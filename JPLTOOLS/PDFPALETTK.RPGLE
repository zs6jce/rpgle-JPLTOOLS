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


     d iCyan           s              5u 0
     d iMagenta        s              5u 0
     d iYellow         s              5u 0
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





       ifsname='/Home/Lamontre/PdfPaletteCMYK.pdf';
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
       PdfNewOutline('Color palette CMYK resume');

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
          mydraw+=pdfStrmFillingcolorCMYK(i/255:0:0:0);
          MyDraw+=PdfDrawAddRectangle(000:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(100:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' + %char(i) +', ' +      '0' );
          mydraw+=pdfStrmFillingcolorCMYK(0:i/255:0:0);
          MyDraw+=PdfDrawAddRectangle(100:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(200:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' +      '0' +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorCMYK(0:0:i/255:0);
          MyDraw+=PdfDrawAddRectangle(200:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(300:PdfTextRow);
          MyText+=PdfTextAdd(     '0' +', ' + %char(i) +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorCMYK(0:i/255:i/255:0);
          MyDraw+=PdfDrawAddRectangle(300:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(400:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' +      '0' +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorCMYK(i/255:0:i/255:0);
          MyDraw+=PdfDrawAddRectangle(400:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(500:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' + %char(i) +', ' +      '0' );
          mydraw+=pdfStrmFillingcolorCMYK(i/255:i/255:0:0);
          MyDraw+=PdfDrawAddRectangle(500:PdfTextRow+08:098:10);
          mydraw+=PdfDrawClosePath(pdf_fill );

          MyText+=PdfTextGoTo(600:PdfTextRow);
          MyText+=PdfTextAdd(%char(i) +', ' + %char(i) +', ' + %char(i) );
          mydraw+=pdfStrmFillingcolorCMYK(i/255:i/255:i/255:0);
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

       //?add 16 pages for the color palette
B01    for iCyan = 0 by 16;
B02       if iCyan >= 256;
             iCyan = 255;
E02       endif;
          //?add a page to the pdf
          PdfNewPage(pdf_A4Landscape:'Page':0:0:10);//?dim = 0 0 595 840
          PdfPageResource(myResource);
          PdfNewOutline('Color palette CMYK detailled');
          myDraw='';
          myText='';
          MyDraw+=PdfStrmSaveGraphicState();

          MyText+=PdftextOpen();
          MyText +=PdfTextFont(PdfHelvet :08);
          MyText+=PdfStrmStrokingColorGray(0);
          MyText+=PdfStrmFillingColorGray(0);
          MyText+=PdfTextGoTo(00:500);

B02       for iMagenta= 0 by 16;
B03          if iMagenta >= 256;
                iMagenta = 255;
E03          endif;

B03          for iYellow = 0 by 16;
B04             if iYellow >= 256;
                   iYellow = 255;
E04             endif;
                MyText+=PdfTextAdd(%char(iCyan) +', '
                   + %char(iMagenta) +', '
                   + %char(iYellow) );
                mydraw+=pdfStrmFillingcolorCMYK(
                      iCyan/255:iMagenta/255:iYellow/255:0);
                MyDraw+=PdfDrawAddRectangle(PdfTextCol:PdfTextRow+08:48:12);
                mydraw+=PdfDrawClosePath(pdf_fill );

                MyText+=PdfTextGoTo(PdfTextCol+50:PdfTextRow);
B04             if iYellow >= 255;
                   leave;
E04             endif;
E03          endfor;
             MyText+=PdfTextNewLine();
             MyText+=PdfTextNewLine();
             MyText+=PdfTextNewLine();
             MyText+=PdfTextToLeft();
B03          if iMagenta >= 255;
                leave;
E03          endif;
E02       endfor;
          MyText+=PdfTextClose();
          MyDraw+=PdfStrmRestoreGraphicState();


          mystream=mydraw+mytext;
          MyContent = PdfLoadContent(myStream);//?auto-close
          PdfPageContent (myContent );
          PdfClosePage( );

B02       if iCyan >= 255;
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
