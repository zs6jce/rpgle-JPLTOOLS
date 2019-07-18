     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define BMP
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     D IfsName         s            512a   varying
     d                                     inz('/home/lamontre/FirstBmp.Bmp')
     D MyColor         ds                  likeds(BmpPixel)
      // constantes : max 1024 cars donc 32*32
     d bmp_arial       ds
     D A               C                   CONST('-
     D                                     01345678901234567890123456789012-
     D                                     02345678901234567890123456789012-
     D                                     03345678901234567890123456789012-
     D                                     04345678901234567890123456789012-
     D                                     05345678901234567890123456789012-
     D                                     06345678901234567890123456789012-
     D                                     07345678901234567890123456789012-
     D                                     08345678901234567890123456789012-
     D                                     09345678901234567890123456789012-
     D                                     10345678901234567890123456789012-
     D                                     11345678901234567890123456789012-
     D                                     12345678901234567890123456789012-
     D                                     13345678901234567890123456789012-
     D                                     14345678901234567890123456789012-
     D                                     15345678901234567890123456789012-
     D                                     16345678901234567890123456789012-
     D                                     17345678901234567890123456789012-
     D                                     18345678901234567890123456789012-
     D                                     19345678901234567890123456789012-
     D                                     20345678901234567890123456789012-
     D                                     21345678901234567890123456789012-
     D                                     22345678901234567890123456789012-
     D                                     23345678901234567890123456789012-
     D                                     24345678901234567890123456789012-
     D                                     25345678901234567890123456789012-
     D                                     26345678901234567890123456789012-
     D                                     27345678901234567890123456789012-
     D                                     28345678901234567890123456789012-
     D                                     29345678901234567890123456789012-
     D                                     30345678901234567890123456789012-
     D                                     31345678901234567890123456789012-
     D                                     32345678901234567890123456789012')







      /free
       //?this tool is architectured to build one bmp at a time
       //?destroy if exist then create a file
       BmpNewFile(Ifsname:250:200);
       bmptranslate(50: 50);
       BmpScale(1:0,5);
       bmpsavegraphicstate();
       bmprotate   ( 30   );
       bmpskew     ( 15:15);
       //?bitmap dims are 250 * 200. So, Pixel address is 0-249 * 0-199
       MyColor = BmpRGB(255:127:63);
       BmpRectangle(2:4:20:10: MyColor);
       BmpRectangle(20:0:10:10: bmpColor(bmpnamedcolor.Yellow));
       BmpLine(10:20:50:100:5:bmpColor(bmpnamedcolor.red));
       BmpLine(100:100:200:100:1:bmpColor(bmpnamedcolor.gainsboro ));
       BmpLine(100:100:200:200:2:bmpColor(bmpnamedcolor.azure ));
       BmpLine(100:100:100:300:3:bmpColor(bmpnamedcolor.red ));
       BmpLine(100:100:000:200:4:bmpColor(bmpnamedcolor.magenta ));
       BmpLine(100:100:000:100:5:bmpColor(bmpnamedcolor.orange ));
       BmpLine(100:100:000:000:6:bmpColor(bmpnamedcolor.salmon ));
       BmpLine(100:100:100:000:7:bmpColor(bmpnamedcolor.oldgold ));
       BmpLine(100:100:200:000:8:bmpColor(bmpnamedcolor.pink ));
       bmpdot(000:000:1:bmpColor(bmpnamedcolor.black ));
       bmpdot(249:199:1:bmpColor(bmpnamedcolor.black ));
       bmpdot(000:199:1:bmpColor(bmpnamedcolor.black ));
       bmpdot(249:000:1:bmpColor(bmpnamedcolor.black ));
       BmpEllipse(050:050:020:100:1:bmpColor(bmpnamedcolor.green ));
       BmpEllipse(249:199:000:000:3:bmpColor(bmpnamedcolor.green ));
       bmprestoregraphicstate();
       BmpRectangle(040:150:050:050:  bmpColor(bmpnamedcolor.Yellow));
       BmpEllipse  (040:150:040:051:1:bmpColor(bmpnamedcolor.green ));
       BmpRectangle(050:150:150:160:  bmpColor(bmpnamedcolor.Yellow));
       BmpEllipse  (050:150:150:151:1:bmpColor(bmpnamedcolor.green ));
       bmprestoregraphicstate();
       BmpRectangle(020:050:150:100:  bmpColor(bmpnamedcolor.LightPurple));
       BmpLine(050:050:020:100:1:bmpColor(bmpnamedcolor.cyan      ));
       BmpLine(100:050:150:070:1:bmpColor(bmpnamedcolor.cyan      ));
       BmpBezier (050:050:020:100:150:070:100:050
                        :2:bmpColor(bmpnamedcolor.navy));
       BmpCloseFile();
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
