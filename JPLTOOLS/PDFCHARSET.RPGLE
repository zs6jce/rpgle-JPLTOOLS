      *
      *  this demonstrator shows
      *  -how to print each character of the PDF reader character set,
      *   even if these characters are not in the classic EBCDIC character set (IE CCSID 500)
      *   this remark targets particularly all the windows's chars between x'80' and x'9f'
      *  - each character in each of the 14 embedded font
      *  - the checker of character size computation.
      *
      /define LOWERCASE
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
     d PieText         s                   like(pdfstream  )
     d PieTextLen      s                   like(PdfTextStrlen)
     d daisyText       s                   like(pdfstream  )
     d Logo            ds                  likeds(pdfImage   )
     d i               s              5i 0


     d MyColor         ds                  likeds(PdfColor)
     d Sample          s             50
     d SampleSize      s              3u 0 inz(20)
     d Len             s                   like(PdfTextStrlen)

     d ascii           ds                  qualified
     d   value                        3u 0 dim(224)
     d   char                         1    dim(224) overlay(ascii)

     d CharName        DS                  qualified
     d SPACE                         14    inz('SPACE         ')
     d EXCLAMATION                   14    inz('EXCLAMATION   ')
     d QUOTATION_MARK                14    inz('QUOTATION_MARK')
     d NUMBER_SIGN                   14    inz('NUMBER_SIGN   ')
     d DOLLAR_SIGN                   14    inz('DOLLAR_SIGN   ')
     d PERCENT_SIGN                  14    inz('PERCENT_SIGN  ')
     d AMPERSAND                     14    inz('AMPERSAND     ')
     d APOSTROPHE                    14    inz('APOSTROPHE    ')
     d L_PARENTHESIS                 14    inz('L_PARENTHESIS ')
     d R_PARENTHESIS                 14    inz('R_PARENTHESIS ')
     d ASTERISK                      14    inz('ASTERISK      ')
     d PLUS_SIGN                     14    inz('PLUS_SIGN     ')
     d COMMA                         14    inz('COMMA         ')
     d HYPHEN_MINUS                  14    inz('HYPHEN_MINUS  ')
     d PERIOD                        14    inz('PERIOD        ')
     d SLASH                         14    inz('SLASH         ')
     d DIGIT_ZERO                    14    inz('DIGIT_ZERO    ')
     d DIGIT_ONE                     14    inz('DIGIT_ONE     ')
     d DIGIT_TWO                     14    inz('DIGIT_TWO     ')
     d DIGIT_THREE                   14    inz('DIGIT_THREE   ')
     d DIGIT_FOUR                    14    inz('DIGIT_FOUR    ')
     d DIGIT_FIVE                    14    inz('DIGIT_FIVE    ')
     d DIGIT_SIX                     14    inz('DIGIT_SIX     ')
     d DIGIT_SEVEN                   14    inz('DIGIT_SEVEN   ')
     d DIGIT_EIGHT                   14    inz('DIGIT_EIGHT   ')
     d DIGIT_NINE                    14    inz('DIGIT_NINE    ')
     d COLON                         14    inz('COLON         ')
     d SEMICOLON                     14    inz('SEMICOLON     ')
     d LESS_THAN_SIGN                14    inz('LESS_THAN_SIGN')
     d EQUALS_SIGN                   14    inz('EQUALS_SIGN   ')
     d GREATER_THAN                  14    inz('GREATER_THAN  ')
     d QUESTION_MARK                 14    inz('QUESTION_MARK ')
     d COMMERCIAL_AT                 14    inz('COMMERCIAL_AT ')
     d CAPITAL_A                     14    inz('CAPITAL_A     ')
     d CAPITAL_B                     14    inz('CAPITAL_B     ')
     d CAPITAL_C                     14    inz('CAPITAL_C     ')
     d CAPITAL_D                     14    inz('CAPITAL_D     ')
     d CAPITAL_E                     14    inz('CAPITAL_E     ')
     d CAPITAL_F                     14    inz('CAPITAL_F     ')
     d CAPITAL_G                     14    inz('CAPITAL_G     ')
     d CAPITAL_H                     14    inz('CAPITAL_H     ')
     d CAPITAL_I                     14    inz('CAPITAL_I     ')
     d CAPITAL_J                     14    inz('CAPITAL_J     ')
     d CAPITAL_K                     14    inz('CAPITAL_K     ')
     d CAPITAL_L                     14    inz('CAPITAL_L     ')
     d CAPITAL_M                     14    inz('CAPITAL_M     ')
     d CAPITAL_N                     14    inz('CAPITAL_N     ')
     d CAPITAL_O                     14    inz('CAPITAL_O     ')
     d CAPITAL_P                     14    inz('CAPITAL_P     ')
     d CAPITAL_Q                     14    inz('CAPITAL_Q     ')
     d CAPITAL_R                     14    inz('CAPITAL_R     ')
     d CAPITAL_S                     14    inz('CAPITAL_S     ')
     d CAPITAL_T                     14    inz('CAPITAL_T     ')
     d CAPITAL_U                     14    inz('CAPITAL_U     ')
     d CAPITAL_V                     14    inz('CAPITAL_V     ')
     d CAPITAL_W                     14    inz('CAPITAL_W     ')
     d CAPITAL_X                     14    inz('CAPITAL_X     ')
     d CAPITAL_Y                     14    inz('CAPITAL_Y     ')
     d CAPITAL_Z                     14    inz('CAPITAL_Z     ')
     d LEFT_BRACKET                  14    inz('LEFT_BRACKET  ')
     d BACKSLASH                     14    inz('BACKSLASH     ')
     d RIGHT_BRACKET                 14    inz('RIGHT_BRACKET ')
     d CIRCUMFLEX_ACC                14    inz('CIRCUMFLEX_ACC')
     d UNDERSCORE                    14    inz('UNDERSCORE    ')
     d GRAVE_ACCENT                  14    inz('GRAVE_ACCENT  ')
     d SML_A                         14    inz('SML_A         ')
     d SML_B                         14    inz('SML_B         ')
     d SML_C                         14    inz('SML_C         ')
     d SML_D                         14    inz('SML_D         ')
     d SML_E                         14    inz('SML_E         ')
     d SML_F                         14    inz('SML_F         ')
     d SML_G                         14    inz('SML_G         ')
     d SML_H                         14    inz('SML_H         ')
     d SML_I                         14    inz('SML_I         ')
     d SML_J                         14    inz('SML_J         ')
     d SML_K                         14    inz('SML_K         ')
     d SML_L                         14    inz('SML_L         ')
     d SML_M                         14    inz('SML_M         ')
     d SML_N                         14    inz('SML_N         ')
     d SML_O                         14    inz('SML_O         ')
     d SML_P                         14    inz('SML_P         ')
     d SML_Q                         14    inz('SML_Q         ')
     d SML_R                         14    inz('SML_R         ')
     d SML_S                         14    inz('SML_S         ')
     d SML_T                         14    inz('SML_T         ')
     d SML_U                         14    inz('SML_U         ')
     d SML_V                         14    inz('SML_V         ')
     d SML_W                         14    inz('SML_W         ')
     d SML_X                         14    inz('SML_X         ')
     d SML_Y                         14    inz('SML_Y         ')
     d SML_Z                         14    inz('SML_Z         ')
     d LEFT_BRACE                    14    inz('LEFT_BRACE    ')
     d VERTICAL_LINE                 14    inz('VERTICAL_LINE ')
     d RIGHT_BRACE                   14    inz('RIGHT_BRACE   ')
     d ASCIITILDE                    14    inz('ASCIITILDE    ')
     d DELETE                        14    inz('DELETE        ')
     d Euro                          14    inz('Euro          ')
     d x81                           14    inz('x81           ')
     d x82                           14    inz('x82           ')
     d florin                        14    inz('florin        ')
     d quotedblbase                  14    inz('quotedblbase  ')
     d x85                           14    inz('x85           ')
     d dagger                        14    inz('dagger        ')
     d daggerdbl                     14    inz('daggerdbl     ')
     d circumflex                    14    inz('circumflex    ')
     d perthousand                   14    inz('perthousand   ')
     d CapScaron                     14    inz('CapScaron     ')
     d guilsinglleft                 14    inz('guilsinglleft ')
     d cap_OE                        14    inz('cap_OE        ')
     d x8d                           14    inz('x8d           ')
     d Cap_Zcaron                    14    inz('Cap_Zcaron    ')
     d x8f                           14    inz('x8f           ')
     d x90                           14    inz('x90           ')
     d quoteleft                     14    inz('quoteleft     ')
     d quoteright                    14    inz('quoteright    ')
     d quotedblleft                  14    inz('quotedblleft  ')
     d quotedblright                 14    inz('quotedblright ')
     d bullet                        14    inz('bullet        ')
     d underline                     14    inz('underline     ')
     d dbl_underline                 14    inz('dbl_underline ')
     d Tilde                         14    inz('Tilde         ')
     d trademark                     14    inz('trademark     ')
     d Sml_scaron                    14    inz('Sml_scaron    ')
     d guilsinglright                14    inz('guilsinglright')
     d sml_oe                        14    inz('sml_oe        ')
     d x9d                           14    inz('x9d           ')
     d sml_zcaron                    14    inz('sml_zcaron    ')
     d Ydieresis                     14    inz('Ydieresis     ')
     d NO_BREAK_SPACE                14    inz('NO_BREAK_SPACE')
     d INVERTED_EXCLA                14    inz('INVERTED_EXCLA')
     d CENT_SIGN                     14    inz('CENT_SIGN     ')
     d POUND_SIGN                    14    inz('POUND_SIGN    ')
     d CURRENCY_SIGN                 14    inz('CURRENCY_SIGN ')
     d YEN_SIGN                      14    inz('YEN_SIGN      ')
     d BROKEN_BAR                    14    inz('BROKEN_BAR    ')
     d SECTION_SIGN                  14    inz('SECTION_SIGN  ')
     d DIAERESIS                     14    inz('DIAERESIS     ')
     d COPYRIGHT_SIGN                14    inz('COPYRIGHT_SIGN')
     d FEMININE_ORDIN                14    inz('FEMININE_ORDIN')
     d L_DBL_QUOTE                   14    inz('L_DBL_QUOTE   ')
     d NOT_SIGN                      14    inz('NOT_SIGN      ')
     d SOFT_HYPHEN                   14    inz('SOFT_HYPHEN   ')
     d REGISTERED                    14    inz('REGISTERED    ')
     d MACRON                        14    inz('MACRON        ')
     d DEGREE_SIGN                   14    inz('DEGREE_SIGN   ')
     d PLUS_MINUS                    14    inz('PLUS_MINUS    ')
     d SUPER_TWO                     14    inz('SUPER_TWO     ')
     d SUPER_THREE                   14    inz('SUPER_THREE   ')
     d ACUTE_ACCENT                  14    inz('ACUTE_ACCENT  ')
     d MICRO_SIGN                    14    inz('MICRO_SIGN    ')
     d PARAGRAPH_sign                14    inz('PARAGRAPH_sign')
     d MIDDLE_DOT                    14    inz('MIDDLE_DOT    ')
     d CEDILLA                       14    inz('CEDILLA       ')
     d SUPER_ONE                     14    inz('SUPER_ONE     ')
     d MASCULINE_ORDI                14    inz('MASCULINE_ORDI')
     d R_DBL_QUOTE                   14    inz('R_DBL_QUOTE   ')
     d ONE_QUARTER                   14    inz('ONE_QUARTER   ')
     d ONE_HALF                      14    inz('ONE_HALF      ')
     d THREE_QUARTERS                14    inz('THREE_QUARTERS')
     d INVERTED_QUEST                14    inz('INVERTED_QUEST')
     d CAP_A_GRAVE                   14    inz('CAP_A_GRAVE   ')
     d CAP_A_ACUTE                   14    inz('CAP_A_ACUTE   ')
     d CAP_A_CIRCUMFL                14    inz('CAP_A_CIRCUMFL')
     d CAP_A_TILDE                   14    inz('CAP_A_TILDE   ')
     d CAP_A_DIAERESI                14    inz('CAP_A_DIAERESI')
     d CAP_A_RING_ABO                14    inz('CAP_A_RING_ABO')
     d CAP_AE                        14    inz('CAP_AE        ')
     d CAP_C_CEDILLA                 14    inz('CAP_C_CEDILLA ')
     d CAP_E_GRAVE                   14    inz('CAP_E_GRAVE   ')
     d CAP_E_ACUTE                   14    inz('CAP_E_ACUTE   ')
     d CAP_E_CIRCUMFL                14    inz('CAP_E_CIRCUMFL')
     d CAP_E_DIAERESI                14    inz('CAP_E_DIAERESI')
     d CAP_I_GRAVE                   14    inz('CAP_I_GRAVE   ')
     d CAP_I_ACUTE                   14    inz('CAP_I_ACUTE   ')
     d CAP_I_CIRCUMFL                14    inz('CAP_I_CIRCUMFL')
     d CAP_I_DIAERESI                14    inz('CAP_I_DIAERESI')
     d CAP_ETH                       14    inz('CAP_ETH       ')
     d CAP_N_TILDE                   14    inz('CAP_N_TILDE   ')
     d CAP_O_GRAVE                   14    inz('CAP_O_GRAVE   ')
     d CAP_O_ACUTE                   14    inz('CAP_O_ACUTE   ')
     d CAP_O_CIRCUMFL                14    inz('CAP_O_CIRCUMFL')
     d CAP_O_TILDE                   14    inz('CAP_O_TILDE   ')
     d CAP_O_DIAERESI                14    inz('CAP_O_DIAERESI')
     d MULTIPLICATION                14    inz('MULTIPLICATION')
     d CAP_O_SLASH                   14    inz('CAP_O_SLASH   ')
     d CAP_U_GRAVE                   14    inz('CAP_U_GRAVE   ')
     d CAP_U_ACUTE                   14    inz('CAP_U_ACUTE   ')
     d CAP_U_CIRCUMFL                14    inz('CAP_U_CIRCUMFL')
     d CAP_U_DIAERESI                14    inz('CAP_U_DIAERESI')
     d CAP_Y_ACUTE                   14    inz('CAP_Y_ACUTE   ')
     d CAP_THORN                     14    inz('CAP_THORN     ')
     d SML_SHARP_S                   14    inz('SML_SHARP_S   ')
     d SML_A_GRAVE                   14    inz('SML_A_GRAVE   ')
     d SML_A_ACUTE                   14    inz('SML_A_ACUTE   ')
     d SML_A_CIRCUMFL                14    inz('SML_A_CIRCUMFL')
     d SML_A_TILDE                   14    inz('SML_A_TILDE   ')
     d SML_A_DIAERESI                14    inz('SML_A_DIAERESI')
     d SML_A_RING_ABO                14    inz('SML_A_RING_ABO')
     d SML_AE                        14    inz('SML_AE        ')
     d SML_C_CEDILLA                 14    inz('SML_C_CEDILLA ')
     d SML_E_GRAVE                   14    inz('SML_E_GRAVE   ')
     d SML_E_ACUTE                   14    inz('SML_E_ACUTE   ')
     d SML_E_CIRCUMFL                14    inz('SML_E_CIRCUMFL')
     d SML_E_DIAERESI                14    inz('SML_E_DIAERESI')
     d SML_I_GRAVE                   14    inz('SML_I_GRAVE   ')
     d SML_I_ACUTE                   14    inz('SML_I_ACUTE   ')
     d SML_I_CIRCUMFL                14    inz('SML_I_CIRCUMFL')
     d SML_I_DIAERESI                14    inz('SML_I_DIAERESI')
     d SML_ETH                       14    inz('SML_ETH       ')
     d SML_N_TILDE                   14    inz('SML_N_TILDE   ')
     d SML_O_GRAVE                   14    inz('SML_O_GRAVE   ')
     d SML_O_ACUTE                   14    inz('SML_O_ACUTE   ')
     d SML_O_CIRCUMFL                14    inz('SML_O_CIRCUMFL')
     d SML_O_TILDE                   14    inz('SML_O_TILDE   ')
     d SML_O_DIAERESI                14    inz('SML_O_DIAERESI')
     d DIVISION_SIGN                 14    inz('DIVISION_SIGN ')
     d SML_O_SLASH                   14    inz('SML_O_SLASH   ')
     d SML_U_GRAVE                   14    inz('SML_U_GRAVE   ')
     d SML_U_ACUTE                   14    inz('SML_U_ACUTE   ')
     d SML_U_CIRCUMFL                14    inz('SML_U_CIRCUMFL')
     d SML_U_DIAERESI                14    inz('SML_U_DIAERESI')
     d SML_Y_ACUTE                   14    inz('SML_Y_ACUTE   ')
     d SML_THORN                     14    inz('SML_THORN     ')
     d SML_Y_DIAERESI                14    inz('SML_Y_DIAERESI')
     d   name                        14    dim(224) overlay(charname)

     d iRed            s              5u 0
     d iGreen          s              5u 0
     d iBlue           s              5u 0
     d iPage           s              5u 0
     d iChar           s              5u 0

     d MyFont          ds                  likeds(pdfFont)
      /free
       //?my pdf objects need to be created as soon as possible
       //?to store childs object number
       //?
       //?this tool is architectured to build one pdf at a time : all pdf object
       //?are global and unique : they don't need to be named inside procedure.
       //?this makes code cleaned from repeating most pdf objects list in each
       //?procedure call.
       //?
       //?
       //?
       //?destroy if exist then create a file
       //?





       ifsname='/Home/Lamontre/PdfCharacterSet.pdf';
       PdfNewFile(Ifsname: 'Test STRLEN' :0:'':'':511);
       // 511 = S_IRWXU + S_IRWXG + S_IRWXO ; cf JP4IFS lines 85 & next
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

