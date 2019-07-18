    ? *
    ? *
    ? *
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

     d PdfAdobePI      ds                  likeds(PdfFont)
     d PdfArialMS      ds                  likeds(PdfFont)

     d a16             s             16a
     d a32             s             32a
     d a48             s             48a
     d c16             s             16c   ccsid(1200)

     d do_a32          pr            32a
     d   from                         2a   const
     d do_a48          pr            48a
     d   from                         3a   const
     d do_c16          pr            16c
     d   from                         1c   const


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
       pdfinz();
       *inlr = *on;



       //?preload the images to be used in the pdf
       message('CPF9898':'preload logo':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');

       Jpl =pdfpreloadjpeg ('/Home/Lamontre/jpl.jpg');
       Logo =pdfpreloadjpeg ('/Home/Lamontre/logo.jpg');


       message('CPF9898':'preload bmp':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
       bmp = pdfpreloadbmp24('/Home/Lamontre/rgb.bmp' );

       //?le temps de chargement d'un BMP est effectivement très long.
       //?Ca mérite une petite investigation. Je me note ça dans un coin
       //?de toute façon, le bon choix ce n'est pas BMP c'est JPG.

       //?
       //?destroy if exist then create a file
       //?
B01    For i = 1 to 4;
          message('CPF9898':'Open the file':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
B02       Select;
X02          When i = 1;
                IfsName='/Home/Lamontre/Pdf5a.pdf';
                pdfnewfile(IfsName: 'Test all PDF directive'
                   : pdf_allow_reset
                   //?  + Pdf_Allow_hqprint
                   + pdf_allow_assemble
                   //?  + Pdf_Allow_extract
                   + pdf_allow_fill
                   + pdf_allow_annote
                   //?  + Pdf_Allow_copy
                   + pdf_allow_modify
                   //?  + Pdf_Allow_print
                   : 'user' : 'owner'
                   //?: PdfOPen_ObjAut + PdfOpen_Unlink
                   //?+ S_IRWXU + S_IRWXG + S_IRWXO);
                   //?:  S_IRWXU + S_IRWXG + S_IRWXO);
                   //?: S_IRWXU );
                   : 0 );
X02          When i = 2;
                IfsName='/Home/Lamontre/Pdf5b.pdf';
                pdfnewfile(IfsName: 'Test all PDF directive'
                   : pdf_allow_reset + pdf_allow_extract
                   : '' : 'owner');
X02          When i = 3;
                IfsName='/Home/Lamontre/Pdf5c.pdf';
                pdfnewfile(IfsName: 'Test all PDF directive'
                   : pdf_allow_reset + pdf_allow_extract
                   : '' : '' );
X02          When i = 4;
                IfsName='/Home/Lamontre/Pdf5d.pdf';
                pdfnewfile(IfsName :'Test all PDF directive' );
E02       Endsl;
          //?prepare foundation objects
          pdfnewroot();
          pdfnewoutlines();
          pdfnewpages();
          //?prepare the font list to be used in the pdf
          //?load each font
          pdfcourier =pdfloadfont1('F1' :pdf_courier);
          pdfcourierb =pdfloadfont1('F2' :pdf_courier:pdf_bold);
          pdfcourieri =pdfloadfont1('F3' :pdf_courier:pdf_italic);
          pdfcourierbi=pdfloadfont1('F4' :pdf_courier:pdf_bold:pdf_italic);
          pdfhelvet =pdfloadfont1('F5' :pdf_helvet );
          pdfhelvetb =pdfloadfont1('F6' :pdf_helvet :pdf_bold);
          pdfhelveti =pdfloadfont1('F7' :pdf_helvet :pdf_italic);
          pdfhelvetbi =pdfloadfont1('F8' :pdf_helvet :pdf_bold:pdf_italic);
          pdftimes =pdfloadfont1('F9' :pdf_times );
          pdftimesb =pdfloadfont1('F10':pdf_times :pdf_bold);
          pdftimesi =pdfloadfont1('F11':pdf_times :pdf_italic);
          pdftimesbi =pdfloadfont1('F12':pdf_times :pdf_bold:pdf_italic);
          pdfsymbol =pdfloadfont1('F13':pdf_symbol);
          pdfzapf =pdfloadfont1('F14':pdf_zapf );
          PdfPrinter =pdfloadfont1('F15':pdf_helvet : pdf_fixedpitch);
          PdfPrinterB =pdfloadfont1('F16':pdf_helvet:pdf_bold: pdf_fixedpitch);
          PdfPrinterI =pdfloadfont1('F17':pdf_helvet:pdf_italic:pdf_fixedpitch);
          PdfPrinterBI=pdfloadfont1('F18' :pdf_helvet
             :pdf_bold:pdf_italic: pdf_fixedpitch);

          PdfAdobePI =pdfloadfont2('F21':pdf_adobepistd: pdf_unijis);
          PdfArialMS =pdfloadfont2('F22':pdf_arialunicodems: pdf_uniks);

          //?load the images to be used in the pdf
          //?pdfmemLoadJpeg and pdfmemLoadbmp24 are equal while PdfPreLoadxxx
          //?   has actually preloaded the picture.
          //?but if PDF is not crypted (IE with no password ... ) and picture size is > 64K,
          //?   then they work differently.

          pdfmemloadjpeg ( Logo );
          pdfmemloadjpeg ( Jpl );
          pdfmemloadbmp24( bmp );

          //?prepare a procset list
          //?procset is a part of resource. Reusable multiple object
          myProcSet=pdfloadprocset(pdf_procpdf : pdf_procimagec);   //?auto-close
          //?make a resouurce : reference the procset to be used in future page
          //?resource is a part of a page. Reusable multiple object
          myResource =pdfnewresource(myProcSet);
          //?if any, reference the images to be used in the pdf
          pdfresourceaddimage(myResource :Logo );
          pdfresourceaddimage(myResource :Jpl );
          pdfresourceaddimage(myResource :bmp );

          //?if any, reference the fonts to be used in the pdf
          pdfresourceaddfont( myResource : pdfcourier );
          pdfresourceaddfont( myResource : pdfcourierb );
          pdfresourceaddfont( myResource : pdfcourieri );
          pdfresourceaddfont( myResource : pdfcourierbi );
          pdfresourceaddfont( myResource : pdfhelvet );
          pdfresourceaddfont( myResource : pdfhelvetb );
          pdfresourceaddfont( myResource : pdfhelveti );
          pdfresourceaddfont( myResource : pdfhelvetbi );
          pdfresourceaddfont( myResource : pdftimes );
          pdfresourceaddfont( myResource : pdftimesb );
          pdfresourceaddfont( myResource : pdftimesi );
          pdfresourceaddfont( myResource : pdftimesbi );
          pdfresourceaddfont( myResource : pdfsymbol );
          pdfresourceaddfont( myResource : pdfzapf );
          pdfresourceaddfont( myResource : PdfPrinter );
          pdfresourceaddfont( myResource : PdfPrinterB );
          pdfresourceaddfont( myResource : PdfPrinterI );
          pdfresourceaddfont( myResource : PdfPrinterBI );
          pdfresourceaddfont( myResource : PdfAdobePI );
          pdfresourceaddfont( myResource : PdfArialMS );

          pdfcloseresource ( myResource);
          //?In this sample, I use only one resource, one procset
          //?perhaps not optimized, but it works.

          message('CPF9898':'Page 1':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
          //?add a page to the pdf
          pdfnewpage(pdf_a4portrait:'Page 1':0:0:10);
          pdfpageresource(myResource);
          //?add outline : a line in the bookmark list
          pdfnewoutline('Text, font & size');
          myDraw='';
          myText='';

          myDraw+=pdfdrawimage(Jpl:20:600);
          myDraw+=pdfdrawimage(Jpl:50:400 );
          myDraw+=pdfdrawimage(Jpl:300:000 );
          myText+=pdftextopen();
          //?reset colors
          myText+=pdfstrmstrokingcolorgray(0.5);
          myText+=pdfstrmfillingcolorgray(0);
          myText+=pdftextfont(pdfcourier:16);
          myText+=pdftextgoto(0:690);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourier:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourierb:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourieri:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourierbi:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelvet :08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelvetb:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelveti:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelvetbi:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimes:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesb:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesi:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesbi:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfsymbol:08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfzapf :08);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourier:48);
          myText+=pdftextcharspace(2);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextwordspace(2);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextcondensed( 50);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextrendering(pdf_fill);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextrendering(pdf_stroke);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextrendering(pdf_fill:pdf_stroke);
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextclose();
          myText+=pdfdrawimage(Jpl :20:300);

          myStream=myDraw+myText;
          myContent = pdfloadcontent(myStream);   //?auto-close
          pdfpagecontent (myContent );
          pdfclosepage( );

          //?add a page to the pdf
          message('CPF9898':'Page 2':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
          pdfnewpage(pdf_a4portrait:'Page 2':0:0:10);
          pdfpageresource(myResource);
          //?add outline : a line in the bookmark list
          pdfnewoutline('Logo et translation');
          myDraw='';
          myText='';

          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfdrawimage(Logo :000:700);
          myDraw+=pdfdrawimage(Logo :050:600:0.6);
          myDraw+=pdfdrawimage(Logo :100:500:0.5);
          myDraw+=pdfdrawimage(Logo :150:400:0.4);
          myDraw+=pdfdrawimage(Logo :200:300:0.3);
          myDraw+=pdfdrawimage(Logo :250:200:0.2);
          myDraw+=pdfdrawimage(Logo :300:100:0.1);
          myDraw+=pdfdrawimage(Logo :350:000:0.05);
          myDraw+=pdfstrmrestoregraphicstate();


          myStream=myDraw+myText;
          myContent = pdfloadcontent(myStream);   //?auto-close
          pdfpagecontent (myContent );
          pdfclosepage( );

          //?add a page to the pdf
          message('CPF9898':'Page 3':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
          pdfnewpage(pdf_a4portrait:'Page 3':0:0:10);
          pdfpageresource(myResource);
          //?add outline : a line in the bookmark list
          pdfnewoutline('Native Drawing');
          //?now it's time to make a stream ie data to show
          myStream='';
          //?a stream is a concatenation of image,
          //?draw & text.
          myDraw='';
          myText='';
          myDraw+=pdfstrmsavegraphicstate();
          //?be carefull when building stream data :
          //?don't mix draw directive with text directive.
          //?each directive batch has it's own start and end directive.
          //?draw only directives are prefixed PdfDraw
          //?text only directives are prefixed Pdftext
          //?Common    directives are prefixed Pdfstrm
          myDraw+=pdfdrawaddrectangle(0:800:34:10);
          myDraw+=pdfdrawimage(bmp:50:750);
          myDraw+=pdfdrawclosepath(pdf_stroke);
          myDraw+=pdfdrawaddrectangle(32:700:34:18);
          myDraw+=pdfdrawclosepath(pdf_stroke);

          //?Draw a black line segment, using the default line width.
          myDraw+=pdfdrawgoto(150:250);   //?150 250 m
          myDraw+=pdfdrawaddline(150:350);   //?150 350 l
          myDraw+=pdfdrawclosepath(pdf_stroke);
          //?Draw a thicker, dashed line segment.
          //? Set line width to 4 points
          myDraw+=pdfdrawlinewidth(4);
          //?Set dash pattern to 4 units on, 6 units o80
          myDraw+=pdfdrawdashedline(0:4:6);
          myDraw+=pdfdrawgoto(150:250);
          myDraw+=pdfdrawaddline(400:250);
          myDraw+=pdfdrawclosepath(pdf_stroke);
          //?Reset dash pattern to a solid line
          myDraw+=pdfdrawdashedline();
          //?Reset line width to 1 unit
          myDraw+=pdfdrawlinewidth(1);
          //?Draw a rectangle with a 1-unit red border, filled with light blue.
          //?Red for stroke color
          myDraw+=pdfstrmstrokingcolorrgb(1:0:0);
          //?Light blue for fill color
          myDraw+=pdfstrmfillingcolorrgb(0.5:0.75:1);
          myDraw+=pdfdrawaddrectangle(200:300:50:75);
          //?no, finally I prefer a green border
          myDraw+=pdfstrmstrokingcolorrgb(0:1:0);
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          //?Draw a curve filled with gray and with a colored border.
          myDraw+=pdfstrmstrokingcolorrgb(0.5:0.1:0.2);
          myDraw+=pdfstrmfillingcolorgray(0.7);
          myDraw+=pdfdrawgoto(300:300);
          myDraw+=pdfdrawaddbezier(300:400:400:400:400:300);
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_close:pdf_stroke);
          //?move current point to x y page 163
          myDraw+=pdfdrawgoto(150:250);
          myDraw+=pdfdrawaddline(153:350);
          myDraw+=pdfdrawaddrectangle(390:490:20:20);
          myDraw+=pdfdrawaddrectangle(390:740:20:20);
          myDraw+=pdfdrawaddrectangle(190:490:20:20);
          myDraw+=pdfdrawaddrectangle(190:740:20:20);
          myDraw+=pdfdrawaddrectangle(200:500:200:250);
          myDraw+=pdfdrawgoto(400:500);
          myDraw+=pdfdrawaddbezier(400:750:200:500:200:750);
          myDraw+=pdfdrawclosesubpath();
          myDraw+=pdfdrawgoto(200:500);
          myDraw+=pdfdrawaddbezier(200:750:400:500:400:750);
          myDraw+=pdfdrawclosesubpath();
          myDraw+=pdfdrawclosepath(pdf_fillevenodd:pdf_close:pdf_stroke);
          //?test drawline directives

          myDraw+=pdfdrawlinewidth(10);

          myDraw+=pdfdrawgoto(100:460);
          myDraw+=pdfdrawaddline(200:460);
          myDraw+=pdfdrawaddline(100:500);
          myDraw+=pdfstrmstrokingcolorcmyk(,1 : ,2 : ,3 : ,4);
          myDraw+=pdfstrmfillingcolorcmyk(,4 : ,3 : ,2 : ,1);
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);

          myDraw+=pdfdrawlinecap(pdf_linecapbutt);
          myDraw+=pdfdrawlinejoin(pdf_joinmiter );
          myDraw+=pdfdrawmiterlimit(2) ;
          myDraw+=pdfdrawgoto(100:440);
          myDraw+=pdfdrawaddline(300:440);
          myDraw+=pdfdrawaddline(200:480);
          myDraw+=pdfdrawclosepath(pdf_stroke);

          myDraw+=pdfdrawlinecap(pdf_linecapround);
          myDraw+=pdfdrawlinejoin(pdf_joinround );
          myDraw+=pdfdrawgoto(100:420);
          myDraw+=pdfdrawaddline(400:420);
          myDraw+=pdfdrawaddline(300:460);
          myDraw+=pdfdrawclosepath(pdf_stroke);

          myDraw+=pdfdrawlinecap(pdf_linecapprojecting);
          myDraw+=pdfdrawlinejoin(pdf_joinbevel );
          myDraw+=pdfdrawgoto(100:400);
          myDraw+=pdfdrawaddline(500:400);
          myDraw+=pdfdrawaddline(400:440);
          myDraw+=pdfdrawclosepath(pdf_stroke);






          myDraw+=pdfstrmrestoregraphicstate();


          myText =pdfcanvas( pdfhelvet : 50 : 20 );

          myText+=pdfstrmsavegraphicstate();
          myText+=pdftextopen();
          myText+=pdftextfont(pdfhelvet :08);
          myText+=pdftextgoto(0:800);
          myText+=pdftextadd('0:800');
          myText+=pdftextgoto(150:250);
          myText+=pdftextadd('150:250');
          myText+=pdftextgoto(300:300);
          myText+=pdftextadd('300:300');
          myText+=pdftextgoto(300:400);
          myText+=pdftextadd('300:400');
          myText+=pdftextgoto(400:400);
          myText+=pdftextadd('400:400');
          myText+=pdftextgoto(400:300);
          myText+=pdftextadd('400:300');
          myText+=pdftextgoto(400:500);
          myText+=pdftextadd('400:500');
          myText+=pdftextgoto(400:750);
          myText+=pdftextadd('400:750');
          myText+=pdftextgoto(200:500);
          myText+=pdftextadd('200:500');
          myText+=pdftextgoto(200:750);
          myText+=pdftextadd('200:750');

          myText+=pdftextgoto(100:200);
          myText+=pdftextadd('Current font is ' + pdffontname);
          myText+=pdftextnewline();
          myText+=pdftextadd('Font size is ' + %Char(pdffontsize));








          myText+=pdftextclose();
          myText+=pdfstrmrestoregraphicstate();


          myStream=myDraw+myText;
          myContent = pdfloadcontent(myStream);   //?auto-close
          pdfpagecontent (myContent );
          pdfclosepage( );

          //?add a page to the pdf
          message('CPF9898':'Page 4':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
          pdfnewpage(pdf_a4portrait:'Page 4':0:0:10);
          pdfpageresource(myResource);
          //?add outline : a line in the bookmark list
          pdfnewoutline('scaling');
          //?now it's time to make a stream ie data to show
          myStream='';
          //?a stream is a concatenation of image,
          //?draw & text.
          myDraw='';
          myText='';
          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfstrmfillingcolorgray(0.7);
          myDraw+=pdfdrawlinewidth(2 );


          myDraw+=pdfstrmtranslate(100:700);
          //?demo strmscale
          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfstrmstrokingcolorrgb(1 :0 :0 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmscale(1,5:1,5 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myText+=pdfstrmrestoregraphicstate();

          myDraw+=pdfstrmtranslate(0:-150 );
          //?demo strmskew
          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfstrmstrokingcolorrgb(0 :1 :0 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmskew (15 :15 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmrestoregraphicstate();

          myDraw+=pdfstrmtranslate(0:-150);
          //?demo strmrotate
          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfstrmstrokingcolorrgb(0 :0 :1 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmrotate( 15 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmrestoregraphicstate();

          myDraw+=pdfstrmtranslate(0:-150 );
          //?demo strmtranslate
          myDraw+=pdfstrmsavegraphicstate();
          myDraw+=pdfstrmstrokingcolorgray(0 );
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmtranslate(50: -50);
          myDraw+=pdfdrawaddrectangle(50:50:20 :20 );
          myDraw+=pdfdrawclosepath(pdf_fill:pdf_stroke);
          myDraw+=pdfstrmrestoregraphicstate();
          myDraw+=pdfstrmrestoregraphicstate();

          //?demo strlen
       //?avoid PdfStrmSaveGraphicState in MyText : TextGoto, TextMoveTo & TextNewLine don't handle
          myText+=pdftextopen();
          myText+=pdftextfont(pdfcourier:10);
          myText+=pdfstrmstrokingcolorgray(0 );
          myText+=pdfstrmfillingcolorgray(0 );
          myText+=pdftextgoto(0:800);
          myText+=pdftextadd('Scale - in red ; skew - in green ; '
             + 'rotate - in blue ; translate - in black');
          myText+=pdftextgoto(0:690);
          myText+=pdftextadd('YCurrRow='+%Char(pdftextrow())+', XCurrCol='
             +%Char(pdftextcol()) );
          myText+=pdftextadd(pdffontname() + %Char(pdffontsize));
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourier:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourierb:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourieri:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfcourierbi:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          //?newline take care of font size. Set font of next line before callinf PdfNewLine
          myText+=pdftextfont(pdfcourier:20);
          myText+=pdftextnewline();
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelvet :10);
          myText+=pdftextadd(pdffontname() + %Char(pdffontsize));
          myText+=pdftextnewline();
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();


          myText+=pdftextcharspace( 1 );
          myText+=pdftextadd('(charspacing 1   )'+CouCou);
          myText+=pdftextcharspace( 0 );   //?back to default
          myText+=pdftextnewline();

          myText+=pdftextwordspace( 2 );
          myText+=pdftextadd('(wordspacing 2)'+CouCou);
          myText+=pdftextwordspace( 0 );   //?back to default
          myText+=pdftextnewline();

          myText+=pdftextcondensed( 50 );
          myText+=pdftextadd('(Condensed 50%)'+CouCou);
          myText+=pdftextcondensed( 100);   //?back to default
          myText+=pdftextnewline();
          myText+=pdftextadd('CurrRow='+%Char(pdftextrow())+', CurrCol='
             +%Char(pdftextcol()) );





          myText+=pdftextfont(pdfhelvetb:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelveti:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdfhelvetbi:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();

          Texte= '(centered)'+CouCou ;
          myText+=pdftextmoveto( pdftextcenter( 295 : Texte ) : 0 );
          myText+=pdftextadd(Texte );
          myText+=pdftextnewline();

          Texte= '(to right)'+CouCou ;
          myText+=pdftextmoveto( pdftextright (590 : Texte ) : 0 );
          myText+=pdftextadd(Texte );
          //?new line, vertical aligned to previous line
          myText+=pdftextnewline();
          myText+=pdftextadd('CurrRow='+%Char(pdftextrow())+', CurrCol='
             +%Char(pdftextcol()) );
          myText+=pdftextnewline();
          myText+=pdftextadd('CurrRow='+%Char(pdftextrow())+', CurrCol='
             +%Char(pdftextcol()) );
          myText+=pdftextnewline();
          myText+=pdftextadd('CurrRow='+%Char(pdftextrow())+', CurrCol='
             +%Char(pdftextcol()) );
          myText+=pdftextnewline();
          myText+=pdftexttoleft();



          myText+=pdftextfont(pdftimes:10);
          myText+=pdftextadd(pdffontname() + %Char(pdffontsize));
          myText+=pdftextnewline();
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesb:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesi:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          myText+=pdftextfont(pdftimesbi:10);
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(CouCou)))+':');
          myText+=pdftextadd(CouCou);
          myText+=pdftextnewline();
          //? fixed-pitch helvet : not pretty.
          //? MyText+=PdfTextFont(PdfPrinter:10);
          //? MyText+=PdfTextAdd(%char(%int(PdfTextStrLen(coucou)))+':');
          //? MyText+=PdfTextadd(coucou);
          //? MyText+=PdfTextnewline();
          //?
          //? MyText+=PdfTextFont(PdfPrinterB:10);
          //? MyText+=PdfTextAdd(%char(%int(PdfTextStrLen(coucou)))+':');
          //? MyText+=PdfTextadd(coucou);
          //? MyText+=PdfTextnewline();
          //?
          //? MyText+=PdfTextFont(PdfPrinterI:10);
          //? MyText+=PdfTextAdd(%char(%int(PdfTextStrLen(coucou)))+':');
          //? MyText+=PdfTextadd(coucou);
          //? MyText+=PdfTextnewline();
          //?
          //? MyText+=PdfTextFont(PdfPrinterBI:10);
          //? MyText+=PdfTextAdd(%char(%int(PdfTextStrLen(coucou)))+':');
          //? MyText+=PdfTextadd(coucou);
          //? MyText+=PdfTextnewline();









          myText+=pdftextclose();


          myStream=myDraw+myText;
          myContent = pdfloadcontent(myStream);   //?auto-close
          pdfpagecontent (myContent );
          pdfclosepage( );

          //?add a page to the pdf
          message('CPF9898':'Page 5':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');
          pdfnewpage(pdf_a4portrait:'Page 4':0:0:10);
          pdfpageresource(myResource);
          //?add outline : a line in the bookmark list
          pdfnewoutline('Unicode');
          //?now it's time to make a stream ie data to show
          myStream='';
          //?a stream is a concatenation of image,
          //?draw & text.
          myDraw='';
          myText='';

          myText+=pdftextopen();
          myText+=pdftextgoto(0:800);
          myText+=pdftextfont(PdfHelvet:15);
          myText+=pdftextadd('ebcdic/AdobePiStd/UniJIS');
          myText+=pdftextnewline();
          myText+=pdftextfont(PdfAdobePI:15);
          myText+=pdfstrmstrokingcolorgray(0 );
          myText+=pdfstrmfillingcolorgray(0 );
          Exsr testufont;

          myText+=pdftextgoto(300:800);
          myText+=pdftextfont(PdfHelvet:15);
          myText+=pdftextadd('ebcdic/ArialMS/UniKS');
          myText+=pdftextnewline();
          myText+=pdftextfont(PdfArialMS:15);
          myText+=pdfstrmstrokingcolorgray(0 );
          myText+=pdfstrmfillingcolorgray(0 );
          Exsr testufont;

          myText+=pdftextclose();

          myStream=myDraw+myText ;

       myContent = pdfloadcontent(myStream);//?auto-close, reusable (usage ? it's a complete page)
          pdfpagecontent (myContent );
          pdfclosepage( );


         message('CPF9898':'Close the file':'*LIBL':'QCPFMSG':'*STATUS':'*EXT');

          //?close the pdf
          pdfcloseoutlines();
          pdfclosepages();
          pdfcloseroot(pdf_outlines);
          pdfclosefile();

E01    Endfor;   //?4 files

B01    Begsr testufont;


          myText+=pdftextadd(' !"#$%&''()*+,-./');
          myText+=pdftextnewline();
          myText+=pdftextadd('0123456789:;<=>?');
          myText+=pdftextnewline();
          myText+=pdftextadd('@ABCDEFGHIJKLMNO');
          myText+=pdftextnewline();
          myText+=pdftextadd('PQRSTUVWXYZ[\]^_');
          myText+=pdftextnewline();
          myText+=pdftextadd('`abcdefghijklmno');
          myText+=pdftextnewline();
          myText+=pdftextadd('pqrstuvwxyz{|}~ ');
          myText+=pdftextnewline();
          myText+=pdftextadd('                ');
          myText+=pdftextnewline();
          myText+=pdftextadd('                ');
          myText+=pdftextnewline();
          myText+=pdftextadd(' ¡¢£¤¥¦§¨©ª«¬­®¯');
          myText+=pdftextnewline();
          myText+=pdftextadd('°±²³´µ¶·¸¹º»¼½¾¿');
          myText+=pdftextnewline();
          myText+=pdftextadd('ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ');
          myText+=pdftextnewline();
          myText+=pdftextadd('ÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß');
          myText+=pdftextnewline();
          myText+=pdftextadd('àáâãäåæçèéêëìíîï');
          myText+=pdftextnewline();
          a16 = 'ðñòóôõö÷øùúûüýþÿ' ;
          myText+=pdftextadd(%Char(%Int(pdftextstrlen(a16 ) ))+':');
          myText+=pdftextnewline();
          myText+=pdftextadd(a16 );
          myText+=pdftextnewline();
          myText+=pdftextnewline();
          myText+=pdftextadd('UTF16');
          myText+=pdftextnewline();
          c16 = do_c16(u'0020') ;
          myText+=pdftextadd(%Char(%Int(pdftextstrlenu16(c16 ) ))+':');
          myText+=pdftextnewline();
          myText+=pdftextaddu16(c16 );
          myText+=pdftextnewline();
          myText+=pdftextaddu16(do_c16(u'0100'));
          myText+=pdftextnewline();
          myText+=pdftextaddu16(do_c16(u'0390'));
          myText+=pdftextnewline();
          myText+=pdftextaddu16(do_c16(u'0410'));
          myText+=pdftextnewline();
          myText+=pdftextaddu16(do_c16(u'3040'));
          myText+=pdftextnewline();
          myText+=pdftextaddu16(do_c16(u'30A0'));
          myText+=pdftextnewline();
          c16 = do_c16(u'AC00') ;
          myText+=pdftextadd(%Char(%Int(pdftextstrlenu16(c16 ) ))+':');
          myText+=pdftextnewline();
          myText+=pdftextaddu16(c16 );
          myText+=pdftextnewline();


          myText+=pdftextnewline();

          myText+=pdftextadd('UTF8');
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a32(x'C480'));
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a32(x'CE90'));
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a32(x'D090'));
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a48(x'E38180'));
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a48(x'e382a0'));
          myText+=pdftextnewline();
          myText+=pdftextaddu8 (do_a48(x'eab080'));
          myText+=pdftextnewline();
          myText+=pdftextnewline();

E01    Endsr ;
      /end-free

      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

BPR ?p do_a32          b
     d do_a32          pi            32a
     d   from                         2a   const
     d a32             s             32a
     d u               ds                  qualified based(pU)
     d   a                     1      2
     d   a_u                   2      2u 0
     d i               s              3u 0
    ? /free
       pU = %Addr(a32);
B01    For i = 0 to 15;
          u.a = from;
          u.a_u +=i;
          pU +=2;
E01    Endfor;
       Return a32;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
    ? /end-free
EPR  p                 e
BPR ?p do_a48          b
     d do_a48          pi            48a
     d   from                         3a   const
     d a48             s             48a
     d u               ds                  qualified based(pU)
     d   a                     1      3
     d   a_u                   3      3u 0
     d i               s              3u 0
    ? /free
       pU = %Addr(a48);
B01    For i = 0 to 15;
          u.a = from;
          u.a_u +=i;
          pU +=3;
E01    Endfor;
       Return a48;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
    ? /end-free
EPR  p                 e

BPR ?p do_c16          b
     d do_c16          pi            16c
     d   from                         1c   const
     d    c16          s             16c


     d u               ds                  qualified based(pU)
     d   c                     1      2c
     d   c_u                   1      2u 0
     d i               s              3u 0
    ? /free
       pU = %Addr(c16);
B01    For i = 0 to 15;
          u.c = from;
          u.c_u +=i;
          pU +=2;
E01    Endfor;

       Return c16;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ?p*                b
    ? */free
    ? * begsr *pssr;
    ? * dump;
    ? * endsr;
    ? */end-free
    ?P*                 e
    ? *=---------------------------------------------------------------=*
