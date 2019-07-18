      /if defined(DATA_SECTION)
     D bmpFileHandle   s             10i 0
     D bmpBytesCount   S             10i 0
     d BmpBuffer       s          65000    varying
     d bmpBuffLen      s             10i 0 inz(%size(bmpBuffer))
     D bmpFile         ds                  qualified
     d    filename                  512
    ?d*   bfType = 'BM'               2a
     d    bfSize                     10u00
    ?d*   bfOffBits = 54             10u00
    ?d*   biSize = 40                10u00
     d    biWidth                    10u00
     d    biHeight                   10u00
    ?d*   biPlanes = 0                5u00
    ?d*   biBitCount = 24             5u00
    ?d*   biCompression = 0          10u00
    ?d*   biSizeImage = 0            10u00
    ?d*   biXPelsPerMeter = 0        10u00
    ?d*   biYPelsPerMeter = 0        10u00
    ?d*   biClrUsed = 0              10u00
    ?d*   biClrImportant = 0         10u00
     d    PixelP                       *
     d    Cm                               likeds(BmpConvMatrix)
     d                                     dim(20)
     d    CmCount                     3u00
     d bmpPixel        ds                  based(BmpPixelP)
     d                                     qualified
     d    blue                        3u00
     d    green                       3u00
     d    red                         3u00
     d bmpConvMatrix   ds
     d                                     qualified
     d    a                           8f
     d    b                           8f
     d    c                           8f
     d    d                           8f
     d    e                           8f
     d    f                           8f
     d    save                         n

     d bmpColor        pr                  likeds(BmpPixel)
     d    Named                       3
     d bmpNamedColor   ds                  qualified
     D black...
     d                                3    inz(x'000000')
     D navy...
     d                                3    inz(x'000080')
     D blue...
     d                                3    inz(x'0000FF')
     D darkgreen...
     d                                3    inz(x'003300')
     D darkblue...
     d                                3    inz(x'003366')
     D mediumblue...
     d                                3    inz(x'0066CC')
     D forestgreen...
     d                                3    inz(x'008000')
     D darkseagreen...
     d                                3    inz(x'008080')
     D darkcyan...
     d                                3    inz(x'00CCFF')
     D green...
     d                                3    inz(x'00FF00')
     D cyan...
     d                                3    inz(x'00FFFF')
     D maroon...
     d                                3    inz(x'333300')
     D darkgrey...
     d                                3    inz(x'333333')
     D lightnavy...
     d                                3    inz(x'333399')
     D lightblue...
     d                                3    inz(x'3366FF')
     D seagreen...
     d                                3    inz(x'339966')
     D lightcyan...
     d                                3    inz(x'33CCCC')
     D violet...
     d                                3    inz(x'660066')
     D blueviolet...
     d                                3    inz(x'666699')
     D darkred...
     d                                3    inz(x'800000')
     D purple...
     d                                3    inz(x'800080')
     D khaki...
     d                                3    inz(x'808000')
     D grey...
     d                                3    inz(x'808080')
     D lightgrey...
     d                                3    inz(x'969696')
     D firebrick...
     d                                3    inz(x'993300')
     D orchid...
     d                                3    inz(x'993366')
     D lightblueviolet...
     d                                3    inz(x'9999FF')
     D greenyellow...
     d                                3    inz(x'99CC00')
     D skyblue...
     d                                3    inz(x'99CCFF')
     D azuregrey...
     d                                3    inz(x'C0C0C0')
     D lightpurple...
     d                                3    inz(x'CC99FF')
     D thistle...
     d                                3    inz(x'CCCCFF')
     D gainsboro...
     d                                3    inz(x'CCFFCC')
     D azure...
     d                                3    inz(x'CCFFFF')
     D red...
     d                                3    inz(x'FF0000')
     D magenta...
     d                                3    inz(x'FF00FF')
     D orange...
     d                                3    inz(x'FF6600')
     D salmon...
     d                                3    inz(x'FF8080')
     D oldgold...
     d                                3    inz(x'FF9900')
     D pink...
     d                                3    inz(x'FF99CC')
     D gold...
     d                                3    inz(x'FFCC00')
     D wheat...
     d                                3    inz(x'FFCC99')
     D yellow...
     d                                3    inz(x'FFFF00')
     D cornsilk...
     d                                3    inz(x'FFFF99')
     D snow...
     d                                3    inz(x'FFFFCC')
     D white...
     d                                3    inz(x'FFFFFF')

     d bmpRGB          pr                  likeds(BmpPixel)
     d    red                         3u00 const
     d    green                       3u00 const
     d    blue                        3u00 const
     d bmpRectangle    pr
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
    ?d****width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d bmpEllipse      pr
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d bmpBezier       pr
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
     d    x3                         10i00 const
     d    y3                         10i00 const
     d    x4                         10i00 const
     d    y4                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d bmpDot          pr
     d    x                          10i00 const
     d    y                          10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d bmpLine         pr
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const

     D bmpCloseFile    pr
    ?D*bmpCloseFilev0  pr
     d bmpNewFile      pr
     D  FileName                    512a   varying const
     D  Width                        10u00         const
     D  Height                       10u00         const
     D BmpOpen         pr
     D  FileName                    512a   varying const
     D BmpWrite        pr
     D  data                         10    const varying
     d BinWin4         pr             4
     d  B4                           10u 0 const
     d BmpRestoreGraphicState...
     d                 pr
     d BmpRotate...
     d                 pr
     d alpha                          5i 0 value
     d BmpSaveGraphicState...
     d                 pr
     d BmpScale...
     d                 pr
     d x                              7p 2 value
     d y                              7p 2 value
     d BmpSkew...
     d                 pr
     d alpha                          5i 0 value
     d beta                           5i 0 value
     d BmpTranslate...
     d                 pr
     d x                              5i 0 value
     d y                              5i 0 value
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  P bmpNewFile      b
     d bmpNewFile      pi
     D  FileName                    512a   varying const
     D  Width                        10u00         const
     D  Height                       10u00         const
     D  W              s             10u00
     D  H              s             10u00
      /free
       bmpBuffLen-=10;
       clear bmpFile ;
       bmpFile.FileName = FileName;
       bmpFile.biwidth = width ;
       //?bmpclosefile V2 : line length is limited to 65000 ie 65000/3 pixels
       //?20000 pixels = 233 inch = 593 cm !