B01    for i = 1 to 224;
          ascii.value(i)=i+31;
E01    endfor;
       ascii =ConvCcsid(1252:0:ascii );

B01    for i = 1 to 14;
B02       select;
X02          when i = 1;
                myfont= PdfCourier ;
X02          when i = 2;
                myfont= PdfCourierB ;
X02          when i = 3;
                myfont= PdfCourierI ;
X02          when i = 4;
                myfont= PdfCourierBI;
X02          when i = 5;
                myfont= PdfHelvet ;
X02          when i = 6;
                myfont= PdfHelvetB ;
X02          when i = 7;
                myfont= PdfHelvetI ;
X02          when i = 8;
                myfont= PdfHelvetBI ;
X02          when i = 9;
                myfont= PdfTimes ;
X02          when i =10;
                myfont= PdfTimesB ;
X02          when i =11;
                myfont= PdfTimesI ;
X02          when i =12;
                myfont= PdfTimesBI ;
X02          when i =13;
                myfont= PdfSymbol ;
X02          when i =14;
                myfont= PdfZapf ;
E02       endsl;
          //?new page
          //?add a page to the pdf
          //?PdfNewPage(pdf_Custom     :'Page ':5000:2250:50);
          PdfNewPage(pdf_Custom     :'Page ':5000:4500:50);
          PdfPageResource(myResource);
          PdfNewOutline(MyFont.basefont);
          myDraw='';
          myText='';
          MyText =PdfCanvas( PdfHelvet : 50 : samplesize );

             MyDraw+=PdfStrmSaveGraphicState();

          MyText+=PdftextOpen();
          MyText+=PdfStrmStrokingColorGray(0);
          MyText+=PdfStrmFillingColorGray(0);
          MyText+=PdfTextGoTo(000:4500 - sampleSize*2);
