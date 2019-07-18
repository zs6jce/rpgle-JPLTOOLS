      /define INFDS
      /define PDF
      /define CMATH
      /define LowerCase
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
     h copyright('Author is Jean-Paul Lamontre')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     D IfsName         s            512a   varying
     D RC              S             10i 0

     d myProcSet       ds                  likeds(pdfprocset)
     d myResource      ds                  likeds(pdfResource)
     d myResource2     ds                  likeds(pdfResource)
     d myContent       ds                  likeds(pdfContent )
     d myStream        s                   like(pdfstream  )
     d myDraw          s                   like(pdfstream  )
     d myText          s                   like(pdfstream  )


     d iRed            s              5u 0
     d iGreen          s              5u 0
     d iBlue           s              5u 0
     d i               s              5u 0


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
       //?
       //?destroy if exist then create a file
       //?





       ifsname='/Home/Lamontre/PdfPalette.pdf';
       PdfNewFile(Ifsname: 'Draw the Color Palette' );
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
       PdfNewPage(pdf_A4Landscape:'Page':0:0:10);//?dim = 0 0 595 840
       PdfPageResource(myResource);
       PdfNewOutline('Color palette RGB resume');

       myDraw='';
       myText='';
       MyDraw+=PdfStrmSaveGraphicState();


       MyText+=PdftextOpen();
       MyText +=PdfTextFont(PdfHelvet :10);
       MyText+=PdfStrmStrokingColorGray(0);
       MyText+=PdfStrmFillingColorGray(0);
       MyText+=PdfTextGoTo(00:500);

B01    for i = 0 by 16;
B02       if i >= 256;
             i = 255;