B01    if bmpfile.biwidth > 20000;
          bmpfile.biwidth = 20000;
E01    endif;
       bmpFile.biheight = height ;
       bmpfile.pixelp = %alloc(bmpFile.biwidth*bmpfile.biheight*3);
m      //? mise à blanc de l'image (red=green=blue=255)
B01    for h = 0 to bmpfile.biheight-1;
B02       for w = 0 to bmpfile.biwidth-1;
             BmpPixelP = Bmpfile.PixelP +
                (h * bmpfile.biwidth + w ) * 3;
             BmpPixel.red = 255;
             BmpPixel.green = 255;
             BmpPixel.blue = 255;
E02       endfor;
E01    endfor;
       bmpOpen(FileName);
       bmpBytesCount=0;
       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR  P bmpCloseFile    b
     d bmpCloseFile    pi
     d x10             ds
     d  n10                          10s 0
     D WriteData       s          65535
     D WriteLen        s             10i 0
     d lineLen         s             10i 0                                      line length
     d lineAdj         s             10i 0                                      lane adjustment
     d line            s             10i 0
     d pixel           s             10i 0
     d rc              s             10i 0



      /free
       //?linelen : width * 3 rounded to multiple of 4
       linelen = BmpFile.biwidth * 3;//?    93=31*3
       lineadj = %rem(linelen:4);//?        1=rem(93/4)
       linelen = linelen / 4;//?             23=93/4
B01    if lineadj <> 0;
          linelen+=1;//?                    24
          lineadj = 4 - lineadj; //          3   nb x'00' to close a line
