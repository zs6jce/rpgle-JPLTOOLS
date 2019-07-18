      * physical limit to XREF objects list : 16Mb / 4 = 4 M objects
      * same for KIDS (one object in KIDS for each page)
      * With a minimum of 5 objects per page (resource+page+outline+stream+streamsize)
      * An average of 8 objects per page give the limit of 512 K pages
      *
      * this test program generates a 20,000 pages PDF file.
      * And AdobeReader9 has difficulties to open it on a quadcode PC.
      * That is to say that a PDF fatter than 2,000 pages is probably the
      * natural limit of the Acrobat reader.
      * With Foxit, no issue.
      *
      *
      *
      *
      *
      /define INFDS
      /define PDF
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
     h copyright('Author is Jean-Paul Lamontre')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     D IfsName         s            512a   varying
     D RC              S             10i 0

    ?d* demo making a pdf
     d CouCou          c                   'The quick brown fox jumps over a -
     d                                      lazy dog. Portez ce vieux Whiskey -
     d                                      blond qui fume.'

     d myProcSet       ds                  likeds(pdfprocset)
     d myResource      ds                  likeds(pdfResource)
     d myResource2     ds                  likeds(pdfResource)
     d myContent       ds                  likeds(pdfContent )
     d myStream        s                   like(pdfstream  )
     d myDraw          s                   like(pdfstream  )
     d myText          s                   like(pdfstream  )
     d Logo            ds                  likeds(pdfImage   )
     d Jpl             ds                  likeds(pdfImage   )
     d bmp             ds                  likeds(pdfImage   )
     d i               s              5i 0
     d Texte           s                   like(pdfstream  )
     d PdfPrinter      ds                  likeds(PdfFont)
     d PdfPrinterB     ds                  likeds(PdfFont)
     d PdfPrinterI     ds                  likeds(PdfFont)
     d PdfPrinterBI    ds                  likeds(PdfFont)

      /free
       //?my pdf objects need to be created as soon as possible
       //?to store childs object number
       //?
       //?this tool is architectured to build one pdf at a time : all pdf objects
       //?are global and unique : they don't need to be named inside procedure.
       //?this makes code cleaned from repeating most pdf objects list in each
       //?procedure call.
       //?
       //?
       //?Prepare the service program to work for me
          PdfInz();



       //?preload the images to be used in the pdf
       message('CPF9898':'preload logo':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');



           jpl    =pdfpreLoadJpeg ('/Home/Lamontre/jpl.jpg');
           logo   =pdfpreLoadJpeg ('/Home/Lamontre/logo.jpg');


       message('CPF9898':'preload bmp':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       bmp  =  pdfpreLoadbmp24('/Home/Lamontre/rgb.bmp'       );
       // le temps de chargement d'un BMP est effectivement très long.
       // Ca mérite une petite investigation. Je me note ça dans un coin
       // de toute façon, le bon choix ce n'est pas BMP c'est JPG.

       //?
       //?destroy if exist then create a file
       //?

       message('CPF9898':'Open the file':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
         ifsname='/Home/Lamontre/Pdf54.pdf';
          PdfNewFile(Ifsname :'Test all PDF directive'  );

       //?prepare foundation objects
       PdfNewRoot();
       PdfNewOutlines();
       PdfNewPages();
       //?prepare the font list to be used in the pdf
       //?load each font
       PdfCourier  =PdfLoadFont1('F1' :pdf_Courier);
       PdfCourierB =PdfLoadFont1('F2' :pdf_Courier:pdf_bold);
       PdfCourierI =PdfLoadFont1('F3' :pdf_Courier:pdf_italic);
       PdfCourierBI=PdfLoadFont1('F4' :pdf_Courier:pdf_bold:pdf_italic);
       PdfHelvet   =PdfLoadFont1('F5' :pdf_Helvet );
       PdfHelvetB  =PdfLoadFont1('F6' :pdf_Helvet :pdf_bold);
       PdfHelvetI  =PdfLoadFont1('F7' :pdf_Helvet :pdf_italic);
       PdfHelvetBI =PdfLoadFont1('F8' :pdf_Helvet :pdf_bold:pdf_italic);
       PdfTimes    =PdfLoadFont1('F9' :pdf_Times  );
       PdfTimesB   =PdfLoadFont1('F10':pdf_Times  :pdf_bold);
       PdfTimesI   =PdfLoadFont1('F11':pdf_Times  :pdf_italic);
       PdfTimesBI  =PdfLoadFont1('F12':pdf_Times  :pdf_bold:pdf_italic);
       PdfSymbol   =PdfLoadFont1('F13':pdf_Symbol);
       PdfZapf     =PdfLoadFont1('F14':pdf_Zapf );
       PdfPrinter  =PdfLoadFont1('F15' :pdf_Helvet : pdf_fixedpitch);
       PdfPrinterB =PdfLoadFont1('F16' :pdf_Helvet :pdf_bold: pdf_fixedpitch);
       PdfPrinterI =PdfLoadFont1('F17' :pdf_Helvet :pdf_italic: pdf_fixedpitch);
       PdfPrinterBI=PdfLoadFont1('F18' :pdf_Helvet
                                 :pdf_bold:pdf_italic: pdf_fixedpitch);

       //?load the images to be used in the pdf
       //  Logo   =pdfLoadJpeg ('/Home/Lamontre/Pictet601.jpg');
       //  jpl    =pdfLoadJpeg ('/Home/Lamontre/jpl.jpg');
               pdfmemLoadbmp24( Logo );
               pdfmemLoadbmp24( jpl  );
               pdfmemLoadbmp24( bmp  );





       //?prepare a procset list
       //?procset is a part of resource. Reusable multiple object
       myProcset=PdfLoadProcset(pdf_procpdf : pdf_procimagec);//?auto-close
       //?make a resouurce : reference the procset to be used in future page
       //?resource is a part of a page. Reusable multiple object
       myResource =PdfNewResource(myProcset);
       //?if any, reference the images to be used in the pdf
       pdfresourceAddImage(myresource :Logo   );
       pdfresourceAddImage(myresource :Jpl    );
       pdfresourceAddImage(myresource :bmp    );

       //?if any, reference the fonts to be used in the pdf
       PdfResourceAddFont( myResource : PdfCourier );
       PdfResourceAddFont( myResource : PdfCourierB );
       PdfResourceAddFont( myResource : PdfCourierI );
       PdfResourceAddFont( myResource : PdfCourierBI );
       PdfResourceAddFont( myResource : PdfHelvet );
       PdfResourceAddFont( myResource : PdfHelvetB );
       PdfResourceAddFont( myResource : PdfHelvetI );
       PdfResourceAddFont( myResource : PdfHelvetBI );
       PdfResourceAddFont( myResource : PdfTimes );
       PdfResourceAddFont( myResource : PdfTimesB );
       PdfResourceAddFont( myResource : PdfTimesI );
       PdfResourceAddFont( myResource : PdfTimesBI );
       PdfResourceAddFont( myResource : PdfSymbol );
       PdfResourceAddFont( myResource : PdfZapf );
       PdfResourceAddFont( myResource : PdfPrinter );
       PdfResourceAddFont( myResource : PdfPrinterB );
       PdfResourceAddFont( myResource : PdfPrinterI  );
       PdfResourceAddFont( myResource : PdfPrinterBI  );

       PdfCloseResource ( myResource);
       //?In this sample, I use only one resource, one procset
       //?perhaps not optimized, but it works.

       message('CPF9898':'Page 1':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 1':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Text, font & size');
       myDraw='';
       myText='';

           myDraw+=PdfDrawImage(Jpl:20:600);
           myDraw+=PdfDrawImage(Jpl:50:400  );
           myDraw+=PdfDrawImage(Jpl:300:000    );
       MyText+=PdfTextOpen();
       //?reset colors
       MyText+=PdfStrmStrokingColorGray(0.5);
       MyText+=PdfStrmFillingColorGray(0);
       MyText+=PdfTextFont(PdfCourier:16);
       MyText+=PdfTextGoTo(0:690);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourier:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierB:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierBI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvet :08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetB:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetBI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimes:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesB:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesBI:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfSymbol:08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfZapf :08);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourier:48);
       MyText+=PdfTextCharSpace(2);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextWordSpace(2);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextCondensed( 50);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextRendering(Pdf_Fill);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextRendering(Pdf_Stroke);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextRendering(Pdf_Fill:Pdf_Stroke);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextClose();
       myText+=PdfDrawImage(Jpl     :20:300);

       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       message('CPF9898':'Page 2':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       PdfNewPage(pdf_A4Portrait:'Page 2':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Logo et translation');
       myDraw='';
       myText='';

       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfDrawImage(Logo    :000:700);
       MyDraw+=PdfDrawImage(Logo    :050:600:0.6);
       MyDraw+=PdfDrawImage(Logo    :100:500:0.5);
       MyDraw+=PdfDrawImage(Logo    :150:400:0.4);
       MyDraw+=PdfDrawImage(Logo    :200:300:0.3);
       MyDraw+=PdfDrawImage(Logo    :250:200:0.2);
       MyDraw+=PdfDrawImage(Logo    :300:100:0.1);
       MyDraw+=PdfDrawImage(Logo    :350:000:0.05);
       MyDraw+=PdfStrmRestoreGraphicState();


       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       message('CPF9898':'Page 3':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       PdfNewPage(pdf_A4Portrait:'Page 3':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Native Drawing');
       //?now it's time to make a stream ie data to show
       mystream='';
       //?a stream is a concatenation of image,
       //?draw & text.
       myDraw='';
       myText='';
       MyDraw+=PdfStrmSaveGraphicState();
       //?be carefull when building stream data :
       //?don't mix draw directive with text directive.
       //?each directive batch has it's own start and end directive.
       //?draw only directives are prefixed PdfDraw
       //?text only directives are prefixed Pdftext
       //?Common    directives are prefixed Pdfstrm
       myDraw+=PdfDrawAddRectangle(0:800:34:10);
       myDraw+=PdfDrawImage(bmp:50:750);
       mydraw+=PdfDrawClosePath(pdf_stroke);
       myDraw+=PdfDrawAddRectangle(32:700:34:18);
       mydraw+=PdfDrawClosePath(pdf_stroke);

       //?Draw a black line segment, using the default line width.
       mydraw+=PdfDrawGoTo(150:250);//?150 250 m
       myDraw+=PdfDrawAddLine(150:350);//?150 350 l
       mydraw+=PdfDrawClosePath(pdf_stroke);
       //?Draw a thicker, dashed line segment.
       //? Set line width to 4 points
       mydraw+=PdfDrawLineWidth(4);
       //?Set dash pattern to 4 units on, 6 units o80
       myDraw+=PdfDrawdashedLine(0:4:6);
       mydraw+=pdfdrawgoto(150:250);
       mydraw+=pdfdrawaddline(400:250);
       mydraw+=PdfDrawClosePath(pdf_stroke);
       //?Reset dash pattern to a solid line
       mydraw+=pdfdrawdashedline();
       //?Reset line width to 1 unit
       mydraw+=PdfDrawLineWidth(1);
       //?Draw a rectangle with a 1-unit red border, filled with light blue.
       //?Red for stroke color
       mydraw+=pdfStrmStrokingcolorrgb(1:0:0);
       //?Light blue for fill color
       mydraw+=pdfStrmFillingcolorrgb(0.5:0.75:1);
       myDraw+=PdfDrawAddRectangle(200:300:50:75);
       // no, finally I prefer a green border
       mydraw+=pdfStrmStrokingcolorrgb(0:1:0);
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       //?Draw a curve filled with gray and with a colored border.
       MyDraw+=PdfStrmStrokingColorRGB(0.5:0.1:0.2);
       MyDraw+=PdfStrmFillingColorGray(0.7);
       MyDraw+=PdfDrawGoTo(300:300);
       MyDraw+=PdfDrawAddBezier(300:400:400:400:400:300);
       MyDraw+=PdfDrawClosePath(pdf_Fill:Pdf_Close:Pdf_Stroke);
       //?move current point to x y page 163
       MyDraw+=PdfDrawGoTo(150:250);
       MyDraw+=PdfDrawAddLine(153:350);
       MyDraw+=PdfDrawAddrectangle(390:490:20:20);
       MyDraw+=PdfDrawAddrectangle(390:740:20:20);
       MyDraw+=PdfDrawAddrectangle(190:490:20:20);
       MyDraw+=PdfDrawAddrectangle(190:740:20:20);
       MyDraw+=PdfDrawAddrectangle(200:500:200:250);
       MyDraw+=PdfDrawGoTo(400:500);
       MyDraw+=PdfDrawAddBezier(400:750:200:500:200:750);
       MyDraw+=PdfDrawCloseSubPath();
       MyDraw+=PdfDrawGoTo(200:500);
       MyDraw+=PdfDrawAddBezier(200:750:400:500:400:750);
       MyDraw+=PdfDrawCloseSubPath();
       MyDraw+=PdfDrawClosePath(pdf_FillEvenOdd:Pdf_Close:Pdf_Stroke);
       // test drawline directives

       mydraw+=PdfDrawLineWidth(10);

       MyDraw+=PdfDrawGoTo(100:460);
       mydraw+=pdfdrawaddline(200:460);
       mydraw+=pdfdrawaddline(100:500);
       mydraw+=PdfStrmStrokingColorCMYK(,1 : ,2 : ,3 : ,4);
       mydraw+=PdfStrmFillingColorCMYK(,4 : ,3 : ,2 : ,1);
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);

       MyDraw+=PdfDrawLineCap(Pdf_LineCapButt);
       MyDraw+=PdfDrawLineJoin(Pdf_JoinMiter           );
       MyDraw+=PdfDrawMiterLimit(2)                     ;
       MyDraw+=PdfDrawGoTo(100:440);
       mydraw+=pdfdrawaddline(300:440);
       mydraw+=pdfdrawaddline(200:480);
       mydraw+=PdfDrawClosePath(pdf_stroke);

       MyDraw+=PdfDrawLineCap(Pdf_LineCapRound);
       MyDraw+=PdfDrawLineJoin(Pdf_JoinRound           );
       MyDraw+=PdfDrawGoTo(100:420);
       mydraw+=pdfdrawaddline(400:420);
       mydraw+=pdfdrawaddline(300:460);
       mydraw+=PdfDrawClosePath(pdf_stroke);

       MyDraw+=PdfDrawLineCap(Pdf_LineCapProjecting);
       MyDraw+=PdfDrawLineJoin(Pdf_JoinBevel           );
       MyDraw+=PdfDrawGoTo(100:400);
       mydraw+=pdfdrawaddline(500:400);
       mydraw+=pdfdrawaddline(400:440);
       mydraw+=PdfDrawClosePath(pdf_stroke);






       MyDraw+=PdfStrmRestoreGraphicState();


       MyText =PdfCanvas( PdfHelvet : 50 : 20 );

       Mytext+=PdfStrmSaveGraphicState();
       myText+=PdftextOpen();
           MyText+=PdfTextFont(PdfHelvet :08);
       myText+=PdftextGoTo(0:800);
       myText+=PdfTextAdd('0:800');
       myText+=PdftextGoTo(150:250);
       myText+=PdfTextAdd('150:250');
       myText+=PdftextGoTo(300:300);
       myText+=PdfTextAdd('300:300');
       myText+=PdftextGoTo(300:400);
       myText+=PdfTextAdd('300:400');
       myText+=PdftextGoTo(400:400);
       myText+=PdfTextAdd('400:400');
       myText+=PdftextGoTo(400:300);
       myText+=PdfTextAdd('400:300');
       myText+=PdftextGoTo(400:500);
       myText+=PdfTextAdd('400:500');
       myText+=PdftextGoTo(400:750);
       myText+=PdfTextAdd('400:750');
       myText+=PdftextGoTo(200:500);
       myText+=PdfTextAdd('200:500');
       myText+=PdftextGoTo(200:750);
       myText+=PdfTextAdd('200:750');

       myText+=PdftextGoTo(100:200);
       myText+=PdfTextAdd('Current font is ' + pdfFontName);
       MyText+=PdfTextnewline();
       myText+=PdfTextAdd('Font size is ' + %char(pdfFontSize));








       myText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();


       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       message('CPF9898':'Page 4':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       PdfNewPage(pdf_A4Portrait:'Page 4':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('scaling');
       //?now it's time to make a stream ie data to show
       mystream='';
       //?a stream is a concatenation of image,
       //?draw & text.
       myDraw='';
       myText='';
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmFillingColorGray(0.7);
       mydraw+=PdfDrawLineWidth(2 );


       MyDraw+=PdfStrmtranslate(100:700);
       // demo strmscale
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(1  :0  :0  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmScale(1,5:1,5    );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mytext+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150 );
       // demo strmskew
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(0  :1  :0  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmSkew (15 :15     );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mydraw+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150);
       // demo strmrotate
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(0  :0  :1  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmrotate(   15     );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mydraw+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150 );
       // demo strmtranslate
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorGray(0         );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmtranslate(50: -50);
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmRestoreGraphicState();
       MyDraw+=PdfStrmRestoreGraphicState();

       // demo strlen
       // avoid PdfStrmSaveGraphicState in MyText : TextGoto, TextMoveTo & TextNewLine don't handle
       MyText+=PdfTextOpen();
       MyText+=PdfTextFont(PdfCourier:10);
       MyText+=PdfStrmStrokingColorGray(0  );
       MyText+=PdfStrmFillingColorGray(0  );
       MyText+=PdfTextGoTo(0:800);
       MyText+=PdfTextadd('Scale - in red ; skew - in green ; '
        + 'rotate - in blue ; translate - in black');
       MyText+=PdfTextGoTo(0:690);
       MyText+=PdfTextAdd('YCurrRow='+%char(PdfTextRow())+', XCurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourier:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       // newline take care of font size. Set font of next line before callinf PdfNewLine
       MyText+=PdfTextFont(PdfCourier:20);
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvet :10);
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();


       MyText+=PdfTextCharSpace( 1  );
       MyText+=PdfTextadd('(charspacing 1   )'+coucou);
       MyText+=PdfTextCharSpace( 0  );  // back to default
       MyText+=PdfTextnewline();

       MyText+=PdfTextWordSpace(  2 );
       MyText+=PdfTextadd('(wordspacing 2)'+coucou);
       MyText+=PdfTextWordSpace(  0 ); // back to default
       MyText+=PdfTextnewline();

       MyText+=PdfTextCondensed( 50 );
       MyText+=PdfTextadd('(Condensed 50%)'+coucou);
       MyText+=PdfTextCondensed( 100);  // back to default
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );





       MyText+=PdfTextFont(PdfHelvetB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();

       texte= '(centered)'+coucou ;
       MyText+=PdfTextMoveTo(   PdfTextCenter( 295 : Texte ) : 0 );
       MyText+=PdfTextadd(Texte              );
       MyText+=PdfTextnewline();

       texte= '(to right)'+coucou ;
       MyText+=PdfTextMoveTo(   PdfTextRight (590 : Texte ) : 0 );
       MyText+=PdfTextadd(Texte              );
       // new line, vertical aligned to previous line
       MyText+=PdfTextNewLine();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextToLeft();



       MyText+=PdfTextFont(PdfTimes:10);
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       //  fixed-pitch helvet : not pretty.
       //  MyText+=PdfTextFont(PdfPrinter:10);
       //  MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       //  MyText+=PdfTextadd(coucou);
       //  MyText+=PdfTextnewline();
       //
       //  MyText+=PdfTextFont(PdfPrinterB:10);
       //  MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       //  MyText+=PdfTextadd(coucou);
       //  MyText+=PdfTextnewline();
       //
       //  MyText+=PdfTextFont(PdfPrinterI:10);
       //  MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       //  MyText+=PdfTextadd(coucou);
       //  MyText+=PdfTextnewline();
       //
       //  MyText+=PdfTextFont(PdfPrinterBI:10);
       //  MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       //  MyText+=PdfTextadd(coucou);
       //  MyText+=PdfTextnewline();









       MyText+=PdfTextClose();



          mystream=mydraw+mytext              ;

       MyContent = PdfLoadContent(myStream);//?auto-close, reusable (usage ? it's a complete page)
          PdfPageContent (myContent );
       PdfClosePage( );


       // target : search the dump by out-of-capacity

       for ever=1 to 100;

       //?add a page to the pdf
       message('CPF9898':'More Pages '+%char(ever)
                                      :'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       PdfNewPage(pdf_A4Portrait:'Page 4':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('scaling');
       //?now it's time to make a stream ie data to show
       mystream='';
       //?a stream is a concatenation of image,
       //?draw & text.
       myDraw='';
       myText='';
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmFillingColorGray(0.7);
       mydraw+=PdfDrawLineWidth(2 );


       MyDraw+=PdfStrmtranslate(100:700);
       // demo strmscale
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(1  :0  :0  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmScale(1,5:1,5    );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mytext+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150 );
       // demo strmskew
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(0  :1  :0  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmSkew (15 :15     );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mydraw+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150);
       // demo strmrotate
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorRGB(0  :0  :1  );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmrotate(   15     );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       Mydraw+=PdfStrmRestoreGraphicState();

       MyDraw+=PdfStrmtranslate(0:-150 );
       // demo strmtranslate
       MyDraw+=PdfStrmSaveGraphicState();
       MyDraw+=PdfStrmStrokingColorGray(0         );
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmtranslate(50: -50);
       myDraw+=PdfDrawAddRectangle(50:50:20 :20 );
       mydraw+=PdfDrawClosePath(pdf_fill:pdf_stroke);
       MyDraw+=PdfStrmRestoreGraphicState();
       MyDraw+=PdfStrmRestoreGraphicState();

       // demo strlen
       // avoid PdfStrmSaveGraphicState in MyText : TextGoto, TextMoveTo & TextNewLine don't handle
       MyText+=PdfTextOpen();
       MyText+=PdfTextFont(PdfCourier:10);
       MyText+=PdfStrmStrokingColorGray(0  );
       MyText+=PdfStrmFillingColorGray(0  );
       MyText+=PdfTextGoTo(0:800);
       MyText+=PdfTextadd('Scale - in red ; skew - in green ; '
        + 'rotate - in blue ; translate - in black');
       MyText+=PdfTextGoTo(0:690);
       MyText+=PdfTextAdd('YCurrRow='+%char(PdfTextRow())+', XCurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourier:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfCourierBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       // newline take care of font size. Set font of next line before callinf PdfNewLine
       MyText+=PdfTextFont(PdfCourier:20);
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvet :10);
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();


       MyText+=PdfTextCharSpace( 1  );
       MyText+=PdfTextadd('(charspacing 1   )'+coucou);
       MyText+=PdfTextCharSpace( 0  );  // back to default
       MyText+=PdfTextnewline();

       MyText+=PdfTextWordSpace(  2 );
       MyText+=PdfTextadd('(wordspacing 2)'+coucou);
       MyText+=PdfTextWordSpace(  0 ); // back to default
       MyText+=PdfTextnewline();

       MyText+=PdfTextCondensed( 50 );
       MyText+=PdfTextadd('(Condensed 50%)'+coucou);
       MyText+=PdfTextCondensed( 100);  // back to default
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );





       MyText+=PdfTextFont(PdfHelvetB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfHelvetBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();

       texte= '(centered)'+coucou ;
       MyText+=PdfTextMoveTo(   PdfTextCenter( 295 : Texte ) : 0 );
       MyText+=PdfTextadd(Texte              );
       MyText+=PdfTextnewline();

       texte= '(to right)'+coucou ;
       MyText+=PdfTextMoveTo(   PdfTextRight (590 : Texte ) : 0 );
       MyText+=PdfTextadd(Texte              );
       // new line, vertical aligned to previous line
       MyText+=PdfTextNewLine();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd('CurrRow='+%char(PdfTextRow())+', CurrCol='
           +%char(PdfTextCol()) );
       MyText+=PdfTextnewline();
       MyText+=PdfTextToLeft();



       MyText+=PdfTextFont(PdfTimes:10);
       MyText+=PdfTextadd(pdffontname() + %char(pdffontsize));
       MyText+=PdfTextnewline();
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesB:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextFont(PdfTimesBI:10);
       MyText+=PdfTextAdd(%char(PdfTextStrLen(coucou))+':');
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextClose();



          mystream=mydraw+mytext              ;

       MyContent = PdfLoadContent(myStream);//?auto-close, reusable (usage ? it's a complete page)
          PdfPageContent (myContent );
       PdfClosePage( );

       endfor;

       for ever=101 to 20000;

       //?add a page to the pdf
       message('CPF9898':'More Pages '+%char(ever)
                                      :'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       PdfNewPage(pdf_A4Portrait:'Page 4':0:0:10);
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('scaling');
       //?now it's time to make a stream ie data to show
       mystream='';
       //?a stream is a concatenation of image,
       //?draw & text.
       myDraw='';
       myText='';
       // avoid PdfStrmSaveGraphicState in MyText : TextGoto, TextMoveTo & TextNewLine don't handle
       MyText+=PdfTextOpen();
       MyText+=PdfTextFont(PdfCourier:10);
       MyText+=PdfStrmStrokingColorGray(0  );
       MyText+=PdfStrmFillingColorGray(0  );
       MyText+=PdfTextGoTo(0:800);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextClose();



          mystream=mydraw+mytext              ;

       MyContent = PdfLoadContent(myStream);//?auto-close, reusable (usage ? it's a complete page)
          PdfPageContent (myContent );
       PdfClosePage( );

       endfor;

       message('CPF9898':'Close the file':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');

       //?close the pdf
       PdfCloseOutlines();
       PdfClosePages();
       PdfCloseRoot(Pdf_Outlines);
       PdfCloseFile();



       *inlr = *on;
      /end-free

      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

    ? *=---------------------------------------------------------------=*
    ?p*                b
    ? */free
    ? * begsr *pssr;
    ? * dump;
    ? * endsr;
    ? */end-free
    ?P*                 e
    ? *=---------------------------------------------------------------=*