E02       endif;
          MyText+=PdfTextGoTo(000:PdfTextRow);
          MyDraw+=PdfDrawGoTo(000:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' +      '0' +', ' +      '0' );
          mydraw+=pdfStrmFillingcolorrgb(i/255:0:0);
          MyDraw+=PdfDrawAddRectangle(000:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(100:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' + %char(i) +', ' +      '0' );
          mydraw+=pdfStrmFillingcolorrgb(0:i/255:0);
          MyDraw+=PdfDrawAddRectangle(100:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(200:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' +      '0' +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorrgb(0:0:i/255);
          MyDraw+=PdfDrawAddRectangle(200:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(300:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' + %char(i) +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorrgb(0:i/255:i/255);
          MyDraw+=PdfDrawAddRectangle(300:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(400:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' +      '0' +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorrgb(i/255:0:i/255);
          MyDraw+=PdfDrawAddRectangle(400:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(500:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' + %char(i) +', ' +      '0' );
          mydraw+=pdfStrmFillingcolorrgb(i/255:i/255:0);
          MyDraw+=PdfDrawAddRectangle(500:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(600:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' + %char(i) +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorrgb(i/255:i/255:i/255);
          MyDraw+=PdfDrawAddRectangle(600:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(700:PdfTextRow);
          MyText+=PdfTextNewLine();
          MyText+=PdfTextNewLine();
B02       if i >= 255;
             leave;
E02       endif;
E01    endfor;




       MyText+=PdfTextClose();

       MyDraw+=PdfStrmRestoreGraphicState();

       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );

       //?add a page to the pdf
       PdfNewPage(pdf_A4Landscape:'Page':0:0:10);//?dim = 0 0 595 840
       PdfPageResource(myResource);
       PdfNewOutline('Named Color palette');

       myDraw='';
       myText='';
       MyDraw+=PdfStrmSaveGraphicState();
       MyText+=PdftextOpen();
       MyText +=PdfTextFont(PdfHelvet :10);
       MyText+=PdfStrmStrokingColorGray(0);
       MyText+=PdfStrmFillingColorGray(0);


       MyText+=PdfTextGoTo(00:580);

       MyText+=PdfTextAdd(             'aliceblue');
       mydraw+=pdfStrmFillingcolorHTML('aliceblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'antiquewhite');
       mydraw+=pdfStrmFillingcolorHTML('antiquewhite');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'aquamarine');
       mydraw+=pdfStrmFillingcolorHTML('aquamarine');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'azure');
       mydraw+=pdfStrmFillingcolorHTML('azure');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'beige');
       mydraw+=pdfStrmFillingcolorHTML('beige');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'bisque');
       mydraw+=pdfStrmFillingcolorHTML('bisque');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'blanchedalmond');
       mydraw+=pdfStrmFillingcolorHTML('blanchedalmond');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'blue');
       mydraw+=pdfStrmFillingcolorHTML('blue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'blueviolet');
       mydraw+=pdfStrmFillingcolorHTML('blueviolet');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'brown');
       mydraw+=pdfStrmFillingcolorHTML('brown');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'burlywood');
       mydraw+=pdfStrmFillingcolorHTML('burlywood');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'cadetblue');
       mydraw+=pdfStrmFillingcolorHTML('cadetblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'chartreuse');
       mydraw+=pdfStrmFillingcolorHTML('chartreuse');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'chocolate');
       mydraw+=pdfStrmFillingcolorHTML('chocolate');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'coral');
       mydraw+=pdfStrmFillingcolorHTML('coral');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'cornflower');
       mydraw+=pdfStrmFillingcolorHTML('cornflower');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'cornsilk');
       mydraw+=pdfStrmFillingcolorHTML('cornsilk');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'crimson');
       mydraw+=pdfStrmFillingcolorHTML('crimson');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'cyan');
       mydraw+=pdfStrmFillingcolorHTML('cyan');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkblue');
       mydraw+=pdfStrmFillingcolorHTML('darkblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'darkcyan');
       mydraw+=pdfStrmFillingcolorHTML('darkcyan');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkgoldenrod');
       mydraw+=pdfStrmFillingcolorHTML('darkgoldenrod');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkgray');
       mydraw+=pdfStrmFillingcolorHTML('darkgray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkgreen');
       mydraw+=pdfStrmFillingcolorHTML('darkgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkkhaki');
       mydraw+=pdfStrmFillingcolorHTML('darkkhaki');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkmagenta');
       mydraw+=pdfStrmFillingcolorHTML('darkmagenta');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkolivegreen');
       mydraw+=pdfStrmFillingcolorHTML('darkolivegreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'darkorange');
       mydraw+=pdfStrmFillingcolorHTML('darkorange');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkorchid');
       mydraw+=pdfStrmFillingcolorHTML('darkorchid');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkred');
       mydraw+=pdfStrmFillingcolorHTML('darkred');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darksalmon');
       mydraw+=pdfStrmFillingcolorHTML('darksalmon');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkseagreen');
       mydraw+=pdfStrmFillingcolorHTML('darkseagreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkslateblue');
       mydraw+=pdfStrmFillingcolorHTML('darkslateblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkslategray');
       mydraw+=pdfStrmFillingcolorHTML('darkslategray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'darkturquoise');
       mydraw+=pdfStrmFillingcolorHTML('darkturquoise');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'darkviolet');
       mydraw+=pdfStrmFillingcolorHTML('darkviolet');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'deeppink');
       mydraw+=pdfStrmFillingcolorHTML('deeppink');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'deepskyblue');
       mydraw+=pdfStrmFillingcolorHTML('deepskyblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'dimgray');
       mydraw+=pdfStrmFillingcolorHTML('dimgray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'dodgerblue');
       mydraw+=pdfStrmFillingcolorHTML('dodgerblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'firebrick');
       mydraw+=pdfStrmFillingcolorHTML('firebrick');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'floralwhite');
       mydraw+=pdfStrmFillingcolorHTML('floralwhite');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'forestgreen');
       mydraw+=pdfStrmFillingcolorHTML('forestgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'gainsboro');
       mydraw+=pdfStrmFillingcolorHTML('gainsboro');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'ghostwhite');
       mydraw+=pdfStrmFillingcolorHTML('ghostwhite');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'gold');
       mydraw+=pdfStrmFillingcolorHTML('gold');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'goldenrod');
       mydraw+=pdfStrmFillingcolorHTML('goldenrod');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'gray');
       mydraw+=pdfStrmFillingcolorHTML('gray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'green');
       mydraw+=pdfStrmFillingcolorHTML('green');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'greenyellow');
       mydraw+=pdfStrmFillingcolorHTML('greenyellow');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'honeydew');
       mydraw+=pdfStrmFillingcolorHTML('honeydew');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'hotpink');
       mydraw+=pdfStrmFillingcolorHTML('hotpink');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'indianred');
       mydraw+=pdfStrmFillingcolorHTML('indianred');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'indigo');
       mydraw+=pdfStrmFillingcolorHTML('indigo');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'ivory');
       mydraw+=pdfStrmFillingcolorHTML('ivory');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'khaki');
       mydraw+=pdfStrmFillingcolorHTML('khaki');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lavender');
       mydraw+=pdfStrmFillingcolorHTML('lavender');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lavenderblush');
       mydraw+=pdfStrmFillingcolorHTML('lavenderblush');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lawngreen');
       mydraw+=pdfStrmFillingcolorHTML('lawngreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lemonchiffon');
       mydraw+=pdfStrmFillingcolorHTML('lemonchiffon');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightblue');
       mydraw+=pdfStrmFillingcolorHTML('lightblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightcoral');
       mydraw+=pdfStrmFillingcolorHTML('lightcoral');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'lightcyan');
       mydraw+=pdfStrmFillingcolorHTML('lightcyan');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightgoldenrodyellow');
       mydraw+=pdfStrmFillingcolorHTML('lightgoldenrodyellow');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightgreen');
       mydraw+=pdfStrmFillingcolorHTML('lightgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightgrey');
       mydraw+=pdfStrmFillingcolorHTML('lightgrey');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightpink');
       mydraw+=pdfStrmFillingcolorHTML('lightpink');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightsalmon');
       mydraw+=pdfStrmFillingcolorHTML('lightsalmon');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightseagreen');
       mydraw+=pdfStrmFillingcolorHTML('lightseagreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'lightskyblue');
       mydraw+=pdfStrmFillingcolorHTML('lightskyblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightslategray');
       mydraw+=pdfStrmFillingcolorHTML('lightslategray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightsteelblue');
       mydraw+=pdfStrmFillingcolorHTML('lightsteelblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lightyellow');
       mydraw+=pdfStrmFillingcolorHTML('lightyellow');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'lime');
       mydraw+=pdfStrmFillingcolorHTML('lime');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'limegreen');
       mydraw+=pdfStrmFillingcolorHTML('limegreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'linen');
       mydraw+=pdfStrmFillingcolorHTML('linen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextToLeft();
       MyText+=PdfTextAdd(             'magenta');
       mydraw+=pdfStrmFillingcolorHTML('magenta');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'maroon');
       mydraw+=pdfStrmFillingcolorHTML('maroon');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumaquamarine');
       mydraw+=pdfStrmFillingcolorHTML('mediumaquamarine');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumblue');
       mydraw+=pdfStrmFillingcolorHTML('mediumblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumorchid');
       mydraw+=pdfStrmFillingcolorHTML('mediumorchid');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumpurple');
       mydraw+=pdfStrmFillingcolorHTML('mediumpurple');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumseagreen');
       mydraw+=pdfStrmFillingcolorHTML('mediumseagreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'mediumslateblue');
       mydraw+=pdfStrmFillingcolorHTML('mediumslateblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumspringgreen');
       mydraw+=pdfStrmFillingcolorHTML('mediumspringgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumturquoise');
       mydraw+=pdfStrmFillingcolorHTML('mediumturquoise');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mediumvioletred');
       mydraw+=pdfStrmFillingcolorHTML('mediumvioletred');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'midnightblue');
       mydraw+=pdfStrmFillingcolorHTML('midnightblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mintcream');
       mydraw+=pdfStrmFillingcolorHTML('mintcream');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'mistyrose');
       mydraw+=pdfStrmFillingcolorHTML('mistyrose');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'moccasin');
       mydraw+=pdfStrmFillingcolorHTML('moccasin');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'navajowhite');
       mydraw+=pdfStrmFillingcolorHTML('navajowhite');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'navy');
       mydraw+=pdfStrmFillingcolorHTML('navy');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'oldlace');
       mydraw+=pdfStrmFillingcolorHTML('oldlace');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'olive');
       mydraw+=pdfStrmFillingcolorHTML('olive');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'olivedrab');
       mydraw+=pdfStrmFillingcolorHTML('olivedrab');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'orange');
       mydraw+=pdfStrmFillingcolorHTML('orange');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'orangered');
       mydraw+=pdfStrmFillingcolorHTML('orangered');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'orchid');
       mydraw+=pdfStrmFillingcolorHTML('orchid');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'palegoldenrod');
       mydraw+=pdfStrmFillingcolorHTML('palegoldenrod');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'palegreen');
       mydraw+=pdfStrmFillingcolorHTML('palegreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'paleturquoise');
       mydraw+=pdfStrmFillingcolorHTML('paleturquoise');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'palevioletred');
       mydraw+=pdfStrmFillingcolorHTML('palevioletred');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'papayawhip');
       mydraw+=pdfStrmFillingcolorHTML('papayawhip');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'peachpuff');
       mydraw+=pdfStrmFillingcolorHTML('peachpuff');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'peru');
       mydraw+=pdfStrmFillingcolorHTML('peru');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'pink');
       mydraw+=pdfStrmFillingcolorHTML('pink');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'plum');
       mydraw+=pdfStrmFillingcolorHTML('plum');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'powderblue');
       mydraw+=pdfStrmFillingcolorHTML('powderblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'purple');
       mydraw+=pdfStrmFillingcolorHTML('purple');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'red');
       mydraw+=pdfStrmFillingcolorHTML('red');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'rosybrown');
       mydraw+=pdfStrmFillingcolorHTML('rosybrown');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'royalblue');
       mydraw+=pdfStrmFillingcolorHTML('royalblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'saddlebrown');
       mydraw+=pdfStrmFillingcolorHTML('saddlebrown');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'salmon');
       mydraw+=pdfStrmFillingcolorHTML('salmon');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'sandybrown');
       mydraw+=pdfStrmFillingcolorHTML('sandybrown');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'seagreen');
       mydraw+=pdfStrmFillingcolorHTML('seagreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'seashell');
       mydraw+=pdfStrmFillingcolorHTML('seashell');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'sienna');
       mydraw+=pdfStrmFillingcolorHTML('sienna');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'silver');
       mydraw+=pdfStrmFillingcolorHTML('silver');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'skyblue');
       mydraw+=pdfStrmFillingcolorHTML('skyblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'slateblue');
       mydraw+=pdfStrmFillingcolorHTML('slateblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'slategray');
       mydraw+=pdfStrmFillingcolorHTML('slategray');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'snow');
       mydraw+=pdfStrmFillingcolorHTML('snow');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'springgreen');
       mydraw+=pdfStrmFillingcolorHTML('springgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'steelblue');
       mydraw+=pdfStrmFillingcolorHTML('steelblue');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'tan');
       mydraw+=pdfStrmFillingcolorHTML('tan');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'teal');
       mydraw+=pdfStrmFillingcolorHTML('teal');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'thistle');
       mydraw+=pdfStrmFillingcolorHTML('thistle');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'tomato');
       mydraw+=pdfStrmFillingcolorHTML('tomato');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'turquoise');
       mydraw+=pdfStrmFillingcolorHTML('turquoise');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'violet');
       mydraw+=pdfStrmFillingcolorHTML('violet');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextNewLine();
       MyText+=PdfTextToLeft();

       MyText+=PdfTextAdd(             'wheat');
       mydraw+=pdfStrmFillingcolorHTML('wheat');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'white');
       mydraw+=pdfStrmFillingcolorHTML('white');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'whitesmoke');
       mydraw+=pdfStrmFillingcolorHTML('whitesmoke');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'yellow');
       mydraw+=pdfStrmFillingcolorHTML('yellow');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);

       MyText+=PdfTextAdd(             'yellowgreen');
       mydraw+=pdfStrmFillingcolorHTML('yellowgreen');
       MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+8:98:10 );
          mydraw+=PdfDrawClosePath(pdf_fill );
       MyText+=PdfTextGoTo(PdfTextCol+100: PdfTextRow);
       MyDraw+=PdfStrmRestoreGraphicState();

       MyText+=PdfTextClose();

       mystream=mydraw+mytext;
       MyContent = PdfLoadContent(myStream);//?auto-close
       PdfPageContent (myContent );
       PdfClosePage( );
       //?add 16 pages for the color palette
