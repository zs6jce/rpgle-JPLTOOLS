      /define INFDS
      /define PDF
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     D IfsName         s            512a   varying
     D                                     inz('/home/lamontre/FirstPdf.pdf')
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




      /free
       //?my pdf objects need to be created as soon as possible
       //?to store childs object number
       //?
       //?this tool is architectured to build one pdf at a time : all pdf objects
       //?are global and unique : they don't need to be named inside procedure.
       //?this makes code cleaned from repeating most pdf objects list in each
       //?procedure call.
       //?
       //?destroy if exist then create a file
       //?
       PdfNewFile(Ifsname);
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






       //?prepare a procset list
       //?procset is a part of resource. Reusable multiple object
       myProcset=PdfLoadProcset(pdf_procpdf : pdf_procimagec);//?auto-close
       //?make a resouurce : reference the procset to be used in future page
       //?resource is a part of a page. Reusable multiple object
       myResource =PdfNewResource(myProcset);




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

       PdfCloseResource ( myResource);
       //?In this sample, I use only one resource, one procset
       //?perhaps not optimized, but it works.

       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 1');
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 1');
       //?now it's time to make a stream ie data to show
       mystream='';
       //?a stream is a concatenation of image,
       //?draw & text.
       myDraw='';
       myText='';
       //?be carefull when building stream data :
       //?don't mix draw directive with text directive.
       //?each directive batch has it's own start and end directive.
       //?draw only directives are prefixed PdfDraw
       //?text only directives are prefixed Pdftext
       //?Common    directives are prefixed Pdfstrm
       myDraw+=PdfDrawAddRectangle(0:800:34:10);
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

       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close, reusable (usage ? it's a complete page)
          PdfPageContent (myContent );
       PdfClosePage( );
       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 2');
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 2');
       myDraw='';
       myText='';


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
       MyText+=PdfTextCondensed(50);
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


       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );
       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 3');
       PdfPageResource(myResource);
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 3');
       myDraw='';
       myText='';

       MyText+=PdfStrmSaveGraphicState();
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(20:800);
       //?Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit
       MyText+=PdfStrmScale(0.5:0.5);
       MyText+=PdfTextFont(PdfCourier:30);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextadd('Escape chars are \\, \) & \(');
       //?Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle counterclockwise.
       //?rotation -15∞
       myText+=PdfStrmRotate(330);
       MyText+=PdfTextFont(PdfCourier:30);
       MyText+=PdfTextGoTo(0:0 );
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       //?Skew is specified by : 1 tana tanﬂ 1 0 0 cm ; a = angle x ﬂ = angle y
       //?skew 0∞, -15∞
       myText+=PdfStrmSkew(0:345);
       MyText+=PdfTextGoTo(170:-20);
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextadd(coucou);
       MyText+=PdfTextnewline();
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();

       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );
       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 4');

       PdfPageResource(myResource );
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 4');
       myDraw='';
       myText='';


       MyText+=PdfStrmSaveGraphicState();



       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(20:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('1) at 20.400');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();
       //?Translation is obtained by : 1 0 0 1 Tx Ty cm
       MyText+=PdfStrmSaveGraphicState();
       MyText+=PdfStrmTranslate(50:50);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('2- translated 50.50');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();
       //?Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit
       MyText+=PdfStrmSaveGraphicState();
       MyText+=PdfStrmScale(1.5:0.5);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('3- scaled 150%,50% + goto 000.400');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();
       //?Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle counterclockwise.
       //?rotation -15∞
       MyText+=PdfStrmSaveGraphicState();
       myText+=PdfStrmRotate(330);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('4- rotated -15∞ + goto 020.400');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();
       //?Skew is specified by : 1 tana tanﬂ 1 0 0 cm ; a = angle x ﬂ = angle y
       //?skew 0∞, -15∞
       MyText+=PdfStrmSaveGraphicState();
       myText+=PdfStrmSkew(15:15 );
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('5- Skew 15∞&-15∞ + goto 020.400');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();



       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 5');
       PdfPageResource(myResource );
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 5');
       myDraw='';
       myText='';


       MyText+=PdfStrmSaveGraphicState();



       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(20:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('1- at 0.400');
       MyText+=PdfTextClose();

       //?Translation is obtained by : 1 0 0 1 Tx Ty cm

       MyText+=PdfStrmTranslate(50:50);
       myDraw+=PdfDrawgoto   (100:500);
       myDraw+=PdfDrawAddLine(200:500);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('2- translated 50.50');
       MyText+=PdfTextClose();

       //?Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit

       MyText+=PdfStrmScale(1.5:0.5);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('3- scaled 150%,50% + goto 000.400');
       MyText+=PdfTextClose();

       //?Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle counterclockwise.
       //?rotation -15∞

       myText+=PdfStrmRotate(330);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('4- rotated -15∞ + goto 020.400');
       MyText+=PdfTextClose();

       //?Skew is specified by : 1 tana tanﬂ 1 0 0 cm ; a = angle x ﬂ = angle y
       //?skew 0∞, -15∞

       myText+=PdfStrmSkew(15:15 );
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('5- Skew 15∞&-15∞ + goto 020.400');
       MyText+=PdfTextClose();
       MyText+=PdfStrmRestoreGraphicState();



       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       PdfNewPage(pdf_A4Portrait:'Page 6');
       PdfPageResource(myResource );
       //?add outline : a line in the bookmark list
       PdfNewOutline('Page 6');
       myDraw='';
       myText='';

       // initial state

       MyText+=PdfStrmSaveGraphicState();
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(20:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('1- at 0.400');
       MyText+=PdfTextClose();
       //?Skew is specified by : 1 tana tanﬂ 1 0 0 cm ; a = angle x ﬂ = angle y
       //?skew 0∞, -15∞

       myText+=PdfStrmSkew(15:15 );
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('2- Skew 15∞&-15∞ + goto 020.400');
       MyText+=PdfTextClose();
       //?Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle counterclockwise.
       //?rotation -15∞

       myText+=PdfStrmRotate(330);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('3- rotated -15∞ + goto 020.400');
       MyText+=PdfTextClose();
       //?Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit

       MyText+=PdfStrmScale(1.5:0.5);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('4- scaled 150%,50% + goto 000.400');
       MyText+=PdfTextClose();

       //?Translation is obtained by : 1 0 0 1 Tx Ty cm

       MyText+=PdfStrmTranslate(50:50);
       myDraw+=PdfDrawgoto   (100:500);
       myDraw+=PdfDrawAddLine(200:500);
       MyText+=PdfDrawAddrectangle(020:400:400:100);
       MyText+=PdfDrawClosePath(pdf_stroke);
       MyText+=PdfTextOpen();
       MyText+=PdfTextGoTo(020:400);
       MyText+=PdfTextFont(PdfCourier:60);
       MyText+=PdfTextadd('5- translated 50.50');
       MyText+=PdfTextClose();


       MyText+=PdfStrmRestoreGraphicState();




       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?close the pdf
       PdfCloseOutlines();
       PdfClosePages();
       PdfCloseRoot( );
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