B02       for iChar = 1 to 224;
             MyText+=PdfTextFont(MyFont :SampleSize);
             Sample=*blank;
             Sample=%xlate(' ':Ascii.char(iChar):Sample);
             mytext+=PdfTextToLeft();
             mytext+=PdfTextmoveto(1000-len:0);
             Len=PdfTextStrlen(Sample);//?sample = 50 chars, font 20
             mytext+=PdfTextAdd(Sample);
             MyText+=PdfTextFont(PdfHelvet :samplesize);
             mytext+=PdfTextAdd('<'
                + lcase(%trim(charname.name(iChar))
                +%trim(  MYFONT.BASEFONT )       )
                +'>='+%char(%int(len  ))+' dots');
             mydraw+=pdfStrmFillingcolorhtml('red');
             MyDraw+=PdfDrawAddRectangle(
                PdfTextCol:PdfTextRow:len:samplesize-5);
             mydraw+=PdfDrawClosePath(pdf_fill );
             MyText+=PdfTextNewLine();
E02       endfor;

          //?close page
          MyText+=PdfTextClose();
          MyDraw+=PdfStrmRestoreGraphicState();


          mystream=mydraw+mytext;
          //?mystream=mytext;
          MyContent = PdfLoadContent(myStream);//?auto-close
          PdfPageContent (myContent );
          PdfClosePage( );
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