B01    for iRed = 0 by 16;
B02       if iRed >= 256;
             iRed = 255;
E02       endif;
          //?add a page to the pdf
          PdfNewPage(pdf_A4Landscape:'Page':0:0:10);//?dim = 0 0 595 840
          PdfPageResource(myResource);
          PdfNewOutline('Color palette RGB detailled');
          myDraw='';
          myText='';
          MyDraw+=PdfStrmSaveGraphicState();

          MyText+=PdftextOpen();
          MyText +=PdfTextFont(PdfHelvet :08);
          MyText+=PdfStrmStrokingColorGray(0);
          MyText+=PdfStrmFillingColorGray(0);
          MyText+=PdfTextGoTo(00:500);

B02       for iGreen= 0 by 16;
B03          if iGreen >= 256;
                iGreen = 255;
E03          endif;

B03          for iBlue = 0 by 16;
B04             if iBlue >= 256;
                   iBlue = 255;
E04             endif;
                MyText+=PdfTextAdd(%char(iRed) +', '
                   + %char(iGreen) +', '
                   + %char(iBlue) );
                mydraw+=pdfStrmFillingcolorrgb(iRed/255:iGreen/255:iBlue/255);
                MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+08:48:12);
                mydraw+=PdfDrawClosePath(pdf_fill );

                MyText+=PdfTextGoTo(PdfTextCol+50:PdfTextRow);
B04             if iBlue >= 255;
                   leave;
E04             endif;
E03          endfor;
             MyText+=PdfTextNewLine();
             MyText+=PdfTextNewLine();
             MyText+=PdfTextNewLine();
             MyText+=PdfTextToLeft();
B03          if iGreen >= 255;
                leave;
E03          endif;
E02       endfor;
          MyText+=PdfTextClose();
          MyDraw+=PdfStrmRestoreGraphicState();


          mystream=mydraw+mytext;
          MyContent = PdfLoadContent(myStream);//?auto-close
          PdfPageContent (myContent );
          PdfClosePage( );

B02       if iRed >= 255;
             leave;
E02       endif;
E01    endfor;
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