E01    endif;
       linelen *=4;//?                      96
       BmpBuffer='';
       //?structure of a BMP 24 bits per color file
       //?sample : the first 120 bytes of a .BMP
       //?424D360600 0000000000 3600000028 0000002000
       //?0000100000 0001001800 0000000000 0600000000
       //?0000000000 0000000000 00000000FF FFFFFFFFFF
       //?
       //?The BITMAP FILEHEADER
       //?start size name stdvalue purpose
       //?1 2   bfType 19778 must always be set to 'BM' to declare that this is a .bmp-file.
       //?             424D = 'BM' = 4d42h = 19778d
       bmpBuffer = x'424D'+
       //?3 4   bfSize ?? specifies the size of the file in bytes.
       //?             360600 00 = 00000636h = 1590d
       //?
          BinWin4(linelen * bmpfile.biheight + 54)+
       //?7 2   bfReserved1 0 must always be set to zero.
       //?             0000
          x'0000'+
       //?9 2   bfReserved2 0 must always be set to zero.
       //?             0000
          x'0000'+
       //?11 4  bfOffBits 1078 specifies the offset from the beginning of the file to the bitmap
       //?data.
       //?             36000000 = 00000036h = 54
          x'36000000'+
       //?
       //?The BITMAP INFOHEADER:
       //?start size name stdvalue purpose
       //?15 4  biSize 40 specifies the size of the BITMAPINFOHEADER structure, in bytes.
       //?             28000000 = 00000028h = 40d
          x'28000000'+
       //?19 4  biWidth 100 specifies the width of the image, in pixels.
       //?             20000000 = 00000020 = 32d
          BinWin4(bmpfile.biwidth )+
       //?23 4  biHeight 100 specifies the height of the image, in pixels.
       //?             10000000 = 00000010 = 16d
          BinWin4(bmpfile.biheight )+
       //?27 2  biPlanes 1 specifies the number of planes of the target device, must be set to zero
       //?             0100 = 0001
          x'0100'+
       //?29 2  biBitCount 8 specifies the number of bits per pixel.
       //?             1800= 0018h = 24d
          x'1800'+
       //?31 4  biCompression 0 Specifies the type of compression, usually set to zero (no
       //?             compression).
       //?             00000000
          x'00000000'+
       //?35 4  biSizeImage 0 specifies the size of the image data, in bytes. If there is no
       //?             compression, it is valid to set this member to zero.
       //?             00060000 = 00000600h = 1536d
       //?             ! embedded alignment bytes are counted
          BinWin4(linelen * bmpfile.biheight )+
       //?39 4  biXPelsPerMeter 0 specifies the the horizontal pixels per meter on the designated
       //?             targer device, usually set to zero.
       //?             00000000
          x'00000000'+
       //?43 4  biYPelsPerMeter 0 specifies the the vertical pixels per meter on the designated
       //?             targer device, usually set to zero.
       //?             00000000
          x'00000000'+
       //?47 4  biClrUsed 0 specifies the number of colors used in the bitmap, if set to zero the
       //?             number of colors is calculated using the biBitCount member.
       //?             00000000
          x'00000000'+
       //?51 4  biClrImportant 0 specifies the number of color that are 'important' for the bitmap,
       //?             if set to zero, all colors are important.
       //?             00000000
          x'00000000';
       WriteLen=%len(BmpBuffer);
       writedata = BmpBuffer ;//?remove varlen (the first 2 chars)
       rc = write(BmpFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;
       //?extraire les pixels
       //?parcourir les lignes
       //?line len is a multiple of 4 bytes
       //?line len = line width upper rounded to 4 bytes
B01    for Line = bmpfile.biheight-1 downto 0;
          bmpBuffer='';
          //?parcourir les pixel
B02       for pixel = 0 to bmpfile.biwidth-1 ;
             //?extraire les couleurs
B03          BmpPixelP = BmpFile.PixelP +
                (line * bmpfile.biwidth * 3) +
                (Pixel * 3) ;
             BmpBuffer+=BmpPixel;
E02       endfor;
B02       if lineadj > 0;
B03          for pixel = 1 to LineAdj;
                BmpBuffer+=x'00';
E03          endfor;
E02       endif ;
          //?flush the buffer
          WriteLen=%len(BmpBuffer);
          writedata = BmpBuffer ;//?remove varlen (the first 2 chars)
          rc = write(BmpFileHandle : WriteData : WriteLEN ) ;
B02       if rc = -1;
             escerrno(errno);
E02       endif;
E01    endfor;
       Rc = close(bmpFileHandle) ;
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       return;
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? * there is a very big issue in ILE : run time is directly depending
    ? * on size of data in called procedure.
    ? * here, when was using bmpclosefilev0 + bmpwrite, exporting data to
    ? * the IFS file was very long.
    ? * after rewriting (ie incorporating bmpwrite into bmpclosefile)
    ? * run time is divided by 100 approx.
    ? * the issue is in local data for bmpwrite : they must be allocated
    ? * then deallocated for each run.
    ? * I have not tested if globalizing these data will solve the issue.
    ? *P bmpCloseFilev0  b
    ? *d bmpCloseFilev0  pi
    ? *d x10             ds
    ? *d  n10                          10s 0
    ? *D WriteData       s          65535
    ? *D WriteLen        s             10i 0
    ? *d lineLen         s             10i 0                                      line length
    ? *d lineAdj         s             10i 0                                      lane adjustment
    ? *d line            s             10i 0
    ? *d pixel           s             10i 0
    ? *d rc              s             10i 0
    ? * /free
    ? *  //?linelen : width * 3 rounded to multiple of 4
    ? *  linelen = BmpFile.biwidth * 3;//?    93=31*3
    ? *  lineadj = %rem(linelen:4);//?        1=rem(93/4)
    ? *  linelen = linelen / 4;//?             23=93/4
    ? *  if lineadj <> 0;
    ? *     linelen+=1;//?                    24
    ? *     lineadj = 4 - lineadj; //          3   nb x'00' to close a line
    ? *  endif;
    ? *  linelen *=4;//?                      96
    ? *  //?structure of a BMP 24 bits per color file
    ? *  //?sample : the first 120 bytes of a .BMP
    ? *  //?424D360600 0000000000 3600000028 0000002000
    ? *  //?0000100000 0001001800 0000000000 0600000000
    ? *  //?0000000000 0000000000 00000000FF FFFFFFFFFF
    ? *  //?
    ? *  //?The BITMAP FILEHEADER
    ? *  //?start size name stdvalue purpose
    ? *  //?1 2   bfType 19778 must always be set to 'BM' to declare that this is a .bmp-file.
    ? *  //?             424D = 'BM' = 4d42h = 19778d
    ? *  bmpwrite(x'424D');
    ? *  //?3 4   bfSize ?? specifies the size of the file in bytes.
    ? *  //?             360600 00 = 00000636h = 1590d
    ? *  //?
    ? *  bmpwrite(BinWin4(linelen * bmpfile.biheight + 54));
    ? *  //?7 2   bfReserved1 0 must always be set to zero.
    ? *  //?             0000
    ? *  bmpwrite(x'0000');
    ? *  //?9 2   bfReserved2 0 must always be set to zero.
    ? *  //?             0000
    ? *  bmpwrite(x'0000');
    ? *  //?11 4  bfOffBits 1078 specifies the offset from the beginning of the file to the bitmap
    ? *  //?data.
    ? *  //?             36000000 = 00000036h = 54
    ? *  bmpwrite(x'36000000');
    ? *  //?
    ? *  //?The BITMAP INFOHEADER:
    ? *  //?start size name stdvalue purpose
    ? *  //?15 4  biSize 40 specifies the size of the BITMAPINFOHEADER structure, in bytes.
    ? *  //?             28000000 = 00000028h = 40d
    ? *  bmpwrite(x'28000000');
    ? *  //?19 4  biWidth 100 specifies the width of the image, in pixels.
    ? *  //?             20000000 = 00000020 = 32d
    ? *  bmpwrite(BinWin4(bmpfile.biwidth ));
    ? *  //?23 4  biHeight 100 specifies the height of the image, in pixels.
    ? *  //?             10000000 = 00000010 = 16d
    ? *  bmpwrite(BinWin4(bmpfile.biheight ));
    ? * //?27 2  biPlanes 1 specifies the number of planes of the target device, must be set to zero
    ? *  //?             0100 = 0001
    ? *  bmpwrite(x'0100');
    ? *  //?29 2  biBitCount 8 specifies the number of bits per pixel.
    ? *  //?             1800= 0018h = 24d
    ? *  bmpwrite(x'1800');
    ? *  //?31 4  biCompression 0 Specifies the type of compression, usually set to zero (no
    ? *  //?             compression).
    ? *  //?             00000000
    ? *  bmpwrite(x'00000000');
    ? *  //?35 4  biSizeImage 0 specifies the size of the image data, in bytes. If there is no
    ? *  //?             compression, it is valid to set this member to zero.
    ? *  //?             00060000 = 00000600h = 1536d
    ? *  //?             ! embedded alignment bytes are counted
    ? *  bmpwrite(BinWin4(linelen * bmpfile.biheight ));
    ? *  //?39 4  biXPelsPerMeter 0 specifies the the horizontal pixels per meter on the designated
    ? *  //?             targer device, usually set to zero.
    ? *  //?             00000000
    ? *  bmpwrite(x'00000000');
    ? *  //?43 4  biYPelsPerMeter 0 specifies the the vertical pixels per meter on the designated
    ? *  //?             targer device, usually set to zero.
    ? *  //?             00000000
    ? *  bmpwrite(x'00000000');
    ? *  //?47 4  biClrUsed 0 specifies the number of colors used in the bitmap, if set to zero the
    ? *  //?             number of colors is calculated using the biBitCount member.
    ? *  //?             00000000
    ? *  bmpwrite(x'00000000');
    ? * //?51 4  biClrImportant 0 specifies the number of color that are 'important' for the bitmap,
    ? *  //?             if set to zero, all colors are important.
    ? *  //?             00000000
    ? *  bmpwrite(x'00000000');
    ? *  //?extraire les pixels
    ? *  //?parcourir les lignes
    ? *  //?line len is a multiple of 4 bytes
    ? *  //?line len = line width upper rounded to 4 bytes
    ? *  for Line = bmpfile.biheight-1 downto 0;
    ? *     //?parcourir les pixel
    ? *     for pixel = 0 to bmpfile.biwidth-1 ;
    ? *        //?extraire les couleurs
    ? *        BmpPixelP = BmpFile.PixelP +
    ? *           (line * bmpfile.biwidth * 3) +
    ? *           (Pixel * 3) ;
    ? *        BmpWrite(BmpPixel);
    ? *     endfor;
    ? *     if lineadj > 0;
    ? *        for pixel = 1 to LineAdj;
    ? *           BmpWrite(x'00');
    ? *        endfor;
    ? *     endif ;
    ? *  endfor;
    ? *  //?flush the buffer
    ? *  WriteLen=%len(BmpBuffer);
    ? *  writedata = BmpBuffer ;//?remove varlen (the first 2 chars)
    ? *  rc = write(BmpFileHandle : WriteData : WriteLEN ) ;
    ? *  if rc = -1;
    ? *     escerrno(errno);
    ? *  endif;
    ? *  Rc = close(bmpFileHandle) ;
    ? *  if rc <> 0;
    ? *     if errno <> 3025;
    ? *        escerrno(errno);
    ? *     endif;
    ? *  endif;
    ? *  return;
    ? *  begsr *pssr;
    ? *  dump;
    ? *  endsr;
    ? */end-free
    ? *P                 e
    ? *=---------------------------------------------------------------=*
    ? *P BmpWrite        b
    ? *D BmpWrite        pi
    ? *D  data                         10    const varying
    ? *D WriteData       s          65535
    ? *D WriteLen        s             10i 0
    ? *D RC              S             10i 0
    ? * /free
    ? *  WriteLen=%len(data );
    ? *  BmpBytesCount+=WriteLen;
    ? *  //?buffer not full ? add to buffer
    ? *  if writelen + %len(BmpBuffer) < BmpBuffLen;
    ? *     BmpBuffer += data;
    ? *     return;
    ? *  endif;
    ? *  //?flush the buffer
    ? *  WriteLen=%len(BmpBuffer);
    ? *  writedata = BmpBuffer ;//?remove varlen (the first 2 chars)
    ? *  rc = write(BmpFileHandle : WriteData : WriteLEN ) ;
    ? *  if rc = -1;
    ? *     escerrno(errno);
    ? *  endif;
    ? *  //?load data to the buffer
    ? *  BmpBuffer = Data;
    ? *  return;
    ? *  begsr *pssr;
    ? *  dump;
    ? *  endsr;
    ? */end-free
    ? *P BmpWrite        e
    ? *=---------------------------------------------------------------=*
BPR  P bmpOpen         b
     D bmpOpen         pi
     D  FileName                    512a   varying const
     d rc              s             10i 0
      /free
       //?delete the file
       rc= unlink (FileName );
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       //?create a file & declare implicit code page converter
       bmpFileHandle = open(FileName
          : O_CREAT + O_WRONLY + O_TRUNC + O_CODEPAGE
          : S_IRWXU + S_IROTH
          : CP_ISO8859_1 ) ;
B01    if bmpFileHandle = -1;
          escerrno(errno);
E01    endif;
       return;
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?p BinWin4         b
     d BinWin4         pi             4
     d  B4                           10u 0 const
     d bytes           ds
     d  byte                          1    dim(4)
     d  x4                            4    overlay(bytes)
     d bin4            ds
     d  bin                           1    dim(4)
     d  value                        10i 0 overlay(bin4)
    ? /free
       value = b4;
       byte(4) = bin(1) ;
       byte(3) = bin(2) ;
       byte(2) = bin(3) ;
       byte(1) = bin(4) ;
       return x4 ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpRGB          b
     d bmpRGB          pi                  likeds(BmpPixel)
     d    red                         3u00 const
     d    green                       3u00 const
     d    blue                        3u00 const
     d aColor          ds                  likeds(BmpPixel)
      /free
       acolor.red = red;
       acolor.green = green;
       acolor.blue = blue;
       return aColor;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpLine         b
     d bmpLine         pi
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d  xlen           s             10i00
     d  ylen           s             10i00
     d  xstep          s             10p05
     d  ystep          s             10p05
     d  loopcount      s             10i00
     d  x              s             10p05
     d  y              s             10p05
     d  xw             s             10p05
     d  yw             s             10p05
     d  again          s               n
      /free
B01    if x1 = x2 and y1 = y2;
          bmpDot (x1 : y1 :width: acolor);
          return;
E01    endif;
       xlen = %abs(%int(x2) - x1);
       ylen = %abs(%int(y2) - y1);
       //?avoid loosing pixels when y progression is too quick
       //?if y progress is lowed than x, then xstep is 1, then ystep < 1
       //?if y progress is higher than x, then xstep < 1 enought to ystep = 1
B01    if ylen > xlen;
          xstep = (%int(x2) - x1)/%abs(%int(y2) - y1);
B02       if y2 > y1;
             ystep = 1;
X02       else;
             ystep = -1;
E02       endif;
          loopcount=ylen;
X01    else;
B02       if x2 > x1;
             xstep = 1;
X02       else;
             xstep = -1;
E02       endif;
          ystep = (%int(y2) - y1)/%abs(%int(x2) - x1);
          loopcount=xlen;
E01    endif;
       again = true;
       x = x1;
       y = y1;
B01    dow again;
          bmpDot (x : y : width :aColor);
          x+=xstep;
          y+=ystep;
          loopcount-=1;
          again = (loopcount >= 0);
E01    enddo;
       return;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpRectangle    b
     d bmpRectangle    pi
     d    xa                         10i00 const
     d    ya                         10i00 const
     d    xb                         10i00 const
     d    yb                         10i00 const
    ?d****width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d    x1           s             10i00
     d    y1           s             10i00
     d    x2           s             10i00
     d    y2           s             10i00
     d x               s             10i00
     d y               s             10i00
      /free
B01    if xa < xb;
          x1 = xa;
          x2 = xb;
X01    else;
          x1=xb;
          x2=xa;
E01    endif;
B01    if ya < yb;
          y1 = ya;
          y2 = yb;
X01    else;
          y1=yb;
          y2=ya;
E01    endif;
B01    for y = y1 to y2;
B02       for x = x1 to x2;
             BmpDot (x : y : 1 : acolor);
E02       endfor;
E01    endfor;


B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpEllipse      b
     d bmpEllipse      pi
     d    xa                         10i00 const
     d    ya                         10i00 const
     d    xb                         10i00 const
     d    yb                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d    x0           s             10i00
     d    y0           s             10i00
     d    xstep        s             10p05
     d    loopcount    s             10i00
     d    again        s               n
     d x               s             10p05
     d y               s             10p05
       //?ellipse : (x^2/a^2)+(y^2/b^2)=1
       //?soit y=b*(1-(x^2/a^2))^0.5
       //?parameters are the outside rectangle
     d a               s             10p05
     d b               s             10p05
     d f1              s              8f
      /free
       //?avoid limits (a or b = 0)
B01    if xa = xb or ya = yb;
          bmpline(xa:ya:xb:yb:width:acolor);
          return;
E01    endif;






       a = (%int(xb) - xa)/2;
       b = (%int(yb) - ya)/2;
       x0 = xa + a;
       y0 = ya + b;
       a = %abs(a);
       b = %abs(b);
B01    if xa < xb;
          xstep = 0,5;
X01    else;
          xstep= -0,5;
E01    endif;
B01    if b > a;
          xstep = a / b *xstep;
E01    endif;
       loopcount = %abs(a / xstep);


       again=true;
       x = 0;
B01    dow again ;

B02       if x >= a;
             y=0;
X02       else;
             f1 = %sqrt(1 - %float((x*x) /( a*a)));
             y = b * f1;
E02       endif;
B02
          bmpDot(x0+x :y0+y : width : acolor);
          bmpDot(x0-x :y0+y : width : acolor);
          bmpDot(x0+x :y0-y : width : acolor);
          bmpDot(x0-x :y0-y : width : acolor);
E02
B02       if x > a + 0,5;
             again=false;
E02       endif;
          x+=(f1/2);
E01    enddo;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpDot          b
     d bmpDot          pi
     d    x                          10i00 const
     d    y                          10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const



     d  xw             s             10i00
     d  yw             s             10i00
     d  cm             ds                  likeds(bmpconvmatrix)
     d  xt1            s              8f
     d  yt1            s              8f
     d  xt2            s              8f
     d  yt2            s              8f
     d  xc             s             10i00
     d  yc             s             10i00

      /free




       xw = x ;
B01    dow xw < x + width ;
          yw = y;
B02       dow yw < y + width ;
             //?translation rules
             xc = xw ;
             yc = yw ;
B03          if bmpfile.cmcount > 0;
                xt1 = xw;
                yt1 = yw;
B04             for iFor = bmpfile.cmcount downto 1;
                   //?                [a b 0]
                   //?[x'y'1]=[x y 1]*[c d 0]
                   //?                [e f 1]
                   //?ie
                   //?x' = a*x+c*y+e
                   //?y' = b*x+d*y+f
                   cm = bmpfile.cm(iFor);
                   xt2 = cm.a*xt1+cm.c*yt1+cm.e;
                   yt2 = cm.b*xt1+cm.d*yt1+cm.f;
                   xt1 = xt2;
                   yt1 = yt2;
E04             endfor;
                xc = xt1;
                yc = yt1;
E03          endif;
             //?add the dot to the bitmap
B03          if 0 <= xc and xc < bmpfile.biwidth;
B04             if 0 <= yc and yc < bmpfile.biheight;
                   BmpPixelP = Bmpfile.PixelP +
                      (yc * bmpfile.biwidth + xc ) * 3;
                   BmpPixel.red = acolor.red;
                   BmpPixel.green = acolor.green;
                   BmpPixel.blue = acolor.blue;
E04             endif;
E03          endif;
             yw+=1;
E02       enddo ;
          xw+=1;
E01    enddo ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p bmpColor        b
     d bmpColor        pi                  likeds(BmpPixel)
     d    Named                       3
     d Color           ds
     d    red                         3u00
     d    green                       3u00
     d    blue                        3u00
     d aColor          ds                  likeds(BmpPixel)
      /free
       Color = Named;
       acolor.red = red;
       acolor.green = green;
       acolor.blue = blue;
       return aColor;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpRestoreGraphicState...
BPR  p                 b
     d BmpRestoreGraphicState...
     d                 pi
      /free
B01    for iFor = bmpfile.cmcount downto 1;
B02       if bmpfile.cm(iFor).save = true;
             bmpfile.cmcount = iFor;
             bmpfile.cm(iFor).save = false;
             return;
E02       endif;
E01    endfor;
       bmpfile.cmcount = 0 ;
       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpRotate...
BPR  p                 b
     d BmpRotate...
     d                 pi
     d alpha                          5i 0 value
     d cos             s              8f
     d sin             s              8f



    ? *Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle counterclockwise.
      /free
       cos = c_cos (c_pi * alpha / 180);
       sin = c_sin (c_pi * alpha / 180);
B01    if bmpfile.cmcount < 20;
          bmpfile.cmcount+=1;
          bmpfile.cm(bmpfile.cmcount).a = cos;
          bmpfile.cm(bmpfile.cmcount).b = sin;
          bmpfile.cm(bmpfile.cmcount).c =-sin;
          bmpfile.cm(bmpfile.cmcount).d = cos;
          bmpfile.cm(bmpfile.cmcount).e = 0 ;
          bmpfile.cm(bmpfile.cmcount).f = 0 ;
E01    endif;
       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpSaveGraphicState...
BPR  p                 b
     d BmpSaveGraphicState...
     d                 pi
      /free
B01    if bmpfile.cmcount > 0;
          bmpfile.cm(bmpfile.cmcount).save = true;
E01    endif;
       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpScale...
BPR  p                 b
     d BmpScale...
     d                 pi
     d x                              7p 2 value
     d y                              7p 2 value
    ? *Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit
      /free
B01    if bmpfile.cmcount < 20;
          bmpfile.cmcount+=1;
          bmpfile.cm(bmpfile.cmcount).a = x ;
          bmpfile.cm(bmpfile.cmcount).b = 0 ;
          bmpfile.cm(bmpfile.cmcount).c = 0 ;
          bmpfile.cm(bmpfile.cmcount).d = y ;
          bmpfile.cm(bmpfile.cmcount).e = 0 ;
          bmpfile.cm(bmpfile.cmcount).f = 0 ;
E01    endif;
       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpSkew...
BPR  p                 b
     d BmpSkew...
     d                 pi
     d alpha                          5i 0 value
     d beta                           5i 0 value
     d tanA            s              8f
     d tanB            s              8f



    ? *Angle en radian = pi * (angle en degré) / 180
    ? *Skew is specified by : 1 tana tanß 1 0 0 cm ; a = angle x ß = angle y
      /free
       tanA = c_tan (c_pi * alpha / 180);
       tanB = c_tan (c_pi * beta / 180);




B01    if bmpfile.cmcount < 20;
          bmpfile.cmcount+=1;
          bmpfile.cm(bmpfile.cmcount).a = 1 ;
          bmpfile.cm(bmpfile.cmcount).b =tana;
          bmpfile.cm(bmpfile.cmcount).c =tanB;
          bmpfile.cm(bmpfile.cmcount).d = 1 ;
          bmpfile.cm(bmpfile.cmcount).e = 0 ;
          bmpfile.cm(bmpfile.cmcount).f = 0 ;
E01    endif;

       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
     p BmpTranslate...
BPR  p                 b
     d BmpTranslate...
     d                 pi
     d x                              5i 0 value
     d y                              5i 0 value

    ? *translation : tx ty m ou 1 0 0 1 tx ty cm
      /free

B01    if bmpfile.cmcount < 20;
          bmpfile.cmcount+=1;
          bmpfile.cm(bmpfile.cmcount).a = 1 ;
          bmpfile.cm(bmpfile.cmcount).b = 0 ;
          bmpfile.cm(bmpfile.cmcount).c = 0 ;
          bmpfile.cm(bmpfile.cmcount).d = 1 ;
          bmpfile.cm(bmpfile.cmcount).e = x ;
          bmpfile.cm(bmpfile.cmcount).f = y ;
E01    endif;



       return ;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
BPR  p bmpBezier       b
     d bmpBezier       pi
     d    x1                         10i00 const
     d    y1                         10i00 const
     d    x2                         10i00 const
     d    y2                         10i00 const
     d    x3                         10i00 const
     d    y3                         10i00 const
     d    x4                         10i00 const
     d    y4                         10i00 const
     d    width                      10i00 const
     d    aColor                           likeds(BmpPixel) const
     d t               s              4f
     d tstep           s              4f
     d again           s               n
     d Bx              s              4f
     d By              s              4f
     d xmin            s             10i00
     d xmax            s             10i00
     d ymin            s             10i00
     d ymax            s             10i00
       //?bezier(p1, pc1, pc2, p2) :
       //?pn = (xn, yn)
       //?
       //?pour t variant de 0 à 1,
       //?Bx(t) = (1-t)^3*P1.x + 3*(1-t)^2*t*PC1.x + 3*(1-t)*t^2 PC2.x + t^3*P2.x
       //?By(t) = (1-t)^3*P1.y + 3*(1-t)^2*t*PC1.y + 3*(1-t)*t^2 PC2.y + t^3*P2.y
       //?
       //?Bx et By sont les points de la courbe de bezier.
       //?
      /free
       //?search x & y limits : the outside polygone
       xmin = *hival;
       xmax = *loval;
       ymin = *hival;
       ymax = *loval;
B01    if xmin > x1;
          xmin = x1;
E01    endif;
B01    if xmin > x2;
          xmin = x2;
E01    endif;
B01    if xmin > x3;
          xmin = x3;
E01    endif;
B01    if xmin > x4;
          xmin = x4;
E01    endif;
B01    if xmax < x1;
          xmax = x1;
E01    endif;
B01    if xmax < x2;
          xmax = x2;
E01    endif;
B01    if xmax < x3;
          xmax = x3;
E01    endif;
B01    if xmax < x4;
          xmax = x4;
E01    endif;
B01    if ymin > y1;
          ymin = y1;
E01    endif;
B01    if ymin > y2;
          ymin = y2;
E01    endif;
B01    if ymin > y3;
          ymin = y3;
E01    endif;
B01    if ymin > y4;
          ymin = y4;
E01    endif;
B01    if ymax < y1;
          ymax = y1;
E01    endif;
B01    if ymax < y2;
          ymax = y2;
E01    endif;
B01    if ymax < y3;
          ymax = y3;
E01    endif;
B01    if ymax < y4;
          ymax = y4;
E01    endif;
       tstep =((xmax - xmin ) + (ymax - ymin))/(xmax - xmin)**2;
       t = 0;
       again=true;
B01    dow again ;
B02       if t < 1;
             //?Bx(t) = (1-t)^3*P1.x + 3*(1-t)^2*t*PC1.x + 3*(1-t)*t^2 PC2.x + t^3*P2.x
             Bx=(1-t)**3*x1+3*(1-t)**2*t*x2+3*(1-t)*t**2*x3+t**3*x4;
             //?By(t) = (1-t)^3*P1.y + 3*(1-t)^2*t*PC1.y + 3*(1-t)*t^2 PC2.y + t^3*P2.y
             By=(1-t)**3*y1+3*(1-t)**2*t*y2+3*(1-t)*t**2*y3+t**3*y4;
B02
             bmpDot(Bx :By : width : acolor);
E02
X02       else ;
             again=false;
E02       endif;
          t+=tStep ;
E01    enddo;
B00    begsr *pssr;
       dump;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
      /endif
