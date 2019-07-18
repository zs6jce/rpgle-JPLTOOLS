    ? *=------------------------------------------------------------------------------------------=*
    ? *
    ? *  If you need to change anything in this code, feed back !
    ? *  so, I will take care of the update in next version
    ? *
    ? *=------------------------------------------------------------------------------------------=*
BPR ?p PdfDrawImage    b                   export
     d PdfDrawImage    pi                  like(pdfs1)
     d theImage                            likeds(pdfImage) const
     d x                              5i 0 value
     d y                              5i 0 value
     d thezoom                        5p 4 value options(*nopass)
     d VerticalZoom                   5p 4 value options(*nopass)
     d zoom            s              5p 2       static
     d zoomV           s              5p 4       static
     d zoomH           s              8f         static
     d zoomW           s              8f         static
     d Draw            s                   like(pdfs1)
      /free
B01    If %Parms >=4;
          zoom=thezoom;
X01    Else ;
          zoom=1;
E01    Endif;
B01    If %Parms >=5;
          zoomV=VerticalZoom;
X01    Else ;
          zoomV=zoom;
E01    Endif;
       Draw = Pdfstrmsavegraphicstate() ;
       Draw+= Pdfstrmtranslate(x:y);
       zoomH = theImage.Height*zoomv;
       zoomW= theImage.Width*zoom ;
       Draw+= Pdfstrmscale(zoomW:zoomH) ;
       Draw+= Latin1(theImage.Name+ ' Do ') ;
       Draw+= Pdfstrmrestoregraphicstate();
       Return Draw;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p WinBin4         b
     d WinBin4         pi            10u 0
     d  x4                            4    value
     d bytes           ds                        static
     d  byte                          1    dim(4)
     d bin4            ds                        static
     d  bin                           1    dim(4)
     d  value                        10i 0 overlay(bin4)
      /free
       bytes = x4;
       bin(1) = byte(4);
       bin(2) = byte(3);
       bin(3) = byte(2);
       bin(4) = byte(1);
       Return value;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p pdfMemBMP24     b
     d pdfMemBMP24     pi                  likeds(PdfImage)
     d anImage                             likeds(PdfImage)
     d TheImage        ds                  likeds(PdfImage)
     d  bmplenobj      s                   like(pdfobj)
      /free
       theImage=anImage;
B01    If theImage.Preloaded = False;
          Message('PDF0013':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       theImage.Filter='/ASCII85Decode';
       theImage.Colorspace='/DeviceRGB';
       theImage.Width = anImage.Width;
       theImage.Height= anImage.Height;
       theImage.Bpc = anImage.Bpc;
       theImage.Obj=Pdfnewobj();
       bmplenobj =Pdfnewobj();
       theImage.Name = '/Bmp'+%Trim( %Editc(theImage.Obj:'P'));
       Pdffile_xref(theImage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.Bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + Pdfwobj(bmplenobj)
          + 'R>> stream' + Crlf);
       Pdfbinwrite(theImage.Stream: 2 );   //?stream est en ebcdic base85
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref(bmplenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj(bmplenobj)+'obj '
          + %Editc(%Len(Myimage):'P') + ' endobj' + Crlf);
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?ppdfPreLoadBMP24  b                   export
     dPdfPreLoadBmp24  pi                  likeds(PdfImage)
     D  FileName                    512a   varying const
     d  TheImage       ds                  likeds(PdfImage)
    ?d*
    ?d* automatic preload of picture mecanism :
    ?d* preload is limited to 64k, output size. with encode85, 64k out = 50k in * 5 / 4
    ?d* preload in one fiels is mandatory to be able to cipher the PDF, if PDF is crypted.
    ?d* so, a picture bigger than 50 k can not be crypted by this version of PDF server.
    ?d* un jour, je saurai utiliser ça:
    ?d* The key context allows encryption or decryption of a message in multiple blocks using
    ?d* multiple calls to CIPHER.
    ?d*
    ?d* user entry points
    ?d*    pdfPreloadBmp24 receive a file name and output a PdfImage DS
    ?d*                    is to be used one time per PDF generator program
    ? *
    ? *    PdfMemLoagBmp24 receive a PdfImage, and get it back updated if necessary
    ? *                    is to be used one time per PDF file
    ? *                    is the proc to be used instead of deprecated PdfLoadBmp24
    ? *
    ? * private entry point
    ? *    BmpReader
    ? *    receive a PdfImage, a bool
    ? *    load the bmp either into the PdfImage or directly to the PdfFile
    ? *
    ?d* load a bitmap, write it under ASCII85decode coding
    ?d*
     D FileHandleA     s             10i 0        static
     d rc              s             10i 0        static
     d myStat          ds                  likeds(statds)
      /free
       //? structure of a BMP 24 bits per color file
       //? sample : the first 120 bytes of a .BMP
       //? 424D360600 0000000000 3600000028 0000002000
       //? 0000100000 0001001800 0000000000 0600000000
       //? 0000000000 0000000000 00000000FF FFFFFFFFFF
       //?
       //? The BITMAP FILEHEADER
       //? start size name stdvalue purpose
       //? 1 2   bfType 19778 must always be set to 'BM' to declare that this is
       //?              424D = 'BM' = 4d42h = 19778d
       //? 3 4   bfSize ?? specifies the size of the file in bytes.
       //?              360600 00 = 00000636h = 1590d
       //? 7 2   bfReserved1 0 must always be set to zero.
       //?              0000
       //? 9 2   bfReserved2 0 must always be set to zero.
       //?              0000
       //? 11 4  bfOffBits 1078 specifies the offset from the beginning of the fi
       //? data.
       //?              36000000 = 00000036h = 54
       //?
       //? The BITMAP INFOHEADER:
       //? start size name stdvalue purpose
       //? 15 4  biSize 40 specifies the size of the BITMAPINFOHEADER structure,
       //?              28000000 = 00000028h = 40d
       //? 19 4  biWidth 100 specifies the width of the image, in pixels.
       //?              20000000 = 00000020 = 32d
       //? 23 4  biHeight 100 specifies the height of the image, in pixels.
       //?              10000000 = 00000010 = 16d
       //? 27 2  biPlanes 1 specifies the number of planes of the target device,
       //?              0100 = 0001
       //? 29 2  biBitCount 8 specifies the number of bits per pixel.
       //?              1800= 0018h = 24d
       //? 31 4  biCompression 0 Specifies the type of compression, usually set t
       //?              compression).
       //?              00000000
       //? 35 4  biSizeImage 0 specifies the size of the image data, in bytes. If
       //?              compression, it is valid to set this member to zero.
       //?              00060000 = 00000600h = 1536d
       //?              ! embedded alignment bytes are counted
       //? 39 4  biXPelsPerMeter 0 specifies the the horizontal pixels per meter
       //?              targer device, usually set to zero.
       //?              00000000
       //? 43 4  biYPelsPerMeter 0 specifies the the vertical pixels per meter on
       //?              targer device, usually set to zero.
       //?              00000000
       //? 47 4  biClrUsed 0 specifies the number of colors used in the bitmap, i
       //?              number of colors is calculated using the biBitCount membe
       //?              00000000
       //? 51 4  biClrImportant 0 specifies the number of color that are 'importa
       //?              if set to zero, all colors are important.
       //?              00000000
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;
       Clear theImage;
       theImage.FileName = FileName;
       theImage.Filter='/ASCII85Decode';
       theImage.Colorspace='/DeviceRGB';
       //?open file, binary mode (no O_TEXTDATA option)
       //?Do I really need to open a file to get stats ? need to investigate later
       FileHandleA= Open( %Trim(FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
E01    Endif;
       rc = Fstat(FileHandleA : myStat);
       rc = Close(FileHandleA) ;
       rc = myStat.St_size * 5 / 4 ;
B01    If rc < %Size(theImage.Stream);
          theImage.Preloadable = True;
X01    Else;
B02       If Pdffile.Encrypted;
             //?un jour, je saurai utiliser ça:
            //?The key context allows encryption or decryption of a message in multiple blocks using
             //?multiple calls to CIPHER.
             //?not cryptable  , too big for 64k stream
             Message('PDF0012':'':'':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
B01    If theImage.Preloadable =False;
          //?will run load from disk each time PdfMemLoad is called
          Return theImage;
E01    Endif;
       Bmpload(theImage : True);   //?load BMP to mem
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?pBmpLoad          b
     dBmpLoad          pi            10i 0
     D TheImage                            likeds(PdfImage)
     d ToMem                           n   const
    ? * updates the stream length outputed (file or ds:TheImage)
     D FileHandleA     s             10i 0        static
     D AsciiData       s          65535           static
     D Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
     d AsciiPos        S             10i 0 inz(0)
     d OffBits         s             10i 0        static
     d rc              s             10i 0        static
     d line            s             10i 0        static
     d linLen          s             10i 0        static
     d Pixlen          s             10i 0        static
     d pixel           s             10i 0        static
     d pixRGB          s             10i 0        static
     d PDF0007         ds                         static
     d  m1                          512    varying
     d PdfData         s                   like(pdfbuffer)   static
     d Pdf85           s                   like(pdfbuffer)   static
     d  i              s              5u 0
     d  bmplen         s             10u 0
     d  bmplenobj      s                   like(pdfobj)
      /free
       //?open file, binary mode (no O_TEXTDATA option)
       FileHandleA= Open( %Trim(theImage.FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       AsciiFrom = 0;
       rc =Pread (FileHandleA: %Addr(AsciiData) : 65535 : 0 ) ;
       AsciiTo = rc;
       m1 = theImage.FileName;
B01    If rc < 40;
          Message('PDF0007':PDF0007:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
B01    If %Subst(AsciiData:1:2) <> x'424D';
          Message('PDF0007':PDF0007:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       rc = WinBin4(%Subst(AsciiData:15:4));
B01    If rc <> 40;
          Message('PDF0008':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       OffBits = WinBin4(%Subst(AsciiData:11:4));
       theImage.Width = WinBin4(%Subst(AsciiData:19:4));
       theImage.Height= WinBin4(%Subst(AsciiData:23:4));
       theImage.Bpc = WinBin4(%Subst(AsciiData:29:4))/3;
       Pixlen = WinBin4(%Subst(AsciiData:29:4))/8;
       rc = WinBin4(%Subst(AsciiData:31:4));
B01    If rc <> 0;
          Message('PDF0009':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       rc = theImage.Height * theImage.Width * 3;   //?nb of bytes
       //? If the length of the binary data to be encoded is not a multiple of 4
       //? partial group of 4 is used to produce a last, partial group of 5 outp
       //? writes only the first n + 1 characters of the resulting group of 5. T
       //? immediately followed by the ~> EOD marker.
       bmplen = 0 ;
       theImage.Preloaded = ToMem;
       //?extraire les pixels
       //?parcourir les lignes
       //?line len is a multiple of 4 bytes
       //?line len = line width upper rounded to 4 bytes
       PdfData = '';
       linLen = 4 * %Int((theImage.Width * Pixlen + 3) / 4) ;
B01    For line = theImage.Height Downto 1;
          //? pdfwrite(%editc((Line - 1) * LinLen + offBits :'P'));
          //?parcourir les pixel
B02       For pixel = 1 To theImage.Width ;
             //?extraire les couleurs
B03          For pixRGB = 2 Downto 0;
                Pos = (line - 1) * linLen + (pixel - 1) * Pixlen
                   + OffBits + pixRGB + 1;
B04             If AsciiFrom <= Pos And Pos <= AsciiTo;
                   //?target byte is available
                   AsciiPos = Pos - AsciiFrom;
                   PdfData +=%Subst(AsciiData:AsciiPos:1 );
X04             Else;
                   //?reload an other part of the file
                   AsciiFrom = Pos - 32000;
B05                If AsciiFrom < 0;
                      AsciiFrom = 0;
E05                Endif;
                   rc =Pread (FileHandleA: %Addr(AsciiData)
                      : 65535 :AsciiFrom);
                   AsciiTo = AsciiFrom + rc;
B05                If AsciiFrom <= Pos And Pos <= AsciiTo;
                      //?target byte is available
                      AsciiPos = Pos - AsciiFrom;
                      PdfData +=%Subst(AsciiData:AsciiPos:1 );
X05                Else;
                      PdfData +='?';
E05                Endif;
E04             Endif;
                //?one char added, it's time to think to ascii85 convertion
B04             If %Len(PdfData) >=4;
                   Pdf85=Pdfencode85(PdfData);
B05                If theImage.Preloaded;
                      theImage.Stream += Pdf85 ;
X05                Else;
                      Pdfbinwrite(Pdf85: 2 );
E05                Endif;
                   bmplen+=%Len(Pdf85);
E04             Endif;
E03          Endfor;
             //?  PdfData +=' ';
E02       Endfor;
          //?PdfWrite(PdfData + crlf );
          //?PdfData ='';
E01    Endfor;
B01    If %Len(PdfData) >=1;
          Pdf85=Pdfencode85(PdfData);
B02       If theImage.Preloaded;
             theImage.Stream += Pdf85 ;
X02       Else;
             Pdfbinwrite(Pdf85: 2 );
E02       Endif;
          bmplen+=%Len(Pdf85);
E01    Endif;
       rc = Close(FileHandleA) ;
       Return bmplen ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?pPdfMemLoadBMP24  b                   export
     dPdfMemLoadBMP24  pi
     D TheImage                            likeds(PdfImage)
     d  bmplen         s             10u 0
     d  bmplenobj      s                   like(pdfobj)
      /free

B01    If theImage.Preloaded = ' ';   //?neither '0' nor '1'
          Clear theImage;
          Message('PDF0016':'':'':'JPLTOOLS');
          Dumpcallstack();
          Pdffile.Withdiag=True;
          Return;
E01    Endif;

       theImage.Obj=Pdfnewobj();
       bmplenobj =Pdfnewobj();
       theImage.Name = '/Bmp'+%Trim( %Editc(theImage.Obj:'P'));
       bmplen = 0 ;
       Pdffile_xref(theImage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.Bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + Pdfwobj(bmplenobj)
          + 'R>> stream' + Crlf);
B01    If theImage.Preloaded;
          bmplen=%Len(theImage.Stream);
          Pdfbinwrite(theImage.Stream: 2 );
X01    Else ;
          bmplen=BmpLoad(theImage:False);
E01    Endif;
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref(bmplenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj(bmplenobj)+'obj '
          + %Editc(bmplen:'P') + ' endobj' + Crlf);
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  pPdfMemLoadBMP24  e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p pdfEncode85     b
     d pdfEncode85     pi                  like(PdfS3)
     d    in85                             like(PdfS3)
     d encoded         s                   like(pdfS3) static




    ?d* home for 4 chars to encode
     d c4              ds             4    static
     d C4i                           10u 0
    ?d* work for 5 chars encoded
     d c5              ds             5    static qualified
     d  value                         3u 0 dim(5)
     d out85           ds             5    static qualified
     d  value                         1    dim(5)
     d









    ?d*
     d i               s             10u 0 static
     d inlen           s             10u 0 static
      /free
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;


       //?base85inz =
       //?          PortableChar.ExclamationPoint + '"' +
       //?          PortableChar.NumberSign + '' +
       //?          portablechar.dollar + '%&''()*+,-./0123456789:;<=>?' +
       //?          PortableChar.AtSign + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
       //?          PortableChar.LeftBracket      +
       //?          PortableChar.BackSlash       +
       //?          PortableChar.RightBracket +
       //?          PortableChar.Caret + '_µabcdefghijklmnopqrstu'     ;
       //?base85inz =
       //?                           '!"#$%&''()*+,-./0123456789:;<=>?@ABC'
       //?+                          'DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefg'
       //?+                          'hijklmnopqrstu';
       inlen= %Len(in85);
B01    If inlen > 4;
          //?pick the first 4 chars
          c4 = %Subst(in85:1:4);
          in85 = %Subst(in85:5);
X01    Elseif inlen =4;
          //?pick all the 4 chars
          c4 = in85;
          in85='';
X01    Else;
          //?pick the remainding chars
          c4 = *loval;
          c4=in85;
          in85='';
E01    Endif;
       c5.value(5) = %Rem(C4i:85);
       C4i = %Div(C4i:85);
       c5.value(4) = %Rem(C4i:85);
       C4i = %Div(C4i:85);
       c5.value(3) = %Rem(C4i:85);
       C4i = %Div(C4i:85);
       c5.value(2) = %Rem(C4i:85);
       C4i = %Div(C4i:85);
       c5.value(1) = %Rem(C4i:85);
       C4i = %Div(C4i:85);
       out85.value(1) = Base85.Char (c5.value(1)+1);
       out85.value(2) = Base85.Char (c5.value(2)+1);
       out85.value(3) = Base85.Char (c5.value(3)+1);
       out85.value(4) = Base85.Char (c5.value(4)+1);
       out85.value(5) = Base85.Char (c5.value(5)+1);
B01    If inlen >=4;
          encoded = out85;
B02       If encoded =
                Portablechar.Exclamationpoint +
                Portablechar.Exclamationpoint +
                Portablechar.Exclamationpoint +
                Portablechar.Exclamationpoint +
                Portablechar.Exclamationpoint ;
             encoded = 'z';
E02       Endif;
X01    Else;
          encoded = %Subst(out85:1:inlen+1)+'' +
             Portablechar.Tilde + '>';
E01    Endif;
       Return encoded ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p pdfLoadJPEGh    b
     d pdfLoadJPEGh    pi                  likeds(PdfImage)
     D  FileName                    512a   varying const
    ?D* Name                               like(pdfs1   )   const
     d TheImage        ds                  likeds(PdfImage) static
     D FileHandleA     s             10i 0        static
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
    ?D*Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
    ?d*AsciiPos        S             10i 0 inz(0)
     d AsciiRead       S             10i 0 inz(0)
    ?d*OffBits         s             10i 0        static
     d rc              s             10i 0        static
    ?d*line            s             10i 0        static
    ?d*linLen          s             10i 0        static
    ?d*Pixlen          s             10i 0        static
    ?d*pixel           s             10i 0        static
    ?d*pixRGB          s             10i 0        static
     d PDF0010         ds                         static
     d  m1                          512    varying
    ?d*PdfData         s                   like(pdfbuffer)   static
    ?d* i              s              5u 0
    ?d* hex            ds             2
    ?d* hex1                          1
    ?d* hex2                          1
    ?d* h              ds             2
    ?d* h1                     1      1i 0
    ?d* h2                     2      2i 0
    ?d* c                      1      1
    ?d* h12                    1      2i 0
    ?d* x12                    1      2
    ?d* w12            s              2
    ?d* testproc       s               n   inz(*off)
       //?http://en.wikipedia.org/wiki/JPEG_File_Interchange_Format
       //?http://www.gvsoft.homedns.org/exif/Exif-explanation.html Description o
       //?http://www.obrador.com/essentialjpeg/headerinfo.htm
       //?
       //?a jpg file is a serie on chunks, each starts with a marker x'FF..'
       //?SOI and EOI markers have a length of 0, others have data
       //?hexa   name
       //?FFD8 - Start of Image (SOI) marker ; always at the first two bytes of
       //?FFE0 - JFIF marker
       //?FFD8 - Define Quantization table marker
       //?FFC4 - Define Huffman table marker
       //?FFC0 - Start of frame marker
       //?FFDA - Start of Scan marker
       //?FFFE - Comment marker
       //?FFD9 - End of Image (EOI) marker
       //?data starts always with a 2-bytes value :the length of the chunk, incl
       //?
       //?details
       //?FFE0 - JFIF marker, or APP0 Marker   (note : APP1 marker is for EXIF t
       //?1-2    len                    0010
       //?3-7    JFIF + x'00'           4A46494600
       //?8-9    version                0101
       //?10     density unit           01     0=no, 1=pixels per inch 2=pixel p
       //?11-12  horizontal density     0060
       //?13-14  vertical density       0060
       //?15     Thumbnail Width        00
       //?16     Thumbnail Height       00
       //?17+    Thumbnail Data 3 * Thumbnail Width * Thumbnail Height
       //?       Uncompressed 24 bit RGB raster
     d ffxx            ds                  qualified based(pffxx)
     d   marker                       2
     d   len                          5u 0
     d ffe0            ds                  qualified based(pFFE0)
     d   marker                       2
     d   len                          5u 0
     d   jfif                         5
     d   versionMAJ                   3u 0
     d   versionmin                   3u 0
     d   densityUnit                  3u 0
     d   HorDensity                   5u 0
     d   VerDensity                   5u 0
       //?FFC0 - Start of frame marker
       //?01-02  len                    0011  len = 17
       //?03     bits per component     08
       //?04-05  Y size                 00EC
       //?06-07  X zize                 00EC
       //?08     Nf : 3=Colors; 1=gray  03
       //?                               Nf times :
       //?09-11  Id, H & V sampling     012200
       //?12-14  Id, H & V sampling     021101
       //?15-17  Id, H & V sampling     031101
     d ffc0            ds                  qualified based(pFFC0)
     d   marker                       2
     d   len                          5u 0
     d   bpc                          3u 0
     d   Ysize                        5u 0
     d   Xsize                        5u 0
     d myStat          ds                  likeds(statds)
      /free
       //?
       Clear theImage;
       theImage.Filter='' +
          Portablechar.Leftbracket + '/ASCIIHexDecode /DCTDecode' +
          Portablechar.Rightbracket ;
       theImage.Colorspace='/DeviceRGB';
       FileHandleA= Open( %Trim(FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
E01    Endif;
       AsciiFrom = 0;
       AsciiRead =Pread (FileHandleA: %Addr(AsciiData) : 32000 : 0 ) ;
       m1 = FileName;
       pffxx=%Addr(AsciiData);
B01    If ffxx.marker <> x'FFD8';
          Message('PDF0010':PDF0010:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return theImage;
E01    Endif;
       //?search chunk after chunk the markers FFE0 and FFC0
B01    Dow True;
B02       If ffxx.marker = x'FFD8';
             pffxx +=2;
X02       Else;
             pffxx+=ffxx.len+2;
E02       Endif;
B02       If pffxx > %Addr(AsciiData) + AsciiRead ;
             //?chunk ffc0 not found within the first 30k of the jpeg
             Message('PDF0010':PDF0010:'':'JPLTOOLS');
             Pdffile.Withdiag=True;
             Return theImage;
E02       Endif;
B02       If ffxx.marker = x'FFD9' ;
             //?end of image before start of frame, abort
             Message('PDF0010':PDF0010:'':'JPLTOOLS');
             Pdffile.Withdiag=True;
             Return theImage;
E02       Endif;
B02       If ffxx.marker=x'FFC0' ;
             pFFC0 = pffxx;
             theImage.bpc = ffc0.bpc ;
             theImage.Height=ffc0.Ysize ;
             theImage.Width =ffc0.Xsize ;
             Leave;
E02       Endif;
B02       If ffxx.marker=x'FFE0' ;
             pFFE0 = pffxx;
E02       Endif;
E01    Enddo;
       theImage.Obj=Pdfnewobj();
       theImage.Name = '/Jpg'+%Trim( %Editc(theImage.Obj:'P'));
       rc = Fstat(FileHandleA : myStat);
       rc = myStat.St_size * 2 ;
       AsciiTo= myStat.St_size ;
       Pdffile_xref(theImage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + %Editc(rc:'P') + ' >> stream' + Crlf);
       //?extract jpeg data - first chunk 32k already read
B01    Dow True;   //?for ever
          rc = AsciiRead * 2;
          Chr2hex (Hexadata : AsciiData : rc ) ;
          Pdfbinwrite(%Subst(Hexadata : 1 : rc): 2 );   //?attention, HS si cryptage
          //?read next chunk
          AsciiFrom +=AsciiRead;
B02       If AsciiFrom >= AsciiTo;
             Leave;
E02       Endif;
          AsciiRead =Pread (FileHandleA: %Addr(AsciiData)
             : 32000 :AsciiFrom);
E01    Enddo ;
       rc = Close(FileHandleA) ;
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p pdfLoadJPEG     b
     d pdfLoadJPEG     pi                  likeds(PdfImage)
     D  FileName                    512a   varying const
    ?D* Name                               like(pdfs1   )   const
     d TheImage        ds                  likeds(PdfImage) static
     D FileHandleA     s             10i 0        static
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
    ?D*Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
    ?d*AsciiPos        S             10i 0 inz(0)
     d AsciiRead       S             10i 0 inz(0)
    ?d*OffBits         s             10i 0        static
     d rc              s             10i 0        static
    ?d*line            s             10i 0        static
    ?d*linLen          s             10i 0        static
    ?d*Pixlen          s             10i 0        static
    ?d*pixel           s             10i 0        static
    ?d*pixRGB          s             10i 0        static
     d PDF0010         ds                         static
     d  m1                          512    varying
     d PdfData         s                   like(pdfbuffer)   static
     d Pdf85           s                   like(pdfbuffer)   static
     d  savImage       s               n   inz(*off)

       //?http://en.wikipedia.org/wiki/JPEG_File_Interchange_Format
       //?http://www.gvsoft.homedns.org/exif/Exif-explanation.html Description o
       //?http://www.obrador.com/essentialjpeg/headerinfo.htm
       //?
       //?a jpg file is a serie on chunks, each starts with a marker x'FF..'
       //?SOI and EOI markers have a length of 0, others have data
       //?hexa   name
       //?FFD8 - Start of Image (SOI) marker ; always at the first two bytes of
       //?FFE0 - JFIF marker
       //?FFD8 - Define Quantization table marker
       //?FFC4 - Define Huffman table marker
       //?FFC0 - Start of frame marker
       //?FFDA - Start of Scan marker
       //?FFFE - Comment marker
       //?FFD9 - End of Image (EOI) marker
       //?data starts always with a 2-bytes value :the length of the chunk, incl
       //?
       //?details
       //?FFE0 - JFIF marker, or APP0 Marker   (note : APP1 marker is for EXIF t
       //?1-2    len                    0010
       //?3-7    JFIF + x'00'           4A46494600
       //?8-9    version                0101
       //?10     density unit           01     0=no, 1=pixels per inch 2=pixel p
       //?11-12  horizontal density     0060
       //?13-14  vertical density       0060
       //?15     Thumbnail Width        00
       //?16     Thumbnail Height       00
       //?17+    Thumbnail Data 3 * Thumbnail Width * Thumbnail Height
       //?       Uncompressed 24 bit RGB raster
     d ffxx            ds                  qualified based(pffxx)
     d   marker                       2
     d   len                          5u 0
     d ffe0            ds                  qualified based(pFFE0)
     d   marker                       2
     d   len                          5u 0
     d   jfif                         5
     d   versionMAJ                   3u 0
     d   versionmin                   3u 0
     d   densityUnit                  3u 0
     d   HorDensity                   5u 0
     d   VerDensity                   5u 0
       //?FFC0 - Start of frame marker
       //?01-02  len                    0011  len = 17
       //?03     bits per component     08
       //?04-05  Y size                 00EC
       //?06-07  X zize                 00EC
       //?08     Nf : 3=Colors; 1=gray  03
       //?                               Nf times :
       //?09-11  Id, H & V sampling     012200
       //?12-14  Id, H & V sampling     021101
       //?15-17  Id, H & V sampling     031101
     d ffc0            ds                  qualified based(pFFC0)
     d   marker                       2
     d   len                          5u 0
     d   bpc                          3u 0
     d   Ysize                        5u 0
     d   Xsize                        5u 0
     d myStat          ds                  likeds(statds)
     d  bmplen         s             10u 0
     d  bmplenobj      s                   like(pdfobj)
      /free
       //?
B01    If ( Myimage = ' ' );
          savImage=*on;
E01    Endif;
       Clear theImage;
       theImage.Filter='' +
          Portablechar.Leftbracket + '/ASCII85Decode /DCTDecode' +
          Portablechar.Rightbracket + '';
       theImage.Colorspace='/DeviceRGB';
       FileHandleA= Open( %Trim(FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
E01    Endif;
       AsciiFrom = 0;
       //?multiple of 4, need to be eaten by pdfencode85
       AsciiRead =Pread (FileHandleA: %Addr(AsciiData) : 32000 : 0 ) ;
       m1 = FileName;
       pffxx=%Addr(AsciiData);
B01    If ffxx.marker <> x'FFD8';
          Message('PDF0010':PDF0010:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return theImage;
E01    Endif;
       //?search chunk after chunk the markers FFE0 and FFC0
B01    Dow True;
B02       If ffxx.marker = x'FFD8';
             pffxx +=2;
X02       Else;
             pffxx+=ffxx.len+2;
E02       Endif;
B02       If pffxx > %Addr(AsciiData) + AsciiRead ;
             //?chunk ffc0 not found within the first 30k of the jpeg
             //?  message('PDF0010':pdf0010:'':'JPLTOOLS');
             //?  return theimage;
             AsciiFrom +=AsciiRead;
             AsciiRead =Pread (FileHandleA: %Addr(AsciiData)
                : 32000 :AsciiFrom);
             pffxx=%Addr(AsciiData);
E02       Endif;
B02       If ffxx.marker = x'FFD9'
X02       Or AsciiRead = 0;   //? trap for EOF  13 Oct 10
             //?end of image before start of frame, abort
             Message('PDF0010':PDF0010:'':'JPLTOOLS');
             Pdffile.Withdiag=True;
             Return theImage;
E02       Endif;
B02       If ffxx.marker=x'FFC0' ;
             pFFC0 = pffxx;
             theImage.bpc = ffc0.bpc ;
             theImage.Height=ffc0.Ysize ;
             theImage.Width =ffc0.Xsize ;
             Leave;
E02       Endif;
B02       If ffxx.marker=x'FFE0' ;
             pFFE0 = pffxx;
E02       Endif;
E01    Enddo;
       AsciiFrom = 0;
       theImage.Obj=Pdfnewobj();
       bmplenobj =Pdfnewobj();
       theImage.Name = '/Jpg'+%Trim( %Editc(theImage.Obj:'P'));
       rc = Fstat(FileHandleA : myStat);
       rc = myStat.St_size * 2 ;
       AsciiTo= myStat.St_size ;
       Pdffile_xref(theImage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + Pdfwobj(bmplenobj)
          + 'R>> stream' + Crlf);
       //?extract jpeg data - first chunk 32k already read
B01    Dow True;   //?for ever
          PdfData = %Subst(AsciiData:1:AsciiRead);
B02       Dow %Len(PdfData) > 0;
             Pdf85=pdfEncode85(PdfData);
B03          If ( savImage );
                Myimage+=%Trimr(Pdf85);
E03          Endif;
             bmplen+=%Len(Pdf85);
             Pdfwrite(Pdf85);
E02       Enddo;
          //?read next chunk
          AsciiFrom +=AsciiRead;
B02       If AsciiFrom >= AsciiTo;
             Leave;
E02       Endif;
          //?multiple of 4, need to be eaten by pdfencode85
          AsciiRead =Pread (FileHandleA: %Addr(AsciiData)
             : 32000 :AsciiFrom);
E01    Enddo ;
       //?the remainder, if any;
B01    If %Len(PdfData) >=1;
          Pdf85=pdfEncode85(PdfData);
B02       If ( savImage );
             Myimage+=%Trimr(Pdf85);
E02       Endif;
          bmplen+=%Len(Pdf85);
          Pdfwrite(Pdf85);
E01    Endif;
       //?pdfBinwrite(MyImage:false);
       rc = Close(FileHandleA) ;
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref(bmplenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj(bmplenobj)+'obj '
          + %Editc(bmplen:'P') + ' endobj' + Crlf);
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p pdfMemJPEG      b
     d pdfMemJPEG      pi                  likeds(PdfImage)
     d anImage                             likeds(PdfImage)
     d TheImage        ds                  likeds(PdfImage)
     d  bmplenobj      s                   like(pdfobj)
      /free
       Clear theImage;
       theImage.Filter='' +
          Portablechar.Leftbracket + '/ASCII85Decode /DCTDecode' +
          Portablechar.Rightbracket + '';
       theImage.Colorspace='/DeviceRGB';
       theImage.Width = anImage.Width;
       theImage.Height= anImage.Height;
       theImage.bpc = anImage.bpc;
       theImage.Obj=Pdfnewobj();
       bmplenobj =Pdfnewobj();
       theImage.Name = '/Jpg'+%Trim( %Editc(theImage.Obj:'P'));
       Pdffile_xref(theImage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + Pdfwobj(bmplenobj)
          + 'R>> stream' + Crlf);
       Pdfbinwrite(Myimage: 2 );
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref(bmplenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj(bmplenobj)+'obj '
          + %Editc(%Len(Myimage):'P') + ' endobj' + Crlf);
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?ppdfPreLoadJPEG   b                   export
     dpdfPreLoadJPEG   pi                  likeds(PdfImage)
     D  FileName                    512a   varying const
     d TheImage        ds                  likeds(PdfImage) static
     D FileHandleA     s             10i 0        static
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
    ?D*Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
    ?d*AsciiPos        S             10i 0 inz(0)
     d AsciiRead       S             10i 0 inz(0)
    ?d*OffBits         s             10i 0        static
     d rc              s             10i 0        static
    ?d*line            s             10i 0        static
    ?d*linLen          s             10i 0        static
    ?d*Pixlen          s             10i 0        static
    ?d*pixel           s             10i 0        static
    ?d*pixRGB          s             10i 0        static
     d PDF0010         ds                         static
     d  m1                          512    varying
     d PdfData         s                   like(pdfbuffer)   static
     d Pdf85           s                   like(pdfbuffer)   static
     d  savImage       s               n   inz(*off)
       //? http://en.wikipedia.org/wiki/JPEG_File_Interchange_Format
       //? http://www.gvsoft.homedns.org/exif/Exif-explanation.html Description o
       //? http://www.obrador.com/essentialjpeg/headerinfo.htm
       //?
       //? a jpg file is a serie on chunks, each starts with a marker x'FF..'
       //? SOI and EOI markers have a length of 0, others have data
       //? hexa   name
       //? FFD8 - Start of Image (SOI) marker ; always at the first two bytes of
       //? FFE0 - JFIF marker
       //? FFD8 - Define Quantization table marker
       //? FFC4 - Define Huffman table marker
       //? FFC0 - Start of frame marker
       //? FFDA - Start of Scan marker
       //? FFFE - Comment marker
       //? FFD9 - End of Image (EOI) marker
       //? data starts always with a 2-bytes value :the length of the chunk, incl
       //?
       //? details
       //? FFE0 - JFIF marker, or APP0 Marker   (note : APP1 marker is for EXIF t
       //? 1-2    len                    0010
       //? 3-7    JFIF + x'00'           4A46494600
       //? 8-9    version                0101
       //? 10     density unit           01     0=no, 1=pixels per inch 2=pixel p
       //? 11-12  horizontal density     0060
       //? 13-14  vertical density       0060
       //? 15     Thumbnail Width        00
       //? 16     Thumbnail Height       00
       //? 17+    Thumbnail Data 3 * Thumbnail Width * Thumbnail Height
       //?        Uncompressed 24 bit RGB raster
     d ffxx            ds                  qualified based(pffxx)
     d   marker                       2
     d   len                          5u 0
     d ffe0            ds                  qualified based(pFFE0)
     d   marker                       2
     d   len                          5u 0
     d   jfif                         5
     d   versionMAJ                   3u 0
     d   versionmin                   3u 0
     d   densityUnit                  3u 0
     d   HorDensity                   5u 0
     d   VerDensity                   5u 0
       //?FFC0 - Start of frame marker
       //?01-02  len                    0011  len = 17
       //?03     bits per component     08
       //?04-05  Y size                 00EC
       //?06-07  X zize                 00EC
       //?08     Nf : 3=Colors; 1=gray  03
       //?                               Nf times :
       //?09-11  Id, H & V sampling     012200
       //?12-14  Id, H & V sampling     021101
       //?15-17  Id, H & V sampling     031101
     d ffc0            ds                  qualified based(pFFC0)
     d   marker                       2
     d   len                          5u 0
     d   bpc                          3u 0
     d   Ysize                        5u 0
     d   Xsize                        5u 0
     d myStat          ds                  likeds(statds)
      /free
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;
       Clear theImage;
       theImage.FileName = FileName;
       theImage.Filter='' +
          Portablechar.Leftbracket + '/ASCII85Decode /DCTDecode' +
          Portablechar.Rightbracket + '';
       theImage.Colorspace='/DeviceRGB';
       FileHandleA= Open( %Trim(FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
E01    Endif;
       rc = Fstat(FileHandleA : myStat);
       rc = Close(FileHandleA) ;
       rc = myStat.St_size * 5 / 4 ;
B01    If rc < %Size(theImage.Stream);
          theImage.Preloadable = True;
X01    Else;
B02       If Pdffile.Encrypted;
             //?un jour, je saurai utiliser ça:
            //?The key context allows encryption or decryption of a message in multiple blocks using
             //?multiple calls to CIPHER.
             //?not cryptable  , too big for 64k stream
             Message('PDF0012':'':'':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
B01    If theImage.Preloadable =False;
          //?will run load from disk each time PdfMemLoad is called
          Return theImage;
E01    Endif;
       Jpgload(theImage : True);   //?load JPG to mem
       Return theImage;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?pJpgLoad          b
     dJpgLoad          pi            10i 0
     D  TheImage                           likeds(PdfImage)
     d  ToMem                         1    const
    ? *
    ? * ToMem = false : ecriture directe dans le pdf
    ? * ToMem = true : ecriture dans theimage.stream
    ? * ToMem = 2 : juste charger les attributs de theimage
    ? *
     D FileHandleA     s             10i 0        static
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
    ?D*Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
    ?d*AsciiPos        S             10i 0 inz(0)
     d AsciiRead       S             10i 0 inz(0)
    ?d*OffBits         s             10i 0        static
     d rc              s             10i 0        static
    ?d*line            s             10i 0        static
    ?d*linLen          s             10i 0        static
    ?d*Pixlen          s             10i 0        static
    ?d*pixel           s             10i 0        static
    ?d*pixRGB          s             10i 0        static
     d PDF0010         ds                         static
     d  m1                          512    varying
     d PdfData         s                   like(pdfbuffer)   static
     d Pdf85           s                   like(pdfbuffer)   static
     d ffxx            ds                  qualified based(pffxx)
     d   marker                       2
     d   len                          5u 0
     d ffe0            ds                  qualified based(pFFE0)
     d   marker                       2
     d   len                          5u 0
     d   jfif                         5
     d   versionMAJ                   3u 0
     d   versionmin                   3u 0
     d   densityUnit                  3u 0
     d   HorDensity                   5u 0
     d   VerDensity                   5u 0
     d ffc0            ds                  qualified based(pFFC0)
     d   marker                       2
     d   len                          5u 0
     d   bpc                          3u 0
     d   Ysize                        5u 0
     d   Xsize                        5u 0
     d myStat          ds                  likeds(statds)
     d  bmplen         s             10u 0
     d  bmplenobj      s                   like(pdfobj)
      /free
       //?
       theImage.Damaged = True;
       FileHandleA= Open( %Trim(theImage.FileName)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       AsciiFrom = 0;
       //?multiple of 4, need to be eaten by pdfencode85
       AsciiRead =Pread (FileHandleA: %Addr(AsciiData) : 32000 : 0 ) ;
       m1 = theImage.FileName;
       pffxx=%Addr(AsciiData);
B01    If ffxx.marker <> x'FFD8';
          Message('PDF0010':PDF0010:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return 0;
E01    Endif;
       //?search chunk after chunk the markers FFE0 and FFC0
B01    Dow True;
B02       If ffxx.marker = x'FFD8';
             pffxx +=2;
X02       Else;
             pffxx+=ffxx.len+2;
E02       Endif;
B02       If pffxx > %Addr(AsciiData) + AsciiRead ;
             //?chunk ffc0 not found within the first 30k of the jpeg
             //?  message('PDF0010':pdf0010:'':'JPLTOOLS');
             //?  return theimage;
             AsciiFrom +=AsciiRead;
             AsciiRead =Pread (FileHandleA: %Addr(AsciiData)
                : 32000 :AsciiFrom);
             pffxx=%Addr(AsciiData);
E02       Endif;
B02       If ffxx.marker = x'FFD9'
X02       Or AsciiRead = 0;   //? trap for EOF  13 Oct 10
             //?end of image before start of frame, abort
             Message('PDF0010':PDF0010:'':'JPLTOOLS');
             Pdffile.Withdiag=True;
             Return 0 ;
E02       Endif;
B02       If ffxx.marker=x'FFC0' ;
             pFFC0 = pffxx;
             theImage.bpc = ffc0.bpc ;
             theImage.Height=ffc0.Ysize ;
             theImage.Width =ffc0.Xsize ;
             Leave;
E02       Endif;
B02       If ffxx.marker=x'FFE0' ;
             pFFE0 = pffxx;
E02       Endif;
E01    Enddo;
B01    If ToMem ='2';
          Return 0;
E01    Endif;
       AsciiFrom = 0;
       rc = Fstat(FileHandleA : myStat);
       rc = myStat.St_size * 2 ;
       AsciiTo= myStat.St_size ;
       bmplen = 0 ;
       theImage.Preloaded = ToMem;
       //?extract jpeg data - first chunk 32k already read
B01    Dow True;   //?for ever
          PdfData = %Subst(AsciiData:1:AsciiRead);
B02       Dow %Len(PdfData) > 0;
             Pdf85=pdfEncode85(PdfData);
B03          If theImage.Preloaded;
                theImage.Stream+=Pdf85;
X03          Else;
                Pdfbinwrite(Pdf85: 2 );
E03          Endif;
             bmplen+=%Len(Pdf85);
E02       Enddo;
          //?read next chunk
          AsciiFrom +=AsciiRead;
B02       If AsciiFrom >= AsciiTo;
             Leave;
E02       Endif;
          //?multiple of 4, need to be eaten by pdfencode85
          AsciiRead =Pread (FileHandleA: %Addr(AsciiData)
             : 32000 :AsciiFrom);
E01    Enddo ;
       //?the remainder, if any;
B01    If %Len(PdfData) >=1;
          Pdf85=pdfEncode85(PdfData);
B02       If theImage.Preloaded;
             theImage.Stream+=Pdf85;
X02       Else;
             Pdfbinwrite(Pdf85: 2 );
E02       Endif;
          bmplen+=%Len(Pdf85);
E01    Endif;
       rc = Close(FileHandleA) ;
       theImage.Damaged = False;
       Return bmplen ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?pPdfMemLoadJpeg   b                   export
     dPdfMemLoadJpeg   pi
     d TheImage                            likeds(PdfImage)
     D FileHandleA     s             10i 0        static
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
    ?D*Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d AsciiTo         S             10i 0 inz(0)
    ?d*AsciiPos        S             10i 0 inz(0)
     d AsciiRead       S             10i 0 inz(0)
    ?d*OffBits         s             10i 0        static
     d rc              s             10i 0        static
    ?d*line            s             10i 0        static
    ?d*linLen          s             10i 0        static
    ?d*Pixlen          s             10i 0        static
    ?d*pixel           s             10i 0        static
    ?d*pixRGB          s             10i 0        static
     d PDF0010         ds                         static
     d  m1                          512    varying
     d PdfData         s                   like(pdfbuffer)   static
     d Pdf85           s                   like(pdfbuffer)   static
     d  savImage       s               n   inz(*off)
       //?http://en.wikipedia.org/wiki/JPEG_File_Interchange_Format
       //?http://www.gvsoft.homedns.org/exif/Exif-explanation.html Description o
       //?http://www.obrador.com/essentialjpeg/headerinfo.htm
       //?
       //?a jpg file is a serie on chunks, each starts with a marker x'FF..'
       //?SOI and EOI markers have a length of 0, others have data
       //?hexa   name
       //?FFD8 - Start of Image (SOI) marker ; always at the first two bytes of
       //?FFE0 - JFIF marker
       //?FFD8 - Define Quantization table marker
       //?FFC4 - Define Huffman table marker
       //?FFC0 - Start of frame marker
       //?FFDA - Start of Scan marker
       //?FFFE - Comment marker
       //?FFD9 - End of Image (EOI) marker
       //?data starts always with a 2-bytes value :the length of the chunk, incl
       //?
       //?details
       //?FFE0 - JFIF marker, or APP0 Marker   (note : APP1 marker is for EXIF t
       //?1-2    len                    0010
       //?3-7    JFIF + x'00'           4A46494600
       //?8-9    version                0101
       //?10     density unit           01     0=no, 1=pixels per inch 2=pixel p
       //?11-12  horizontal density     0060
       //?13-14  vertical density       0060
       //?15     Thumbnail Width        00
       //?16     Thumbnail Height       00
       //?17+    Thumbnail Data 3 * Thumbnail Width * Thumbnail Height
       //?       Uncompressed 24 bit RGB raster
     d ffxx            ds                  qualified based(pffxx)
     d   marker                       2
     d   len                          5u 0
     d ffe0            ds                  qualified based(pFFE0)
     d   marker                       2
     d   len                          5u 0
     d   jfif                         5
     d   versionMAJ                   3u 0
     d   versionmin                   3u 0
     d   densityUnit                  3u 0
     d   HorDensity                   5u 0
     d   VerDensity                   5u 0
       //?FFC0 - Start of frame marker
       //?01-02  len                    0011  len = 17
       //?03     bits per component     08
       //?04-05  Y size                 00EC
       //?06-07  X zize                 00EC
       //?08     Nf : 3=Colors; 1=gray  03
       //?                               Nf times :
       //?09-11  Id, H & V sampling     012200
       //?12-14  Id, H & V sampling     021101
       //?15-17  Id, H & V sampling     031101
     d ffc0            ds                  qualified based(pFFC0)
     d   marker                       2
     d   len                          5u 0
     d   bpc                          3u 0
     d   Ysize                        5u 0
     d   Xsize                        5u 0
     d myStat          ds                  likeds(statds)
     d  bmplen         s             10u 0
     d  bmplenobj      s                   like(pdfobj)
      /free

B01    If theImage.Preloaded = ' ';   //?neither '0' nor '1'
          Clear theImage;
          Message('PDF0016':'':'':'JPLTOOLS');
          Dumpcallstack();
          Pdffile.Withdiag=True;
          Return;
E01    Endif;

       bmplen=0;
       theImage.Obj=Pdfnewobj();
       bmplenobj =Pdfnewobj();
       theImage.Name = '/Jpg'+%Trim( %Editc(theImage.Obj:'P'));
       rc = Fstat(FileHandleA : myStat);
       rc = myStat.St_size * 2 ;
       AsciiTo= myStat.St_size ;
       Pdffile_xref(theImage.Obj : Pdfbytescount);

B01    If theImage.Preloaded = False;
          //?recuperer les attributs
          JpgLoad(theImage:'2' ) ;
E01    Endif;
       Pdfwrite(Pdfwobj(theImage.Obj)+'obj <<'
          + ' /Type /XObject /Subtype /Image /Width '
          + %Editc(theImage.Width:'P')
          + ' /Height ' + %Editc(theImage.Height:'P')
          + ' /BitsPerComponent ' + %Editc(theImage.bpc:'P')
          + ' /ColorSpace ' + theImage.Colorspace
          + ' /Filter ' + theImage.Filter
          + ' /Length '
          + Pdfwobj(bmplenobj)
          + 'R>> stream' + Crlf);
B01    If theImage.Preloaded;
          bmplen=%Len(theImage.Stream);
          Pdfbinwrite(theImage.Stream: 2 );
X01    Else ;
          bmplen=JpgLoad(theImage:False);
E01    Endif;
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref(bmplenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj(bmplenobj)+'obj '
          + %Editc(bmplen:'P') + ' endobj' + Crlf);
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p PdfTextCondensed...
BPR ?p                 b                   export
     d PdfTextCondensed...
     d                 pi                  like(pdfS1)
     d    spacing                     5i 0 value
      /free
       //?default value is 100
       Pdffile.Currcondsize = spacing;

       Return Latin1(%Editc(spacing:'P')+ ' Tz ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfTextCol      b                   export
     d PdfTextCol      pi                  like(pdfobj)
     d
      /free
       //?take care, PdfTextCol is not avare of save & restore graphic state
       //?IE if you save the graphstate, then print some lines then restore the graphstate,
       //?the text cursor goes back to it's position at save time.
       //?so next text line will override ; but the PDF server don't know
       //?to handle this case,
       //?avoid to save and restore graphix state into a text stream
       //?note to JPL : add a stack to handle cursor position
       //?when save & restore graphix state
       Return Pdffile.Textcurrx;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfTextRow      b                   export
     d PdfTextRow      pi                  like(pdfobj)
     d
      /free
       //?take care, PdfTextRow is not avare of save & restore graphic state
       Return Pdffile.Textcurry;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p PdfTextWordSpace...
BPR ?p                 b                   export
     d PdfTextWordSpace...
     d                 pi                  like(pdfS1)
     d    spacing                     5s 3 value
      /free
       //?default value is 0
       Return Latin1(%Editc(spacing:'P')+ ' Tw ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p PdfTextCharSpace...
BPR ?p                 b                   export
     d PdfTextCharSpace...
     d                 pi                  like(pdfS1)
     d    spacing                     5s 3 value
      /free
       //?default value is 0
       Return Latin1(%Editc(spacing:'P')+ ' Tc ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p PdfPageContent...
BPR ?p                 b                   export
     d PdfPageContent...
     d                 pi
     d    theContent                       likeds(PdfContent)  const
      /free
       Pdfpage.Content = theContent.Obj;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p PdfPageResource...
BPR ?p                 b                   export
     d PdfPageResource...
     d                 pi
     d    theresource                      likeds(PdfResource) const
      /free
B01    If Not Pdfpage.Isopen ;
       Message ('':'Page is not open when PdfPageRessource':'':'':'*DIAG':'':2);
          Pdffile.Withdiag=True;
E01    Endif;
       Pdfpage.Resource=theresource.Obj;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfClosePage    b                   export
     d PdfClosePage...
     d                 pi
      /free
       //?   4 0 obj << /Type /Page /Parent 3 0 R /MediaBox [0 0 595 840] /Conte
       //?   6 0 R >> endobj
       Pdffile_xref(Pdfpage.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(Pdfpage.Obj)+'obj << /Type /Page /Parent '
          + Pdfwobj(Pdfpage.Parent) + 'R /MediaBox ' +
          Portablechar.Leftbracket + ''
          + %Trim(%Editc(Pdfpage.Mediabox(1)-Pdfpage.Margin(1):'P'))+ ' '   //?low left x
          + %Trim(%Editc(Pdfpage.Mediabox(2)-Pdfpage.Margin(4):'P'))+ ' '   //?low left y
          + %Trim(%Editc(Pdfpage.Mediabox(3)+Pdfpage.Margin(2):'P'))+ ' '   //?upper right x
          + %Trim(%Editc(Pdfpage.Mediabox(4)+Pdfpage.Margin(3):'P'))   //?upper right y
          + '' +
          Portablechar.Rightbracket + ' '
          + '/BleedBox ' +
          Portablechar.Leftbracket + ''
          + %Trim(%Editc(Pdfpage.Mediabox(1):'P'))+ ' '   //?low left x
          + %Trim(%Editc(Pdfpage.Mediabox(2):'P'))+ ' '   //?low left y
          + %Trim(%Editc(Pdfpage.Mediabox(3):'P'))+ ' '   //?upper right x
          + %Trim(%Editc(Pdfpage.Mediabox(4):'P'))   //?upper right y
          + Portablechar.Rightbracket +
          ' /Contents '+Pdfwobj(Pdfpage.Content) + 'R /Resources ' +
          Pdfwobj(Pdfpage.Resource) + 'R >> endobj'+Crlf);
       Pdfpage.Isopen = False;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfDrawGoto     b                   export
     d PdfDrawGoto     pi                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
      /free
       Pdffile.Drawcurrx = x ;
       Pdffile.Drawcurry = y ;
       Return Latin1(%Char(x) +' '+ %Char(y) + ' m ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmStrokingColorRGB...
BPR ?p                 b                   export
     d PdfStrmStrokingColorRGB...
     d                 pi                  like(pdfs1)
     d red                            5p 4 value
     d green                          5p 4 value
     d blue                           5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If red < 0 Or 1< red;
          m1 = red ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If green < 0 Or 1< green;
          m1 = green ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If blue < 0 Or 1< blue ;
          m1 = blue ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(red)+' '+%Char(green)+' '+%Char(blue)+' RG ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmFillingColorRGB...
BPR ?P                 b                   export
     d PdfStrmFillingColorRGB...
     d                 pi                  like(pdfs1)
     d red                            5p 4 value
     d green                          5p 4 value
     d blue                           5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If red < 0 Or 1< red;
          m1 = red ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If green < 0 Or 1< green;
          m1 = green ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If blue < 0 Or 1< blue ;
          m1 = blue ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(red)+' '+%Char(green)+' '+%Char(blue)+' rg ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmStrokingColorGray...
BPR ?P                 b                   export
     d PdfStrmStrokingColorGray...
     d                 pi                  like(pdfs1)
     d gray                           5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If gray < 0 Or 1< gray;
          m1 = gray;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(gray)+' G ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmFillingColorGray...
BPR ?P                 b                   export
     d PdfStrmFillingColorGray...
     d                 pi                  like(pdfs1)
     d gray                           5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If gray < 0 Or 1< gray;
          m1 = gray ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
E01    Endif;
       Return Latin1(%Char(gray)+' g ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmStrokingColorCMYK...
BPR ?p                 b                   export
     d PdfStrmStrokingColorCMYK...
     d                 pi                  like(pdfs1)
     d cyan                           5p 4 value
     d magenta                        5p 4 value
     d yellow                         5p 4 value
     d black                          5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If cyan< 0 Or 1< cyan;
          m1 = cyan ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If magenta < 0 Or 1< magenta;
          m1 = magenta ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If yellow < 0 Or 1< yellow ;
          m1 = yellow ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If black < 0 Or 1< black ;
          m1 = black ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(cyan)+' '+%Char(magenta)+' '+ %Char(yellow)+' '+
          %Char(black)+' K ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmFillingColorCMYK...
BPR ?P                 b                   export
     d PdfStrmFillingColorCMYK...
     d                 pi                  like(pdfs1)
     d cyan                           5p 4 value
     d magenta                        5p 4 value
     d yellow                         5p 4 value
     d black                          5p 4 value
     d pdf0002         ds
     d  m1                            5p 4
      /free
B01    If cyan< 0 Or 1< cyan;
          m1 = cyan ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If magenta < 0 Or 1< magenta;
          m1 = magenta ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If yellow < 0 Or 1< yellow ;
          m1 = yellow ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If black < 0 Or 1< black ;
          m1 = black ;
          Message('PDF0002':pdf0002:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(cyan)+' '+%Char(magenta)+' '+ %Char(yellow)+' '+
          %Char(black)+' k ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawLineWidth...
BPR ?P                 b                   export
     d PdfDrawLineWidth...
     d                 pi                  like(pdfs1)
     d width                          5p 0 value
     d pdf0003         ds
     d  m1                            5p 0
      /free
B01    If width< 0 ;
          m1=width ;
          Message('PDF0003':pdf0003:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(width)+' w ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfDrawLineCap  b                   export
     d PdfDrawLineCap  pi                  like(pdfs1)
     d LineCap                             like(pdfS1) const
     d pdf0004         ds
     d p1                                  like(pdfS1)
     d p2                                  like(pdfS1)
      /free
B01    If LineCap = Pdf_linecapbutt Or
             LineCap = Pdf_linecapround Or
             LineCap = Pdf_linecapprojecting ;
X01    Else;
          p1=LineCap;
          p2 = Pdf_linecapbutt +', '+
             Pdf_linecapround +', '+
             Pdf_linecapprojecting;
          Message('PDF0004':pdf0004:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    Select;
X01       When LineCap = Pdf_linecapbutt ;
             Return Latin1('0 J ') ;
X01       When LineCap = Pdf_linecapround ;
             Return Latin1('1 J ') ;
X01       When LineCap = Pdf_linecapprojecting ;
             Return Latin1('2 J ') ;
X01       Other;
             Return Latin1('0 J ') ;
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawLineJoin...
BPR ?P                 b                   export
     d PdfDrawLineJoin...
     d                 pi                  like(pdfs1)
     d LineJoin                            like(pdfS1) const
     d pdf0005         ds
     d   p1                                like(pdfS1)
     d   p2                                like(pdfS1)
      /free
B01    If LineJoin= Pdf_joinmiter Or
             LineJoin= Pdf_joinround Or
             LineJoin= Pdf_joinbevel ;
X01    Else;
          p1=LineJoin;
          p2 = Pdf_joinmiter +', '+
             Pdf_joinround +', '+
             Pdf_joinbevel ;
          Message('PDF0005':pdf0005:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    Select;
X01       When LineJoin= Pdf_joinmiter ;
             Return Latin1('0 j ') ;
X01       When LineJoin= Pdf_joinround ;
             Return Latin1('1 j ') ;
X01       When LineJoin= Pdf_joinbevel ;
             Return Latin1('2 j ') ;
X01       Other;
             Return Latin1('0 j ') ;
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawMiterLimit...
BPR ?P                 b                   export
     d PdfDrawMiterLimit...
     d                 pi                  like(pdfs1)
     d limit                          5p 3 value
     d pdf0006         ds
     d   m1                           5p 3
      /free
B01    If limit< 1 ;
          m1=limit;
          Message('PDF0006':pdf0006:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(%Char(limit)+' M ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
EPR  P PdfDrawDashedLine...
BPR ?P                 b                   export
     d PdfDrawDashedLine...
     d                 pi                  like(pdfs1)
     d black                          5u 0 value options(*nopass)
     d white                          5u 0 value options(*nopass)
     d start                          5u 0 value options(*nopass)
      /free
B01    If %Parms = 3;
          Return Latin1(
             Portablechar.Leftbracket + '' + %Char(black)+' '+%Char(white)+ '' +
             Portablechar.Rightbracket + ' '
             +%Char(start)+' d ');
E01    Endif;
B01    If %Parms = 2;
          Return Latin1(
             Portablechar.Leftbracket + '' + %Char(black)+' '+%Char(white)+ '' +
             Portablechar.Rightbracket + ' 0 d ');
E01    Endif;
B01    If %Parms = 1;
          Return Latin1(
             Portablechar.Leftbracket + '' + %Char(black) + '' +
             Portablechar.Rightbracket + ' 0 d ');
E01    Endif;
B01    If %Parms = 0;
          Return Latin1(
             Portablechar.Leftbracket + '' +
             Portablechar.Rightbracket + ' 0 d ');
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfDrawAddLine  b                   export
     d PdfDrawAddLine...
     d                 pi                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
      /free
       Pdffile.Drawcurrx = x ;
       Pdffile.Drawcurry = y ;
       Return Latin1(%Char(x) + ' ' + %Char(y) + ' l ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawAddBezier...
BPR ?P                 b                   export
     d PdfDrawAddBezier...
     d                 pi                  like(pdfs1)
     d x1                             5i 0 value
     d y1                             5i 0 value
     d x2                             5i 0 value
     d y2                             5i 0 value
     d x3                             5i 0 value
     d y3                             5i 0 value
      /free
       Pdffile.Drawcurrx = x3;
       Pdffile.Drawcurry = y3;
       Return Latin1(%Char(x1) + ' ' + %Char(y1) + ' '
          + %Char(x2) + ' ' + %Char(y2) + ' '
          + %Char(x3) + ' ' + %Char(y3) + ' '
          + ' c ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawAddRectangle...
BPR ?P                 b                   export
     d PdfDrawAddRectangle...
     d                 pi                  like(pdfs1)
     d x                              6p 1 value
     d y                              6p 1 value
     d w                              6p 1 value
     d h                              6p 1 value
      /free
       Pdffile.Drawcurrx = x +w ;
       Pdffile.Drawcurry = y +h ;
       Return Latin1(%Char(x ) + ' ' + %Char(y ) + ' '
          + %Char(w ) + ' ' + %Char(h )
          + ' re ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawCloseSubPath...
BPR ?P                 b                   export
     d PdfDrawCloseSubPath...
     d                 pi                  like(pdfs1)
      /free
       Return Latin1('h ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawClosePath...
BPR ?P                 b                   export
     d PdfDrawClosePath...
     d                 pi                  like(pdfs1)
     d p1                                  like(pdfs1) const
     d p2                                  like(pdfs1) const options(*nopass)
     d p3                                  like(pdfs1) const options(*nopass)
     d FillN0          s               n   inz(*off)
     d FillEO          s               n   inz(*off)
     d closep          s               n   inz(*off)
     d stroke          s               n   inz(*off)
     d closemode       ds
    ?d*                                         NECS
     d mode1                          7    inz('0001 S ')
     d mode2                          7    inz('0011 s ')
     d mode3                          7    inz('1000 f ')
     d mode4                          7    inz('0100 f*')
     d mode5                          7    inz('1001 B ')
     d mode6                          7    inz('0101 B*')
     d mode7                          7    inz('1011 b ')
     d mode8                          7    inz('0111 b*')
     d mode9                          7    inz('0000 n ')
     d cherche                        4
     d pos                            5u 0
      /free
B01    If %Parms >= 1;
B02       If p1 = Pdf_stroke ;
             stroke=*on;
E02       Endif;
B02       If p1 = Pdf_fill ;
             FillN0=*on;
E02       Endif;
B02       If p1 = Pdf_fillevenodd ;
             FillEO=*on;
E02       Endif;
B02       If p1 = Pdf_close ;
             closep=*on;
E02       Endif;
E01    Endif;
B01    If %Parms >= 2;
B02       If p2 = Pdf_stroke ;
             stroke=*on;
E02       Endif;
B02       If p2 = Pdf_fill ;
             FillN0=*on;
E02       Endif;
B02       If p2 = Pdf_fillevenodd ;
             FillEO=*on;
E02       Endif;
B02       If p2 = Pdf_close ;
             closep=*on;
E02       Endif;
E01    Endif;
B01    If %Parms >= 3;
B02       If p3 = Pdf_stroke ;
             stroke=*on;
E02       Endif;
B02       If p3 = Pdf_fill ;
             FillN0=*on;
E02       Endif;
B02       If p3 = Pdf_fillevenodd ;
             FillEO=*on;
E02       Endif;
B02       If p3 = Pdf_close ;
             closep=*on;
E02       Endif;
E01    Endif;
       cherche = FillN0 + FillEO + closep + stroke ;
       Pos = 0;
       Pos = %Scan(cherche:closemode);
B01    If Pos =0;
          Return Latin1(' s ' );
X01    Else;
          Pos+=4;
          Return Latin1(%Subst(closemode:Pos:3)+' ' );
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextOpen     b                   export
     d PdfTextOpen...
     d                 pi                  like(pdfs1)
      /free
B01    If Not Pdfpage.Isopen ;
          Message ('':'Page is not open when PdfTextOpen':'':'':'*DIAG':'':2);
          Pdffile.Withdiag=True;
E01    Endif;
B01    If Pdfpage.Textisopen ;
          //?message ('':'Text is already open when PdfTextOpen':'':'':'*DIAG':'':2);
          //?  pdffile.withdiag=true;
          Return '';
E01    Endif;
       Pdfpage.Textisopen=True;
       Pdffile.Currfont=*null ;
       Pdffile.Textcurrx = 0 ;
       Pdffile.Textcurry = 0 ;
       Return Latin1(' BT ');
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextGoTo     b                   export
     d PdfTextGoTo     pi                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d pdfs            s                   like(pdfs1) static
      /free
       pdfs= %Char(x-Pdffile.Textcurrx) + ' '
          + %Char(y-Pdffile.Textcurry) + ' Td ' ;
       Pdffile.Textcurrx = x ;
       Pdffile.Textcurry = y ;
       Return Latin1(pdfs);
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextMoveTo   b                   export
     d PdfTextMoveTo   pi                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
      /free
       Pdffile.Textcurrx+= x ;
       Pdffile.Textcurry+= y ;
       Return Latin1(%Char(x) + ' ' + %Char(y) + ' Td ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P Pdfcanvas       b                   export
     d PdfCanvas       pi                  like(pdfstream)
     d font                                likeds(PdfFont)
     d Hspace                         5i 0 value
     d Vspace                         5i 0 value
     d i               s              5i 0                 static
     d pdfs            s                   like(pdfcanvas) static
      /free
       //?
       //?   PdfPage.mediabox(3)= 595 ; width
       //?   PdfPage.mediabox(4)= 840 ; height
B01    If Hspace < 0 Or Vspace < 0;
          Return '';
E01    Endif;
       pdfs=Pdfstrmsavegraphicstate();
       pdfs +=PdfStrmFillingColorRGB(1:0:0);
       pdfs +=PdfStrmStrokingColorRGB(1:0:0);
       pdfs +=PdfDrawLineWidth(1);
       pdfs +=PdfDrawDashedLine();
       //?bordure 840 x 595
       pdfs +=PdfDrawAddRectangle( -5: -5
          : Pdfpage.Mediabox(3)+10
          : Pdfpage.Mediabox(4)+10);
       pdfs +=PdfDrawClosePath( Pdf_stroke);
       //?canvas
       pdfs +=PdfStrmFillingColorRGB(0:1:0);
       pdfs +=PdfStrmStrokingColorRGB(0:1:0);
       pdfs +=PdfDrawLineWidth(1);
       pdfs +=PdfDrawDashedLine(2:2);
       //?vertical canevas
B01    For i = 1 To Pdfpage.Mediabox(3) By Hspace*2;
          pdfs +=PdfDrawAddRectangle(i :000:Hspace:Pdfpage.Mediabox(4));
E01    Endfor;
       //?horizontal canevas
B01    For i = 1 To Pdfpage.Mediabox(4) By Vspace*2;
          pdfs +=PdfDrawAddRectangle(000:i :Pdfpage.Mediabox(3):Vspace);
E01    Endfor;
       //?Reset dash pattern to a solid line
       pdfs +=PdfDrawClosePath(Pdf_stroke);
       pdfs +=PdfDrawDashedLine();
       pdfs +=PdfDrawLineWidth(1);

       pdfs+=PdfTextOpen()
          + PdfStrmFillingColorGray(0)
          + PdfStrmStrokingColorGray(0)
          + Pdftextfont(font :Vspace);
       pdfs +=PdfTextGoTo(000:Pdfpage.Mediabox(4)-Vspace);
B01    For i = 1 To Pdfpage.Mediabox(3)-1 By Hspace;
          pdfs +=Pdftextadd(%Char(Pdffile.Textcurrx));
          pdfs +=PdfTextMoveTo(Hspace:000);
E01    Endfor;
       pdfs +=Pdftextclose();
       pdfs +=PdfTextOpen()+ Pdftextfont(font :Vspace);
       pdfs +=PdfTextGoTo(000:Pdfpage.Mediabox(4)-Vspace*2);
B01    For i = 1 To Pdfpage.Mediabox(4)-Vspace*2 By Vspace;
          pdfs +=Pdftextadd(%Char(Pdffile.Textcurry));
          pdfs +=Pdftextnewline();
E01    Endfor;
       pdfs +=Pdftextclose();
       pdfs +=Pdfstrmrestoregraphicstate();
       Return pdfs;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfFontSize     b                   export
     d PdfFontSize     pi             5i 0
      /free
       Return Pdffile.Currfontsize;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfFontName     b                   export
     d PdfFontName     pi           100    varying
      /free
       Ppdffont=Pdffile.Currfont;
       Return Pdffont.Basefont;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextFont     b                   export
     d PdfTextFont...
     d                 pi                  like(pdfs1)
     d font                                likeds(pdffont)
     d size                           5i 0 value
     d lead                           5i 0 value options(*nopass)
    ? * ref1.4 page 304 : leading is the vertical size of the line : dots between two lines.
      /free
B01    If font.Obj = 0;
          Message('PDF0017':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return '';
E01    Endif;

       Pdffile.Currfontsize=size;
       Pdffile.Currfont =%Addr(font) ;
B01    If %Parms = 2;
          Return Latin1(font.Name + ' ' + %Char(size) + ' Tf ') ;
X01    Else;
          Return Latin1(font.Name + ' ' + %Char(size) + ' Tf '+
             %Char(lead) + ' TL ') ;
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextAdd      b                   export
     d PdfTextAdd...
     d                 pi                  like(pdfs3)
     d text                                like(pdfs2) const
     d escaped         s                   like(pdfs2)     static
    ? *debug
     D AsciiData       s          32000           static
     D Hexadata        s          64000           static
     d len             s             10u 0        static
      /free


       Ppdffont=Pdffile.Currfont;
B01    If Pdffont.Name='';
          Message('PDF0011':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       //?text est en EBCDIC
B01    If Pdffont.Isunicode;
          //?escape des ( ) et \ en octal, puis convertion u16


          Return Pdfsymbolize2(U16a(text) );








          //?debug - attention, fait descendre la taille max d'une page à 8000 caracteres
          //?asciidata = u16(text) ;
          //?len = %len(text) * 2;
          //? chr2hex (Hexadata : AsciiData : len) ;
          //?Return latin1('<' + %subst(hexadata:1:len) +'> Tj ') ;

X01    Else;
          escaped = text;
          escaped = Pdfsymbolize(escaped:
             Portablechar.Backslash :
             Portablechar.Backslash + '' +
             Portablechar.Backslash );
          escaped = Pdfsymbolize(escaped:')':
             Portablechar.Backslash + ')');
          escaped = Pdfsymbolize(escaped:'(':
             Portablechar.Backslash + '(');
          Return Latin1('('+escaped+') Tj ') ;
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextAddU8    b                   export
     d PdfTextAddU8...
     d                 pi                  like(pdfs3)
     d text                                like(pdfs2) const
     d escaped         s                   like(pdfs2)     static
    ?d*AsciiStream     s          32000          static
     d stream          ds          2002    qualified
     d u16                                 like(pdfu2)
     d binV                        2000a   varying overlay(u16)
     d cp_n                           5u00 dim(1000) overlay(u16)               pour debugger avec excel
     d len                     1      2i 0
     d bin                     3   2002
     d inputStream     s                   like(pdfS3) static
     d inputLen        s             10i 0       static
     d AsciiLen        s             10i 0       static
     d Len             s             10i 0       static
      /free



       Ppdffont= Pdffile.Currfont;
B01    If Pdffont.Name='';
          Message('PDF0011':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
       //?text est en UTF8
B01    If Pdffont.Isunicode;
          //?convertir le U8 en U16

          //?la longueur du string en UTF8 est en octets, le nb de chars est indéterminé
          inputLen = %Len(text ) ;
          inputStream = text ;
          AsciiLen = %Size(stream.bin ) ;
          len = AsciiLen ;
          rc = Iconv(Pdfhiconvu8u16:
             %Addr(inputStream)+2 : inputLen :
             %Addr(stream.bin ) : AsciiLen );
B02       If rc< 0;
B03          If C_errno <> 0;
                Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
                Pdffile.Withdiag=True;
                len = 0;
E03          Endif;
E02       Endif;
          len = len-AsciiLen ;
          stream.len = Len/2 ;
          if len > 0;
          //?stream.bin  =%Subst(AsciiStream:1: len ) ;
      /IF DEFINED(*V6R1M0)
B02       If Pdffont.Subtype = 'LOADFONT3';
             //?apliquer les substitutions
             Gsub(Pdffont:stream.u16 );
             //?appliquer la convertion BIDI
             if pdffont.forcelre;
             stream.u16= pdflre+stream.u16;
             endif;
             Bidi_p1 = %Addr(stream.bin );
             Bidi_p3 = %Addr( Pdffont.Bc );
             Bidi_p4 = %Addr( Pdffont.Bmg);
             Bidi(Bidi_p1 : stream.len : Bidi_p3 : bidi_p4 ) ;
             if pdffont.forcelre and %subst(stream.u16:1:1)=pdflre;
             stream.u16= %subst(stream.u16:2);
             endif;
E02       Endif;
       /endif
E02       Endif;
          stream.Len*=2;
          Return Pdfsymbolize2( stream.binV );

X01    Else;
          //?best fit convertion from U8 to Latin1

          inputLen = %Len(text ) ;
          inputStream = text ;
          AsciiLen = %Size(stream.bin ) ;
          len = AsciiLen ;
          rc = Iconv(Pdfhiconvu8latin1:
             %Addr(inputStream)+2 : inputLen :
             %Addr(stream.bin ) : AsciiLen );
B02       If rc< 0;
B03          If C_errno <> 0;
                Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
                Pdffile.Withdiag=True;
                len = 0;
E03          Endif;
E02       Endif;
          stream.len = len ;
          escaped = stream.binV ;








          //?(
          escaped = Pdfsymbolize(escaped:x'28' :'' +
             Latin1(Portablechar.Backslash + '000'+
             Portablechar.Backslash + '050'));

          //?)
          escaped = Pdfsymbolize(escaped:x'29' :'' +
             Latin1(Portablechar.Backslash + '000'+
             Portablechar.Backslash + '051'));

          //?\
          escaped = Pdfsymbolize(escaped:x'5c' :'' +
             Latin1(Portablechar.Backslash + '000'+
             Portablechar.Backslash + '134'));

          Return Latin1('(') + escaped + Latin1(') Tj ') ;
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextAddu16   b                   export
     d PdfTextAddu16...
     d                 pi                  like(pdfs3)
     d text                                like(pdfu2) const
     d stream          ds          2002    qualified
    ?d*u16                         1000c   varying                              like(pdfu2)
     d u16                                 like(pdfu2)
     d binV                        2000a   varying overlay(u16)
     d len                     1      2i 0
     d bin                     3   2002
     d escaped         s           2000a   varying based(pescaped)
     d pEscaped        s               *   inz(%addr(stream.binv))

    ?d*AsciiStream     s          32000          static
    ?d*inputStream     s                   like(pdfS3) static
    ?d*inputLen        s             10i 0       static
    ?d*AsciiLen        s             10i 0       static
    ?d*Len             s             10i 0       static



      /free



       Ppdffont=Pdffile.Currfont ;
B01    If Pdffont.Name='';
          Message('PDF0011':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;

B01    If Pdffont.Isunicode;
          //?la longueur du string UTF16 est en caractères
          stream.u16 = text;


         if stream.len > 0;
      /IF DEFINED(*V6R1M0)
B02       If Pdffont.Subtype = 'LOADFONT3';
             //?apliquer les substitutions
             Gsub(Pdffont:stream.u16);
             //?appliquer la convertion BIDI
             if pdffont.forcelre;
             stream.u16= pdflre+stream.u16;
             endif;
             Bidi_p1 = %Addr(stream.bin );
             Bidi_p3 = %Addr( Pdffont.Bc );
             Bidi_p4 = %Addr( Pdffont.Bmg);
             Bidi(Bidi_p1 : stream.len : Bidi_p3 : bidi_p4 ) ;


             if pdffont.forcelre and %subst(stream.u16:1:1)=pdflre;
             stream.u16= %subst(stream.u16:2);
             endif;

E02       Endif;
      /endif
         endif;

          stream.Len*=2;
          Return Pdfsymbolize2(stream.binV) ;

X01    Else;
          //?convertion from U16 to 1252

          escaped = U16latin1(text);
          escaped = Pdfsymbolize(escaped:x'5c':x'5c5c');
          escaped = Pdfsymbolize(escaped:x'28':x'5c28');
          escaped = Pdfsymbolize(escaped:x'29':x'5c29');
          Return Latin1('(')+escaped+Latin1(') Tj ') ;
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=------------------------------------------------------------------------
BPR ?P PdfSymbolize    B
     d PdfSymbolize    pi                  like(pdfs3)
     d  VarName                            like(pdfs3) const
     d  Diacritic                     1    const
     d  NamedSymbol                  25    const varying
     d Symbolized      s                   like(pdfs3)     static
     D Pos             s              5u 0                 static
     D Len             s              5u 0                 static
      /free
       Symbolized = VarName ;
       len = %Len(NamedSymbol);
       Pos = 1 ;
B01    Dow 1=1 ;
B02       If Pos > %Len(Symbolized) ;
             Leave ;
E02       Endif ;
          Eval Pos = %Scan(Diacritic:Symbolized:Pos);
B02       If Pos = 0 ;
             Leave ;
E02       Endif ;
          Symbolized = %Replace(NamedSymbol:Symbolized:
             Pos:1) ;
          Pos = Pos + len ;
E01    Enddo ;
       Return Symbolized ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
    ? *=------------------------------------------------------------------------
    ? *=------------------------------------------------------------------------
BPR ?P PdfSymbolize2   B
     d PdfSymbolize2   pi                  like(pdfs3)
     d  VarName                            like(pdfs3) const

     d intext          s                   like(pdfs3)     static
     d Symbolized      s                   like(pdfs3)     static
     D Pos             s              5u 0                 static
     D Len             s              5u 0                 static
     D i               s              5u 0                 static
    ? * pour scanner InText
     d                 ds             2    based(pU )
     d u11                     1      1
     d u12                     1      2
     d u22                     2      2
     d u                       1      2u00
     d w               s              5i 0
     d x4              s              4                    static

     d SymbolizeAll    s               n   inz(*ON )
    ?d*SymbolizeAll    s               n   inz(*OFF )

      /free
       //?ignorer le premier byte de diacritic
       //?pour tout mot (de 2 octets) ayant un octet egal aux valeurs critiques
       //?remplacer ce mot par sa valeur en hexa
       //?intext est en UTF16
       intext = VarName ;
       //?decouper diacritic en 2 octets
       //
       //?modele à repeter
       //?[<FFFF>] TJ  +x -y Td
       //

       Symbolized =Latin1( Portablechar.Leftbracket);
       pU = %Addr(intext ) ;   //?varying

       len = %Len(intext)/2;   //?utf16 dans du string
B01    For i = 1 To len;
          pU+=2;
          //?If SymbolizeAll Or
          //?      u22 = x'0a' Or
          //?      u22 = x'0d' Or
          //?      u22 = x'28' Or
          //?      u22 = x'29' Or
          //?      u22 = x'5c' Or
          //?      u11 = x'0a' Or
          //?      u11 = x'0d' Or
          //?      u11 = x'28' Or
          //?      u11 = x'29' Or
          //?      u11 = x'5c' ;
          //
          //?remplacer les 2 bytes par namedsymbol

          Chr2hex (x4 : u12 : 4 ) ;
          //?   Symbolized+=Latin1(')<' + x4 + '>(');
          Symbolized += Latin1('<' + x4 + '>' );
      /IF DEFINED(*V6R1M0)
          //?avancer X de char width
B02       If u <> 0;
B03          If Pdffont.Adjust(u) <> 0;
                w = Pdffont.Adjust(u) ;   //?/ 1000 * Pdffile.Currfontsize;
                //?symbolized+=Latin1(%Char(-pdffont.adjust(u)    )) ;
E03          Endif;
E02       Endif;
      /endif
          //?Else;
          //?   //?recopier les 2 bytes
          //?   Symbolized+=u12;
          //?Endif;
E01    Endfor;
       Symbolized+=Latin1( Portablechar.Rightbracket+' TJ ') ;
       Return Symbolized ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
    ? *=------------------------------------------------------------------------
BPR ?P PdfTextNewLine  b                   export
     d PdfTextNewLine...
     d                 pi                  like(pdfs1)
     d retval          s                   like(pdfs1)
      /free
       //?goto next line, vertically aligned to previous line
       Pdffile.Textcurry -= Pdffile.Currfontsize;
       //?return '0 '+%char(PdfFile.currfontsize*-1)+' Td'+crlf;
       //?TODO : verifier si T* ferait le boulot
       retval= ' 0 '+%Char(Pdffile.Currfontsize*-1)+' Td ';
       Return Latin1(retval);
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=------------------------------------------------------------------------
BPR ?P PdfTextToLeft   b                   export
     d PdfTextToLeft...
     d                 pi                  like(pdfs1)
     d retval          s                   like(pdfs1)
      /free
       //?goto left margin
       retval= ' ' + %Char(Pdffile.Textcurrx*-1) + ' 0 Td ';
       Pdffile.Textcurrx = 0;
       Return Latin1(retval);
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfTextRendering...
BPR ?P                 b                   export
     d PdfTextRendering...
     d                 pi                  like(pdfs1)
     d p1                                  like(pdfs1) const options(*nopass)
     d p2                                  like(pdfs1) const options(*nopass)
     d stroke          s               n   inz(*off)
     d fill            s               n   inz(*off)
      /free
B01    If %Parms = 0;
          Return Latin1('2 Tr ') ;
E01    Endif;
B01    If %Parms >= 1;
B02       If p1 = Pdf_stroke ;
             stroke=*on;
E02       Endif;
B02       If p1 = Pdf_fill;
             fill = *on;
E02       Endif;
E01    Endif;
B01    If %Parms >= 2;
B02       If p2 = Pdf_stroke ;
             stroke=*on;
E02       Endif;
B02       If p2 = Pdf_fill;
             fill = *on;
E02       Endif;
E01    Endif;
B01    Select;
X01       When fill And stroke;
             Return Latin1('2 Tr ') ;
X01       When fill ;
             Return Latin1('0 Tr ') ;
X01       When stroke;
             Return Latin1('1 Tr ') ;
X01       Other ;
             Return Latin1('3 Tr ') ;
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextClose    b                   export
     d PdfTextClose...
     d                 pi                  like(pdfs1)
      /free
B01    If Not Pdfpage.Textisopen ;
          //?message ('':'Text is not open when PdfTextClose':'':'':'*DIAG':'':2);
          //?pdffile.withdiag=true;
          Return '';
E01    Endif;
       Pdfpage.Textisopen=False;
       Return Latin1('ET ' );
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ?P*                b
    ? *free
    ? *begsr *pssr;
    ? *dump;
    ? *endsr;
    ? *end-free
    ?P*                e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfStrmSkew     b                   export
     d PdfStrmSkew...
     d                 pi                  like(pdfs1)
     d alpha                          8f   value
     d beta                           8f   value
     d tanA            s              8f         static
     d tanB            s              8f         static
     d tanA3           s              5p 3       static
     d tanB3           s              5p 3       static
    ? *Angle en radian = pi * (angle en degré) / 180
    ? *Skew is specified by : 1 tana tanß 1 0 0 cm ; a = angle x ß = angle y
      /free
       tanA = C_tan (C_pi * alpha / 180);
       tanB = C_tan (C_pi * beta / 180);
       tanA3=%Dec(tanA:5:3);
       tanB3=%Dec(tanB:5:3);
       Return Latin1('1 '+%Editc(tanA3:'P') + ' ' +
          %Editc(tanB3:'P') + ' 1 0 0 cm ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfStrmScale    b                   export
     d PdfStrmScale...
     d                 pi                  like(pdfs1)
     d x                              7p 2 value
     d y                              7p 2 value
    ? *Scaling is obtained by : sx 0 0 sy 0 0 cm : 1x new unit = sx old unit
      /free
       Return Latin1(%Editc(x:'P') + ' 0 0 ' +
          %Editc(y:'P') + ' 0 0 cm ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfStrmRotate   b                   export
     d PdfStrmRotate...
     d                 pi                  like(pdfs1)
     d alpha                          8f   value
     d cos             s              8f         static
     d sin             s              8f         static
     d Cos3            s              5p 3       static
     d Sin3            s              5p 3       static
    ? *Rotations are produced by : cos? sin? -sin? cos? 0 0 cm ; ? = angle count
      /free
       cos = C_cos (C_pi * alpha / 180);
       sin = C_sin (C_pi * alpha / 180);
       Cos3=%Dec(cos:5:3);
       Sin3=%Dec(sin:5:3);
       Return Latin1( %Editc(Cos3:'P')+' '+%Editc(Sin3:'P') + ' ' +
          %Editc(Sin3*-1:'P') + %Editc(Cos3:'P')+ ' 0 0 cm ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmTranslate...
BPR ?P                 b                   export
     d PdfStrmTranslate...
     d                 pi                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
    ? *translation : tx ty m ou 1 0 0 1 tx ty cm
      /free
       Return Latin1('1 0 0 1 '+%Char(x)+' '+%Char(y) + ' cm ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmRestoreGraphicState...
BPR ?p                 b                   export
     d PdfStrmRestoreGraphicState...
     d                 pi                  like(pdfs1)
      /free
       Return Latin1(' Q ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfTextRestoreGraphicState...
BPR ?p                 b
     d PdfTextRestoreGraphicState...
     d                 pi                  like(pdfs1)
      /free
B01    If Pdfpage.Textisopen ;
          Message ('':'Text is already open when PdfStrmRestoreGraphicState'
             :'':'':'*DIAG':'':2);
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(' Q ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawRestoreGraphicState...
BPR ?p                 b
     d PdfDrawRestoreGraphicState...
     d                 pi                  like(pdfs1)
      /free
       Return ' Q ' ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmSaveGraphicState...
BPR ?p                 b                   export
     d PdfStrmSaveGraphicState...
     d                 pi                  like(pdfs1)
      /free
       Return Latin1(' q ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfTextSaveGraphicState...
BPR ?p                 b
     d PdfTextSaveGraphicState...
     d                 pi                  like(pdfs1)
      /free
B01    If Pdfpage.Textisopen ;
          Message ('':'Text is already open when PdfStrmSaveGraphicState'
             :'':'':'*DIAG':'':2);
          Pdffile.Withdiag=True;
E01    Endif;
       Return Latin1(' q ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfDrawSaveGraphicState...
BPR ?p                 b
     d PdfDrawSaveGraphicState...
     d                 pi                  like(pdfs1)
      /free
       Return Latin1(' q ') ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewPage      b                   export
     d PdfNewPage      pi
     d theformat                           like(PdfS1) const
     d thetitle                            like(PdfS1) const
     d   width                        5i 0 const options(*nopass)
     d   height                       5i 0 const options(*nopass)
     d p_leftmargin                   5i 0 const options(*nopass)
     d p_rightmargin                  5i 0 const options(*nopass)
     d p_topmargin                    5i 0 const options(*nopass)
     d p_bottommargin                 5i 0 const options(*nopass)
     d   leftmargin    s              5i 0
     d   rightmargin   s              5i 0
     d   topmargin     s              5i 0
     d   bottommargin  s              5i 0
      /free
       Clear Pdfpage;
       leftmargin = 0 ;
       rightmargin = 0 ;
       topmargin = 0 ;
       bottommargin = 0 ;
B01    If %Parms >= 5;
          leftmargin = p_leftmargin;
          rightmargin = leftmargin ;
          topmargin = leftmargin ;
          bottommargin = leftmargin ;
E01    Endif;
B01    If %Parms >= 6;
          topmargin = p_topmargin;
          bottommargin = topmargin ;
E01    Endif;
B01    If %Parms >= 7;
          rightmargin = p_rightmargin;
E01    Endif;
B01    If %Parms >= 8;
          bottommargin = p_bottommargin;
E01    Endif;
       Pdfpage.Margin (1)=leftmargin ;
       Pdfpage.Margin (2)=rightmargin ;
       Pdfpage.Margin (3)=topmargin ;
       Pdfpage.Margin (4)=bottommargin ;
       Pdfpage.Obj = Pdfnewobj( );
       Pdfpage.Parent=Pdfpages.Obj;
       Pdfpage.Title = thetitle;
       Pdfpage.Mediabox(1)=0;
       Pdfpage.Mediabox(2)=0;
B01    Select ;
X01       When theformat=Pdf_custom ;
             Pdfpage.Mediabox(3)= width;
             Pdfpage.Mediabox(4)= height;
X01       When theformat=Pdf_a4portrait;
             Pdfpage.Mediabox(3)= 595 ;
             Pdfpage.Mediabox(4)= 840 ;
X01       When theformat=Pdf_a4landscape;
             Pdfpage.Mediabox(3)= 840 ;
             Pdfpage.Mediabox(4)= 595 ;
X01       Other;
             Pdfpage.Mediabox(3)= 595 ;
             Pdfpage.Mediabox(4)= 840 ;
E01    Endsl;
       Pdffile.Drawcurrx = 0;
       Pdffile.Textcurrx = 0;
       Pdffile.Currcondsize = 100;
       Pdffile.Drawcurry = Pdfpage.Mediabox(4);
       Pdffile.Textcurry = Pdfpage.Mediabox(4);
       Pdfpages.Count+=1;
       Pdfpages_kids(Pdfpages.Count: Pdfpage.Obj);
       Pdfpage.Isopen = True;
       Pdfpage.Textisopen = False;
       Pdffile.Currfont=*null ;
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewOutLine   b                   export
     d PdfNewOutLine   pi
     d thetitle                            like(PdfS1) const
      /free
       Pdfoutlines.Last = Pdfoutlines.Next;
       Pdfoutlines.Next = Pdfnewobj( );
       Pdfoutlines.Count+=1;
       Pdfoutlines.Lastpage=Pdfpage.Obj;
       Pdffile_xref(Pdfoutlines.Last : Pdfbytescount);

       Pdfwrite(Pdfwobj(Pdfoutlines.Last)+'obj << /Parent '
          + Pdfwobj(Pdfoutlines.Obj)+'R'
          + ' /Title (' );
       Pdfbinwrite( thetitle : 0 );
       //?  pdfwrite(    thetitle       );
       Pdfwrite(')'
          + ' /Next ' + Pdfwobj(Pdfoutlines.Next)+'R'
          + ' /Dest ' +
          Portablechar.Leftbracket + ''+ Pdfwobj(Pdfpage.Obj )+'R /XYZ '
          + %Trim(%Editc(Pdffile.Textcurrx:'P')) + ' '
          + %Trim(%Editc(Pdffile.Textcurry:'P'))
          +' 0' +
          Portablechar.Rightbracket + ' >> endobj'+Crlf);
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfLoadContent  b                   export
     d PdfLoadContent  pi                  likeds(pdfContent)
     d   thestream                         like(pdfS3) const
     d   inHexa                        n   options(*nopass) const
     d theContent      ds                  likeds(pdfContent)
    ? * returns char representation of any hexadecimal string
     D Chr2Hex         Pr                  ExtProc('cvthc')
     D  Tgt                            *   value
     D  Src                            *   value
     D  TgtLen                       10i 0 Value
     d AsciiStream     s          32000          static
     d inputStream     s                   like(pdfS3) static
     d Len             s             10i 0       static
     d     lenobj      s                   like(pdfobj)
     d pTheStream      s               *         static
      /free

B01    If %Len(thestream)>= 65000;
          //?pour faire sauter cette limite, regler d'abord le pb de cryptage des grosses images
          Message('PDF0015':'':'':'JPLTOOLS');
          Dumpcallstack();
          Pdffile.Withdiag=True;
E01    Endif;
B01    If %Parms > 1 And inHexa = *on;
          len = %Len(thestream) ;
          inputStream = thestream ;
          AsciiStream = thestream ;
          //?rc = Iconv(PdfhiconvLatin1 :
          //?   %Addr(inputStream)+2 : len :
          //?   %Addr(AsciiStream) : len );
          //?If rc< 0;
          //?   If C_errno <> 0;
          //?      Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
          //?      Pdffile.Withdiag=True;
          //?      len = 0;
          //?   Endif;
          //?Endif;
          len = %Len(thestream) *2;
          %Len(theContent.stream)=len;
          theContent.Length = len ;
          Chr2Hex ( %Addr(theContent.stream)+2:
             %Addr(AsciiStream):
             len );
          theContent.Obj = Pdfnewobj( );
          lenobj = Pdfnewobj( );
          Pdffile_xref(theContent.Obj : Pdfbytescount);





          Pdfwrite(Pdfwobj(theContent.Obj)+'obj << /Length '
             + Pdfwobj( lenobj)
             + 'R /Filter  /ASCIIHexDecode'
             + '>> stream' + Crlf);
X01    Else;
          theContent.stream = thestream;
B02       If Pdffile.Encrypted;
             //?conflit avec l'unicode, pas de crfl dans un stream
             //?theContent.stream = PdfSymbolize(theContent.stream:x'0d':'');
             //?theContent.stream = PdfSymbolize(theContent.stream:x'0a':x'20');
E02       Endif;
          theContent.Length = %Len(theContent.stream);
          theContent.Obj = Pdfnewobj( );
          lenobj = Pdfnewobj( );
          Pdffile_xref(theContent.Obj : Pdfbytescount);




          Pdfwrite(Pdfwobj(theContent.Obj)+'obj << /Length '
             + Pdfwobj( lenobj)
             + 'R>> stream' + Crlf);
E01    Endif;
       theContent.Length = Pdfbinwrite(theContent.stream: 1 );
       Pdfwrite( 'endstream'+Crlf+'endobj'+Crlf);
       Pdffile_xref( lenobj : Pdfbytescount);

       Pdfwrite(Pdfwobj( lenobj)+'obj '
          + %Editc(theContent.Length:'P') + ' endobj' + Crlf);
       Return theContent;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfCloseResource...
BPR ?p                 b                   export
     d PdfCloseResource...
     d                 pi
     d theResource                         likeds(PdfResource)
      /free
       theresource.Obj = Pdfnewobj( );
       Pdffile_xref(theresource.Obj : Pdfbytescount);

       Pdfwrite(Pdfwobj(theresource.Obj)+'obj << /ProcSet ' +
          Portablechar.Leftbracket + ''
          + theresource.Procset + '' +
          Portablechar.Rightbracket + '');
B01    If %Len(theresource.Xobject) <> 0 ;
          Pdfwrite(' /XObject <<' + theresource.Xobject + '>> ');
E01    Endif;
B01    If %Len(theresource.font ) <> 0 ;
          Pdfwrite(' /Font <<' + theresource.font + ' >> ');
E01    Endif;
       Pdfwrite('>> endobj' + Crlf);
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfResourceAddImage...
BPR ?p                 b                   export
     d PdfResourceAddImage...
     d                 pi
     d theResource                         likeds(PdfResource)
     d theimage                            likeds(pdfImage) const
      /free
B01    If theImage.Preloaded = ' ';   //?neither '0' nor '1'
          Message('PDF0016':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
          Return;
E01    Endif;
       theresource.Xobject += theImage.Name + ' '
          + Pdfwobj(theImage.Obj)+' R ';
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfResourceAddFont...
BPR ?p                 b                   export
     d PdfResourceAddFont...
     d                 pi
     d theResource                         likeds(PdfResource)
     d thefont                             likeds(pdfFont) const
      /free
       theresource.font += ' ' + thefont.Name + ' '
          + Pdfwobj(thefont.Obj)+'R';
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewResource  b                   export
     d PdfNewResource  pi                  likeds(PdfResource)
     d   theProcSet                        likeds(pdfProcSet) const
     d theResource     ds                  likeds(PdfResource)
      /free
       Clear theresource;
B01    For Ifor = 1 To theProcSet.Count;
          theresource.Procset += theProcSet.Set(Ifor);
E01    Endfor;
       theresource.Procset = %Trim(theresource.Procset);
       Return theresource;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfProcSetAdd   b                   export
     d PdfProcSetAdd   pi
     d   theProcSet                        likeds(pdfProcSet)
     d   Theproc                           like(pdfS1) const
      /free
B01    If Theproc = Pdf_procpdf Or
             Theproc = Pdf_proctext Or
             Theproc = Pdf_procimageb Or
             Theproc = Pdf_procimagec Or
             Theproc = Pdf_procimagei ;
          theProcSet.Count +=1;
          theProcSet.Set(theProcSet.Count)='/' + Theproc+ ' ';
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfLoadProcset  b                   export
     d PdfLoadProcset  pi                  likeds(pdfProcSet)
     d p1                                  like(pdfs1) const options(*nopass)
     d p2                                  like(pdfs1) const options(*nopass)
     d p3                                  like(pdfs1) const options(*nopass)
     d p4                                  like(pdfs1) const options(*nopass)
     d p5                                  like(pdfs1) const options(*nopass)
     d TheProcSet      ds                  likeds(pdfProcSet)
      /free
       Clear theProcSet;
B01    If %Parms >= 1;
          PdfProcSetAdd(theProcSet:p1);
E01    Endif;
B01    If %Parms >= 2;
          PdfProcSetAdd(theProcSet:p2);
E01    Endif;
B01    If %Parms >= 3;
          PdfProcSetAdd(theProcSet:p3);
E01    Endif;
B01    If %Parms >= 4;
          PdfProcSetAdd(theProcSet:p4);
E01    Endif;
B01    If %Parms >= 5;
          PdfProcSetAdd(theProcSet:p5);
E01    Endif;
       Return theProcSet;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? * load one of the 14 internal type1 font
    ? *=---------------------------------------------------------------=*
BPR ?P PdfLoadFont1    b                   export
     d PdfLoadFont1    pi                  likeds(pdfFont)
     d name                                like(pdfs1) const
     d font                                like(pdfs1) const
     d attr1                               like(pdfs1) const options(*nopass)
     d attr2                               like(pdfs1) const options(*nopass)
     d attr3                               like(pdfs1) const options(*nopass)
     d TheFONT         ds                  likeds(pdfFont)
     d FixedPitch      s               n   inz(*off)
     d bold            s               n   inz(*off)
     d italic          s               n   inz(*off)
     d Courier         s               n   inz(*off)
     d Helvet          s               n   inz(*off)
     d Times           s               n   inz(*off)
     d Symbol          s               n   inz(*off)
     d zapf            s               n   inz(*off)
     d
      /free
       Clear thefont;
       thefont.Isunicode=False;
B01    If %Subst(name : 1 : 1) = '/';
          thefont.name = name;
X01    Else;
          thefont.name='/' + name;
E01    Endif;
B01    If font = Pdf_courier;
          Courier=*on;
E01    Endif;
B01    If font = Pdf_helvet;
          Helvet = *on;
E01    Endif;
B01    If font = Pdf_times ;
          Times = *on;
E01    Endif;
B01    If font = Pdf_symbol ;
          Symbol = *on;
E01    Endif;
B01    If font = Pdf_zapf ;
          zapf = *on;
E01    Endif;
B01    If %Parms >= 3;
B02       If attr1 = Pdf_bold;
             bold = *on;
E02       Endif;
B02       If attr1 = Pdf_italic;
             italic = *on;
E02       Endif;
B02       If attr1 = Pdf_fixedpitch;
             FixedPitch = *on;
E02       Endif;
E01    Endif;
B01    If %Parms >= 4;
B02       If attr2 = Pdf_bold;
             bold = *on;
E02       Endif;
B02       If attr2 = Pdf_italic;
             italic = *on;
E02       Endif;
B02       If attr2 = Pdf_fixedpitch;
             FixedPitch = *on;
E02       Endif;
E01    Endif;
B01    If %Parms >= 5;
B02       If attr2 = Pdf_bold;
             bold = *on;
E02       Endif;
B02       If attr2 = Pdf_italic;
             italic = *on;
E02       Endif;
B02       If attr3 = Pdf_fixedpitch;
             FixedPitch = *on;
E02       Endif;
E01    Endif;
       thefont.Subtype='/Type1';
B01    Select;
X01       When Courier And bold And italic;
             thefont.Basefont = '/Courier-BoldOblique';
X01       When Courier And italic;
             thefont.Basefont = '/Courier-Oblique';
X01       When Courier And bold ;
             thefont.Basefont = '/Courier-Bold';
X01       When Courier ;
             thefont.Basefont = '/Courier';
X01       When Helvet And bold And italic;
             thefont.Basefont = '/Helvetica-BoldOblique';
X01       When Helvet And italic;
             thefont.Basefont = '/Helvetica-Oblique';
X01       When Helvet And bold ;
             thefont.Basefont = '/Helvetica-Bold';
X01       When Helvet ;
             thefont.Basefont = '/Helvetica';
X01       When Times And bold And italic;
             thefont.Basefont = '/Times-BoldItalic';
X01       When Times And italic;
             thefont.Basefont = '/Times-Italic';
X01       When Times And bold ;
             thefont.Basefont = '/Times-Bold';
X01       When Times ;
             thefont.Basefont = '/Times-Roman';
X01       When Symbol ;
             thefont.Basefont = '/Symbol';
X01       When zapf ;
             thefont.Basefont = '/ZapfDingbats';
X01       Other ;
             thefont.Basefont = '/Unknown';
             Message('PDF0001':font:'':'JPLTOOLS');
             Pdffile.Withdiag=True;
E01    Endsl;
       //?theFont.subtype='/Type1';
       thefont.Encoding='/WinAnsiEncoding';
       //?flush to file
       thefont.Obj = Pdfnewobj();
       Pdffile_xref(thefont.Obj : Pdfbytescount);

       //?note to jpl : gestion du symbole euro
       //?remplacer le code actuel
       //?
       //?5 0 obj << /Type /Font /Subtype /Type1 /Name /F1 /BaseFont /Courier /Encoding
       //?           /WinAnsiEncoding >> endobj
       //?
       //?par un truc comme ça
       //?
       //?   8 0 obj
       //?   <<
       //?   /Type /Encoding
       //?   /BaseEncoding /WinAnsiEncoding
       //?   /Differences ' +
       //?          PortableChar.LeftBracket + ' 164 /Euro ' +
       //?          PortableChar.RightBracket + '
       //?   >>
       //?   endobj
       //?
       //?   9 0 obj
       //?   <<
       //?   /Type /Font
       //?   /Subtype /Type1
       //?   /Name /F1
       //?   /BaseFont /Courier
       //?   /Encoding 8 0 R
       //?   >>
       //?
B01    If ( FixedPitch );
          Pdfwrite(Pdfwobj(thefont.Obj)+'obj << /Type /Font /Subtype '+
             thefont.Subtype + ' /Name ' + thefont.name + ' /BaseFont ' +
             thefont.Basefont + ' /FirstChar 0 /LastChar 255 /Widths ' +
             '' +
             Portablechar.Leftbracket +
             '0700 0700 0700 0700 0700 0700 0700 0700 0700 0000 ' +
             ' 0000 0700 0700 0000 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700 0700 0700 0700 0700' +
             ' 0700 0700 0700 0700 0700 0700' +
             Portablechar.Rightbracket +
             ' /Encoding ' + thefont.Encoding +
             ' >> endobj' + Crlf);
          //?that's for PdfTextStrLen : it will use a fixed length for calculation
          thefont.Basefont = Pdf_fixedpitch;
X01    Else;
          Pdfwrite(Pdfwobj(thefont.Obj)+'obj << /Type /Font /Subtype '+
             thefont.Subtype + ' /Name ' + thefont.name + ' /BaseFont ' +
             thefont.Basefont + ' /Encoding ' + thefont.Encoding +
             ' >> endobj' + Crlf);
E01    Endif;
       Return thefont;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? * load an external unembbedded unicode font
    ? *=---------------------------------------------------------------=*
BPR ?P PdfLoadFont2    b                   export
     d PdfLoadFont2    pi                  likeds(pdfFont)
     d name                                like(pdfs1) const
     d basefont                            like(pdfs1) const
     d encoding                            like(pdfs1) const


     d TheFONT         ds                  likeds(pdfFont)
     d ObjDesc         s                   like(pdfobj)
     d ObjCid          s                   like(pdfobj)

     d i               s              5u 0





     d
      /free
       Clear thefont;
       thefont.Isunicode=True ;
B01    If %Subst(name : 1 : 1) = '/';
          thefont.name = name;
X01    Else;
          thefont.name='/' + name;
E01    Endif;
B01    If basefont = Pdf_adobepistd
X01    Or basefont = Pdf_arialunicodems;
          thefont.basefont = basefont;
X01    Else;
          thefont.basefont = '/Unknown';
          Message('PDF0001':basefont:'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;

B01    If encoding = Pdf_unicns
X01    Or encoding = Pdf_unigb
X01    Or encoding = Pdf_unijis
X01    Or encoding = Pdf_uniks;
X01    Else;
          thefont.encoding = '/Unknown';
          Message('PDF0019':encoding:'':'JPLTOOLS');
          Pdffile.Withdiag=True;

E01    Endif;
       thefont.Subtype='/Type0';
       thefont.encoding=encoding;
       //?flush to file
       //?the descriptor
       ObjDesc = Pdfnewobj();
       Pdffile_xref( ObjDesc : Pdfbytescount);


B01    If basefont = Pdf_adobepistd ;

          Pdfwrite(Pdfwobj( ObjDesc)+'obj <<'
             + ' /Type /FontDescriptor '
             + ' /FontName ' + thefont.basefont
             + ' /Ascent  880 '
             + ' /Descent -120 '
             + ' /CapHeight 1000 '
             + ' /Flags 32 '
             + ' /FontBBox '+Portablechar.Leftbracket
             + '-437  -340 1147 1317' + Portablechar.Rightbracket
             + ' /ItalicAngle 0 '
             + ' /StemV 70 '
             + ' /MissingWidth 1000>> '
             + ' endobj '+Crlf)
             ;
E01    Endif;
B01    If basefont = Pdf_arialunicodems;
          Pdfwrite(Pdfwobj( ObjDesc)+'obj <<'
             + ' /Type /FontDescriptor '
             + ' /FontName ' + thefont.basefont
             + ' /Ascent 1069 '
             + ' /Descent -271 '
             + ' /CapHeight 1069 '
             + ' /Flags 32 '
             + ' /FontBBox '+Portablechar.Leftbracket
             + '-1011 -330 2260 1078' + Portablechar.Rightbracket
             + ' /ItalicAngle 0 '
             + ' /StemV 70 '
             + ' /MissingWidth 750>> '
             + ' endobj '+Crlf)
             ;
E01    Endif;

       //?the CID font and the descriptor
       ObjCid = Pdfnewobj();
       Pdffile_xref( ObjCid : Pdfbytescount);
       Pdfwrite(Pdfwobj( ObjCid)+'obj <<'
          + '/Type /Font '
          + '/Subtype /CIDFontType0 '
          + '/BaseFont ' + thefont.basefont);
B01    Select;
X01       When thefont.encoding=Pdf_unigb ;
             Pdfwrite(' /CIDSystemInfo <</Registry (');
             Pdfbinwrite('Adobe':2);
             Pdfwrite(') /Ordering (');
             Pdfbinwrite('GB1':2);
             Pdfwrite(') /Supplement 5>>');
X01       When thefont.encoding=Pdf_unicns;
             Pdfwrite(' /CIDSystemInfo <</Registry (');
             Pdfbinwrite('Adobe':2);
             Pdfwrite(') /Ordering (');
             Pdfbinwrite('CNS1':2);
             Pdfwrite(') /Supplement 6>>');
X01       When thefont.encoding=Pdf_unijis;
             Pdfwrite(' /CIDSystemInfo <</Registry (');
             Pdfbinwrite('Adobe':2);
             Pdfwrite(') /Ordering (');
             Pdfbinwrite('Japan1':2);
             Pdfwrite(') /Supplement 6>>');
X01       When thefont.encoding=Pdf_uniks ;
             Pdfwrite(' /CIDSystemInfo <</Registry (');
             Pdfbinwrite('Adobe':2);
             Pdfwrite(') /Ordering (');
             Pdfbinwrite('Korea1':2);
             Pdfwrite(') /Supplement 2>>');
E01    Endsl;

       //?font descriptor and character sizes

B01    If basefont=Pdf_adobepistd;
          Pfont = %Addr(Pistd);
          Pdfwrite(
             '/FontDescriptor ' + Pdfwobj( ObjDesc) + 'R '
             + '/DW 1000 ');
X01    Else;
          Pfont = %Addr(Arial);
          Pdfwrite(
             '/FontDescriptor ' + Pdfwobj( ObjDesc) + 'R '
             + '/DW  750 ');
E01    Endif;
       Pdfwrite(
          '/W '+Portablechar.Leftbracket
          + ' 1 '+Portablechar.Leftbracket );

B01    For i = 1 To 224 ;
          Pdfwrite(%Editc( font.size(i):'P'));


E01    Endfor;

       Pdfwrite(
          Portablechar.Rightbracket+' '
          + Portablechar.Rightbracket+' >> '
          +'endobj '+Crlf);





       thefont.Obj = Pdfnewobj();
       Pdffile_xref(thefont.Obj : Pdfbytescount);





       Pdfwrite(Pdfwobj(thefont.Obj)+'obj << '






          + ' /Type /Font '
          + ' /Subtype /Type0 '
          + ' /BaseFont ' + thefont.basefont+ '-'+thefont.encoding
          + ' /Name ' + thefont.name
          + ' /Encoding /' + thefont.encoding
          + ' /DescendantFonts '+Portablechar.Leftbracket
          + Pdfwobj(ObjCid)+ ' R '
          +Portablechar.Rightbracket + '>> '
          + ' endobj '+Crlf);


       Return thefont;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
      /IF DEFINED(*V6R1M0)
    ? *=---------------------------------------------------------------=*
    ? * load a TTF font
    ? *=---------------------------------------------------------------=*
BPR ?P PdfLoadFont3    b                   export
     d PdfLoadFont3    pi
     d name                                like(pdfs1) const
     d pgmname                       21                const
     d ifsname                             like(pdfs2) const
     d TheFONT                             likeds(pdfFont)
    ? *=-----------------------------------
     d CtgDim          c                   const(10000)
     d ctg             ds                  qualified dim(ctgdim)
     d  char                          5u00
     d  glyf                          5u00
     d  width                         5u00
     d FontMetrics     ds                  likeds(fontmetrics_t)
     d XmlStream       s            500    varying
     D FileHandleA     s             10i 0
     d AsciiFrom       S             10i 0 inz(0)
     d myStat          ds                  likeds(statds)
     d ObjTtf          s                   like(pdfobj)
     d ObjToUnicode    s                   like(pdfobj)
     d ObjCid          s                   like(pdfobj)
     d ObjDescriptor   s                   like(pdfobj)
     d ObjCidToGid     s                   like(pdfobj)
    ? * taille en dur pour planter si pdfs3 change de taille
     d buffer          ds         65002    static
     d   info                              like(pdfbuffer)
     d   len                          5u00 overlay(buffer)
     D   AsciiData                65000    overlay(buffer:3    )
     d
     d WidthCurMode    s              5i00
     d WidthNxtMode    s              5i00
     d wcond           ds                  qualified
     d   last                         5u00
     d   width                        5u00
     d iCtg            s             10i00
     d filter          s             50    varying

     d Plugin          pr                  extpgm(pgmname)
     d name                                like(pdfs1) const
     d ifsname                             like(pdfs2) const
     d thefont                             likeds(pdfFont)
     d fontmet                             likeds(fontmetrics  )



      /free


       Plugin
          (name
          :ifsname
          :thefont:FontMetrics );

       thefont.Obj = Pdfnewobj();
       ObjTtf = Pdfnewobj();
       ObjToUnicode = Pdfnewobj();
       ObjCid = Pdfnewobj();
       ObjDescriptor= Pdfnewobj();
       ObjCidToGid = Pdfnewobj();

B01    If %Subst(name : 1 : 1) = '/';
          thefont.name = name;
X01    Else;
          thefont.name='/' + name;
E01    Endif;
       thefont.encoding = 'Identity-H';

       //?font descriptor

       Pdffile_xref(thefont.Obj : Pdfbytescount);
       Pdfwrite(Pdfwobj(thefont.Obj)+'obj << '

          + ' /Type /Font '
          + ' /Subtype /Type0 '
          + ' /BaseFont /'+ thefont.basefont
          + ' /Name ' + thefont.name
          + ' /Encoding /' + thefont.encoding
          + ' /ToUnicode ' + Pdfwobj(ObjToUnicode)+ ' R '
          + ' /DescendantFonts '
          +Portablechar.Leftbracket
          + Pdfwobj(ObjCid)+ ' R '
          +Portablechar.Rightbracket + '>> '
          + 'endobj '+Crlf);

       //?font file ttf or ttf.z

B01    If thefont.Embedfont = 1;

          FileHandleA= Open( %Trim(FontMetrics.Ttffile+'.z')
             : O_rdonly ) ;
B02       If FileHandleA> -1;
          filter = '/Filter /FlateDecode ';
          else;
          filter = '';
          FileHandleA= Open( %Trim(FontMetrics.Ttffile)
             : O_rdonly ) ;
B02       If FileHandleA= -1;
             Message(Errnomsg(Errno()):'':'':'QCPFMSG');
             Pdffile.Withdiag=True;
             Return ;
E02       Endif;
E02       Endif;
          rc = Fstat(FileHandleA : myStat);

          Pdffile_xref(ObjTtf : Pdfbytescount);
          Pdfwrite(Pdfwobj(ObjTtf )+'obj << '
             + '/Length ' + %Char(FontMetrics.Ttffilesize)
             + filter
             + ' /Length1 ' + %Char(myStat.St_size) + ' >> stream' + Crlf);

          AsciiFrom = 0;
B02       For Ever;
             len=Pread (FileHandleA: %Addr(AsciiData)
                : %Size(AsciiData) : AsciiFrom ) ;
             Pdfbinwrite(info:1);
B03          If len < %Size(AsciiData);
                Leave;
E03          Endif;
             AsciiFrom+=len;
E02       Endfor;
          Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
          rc = Close(FileHandleA) ;
E01    Endif;
       //?ToUnicode ressources

       info = '';
       info+=' /CIDInit /ProcSet findresource begin';
       info+=' 12 dict begin';
       info+=' begincmap';
       info+=' /CIDSystemInfo';
       info+=' << /Registry (Adobe) /Ordering (UCS) /Supplement 0 >> def';
       info+=' /CMapName /Adobe-Identity-UCS def';
       info+=' /CMapType 2 def';
       info+=' /WMode 0 def';

       info+=FontMetrics.Cidsysteminfo;
       Pdffile_xref(ObjToUnicode: Pdfbytescount);
       Pdfwrite(Pdfwobj(ObjToUnicode)+'obj <</Length '
          + %Char(%Len(info))+ '>> stream'+Crlf+info
          +' endstream'+Crlf
          +' endobj'+Crlf);


       Pdffile_xref(ObjCid : Pdfbytescount);
       Pdfwrite(Pdfwobj(ObjCid )+'obj <<'
          + ' /Type /Font'
          + ' /Subtype /CIDFontType2'
          + ' /BaseFont /'+thefont.basefont
          + ' /CIDSystemInfo'
          + ' << /Registry (Adobe) /Ordering (Identity) /Supplement 0 >>'
          + ' /FontDescriptor '+ Pdfwobj(ObjDescriptor)+ ' R '

          + ' /DW '+ %Char(FontMetrics.Missingwidth)
          + ' /W '+ Portablechar.Leftbracket + ' '
          + FontMetrics.Cmap);




       Pdfwrite(Portablechar.Rightbracket
          + ' /CIDToGIDMap '+Pdfwobj(ObjCidToGid)+ 'R >> endobj'+Crlf);




       //?fontdescriptor


       Pdffile_xref(ObjDescriptor: Pdfbytescount);
       Pdfwrite(Pdfwobj(ObjDescriptor )+'obj <<'

          + ' /Type /FontDescriptor'
          + ' /FontName /'+thefont.basefont
          + ' /Ascent '+%Char(FontMetrics.Ymax)
          + ' /Descent '+%Char(FontMetrics.Ymin)
          + ' /CapHeight '+%Char(FontMetrics.Capsheight)
          + ' /Flags '+%Char(FontMetrics.Flags)
          + ' /FontBBox '
          + Portablechar.Leftbracket
          + %Char(FontMetrics.Xmin)+' '
          + %Char(FontMetrics.Ymin)+' '
          + %Char(FontMetrics.Xmax)+' '
          + %Char(FontMetrics.Ymax)+' '
          + Portablechar.Rightbracket
          + ' /ItalicAngle '+%Char(FontMetrics.Italicangle)
          + ' /StemV '+%Char(FontMetrics.Stemv)
          + ' /MissingWidth '+%Char(FontMetrics.Missingwidth)
          + ' /FontFile2 '+Pdfwobj(ObjTtf)+' R >>'
          + ' endobj'+Crlf);

       //?fichier ctg ou ctg.z


          FileHandleA= Open( %Trim(FontMetrics.ctgfile+'.z')
             : O_rdonly ) ;
B02       If FileHandleA> -1;
          filter = '/Filter /FlateDecode ';
          else;
          filter = '';
       FileHandleA= Open( %Trim(FontMetrics.Ctgfile)
          : O_rdonly ) ;
B01    If FileHandleA= -1;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG');
          Pdffile.Withdiag=True;
          Return ;
E01    Endif;
E01    Endif;
       rc = Fstat(FileHandleA : myStat);

       Pdffile_xref(ObjCidToGid : Pdfbytescount);
       Pdfwrite(Pdfwobj(ObjCidToGid)+'obj << '
          + '/Length ' + %Char(myStat.St_size)
          + filter
          + ' >> stream' + Crlf);

       AsciiFrom = 0;
B01    For Ever;
          len=Pread (FileHandleA: %Addr(AsciiData)
             : %Size(AsciiData) : AsciiFrom ) ;
          Pdfbinwrite(info:1);
B02       If len < %Size(AsciiData);
             Leave;
E02       Endif;
          AsciiFrom+=len;
E01    Endfor;
       Pdfwrite('endstream'+Crlf+'endobj'+Crlf);
       rc = Close(FileHandleA) ;

       //?memoriser les definitions de fontes, besoin de menage en sortant
B01    If Pdffile.Ifontstack < %Elem(Pdffile.Fontstack);
          Pdffile.Ifontstack+=1;
          Pdffile.Fontstack(Pdffile.Ifontstack)=%Addr(thefont);
E01    Endif;
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
      /endif
    ? *=---------------------------------------------------------------=*
    ? * Pdf Write : convert a object number to text
    ? *=---------------------------------------------------------------=*
BPR ?P PdfWObj         b
     d PdfWObj         pi                  like(pdfs1)
     d Obj                                 like(PdfObj) const
      /free
       Return %Trim(%Editc(Obj:'P'))+' 0 ';
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfClosePages   b                   export
     d PdfClosePages   pi
      /free
       Pdfroot.Pages= Pdfpages.Obj;
       Pdffile_xref(Pdfpages.Obj : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdfpages.Obj)+'obj << /Type /Pages /Count '
          + %Trim(%Editc(Pdfpages.Count:'P'))+ ' /Kids ' +
          Portablechar.Leftbracket + '' );
B01    For Ifor = 1 To Pdfpages.Count ;
          Ppdfkids=Ppdfkidsarray+(Ifor-1)*%size(Pdfobj);
          Pdfwrite(PdfWObj(Pdfkids.Obj )+ 'R ');
E01    Endfor;
       Pdfwrite('' +
          Portablechar.Rightbracket + ' >> endobj'+Crlf);
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfCloseOutLines...
BPR ?p                 b                   export
     d PdfCloseOutLines...
     d                 pi
      /free
       Pdffile_xref(Pdfoutlines.Next : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdfoutlines.Next)+'obj << /Parent '
          + PdfWObj(Pdfoutlines.Obj)+'R '
          + ' /Title (');
       //?pdfBinwrite      ('Last Page':false);
       Pdfbinwrite (' ': 0 );
       //? pdfwrite      ('Last Page');
       Pdfwrite(
          ') /Dest ' +
          Portablechar.Leftbracket +
          PdfWObj(Pdfoutlines.Lastpage)+'R /XYZ 0 0 0' +
          Portablechar.Rightbracket + ' >> '
          +' endobj'+Crlf);

       Pdfroot.Outlines= Pdfoutlines.Obj;
       Pdffile_xref(Pdfoutlines.Obj : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdfoutlines.Obj)+'obj << /Type /Outlines'
          + ' /Count ' + %Trim(%Editc(Pdfoutlines.Count:'P'))
          + ' /First ' + PdfWObj(Pdfoutlines.First) + 'R'
          + ' /Last ' + PdfWObj(Pdfoutlines.Next) + 'R'
          + ' >> endobj'+Crlf);
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfCloseRoot    b                   export
     d PdfCloseRoot    pi
     d p1                                  like(pdfs1) const options(*nopass)
     d PageMode        s                   like(pdfs1)
      /free
B01    If %Parms >= 1;
          PageMode = p1;
X01    Else;
          PageMode = Pdf_none ;
E01    Endif;
B01    Select ;
X01       When PageMode = 'USENONE'
X01       Or PageMode = Pdf_none;
             PageMode = Pdf_none;
X01       When PageMode = 'USEOUTLINES'
X01       Or PageMode = Pdf_outlines;
             PageMode = Pdf_outlines;
X01       When PageMode = 'USETHUMBS'
X01       Or PageMode = Pdf_thumbs;
             PageMode = Pdf_thumbs;
X01       When PageMode = 'FULLSCREEN'
X01       Or PageMode = Pdf_fullscreen;
             PageMode = Pdf_fullscreen;
X01       Other ;
             PageMode = Pdf_none;
E01    Endsl;
       Pdfroot.Obj = Pdfnewobj( );
       Pdffile.Root = Pdfroot.Obj;
       Pdffile_xref(Pdfroot.Obj : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdfroot.Obj)+'obj << /Type /Catalog ') ;
B01    If Pdfroot.Outlines <> 0;
          Pdfwrite('/Outlines '+PdfWObj(Pdfroot.Outlines)+'R '
             + '/PageMode '+ PageMode + ' ');
E01    Endif;
B01    If Pdfroot.Pages <> 0;
          Pdfwrite('/Pages '+PdfWObj(Pdfroot.Pages)+'R ');
E01    Endif;
B01    If Testpdfa;
          Pdfwrite('/MarkInfo<</Marked true>>');
          Pdfwrite('/OutputIntents'+Portablechar.Leftbracket
             +'<</Type/OutputIntent');
          Pdfwrite('/S/GTS_PDFA1');
          Pdfwrite('/OutputConditionIdentifier(sRGB) ');
          Pdfwrite('/RegistryName(http://www.color.org)');
          Pdfwrite('/Info(Creator: HP     Manufacturer:IEC    Model:sRGB)');
          Pdfwrite('>>'+Portablechar.Rightbracket+'');
E01    Endif;
       Pdfwrite('>> endobj'+Crlf);
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewPages     b                   export
     d PdfNewPages     pi
      /free
       Clear Pdfpages;
       Pdfpages.Obj = Pdfnewobj();
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;
       Ppdfkidsarray=%Realloc(Ppdfkidsarray:%Size(Pdfobj));
       Pdfpages.Allockids=1;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewOutlines  b                   export
     d PdfNewOutlines  pi
      /free
       Clear Pdfoutlines;
       Pdfoutlines.Obj = Pdfnewobj();
       Pdfoutlines.First = Pdfnewobj();
       Pdfoutlines.last = Pdfoutlines.First;
       Pdfoutlines.Next = Pdfoutlines.First;
       Pdfoutlines.Count=1;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P pdfNewObj       b
     d pdfNewObj       pi                  like(PdfObj)
      /free
       Pdffile.size+=1;
       //?if allocated space to PdfXrefArray is too short, realloc it
B01    If Pdffile.size > Pdffile.Allocxref;
          Pdffile.Allocxref*=2;
B02       If Pdfinit.Needinit;
             Pdfinz();
E02       Endif;
          Ppdfxrefarray=%Realloc(Ppdfxrefarray:
             Pdffile.Allocxref*%size(Pdfobj));
E01    Endif;
       Return Pdffile.size;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewRoot      b                   export
     d PdfNewRoot      pi
      /free

       //?TODO transferer ici les writes de newfile
       //?creer une proc PdfFileAtr pour les attributs manquants : ccsid, creator,title,

       Clear Pdfroot;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfNewFile      b                   export
     d PdfNewFile      pi
     D  FileName                    512a   varying const
     D  Title                       512a   varying const options(*nopass)
     d  p_permission                 10i 0 options(*nopass) const
     d  p_userpwd                    32    options(*nopass) const
     d  p_OwnerPwd                   32    options(*nopass) const
     d  p_OpenMode                   10i 0 options(*nopass) const
     d    permission   s             10i 0
     d    userpwd      s             32
     d    OwnerPwd     s             32
     d    OpenMode     s             10i 0
     D  Keys           ds
     d  UserKey                      32
     d  OwnerKey                     32
     d  FileId         s             16
     d  longfileid     s            100
     D  len            s              5i 0
      /free
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;
       //?default parameters
B01    If %Parms >= 6;
          OpenMode = p_OpenMode;
X01    Else;
          OpenMode = -1;
E01    Endif;
       //?Initialise conversion table
       Tblascii = Inztblascii();   //?TODO passer par iConv
       Clear Pdffile ;
       //?cleanup previous usage of sortArray
       //? if pPdfXrefArray <> *null;
       //?    dealloc pPdfXrefArray;
       //? endif;
       Ppdfxrefarray=%Realloc(Ppdfxrefarray:%Size(Pdfobj));
       Pdffile.Allocxref=1;
       //?
       Pdffile.FileName = FileName;
       Pdfopen(FileName:OpenMode);
       Pdfbytescount=0;
       Pdfbufflen=-10;
       Pdfbufflen=50000;
       Pdffile.Version='PDF-1.7';
       Pdffile.First =1 ;
       Pdffile.Creator='/';
       Pdffile.Creator='undefined attribute';
       Pdffile.Title='undefined attribute';
       Pdffile.Creationdate = 'D:' +%Subst(%Char(%Timestamp():*iso0):1:14)
          + '+01''00''';   //?GMT+1 hardcoded -> sysval QUTCOFFSET
       Pdffile.Author= %Char(Spjbnb)+'/'+%Trim(Spjbus)+'/'+%Trim(Spjbnm);
B01    If %Parms >= 2;
          Pdffile.Title=Title;
E01    Endif;
       Pdffile.Producer='JPLTools20110204';
       Pdffile.Currcondsize = 100;

       //?le marqueur de UTF8  (BOM=Byte Order Mark)
       //?surtout pas ! c'est pas de l'utf8, c'est du binaire.
       //?pdfbinwrite(x'EFBBBF':3 );
       Pdfwrite('%' + Pdffile.Version + '%âãÏÓÚ' + Portablechar );
       //? pdfwrite('âä@áãå\ñ°.<(+! &{êë}íîïìß§$*);^ -/ÂÄÀÁÃÅÇÑù,%_>? øÉÊËÈÍÎÏ');
       //? pdfwrite('Ìµ:£à''="Øabcdefghi«»ðýþ±[jklmnopqr');
       //? pdfwrite('ªºæ¸Æ?`¨stuvwxyz¡¿ÐÝÞ®¢#¥·');
       //? pdfwrite('©]¶¼½¾¬|¯~´×éABCDEFGHI­ôöòóõèJKLMNOPQR¹ûü¦úÿç÷STUVWXYZ²ÔÖÒÓÕ');
       //? pdfwrite('0123456789³ÛÜÙÚ This long dirty comment text is here to '
       //?    +'explain to windows that this file is not unicode '
       //?    +'but just classic ANSI ASCII code page 1252');
       Pdfwrite(Crlf);
       Pdffile.Withdiag = False;
       //?initialize encryption, if necessary : permission is required
       //?permission mask (32 bits)
       //?33322222222221111111111000000000
       //?21 987654321 987654321 987654321
       //?11111111111111111111    11    00 reserved, fixed values
       //?                -4           100 print , draft see bit 12
       //?                -8          1000 modify, see 6, 9, 11
       //?               -16         10000 copy & extract, see 10
       //?               -32        100000 annotation, fill form
       //?              -256     100000000 fill form
       //?              -512    1000000000 extract
       //?             -1024   10000000000 assemble
       //?             -2048  100000000000 print high quality
       //?for a field defined 10i 0,
       //?-3392 = x'FFFFF2C0' = b'11111111111111111111001011000000' = all forbidn but extract V3
       //?  -64 = x'FFFFFFC0' = b'11111111111111111111111111000000' = all forbidn V2
       //?   -4 = x'FFFFFFFC' = b'11111111111111111111111111111100' = all allowed
B01    If %Parms <=2;
          Pdffile.Encrypted=False;
X01    Else;
          Pdffile.Encrypted=True ;
E01    Endif;
B01    If %Parms <= 2;
          permission= 0 ;
X01    Else;
          permission=p_permission;
E01    Endif;
       Pdffile.permission=permission;
B01    If permission > -4;
          Pdffile.Encrypted=False;
X01    Else;
          Pdffile.Encrypted=True ;
E01    Endif;
       //?
       //?en v5r2 : cryptage désactivé
       //?
       //?
       //?
       //?system info : into PdfInz()
B01    If Pdfinit.Osversion <= 'V5R2M0' And Pdffile.Encrypted=True;
          Message ('':'Release ' + Pdfinit.Osversion
             + ' don''t handle encryption':'':'*DIAG') ;
          Pdffile.Encrypted=False;
E01    Endif;
       //?
       //?
       //?
       //?
       //?
       //?generate a fileid
       longfileid = %Char(%Timestamp()) + FileName;
       len=%Len(%Trimr(longfileid));
       FileId= Md5hash(x'00':longfileid:len) ;
       //?for test, use a fixed fileid
       //?FileId    =X'11111111222222223333333344444444';
       //?FileId    =X'7DFBC405ACAF5A0A4344EBA28725205F';
       Chr2Hex(Pdffile.FileId : FileId : 32 );
       //?get password, if trasmitted
B01    If %Parms >= 4;
          userpwd = p_userpwd;
X01    Else;
          userpwd='';
E01    Endif;
B01    If %Parms >= 5;
          OwnerPwd = p_OwnerPwd;
X01    Else;
          OwnerPwd='';
E01    Endif;
       //?compute the encoding keys
B01    If Pdffile.Encrypted ;
          Keys=Compute_keys(
             '3'
             :FileId
             :permission
             :userpwd
             :OwnerPwd);
          Chr2Hex(Pdffile.UserKey:UserKey : 64 );
          Chr2Hex(Pdffile.OwnerKey:OwnerKey : 64 );
X01    Else;
          Chr2Hex(Pdffile.UserKey:FileId : 64 );
          Chr2Hex(Pdffile.OwnerKey:FileId : 64 );
E01    Endif;
       //?write the file information object
       Pdffile.info = pdfNewObj();
       Pdffile_xref(Pdffile.info : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdffile.info )+'obj <<');
       Pdfwrite(' /Creator (') ;   //?attribute Application in PDF properties
       //?pdfbinwrite( pdffile.creator :false);
       Pdfwrite(')');
       Pdfwrite(' /CreationDate (') ;
       Pdfbinwrite( Pdffile.Creationdate : 0 );
       Pdfwrite(')');
       Pdfwrite(' /Title (');
       //?pdfbinwrite( pdffile.Title : false);
       Pdfwrite(')');
       Pdfwrite(' /Producer (');
       Pdfbinwrite( Pdffile.Producer : 0 );
       Pdfwrite(')');
       Pdfwrite(' /Keywords (');
       //? pdfbinwrite('undefined attribute' : false);
       Pdfwrite(')');
       Pdfwrite(' /ModDate (');
       Pdfbinwrite( Pdffile.Creationdate : 0 );
       Pdfwrite(')');
       Pdfwrite(' /Subject (');
       //? pdfbinwrite('undefined attribute' : false);
       Pdfwrite(')');
       Pdfwrite(' /Author (');
       Pdfbinwrite( Pdffile.Author : 0 );
       Pdfwrite(')');
       Pdfwrite('>> endobj'+Crlf);
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfCloseFile    b                   export
     d PdfCloseFile    pi
     d x10             ds                        static
     d  n10                          10s 0
     d x32             s             32          static

     d i               s              5i00
      /free
       //?write the encryption obj
       //? if pdffile.encrypted;
       Pdffile.Encrypt= pdfNewObj();
       Pdffile_xref(Pdffile.Encrypt : Pdfbytescount);

       Pdfwrite(PdfWObj(Pdffile.Encrypt )+'obj <<'
          + '/Filter /Standard /V 2 /R 3 /Length 128 ');
       //? hex2chr(x32:pdffile.ownerkey:64);
       //? PdfBinWrite(x32 : true);
       //? PdfWrite(')');
       Pdfwrite('/O <' + Pdffile.OwnerKey + '> ');
       //? PdfWrite(') /U(');
       //? hex2chr(x32:pdffile.userkey:64);
       //? PdfBinWrite(x32 : true);
       Pdfwrite('/U <' + Pdffile.UserKey + '>');
       Pdfwrite(' /P ' + %Char(Pdffile.permission)
          + ' >> endobj'+Crlf);
       //?endif;
       //?write the xref
       Pdffile.Startxref =Pdfbytescount;
       Pdfwrite('xref'+Crlf);
       Pdfwrite('0 ' );
       Pdfwrite(%Trim(%Editc(Pdffile.size+1:'P'))+ Crlf);
       Pdfwrite('0000000000 65535 f' + Crlf );

B01    For Ifor = 1 To Pdffile.size ;
          //?n10 = pdffile.xref(iFor);
          Ppdfxref=Ppdfxrefarray+(Ifor-1)*%size(Pdfobj);
          n10 = Pdfxref.Obj;
          Pdfwrite(x10 + ' 00000 n' + Crlf);
E01    Endfor;
       Pdfwrite('trailer << /Size ' + %Trim(%Editc(Pdffile.size+1:'P'))+
          ' /Root ' + PdfWObj(Pdffile.Root)+ 'R ' +
          ' /Info ' + PdfWObj(Pdffile.info)+ 'R ');
B01    If Pdffile.Encrypted;
          //?chr2hex(x32 : pdffile.fileid : 32 );
          Pdfwrite('/Encrypt ' + PdfWObj(Pdffile.Encrypt)+ 'R ');
E01    Endif;

B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;
       Ppdfxrefarray=%Realloc(Ppdfxrefarray:%Size(Pdfobj));
       Pdffile.Allocxref=1;
       Ppdfkidsarray=%Realloc(Ppdfkidsarray:%Size(Pdfobj));
       Pdfpages.Allockids=1;

       Pdfwrite('/ID ' +
          Portablechar.Leftbracket + '<' + Pdffile.FileId
          + '><' + Pdffile.FileId + '>' +
          Portablechar.Rightbracket + '');

       Pdfwrite ('>>' + Crlf);
       Pdfwrite('startxref'+Crlf+%Trim(%Editc(Pdffile.Startxref:'P')) + Crlf);
       Pdfwrite('%%EOF'+Crlf);
       //?flush the buffer
       Pdfflush();
       Pdfbuffer = '';
       //?Close the file
       rc = Close(Pdffilehandle) ;
B01    If rc <> 0;
B02       If Errno <> 3025;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
B01    If Pdffile.Withdiag = True;
          Message('CPF9898'
             :'*DIAG messages signal errors. Use F1+F9 to know lines numbers'
             + '. Abnormal termination.'
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY':1);
E01    Endif;
       Iconv_close(Pdfhiconvlatin1 );
       Iconv_close(Pdfhiconvu8latin1 );
       Iconv_close(Pdfhiconvu16latin1 );
       Iconv_close(Pdfhiconvu8u16);
       Iconv_close(Pdfhiconvu16);
      /IF DEFINED(*V6R1M0)
       //?menage dans les definitions de fontes
B01    For i = 1 To Pdffile.Ifontstack;
          Ppdffont = Pdffile.Fontstack(Pdffile.Ifontstack);
B02       If Pdffont.Pgsub <> *null;
             Dealloc(N) Pdffont.Pgsub;
E02       Endif ;
E01    Endfor;
      /endif
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfOpen         b
     D PdfOpen         pi
     D  FileName                    512a   varying const
     d  p_OpenMode                   10i 0 const
     d cmde            s           2000    varying static
     d  WithUnlink     s               n
     d  WithObjAUt     s               n
     d  WithMode       s             10i 0
     d  w              s             10i 0
     d  OpenMode       s             10i 0
      /free
       //?delete the file
       OpenMode = p_OpenMode;
B01    If OpenMode = -1;   //?compatibilité ascendante
          WithUnlink = True;
          WithObjAUt = True;
          OpenMode = S_irwxu;
X01    Else;
          w = %Bitand( p_OpenMode : Pdfopen_unlink );
B02       If ( w = Pdfopen_unlink);
             WithUnlink = True;
             OpenMode -= Pdfopen_unlink;
E02       Endif;

          w = %Bitand( p_OpenMode : Pdfopen_objaut );
B02       If ( w = Pdfopen_objaut);
             WithObjAUt = True;
             OpenMode -= Pdfopen_objaut;
E02       Endif;

B02       If OpenMode = 0;
             OpenMode = S_irwxu;
E02       Endif;
E01    Endif;

B01    If WithUnlink;
          rc= Unlink (FileName);
B02       If rc <> 0;
B03          If Errno <> 3025;
                Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
                Pdffile.Withdiag=True;
E03          Endif;
E02       Endif;
E01    Endif;
       //?create a file & declare implicit code page converter
       Pdffilehandle = Open(FileName
          : O_creat + O_wronly + O_trunc + O_codepage
          : OpenMode   //?S_IRWXU
          : Cp_windows ) ;   //?same as in inztblascii   TODO pdf.ccsid
B01    If Pdffilehandle = -1;
          Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
          Pdffile.Withdiag=True;
E01    Endif;
B01    If WithObjAUt;
          //?   close the file to be able
          rc = Close(Pdffilehandle) ;
          //?to change system authority
          cmde='CHGAUT OBJ('''
             + FileName
             +''') USER(*PUBLIC) DTAAUT(*NONE) OBJAUT(*OBJEXIST)';
          rc = C_system(cmde );
B02       If rc <> 0;
             Message(Msgid:'':'':'QCPFMSG');
             Pdffile.Withdiag=True;
E02       Endif;
          //?chmod
          //?seems this chmod is useless. it appears the previous CHGAUT decision cannot
          //?be overwritten, there is somthing to learn here.
          rc = Chmod(FileName:OpenMode) ;
B02       If rc = -1;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
          //?reopen, not in text mode
          Pdffilehandle = Open(FileName
             : O_wronly + O_trunc + O_codepage
             : OpenMode   //?S_IRWXU
             : Cp_utf8 ) ;   //?same as in inztblascii   todo pdf.ccsid
B02       If Pdffilehandle = -1;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?set the portable char set to the current ccsid
B01    If Pdfinit.Needinit;
          Pdfinz();
E01    Endif;


       //?default converter from jobccsid to latin1, the windows west europe & USA codepage
       Pdffromcode.Ccsid = 0 ;
       Pdftocode.Ccsid = Cp_windows ;
       Pdfhiconvlatin1 = Iconv_open(%Addr(Pdftocode) :
          %Addr(Pdffromcode) ) ;
B01    If Pdfhiconvlatin1.rc <> 0;
B02       If Errno() <> 0;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?job to 1200
       Pdffromcode.Ccsid = 0 ;
       Pdftocode.Ccsid = Cp_utf16 ;
       Pdfhiconvu16= Iconv_open(%Addr(Pdftocode) :
          %Addr(Pdffromcode) ) ;
B01    If Pdfhiconvu16.rc <> 0;
B02       If Errno() <> 0;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?1208 to 1200
       Pdffromcode.Ccsid = Cp_utf8 ;
       Pdftocode.Ccsid = Cp_utf16 ;
       Pdfhiconvu8u16= Iconv_open(%Addr(Pdftocode) :
          %Addr(Pdffromcode) ) ;
B01    If Pdfhiconvu8u16.rc <> 0;
B02       If Errno() <> 0;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?1208 to 1252
       Pdffromcode.Ccsid = Cp_utf8 ;
       Pdftocode.Ccsid = Cp_windows ;
       Pdfhiconvu8latin1= Iconv_open(%Addr(Pdftocode) :
          %Addr(Pdffromcode) ) ;
B01    If Pdfhiconvu8latin1.rc <> 0;
B02       If Errno() <> 0;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?1200 to 1252
       Pdffromcode.Ccsid = Cp_utf16;
       Pdftocode.Ccsid = Cp_windows ;
       Pdfhiconvu16latin1= Iconv_open(%Addr(Pdftocode) :
          %Addr(Pdffromcode) ) ;
B01    If Pdfhiconvu16latin1.rc <> 0;
B02       If Errno() <> 0;
             Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endif;
       //?let file opened to write into in binary mode
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfWrite        b
     D PdfWrite        pi
     D  data                               const like(pdfbuffer)
     D WriteLen        s             10i 0       static
     D RC              S             10i 0       static
     d lData           s                   like(pdfbuffer) static
     d escaped         s                   like(pdfbuffer) static
      /free


       //?Convert to ASCII
       lData = Latin1(data);
       WriteLen = %Len(lData);
       Pdfbytescount+=WriteLen;
       //?buffer not full ? add to buffer
B01    If WriteLen + %Len(Pdfbuffer) < Pdfbufflen;
          Pdfbuffer +=lData;
          Return;
E01    Endif;
       //?flush the buffer
       Pdfflush();
       //?load data to the buffer
       Pdfbuffer =lData;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P PdfWrite        e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfBinWrite     b
     D PdfBinWrite     pi            10i 0
     D  data                               const like(pdfbuffer)
     d  binMode                       5u 0 const
     D WriteLen        s             10i 0       static
     D RC              S             10i 0       static
     d lData           s                   like(pdfbuffer) static
     d escaped         s                   like(pdfbuffer) static
      /free

       //?pdfbinwrite recoit tout les textes de data, qui méritent encryption.
       //?les textes de structure passent par PDFWRITE directement

       //?binmode =  0  data est en EBCDIC
       //?binmode =  1  data est en ASCII   (pour pdfwrite)
       //?binmode =  2  data est en EBCDIC, mais pas d'escape des \ ( )
       //?binmode =  3  data est en ASCII ou UNICODE, ne pas crypter

       //?if binary is 0, then data is ebcdic and need encryption
       //?else write asis
       //?endif
B01    If %Len(data) = 0;
          Return 0;
E01    Endif;
       lData = data;
B01    Select;
X01       When binMode = 0 Or binMode = 2;   //?EBCDIC user data, need encryption
             //?Convert to ASCII
B02          If Pdffile.Encrypted;
                escaped = lData ;
                escaped = PdfSymbolize(escaped:Cr :
                   Portablechar.Backslash + '015');
                escaped = PdfSymbolize(escaped:Lf :
                   Portablechar.Backslash + '012');
                lData = escaped;
E02          Endif;

             lData=Latin1(lData);
             //?encrypt
B02          If Pdffile.Encrypted;
                lData = Pdfencrypt(lData);
B03             If binMode=0;
                   escaped = lData ;
                   escaped = PdfSymbolize(escaped:x'5c':x'5c5c');
                   escaped = PdfSymbolize(escaped:x'28':x'5c28');
                   escaped = PdfSymbolize(escaped:x'29':x'5c29');
                   lData = escaped;
E03             Endif;
E02          Endif;
X01       When binMode = 1;
             //?data is already in ascii. The true binary mode
             //?Convert to ASCII: done
B02          If Pdffile.Encrypted;
                //?escaped = lData ;
                //?note: il n'y a plus de crlf dans les streams, pas compatible avec unicode

                //?verifier si ces symbolize sont utiles / efficaces / obligatoires
                //?il y a un seul appel de binwrite en mode=1, c'est dans loadcontent
                //?quand on charge les streams donc.
                //?donc ces symbolize ne sont pas utiles
                //?escaped = PdfSymbolize(escaped:x'0d' :
                //?   portablechar.backslash + '015');

                //?escaped = PdfSymbolize(escaped:x'0a' :
                //?   portablechar.backslash + '012');
                //?lData = escaped;

                //?encrypt
                lData = Pdfencrypt(lData);
B03             If binMode=0;
                   escaped = lData ;
                   escaped = PdfSymbolize(escaped:x'5c':x'5c5c');
                   escaped = PdfSymbolize(escaped:x'28':x'5c28');
                   escaped = PdfSymbolize(escaped:x'29':x'5c29');
                   lData = escaped;
E03             Endif;
E02          Endif;
X01       When binMode = 3;
             //? ne rien faire
E01    Endsl;
       WriteLen=%Len(lData);
       Pdfbytescount+=WriteLen;
       //?buffer not full ? add to buffer
B01    If WriteLen + %Len(Pdfbuffer) < Pdfbufflen;
          Pdfbuffer +=lData;
          Return WriteLen;
E01    Endif;
       //?flush the buffer
       Pdfflush();
       //?load data to the buffer
       Pdfbuffer =lData;
       Return WriteLen;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P PdfBinWrite     e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfFlush        b
     D PdfFlush        pi
     D WriteData       s          65535          static
     D WriteLen        s             10i 0       static
     D RC              S             10i 0       static
      /free
       //?flush the buffer
       WriteLen=%Len(Pdfbuffer);
       WriteData = Pdfbuffer ;   //?remove varlen (the first 2 chars)
       rc = Write(Pdffilehandle : WriteData : WriteLen ) ;
B01    If rc = -1;
          Message(Errnomsg(Errno()):'':'*LIBL':'QCPFMSG') ;
          Pdffile.Withdiag=True;
E01    Endif;
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextRight    B                   export
     d PdfTextRight    pi             5i 0
     d  endPos                        5i 0                 value
     d  Str                                like(pdfs1) const
      /free
       Return %Inth(endPos - Pdftextstrlen(Str));
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextRightU16...
BPR ?P                 B                   export
     d                 pi             5i 0
     d  endPos                        5i 0                 value
     d  Str                                like(pdfu2) const
      /free
       Return %Inth(endPos - Pdftextstrlenu16(Str));
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextCenter   B                   export
     d PdfTextCenter   pi             5i 0
     d  endPos                        5i 0                 value
     d  Str                                like(pdfs1) const
      /free
       Return %Inth(endPos - Pdftextstrlen(Str)/2);
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextStrlenU16...
BPR ?P                 B                   export
     d                 pi             8f
     d  Str                                like(pdfu2) const
     d  fntSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d  p_font                             likeds(pdffont) const
    ?d* fntNam                             like(PdfFontName)
     d                                     options(*nopass)
     d cp1252          s                   like(pdfs2)     static
     d font3           ds                  likeds(pdffont) static
     d fontSize        s                   like(PdfFontSize) static
     D strcnt          s              5i00                 static
     D strLen          s              8f                   static
     D strLenp         s              8f                   static
     d TrimStr         s                   like(pdfu2)
     d s               ds             2    based(pS) qualified
     d  c                      1      2
     d  u                      1      2u00
     D charSize        s              8f                   static
     D idx             s              5i 0                 static
     d fontSiz         s                   like(PdfFontSize)  static
      /free
B01    If %Parms>=2;
          fontSiz = fntSiz;
X01    Else;
          fontSiz = PdfFontSize();
E01    Endif;
B01    If %Parms>=3;
          font3 = p_font;
X01    Else;
          Ppdffont=Pdffile.Currfont;
          font3 = Pdffont;
E01    Endif;
B01    Select;
      /IF DEFINED(*V6R1M0)
X01       When font3.Subtype = 'LOADFONT3';
             // ben non, faut pas trimmer, comme dans STRLEN1252
             TrimStr=      Str ;
             Gsub(   font3:trimstr   );
             strcnt = %Len(TrimStr);
             strLen = 0;
             pS = %Addr(TrimStr)+0;   //?varying
B02          For idx = 1 By 1 To strcnt;
                pS+=2;
                charSize=font3.width(s.u) / 1000 * fontSiz ;
                strLen+=charSize;
E02          Endfor;
             //?message('':'length of '+trimstr+' is '+%char(strlen));
B02          If strLen > 99999;
                strLenp = 99999;
X02          Else;
                strLenp =strLen * Pdffile.Currcondsize / 100;
E02          Endif;
             Return strLenp;
      /endif
X01       Other;
             cp1252=U16latin1(Str);
          //?text size is evaluable for the 255 first chars. The million of others are sized to 1000
B02          Select;
X02             When %Parms >= 3;
                   Return Pdftextstrlen1252(cp1252:fntSiz:p_font);
X02             When %Parms >= 2;
                   Return Pdftextstrlen1252(cp1252:fntSiz);
X02             Other;
                   Return Pdftextstrlen1252(cp1252);
E02          Endsl;
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextFStrlen  B                   export
     d PdfTextFStrlen  pi             8f
     d  Str                                like(pdfs2) const
     d  fntSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d  p_font                             likeds(pdffont) const
    ?d* fntNam                             like(PdfFontName)
     d                                     options(*nopass)
     d cp1252          s                   like(pdfs2)
      /free
       cp1252=Latin1(%Trim(Str));
       //?for cobolist, facilitate handling fix-sized char string
B01    Select;
X01       When %Parms >= 3;
             Return Pdftextstrlen1252(cp1252:fntSiz:p_font);
X01       When %Parms >= 2;
             Return Pdftextstrlen1252(cp1252:fntSiz);
X01       Other;
             Return Pdftextstrlen1252(cp1252);
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextStrlen   B                   export
     d PdfTextStrLen   pi             8f
     d  Str                                like(pdfs2) const
     d  fntSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d font                                likeds(pdffont) const
    ?d* fntNam                             like(PdfFontName)
     d                                     options(*nopass)
     d cp1252          s                   like(pdfs2)
      /free
       cp1252=Latin1(Str);

B01    Select;
X01       When %Parms >= 3;
             Return Pdftextstrlen1252(cp1252:fntSiz:font );
X01       When %Parms >= 2;
             Return Pdftextstrlen1252(cp1252:fntSiz);
X01       Other;
             Return Pdftextstrlen1252(cp1252);
E01    Endsl;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?P PdfTextStrlen1252...
BPR ?P                 B                   export
     d                 pi             8f
     d  Str                                like(pdfs2) const
     d  fntSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d  p_font                             likeds(pdffont) const
    ?d* fntNam                             like(PdfFontName)
     d                                     options(*nopass)
     d TrimStr         s                   like(pdfs2)
     d s               ds             1    based(pS) qualified
     d  c                      1      1
     d  u                      1      1u 0

     D strCnt          s              5i 0                 static
     D strLen          s              8f                   static
     D strLenp         s              8f                   static
     D charSize        s              8f                   static
     D idx             s              5i 0                 static
     D idx2            s              5i 0                 static
     d fontTyp         s              5i 0                 static
     d deftsize        s              5i 0                 static
     d fontSiz         s                   like(PdfFontSize)
     d font3           ds                  likeds(PdfFont    )
      /free
       //?TrimStr = %Trim(Str);
       //?TrimStr = %Trim(Str);
       //?surtout pas de trim, ca fausse les calculs
       //?ni de trimr - un intervalle à blanc, ça existe
       TrimStr = Str;
       strcnt = %Len(TrimStr);
B01    If %Parms>=2;
          fontSiz = fntSiz;
X01    Else;
          fontSiz = PdfFontSize();
E01    Endif;
B01    If %Parms>=3;
          font3 = p_font;
X01    Else;
          Ppdffont = Pdffile.Currfont;
          font3 = Pdffont;
E01    Endif;
B01    Select;
      /IF DEFINED(*V6R1M0)
X01       When font3.Subtype = 'LOADFONT3';
             strLen = 0;
             pS = %Addr(TrimStr)+1;   //?varying
B02          For idx = 1 By 1 To strcnt;
                pS+=1;
                charSize=font3.width(s.u) / 1000 * fontSiz ;
                strLen+=charSize;
E02          Endfor;
      /endif
X01       Other;
             fontTyp = %Lookup(font3.basefont :Fontstring);
             deftsize=600;
B02          Select ;
X02             When fontTyp = 1;   //?Helvetica
                   Pfont = %Addr(Hvr);
X02             When fontTyp = 2;   //?Helvetica-Bold
                   Pfont = %Addr(Hvb);
X02             When fontTyp = 3;   //?Helvetica-Oblique
                   Pfont = %Addr(Hvo);
X02             When fontTyp = 4;   //?Helvetica-BoldOblique
                   Pfont = %Addr(Hvbi);
X02             When fontTyp = 5;   //?Times-Roman
                   Pfont = %Addr(Tir);
X02             When fontTyp = 6;   //?Times-Bold
                   Pfont = %Addr(Tib);
X02             When fontTyp = 7;   //?Times-Italic
                   Pfont = %Addr(Tii);
X02             When fontTyp = 8;   //?Times-BoldItalic
                   Pfont = %Addr(Tibi);
X02             When fontTyp = 9   //?Courier
X02             Or fontTyp =10   //?Courier-Bold
X02             Or fontTyp =11   //?Courier-Oblique
X02             Or fontTyp =12;   //?Courier-BoldOblique
                   Return fontSiz * strcnt * 600 / 1000 ;
X02             When fontTyp = 13;   //?Symbol
                   Return fontSiz * strcnt * 600 / 1000 ;
X02             When fontTyp = 14;   //?ZapfDingbats
                   Pfont = %Addr(zapf);
               //?unicode : tailles de x'0010' à x'00FF' seulement, à étendre, voir les fichier .ufm
X02             When font3.basefont =Pdf_adobepistd;
                   Pfont = %Addr(Pistd);
                   deftsize=1000;
X02             When font3.basefont =Pdf_arialunicodems;
                   Pfont = %Addr(Arial);
                   deftsize=750;
X02             Other;
                   Message('PDF0014':'':'':'JPLTOOLS');
                   Pdffile.Withdiag=True;
                   Return 1;
E02          Endsl;
             strLen = 0;
             pS = %Addr(TrimStr)+1;   //?varying
B02          For idx = 1 By 1 To strcnt;
                pS+=1;
B03             If s.u > 31;
                   idx2 = s.u - 31;   //?les tables de fontsize ciblent 32 à 255
X03             Else;
                   idx2=0;
E03             Endif;
                charSize = 0;
B03             If idx2 > 0 ;
                   charSize=font.size(idx2) / 1000 * fontSiz ;
                   strLen+=charSize;
X03             Else;
                   charSize=deftsize / 1000 * fontSiz ;
                   strLen+=charSize;
E03             Endif;
E02          Endfor;
E01    Endsl;
       //?message('':'length of '+trimstr+' is '+%char(strlen));
B01    If strLen > 99999;
          strLenp = 99999;
X01    Else;
          strLenp =strLen * Pdffile.Currcondsize / 100;
E01    Endif;
       Return strLenp;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
       //?***********************************************************************
       //?Pad - Pad out a password to 32 characters
       //?***********************************************************************
BPR ?P Pad             B
     D Pad             PI            32
     D  Pwd                          32    CONST
     D  PadString                    32    CONST
     D lPwd            s             32
     D lLen            s             10i 0
     D lPadLength      S             10i 0
      /free
       lPwd = Pwd;
       lLen = %Len(%Trimr(Pwd));
       //?Convert to ASCII       // TODO passer par iConv
       Xlateb( %Addr(lPwd):%Addr(Tblascii):%Size(lPwd) );
       lPadLength = 32-lLen;
       lPwd=%Subst(lPwd:1:lLen) + %Subst(PadString:1:lPadLength);
       Return lPwd;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?***********************************************************************
       //?compute_keys - compute the User and Owner keys
       //?***********************************************************************
BPR ?P compute_keys    B
     D compute_keys    PI            64
     D lRevision                      1    Const
     D lFileID                       16    Const
     D lPermissions                   5  0 Const
     D lUserPwd                      32    Const
     D lOwnerPwd                     32    Const
     DlPEntry          s              4A
     DlPaddedOwnerPwd  s             32
     DlPaddedUserPwd   s             32
     DlHashedOwnerPwd  s             16
     DlEncryptionKeyBase...
     D                 S             16
     DlEncryptionKey   S             16
     D lKeyLength      S             10i 0
     D                 DS
     D lPEntryBin                    10i 0 inz(-12)
     D lPEntry4                1      1a
     D lPEntry3                2      2a
     D lPEntry2                3      3a
     D lPEntry1                4      4a
     D lPadString      s             32    inz(X'28BF4E5E4E758A4164004E56FFFA01-
     D                                     082E2E00B6D0683E802F0CA9FE6453697A')
     D lKeysDS         ds
     d lUserKey                      32
     d lOwnerKey                     32
     d x               s              3i 0
      /free
       //?Define key length: 5 if 40-bit, 16 if 128-bit
B01    If lRevision = '2';
          lKeyLength = 5;
X01    Else;
          lKeyLength = 16;
E01    Endif;
       Pdffile.Encryptionrevision=lRevision;
       //?Algorithm 3.3 Computing the encryption dictionary's O (owner password)
       //?1. Pad or truncate the owner password string as described in step 1
       //?   of Algorithm 3.2.  If there is no owner password, use the user
       //?   password instead. (See implementation note 26 in Appendix H.)
       lPaddedOwnerPwd = Pad(lOwnerPwd:lPadString);   //?pad to 32 chars
       //?2. Initialize the MD5 hash function and pass the result of step 1 as
       //?   input to this function.
       lHashedOwnerPwd = Md5hash(x'00':lPaddedOwnerPwd:32);   //?MD5 hash
       //?3. (Revision 3 or greater) Do the following 50 times: Take the output
       //?   from the previous MD5 hash and pass it as input into a new MD5 hash
B01    If lRevision = '3';
B02       For x = 1 To 50;
             lHashedOwnerPwd = Md5hash(x'00':lHashedOwnerPwd:16);
E02       Endfor;
E01    Endif;
       //?4. Create an RC4 encryption key using the first n bytes of the output
       //?   from the final MD5 hash, where n is always 5 for revision 2 but,
       //?   for revision 3 or greater, depends on the value of the encryption
       //?   dictionary's Length entry.
       lEncryptionKeyBase = %Subst(lHashedOwnerPwd:1:lKeyLength);
       //?5. Pad or truncate the user password string as described in step 1
       //?   of Algorithm 3.2.
       lPaddedUserPwd = Pad(lUserPwd:lPadString);   //?pad to 32 chars
       //?6. Encrypt the result of step 5, using an RC4 encryption function
       //?   with the encryption key obtained in step 4.
       lOwnerKey = Rc4encrypt(
          lPaddedUserPwd:lEncryptionKeyBase:32:lKeyLength);
       //?7. (Revision 3 or greater) Do the following 19 times: Take the output
       //?   from the previous invocation of the RC4 function and pass it as
       //?   input to a new invocation of the function; use an encryption key
       //?   generated by taking each byte of the encryption key obtained in ste
       //?   and performing an XOR (exclusive or) operation between that byte an
       //?   single-byte value of the iteration counter (from 1 to 19).
B01    If lRevision = '3';
B02       For x = 1 To 19;
             lEncryptionKey = Xor(lEncryptionKeyBase:x);
             lOwnerKey = Rc4encrypt(lOwnerKey:lEncryptionKey:32:16);
E02       Endfor;
E01    Endif;
       //?Algorithm 3.4 Computing the encryption dictionary's U
       //?(user password) value (Revision 2)
       //?1. Create an encryption key based on the user password string, as
       //?   described in Algorithm 3.2.
       //? .?Algorithm 3.2 Computing an encryption key
       //? .
       //? .?1. Pad or truncate the password string to exactly 32 bytes. If the
       //? .?   password string is more than 32 bytes long, use only its first
       //? .?   more than 32 bytes long, use only its first 32 bytes; if it is
       //? .?   less than 32 bytes long, pad it by appending the required number
       //? .?   of additional bytes from the beginning of the following padding
       //? .?   string:
       //? .
       //? .?   < 28 BF 4E 5E 4E 75 8A 41 64 00 4E 56 FF FA 01 08
       //? .?   2E 2E 00 B6 D0 68 3E 80 2F 0C A9 FE 64 53 69 7A >
       //? .
       //? .?   That is, if the password string is n bytes long, append the first
       //? .?   32 - n bytes of the padding string to the end of the password
       //? .?   string. If the password string is empty (zero-length), meaning ther
       //? .?   is no user password, substitute the entire padding string in its pl
       //? .
       //? .?2. Initialize the MD5 hash function and pass the result of step 1 as
       //? .?   input to this function.
       //? .
       //? .?3. Pass the value of the encryption dictionary's O entry to the MD5
       //? .?   hash function. (Algorithm 3.3 shows how the O value is computed.)
       //? .
       //? .?4. Treat the value of the P entry as an unsigned 4-byte integer and
       //? .?    pass these bytes to the MD5 hash function, low-order byte first.
       //? .
       //? .?5. Pass the first element of the file's file identifier array
       //? .?   (the value of the ID entry in the document's trailer dictionary;
       //? .?   see Table 3.13 on page 73) to the MD5 hash function. (See
       //? .?   implementation note 25 in Appendix H.)
       //? .
       //? .?6. (Revision 3 or greater) If document metadata is not being encrypted
       //? .?   pass 4 bytes with the value 0xFFFFFFFF to the MD5 hash function.
       //? .?   (This bit hasn't been done yet)
       //? .
       //? .?7. Finish the hash.
       //? .
       //? .?8. (Revision 3 or greater) Do the following 50 times: Take the output
       //? .?   from the previous MD5 hash and pass the first n bytes of the output
       //? .?   as input into a new MD5 hash, where n is the number of bytes of the
       //? .?   the encryption key as defined by the value of the encryption
       //? .?   dictionary's Length entry.
       //? .
       //? .?9. Set the encryption key to the first n bytes of the output from
       //? .?   the final MD5 hash, where n is always 5 for revision 2 but, for
       //? .?   revision 3 or greater, depends on the value of the encryption
       //? .?   dictionary's Length entry.
       lPEntryBin = lPermissions;
       lPEntry = lPEntry1 + lPEntry2 + lPEntry3 + lPEntry4;
       lEncryptionKeyBase =
          Md5hash(x'00':lPaddedUserPwd+lOwnerKey+lPEntry+lFileID:84);
       lEncryptionKey=%Subst(lEncryptionKeyBase:1:lKeyLength);
B01    If lRevision = '3';
B02       For x = 1 To 50;
             lEncryptionKey = Md5hash(x'00':lEncryptionKey:16);
E02       Endfor;
E01    Endif;
       Pdffile.Encryptionkeybase =lEncryptionKey ;
       //?2. Encrypt the 32-byte padding string shown in step 1 of
       //?   Algorithm 3.2, using an RC4 encryption function with the
       //?   encryption key from the preceding step.
B01    If lRevision = '2';
          lUserKey = Rc4encrypt(lPadString:lEncryptionKey:32:5);
E01    Endif;
       //?Algorithm 3.5 Computing the encryption dictionary's U
       //?(user password) value (Revision 3 or greater)
B01    If lRevision = '3';
          //?1. Create an encryption key based on the user password string,
          //?   as described in Algorithm 3.2.
          //?
          //?   done
          //?2. Initialize the MD5 hash function and pass the 32-byte
          //?   padding string shown in step 1 of Algorithm 3.2 as input
          //?   to this function.
          //?3. Pass the first element of the file's file identifier array
          //?   ((the value of the ID entry in the document's trailer
          //?   dictionary; see Table 3.13 on page 73) to the hash function
          //?   and finish the hash. (See implementation note 25 in Appendix H.)
          lUserKey = Md5hash(x'00':lPadString+lFileID:48);
          //?4. Encrypt the 16-byte result of the hash, using an RC4
          //?   encryption function with the encryption key from step 1.
          lUserKey = Rc4encrypt(lUserKey:lEncryptionKey:16:16);
          //?5. Do the following 19 times: Take the output from the previous
          //?   invocation of the  RC4 function and pass it as input to a new
          //?   invocation of the function; use an encryption key generated by
          //?   taking each byte of the original encryption key (obtained in
          //?   step 1) and performing an XOR (exclusive or) operation between
          //?   that byte and the single-byte value of the iteration counter
          //?   (from 1 to 19).
          lEncryptionKeyBase = lEncryptionKey;
B02       For x = 1 To 19;
             lEncryptionKey = Xor(lEncryptionKeyBase:x);
             lUserKey = Rc4encrypt(lUserKey:lEncryptionKey:16:16);
E02       Endfor;
          //?6. Append 16 bytes of arbitrary padding to the output from the
          //?   final invocation of the RC4 function and store the 32-byte result
          //?   as the value of the U entry in the encryption dictionary.
          lUserKey = %Subst(lUserKey:1:16)+
             X'00000000000000000000000000000000';
E01    Endif;
       Return lKeysDS;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?**********************************************************************
BPR ?P XOR             B
     D XOR             PI            16
     D  Key                          16    Const
     D  Counter                       3u 0 Const
     D                 DS
     D Output                  1     16
     D OA                      1     16    Dim(16)
     D l               s              3u 0
     D                 ds
     D x                              3u 0
     D SingleByte              1      1
      /free
       Output = Key;
       x = Counter;
B01    For l = 1 To 16;
          OA(l) = %Bitxor(OA(l):SingleByte);
E01    Endfor;
       Return Output;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?***********************************************************************
       //?Initialise Table Ebcdic -> Ascii
       //?***********************************************************************
BPR ?PInzTblAscii      B
     DInzTblAscii      PI           256A
       //?Convert a Graphic Character String API
     DCDRCVRT          PR                  extpgm('CDRCVRT')
     D CCSID1                        10I 0 CONST
     D ST1                           10I 0 CONST
     D S1                           256    CONST
     D L1                            10I 0 CONST
     D CCSID2                        10I 0 CONST
     D ST2                           10I 0 CONST
     D GCCASN                        10I 0 CONST
     D L2                            10I 0 CONST
     D S2                           256
     D L3                            10I 0
     D L4                            10I 0
     D FB                            12
    ?D*USRJOBI         PR                  extpgm('QUSRJOBI')
    ?D*jobi0400                    1024    OPTIONS(*VARSIZE)
    ?D*jobiBytes                      9B 0 CONST
    ?D*jobiFormat                    10    CONST
    ?D*jobiJobName                   26    CONST
    ?D*jobiJobInt                    16    CONST
    ?D*ApiError                     120    OPTIONS(*VARSIZE)
    ?D*ECH             DS
    ?D* ECH01                  1      4B 0 INZ(255)
    ?D* ECH02                  5      8B 0
    ?D* ECH03                  9     15
    ?D* ECH05                 17    255
    ?D*jobi0400        DS
    ?D* CCSID                         9B 0 overlay(jobi0400:373)
       //?conversion tables and CDRCVRT rtn flds
     DTblAscii         s            256    inz(*allx'ff')
     DTblEbcdic        s            256    inz(*allx'ff')
     DL3               s             10i 0
     DL4               s             10i 0
     DFB               s             12
       //?conversion binary - hex
     dxValue           ds
     d bValue                         3U 0
      /free
       //?get CCSID
       //?QUSRJOBI (jobi0400:%len(jobi0400):'JOBI0400':'*':' ':ech  );
       //?create a conversion table
B01    For bValue = 0 To 254;
          %Subst(TblEbcdic:bValue+1:1) = xValue;
E01    Endfor;
       //?create table
       //?Convert a Graphic Character String (CDRCVRT, QTQCVRT) API
       CDRCVRT (Jp4.Jobccsid:0:TblEbcdic:256
          :Cp_windows:0:0:256:TblAscii:L3:L4:FB);
       //?return table
       Return TblAscii;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  PInzTblAscii      E
       //?***********************************************************************
       //?md5hash - Generate MD5 hash output
       //?***********************************************************************
BPR ?Pmd5hash          B
     Dmd5hash          PI            16
     D  pSeq                          1    CONST
     D  pMsg                        128    CONST
     D  pLen                          5u 0 CONST
     DCipher           PR                  EXTPROC('_CIPHER')
     D                                 *   VALUE
     D                                 *   VALUE
     D                                 *   VALUE
     DMD5_Controls     DS
     D MD5_Function                   5u 0 inz(5)
     D MD5_HashAlg                    1    inz(X'00')
     D MD5_Sequence                   1
     D MD5_DataLength                10i 0
     D MD5_Unused                     8    inz(*LOVAL)
     D MD5_HashCtxPtr                  *   inz(%addr(HashWorkArea))
     D HashWorkArea    S             96    inz(*LOVAL)
     D Msg             s            100
     D EncryptedMsg    S             16
     D p_recv          S               *   inz(%addr(EncryptedMsg))
     D p_src           S               *   inz(%addr(Msg))
      /free
       MD5_Sequence = pSeq;
       Msg = pMsg;
       MD5_DataLength = pLen;
       Cipher( %Addr(p_recv):%Addr(MD5_Controls):%Addr(p_src));
       Return EncryptedMsg;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?**********************************************************************
       //?RC4Encrypt - Encrypt data using the RC4 encryption function
       //?**********************************************************************
BPR ?PRC4Encrypt       B
     DRC4Encrypt       PI         65535
     D  pMsg                      65535    CONST
     D  pKey                         16    CONST
     D  pSize                         5u 0 CONST
     D  pKeySize                      5u 0 CONST
     DRC4Cipher        PR                  EXTPROC('_CIPHER')
     D receiver                        *
     D controls                      32a
     D source                          *
     D RC4_Controls    ds                  qualified
     D   funct_id                     2A
     D   datalen                      5u 0
     D   operation                    1A
     D   reserved                    11A
     D   p_key_ctx                     *
     D key_ctx         ds                  qualified
     D   stream                     256A
     D   len                          5U 0
     D   reserved                     6A
     D Msg             s          65535
     D Key             s             16
     D EncryptedMsg    S          65535
     D p_recv          s               *
     D p_src           s               *
      /free
       //? The following will encrypt "msg" using the RC4
       //? algorithm with the encryption key "key", and place
       //? the result into "encryptedMsg"
       Msg=pMsg;
       Key=pKey;
       key_ctx = *allx'00';
       %Subst(key_ctx.stream:1:pKeySize) = Key;
       key_ctx.len = pKeySize;
       key_ctx.reserved = *allx'00';
       RC4_Controls = *allx'00';
       RC4_Controls.funct_id = x'0013';
       RC4_Controls.datalen = pSize;
       RC4_Controls.operation = x'00';   //?0=Encrypt,1=Decrypt
       RC4_Controls.p_key_ctx = %Addr(key_ctx);
       p_recv = %Addr(EncryptedMsg);
       p_src = %Addr(Msg);
       RC4Cipher( p_recv: RC4_Controls: p_src);
       Return EncryptedMsg;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?********************************************************************
       //?Encrypt a string
       //?********************************************************************
       //? 'Object' is the current object in which the data is being encrypted, and 'lEncryptionKey'
       //?is the base encryption key (i.e. the value of the encryption key immediately before step 5
       //?of algorithm 3.4).  As well as escaping the parentheses and the backslash I found I had to
       //?escape the carriage return character
       //?(x'0D') with octal \015 in order for the data to be unencrypted correctly.
BPR ?P PDF_Encrypt     B
     D PDF_Encrypt     PI         65535A
     D lRevision                      1A   const
     D Buffer                     65535A   value
     D Len                           10i 0 value
     D Object                        10i 0 value
     D lEncryptionKey                16a   value
     DlEncryptedString...
     D                 S          65535A
     D lLen            S             10I 0
     D lKey            S             21A
     D lHash           S             16A
     D                 DS
     D lObject                       10i 0
     D lObj3                   2      2
     D lObj2                   3      3
     D lObj1                   4      4
      /free
       lLen=len;
       lObject = Object;
       //?Append the low-order 3 bytes of the object number and the
       //?low-order 2 bytes of the generation number to the encryption key
       //?lowest-order byte first
       //?The generation number is always zero for a new PDF file
B01    If lRevision = '2';
          lKey = %Subst(lEncryptionKey:1:5) + lObj1 + lObj2 + lObj3 +x'0000';
X01    Else;
          lKey = lEncryptionKey + lObj1 + lObj2 + lObj3 + x'0000';
E01    Endif;
       //?MD5 hash the result
B01    If lRevision = '2';
          lHash = md5hash(x'00':lKey:10);
          lKey = %Subst(lHash:1:10);
X01    Else;
          lHash = md5hash(x'00':lKey:21);
          lKey = %Subst(lHash:1:16);
E01    Endif;
       //?RC4 encrypt the data we have been passed, using the first 10
       //?bytes of the output from the MD5 hash as the key
       //?(16 bytes if 128-bit security)
B01    If lRevision = '2';
          lEncryptedString = RC4Encrypt(buffer:lKey:lLen:10);
X01    Else;
          lEncryptedString = RC4Encrypt(buffer:lKey:lLen:16);
E01    Endif;
       Return lEncryptedString;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 E
       //?*=---------------------------------------------------------------------------------------
BPR ?p PdfEncrypt      b
     d PdfEncrypt      Pi                  like(pdfs3)
     D Buffer                              like(pdfs3) value
     d lbuffer         s          65535    based(pBuffer)
     d lRC4            s          65535    static
     d lReturn         s                   like(pdfs3) static
      /free
       pBuffer = %Addr(buffer) + 2;
       lRC4 =
          PDF_Encrypt (
          Pdffile.Encryptionrevision
          : lbuffer
          : %Len(buffer)
          : Pdffile.Currobj
          : Pdffile.Encryptionkeybase );
       lReturn = %Subst(lRC4 : 1: %Len(buffer));
       Return lReturn;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------------------------------
    ? *=---------------------------------------------------------------------------------------
BPR ?P PdfInz          b                   export
     d                 pi
      /free
B01    If Pdfinit.Needinit;
          Base85 = Convccsid(1252:0:Base85_1252 );
          Pdfinit.Osversion = Jp4.Osversion;
          Charlist=Convccsid(1252:0:Charlistinz );
          //?for debug, to see the fields by name
          Charlistinz = Charlist;
          //?le fichier ifs est ouvert en ccsid(1252) en dur
          Portablechar = Convccsid(Portablecharinz.Ccsid:37:Portablecharinz);
          Portablechar.Ccsid=0;

          Ppdfxrefarray=%Alloc(%Size(Pdfobj));
          Pdffile.Allocxref=1;
          Ppdfkidsarray=%Alloc(%Size(Pdfobj));
          Pdfpages.Allockids=1;

          Pdfinit.Needinit = False;
E01    Endif;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------------------------------
    ? *=---------------------------------------------------------------------------------------
BPR ?P PdfFile_Xref    b
     d                 pi
     d   obj                               like(PdfObj)        const
     d   ByteCount                         like(PdfBytesCount)  const
      /free
       Ppdfxref=Ppdfxrefarray+(Obj-1)*%size(Pdfobj);
       Pdfxref.Obj=ByteCount;
       Pdffile.Currobj =Obj ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------------------------------
BPR ?P PdfPages_Kids   b
     d                 pi
     d   count                             like(PdfObj)        const
     d   obj                               like(PdfObj)         const
      /free
       //?if allocated space to PdfKidsArray is too short, realloc it
       //?count progression is always 1
B01    If count > Pdfpages.Allockids;
          Pdfpages.Allockids*=2;
B02       If Ppdfkidsarray = *null;
             Pdfinz();
E02       Endif;
          Ppdfkidsarray=%Realloc(Ppdfkidsarray:
             Pdfpages.Allockids*%size(Pdfobj));
E01    Endif;
       Ppdfkids=Ppdfkidsarray+(count-1)*%size(Pdfobj);
       Pdfkids.Obj=Obj;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------------------------------
    ? *=---------------------------------------------------------------=*
BPR ?p PdfDaisy        b                   export
     d PdfDaisy        pi                  like(pdfs2)
     d    Xorigin                     5i 0                    const
     d    Yorigin                     5i 0                    const
     d    alpha                       8f                      const
     d  p_beta                        8f                      const
     d    length                      5i 0                    const
     d    Color                            Likeds(PdfColor)   const
     d  p_emphasis                    5i 0 const options(*nopass)
     d  p_text                             like(pdfstream)    const
     d                                     options(*nopass)
     d  p_textlen                          like(PdfTextStrlen) const
     d                                     options(*nopass)

     d traction        s              5p 4 static

     d Daisy           s                   like(pdfs2) static
    ?d*xA              s              8f   static
    ?d*yA              s              8f   static
    ?d*xB              s              8f   static
    ?d*yB              s              8f   static
    ?d*xC              s              8f   static
    ?d*yC              s              8f   static
    ?d*xD              s              8f   static
    ?d*yD              s              8f   static
    ?d*lAB             s              8f   static
    ?d*lOC             s              8f   static
     d beta            s              8f   static
     d    emphasis     s              8f
     d    text         s                   like(pdfstream)
     d textlen         s                   like(PdfTextStrlen)

    ? /free
       //?COBOL : all parameters are passed
B01    If %Parms() >=7;
          emphasis = p_emphasis;
X01    Else;
          emphasis = 0;
E01    Endif;
B01    If emphasis < 0;
          emphasis = 0;
E01    Endif;
B01    If %Parms() >=8;
          text = p_text;
X01    Else;
          text='';
E01    Endif;

B01    If %Parms() >=9;
          textlen = p_textlen;
X01    Else;
          textlen=0;
E01    Endif;

       //?calculer un petale de marguerite
       //?sauver le graphic state
       //?translate : le curseur en X,Y (point O)
       //?sans emphasis (mise en évidence)
       //?  rotate : angle alpha. l'axe OA est horizontal
       //?avec emphasis - pousser le dessin de (emphasis) points
       //?avec texte - poser le texte à l'extérieur du dessin
       //?  rotate 1/2 beta
       //?  translate (emphasis:0)
       //?  textgoto(length*2:0) + textadd
       //?  rotate -1/2 beta
       //?
       //?text = a minima pdftextopen + pdftextfont + pdftextadd + pdftextclose
       //?
       //?limites à observer pour obtenir un angle beta coherent
       //?1:
       //?l'angle beta ne peut pas depasser 360°, ça n'a pas de sens.
       //?2:
       //?de plus une courbe de bezier s'exprime dans un rectangle, dont la base est le diamètre
       //?  d'un cercle. du moins c'est ce que j'ai compris. la courbe s'exprime dans le rectangle,
       //?  les coordonnées doivent rester dans le rectangle. de fait la limite de l'angle beta est
       //?  de 180° : le rectangle est calculé en appliquant l'angle beta sur le rayon (parametre
       //?  length)

       //?%rem de 180 retourne 0 à 179. je veux 1 à 180
       //?beta = %Rem(p_beta-1:180)+1;
       beta = p_beta;
B01    If beta < 0;
          beta=-beta;
E01    Endif;
B01    Dow beta > 180;
          beta-=180;
E01    Enddo;
B01    If p_beta < 0;
          beta = -beta;
E01    Endif;

       //?dessiner

       Daisy = PdfStrmSaveGraphicState();   //?1
       Daisy+= PdfStrmTranslate(Xorigin :Yorigin );
       Daisy+= PdfStrmRotate(alpha+Beta/2);
       Daisy+=PdfDrawLineJoin(Pdf_joinround);
B01    If Color.Device = 'RGB';
          Daisy+= PdfStrmStrokingColorRGB(Color.Strokered
             :Color.Strokegreen
             :Color.Strokeblue);
          Daisy+= PdfStrmFillingColorRGB( Color.Fillred
             :Color.Fillgreen
             :Color.Fillblue);
E01    Endif;
B01    If Color.Device = 'CMYK';
          Daisy+= PdfStrmStrokingColorCMYK(Color.Strokecyan
             :Color.Strokemagenta
             :Color.Strokeyellow
             :Color.Strokeblack);
          Daisy+= PdfStrmFillingColorCMYK( Color.Fillcyan
             :Color.Fillmagenta
             :Color.Fillyellow
             :Color.Fillblack);
E01    Endif;
       //?
       Daisy+=Pdfdrawadddaisy(
          beta   //?angle beta
          :emphasis+Length/4   //?longueur 0A
          :emphasis+length   //?  longueur 0B
          :Length/4   //?         longueur AA1
          );
       Daisy+= PdfDrawClosePath(Pdf_fill:Pdf_stroke:Pdf_close);
B01    If text <> '';
          Daisy+= PdfStrmSaveGraphicState();   //?2
B02       If emphasis > 0 ;
             Daisy+=PdfStrmTranslate(emphasis:0);
             Daisy+=PdfDrawLineWidth(1+Emphasis/10);
E02       Endif;
          //?daisy+=text;
          Daisy+=PdfStrmTranslate(length+10 :0);
B02       If textlen > 0;
             Daisy+= PdfStrmRotate(-alpha-Beta/2);   //?revenir @ l'horizontale
             //?si le piepart est entre 90¢ et 270¢, {crire vers la droite
             //?si on a re\u le parametre p_textlen
B03          If 90 <= (alpha+Beta/2) And
                   (alpha+Beta/2) < 270;
                Daisy+=PdfStrmTranslate(-textlen :0);
E03          Endif;
E02       Endif;
          Daisy+=text;
          Daisy+= PdfStrmRestoreGraphicState();   //?2-1
E01    Endif;

       Daisy+= PdfStrmRestoreGraphicState();   //?1-0
       Return Daisy;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p PdfDaisy        e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfPie          b                   export
     d PdfPie          pi                  like(pdfs2)
     d    Xorigin                     5i 0                    const
     d    Yorigin                     5i 0                    const
     d    alpha                       8f                      const
     d    beta                        8f                      const
     d    length                      5i 0                    const
     d    Color                            Likeds(PdfColor)   const
     d  p_emphasis                    5i 0 const options(*nopass)
     d  p_text                             like(pdfstream)    const
     d                                     options(*nopass)
     d  p_textlen                          like(PdfTextStrlen) const
     d                                     options(*nopass)
     d MyBezier1       ds                  likeds(pdfbezier)
     d MyBezier2       ds                  likeds(pdfbezier)
     d Pie             s                   like(pdfs2)   static
    ?d*beta            s              8f   static
     d tanAB           s              8f   static
     d traction        s              5p 4 static inz(0.288)
     d emphasis        s              8f
     d text            s                   like(pdfstream)
     d textlen         s                   like(PdfTextStrlen)

    ? /free
       //?COBOL : all parameters are passed
B01    If %Parms() >=7;
          emphasis = p_emphasis;
X01    Else;
          emphasis = 0;
E01    Endif;



B01    If %Parms() >=8;
          text = p_text;
X01    Else;
          text='';
E01    Endif;
B01    If %Parms() >=9;
          textlen = p_textlen;
X01    Else;
          textlen=0;
E01    Endif;

       //?calculer une part de camembert : voir le dessin ...
       //?sauver le graphic state
       //?translate : le curseur en X,Y (point O)
       //?sans emphasis (mise en évidence)
       //?  rotate : angle alpha. l'axe OA est horizontal
       //?avec emphasis - pousser le dessin de (emphasis) points
       //?avec texte - poser le texte à l'extérieur du dessin
       //?  rotate 1/2 beta
       //?  translate (emphasis:0)
       //?  textgoto(length*1.1:0) + textadd
       //?  rotate -1/2 beta
       //?coordonnées de A=(Length, 0)
       //?longueur AB = CD = tan(beta/3)*Length
       //?coordonnées de B=(Length, lAB)
       //?longueur OC=racine(OD^2 + lAB^2)
       //?coordonnées de C=(cos(beta/3*2)*lOC, sin(beta/3*2)*lOC)
       //?coordonnées de D=(cos(beta)*Length , sin(beta)*Length )
       //?
       //?dessin du camembert (Pie part)
       //?MyDraw+=PdfDrawGoTo(     050:020);    origine
       //?MyDraw+=PdfDrawAddLine(  430:020);    point A
       //?MyDraw+=PdfDrawAddBezier(430:120      point B
       //?                        :400:220      point C
       //?                        :320:290);    point D
       //?MyDraw+=PdfDrawAddLine(  050:020);    origine
       //?MyDraw+=PdfDrawClosePath(pdf_Fill:Pdf_Stroke);
       //?
       //?*=----------------------
       //?CMATH are in radians
       //?cos = c_cos (c_pi * alpha / 180);
       //?sin = c_sin (c_pi * alpha / 180);
       //?
       //?text = a minima pdftextopen + pdftextfont + pdftextadd + pdftextclose
       //?
       //?limites à observer pour obtenir un angle beta coherent
       //?1:
       //?l'angle beta ne peut pas depasser 360°, ça n'a pas de sens.
       //?2:
       //?la methode retenue pour calculer la portion de cercle a une singularité autour de 300°
       //?  en effet l'un des calculs est basé sur tangente(beta*.3) ; et tan(90) = l'infini
       //?3:
       //?de plus une courbe de bezier s'exprime dans un rectangle, dont la base est le diamètre
       //?  d'un cercle. du moins c'est ce que j'ai compris. la courbe s'exprime dans le rectangle,
       //?  les coordonnées doivent rester dans le rectangle. de fait la limite de l'angle beta est
       //?  de 180° : le rectangle est calculé en appliquant l'angle beta sur le rayon (parametre
       //?  length)


       //?coordonnées de l'arc de longueur L1
       MyBezier1=Pdfcalcarc ( beta : emphasis);   //?utile ?
       MyBezier2=Pdfcalcarc ( beta : length + emphasis);

       //?dessiner

       Pie = PdfStrmSaveGraphicState();
       Pie+= PdfStrmTranslate(Xorigin :Yorigin );
       Pie+= PdfStrmRotate(alpha+Beta/2);
       Pie+=PdfDrawLineJoin(Pdf_joinround);
       Pie+=PdfDrawLineWidth(1);
B01    If Color.Device = 'RGB';
          Pie += PdfStrmStrokingColorRGB(Color.Strokered
             :Color.Strokegreen
             :Color.Strokeblue);
          Pie += PdfStrmFillingColorRGB( Color.Fillred
             :Color.Fillgreen
             :Color.Fillblue);
E01    Endif;
B01    If Color.Device = 'CMYK';
          Pie += PdfStrmStrokingColorCMYK(Color.Strokecyan
             :Color.Strokemagenta
             :Color.Strokeyellow
             :Color.Strokeblack);
          Pie += PdfStrmFillingColorCMYK( Color.Fillcyan
             :Color.Fillmagenta
             :Color.Fillyellow
             :Color.Fillblack);
E01    Endif;

       Pie+= Pdfdrawaddcorona(
          beta
          : emphasis
          : length + emphasis
          );

       Pie+= PdfDrawClosePath(Pdf_fill:Pdf_stroke:Pdf_close);

       //?Pie+= PdfStrmSaveGraphicState();
B01    If text <> '';
B02       If emphasis > 0;
             Pie+=PdfStrmTranslate(emphasis:0);
             Pie+=PdfDrawLineWidth(1+Emphasis/10);
E02       Endif;
          Pie+=PdfStrmTranslate(length+10 :0);
          Pie+= PdfStrmSaveGraphicState();
B02       If textlen > 0;
             Pie+= PdfStrmRotate(-alpha-Beta/2);   //?revenir a l'horizontale
             //?si le piepart est entre 90  et 270 degres, ecrire vers la droite
             //?si on a recu le parametre p_textlen
B03          If 90 <= (alpha+Beta/2) And
                   (alpha+Beta/2) < 270;
                Pie+=PdfStrmTranslate(-textlen :0);
E03          Endif;
E02       Endif;
          Pie+=text;
          Pie+= PdfStrmRestoreGraphicState();
          Pie+= PdfDrawGoto ( 0 :0 );
          Pie+= PdfDrawAddLine(-10 :0 );
          Pie+= PdfDrawClosePath(Pdf_fill:Pdf_stroke:Pdf_close);
E01    Endif;
       //?Pie+= PdfStrmRestoreGraphicState();

       Pie+= PdfStrmRestoreGraphicState();
       Return Pie;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p PdfPie          e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfSetColorCMYK...
BPR ?p                 b                   export
     d                 pi                  likeds(PdfColor)
     d  strokeCyan                    5p 4 const
     d  strokeMagenta                 5p 4 const
     d  strokeYellow                  5p 4 const
     d  strokeBlack                   5p 4 const
     d  FillCyan                      5p 4 const
     d  FillMagenta                   5p 4 const
     d  FillYellow                    5p 4 const
     d  FillBlack                     5p 4 const
     d    Color        ds                  likeds(PdfColor)
    ? /free
       //?info about CMYK vs RGB, in french : http://fr.wikipedia.org/wiki/Quadrichromie
       //?The Abobe RGB color space : http://en.wikipedia.org/wiki/Adobe_RGB
       //?Conversion RGB - CMYK
       //?  step 1 (the minimum)
       //?    Black = 0
       //?    Cyan = 1 - Red
       //?    Magenta = 1 - Green
       //?    Yellow = 1 - blue
       //?  step2 (optional) isolat Black
       //?    Black = min(Cyan, Magenta, Yellow)
       //?    Substract black from Cyan, Magenta, Yellow
       //?Conversion CMYK - RGB
       //?    Add black from Cyan, Magenta, Yellow
       //?    Red = 1 _ Cyan
       //?    Green = 1 - Magenta
       //?    Blue = 1 - Yellow
       Color.Device='CMYK';
       Color.strokeCyan = strokeCyan ;
       Color.strokeMagenta = strokeMagenta ;
       Color.strokeYellow = strokeYellow ;
       Color.strokeBlack = strokeBlack ;
       Color.FillCyan = FillCyan ;
       Color.FillMagenta = FillMagenta ;
       Color.FillYellow = FillYellow ;
       Color.FillBlack = FillBlack ;
       Return Color;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfSetColorRGB  b                   export
     d                 pi                  likeds(PdfColor)
     d    strokeRed                   5p 4 const
     d    strokeGreen                 5p 4 const
     d    strokeBlue                  5p 4 const
     d    FillRed                     5p 4 const
     d    FillGreen                   5p 4 const
     d    FillBlue                    5p 4 const
     d    Color        ds                  likeds(PdfColor)
    ? /free
       Color.Device='RGB';
       Color.strokeRed = strokeRed ;
       Color.strokeGreen= strokeGreen ;
       Color.strokeBlue = strokeBlue ;
       Color.FillRed = FillRed ;
       Color.FillGreen = FillGreen ;
       Color.FillBlue = FillBlue ;
       Return Color;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*


BPR ?p PdfRandomcolorHTML...
BPR ?p                 b                   export
     d                 pi            50          varying
     d ColorName                     50    value varying
     d Result          s             50          varying
     d hexa3           ds             7
     d  diese                         1
     d  rgb                           6
     d   red                          2    overlay(rgb)
     d   green                        2    overlay(rgb:*next)
     d   blue                         2    overlay(rgb:*next)
     d bin3            ds             3
     d  r                             3u 0
     d  g                             3u 0
     d  b                             3u 0
     d n5              s              5i 0








     d random_No       s              8f

    ? /free
       //?result = 3 values, one for each primary color (red green blue)
       //?each value between 0 and 255
       //?0 = black, 255 = white
       //?dark colors are colors between 0 and 1/4
       //?light colors are colors between 3/4 and 1
       hexa3 = '';
       Result=ColorName;
       ColorName = Lcase(ColorName);
B01    Select;
X01       When ColorName='*random';
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             r = random_No * 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             g = random_No * 255;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             b = random_No * 255 ;


X01       When ColorName='*light';
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             r =(random_No * .25 + .75)* 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             g =(random_No * .25 + .75)* 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             b =(random_No * .25 + .75)* 255 ;

X01       When ColorName='*flash';
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             r =(random_No )* 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             g =(random_No )* 255 ;
             n5=0;
             n5 =%Abs(%Dec( 255 - r - g : 5 : 0 )) ;
             b =n5 ;





X01       When ColorName='*dark';
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             r =(random_No * .25 )* 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             g =(random_No * .25 )* 255 ;
             Random(Pdffile.Randomseed: random_No : *omit ) ;
             b =(random_No * .25 )* 255 ;

X01       Other;
             Return ColorName;   //?not a random color
E01    Endsl;
       diese='#';
       Chr2Hex(rgb:bin3:6);
       Return hexa3;


B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  P                 e

    ? *=---------------------------------------------------------------=*


BPR ?p PdfCheckcolorHTML...
BPR ?p                 b                   export
     d                 pi                  likeds(PdfColorHTML)
     d ColorName                     50    value varying
     d Result          ds                  likeds(PdfColorHTML)
     d hexa3           ds             7
     d diese                          1
     d rgb                            6
     d red                            2    overlay(rgb)
     d green                          2    overlay(rgb:*next)
     d blue                           2    overlay(rgb:*next)
     d bin3            ds             3
     d r                              3u 0
     d g                              3u 0
     d b                              3u 0


    ? /free
       //?result = 3 values, one for each primary color (red green blue)
       //?each value between 0 and 1
       //?0 = black, 1 = white
       //?dark colors are colors between 0 and 0.25
       //?light colors are colors between 0.75 and 1
       hexa3 = '' ;   //?not understoud
       ColorName = Lcase(ColorName);

B01    If %Len(ColorName)>0;
B02       If %Subst(ColorName:1:1) = Portablechar.Numbersign ;   //?#
             hexa3 = ColorName;
X02       Else;
             //?convert named color to hexa color
B03          Select ;
X03             When ColorName = 'aliceblue';
                   hexa3=Portablechar.Numbersign + 'f0f8ff';
X03             When ColorName = 'antiquewhite';
                   hexa3=Portablechar.Numbersign + 'faebd7';
X03             When ColorName = 'aqua';
                   hexa3=Portablechar.Numbersign + '00ffff';
X03             When ColorName = 'aquamarine';
                   hexa3=Portablechar.Numbersign + '7fffd4';
X03             When ColorName = 'azure';
                   hexa3=Portablechar.Numbersign + 'f0ffff';
X03             When ColorName = 'beige';
                   hexa3=Portablechar.Numbersign + 'f5f5dc';
X03             When ColorName = 'bisque';
                   hexa3=Portablechar.Numbersign + 'ffe4c4';
X03             When ColorName = 'black';
                   hexa3=Portablechar.Numbersign + '000000';
X03             When ColorName = 'blanchedalmond';
                   hexa3=Portablechar.Numbersign + 'ffebcd';
X03             When ColorName = 'blue';
                   hexa3=Portablechar.Numbersign + '0000ff';
X03             When ColorName = 'blueviolet';
                   hexa3=Portablechar.Numbersign + '8a2be2';
X03             When ColorName = 'brown';
                   hexa3=Portablechar.Numbersign + 'a52a2a';
X03             When ColorName = 'burlywood';
                   hexa3=Portablechar.Numbersign + 'deb887';
X03             When ColorName = 'cadetblue';
                   hexa3=Portablechar.Numbersign + '5f9ea0';
X03             When ColorName = 'chartreuse';
                   hexa3=Portablechar.Numbersign + '7fff00';
X03             When ColorName = 'cilagray';
                   hexa3=Portablechar.Numbersign + '5F5F5F';
X03             When ColorName = 'cilagreen';
                   hexa3=Portablechar.Numbersign + '8EBC13';
X03             When ColorName = 'chocolate';
                   hexa3=Portablechar.Numbersign + 'd2691e';
X03             When ColorName = 'coral';
                   hexa3=Portablechar.Numbersign + 'ff7f50';
X03             When ColorName = 'cornflower';
                   hexa3=Portablechar.Numbersign + '6495ed';
X03             When ColorName = 'cornsilk';
                   hexa3=Portablechar.Numbersign + 'fff8dc';
X03             When ColorName = 'crimson';
                   hexa3=Portablechar.Numbersign + 'dc143c';
X03             When ColorName = 'cyan';
                   hexa3=Portablechar.Numbersign + '00ffff';
X03             When ColorName = 'darkblue';
                   hexa3=Portablechar.Numbersign + '00008b';
X03             When ColorName = 'darkcyan';
                   hexa3=Portablechar.Numbersign + '008b8b';
X03             When ColorName = 'darkgoldenrod';
                   hexa3=Portablechar.Numbersign + 'b8860b';
X03             When ColorName = 'darkgray';
                   hexa3=Portablechar.Numbersign + 'a9a9a9';
X03             When ColorName = 'darkgreen';
                   hexa3=Portablechar.Numbersign + '006400';
X03             When ColorName = 'darkkhaki';
                   hexa3=Portablechar.Numbersign + 'bdb76b';
X03             When ColorName = 'darkmagenta';
                   hexa3=Portablechar.Numbersign + '8b008b';
X03             When ColorName = 'darkolivegreen';
                   hexa3=Portablechar.Numbersign + '556b2f';
X03             When ColorName = 'darkorange';
                   hexa3=Portablechar.Numbersign + 'ff8c00';
X03             When ColorName = 'darkorchid';
                   hexa3=Portablechar.Numbersign + '9932cc';
X03             When ColorName = 'darkred';
                   hexa3=Portablechar.Numbersign + '8b0000';
X03             When ColorName = 'darksalmon';
                   hexa3=Portablechar.Numbersign + 'e9967a';
X03             When ColorName = 'darkseagreen';
                   hexa3=Portablechar.Numbersign + '8fbc8b';
X03             When ColorName = 'darkslateblue';
                   hexa3=Portablechar.Numbersign + '483d8b';
X03             When ColorName = 'darkslategray';
                   hexa3=Portablechar.Numbersign + '2f4f4f';
X03             When ColorName = 'darkturquoise';
                   hexa3=Portablechar.Numbersign + '00ced1';
X03             When ColorName = 'darkviolet';
                   hexa3=Portablechar.Numbersign + '9400d3';
X03             When ColorName = 'deeppink';
                   hexa3=Portablechar.Numbersign + 'ff1493';
X03             When ColorName = 'deepskyblue';
                   hexa3=Portablechar.Numbersign + '00bfff';
X03             When ColorName = 'dimgray';
                   hexa3=Portablechar.Numbersign + '696969';
X03             When ColorName = 'dodgerblue';
                   hexa3=Portablechar.Numbersign + '1e90ff';
X03             When ColorName = 'firebrick';
                   hexa3=Portablechar.Numbersign + 'b22222';
X03             When ColorName = 'floralwhite';
                   hexa3=Portablechar.Numbersign + 'fffaf0';
X03             When ColorName = 'forestgreen';
                   hexa3=Portablechar.Numbersign + '228b22';
X03             When ColorName = 'fuchia';
                   hexa3=Portablechar.Numbersign + 'ff00ff';
X03             When ColorName = 'gainsboro';
                   hexa3=Portablechar.Numbersign + 'dcdcdc';
X03             When ColorName = 'ghostwhite';
                   hexa3=Portablechar.Numbersign + 'f8f8ff';
X03             When ColorName = 'gold';
                   hexa3=Portablechar.Numbersign + 'ffd700';
X03             When ColorName = 'goldenrod';
                   hexa3=Portablechar.Numbersign + 'daa520';
X03             When ColorName = 'gray';
                   hexa3=Portablechar.Numbersign + '808080';
X03             When ColorName = 'green';
                   hexa3=Portablechar.Numbersign + '008000';
X03             When ColorName = 'greenyellow';
                   hexa3=Portablechar.Numbersign + 'adff2f';
X03             When ColorName = 'honeydew';
                   hexa3=Portablechar.Numbersign + 'f0fff0';
X03             When ColorName = 'hotpink';
                   hexa3=Portablechar.Numbersign + 'ff69b4';
X03             When ColorName = 'indianred';
                   hexa3=Portablechar.Numbersign + 'cd5c5c';
X03             When ColorName = 'indigo';
                   hexa3=Portablechar.Numbersign + '4b0082';
X03             When ColorName = 'ivory';
                   hexa3=Portablechar.Numbersign + 'fffff0';
X03             When ColorName = 'khaki';
                   hexa3=Portablechar.Numbersign + 'f0e68c';
X03             When ColorName = 'lavender';
                   hexa3=Portablechar.Numbersign + 'e6e6fa';
X03             When ColorName = 'lavenderblush';
                   hexa3=Portablechar.Numbersign + 'fff0f5';
X03             When ColorName = 'lawngreen';
                   hexa3=Portablechar.Numbersign + '7cfc00';
X03             When ColorName = 'lemonchiffon';
                   hexa3=Portablechar.Numbersign + 'fffacd';
X03             When ColorName = 'lightblue';
                   hexa3=Portablechar.Numbersign + 'add8e6';
X03             When ColorName = 'lightcoral';
                   hexa3=Portablechar.Numbersign + 'f08080';
X03             When ColorName = 'lightcyan';
                   hexa3=Portablechar.Numbersign + 'e0ffff';
X03             When ColorName = 'lightgoldenrodyellow';
                   hexa3=Portablechar.Numbersign + 'fafad2';
X03             When ColorName = 'lightgreen';
                   hexa3=Portablechar.Numbersign + '90ee90';
X03             When ColorName = 'lightgrey';
                   hexa3=Portablechar.Numbersign + 'd3d3d3';
X03             When ColorName = 'lightpink';
                   hexa3=Portablechar.Numbersign + 'ffb6c1';
X03             When ColorName = 'lightsalmon';
                   hexa3=Portablechar.Numbersign + 'ffa07a';
X03             When ColorName = 'lightseagreen';
                   hexa3=Portablechar.Numbersign + '20b2aa';
X03             When ColorName = 'lightskyblue';
                   hexa3=Portablechar.Numbersign + '87cefa';
X03             When ColorName = 'lightslategray';
                   hexa3=Portablechar.Numbersign + '778899';
X03             When ColorName = 'lightsteelblue';
                   hexa3=Portablechar.Numbersign + 'b0c4de';
X03             When ColorName = 'lightyellow';
                   hexa3=Portablechar.Numbersign + 'ffffe0';
X03             When ColorName = 'lime';
                   hexa3=Portablechar.Numbersign + '00ff00';
X03             When ColorName = 'limegreen';
                   hexa3=Portablechar.Numbersign + '32cd32';
X03             When ColorName = 'linen';
                   hexa3=Portablechar.Numbersign + 'faf0e6';
X03             When ColorName = 'magenta';
                   hexa3=Portablechar.Numbersign + 'ff00ff';
X03             When ColorName = 'maroon';
                   hexa3=Portablechar.Numbersign + '800000';
X03             When ColorName = 'mediumaquamarine';
                   hexa3=Portablechar.Numbersign + '66cdaa';
X03             When ColorName = 'mediumblue';
                   hexa3=Portablechar.Numbersign + '0000cd';
X03             When ColorName = 'mediumorchid';
                   hexa3=Portablechar.Numbersign + 'ba55d3';
X03             When ColorName = 'mediumpurple';
                   hexa3=Portablechar.Numbersign + '9370db';
X03             When ColorName = 'mediumseagreen';
                   hexa3=Portablechar.Numbersign + '3cb371';
X03             When ColorName = 'mediumslateblue';
                   hexa3=Portablechar.Numbersign + '7b68ee';
X03             When ColorName = 'mediumspringgreen';
                   hexa3=Portablechar.Numbersign + '00fa9a';
X03             When ColorName = 'mediumturquoise';
                   hexa3=Portablechar.Numbersign + '48d1cc';
X03             When ColorName = 'mediumvioletred';
                   hexa3=Portablechar.Numbersign + 'c71585';
X03             When ColorName = 'midnightblue';
                   hexa3=Portablechar.Numbersign + '191970';
X03             When ColorName = 'mintcream';
                   hexa3=Portablechar.Numbersign + 'f5fffa';
X03             When ColorName = 'mistyrose';
                   hexa3=Portablechar.Numbersign + 'ffe4e1';
X03             When ColorName = 'moccasin';
                   hexa3=Portablechar.Numbersign + 'ffe4b5';
X03             When ColorName = 'navajowhite';
                   hexa3=Portablechar.Numbersign + 'ffdead';
X03             When ColorName = 'navy';
                   hexa3=Portablechar.Numbersign + '000080';
X03             When ColorName = 'oldlace';
                   hexa3=Portablechar.Numbersign + 'fdf5e6';
X03             When ColorName = 'olive';
                   hexa3=Portablechar.Numbersign + '808000';
X03             When ColorName = 'olivedrab';
                   hexa3=Portablechar.Numbersign + '6b8e23';
X03             When ColorName = 'orange';
                   hexa3=Portablechar.Numbersign + 'ffa500';
X03             When ColorName = 'orangered';
                   hexa3=Portablechar.Numbersign + 'ff4500';
X03             When ColorName = 'orchid';
                   hexa3=Portablechar.Numbersign + 'da70d6';
X03             When ColorName = 'palegoldenrod';
                   hexa3=Portablechar.Numbersign + 'eee8aa';
X03             When ColorName = 'palegreen';
                   hexa3=Portablechar.Numbersign + '98fb98';
X03             When ColorName = 'paleturquoise';
                   hexa3=Portablechar.Numbersign + 'afeeee';
X03             When ColorName = 'palevioletred';
                   hexa3=Portablechar.Numbersign + 'db7093';
X03             When ColorName = 'papayawhip';
                   hexa3=Portablechar.Numbersign + 'ffefd5';
X03             When ColorName = 'peachpuff';
                   hexa3=Portablechar.Numbersign + 'ffdab9';
X03             When ColorName = 'peru';
                   hexa3=Portablechar.Numbersign + 'cd853f';
X03             When ColorName = 'pink';
                   hexa3=Portablechar.Numbersign + 'ffc0cb';
X03             When ColorName = 'plum';
                   hexa3=Portablechar.Numbersign + 'dda0dd';
X03             When ColorName = 'powderblue';
                   hexa3=Portablechar.Numbersign + 'b0e0e6';
X03             When ColorName = 'purple';
                   hexa3=Portablechar.Numbersign + '800080';
X03             When ColorName = 'red';
                   hexa3=Portablechar.Numbersign + 'ff0000';
X03             When ColorName = 'rosybrown';
                   hexa3=Portablechar.Numbersign + 'bc8f8f';
X03             When ColorName = 'royalblue';
                   hexa3=Portablechar.Numbersign + '4169e1';
X03             When ColorName = 'saddlebrown';
                   hexa3=Portablechar.Numbersign + '8b4513';
X03             When ColorName = 'salmon';
                   hexa3=Portablechar.Numbersign + 'fa8072';
X03             When ColorName = 'sandybrown';
                   hexa3=Portablechar.Numbersign + 'f4a460';
X03             When ColorName = 'seagreen';
                   hexa3=Portablechar.Numbersign + '2e8b57';
X03             When ColorName = 'seashell';
                   hexa3=Portablechar.Numbersign + 'fff5ee';
X03             When ColorName = 'sienna';
                   hexa3=Portablechar.Numbersign + 'a0522d';
X03             When ColorName = 'silver';
                   hexa3=Portablechar.Numbersign + 'c0c0c0';
X03             When ColorName = 'skyblue';
                   hexa3=Portablechar.Numbersign + '87ceeb';
X03             When ColorName = 'slateblue';
                   hexa3=Portablechar.Numbersign + '6a5acd';
X03             When ColorName = 'slategray';
                   hexa3=Portablechar.Numbersign + '708090';
X03             When ColorName = 'snow';
                   hexa3=Portablechar.Numbersign + 'fffafa';
X03             When ColorName = 'springgreen';
                   hexa3=Portablechar.Numbersign + '00ff7f';
X03             When ColorName = 'steelblue';
                   hexa3=Portablechar.Numbersign + '4682b4';
X03             When ColorName = 'tan';
                   hexa3=Portablechar.Numbersign + 'd2b48c';
X03             When ColorName = 'teal';
                   hexa3=Portablechar.Numbersign + '008080';
X03             When ColorName = 'thistle';
                   hexa3=Portablechar.Numbersign + 'd8bfd8';
X03             When ColorName = 'tomato';
                   hexa3=Portablechar.Numbersign + 'ff6347';
X03             When ColorName = 'turquoise';
                   hexa3=Portablechar.Numbersign + '40e0d0';
X03             When ColorName = 'violet';
                   hexa3=Portablechar.Numbersign + 'ee82ee';
X03             When ColorName = 'wheat';
                   hexa3=Portablechar.Numbersign + 'f5deb3';
X03             When ColorName = 'white';
                   hexa3=Portablechar.Numbersign + 'ffffff';
X03             When ColorName = 'whitesmoke';
                   hexa3=Portablechar.Numbersign + 'f5f5f5';
X03             When ColorName = 'yellow';
                   hexa3=Portablechar.Numbersign + 'ffff00';
X03             When ColorName = 'yellowgreen';
                   hexa3=Portablechar.Numbersign + '9acd32';
E03          Endsl;
E02       Endif;
E01    Endif;
       //?no color ?
B01    If hexa3 = '';
          Message('':'unknown color : '+ColorName+'. Set to red');
          hexa3=Portablechar.Numbersign + 'ff0000';
E01    Endif;
       //?convert hexa string to hexa bin
       rgb=Ucase(rgb);
       Hex2chr(bin3:rgb:6);
       Result.red = r / 255;
       Result.green = g / 255;
       Result.blue = B/ 255;
       Return Result;


B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  P                 e

    ? *=---------------------------------------------------------------=*
     p PdfSetColorHTML...
BPR ?p                 b                   export
     d                 pi                  likeds(PdfColor)
     d    StrokeColor                50    const varying
     d    FillColor                  50    const varying
     d    Color        ds                  likeds(PdfColor)
     d    ColorHTML    ds                  likeds(PdfColorHTML)
      /free
       Color.Device='RGB';
       ColorHTML=Pdfcheckcolorhtml(StrokeColor);
       Color.strokeRed = ColorHTML.red;
       Color.strokeGreen= ColorHTML.green ;
       Color.strokeBlue = ColorHTML.blue ;
       ColorHTML=Pdfcheckcolorhtml(FillColor);
       Color.FillRed = ColorHTML.red;
       Color.FillGreen = ColorHTML.green ;
       Color.FillBlue = ColorHTML.blue ;
       Return Color;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmStrokingColorHTML...
BPR ?p                 b                   export

     d                 pi                  like(pdfs1)
     d    NamedColor                 50    value varying
     d    ColorHTML    ds                  likeds(PdfColorHTML)
      /free
       ColorHTML=Pdfcheckcolorhtml(NamedColor);
       Return PdfStrmStrokingColorRGB(
          ColorHTML.red
          : ColorHTML.green
          : ColorHTML.blue );
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     P PdfStrmFillingColorHTML...
BPR ?P                 b                   export

     d                 pi                  like(pdfs1)
     d    NamedColor                 50    value varying
     d    ColorHTML    ds                  likeds(PdfColorHTML)
      /free
       ColorHTML=Pdfcheckcolorhtml(NamedColor);
       Return PdfStrmFillingColorRGB(
          ColorHTML.red
          : ColorHTML.green
          : ColorHTML.blue );
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfComment      b                   export
     d PdfComment      pi
     d    comment                   256    const varying
      /free
       PdfWrite('%' + comment + Crlf);
       Return;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfRandomize    b                   export
     d                 pi
     d    randomize                    n
      /free
B01    If randomize;
          Pdffile.Randomseed=0;
X01    Else;
          Pdffile.Randomseed=1;
E01    Endif;
       Return;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          Needdump=False;
E01    Endif;
E00    Endsr;

      /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*


    ? *=---------------------------------------------------------------=*
BPR ?p PdfCalcArc      b                   export
     d PdfCalcArc      pi                  likeds(pdfbezier)
     d  p_beta                        8f                      const
     d    length                      5i 0                    const
    ? *=----------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d lAB             s              8f   static
     d lOC             s              8f   static

     d beta            s              8f   static
     d tanAB           s              8f   static
     d traction        s              5p 4 static inz(0.333)
    ? * kapa =4*((2^0,5 - 1)/3)
    ? * kapa = tanAB pour le quart de cercle
     d Kappa           s              8f   static
     d                                     inz(0.552284749830794)
    ? * le nombre d'or = (1+5^0.5)/2
     d phi             s              8f   static
     d                                     inz(1.618033988749894848204586834365)
     d AGauche         s               n   static
    ? /free

       //?calculer une part de camembert : voir le dessin ...
       //?bezier offre le support de 0 à 179 ° :
       //?une bezier dessinée dans un rectangle abcd
       //?(dans l'ordre des aiguilles d'une montre)
       //?avec ab = cd = 80 et bc = da = 120
       //?dessine un demi cercle parfait de rayon 60 et de centre = 1/2 de ad
       //?il y a un rapport de 4/3 entre la longueur ab du point de traction
       //?et le rayon.
       //?pour offrir de 0 à 359, il suffit ... de dessiner 2 fois la courbe
       //?A charge pour l'appelant de faire les appels et rotations nécessaires

       //?la procedure effectue les calculs necessaires pour pouvoir dessiner un arc de cercle
       //?sachant les conditions suivantes :
       //?l'arc est défini par * une origine O * un angle BETA * un rayon LENGTH
       //?l'arc est composé de 2 courbes bezier en miroir l'une de l'autre
       //?ce miroir est une symetrie sur l'axe horizontal OA
       //?une courbe bezier s'inscrit dans un trapeze ABCD, AD étant la base
       //?ici ABCD est un trapeze isocele (BAD = CDA et <= 90°)
       //?et AD parrallèle à BC
       //?OAB est un triangle rectangle, ODC aussi
       //?AD n'est pas perpendiculaire à l'axe horizontal, c'est DD' qui l'est
       //?D' est en fait -D
       //?la courbe complete est obtenue par
       //?goto(D)
       //?bezier(C, B, A)
       //?bezier(-B, -C, -D)
       //?ou, plus précidement
       //?goto(xD,yD)
       //?bezier(xC, yC, xB, yB, xA, yA)
       //?bezier(xB, -yB, xC, -yC, xD, -yD)

       //?cette procedure calcule les coordonnees des points A, B, C et D.

       //?coordonnées de A=(Length, 0)
       //?longueur AB = CD = tan(beta/3)*Length
       //?coordonnées de B=(Length, lAB)
       //?longueur OC=racine(OD^2 + lAB^2)
       //?coordonnées de C=(cos(beta/3*2)*lOC, sin(beta/3*2)*lOC)
       //?coordonnées de D=(cos(beta)*Length , sin(beta)*Length )
       //?
       //?*=----------------------
       //?CMATH are in radians
       //?cos(alpha) = c_cos (c_pi * alpha / 180);
       //?sin(alpha) = c_sin (c_pi * alpha / 180);
       //?*=----------------------
       //?limites à observer pour obtenir un angle beta coherent
       //?1:
       //?l'angle beta ne peut pas depasser 360°, ça n'a pas de sens.
       //?et comme bezier donne un demi cercle correct pour beta entre 1 et 180
       //?beta est donc limité à 180
       //?2:
       //?la methode retenue pour calculer la portion de cercle a une singularité autour de 300°
       //?  en effet l'un des calculs est basé sur tangente(beta*.3) ; et tan(90) = l'infini
       //?mais comme le domaine de definition est 1, 180, on s'en fout
       //?3:
       //?quand l'angle beta = 180°
       //?la courbe de bezier s'exprime dans un rectangle, dont la base est le diamètre
       //?  d'un cercle. du moins c'est ce que j'ai compris. la courbe s'exprime dans le rectangle,
       //?  les coordonnées doivent rester dans le rectangle. de fait la limite de l'angle beta est
       //?  de 180° : le rectangle est calculé en appliquant l'angle beta sur le rayon (parametre
       //?  length)

B01    If p_beta = 0;
          Clear MyBezier;
          Return MyBezier;
E01    Endif;

       //?%rem de 360 retourne 0 à 359. je veux 1 à 180
       //?beta=
       //?   (%Rem(p_beta-1:360)+1)//?limitation à 360
       //?     /2; // demi portion
       beta = p_beta;
B01    If beta < 0;
          beta=-beta;
E01    Endif;
B01    Dow beta > 360;
          beta-=360;
E01    Enddo;
       beta = beta / 2;
B01    If p_beta < 0;
          beta = -beta;
E01    Endif;
       //?bezier offre le support de 0 à 179 °
       //?pour offrir de 0 à 359, il suffit ... de dessiner 2 fois la courbe

B01    If beta > 0;
          AGauche=True;
X01    Else;
          AGauche=False;
          beta = - beta;
E01    Endif;

       //?coordonnées de A=(Length, 0)
       MyBezier.Xa = length;
       MyBezier.Ya = 0;
       //?longueur AB = CD = tan(beta/3)*Length
       //?pas si simple que ca. en fait traction varie de 0.3333 a 0.2921
       //?selon que beta varie de 0 a 180
       //?traction = 0.2921 + (0.3333 - 0.2921) * beta / 180
       //?pour obtenir une progression de TanAB passant par
       //?kappa (=0.55) pour beta = 90 et par 1.5 pour beta = 180. Ben non, 1.3
       //?ce qui nous donne 3 valeurs singulières
       //?beta = 0 , traction = 0.3333
       //?beta = 90, traction = 0.3212
       //?beta= 180, traction = 0.2921
       //?If beta < 90;
       //?   traction = 0.3333 - (0.3333 - 0.3212) * beta / 090;
       //?Else;
       //?   traction = 0.3212 - (0.3212 - 0.2921) * (beta - 90) / 90;
       //?Endif;

       //?2013-02-03 optimisation de la traction par cos
       //?0.0412 = 0.3333 - 0.2921
       traction = C_cos(Radian (Beta/2))*0.0412+0.2921 ;

       //?il y a une autre methode pour calculer un arc de cercle au plus juste avec une bezier
       //?mais elle ne fonctionne que de 0 à 90 °, ce qui implique de dessiner 4 fois la courbe
       //?pour couvrir les 360° ; avec les rotations nécessaires. Pas si simple.

       //?l'idée générale
       //?http://www.whizkidtech.redprince.net/bezier/circle/
       //?le calcul de kappa
       //?http://www.whizkidtech.redprince.net/bezier/circle/kappa/
       //?des tutoriels sur bezier
       //?http://www.tinaja.com/cubic01.shtml
       //?le pdf qui donne les formules
       //?http://www.tinaja.com/glib/bezarc1.pdf

       //?la base pratique :
       //?soit un arc de cercle d'origine 0,0, de rayon=1, d'angle 2a
       //?dont la bissectrice de l'angle à l'origine est horizontale
       //?(donc l'arc est à moitié au dessus, à moitié au dessous)
       //?voir dessin au milieu du pdf cité ci-dessus
       //?cet arc est dessiné par une bezier(x0y0, x1y1, x2y2, x3y3)
       //?la droite x0y0 - x3y3 est perpendiculaire à la bissectrice
       //?la droite x1y1 - x2y2 est perpendiculaire à la bissectrice
       //?les coordonnées dependent uniquement de l'angle 2a:
       //?x0 = cos (a),
       //?y0 =  sin (a),
       //?x1 =(4 - cos (a))/3   ou  x1=(4-x0)/3
       //?y1 =(1 - cos (a)) (cos (a) - 3)/(3 sin (a) +0.0000001)
       //?ou y1 =(1 - x0) (x0 - 3)/((3* y0) +0.0000001)
       //?y1 est fragile aux limites. sin(a) tend vers zero.
       //?   limiter le résultat > 1000 à 1000
       //?x1 = x2
       //?y1 = -y2
       //?x3 = x0,
       //?y3 = -y0
       //?puis
       //?multiplier par la la longueur reelle du rayon
       //?ajouter les coordonnées x et y du point d'origine

       //?90° = infini
B01    If beta * traction = 90 ;   //?beta*.3=90
          tanAB = 10000;
X01    Else;
          tanAB = C_tan (Radian (beta * traction) ) ;
E01    Endif;
B01    If tanAB > 10;
          tanAB = 10;
E01    Endif;


       //?tanab = beta*traction/45   ;


       lAB = tanAB * length ;

       //?coordonnées de B=(Length, lAB)

       MyBezier.Xb = length;
       MyBezier.Yb = lAB;

       //?longueur 0C=racine(0D^2 + lAB^2), ben oui, lAB = lCD
       lOC = (length ** 2 + lAB ** 2 ) ** .5 ;

       //?coordonnées de C=(cos(beta/3*2)*lOC, sin(beta/3*2)*lOC)
       MyBezier.Xc = %Inth(C_cos(Radian (beta * (1-traction) ) ) * lOC);
       MyBezier.Yc = %Inth(C_sin(Radian (beta * (1-traction) ) ) * lOC);

       //?coordonnées de D=(cos(beta)*Length , sin(beta)*Length )
       MyBezier.Xd =%Inth( C_cos(Radian (beta ) ) * length);
       MyBezier.Yd =%Inth( C_sin(Radian (beta ) ) * length);

B01    If Not AGauche;
          MyBezier.Ya =-MyBezier.Ya;
          MyBezier.Yb =-MyBezier.Yb;
          MyBezier.Yc =-MyBezier.Yc;
          MyBezier.Yd =-MyBezier.Yd;
E01    Endif;

       Return MyBezier;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p PdfCalcArc      e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfCalcConcave  b                   export
     d PdfCalcConcave  pi                  likeds(pdfbezier)
     d  p_beta                        8f                      const
     d    length1                     5i 0                    const
     d    length2                     5i 0 options(*nopass)   const
    ? *=----------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d traction        s              8f   static
     d lAB             s              8f   static
     d lOC             s              8f   static
     d lOD             s              8f   static
     d beta            s              8f   static
     d AGauche         s               n   static

    ? /free

       //?%rem de 180 retourne 0 à 179. je veux 1 à 180
       //?beta = %Rem(p_beta-1:180)+1;
       beta = p_beta;
B01    If beta < 0;
          beta=-beta;
E01    Endif;
B01    Dow beta > 180;
          beta-=180;
E01    Enddo;



       //?
       beta = beta / 2;
B01    If p_beta > 0;
          AGauche=True;
X01    Else;
          AGauche=False;

E01    Endif;
B01    If %Parms() > 2;   //?traction imposée
          lOD = length1 ;
          lOC = length1 + length2 ;
          traction = lOC / lOD ;
X01    Else;
          traction = 1 + (C_log(beta) / C_log(180)) ;
          lOD = length1 ;
          lOC = lOD * traction;
E01    Endif;

       MyBezier.Xd =%Inth(C_cos( C_pi * (beta ) / 180) * length1);
       MyBezier.Yd =%Inth(C_sin( C_pi * (beta ) / 180) * length1);
       MyBezier.Xc =%Inth(MyBezier.Xd * traction);
       MyBezier.Yc =%Inth(MyBezier.Yd * traction);
       MyBezier.Xa = MyBezier.Xd;
       MyBezier.Ya =-MyBezier.Yd;
       MyBezier.Xb = MyBezier.Xc;
       MyBezier.Yb =-MyBezier.Yc;
B01    If Not AGauche;
          MyBezier.Ya =-MyBezier.Ya;
          MyBezier.Yb =-MyBezier.Yb;
          MyBezier.Yc =-MyBezier.Yc;
          MyBezier.Yd =-MyBezier.Yd;
E01    Endif;

       Return MyBezier;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
BPR ?p PdfCalcConvexe  b                   export
     d PdfCalcConvexe  pi                  likeds(pdfbezier)
     d  p_beta                        8f                      const
     d    length1                     5i 0                    const
     d    length2                     5i 0 options(*nopass)   const
    ? *=----------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d traction        s              8f   static
     d lOC             s              8f   static
     d lOD             s              8f   static
     d beta            s              8f   static
     d AGauche         s               n   static
      /free
       //?%rem de 180 retourne 0 à 179. je veux 1 à 180
       //?beta = %Rem(p_beta-1:180)+1;
       beta = p_beta;
B01    If beta < 0;
          beta=-beta;
E01    Endif;
B01    Dow beta > 180;
          beta-=180;
E01    Enddo;



       //?
       beta = beta / 2;
B01    If p_beta > 0;
          AGauche=True;
X01    Else;
          AGauche=False;

E01    Endif;

B01    If %Parms() > 2;   //?traction imposée
          lOD = length1 ;
          lOC = length1 - length2 ;
          traction = lOC / lOD ;
X01    Else;
          traction = 1 - (C_log(beta) / C_log(180)) ;   //?donc tjrs <= 1 parce que beta <= 180
          lOD = length1 ;
          lOC = lOD * traction;
E01    Endif;

       MyBezier.Xd =%Inth(C_cos( C_pi * (beta ) / 180) * length1);
       MyBezier.Yd =%Inth(C_sin( C_pi * (beta ) / 180) * length1);
       MyBezier.Xc =%Inth(MyBezier.Xd * traction);
       MyBezier.Yc =%Inth(MyBezier.Yd * traction);
       MyBezier.Xa = MyBezier.Xd;
       MyBezier.Ya =-MyBezier.Yd;
       MyBezier.Xb = MyBezier.Xc;
       MyBezier.Yb =-MyBezier.Yc;
B01    If Not AGauche;
          MyBezier.Ya =-MyBezier.Ya;
          MyBezier.Yb =-MyBezier.Yb;
          MyBezier.Yc =-MyBezier.Yc;
          MyBezier.Yd =-MyBezier.Yd;
E01    Endif;

       Return MyBezier;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*


BPR ?p PdfDrawAddCorona...
BPR ?p                 b                   export
     d                 pi                  like(pdfs2)
     d  p_beta                        8f                      const
     d    length1                     5i 0                    const
     d    length2                     5i 0                    const
    ? *=---------------------------------
     d MyBezier1       ds                  likeds(pdfbezier)
     d MyBezier2       ds                  likeds(pdfbezier)
     d Arc             s                   like(pdfs2)   static

    ? /free






       //?coordonnées de l'arc de longueur L1
       MyBezier1=PdfCalcArc (p_beta : length1);
       MyBezier2=PdfCalcArc (p_beta : length2);
       //?dessiner
       Arc='';

       Arc+= PdfDrawGoto ( MyBezier1.Xd :-MyBezier1.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xC : -MyBezier1.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xD :-MyBezier1.yD );//?debug



       Arc+= PdfDrawAddBezier(MyBezier1.Xc : -MyBezier1.Yc
          :MyBezier1.Xb : -MyBezier1.Yb
          :MyBezier1.Xa : -MyBezier1.Ya );

       //?Arc+= PDFDRAWADDLINE (MyBezier1.xB :-MyBezier1.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xA :-MyBezier1.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xB : MyBezier1.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xA : MyBezier1.yA );//?debug



       Arc+= PdfDrawAddBezier(MyBezier1.Xb : MyBezier1.Yb
          :MyBezier1.Xc : MyBezier1.Yc
          :MyBezier1.Xd : MyBezier1.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xC : MyBezier1.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xD : MyBezier1.yD );//?debug



       Arc+= PdfDrawAddLine ( MyBezier2.Xd : MyBezier2.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier2.xC : MyBezier2.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xD : MyBezier2.yD );//?debug



       Arc+= PdfDrawAddBezier(MyBezier2.Xc : MyBezier2.Yc
          :MyBezier2.Xb : MyBezier2.Yb
          :MyBezier2.Xa : MyBezier2.Ya );
       //?arc+= PDFDRAWADDLINE (MyBezier2.xB : MyBezier2.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xA : MyBezier2.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (MyBezier2.xB : -MyBezier2.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xA :-MyBezier2.yA );//?debug





       Arc+= PdfDrawAddBezier(MyBezier2.Xb :-MyBezier2.Yb
          :MyBezier2.Xc :-MyBezier2.Yc
          :MyBezier2.Xd :-MyBezier2.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier2.xC : -MyBezier2.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xD : -MyBezier2.yD );//?debug

       Arc+= PdfDrawAddLine ( MyBezier1.Xd :-MyBezier1.Yd );


       Return Arc;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfDrawAddDaisy...
BPR ?p                 b                   export
     d                 pi                  like(pdfs2)
     d  p_beta                        8f                      const
     d    length0A                    5i 0                    const
     d    length0B                    5i 0                    const
     d  p_lengthAA1                   5i 0 options(*nopass)   const
     d  p_lengthBB1                   5i 0 options(*nopass)   const
    ? *=---------------------------------
     d    lengthAA1    s              5i 0
     d    lengthBB1    s              5i 0
     d MyBezier1       ds                  likeds(pdfbezier)
     d MyBezier2       ds                  likeds(pdfbezier)
     d Arc             s                   like(pdfs2)   static

    ? /free
       //?daisy = droite de A à B
       //?+ concave (partie haute) de B à B1
       //?+ convexe (partie basse) de A à A1
       //?le tout centré sur la bissectrice de beta = l'axe horizontal

       //?le dessin est donc goto A, convexe bezier par A1 -A1 -A,
       //?  droite -A -B, concave bezier par -B1 B1 B, droite B A




B01    If %Parms() > 3;
          lengthAA1 = p_lengthAA1;
X01    Else;
          lengthAA1=-1;
E01    Endif;
B01    If %Parms() > 4;
          lengthBB1 = p_lengthBB1;
X01    Else;
          lengthBB1=-1;
E01    Endif;

       //?coordonnées de l'arc de longueur L1
B01    If lengthAA1 > 0;
          MyBezier1=PdfCalcConvexe (p_beta : length0A : lengthAA1);
X01    Else;
          MyBezier1=PdfCalcConvexe (p_beta : length0A);
E01    Endif;

B01    If lengthBB1 > 0;
          MyBezier2=PdfCalcConcave( p_beta : length0B : lengthBB1);
X01    Else;
          MyBezier2=PdfCalcConcave( p_beta : length0B);
E01    Endif;
       //?dessiner
       Arc='';

       Arc+= PdfDrawGoto ( MyBezier1.Xa : MyBezier1.Ya );
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xC : -MyBezier1.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xD :-MyBezier1.yD );//?debug
       Arc+= PdfDrawAddBezier(MyBezier1.Xb : MyBezier1.Yb
          :MyBezier1.Xc : MyBezier1.Yc
          :MyBezier1.Xd : MyBezier1.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xB :-MyBezier1.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xA :-MyBezier1.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (MyBezier1.xB : MyBezier1.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier1.xA : MyBezier1.yA );//?debug
       Arc+= PdfDrawAddLine ( MyBezier2.Xd : MyBezier2.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier2.xC : MyBezier2.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xD : MyBezier2.yD );//?debug
       Arc+= PdfDrawAddBezier(MyBezier2.Xc : MyBezier2.Yc
          :MyBezier2.Xb : MyBezier2.Yb
          :MyBezier2.Xa : MyBezier2.Ya );
       //?arc+= PDFDRAWADDLINE (MyBezier2.xB : MyBezier2.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xA : MyBezier2.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (MyBezier2.xB : -MyBezier2.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier2.xA :-MyBezier2.yA );//?debug
       Arc+= PdfDrawAddLine ( MyBezier1.Xa : MyBezier1.Ya );

       Return Arc;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR ?p PdfDrawAddArc   b                   export
     d PdfDrawAddArc   pi                  like(pdfs2)
     d  p_beta                        8f                      const
     d    length                      5i 0                    const
     d  p_gotoA                        n   options(*nopass)   const
    ? *=---------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d Arc             s                   like(pdfs2)   static
     d gotoa           s               n   static
    ? /free
B01    If %Parms() > 2;
          gotoa = p_gotoA;
X01    Else;
          gotoa=False;
E01    Endif;

       //?coordonnées de l'arc
       MyBezier=PdfCalcArc (p_beta : length);


       //?dessiner
       Arc='';
B01    If gotoa;
          Arc+= PdfDrawGoto ( MyBezier.Xd :-MyBezier.Yd );
          //?Arc+= PDFDRAWADDLINE (MyBezier.xC : -MyBezier.yC);//?debug
          //?Arc+= PDFDRAWGOTO ( MyBezier.xD :-MyBezier.yD );//?debug
          //?Arc+= PDFDRAWADDLINE (0           : 0           );//?debug
          //?Arc+= PDFDRAWGOTO ( MyBezier.xD :-MyBezier.yD );//?debug
E01    Endif;
       Arc+= PdfDrawAddBezier(MyBezier.Xc : -MyBezier.Yc
          :MyBezier.Xb : -MyBezier.Yb
          :MyBezier.Xa : -MyBezier.Ya );
       //?Arc+= PDFDRAWADDLINE (MyBezier.xB : -MyBezier.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier.xA : MyBezier.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (0           : 0           );//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier.xA : MyBezier.yA );//?debug
       //?Arc+= PDFDRAWADDLINE (MyBezier.xB : MyBezier.yB);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier.xA : MyBezier.yA );//?debug
       Arc+= PdfDrawAddBezier(MyBezier.Xb : MyBezier.Yb
          :MyBezier.Xc : MyBezier.Yc
          :MyBezier.Xd : MyBezier.Yd );
       //?Arc+= PDFDRAWADDLINE (MyBezier.xC : MyBezier.yC);//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier.xD : MyBezier.yD );//?debug
       //?Arc+= PDFDRAWADDLINE (0           : 0           );//?debug
       //?Arc+= PDFDRAWGOTO ( MyBezier.xD : MyBezier.yD );//?debug
       Return Arc;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p Pdfdrawaddarc   e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
EPR  p PdfDrawAddConcave...
BPR ?p                 b                   export
     d                 pi                  like(pdfs2)
     d  p_beta                        8f                      const
     d    length1                     5i 0                    const
     d  p_gotoA                        n   options(*nopass)   const
     d    length2                     5i 0 options(*nopass)   const
    ? *=---------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d Arc             s                   like(pdfs2)   static
     d gotoa           s               n   static

    ? /free
B01    If %Parms() > 2;
          gotoa = p_gotoA;
X01    Else;
          gotoa=False;
E01    Endif;

B01    If %Parms() > 3;
          //?coordonnées de l'arc
          MyBezier=PdfCalcConcave (p_beta : length1 : length2);
X01    Else;
          MyBezier=PdfCalcConcave (p_beta : length1 );
E01    Endif;
       //?dessiner
       Arc='';
B01    If gotoa;
          Arc+= PdfDrawGoto ( MyBezier.Xa : MyBezier.Ya );
E01    Endif;
       Arc+= PdfDrawAddBezier(MyBezier.Xb : MyBezier.Yb
          :MyBezier.Xc : MyBezier.Yc
          :MyBezier.Xd : MyBezier.Yd );
       Return Arc;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
EPR  p PdfDrawAddConvexe...
BPR ?p                 b                   export
     d                 pi                  like(pdfs2)
     d  p_beta                        8f                      const
     d    length1                     5i 0                    const
     d  p_gotoA                        n   options(*nopass)   const
     d    length2                     5i 0 options(*nopass)   const
    ? *=---------------------------------
     d MyBezier        ds                  likeds(pdfbezier)
     d Arc             s                   like(pdfs2)   static
     d gotoa           s               n   static

    ? /free
B01    If %Parms() > 2;
          gotoa = p_gotoA;
X01    Else;
          gotoa=False;
E01    Endif;

B01    If %Parms() > 3;
          //?coordonnées de l'arc
          MyBezier=PdfCalcConvexe (p_beta : length1 : length2);
X01    Else;
          MyBezier=PdfCalcConvexe (p_beta : length1 );
E01    Endif;
       //?dessiner
       Arc='';
B01    If gotoa;
          Arc+= PdfDrawGoto ( MyBezier.Xa : MyBezier.Ya );
E01    Endif;
       Arc+= PdfDrawAddBezier(MyBezier.Xb : MyBezier.Yb
          :MyBezier.Xc : MyBezier.Yc
          :MyBezier.Xd : MyBezier.Yd );
       Return Arc;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
    ? /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*


BPR ?P PdfCalculateTicks...
BPR ?P                 b                   export
     D                 pi
    ?D*min_i                          8f
    ?D*max_i                          8f
    ?D*ticks                          5i 0
    ?D*spacing                        8f
     d chart                               likeds(PdfChart_t)
     D minval          s              8f
     D maxval          s              8f
     D low             s              8f
     D high            s              8f
     D tmp             s              8f
      /free
       minval = chart.minval;
       maxval = chart.maxval;
B01    If (chart.minval > chart.maxval);
          chart.maxval = minval;
          chart.minval = maxval;
E01    Endif;
       Pdfscale (chart);
B01    If (chart.Ticks < 2);
          chart.Ticks = 2;
E01    Endif;
       //?spacing = (high - low)/(ticks - 1.0);
       Return;
      /end-free
EPR  P                 e

BPR ?P PdfScale        b
     D PdfScale        pi
     d chart                               likeds(PdfChart_t)
    ? * = ----------------------------------
     D ulow            s              8f   dim(9)
     D uhigh           s              8f   dim(9)
     D uticks          s              8f   dim(9)
     D udelta          s              8f
     D ufit            s              8f   dim(9)
     D fit             s              8f   dim(9)
     D i               s             10I 0
     D k               s             10I 0 inz(0)
     D bestdelta       s              8f   dim(9)
     D Penalty         s              8f   inz(0.02)
     D xdelta          s              8f
     D delta           s              8f   dim(9)
      /free

       bestdelta(1) = 0.1;
       bestdelta(2) = 0.2;
       bestdelta(3) = 0.5;
       bestdelta(4) = 1.0;
       bestdelta(5) = 2.0;
       bestdelta(6) = 5.0;
       bestdelta(7) = 10.0;
       bestdelta(8) = 20.0;
       bestdelta(9) = 50.0;
B01    If (chart.minval = chart.maxval);
B02       For i = 1 To 9;
             ulow(i) = chart.minval;
             uhigh(i) = chart.maxval+1;
             uticks(i) = 1;
E02       Endfor;
X01    Else ;
          xdelta = chart.maxval - chart.minval;
B02       For i = 1 To 9;
             delta(i) = 10 ** C_floor(C_log10(xdelta)-1) * bestdelta(i);
             uhigh(i) = delta(i) * C_ceil(chart.Maxval/delta(i));
             ulow(i) = delta(i) * C_floor(chart.Minval/delta(i));
             uticks(i) = C_floor((uhigh(i)-ulow(i))/delta(i)) +1;
E02       Endfor;
E01    Endif;
       udelta = chart.maxval - chart.minval;
       k = 1;
B01    For i = 1 To 9;
          ufit(i) = ((uhigh(i) - ulow(i)) - udelta)/(uhigh(i) - ulow(i));
B02       If (uticks(i) - 6.0 > 1.0);
             fit(i) = 2*ufit(i) + Penalty * ((uticks(i) - 6.0) ** 2);
X02       Else;
             fit(i) = 2*ufit(i) + Penalty * (1.0 ** 2);
E02       Endif;
B02       If (i > 0);
B03          If (fit(i) < fit(k));
                k = i;
E03          Endif;
E02       Endif;
E01    Endfor;
       chart.low = ulow(k);
       chart.high = uhigh(k);
       chart.Ticks = uticks(k);
       //? chart.low = ulow(k);
       //? chart.high = uhigh(k);
       //? chart.ticks = uticks(k);

       chart.Range = chart.high - chart.low ;
       chart.spacing = chart.Range / (chart.Ticks - 1.0);
       Return;
      /end-free
EPR  P                 e

BPR ?P PdfDrawChart    b                   export
     d PdfDrawChart    pi                  like(pdfstream)
     d Chart                               likeds(PdfChart_t)
     d Pelts           s               *
    ?d*elts            ds                  based(chart.pElements)
     dwelt             ds                  likeds(pdfchartelement_t)
     d elt             ds                  likeds(pdfchartelement_t)
     d                                     based(pElt)
    ?d*series          ds                  based(chart.pseries)
     d serie           ds                  likeds(pdfchartserie_t)
     d                                     based(      pserie)
     D idx             s              3s 0
    ?D*rng             s             14s 2
    ?D*minval_d        s             12s 0
     D minval          s              8f
     D maxval          s              8f
     D PieSum          s              8f
     D PieMaxL         s              8f
    ?D*tck_val         s             12s 0
    ?D*tck_val_c       s             20a
    ?D*difrow          s              5s 2
    ?D*difcol          s              5s 2
     D curr_X          s              8f
     D Curr_Y          s              8f
     D fntsiz          s              5i 0
     D strsiz          s              3s 0

    ?D*pct             s              5a
    ?D*min_lbl_amt     s              7a   inz('-999.99')
     d element_width   s              8f
     d element_height  s              8f
     d column_width    s              8f
     d column_height   s              8f
     d spacer_width    s              8f
     d Tick_height     s              8f
     d w1              s              8f
     d w2              s              8f
     d w3              s              8f
     d w4              s              8f
    ? * direction generale du texte : plutot horizontal ou plutot vertical
     d TextIsHorizontal...
     d                 s               n
     d i               s              5i 0
     d iserie          s              5i 0
     d zeroneg         s              5i 0
     d zeropos         s              5i 0
     d wtext           s             50    varying
     d MyChartFrame    s                   like(pdfstream  )
     d MyChartBack     s                   like(pdfstream  )
     d MyChartHeading  s                   like(pdfstream  )
     d MyChartTick     s                   like(pdfstream  )
     d MyChartGuide    s                   like(pdfstream  )
     d MyChartElt      s                   like(pdfstream  )
     d MyChartAxe      s                   like(pdfstream  )
     d MyChartText     s                   like(pdfstream  )
    ?d*****
    ?d*pdfchartelementsettext
    ?d*curr_w          s              8f
    ?d*curr_h          s              8f
    ?d****
     d PieColor        ds                  likeds(PdfColor)
     d PieText         s                   like(pdfstream  )
     d PieTextLen      s                   like(PdfTextStrlen)
     d
     d

      /free
       Pelts = chart.Pelements;



       Exsr Defaultsetting;

       MyChartFrame += PdfStrmSaveGraphicState();
B01    If chart.Rotate_degree <> 0;
          //?translate au centre du graphe
          //?rotate
          //?retour à l'origine
          MyChartFrame += PdfStrmTranslate (
             chart.Frame.Style.x
             :chart.Frame.Style.y
             );
          MyChartFrame += PdfStrmRotate(chart.Rotate_degree);
          MyChartFrame += PdfStrmTranslate (
             -chart.Frame.Style.x
             :-chart.Frame.Style.y
             );
E01    Endif;
       MyChartFrame += PdfDrawLineWidth(chart.Default.Style.Linewidth);

       //?structure de la composition:
       //?le cadre general
       //?le titre
       //?les labels en X
       //?les labels en Y
       //?les axes X et Y
       //?les values : representations et nombres

       //?TODO
       //?preparer l'ajout de PieChart
       //?ajouter x y w h à Style, remplacer tous les curr_*, les xpos ypos
       //?ajouter à chart.frame:
       //?   element_width
       //?   column_width
       //?   spacer_width
       //?   element_height

       Exsr Chartframe;   //?la zone du chart
       Exsr Background;   //?la zone de data
       Exsr Heading ;
       Exsr X_axis ;
       Exsr Y_axis ;
       Exsr Elements1;
       Exsr X_ticks ;
       Exsr Y_ticks ;

       MyChartFrame += MyChartHeading ;
       MyChartFrame += MyChartBack ;
       MyChartFrame += MyChartAxe ;
       MyChartFrame += MyChartGuide ;
       MyChartFrame += MyChartElt ;
       MyChartFrame += MyChartTick ;
       MyChartFrame += MyChartText ;
       MyChartFrame += PdfStrmRestoreGraphicState();

       Return MyChartFrame;







       //?* = --------------------------------------------------------------------
B00    Begsr Defaultsetting;
       //?* = -----------------------------------------------------------------
       //?valeurs par défaut initiales
B01    If chart.Default.Style.Linewidth = 0;
          chart.Default.Style.Linewidth = 1;
E01    Endif;
B01    If chart.Default.Style.font.Obj = 0;
          Message('PDF0017':'':'':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;
B01    If chart.Default.Style.StrokeColor = '';
          chart.Default.Style.StrokeColor = 'black     ';
E01    Endif;
B01    If chart.Default.Style.FillColor = '';
          chart.Default.Style.FillColor = 'brown     ';
E01    Endif;
B01    If chart.Default.Style.Backcolor = '';
          chart.Default.Style.Backcolor = 'white     ';
E01    Endif;
B01    If chart.Default.Style.Alignment = '';
          chart.Default.Style.Alignment = Pdf_center ;
E01    Endif;
B01    If chart.Default.Style.fontSize = 0 ;
          chart.Default.Style.fontSize = chart.Frame.Style.Height/50;
E01    Endif;
       //?resoudre les valeurs speciales
       chart.Default.Style = Pdfstyle(
          chart.Default.Style :chart.Default.Style);
       //?propagation des valeurs par defaut
       chart.Default.Style = Pdfstyle(
          chart.Default.Style :chart.Default.Style);
       chart.Frame.Style = Pdfstyle(chart.Frame.Style
          :chart.Default.Style);
       chart.data.Style = Pdfstyle(chart.data.Style
          :chart.Default.Style);
       chart.Xaxe.Style = Pdfstyle(chart.Xaxe.Style
          :chart.Default.Style);
B01    If chart.Xaxe.Style.Rotate_degree = -3 ;
          chart.Xaxe.Style.Rotate_degree = -chart.Rotate_degree ;
B02       If chart.Xaxe.Style.Rotate_degree < 0;
             chart.Xaxe.Style.Rotate_degree += 360;
E02       Endif;
E01    Endif;
       chart.Yaxe.Style = Pdfstyle(chart.Yaxe.Style
          :chart.Default.Style);
B01    If chart.Yaxe.Style.Rotate_degree = -3 ;
          chart.Yaxe.Style.Rotate_degree = -chart.Rotate_degree ;
B02       If chart.Yaxe.Style.Rotate_degree < 0;
             chart.Yaxe.Style.Rotate_degree += 360;
E02       Endif;
E01    Endif;
       chart.Title.Style =
          Pdfstyle(chart.Title.Style :chart.Default.Style);

       //?implantation des zones xaxe yaxe title data
B01    If chart.Aspect = 'PIE';
          chart.Xaxe.Style.Visible = False ;
          chart.Xaxe.Style.height = 0;
          chart.Xaxe.Margin = 0;
          chart.Yaxe.Style.Visible = False ;
          chart.Yaxe.Style.width = 0;
          chart.Yaxe.Margin = 0;
E01    Endif;
B01    If chart.Xaxe.Style.height = -1;
          chart.Xaxe.Style.height = chart.Frame.Style.height / 10;
E01    Endif;

B01    If chart.Title.Style.height = -1 ;
          chart.Title.Style.height = chart.Frame.Style.height / 10;
E01    Endif;

B01    If chart.Yaxe.Style.width = -1;
          chart.Yaxe.Style.width = chart.Frame.Style.width / 10;
E01    Endif;

B01    If chart.Xaxe.Margin = -1 ;
          chart.Xaxe.Margin = chart.Frame.Style.width * .05;
E01    Endif;
B01    If chart.Yaxe.Margin = -1 ;
          chart.Yaxe.Margin = chart.Frame.Style.width * .05;
E01    Endif;

       //?title : accroché en haut à gauche
       //?imposé : .title.style.height
       chart.Title.Style.x = chart.Frame.Style.x + 1;
       chart.Title.Style.y = chart.Frame.Style.y + chart.Frame.Style.height
          - chart.Title.Style.height -1;
       chart.Title.Style.width = chart.Frame.Style.width - 2;

       //?le reste, temporairement dans chart.data.style
       chart.data.Style.x = chart.Frame.Style.x;
       chart.data.Style.y = chart.Frame.Style.y + 1;
       chart.data.Style.width = chart.Title.Style.width ;
       chart.data.Style.height = chart.Frame.Style.height
          - chart.Title.Style.height -2;

       //?yaxe : accroché en bas à gauche + xaxe.style.height
       //?imposé : .yaxe.style.width
       chart.Yaxe.Style.x = chart.data.Style.x;
       chart.Yaxe.Style.y = chart.data.Style.y + chart.Xaxe.Style.height + 2;
       chart.Yaxe.Style.height = chart.data.Style.height - 2
          - chart.Xaxe.Style.height
          - chart.Yaxe.Margin;
       //?xaxe : accroché en bas à gauche + yaxe.style.width
       //?imposé : .xaxe.style.height
       chart.Xaxe.Style.x = chart.data.Style.x + chart.Yaxe.Style.width + 2;
       chart.Xaxe.Style.y = chart.data.Style.y ;
       chart.Xaxe.Style.width = chart.data.Style.width - 2
          - chart.Yaxe.Style.width
          - chart.Xaxe.Margin;

       //?recadrage de chart.data
       chart.data.Style.x = chart.Xaxe.Style.x ;
       chart.data.Style.y = chart.Yaxe.Style.y;
       chart.data.Style.width = chart.Xaxe.Style.width;
       chart.data.Style.height = chart.Yaxe.Style.height;











       element_width = chart.data.Style.width / (chart.Serie_count );
       //?column_width = element_width * .80 ;
       //?spacer_width = element_width * .20 ;
       element_height = chart.data.Style.height;
       //?calcul des echelles de valeurs
       chart.minval = *hival;
       chart.maxval = *loval;
       PieSum = 0;
       PieMaxL = 0;
B01    For idx = 0 To chart.Serie_count - 1;
          pserie = chart.Pseries+(idx )*%size(Pdfchartserie_t);
          serie.Style.width = chart.data.Style.width / (chart.Serie_count );
          serie.Style.height = chart.data.Style.height;
          serie.Style.x = chart.Xaxe.Style.x
             + idx * serie.Style.width ;
          serie.Style.y = chart.Xaxe.Style.y
             + chart.Xaxe.Style.height + 2;

          serie.Style = Pdfstyle(serie.Style:chart.Default.Style);
B02       If serie.Style.Rotate_degree = -3 ;
             serie.Style.Rotate_degree = -chart.Rotate_degree ;
B03          If serie.Style.Rotate_degree < 0;
                serie.Style.Rotate_degree += 360;
E03          Endif;
E02       Endif;
          PieSum += serie.Sumpos-serie.Sumneg;
B02       If PieMaxL < serie.Style.Linewidth ;
             PieMaxL = serie.Style.Linewidth ;
E02       Endif;
B02       If ( serie.Sumpos > chart.maxval );
             chart.maxval = serie.Sumpos ;
E02       Endif;
B02       If ( serie.Sumneg < chart.minval );
             chart.minval = serie.Sumneg ;
E02       Endif;
E01    Endfor;
B01    For idx = 0 By 1 To chart.Elt_count - 1;
          pElt = Pelts+(idx )*%size(elt);
          elt.Style.width = chart.data.Style.width / (chart.Serie_count );
          elt.Style.height = chart.data.Style.height;
          elt.Style = Pdfstyle(elt.Style:chart.Default.Style);
B02       If elt.Style.Rotate_degree = -3 ;
             elt.Style.Rotate_degree = -chart.Rotate_degree ;
B03          If elt.Style.Rotate_degree < 0;
                elt.Style.Rotate_degree += 360;
E03          Endif;
E02       Endif;
E01    Endfor;
B01    If (chart.Floating_zero = False);
          chart.minval = Min(chart.minval:0);
E01    Endif;
       Pdfcalculateticks(chart);

       //?position de l'axe zero, x ou y

B01    Select;
X01       When chart.Aspect = 'COLUMN' Or
                chart.Aspect = 'LINE';
             //?position de la ligne zero


             //?yzero n'est pas sensible à floating_zero.
             //?yzero  =  l'origine des elements, pas l'origine de l'axe des X
             chart.data.Yzero = chart.data.Style.y+
                chart.data.Style.Height*%abs(chart.low)/chart.Range;

             //?yaxe, tick sizes
             Tick_height = chart.Yaxe.Style.height /(chart.Ticks-1);
X01       When chart.Aspect = 'PIE';
             //?coordonées du centre du piechart
             chart.data.Xzero = chart.data.Style.x+
                chart.data.Style.Width/2;
             chart.data.Yzero = chart.data.Style.y+
                chart.data.Style.Height/2;
             element_width = 0;
             column_width = 0;
             spacer_width = 0;
             //?rayon du cercle, espace pour le texte de serie
             element_height = chart.data.Style.Height/2
                -(chart.data.Style.fontSize )
                - PieMaxL * 10;
E01    Endsl;
E00    Endsr;



       //?* = --------------------------------------------------------------------
B00    Begsr Chartframe;
       //?* = -----------------------------------------------------------------
       //?chart frame
B01    If ( chart.Frame.Style.Background = True );
          MyChartFrame += PdfDrawLineWidth(chart.Frame.Style.Linewidth);
          MyChartFrame += Pdfstrmfillingcolorhtml(chart.Frame.Style.Backcolor);
        MyChartFrame += Pdfstrmstrokingcolorhtml(chart.Frame.Style.StrokeColor);
          MyChartFrame += PdfDrawGoto(chart.Frame.Style.x
             :chart.Frame.Style.y );
          MyChartFrame += PdfDrawAddRectangle(chart.Frame.Style.x
             :chart.Frame.Style.y :
             chart.Frame.Style.width :
             chart.Frame.Style.height );
          MyChartFrame += PdfDrawClosePath(Pdf_fill: Pdf_stroke);
E01    Endif;
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr Background;
       //?* = -----------------------------------------------------------------
       //?data background
B01    If chart.data.Style.Background = True;
          MyChartBack += PdfDrawLineWidth(chart.data.Style.Linewidth);
          MyChartBack += Pdfstrmfillingcolorhtml(chart.data.Style.Backcolor);
          MyChartBack += Pdfstrmstrokingcolorhtml(chart.data.Style.StrokeColor);
          MyChartBack += PdfDrawAddRectangle(chart.data.Style.x
             :chart.data.Style.y:
             chart.data.Style.width:chart.data.Style.height);
          MyChartBack += PdfDrawClosePath(Pdf_fill:Pdf_stroke);
E01    Endif;
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr Heading ;
       //?* = -----------------------------------------------------------------
       //?heading background IE title
       //?heading frame
B01    If chart.Title.Style.Background = True;
          MyChartHeading += PdfDrawLineWidth(chart.Title.Style.Linewidth);
          MyChartHeading +=
             Pdfstrmfillingcolorhtml(chart.Title.Style.Backcolor);
          MyChartHeading +=
             Pdfstrmstrokingcolorhtml(chart.Title.Style.StrokeColor);
          MyChartHeading += PdfDrawAddRectangle(chart.Title.Style.x
             :chart.Title.Style.y
             : chart.Title.Style.width :chart.Title.Style.height);
          MyChartHeading += PdfDrawClosePath(Pdf_fill:Pdf_stroke);
E01    Endif;
       //?heading text
       MyChartHeading += PdfTextOpen();
B01    If ( chart.Title.text <> ' ' );
B02       If ( chart.Title.Style.fontSize = -1 );
             fntSiz = chart.Title.Style.height;
             strsiz = PdfTextStrLen(chart.Title.text
                : chart.Title.Style.height
                : chart.Title.Style.font.basefont );
B03          Dow fntSiz > 0 And strsiz > chart.Title.Style.width ;
                fntSiz = fntSiz - 2;
                strsiz = PdfTextStrLen(chart.Title.text
                   : fntSiz
                   : chart.Title.Style.font.basefont );
E03          Enddo;
X02       Else;
             fntSiz = chart.Title.Style.fontSize;
E02       Endif;
          chart.Title.Style.fontSize = fntSiz;
B02       If ( chart.Title.Style.fontSize > 0);
             //?pas mettre de save / restore entre BT et ET
             //?   MyChartHeading += PdfStrmSaveGraphicState();
             MyChartHeading += PdfTextFont(
                chart.Title.Style.font
                : chart.Title.Style.fontSize );
             Curr_Y = chart.Title.Style.y + chart.Title.Style.fontSize * .2 ;

B03          Select;
X03             When chart.Title.Style.Alignment = Pdf_center ;
                   curr_X = chart.Title.Style.x +(chart.Title.Style.width /2);
            MyChartHeading += PdfTextGoTo(PdfTextCenter(curr_X:chart.Title.text)
                      :Curr_Y);
X03             When chart.Title.Style.Alignment = Pdf_right;
                   curr_X = chart.Title.Style.x +chart.Title.Style.width - 5;
             MyChartHeading += PdfTextGoTo(PdfTextRight(curr_X:chart.Title.text)
                      :Curr_Y);
X03             When chart.Title.Style.Alignment = Pdf_left;
                   curr_X = chart.Title.Style.x + 5;
                   MyChartHeading += PdfTextGoTo(curr_X:Curr_Y);
E03          Endsl;

             MyChartHeading +=
                Pdfstrmfillingcolorhtml(chart.Title.Style.FillColor);
             MyChartHeading +=
                Pdfstrmstrokingcolorhtml(chart.Title.Style.StrokeColor);
             MyChartHeading += PdfTextAdd(%Trim(chart.Title.text));
             //?pas mettre de save / restore entre BT et ET
             //?MyChartHeading += PdfStrmRestoreGraphicState();
E02       Endif;
E01    Endif;
       MyChartHeading += PdfTextClose();
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr X_axis ;
       //?* = -----------------------------------------------------------------

B01    If chart.Aspect = 'PIE';
          Leavesr;
E01    Endif;
B01    If ( chart.Xaxe.Style.Visible<>'1' );
          Leavesr;
E01    Endif;

       //?border and background
B01    If chart.Xaxe.Style.Background = True;
          MyChartAxe += PdfDrawLineWidth(chart.Xaxe.Style.Linewidth);
          MyChartAxe += Pdfstrmfillingcolorhtml(chart.Xaxe.Style.Backcolor);
          MyChartAxe += Pdfstrmstrokingcolorhtml(chart.Xaxe.Style.StrokeColor);
          MyChartAxe += PdfDrawAddRectangle(chart.Xaxe.Style.x
             :chart.Xaxe.Style.y :
             chart.Xaxe.Style.width:chart.Xaxe.Style.height-1);
          MyChartAxe += PdfDrawClosePath(Pdf_fill:Pdf_stroke);
E01    Endif;

       //?chart.xaxe.style.fontsize/2 = ticks size
B01    If ( chart.Xaxe.Style.fontSize < 5 );
          chart.Xaxe.Style.fontSize = 5;
E01    Endif;
B01    Select;
X01       When chart.Aspect = 'COLUMN' Or
                chart.Aspect = 'LINE';
             //?labels on the x axis

B02          For idx = 0 To chart.Serie_count-1;
                pserie = chart.Pseries+(idx )*%size(Pdfchartserie_t);
                MyChartAxe += PdfTextOpen();
                MyChartAxe += PdfTextFont(chart.Xaxe.Style.font
                   :chart.Xaxe.Style.fontSize);
                MyChartAxe += Pdfstrmfillingcolorhtml(
                   chart.Xaxe.Style.FillColor);
                MyChartAxe += Pdfstrmstrokingcolorhtml(
                   chart.Xaxe.Style.StrokeColor);
                //?se translater au centre de la case formée
                //?par l'élément et l'axe des X,
                //?effectuer la rotation,
                //?se deplacer à gauche de 1/2 largeur d'element,
                //?ecrire le texte
                curr_X = chart.Xaxe.Style.x
                   + (idx + 0.5) * serie.Style.width ;
                Curr_Y = chart.Xaxe.Style.y
                   + chart.Xaxe.Style.height / 2;
                MyChartAxe += PdfStrmSaveGraphicState();
                MyChartAxe += PdfStrmTranslate(curr_X:Curr_Y);
                //?si rotate = -1, alors faire une rotation en eventail
B03             If chart.Xaxe.Style.Rotate_degree = -1;
                   //?calcul de l'angle par arctangente delta_x / delta_y
                   //?entre currx & y  et le point en haut à droite
                   w2 = chart.data.Style.width
                      - ( idx + 1) * serie.Style.width ;
                   w3 = chart.data.Style.height ;
                   w1 = 90 -Degree(C_atan2( w2 : w3 ));




                   MyChartAxe += PdfStrmRotate(w1);
X03             Else;
                   MyChartAxe += PdfStrmRotate(chart.Xaxe.Style.Rotate_degree);
E03             Endif;
                MyChartAxe += PdfTextMoveTo(- Min(
                   chart.Xaxe.Style.height : serie.Style.width)/ 2 :0);

                MyChartAxe += PdfTextAdd(%Trim(serie.text ));
                MyChartAxe += PdfStrmRestoreGraphicState();
                MyChartAxe += PdfTextClose();
E02          Endfor;
E01    Endsl;
       MyChartAxe += PdfDrawClosePath( Pdf_stroke);
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr X_ticks;
       //?* = -----------------------------------------------------------------
B01    If chart.Aspect = 'PIE';
          Leavesr;
E01    Endif;
       //?x axis line - not conditionned
       MyChartTick += PdfDrawLineWidth(chart.Xaxe.Style.Linewidth);
       MyChartTick += Pdfstrmstrokingcolorhtml('black' );
B01    If ( chart.minval < 0 )
X..       And ( chart.Floating_zero);
          //?Floating x-axis
          MyChartTick += PdfDrawGoto(chart.data.Style.x:chart.data.Yzero);
          MyChartTick += PdfDrawAddLine(chart.data.Style.x
             +chart.data.Style.width
             :chart.data.Yzero);
X01    Else;
          //?x-axis at bottom
          MyChartTick += PdfDrawGoto(chart.data.Style.x:chart.data.Style.y );
          MyChartTick += PdfDrawAddLine(
             chart.data.Style.x+chart.data.Style.width
             :chart.data.Style.y );
E01    Endif;
       MyChartTick += PdfDrawClosePath( Pdf_stroke);

       //?ticks sur l'axe zero
B01    Select;
X01       When chart.Aspect = 'COLUMN' Or
                chart.Aspect = 'LINE';

B02          If ( chart.Floating_zero);
                Curr_Y = chart.data.Yzero;
X02          Else;
                Curr_Y = chart.data.Style.y ;
E02          Endif;
             curr_X = chart.data.Style.x;
B02          For idx = 0 To chart.Serie_count -1;
                pserie = chart.Pseries+(idx )*%size(Pdfchartserie_t);
B03             If chart.Xaxe.Guide ;
                   curr_X = chart.data.Style.x +( idx+1) * serie.Style.width;
                   //?juste stroker le bord de l'element
                   MyChartGuide += PdfStrmStrokingColorGray(0);   //?black
                   MyChartGuide += PdfDrawGoto (
                      curr_X
                      : chart.Xaxe.Style.y );
                   MyChartGuide += PdfDrawAddLine (
                      curr_X

                      : chart.Xaxe.Style.y + chart.data.Style.height
                      + chart.Xaxe.Style.height +2);
                   MyChartGuide += PdfDrawClosePath( Pdf_stroke);

E03             Endif;
                curr_X = chart.data.Style.x +( idx ) * serie.Style.width;

                MyChartTick += PdfDrawGoto(curr_X:Curr_Y);
B03             If ( chart.Ticksinside );
                   MyChartTick += PdfDrawAddLine(curr_X:Curr_Y
                      +chart.Xaxe.Style.Fontsize/2);
X03             Else;
                   MyChartTick += PdfDrawAddLine(curr_X:Curr_Y
                      -chart.Xaxe.Style.Fontsize/2);
E03             Endif;
                MyChartTick += PdfDrawClosePath( Pdf_stroke);
B03             If ( chart.Doubleticks And idx < chart.Serie_count);
                   curr_X += serie.Style.Width/2;
                   MyChartTick += PdfDrawGoto(curr_X:Curr_Y);
B04                If ( chart.Ticksinside );
                      MyChartTick += PdfDrawAddLine(curr_X:Curr_Y
                         +chart.Xaxe.Style.Fontsize/2);
X04                Else;
                      MyChartTick += PdfDrawAddLine(curr_X:Curr_Y
                         -chart.Xaxe.Style.Fontsize/2);
E04                Endif;
                   MyChartTick += PdfDrawClosePath( Pdf_stroke);
E03             Endif;
E02          Endfor;
E01    Endsl;
       //?mychart += pdfdrawclosepath( pdf_stroke);
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr Y_axis ;
       //?* = -----------------------------------------------------------------

B01    If chart.Aspect = 'PIE';
          Leavesr;
E01    Endif;
B01    If ( chart.Yaxe.Style.Visible<>'1' );
          Leavesr;
E01    Endif;
B01    If chart.Yaxe.Style.Background = True;
          MyChartAxe += PdfDrawLineWidth(chart.Yaxe.Style.Linewidth);
          MyChartAxe += Pdfstrmfillingcolorhtml(chart.Yaxe.Style.Backcolor);
          MyChartAxe += Pdfstrmstrokingcolorhtml(chart.Yaxe.Style.StrokeColor);
          MyChartAxe += PdfDrawAddRectangle(
             chart.Yaxe.Style.x:chart.Yaxe.Style.y:
             chart.Yaxe.Style.width-1:chart.Yaxe.Style.height );
          MyChartAxe += PdfDrawClosePath(Pdf_fill:Pdf_stroke);
E01    Endif;
       //?chart.yaxe.style.fontsize/2 = ticks size
B01    If ( chart.Yaxe.Style.fontSize < 5 );
          chart.Yaxe.Style.fontSize = 5;
E01    Endif;
B01    Select;
X01       When chart.Aspect = 'COLUMN' Or
                chart.Aspect = 'LINE';
             //?labels on the y axis

B02          For idx = 0 To chart.Ticks - 1 ;

                MyChartAxe += PdfTextOpen();
                MyChartAxe += PdfTextFont(chart.Yaxe.Style.font
                   :chart.Yaxe.Style.fontSize);
                MyChartAxe += Pdfstrmfillingcolorhtml(
                   chart.Yaxe.Style.FillColor);
                MyChartAxe += Pdfstrmstrokingcolorhtml(
                   chart.Yaxe.Style.StrokeColor);
                //?se translater au centre de la case formée
                //?par le tick   et l'axe des Y,
                //?effectuer la rotation,
                //?se deplacer à gauche de 1/2 largeur d'element,
                //?ecrire le texte
                Curr_Y = chart.Yaxe.Style.y + (idx ) * Tick_height ;
                curr_X = chart.Yaxe.Style.x + chart.Yaxe.Style.width / 2;
                MyChartAxe += PdfStrmSaveGraphicState();
                MyChartAxe += PdfStrmTranslate(curr_X:Curr_Y);
                //?si rotate = -1, alors faire une rotation en eventail
B03             If chart.Yaxe.Style.Rotate_degree = -1;
                   //?calcul de l'angle par arctangente delta_x / delta_y
                   //?entre currx & y  et le point en haut à droite
                   w1 = 90 - Degree(C_atan2(
                      chart.Yaxe.Style.x + chart.Yaxe.Style.width
                      + chart.data.Style.width - curr_X
                      : chart.Yaxe.Style.y +
                      chart.data.Style.height - Curr_Y));
                   MyChartAxe += PdfStrmRotate(w1);
X03             Else;
                   MyChartAxe += PdfStrmRotate(chart.Yaxe.Style.Rotate_degree);
E03             Endif;

                //?sauf si la rotation est d'environ 90 degres, cadrage à gau
                //?par moveto en X
B03             If (45 <= serie.Style.Rotate_degree
X..                And serie.Style.Rotate_degree <= 135)
X03             Or (225 <= serie.Style.Rotate_degree
X..                And serie.Style.Rotate_degree <= 315);
X03             Else;
                   MyChartAxe += PdfTextMoveTo(- Min(
                      chart.Yaxe.Style.width : Tick_height )/ 2 :0);
E03             Endif;
                MyChartAxe += PdfTextAdd(%Trim(
                   %Editc(%Dec(
                   chart.low + idx * chart.spacing:10:0):'N')));
                MyChartAxe += PdfStrmRestoreGraphicState();
                MyChartAxe += PdfTextClose();
E02          Endfor;

E01    Endsl;
       MyChartAxe += PdfDrawClosePath( Pdf_stroke);

E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr Y_ticks;
       //?* = -----------------------------------------------------------------
B01    If chart.Aspect = 'PIE';
          Leavesr;
E01    Endif;
       MyChartTick += PdfDrawLineWidth(chart.Yaxe.Style.Linewidth);
       MyChartTick += Pdfstrmstrokingcolorhtml('black' );
       //?Line on y axis
       MyChartTick += PdfDrawGoto(chart.data.Style.x :chart.data.Style.y);
       MyChartTick += PdfDrawAddLine(chart.data.Style.x
          :chart.data.Style.y+chart.data.Style.height);
       MyChartTick += PdfDrawClosePath( Pdf_stroke);
       //?ticks and label on the y axis
B01    If chart.Yaxe.Guide ;
          //?       draw the line of the current element
B02       For idx = 0 To chart.Ticks - 1;
             MyChartGuide += PdfStrmStrokingColorGray(0);   //?black
             MyChartGuide += PdfDrawGoto (
                chart.Yaxe.Style.x
                : chart.Yaxe.Style.y + Tick_height * idx);
             MyChartGuide += PdfDrawAddLine (
                chart.Yaxe.Style.x
                + chart.Yaxe.Style.width+chart.data.Style.width
                : chart.Yaxe.Style.y + Tick_height * idx );
             MyChartGuide += PdfDrawClosePath( Pdf_stroke);
E02       Endfor;
E01    Endif;
       curr_X = chart.data.Style.x ;
B01    For idx = 0 To chart.Ticks - 1 ;
          Curr_Y = chart.data.Style.y + idx * Tick_height;
          MyChartGuide += PdfDrawGoto(curr_X:Curr_Y);
B02       If ( chart.Ticksinside );
             MyChartGuide += PdfDrawAddLine(curr_X+
                +chart.Yaxe.Style.Fontsize/2:Curr_Y);
X02       Else;
             MyChartGuide += PdfDrawAddLine(curr_X
                -chart.Yaxe.Style.Fontsize/2:Curr_Y);
E02       Endif;
          MyChartGuide += PdfDrawClosePath( Pdf_stroke);
B02       If ( chart.Doubleticks And idx < chart.Ticks - 1);
             Curr_Y += Tick_height /2;
             MyChartGuide += PdfDrawGoto(curr_X:Curr_Y);
B03          If ( chart.Ticksinside );
                MyChartGuide += PdfDrawAddLine(curr_X+
                   +chart.Yaxe.Style.Fontsize/2:Curr_Y);
X03          Else;
                MyChartGuide += PdfDrawAddLine(curr_X
                   -chart.Yaxe.Style.Fontsize/2:Curr_Y);
E03          Endif;
             MyChartGuide += PdfDrawClosePath( Pdf_stroke);
E02       Endif;
E01    Endfor;
E00    Endsr;
       //?* = --------------------------------------------------------------------

       //?* = --------------------------------------------------------------------
B00    Begsr Elements1;
       //?* = -----------------------------------------------------------------
       //?Color inside of column
       //? debug draw the area of the current element
       //?For idx = 0 TO chart.Elt_Count - 1;
       //?   mychartelt += PDFSTRMSTROKINGCOLORGRAY(0);//?black
       //?   mychartelt += PDFDRAWADDRECTANGLE(
       //?      chart.xaxe.x+ element_width * idx
       //?      : chart.yaxe.y - chart.xaxe.style.height
       //?      : element_width : element_height + chart.xaxe.style.height);
       //?   mychartelt += PDFDRAWCLOSEPATH( PDF_STROKE);
       //?endfor;


B01    Select;
X01       When chart.Aspect = 'LINE';
             //?style de la premiere serie
             pserie = chart.Pseries;
             MyChartElt += PdfDrawLineWidth( serie.Style.Linewidth);
             MyChartElt += Pdfstrmstrokingcolorhtml( serie.Style.StrokeColor);

B02          For idx = 0 To chart.Serie_count - 1;
                //?for each serie  , draw the line
                pserie = chart.Pseries+(idx)*%size(Pdfchartserie_t);
                //?effet de bord à eclaircir :
                //?si strokecolor + closepath dans le for, alors
                //?pas d'affichage des lignes du graphe ... ni des guidelines !
                //?mychartelt += PDFDRAWLINEWIDTH( Serie.Style.LineWidth);
                //?mychartelt += PDFSTRMSTROKINGCOLORHTML( Serie.Style.StrokeColor);
                //?prendre une copie du premier element
                pElt = Pelts+(serie.Fromelt )*%size(elt);

                welt = elt;
                pElt = %Addr(welt);
                elt.value = serie.Sumpos + serie.Sumneg;
                elt.Style.x = chart.Xaxe.Style.x
                   + serie.Style.width *(idx + 0.5) ;
                elt.Style.height = %Inth(
                   serie.Style.Height*( elt.value )/chart.Range);
                elt.Style.y = chart.data.Yzero + elt.Style.height;
B03             If (idx = 0);
                   MyChartElt += PdfDrawGoto(elt.Style.x: elt.Style.y );
X03             Else;
                   MyChartElt += PdfDrawAddLine(elt.Style.x: elt.Style.y );
E03             Endif;
B03             If serie.Fromelt < serie.Toelt;   //?il y a plusieurs elements
                   elt.Style.height = %Inth(
                      serie.Style.Height*( serie.Sumpos+1 )/chart.Range);
                   elt.Style.y = chart.data.Yzero + elt.Style.height;
                   MyChartElt += PdfDrawAddLine(elt.Style.x: elt.Style.y );
                   elt.Style.height = %Inth(
                      serie.Style.Height*( serie.Sumneg-1 )/chart.Range);
                   elt.Style.y = chart.data.Yzero + elt.Style.height;
                   MyChartElt += PdfDrawAddLine(elt.Style.x: elt.Style.y );
                   elt.Style.height = %Inth(
                      serie.Style.Height*( elt.value )/chart.Range);
                   elt.Style.y = chart.data.Yzero + elt.Style.height;
                   MyChartElt += PdfDrawAddLine(elt.Style.x: elt.Style.y );
E03             Endif;

B03             If ( serie.Style.Visible = '1' );
                   elt.Style.width = 0 ;
                   elt.Style.height = 0 ;
                   Exsr Pdfchartelementtext;

E03             Endif;
                //?mychartelt += PDFDRAWCLOSEPATH( PDF_STROKE);
E02          Endfor;
             MyChartElt += PdfDrawClosePath( Pdf_stroke);

             //?* = --------------------------------------------------------------
X01       When chart.Aspect = 'COLUMN';
B02          For iserie = 0 To chart.Serie_count - 1;
                //?for each serie  , draw the bar
                zeroneg = chart.data.Yzero;
                zeropos = chart.data.Yzero;
                pserie = chart.Pseries+(iserie)*%size(Pdfchartserie_t);
B03             For idx = serie.Fromelt To serie.Toelt;
                   //?for each element, draw the rectangle
                   pElt = Pelts+(idx)*%size(elt);
                   column_width = serie.Style.width * .80 ;
                   spacer_width = serie.Style.width * .20 ;
                   MyChartElt += PdfDrawLineWidth(elt.Style.Linewidth);
                   MyChartElt += Pdfstrmfillingcolorhtml(elt.Style.Backcolor);
                  MyChartElt += Pdfstrmstrokingcolorhtml(elt.Style.StrokeColor);
                   elt.Style.x = chart.Xaxe.Style.x
                      + serie.Style.width * iserie
                      +(spacer_width / 2);
                   elt.Style.height = %Inth(
                      serie.Style.Height*( elt.value )/chart.Range);
B04                If elt.value > 0;
                      elt.Style.y = zeropos;
X04                Else;
                      elt.Style.y = zeroneg;
E04                Endif;
                   MyChartElt += PdfDrawAddRectangle(elt.Style.x:elt.Style.y:
                      column_width:elt.Style.height);
                   MyChartElt += PdfDrawClosePath(Pdf_fill:Pdf_stroke);

B04                If ( elt.Style.Visible = '1' );

                      //?imprimer le texte de la valeur dans le rectangle
                      //?de la valeur.
                      //?rectangle = curr_x ; curr_y ; curr_w ; curr_h
                      //?texte : selon elt
                      //?     column_width ;
                      //?     elt.style.height;
                      Exsr Pdfchartelementtext;
E04                Endif;
B04                If elt.value > 0;
                      zeropos += elt.Style.height;
X04                Else;
                      zeroneg += elt.Style.height;
E04                Endif;

E03             Endfor;
E02          Endfor;
             //?* = --------------------------------------------------------------
X01       When chart.Aspect = 'PIE';
             //?PdfPie prototype :
             //?   Xorigin   X du centre
             //?   Yorigin   Y du centre
             //?   alpha     angle de départ
             //?   beta      largeur (angle)
             //?   length    longueur (rayon)
             //?   Color     couleur
             //?   Emphasis  ecartement (points)
             //?   text      texte associé
             //?   textlen   largeur du texte (points)

             //?w1  =  angle de depart de chaque serie
             //?w2  =  angle d'une serie

             w1 = 0;
B02          For iserie = 0 To chart.Serie_count - 1;
                //?for each serie  , draw the pie
                pserie = chart.Pseries+(iserie)*%size(Pdfchartserie_t);
                w2 = (360 * serie.Range / PieSum);

                PieColor = Pdfsetcolorhtml(
                   serie.Style.StrokeColor
                   : serie.Style.Backcolor);
                PieText = PdfTextOpen();
                PieText += PdfTextFont(
                   serie.Style.font
                   : serie.Style.fontSize);
                PieText += PdfTextRendering(Pdf_fill );
                PieText += Pdfstrmfillingcolorhtml( serie.Style.FillColor);
                PieTextLen = PdfTextStrLen(serie.text );
                PieText += PdfTextAdd(serie.text );
                PieText += PdfTextClose();

                MyChartElt += PdfPie (
                   chart.data.Xzero
                   :chart.data.Yzero
                   :w1
                   :w2
                   :element_height
                   :PieColor
                   : serie.Style.emphasis
                   :PieText
                   :PieTextLen);

                w1 += w2;
                //?  For idx = Serie.FromElt TO Serie.ToElt;
                //?     //?for each element, draw the rectangle
                //?     pelt = Pelts+(idx)*%SIZE(Elt);
                //?     curr_X = chart.Xaxe.X + element_width * iserie
                //?        +(spacer_width / 2);
                //?     column_height = %Inth(
                //?        ELEMENT_HEIGHT*( Elt.Value )/CHART.range);
                //?     If Elt.Value > 0;
                //?        Curr_Y = zeropos;
                //?
                //?     Else;
                //?        Curr_Y = zeroneg;
                //?
                //?     Endif;
B03             If ( elt.Style.Visible = '1' );
E03             Endif;
E02          Endfor;
             w1 = 0;
B02          For iserie = 0 To chart.Serie_count - 1;
                //?for each element of each serie  , draw the pie
                pserie = chart.Pseries+(iserie)*%size(Pdfchartserie_t);
B03             For idx = serie.Fromelt To serie.Toelt;

                   pElt = Pelts+(idx)*%size(elt);
                   //? w2 = %Inth(360 * %Abs(Elt.Value) / PieSum);
                   w2 = %Abs(elt.value) ;

B04                If ( elt.Style.Visible = '1' );
                      PieColor = Pdfsetcolorhtml(
                         elt.Style.StrokeColor
                         : elt.Style.Backcolor);
                      PieText = PdfTextOpen();
                      PieText += PdfTextFont(
                         elt.Style.font
                         : elt.Style.fontSize);
                      PieText += PdfTextRendering(Pdf_fill );
                      PieText += Pdfstrmfillingcolorhtml( elt.Style.FillColor);

                      //?texte à imprimer
                      Pdfelement(elt:chart.Default) ;
                      wtext = %Trim(Pdfedit(elt)) ;
                      PieTextLen = PdfTextStrLen( wtext );
                      PieText += PdfTextAdd( wtext );
                      PieText += PdfTextClose();

                      //?MyChartElt += PDFPIE (
                      w3 = (360 * w1 / PieSum);
                      w4 = (360 * w2 / PieSum);
B05                   If w4 <= 120;
                         MyChartElt += PdfDaisy(
                            chart.data.Xzero
                            :chart.data.Yzero
                            :w3
                            :w4
                            :element_height / 2
                            :PieColor
                            : serie.Style.emphasis +
                            elt.Style.emphasis
                            :PieText
                            :PieTextLen);
X05                   Else;
                         MyChartElt += PdfPie (
                            chart.data.Xzero
                            :chart.data.Yzero
                            :w3
                            :w4
                            :element_height / 2
                            :PieColor
                            : serie.Style.emphasis + elt.Style.emphasis
                            :PieText
                            :PieTextLen);
E05                   Endif;
E04                Endif;

                   w1 += w2;
E03             Endfor;
E02          Endfor;
E01    Endsl;
E00    Endsr;

       //?* = --------------------------------------------------------------------
B00    Begsr Pdfchartelementtext;

       TextIsHorizontal = Not
          (45 <= elt.Style.Rotate_degree
X..    And elt.Style.Rotate_degree <= 135)
X00    Or (225 <= elt.Style.Rotate_degree
X..    And elt.Style.Rotate_degree <= 315);

       MyChartText += PdfTextOpen();
       //?texte à imprimer
       Pdfelement(elt:chart.Default) ;
       wtext = %Trim(Pdfedit(elt)) ;
B01    If chart.Aspect = 'COLUMN' And elt.Style.fontSize = -1;
          //?place disponible
B02       If TextIsHorizontal;
             w2 = %Abs(elt.Style.height);   //?taille de fonte à priori
             w3 = elt.Style.width;   //?place disponible
X02       Else;
             w2 = elt.Style.width;   //?fontsize
             w3 = %Abs(elt.Style.height);   //?available space
E02       Endif;
          //?largeur dans la fonte
          w1 = PdfTextStrLen(wtext
             : w2
             : elt.Style.font.basefont );
          //?réestimation de la fontsize
          w2 = w2 * w3 / w1;
          //?limitation à la hauteur de colonne
B02       If TextIsHorizontal ;
             w2 = Min(w2 * .9 : %Abs(elt.Style.height));
X02       Else;
             w2 = Min(w2 * .9 : %Abs(elt.Style.width));
E02       Endif;

          //?largeur dans la fonte corrigée
          w1 = PdfTextStrLen(wtext
             :w2
             : elt.Style.font.basefont );
X01    Else;
          w2 = elt.Style.fontSize;
E01    Endif;
       MyChartText += PdfTextFont( elt.Style.font :w2);

       MyChartText += Pdfstrmfillingcolorhtml( elt.Style.FillColor);
       MyChartText += Pdfstrmstrokingcolorhtml( elt.Style.StrokeColor);
       //?se translater au centre de l'element
       //?effectuer la rotation,
       //?se deplacer à gauche de 1/2 largeur d'element,
       //?ecrire le texte
       curr_X = elt.Style.x+elt.Style.Width/2;
       //?si le texte est vertical, cadrage à droite
       //?par moveto en X sur -w1 pixels au lieu de translate

       //?le curr_x;curr_y en mode texte donne la ligne de base, pas la ligne du bas
       //?IE la patte du p est sous la ligne de base, au dessus de la ligne du bas
       Curr_Y = elt.Style.y+elt.Style.height;

B01    If TextIsHorizontal;
B02       If elt.Style.height > 0;
             Curr_Y -= W2*.8;
X02       Else;
             Curr_Y += W2*.2;
E02       Endif;
E01    Endif;
       MyChartText += PdfStrmSaveGraphicState();
       MyChartText += PdfStrmTranslate(curr_X:Curr_Y);
       MyChartText += PdfStrmRotate( elt.Style.Rotate_degree);
       //?si la rotation est d'environ 90 degres, cadrage à droite
       //?par moveto en X sur -w1 pixels

B01    If TextIsHorizontal ;
          //?mettre le texte de la valeur dans le rectangle
          MyChartText += PdfTextMoveTo(- elt.Style.width / 2 :0);
X01    Else;
          //?oui mais seulement pour les valeurs positives
          //?les valeurs negatives sont (déjà) cadrées à gauche
B02       If elt.value > 0;
             MyChartText += PdfTextMoveTo(- w1 : -elt.Style.Width/ 4);
X02       Else ;
             MyChartText += PdfTextMoveTo( 0 : -elt.Style.width / 4);
E02       Endif;
E01    Endif;
       MyChartText += PdfTextAdd(wtext);
       MyChartText += PdfStrmRestoreGraphicState();
       MyChartText += PdfTextClose();

       //?* = -----------------------------------------------------------------
E00    Endsr;
      /end-free
EPR  P                 e


BPR ?p PdfElement      b                   export
     d PdfElement      pi
     d  elt                                likeds(PdfChartElement_t)
     d  gal                                likeds(PdfChartElement_t)
      /free
B01    If elt.Editcode = '';
          elt.Editcode = gal.Editcode;
E01    Endif;
B01    If elt.Editword = '';
          elt.Editword = gal.Editword;
E01    Endif;
B01    If elt.Precision = 0 ;
          elt.Precision = gal.Precision;
E01    Endif;
B01    If elt.Decimal = 0 ;
          elt.Decimal = gal.Decimal ;
E01    Endif;
       Return ;
      /end-free
EPR  P                 e


BPR ?p PdfEdit         b                   export
     d PdfEdit         pi            50    varying
     d  elt                                likeds(PdfChartElement_t)

     d mask            s            256
     d masklen         s             10i 0
     d str             s             50
     d strlen          s             10i 0
     d zero_balance    s              1

     d sourcex         s             60
     d source          ds            60
      /if defined(*V6R1M0)
     d source00                1     60s00
     d source01                1     60s01
     d source02                1     60s02
     d source03                1     60s03
     d source04                1     60s04
     d source05                1     60s05
     d source06                1     60s06
     d source07                1     60s07
     d source08                1     60s08
     d source09                1     60s09
     d source10                1     60s10
     d source11                1     60s11
     d source12                1     60s12
     d source13                1     60s13
     d source14                1     60s14
     d source15                1     60s15
     d source16                1     60s16
     d source17                1     60s17
     d source18                1     60s18
     d source19                1     60s19
     d source20                1     60s20
     d source21                1     60s21
     d source22                1     60s22
     d source23                1     60s23
     d source24                1     60s24
     d source25                1     60s25
     d source26                1     60s26
     d source27                1     60s27
     d source28                1     60s28
     d source29                1     60s29
     d source30                1     60s30
      /else
     d source00               31     60s00
     d source01               31     60s01
     d source02               31     60s02
     d source03               31     60s03
     d source04               31     60s04
     d source05               31     60s05
     d source06               31     60s06
     d source07               31     60s07
     d source08               31     60s08
     d source09               31     60s09
     d source10               31     60s10
     d source11               31     60s11
     d source12               31     60s12
     d source13               31     60s13
     d source14               31     60s14
     d source15               31     60s15
     d source16               31     60s16
     d source17               31     60s17
     d source18               31     60s18
     d source19               31     60s19
     d source20               31     60s20
     d source21               31     60s21
     d source22               31     60s22
     d source23               31     60s23
     d source24               31     60s24
     d source25               31     60s25
     d source26               31     60s26
     d source27               31     60s27
     d source28               31     60s28
     d source29               31     60s29
     d source30               31     60s30
      /endif
      /free

B01    If elt.Editcode = '' And elt.Editword = '';
          Return %Char ( elt.value) ;
E01    Endif;

       //?make an edit mask
       Clear Ech;

B01    Select;
X01       When elt.Decimal = 00;
             source00 = elt.value;
X01       When elt.Decimal = 01;
             source01 = elt.value;
X01       When elt.Decimal = 02;
             source02 = elt.value;
X01       When elt.Decimal = 03;
             source03 = elt.value;
X01       When elt.Decimal = 04;
             source04 = elt.value;
X01       When elt.Decimal = 05;
             source05 = elt.value;
X01       When elt.Decimal = 06;
             source06 = elt.value;
X01       When elt.Decimal = 07;
             source07 = elt.value;
X01       When elt.Decimal = 08;
             source08 = elt.value;
X01       When elt.Decimal = 09;
             source09 = elt.value;
X01       When elt.Decimal = 10;
             source10 = elt.value;
X01       When elt.Decimal = 11;
             source11 = elt.value;
X01       When elt.Decimal = 12;
             source12 = elt.value;
X01       When elt.Decimal = 13;
             source13 = elt.value;
X01       When elt.Decimal = 14;
             source14 = elt.value;
X01       When elt.Decimal = 15;
             source15 = elt.value;
X01       When elt.Decimal = 16;
             source16 = elt.value;
X01       When elt.Decimal = 17;
             source17 = elt.value;
X01       When elt.Decimal = 18;
             source18 = elt.value;
X01       When elt.Decimal = 19;
             source19 = elt.value;
X01       When elt.Decimal = 20;
             source20 = elt.value;
X01       When elt.Decimal = 21;
             source21 = elt.value;
X01       When elt.Decimal = 22;
             source22 = elt.value;
X01       When elt.Decimal = 23;
             source23 = elt.value;
X01       When elt.Decimal = 24;
             source24 = elt.value;
X01       When elt.Decimal = 25;
             source25 = elt.value;
X01       When elt.Decimal = 26;
             source26 = elt.value;
X01       When elt.Decimal = 27;
             source27 = elt.value;
X01       When elt.Decimal = 28;
             source28 = elt.value;
X01       When elt.Decimal = 29;
             source29 = elt.value;
X01       When elt.Decimal = 30;
             source30 = elt.value;
E01    Endsl;
B01    If elt.Editcode <> '';
          //?return %trim(%editc(sourcev:elt.editcode));
          //?RNF0355 20 The second parameter of %EDITC is not a character consta
          Qeccvtec(mask:masklen:strLen:zero_balance:
             elt.Editcode:' ':elt.Precision:elt.Decimal:Ech);
X01    Else;
          zero_balance = x'00';
          Qeccvtew(mask:masklen:strLen:
             elt.Editword:%Len(elt.Editword):Ech );
E01    Endif;
B01    If Ech.Available > 0;

          Message(Ech.Msgid:Ech.Msgdta);
          Return Ech.Msgid;
E01    Endif;
       sourcex = %Subst(source:60 - elt.Precision + 1 : elt.Precision);

       Qecedt(Str:strLen:sourcex:'*ZONED':
          elt.Precision:mask:masklen: zero_balance:Ech);
B01    If Ech.Available > 0;

          Message(Ech.Msgid:Ech.Msgdta);
          Return Ech.Msgid;
E01    Endif;
       Return %Subst(Str:1:strLen);
B00    Begsr *pssr;
       Dump;
E00    Endsr;

      /end-free


EPR  p PdfEdit         e

    ? * = ------------------------------------------------------------------------

BPR ?p PdfStyle        b                   export
     d PdfStyle        pi                  likeds(PdfChartStyle_t)
     d  elt                                likeds(PdfChartStyle_t)
     d  gal                                likeds(PdfChartStyle_t)
     d  rtn            ds                  likeds(PdfChartStyle_t)
      /free
       rtn = elt;
B01    If rtn.StrokeColor = '';
          rtn.StrokeColor = gal.StrokeColor ;
E01    Endif;
B01    If %Subst(rtn.StrokeColor:1:1) = '*';
          rtn.StrokeColor = Pdfrandomcolorhtml(rtn.StrokeColor);
E01    Endif;
B01    If rtn.FillColor = '';
          rtn.FillColor = gal.FillColor ;
E01    Endif;
B01    If %Subst(rtn.FillColor:1:1) = '*';
          rtn.FillColor = Pdfrandomcolorhtml(rtn.FillColor);
E01    Endif;
B01    If rtn.Backcolor = '';
          rtn.Backcolor = gal.Backcolor ;
E01    Endif;
B01    If %Subst(rtn.Backcolor:1:1) = '*';
          rtn.Backcolor = Pdfrandomcolorhtml(rtn.Backcolor);
E01    Endif;
B01    If rtn.font.Obj = 0;
          rtn.font = gal.font ;
E01    Endif;
B01    If rtn.Alignment = '';
          rtn.Alignment = gal.Alignment ;
E01    Endif;
B01    If rtn.fontSize = 0 ;
          rtn.fontSize = gal.fontSize ;
E01    Endif;



B01    If rtn.Linewidth = -1;
          rtn.Linewidth = gal.Linewidth ;
E01    Endif;



B01    If rtn.Rotate_degree = -2 ;
          rtn.Rotate_degree = gal.Rotate_degree ;
E01    Endif;
       //? If rtn.skew_alpha <0 ;
       //?    rtn.skew_alpha = gal.skew_alpha ;
       //? Endif;
       //? If rtn.skew_beta <0 ;
       //?    rtn.skew_beta = gal.skew_beta ;
       //? Endif;
B01    If rtn.Visible = '' ;
          rtn.Visible = gal.Visible ;
E01    Endif;
B01    If rtn.Background = '' ;
          rtn.Background = gal.Background ;
E01    Endif;

       Return rtn;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p PdfStyle        e

    ? * = ------------------------------------------------------------------------

BPR ?p PdfChartInit    b                   export
     d PdfChartInit    pi                  likeds(PdfChart_t)
     d chart           ds                  likeds(PdfChart_t)
      /free
       Clear chart;
       Pdfseriesinit(chart);
       Return chart;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
BPR ?p PdfSeriesInit   b                   export
     d PdfSeriesInit   pi
     d   chart                             likeds(PdfChart_t)
      /free
       chart.Elt_len = 4096 ;
       chart.Elt_pos = 0;
       chart.Pelements = %Alloc( chart.Elt_len);
       chart.Serie_len = 1024 ;
       chart.Serie_pos = 0;
       chart.Pseries = %Alloc( chart.Serie_len);
       Return ;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
BPR ?p PdfSerieOpen    b                   export
     d PdfSerieOpen    pi
     d   chart                             likeds(PdfChart_t)
     d   newserie                          likeds(PdfChartserie_t)
    ? * = -----------------------------------
     d serie           ds                  likeds(PdfChartserie_t)
     d                                     based(pserie      )
      /free
       //?auto expend list of Elements
B01    If chart.Serie_pos + %Size(Pdfchartserie_t
             ) > chart.Serie_len;
          chart.Serie_len += 1024 ;
          chart.Pseries = %Realloc( chart.Pseries : chart.Serie_len);
E01    Endif;
       chart.pserie = chart.Pseries + chart.Serie_pos;
       pserie = chart.pserie;
       serie = newserie;
       serie.Fromelt = -1 ;
       serie.Toelt = 0 ;
       serie.Range = 0 ;
       serie.Sumneg = 0 ;
       serie.Sumpos = 0 ;
       serie.Mini = *hival;
       serie.Maxi = *loval;
       //?set next position to next elementy, if any
       chart.Serie_pos += %Size(Pdfchartserie_t);
       chart.Serie_count += 1;
       Return ;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
BPR ?p PdfElementAdd   b                   export
     d PdfElementAdd   pi
     d   chart                             likeds(PdfChart_t)
     d elt                                 likeds(PdfChartelement_t)
    ?d* = -----------------------------------
     d serie           ds                  likeds(PdfChartserie_t)
     d                                     based(pserie      )
     d element         ds                  likeds(PdfChartelement_t)
     d                                     based(      pelement)
      /free
       //?auto expend list of Elements
B01    If chart.Elt_pos + %Size(Pdfchartelement_t
             ) > chart.Elt_len;
          chart.Elt_len += 4096;
          chart.Pelements = %Realloc( chart.Pelements: chart.Elt_len);
E01    Endif;
       chart.pelement = chart.Pelements + chart.Elt_pos;
       pelement = chart.pelement;
       pserie = chart.pserie;
       element = elt;
       element.Number = chart.Elt_count;
B01    If serie.Fromelt = -1;
          serie.Fromelt = chart.Elt_count;
E01    Endif;
       serie.Toelt = chart.Elt_count;
B01    If element.value > 0;
          serie.Sumpos += element.value;
X01    Else ;
          serie.Sumneg += element.value;
E01    Endif;
B01    If element.value > serie.Mini;
          serie.Mini = element.value;
E01    Endif;
B01    If serie.Maxi < element.value;
          serie.Maxi = element.value;
E01    Endif;
       serie.Range = serie.Sumpos - serie.Sumneg;
       //?set next position to next element , if any
       chart.Elt_pos += %Size(Pdfchartelement_t);
       chart.Elt_count += 1;

       Return ;

B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
BPR ?p PdfSerieClose   b                   export
     d PdfSerieClose   pi
     d   chart                             likeds(PdfChart_t)


      /free
       Return ;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
BPR ?p PdfChartFree    b                   export
     d PdfChartFree    pi
     d   chart                             likeds(PdfChart_t)
      /free
       Dealloc chart.Pelements ;
       Dealloc chart.Pseries ;
       Return ;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
BPR ?p Latin1          b                   export
     d Latin1          pi                  like(PdfS3)
     d thestream                           like(pdfS3) const
    ? * = ---------------------------------
     d AsciiStream     s          64000          static
     d inputStream     s                   like(pdfS3) static
     d inputLen        s             10i 0       static
     d AsciiLen        s             10i 0       static
     d Len             s             10i 0       static
    ? * = ---------------------------------
      /free
       inputLen = %Len(thestream) ;
       inputStream = thestream ;
       AsciiLen = %Size(AsciiStream) ;
       len = AsciiLen ;
       rc = Iconv(Pdfhiconvlatin1 :
          %Addr(inputStream)+2 : inputLen :
          %Addr(AsciiStream) : AsciiLen );
B01    If rc< 0;
B02       If C_errno <> 0;
             Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
             len = 0;
E02       Endif;
E01    Endif;
       Return %Subst(AsciiStream:1:len-AsciiLen );
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
BPR ?p U16a            b
     d U16a            pi                  like(PdfS2)
     d thestream                           like(pdfS2) const
    ? * = ---------------------------------
     d AsciiStream     s          64000          static
     d inputStream     s                   like(pdfS3) static
     d inputLen        s             10i 0       static
     d AsciiLen        s             10i 0       static
     d Len             s             10i 0       static
    ? * = ---------------------------------
      /free
       inputLen = %Len(thestream) ;
       inputStream = thestream ;
       AsciiLen = %Size(AsciiStream) ;
       len = AsciiLen ;
       rc = Iconv(Pdfhiconvu16:
          %Addr(inputStream)+2 : inputLen :
          %Addr(AsciiStream) : AsciiLen );
B01    If rc< 0;
B02       If C_errno <> 0;
             Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
             len = 0;
E02       Endif;
E01    Endif;
       Return %Subst(AsciiStream:1:len-AsciiLen );
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
BPR ?p U16             b                   export
     d U16             pi                  like(Pdfu2)
     d thestream                           like(pdfS2) const
    ? * = ---------------------------------
     d rtn             ds                  qualified static
     d   c1k                       1000c   varying ccsid(1200)
     d   a2k                       2000a   varying overlay(rtn)
     d   len                          5u 0 overlay(rtn)

    ? * = ---------------------------------
      /free
       rtn.a2k = U16a( thestream) ;
       rtn.len /=2;
       Return rtn.c1k;












B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
BPR ?p U16Latin1       b                   export
     d U16Latin1       pi                  like(PdfS3)
     d thestream                           like(pdfu2) const
    ? * = ---------------------------------
     d AsciiStream     s          64000          static
     d inputStream     s                   like(pdfu2) static
     d inputLen        s             10i 0       static
     d AsciiLen        s             10i 0       static
     d Len             s             10i 0       static
    ? * = ---------------------------------
      /free
       inputLen = %Len(thestream) * 2 ;
       inputStream = thestream ;
       AsciiLen = %Size(AsciiStream) ;
       len = AsciiLen ;
       rc = Iconv(Pdfhiconvu16latin1:
          %Addr(inputStream)+2 : inputLen :
          %Addr(AsciiStream) : AsciiLen );
B01    If rc< 0;
B02       If C_errno <> 0;
             Message(Errnomsg(C_errno):'':'*LIBL':'QCPFMSG') ;
             Pdffile.Withdiag=True;
             len = 0;
E02       Endif;
E01    Endif;
       Return %Subst(AsciiStream:1:len-AsciiLen );
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
    ? * see http://en.wikipedia.org/wiki/Code_128
BPR ?p PdfDrawBC128    b                   export
     d PdfDrawBC128    pi                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)               Height of the bar co
     d zoom                           5p 2 value options(*nopass)               Widthness zoom
    ? * = ---------------------------------
     d h               s              5p 1                                      Height
     d z               s              5p 2                                      Zoom
     d i               s              5p 0                                      Counter
     d j               s              5p 0                                      Counter
     d k               s              3p 0                                      Counter
     d draw            s                   like(PdfStream)
     d bc              s            600    varying                              Encoded bar code
     d bw              s              1p 0                                      Bar width
     d bwc             s              6p 0                                      Bar width count
     d nfd             s              3p 0                                      Number of Following
     d checksum        s              7p 0                                      Checksum calculation
     d ch              s              3p 0                                      Encoded char
     d pInz            s               *   Inz(%Addr(ArrayInz))
     d ArrayInz        s            642    Inz('212222222122222221121223121322-   0
     d                                     131222122213122312132212221213-        5
     d                                     221312231212112232122132122231-       10
     d                                     113222123122123221223211221132-       15
     d                                     221231213212223112312131311222-       20
     d                                     321122321221312212322112322211-       25
     d                                     212123212321232121111323131123-       30
     d                                     131321112313132113132311211313-       35
     d                                     231113231311112133112331132131-       40
     d                                     113123113321133121313121211331-       45
     d                                     231131213113213311213131311123-       50
     d                                     311321331121312113312311332111-       55
     d                                     314111221411431111111224111422-       60
     d                                     121124121421141122141221112214-       65
     d                                     112412122114122411142112142211-       70
     d                                     241211221114413111241112134111-       75
     d                                     111242121142121241114212124112-       80
     d                                     124211411212421112421211212141-       85
     d                                     214121412121111143111341131141-       90
     d                                     114113114311411113411311113141-       95
     d                                     114131311141411131211412211214-      100
     d                                     211232233111')                       105
     d code128         s              6    Dim(107) Based(pInz)
     d legalchars      s             95    Inz(' !"#$%&''()*+,-./0123456789:;-  from  1 to 28   atte
     d                                     <=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ-     from 29 to 59
     d                                     [\]^_`abcdefghijklmnopqrstuvwxyz-    from 60 to 91
     d                                     {|}~')                               from 92 to 95
     dMessageDS        ds                  static
     d m1                           512                                         The illegal char
    ? * = ---------------------------------
      /free
       %Subst(legalchars: 2:1) = Portablechar.Exclamationpoint;
       %Subst(legalchars: 4:1) = Portablechar.Numbersign;
       %Subst(legalchars: 5:1) = Portablechar.Dollar;
       %Subst(legalchars:33:1) = Portablechar.Atsign;
       %Subst(legalchars:60:1) = Portablechar.Leftbracket;
       %Subst(legalchars:61:1) = Portablechar.Backslash;
       %Subst(legalchars:62:1) = Portablechar.Rightbracket;
       %Subst(legalchars:63:1) = Portablechar.Caret;
       %Subst(legalchars:92:1) = Portablechar.Leftbrace;
       %Subst(legalchars:93:1) = Portablechar.Logicalor;
       %Subst(legalchars:94:1) = Portablechar.Rightbrace;
       %Subst(legalchars:95:1) = Portablechar.Tilde;

       //?Check for illegal chars
B01    For i=1 To %Len(thebarcode);
B02       If %Scan(%Subst(thebarcode:i:1):legalchars) = 0;
             m1 = %Subst(thebarcode:i:1);
             Message('PDF0018':MessageDS:'*LIBL':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endfor;

       //?Optional parameters
B01    If %Parms >=4;
          h=height;
X01    Else ;
          h=56.69;   //?20mm at 72 dpi (20 = 56.69 / 72 * 25.4)
E01    Endif;
B01    If %Parms >=5;
          z=zoom;
X01    Else ;
          z=14.17;   //?So a thin bar is 0.5mm wide at 72 dpi (0.5 = 14.17 * 0.1 / 72 * 25.4)
E01    Endif;

       i=1;
       bc='';
       checksum=0;
       k=1;
B01    Dow i<=%Len(thebarcode);
          Exsr Nbrfollowingdigits;
B02       If nfd>=4;
             Exsr Encodetablec;
X02       Else;
             Exsr Encodetableb;
E02       Endif;
E01    Enddo;
       ch = %Rem(checksum:103);
       bc += code128(ch+1);
       bc += code128(106+1) +'2';   //?Endcode + endbar

       bwc = 0;
       Draw = PdfStrmSaveGraphicState();
       Draw += PdfDrawGoto(x : y);
       Draw += PdfDrawLineWidth(0);
       Draw += PdfStrmFillingColorGray(0);   //?black

B01    For i=1 To %Len(bc);
          bw = %Dec(%Subst(bc:i:1):1:0);
B02       If %Rem(i:2)=1;
             Draw += PdfDrawAddRectangle(x + Bwc*0.1*z : y : Bw*0.1*z : h);
E02       Endif;
          bwc += bw;
E01    Endfor;

       Draw += PdfDrawClosePath(Pdf_fill);
       Draw += PdfStrmRestoreGraphicState();

       Return Draw;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;

       //?How many digits from the current position onwards
B00    Begsr Nbrfollowingdigits;
       nfd = 0;
       j = i;
B01    Dow j<=%Len(thebarcode);
B02       If %Subst(thebarcode:j:1)>='0' And %Subst(thebarcode:j:1)<='9';
             nfd += 1;
X02       Else;
             Leave;
E02       Endif;
          j += 1;
E01    Enddo;
E00    Endsr;

       //?Encoding with the codeB table: 3 bars = 1 char
       //?We are in codeB mode when we reach this code except if it's the 1st char
B00    Begsr Encodetableb;
B01    If i=1;
          bc += code128(104+1);   //?Starting codeB : numerics
          checksum += 104*k;
E01    Endif;

       ch = %Scan(%Subst(thebarcode:i:1):legalchars);
       bc += code128(ch);
       checksum += (ch-1)*k;
       k += 1;
       i += 1;
E00    Endsr;

       //?Encoding with the codeC table: 3 bars = 2 digits
B00    Begsr Encodetablec;
B01    If i=1;
          bc += code128(105+1);   //?Starting codeC : numerics
          checksum += 105*k;
X01    Else;
          bc += code128( 99+1);   //?Switching from codeB to codeC
          checksum += 99*k;
          k += 1;
E01    Endif;

B01    Dow nfd>=2;
          ch = %Dec(%Subst(thebarcode:i :1):1:0)*10
             + %Dec(%Subst(thebarcode:i+1:1):1:0) ;
          bc += code128(ch+1);
          checksum += Ch*k;
          k += 1;
          i += 2;
          nfd -= 2;
E01    Enddo;

B01    If i<=%Len(thebarcode);   //?at least 1 char remaining
          bc += code128(100+1);   //?Switching from codeC to codeB
          checksum += 100*k;
          k += 1;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
    ? * see http://en.wikipedia.org/wiki/Interleaved_2_of_5
    ? * or better explained http://www.barcodeisland.com/int2of5.phtml
BPR ?p PdfDrawBC2o5i   b                   export
     d PdfDrawBC2o5i   pi                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)               Height of the bar co
     d nwfact                         5p 1 value options(*nopass)               Narrow to wide facto
     d zoom                           5p 2 value options(*nopass)               Widthness zoom
    ? * = ---------------------------------
     d h               s              5p 1                                      Height
     d z               s              5p 1                                      Zoom
     d f               s              5p 2                                      Narrow to wide facto
     d i               s              5p 0                                      Counter
     d j               s              5p 0                                      Counter
     d d1              s              3p 0                                      1st digit of pair
     d d2              s              3p 0                                      2nd digit of pair
     d draw            s                   like(PdfStream)
     d bc              s            600    varying                              Encoded bar code
     d bw              s              9p 2                                      Bar width
     d bwc             s              7p 3                                      Bar width count
     d pInz            s               *   Inz(%Addr(ArrayInz))
     d ArrayInz        s             50    Inz('nnwwn-                           0   n is for narrow
     d                                     wnnnw-                                1   w is for wide
     d                                     nwnnw-                                2
     d                                     wwnnn-                                3
     d                                     nnwnw-                                4
     d                                     wnwnn-                                5
     d                                     nwwnn-                                6
     d                                     nnnww-                                7
     d                                     wnnwn-                                8
     d                                     nwnwn')                               9
     d code2o5i        s              5    Dim(10) Based(pInz)
     dMessageDS        ds                  static
     d m1                           512                                         The illegal char
    ? *
    ? * = ---------------------------------
      /free
       //?Check for illegal chars: only digits
B01    For i=1 To %Len(thebarcode);
B02       If %Scan(%Subst(thebarcode:i:1):'0123456789') = 0;
             Message('PDF0019':'':'*LIBL':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endfor;

       //?The length of the bar code must be even
B01    If %Rem(%Len(thebarcode):2) = 1;
          Message('PDF0020':'':'*LIBL':'JPLTOOLS');
          Pdffile.Withdiag=True;
E01    Endif;

       //?Optional parameters
B01    If %Parms >=4;
          h=height;
X01    Else ;
          h=56.69;   //?20mm at 72 dpi (20 = 56.69 / 72 * 25.4)
E01    Endif;
B01    If %Parms >=5;
B02       If nwfact<2 Or nwfact>3;
             Message('PDF0021':'':'*LIBL':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
          f=nwfact;
X01    Else ;
          f=2.2;
E01    Endif;
B01    If %Parms >=6;
          z=zoom;
X01    Else ;
          z=14.17;   //?So a thin bar is 0.5mm wide at 72 dpi (0.5 = 14.17 * 0.1 / 72 * 25.4)
E01    Endif;

       bc='nnnn';   //?Start code
B01    For i=1 To %Len(thebarcode) By 2;
          d1 = %Dec(%Subst(thebarcode:i :1):1:0) + 1;
          d2 = %Dec(%Subst(thebarcode:i+1:1):1:0) + 1;
B02       For j=1 To 5;
             bc += %Subst(code2o5i(d1):j:1);
             bc += %Subst(code2o5i(d2):j:1);
E02       Endfor;
E01    Endfor;
       bc += 'wnn';   //?End code

       Draw = PdfStrmSaveGraphicState();
       Draw += PdfDrawGoto(x : y);
       Draw += PdfDrawLineWidth(0);
       Draw += PdfStrmFillingColorGray(0);   //?black

       bwc = 0;
B01    For i=1 To %Len(bc);
B02       If %Subst(bc:i:1) = 'w';
             bw = 0.1*z*f;
X02       Else;
             bw = 0.1*z;
E02       Endif;
B02       If %Rem(i:2)=1;
             Draw += PdfDrawAddRectangle(x + bwc : y : bw : h);
E02       Endif;
          bwc += bw;
E01    Endfor;

       Draw += PdfDrawClosePath(Pdf_fill);
       Draw += PdfStrmRestoreGraphicState();

       Return Draw;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
    ? * = ------------------------------------------------------------------------
    ? * see http://en.wikipedia.org/wiki/Code_39
BPR ?p PdfDrawBC39     b                   export
     d PdfDrawBC39     pi                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)               Height of the bar co
     d nwfact                         5p 1 value options(*nopass)               Narrow to wide facto
     d zoom                           5p 2 value options(*nopass)               Widthness zoom
    ? * = ---------------------------------
     d h               s              5p 1                                      Height
     d z               s              5p 1                                      Zoom
     d f               s              5p 2                                      Narrow to wide facto
     d i               s              5p 0                                      Counter
     d ch              s              3p 0                                      Encoded char
     d draw            s                   like(PdfStream)
     d bc              s            600    varying                              Encoded bar code
     d bw              s              9p 2                                      Bar width
     d bwc             s              7p 3                                      Bar width count
     d pInz            s               *   Inz(%Addr(ArrayInz))
     d ArrayInz        s            396    Inz('bwbWBwBwbBwbWbwbwB-              0  1   b is for nar
     d                                     bwBWbwbwBBwBWbwbwb-                   2  3   B is for wid
     d                                     bwbWBwbwBBwbWBwbwb-                   4  5   w is for nar
     d                                     bwBWBwbwbbwbWbwBwB-                   6  7   W is for wid
     d                                     BwbWbwBwbbwBWbwBwb-                   8  9
     d                                     BwbwbWbwBbwBwbWbwB-                  10 11
     d                                     BwBwbWbwbbwbwBWbwB-                  12 13
     d                                     BwbwBWbwbbwBwBWbwb-                  14 15
     d                                     bwbwbWBwBBwbwbWBwb-                  16 17
     d                                     bwBwbWBwbbwbwBWBwb-                  18 19
     d                                     BwbwbwbWBbwBwbwbWB-                  20 21
     d                                     BwBwbwbWbbwbwBwbWB-                  22 23
     d                                     BwbwBwbWbbwBwBwbWb-                  24 25
     d                                     bwbwbwBWBBwbwbwBWb-                  26 27
     d                                     bwBwbwBWbbwbwBwBWb-                  28 29
     d                                     BWbwbwbwBbWBwbwbwB-                  30 31
     d                                     BWBwbwbwbbWbwBwbwB-                  32 33
     d                                     BWbwBwbwbbWBwBwbwb-                  34 35
     d                                     bWbwbwBwBBWbwbwBwb-                  36 37
     d                                     bWBwbwBwbbWbWbWbwb-                  38 39
     d                                     bWbWbwbWbbWbwbWbWb-                  40 41
     d                                     bwbWbWbWbbWbwBwBwb')                 42 43   43 is start
     d code39          s              9    Dim(44) Based(pInz)
     d legalchars      s             43    Inz('0123456789-                     from  1 to 10
     d                                     ABCDEFGHIJKLMNOPQRSTUVWXYZ-          from 11 to 36
     d                                     -. $/+%')                            from 37 to 43
     dMessageDS        ds                  static
     d m1                           512                                         The illegal char
    ? *
    ? * = ---------------------------------
      /free
       %Subst(legalchars:40:1) = Portablechar.Dollar;

       //?Check for illegal chars
B01    For i=1 To %Len(thebarcode);
B02       If %Scan(%Subst(thebarcode:i:1):legalchars) = 0;
             m1 = %Subst(thebarcode:i:1);
             Message('PDF0022':'':'*LIBL':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
E01    Endfor;

       //?Optional parameters
B01    If %Parms >=4;
          h=height;
X01    Else ;
          h=56.69;   //?20mm at 72 dpi (20 = 56.69 / 72 * 25.4)
E01    Endif;
B01    If %Parms >=5;
B02       If nwfact<2 Or nwfact>3;
             Message('PDF0021':'':'*LIBL':'JPLTOOLS');
             Pdffile.Withdiag=True;
E02       Endif;
          f=nwfact;
X01    Else ;
          f=2.2;
E01    Endif;
B01    If %Parms >=6;
          z=zoom;
X01    Else ;
          z=14.17;   //?So a thin bar is 0.5mm wide at 72 dpi (0.5 = 14.17 * 0.1 / 72 * 25.4)
E01    Endif;

       bc = code39(43+1)+'w';   //?Start code
B01    For i=1 To %Len(thebarcode);
          ch = %Scan(%Subst(thebarcode:i:1):legalchars);
          bc += code39(ch)+'w';
E01    Endfor;
       bc += code39(43+1);   //?End code

       Draw = PdfStrmSaveGraphicState();
       Draw += PdfDrawGoto(x : y);
       Draw += PdfDrawLineWidth(0);
       Draw += PdfStrmFillingColorGray(0);   //?black

       bwc = 0;
B01    For i=1 To %Len(bc);
B02       If %Subst(bc:i:1) = 'W' Or %Subst(bc:i:1) = 'B';   //?Wide bar or space
             bw = 0.1*z*f;
X02       Else;   //?Narrow bar or space
             bw = 0.1*z;
E02       Endif;
B02       If %Rem(i:2)=1;
             Draw += PdfDrawAddRectangle(x + bwc : y : bw : h);
E02       Endif;
          bwc += bw;
E01    Endfor;

       Draw += PdfDrawClosePath(Pdf_fill);
       Draw += PdfStrmRestoreGraphicState();

       Return Draw;

B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          //?dump ;
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------

      /IF DEFINED(*V6R1M0)
    ? * = ------------------------------------------------------------------------
BPR ?p GSUB            b
     d GSUB            pi
     d   p_font                            likeds(pdffont)
     d  thestring                          like(pdfu2)
     d ifs             ds                  likeds(ifs_t)
     d Pos             S             10i 0 inz(0)
     d AsciiFrom       S             10i 0 inz(0)
     d OffBits         s             10i 0
     d rc              s             10i 0
     d GsubDebug       s               n   inz(*off)
     d GsubMsg         s           6000    varying

    ? *                GSUB Header
     d gsub_h          ds                  qualified based(pgsub_h)
    ?d*                Fixed Version Version of the GSUB table-initially set to 0x00010000
     d   version                           likeds(fixed)
    ?d*                Offset ScriptList Offset to ScriptList table-from beginning of GSUB table
     d   ScriptList                        like(offset)
    ?d*                Offset FeatureList Offset to FeatureList table-from beginning of GSUB table
     d   FeatureList                       like(offset)
    ?d*                Offset LookupList Offset to LookupList table-from beginning of GSUB table
     d   LookupList                        like(offset)

    ?d* types utilisés dans The OpenType Font File specs
    ? *                BYTE 8-bit unsigned integer.
    ?d* byte           s              3u 0
    ? *                CHAR 8-bit signed integer.
     d  char           s              3i 0
    ? *                USHORT 16-bit unsigned integer.
     d  ushort         s              5u 0
    ? *                SHORT 16-bit signed integer.
     d  short          s              5i 0
     d  uint16         s              5u 0
     d   int16         s              5i 0
    ? *                UINT24 24-bit unsigned integer.
     d  uint24         s              3
    ? *                ULONG 32-bit unsigned integer.
     d  ulong          s             10u 0
    ? *                LONG 32-bit signed integer.
     d  long           s             10i 0
    ? *                Fixed 32-bit signed fixed-point number (16.16)
     d  Fixed          ds                  qualified
     d    Left                        5i 0
     d    Right                       5i 0
    ? *                FUNIT Smallest measurable distance in the em space.
    ? *                FWORD 16-bit signed integer (SHORT) that describes a quantity in FUnits.
     d  fword          s                   like(short)
    ? *                UFWORD 16-bit unsigned integer (USHORT) that describes a quantity in FUnits.
     d  ufword         s                   like(ushort)
    ? *                F2DOT14 16-bit signed fixed number with the low 14 bits of fraction (2.14).
     d  F2dot14        s              2
    ? * x'7fff' = b'0111 1111 1111 1111'
    ? *  mantisse=  --                  = x'01' = 1
    ? *  fraction=    ----------------- = x'3fff' = 16383
    ? *  valeur = 1 + 16383/16384
    ? *  pas clair pour la mantisse x'11' = -1, x'10' = -2, x'00' = 0, complement à 2
    ? *                LONGDATETIME Date represented in number of seconds since 12:00 midnight, Janu
    ? *                The value is represented as a signed 64-bit integer.
     d  longdatetime   s             20i 0
    ? *                Tag Array of four uint8s (length = 32 bits)
    ? *                used to identify a script, language system, feature, or baseline
     d  tag            s              4
    ? *                GlyphID Glyph index number, same as uint16(length = 16 bits)
     d  GlyphID        s                   like(ushort)
    ? *                Offset Offset to a table, same as uint16 (length = 16 bits), NULL offset = 0x
     d  offset         s                   like(ushort)

     d  tablerec       ds                  qualified
    ? *                ULONG tag 4 -byte identifier.
     d    name                             like(tag)
    ? *                ULONG checkSum CheckSum for this table.
     d    checksum                         like(ulong)
    ? *                ULONG offset Offset from beginning of TrueType font file.
     d    offset                           like(ulong)
    ? *                ULONG length Length of this table.
     d    length                           like(ulong)

     d sfnt            ds                  qualified
    ? *                Fixed sfnt version 0x00010000 for version 1.0.
     d   version                           likeds(fixed)
    ? *                USHORT numTables Number of tables.
     d   numTables                         like(ushort)
    ? *                USHORT searchRange (Maximum power of 2 <= numTables) x 16.
     d   searchRange                       like(ushort)
    ? *                USHORT entrySelector Log2(maximum power of 2 <= numTables).
     d  entrySelector                      like(ushort)
    ? *                USHORT rangeShift NumTables x 16-searchRange.
     d   rangeShift                        like(ushort)

     d myStat          ds                  likeds(statds)
     d i               s             10u 0
     d AtOff           s             10i 0

     D IfsName         s            512a   varying
     d XmlHandle       s             10i 0
     d ttfHandle       s             10i 0
     d txtHandle       s             10i 0
     D WriteLen        s             10i 0

     D WriteData       s          65535    varying

     d iChar           s              5u00
     d iGlyf           s              5u00
     d iTable          s              5u00
     d WidthCurMode    s              5i00
     d WidthNxtMode    s              5i00
     d wcond           ds                  qualified
     d   last                         5u00
     d   width                        5u00

     d x4              s              4
     d i5              s              5i00
     d u5              s              5u00

     d wk              ds                  qualified
     d   Len                          5u00
     d   Uni                          5u00 dim(1000)
     d   String                    1000c   varying ccsid(1200) overlay(wk)
     d   BC                           5u00 dim(1000)
     d   Glyf                         5u00 dim(1000)
     d wuni            s              5u00 dim(1000)
     d iWUni           s              5i00
     d MaxWUni         s              5i00

     d Uspace          s              1c   ccsid(1200) inz('')
     d iUni            s              5i00
     d iBMG            s              5i00
     d useBMG          s               n

     d TheFont         ds                  likeds(pdffont)  based(pTheFont)
     d TheScript       s                   like(tag)
     d TheLang         s                   like(tag)

    ?d*=-----------------------------------
    ? *Text processing with OpenType Layout fonts
    ? *
    ? *A text-processing client follows a standard process to convert the string of characters
    ? *  entered by a user into positioned glyphs. To produce text with OpenType Layout fonts:
    ? *1.Using the cmap table in the font, the client converts the character codes into a string of
    ? *  glyph indices.
    ? *2.Using information in the GSUB table, the client modifies the resulting string, substituting
    ? *  positional or vertical glyphs, ligatures, or other alternatives as appropriate.
    ? *3.Using positioning information in the GPOS table and baseline offset information in the BASE
    ? *  table, the client then positions the glyphs.
    ? *4.Using design coordinates the client determines device-independent line breaks. Design
    ? *  coordinates are high-resolution and device-independent.
    ? *5.Using information in the JSTF table, the client justifies the lines, if the user has
    ? *  specified such alignment.
    ? *6.The operating system rasterizes the line of glyphs and renders the glyphs in device
    ? *  coordinates that correspond to the resolution of the output device.
    ? *
    ? *Throughout this process the text-processing client keeps track of the association between the
    ? *character codes for the original text and the glyph indices of the final, rendered text. In
    ? *addition, the client may save language and script information within the text stream to
    ? *clearly associate character codes with typographical behavior.
    ?d*=-----------------------------------
    ?d*                ScriptList table
     d ScriptList      ds                  qualified based(pscriptlist)
    ?d*                uint16 ScriptCount Number of ScriptRecords
     d   Count                             like(uint16)
    ?d*                struct ScriptRecord Array of ScriptRecords
    ?d*                 [ScriptCount] -listed alphabetically by ScriptTag
     d   record                       1

    ?d*                ScriptRecord
     d ScriptRecord    ds                  qualified based(pScriptRecord)
    ?d*                Tag ScriptTag 4-byte ScriptTag identifier
     d   ID                                like(tag)
    ?d*                Offset Script Offset to Script table-from beginning of ScriptList
     d   offset                            like(offset)

    ?d*                Script table
     d Script          ds                  qualified based(pScript     )
    ?d*                Offset DefaultLangSys Offset to DefaultLangSys table-from beginning of Script
     d   defaultlang                       like(offset)
    ?d*                uint16 LangSysCount Number of LangSysRecords for this script-excluding the De
     d   count                             like(uint16)
    ?d*                struct LangSysRecord Array of LangSysRecords-listed alphabetically by LangSys
    ?d*                 [LangSysCount]
     d   record                       1

    ?d*                LangSysRecord
     d LangSysRec      ds                  qualified based(pLangSysRec)
    ?d*                Tag LangSysTag 4-byte LangSysTag identifier
     d   tag                               like(tag)
    ?d*                Offset LangSys Offset to LangSys table-from beginning of Script table
     d   offset                            like(offset)

    ?d*                LangSys table
     d LangSys         ds                  qualified based(pLangSys)
    ?d*                Offset LookupOrder null
     d   order                             like(offset)
    ?d*                uint16 ReqFeatureIndex Index of a feature required for this language system-
    ?d*                features = 0xFFFF
     d   ReqFeature                        like(uint16)
    ?d*                uint16 FeatureCount Number of FeatureIndex values for this language system-ex
    ?d*                feature
     d   count                             like(uint16)
    ?d*                uint16 FeatureIndex[FeatureCount] Array of indices into the FeatureList-in ar
     d   index                             like(uint16) dim(1000)



    ?d*=------------------------------------
    ?d*                FeatureList table
     d featurelist     ds                  qualified based(pfeaturelist)
    ?d*                uint16 FeatureCount Number of FeatureRecords in this table
     d   featurecount                      like(uint16)
    ?d*                struct FeatureRecord[FeatureCount] Array of FeatureRecords-zero-based (first
    ?d*                FeatureIndex = 0)-listed alphabetically by FeatureTag
     d  featurerecord                 1

    ?d*                FeatureRecord
     d featurerecord   ds                  qualified based(pfeaturerecord)
    ?d*                Tag FeatureTag 4-byte feature identification tag
     d   FeatureTag                        like(tag)
    ?d*                Offset Feature Offset to Feature table-from beginning of FeatureList
     d  featureOffset                      like(offset)

    ?d*                Feature table
     d feature         ds                  qualified based(pfeature)
    ?d*                Offset FeatureParams #NAME?
     d   featureparms                      like(offset)
    ?d*                uint16 LookupCount Number of LookupList indices for this feature
     d   lookupcount                       like(uint16)
    ?d*                uint16 LookupListIndex Array of LookupList indices for this feature -zero-bas
    ?d*                        [LookupCount]  LookupListIndex = 0)
     d   LookupListIndex...
     d                                     like(uint16) dim(1000)


    ?d*                LookupList table
     d lookuplist      ds                  qualified based(plookuplist)
    ?d*                uint16 LookupCount Number of lookups in this table
     d   lookupcount                       like(uint16)
    ?d*                Offset Lookup[LookupCount] Array of offsets to Lookup tables-from beginning o
    ?d*                based (first lookup is Lookup index = 0)
     d   lookup                            like(offset) dim(1000)

    ?d*                Lookup table
     d SubLookup       ds                  based(pSubLookup) likeds(lookup)
     d lookup          ds                  qualified based(plookup)
    ?d*                uint16 LookupType Different enumerations for GSUB and GPOS
     d   lookuptype                        like(uint16)
    ?d*                uint16 LookupFlag Lookup qualifiers
     d   lookupflag                   2
    ?d*                uint16 SubTableCount Number of SubTables for this lookup
     d  subtablecount                      like(uint16)
    ?d*                Offset SubTable Array of offsets to SubTables-from beginning of Lookup table
    ?d*                 [SubTableCount]
     d   subtable                          like(offset) dim(1000)
    ?d*                unit16 MarkFilteringSet Index (base 0) into GDEF mark glyph sets structure. T
    ?d*                present if bit UseMarkFilteringSet of lookup flags is set.
     d   MarkFilteringSet...
     d                 s                   like(uint16) based(pMarkFilteringSet)

    ? *SubstFormat subtable
     d LookupType      ds                  qualified based(pLookupType)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)

    ? *SingleSubstFormat1 subtable: Calculated output glyph indices
     d Single          ds                  qualified based(pSingle)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                int16 DeltaGlyphID Add to original GlyphID to get substitute GlyphID
     d   DeltaGlyphID                      like(int16)

     d single2         ds                  qualified based(psingle)
    ? *                uint16 SubstFormat Format identifier-format = 2
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 GlyphCount Number of GlyphIDs in the Substitute array
     d   GlyphCount                        like(uint16)
    ? *                GlyphID Substitute
    ? *                 [GlyphCount] Array of substitute GlyphIDs-ordered by Coverage Index
     d   GlyphID                           like(glyphid) dim(1000)



     d multiple        ds                  qualified based(pMultiple)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 SequenceCount Number of Sequence table offsets in the Sequence array
     d   SequenceCount...
     d                                     like(uint16)
    ? *                Offset Sequence
    ? *                 [SequenceCount] Array of offsets to Sequence tables-from beginning of
    ? *                Substitution table-ordered by Coverage Index
     d   Sequence                          like(offset) dim(1000)

     d alternate       ds                  qualified based(pAlternate)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 AlternateSetCount Number of AlternateSet tables
     d   SetCount                          like(uint16)
    ? *                Offset AlternateSet
    ? *                 [AlternateSetCount] Array of offsets to AlternateSet tables-from beginning
    ? *                of Substitution table-ordered by Coverage Index
     d   Set                               like(offset) dim(1000)


     d AlternateSet    ds                  qualified based(pAlternateSet)
    ? *                uint16 GlyphCount Number of GlyphIDs in the Alternate array
     d   GlyphCount                        like(uint16)
    ? *                GlyphID Alternate[GlyphCount] Array of alternate GlyphIDs-in arbitrary order
     d    Alternate                        like(glyphid) dim(1000)


     d Ligature        ds                  qualified based(pLigature )
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 LigSetCount Number of LigatureSet tables
     d   SetCount                          like(uint16)
    ? *                Offset LigatureSet
    ? *                 [LigSetCount] Array of offsets to LigatureSet tables-from beginning of
    ? *                Substitution table-ordered by Coverage Index
     d   Set                               like(offset) dim(1000)


     d LigatureSet     ds                  qualified based(pLigatureSet)
    ? *                uint16 LigatureCount Number of Ligature tables
     d  LigatureCount                      like(uint16)
    ? *                Offset Ligature[LigatureCount]
    ? *                Array of offsets to Ligature tables-from beginning of
    ? *                LigatureSet table-ordered by preference
     d   Ligature                          like(offset ) dim(1000)

    ? *                Ligature table: Glyph components for one ligature
     d LigatureTable   ds                  qualified based(pLigatureTable)
    ?d*                GlyphID LigGlyph GlyphID of ligature to substitute
     d   LigGlyph                          like(glyphid)
    ?d*                uint16 CompCount Number of components in the ligature
     d  CompCount                          like(uint16)
    ?d*                GlyphID Component[CompCount - 1]
    ?d*                                 Array of component GlyphIDs-start with the second
    ?d*                component-ordered in writing direction
     d   Component                         like(glyphid) dim(1000)






     d Context1        ds                  qualified based(pContext)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 SubRuleSetCount Number of SubRuleSet tables-must equal GlyphCount in
    ? *                Coverage table
     d   SubRuleSetCount...
     d                                     like(uint16)
    ? *                Offset SubRuleSet[SubRuleSetCount]
    ? *                Array of offsets to SubRuleSet tables-from beginning of
    ? *                Substitution table-ordered by Coverage Index
     d   SubRuleSet                        like(offset) dim(1000)

    ? *SubRuleSet table: All contexts beginning with the same glyph
    ? *                uint16 SubRuleCount Number of SubRule tables
    ? *                Offset SubRule
    ? *                 [SubRuleCount] Array of offsets to SubRule tables-from beginning of
    ? *                SubRuleSet table-ordered by preference

    ? *SubRule table: One simple context definition
    ? *                uint16 GlyphCount Total number of glyphs in input glyph sequence-includes the
    ? *                first glyph
    ? *                uint16 SubstCount Number of SubstLookupRecords
    ? *                GlyphID Input
    ? *                 [GlyphCount - 1] Array of input GlyphIDs-start with second glyph
    ? *                struct SubstLookupRecord
    ? *                 [SubstCount] Array of SubstLookupRecords-in design order

    ? *Context2 subtable: Class-based context glyph substitution
     d Context2        ds                  qualified based(pContext)
    ? *                 uint16 SubstFormat Format identifier-format = 2
     d  SubstFormat                        like(uint16)
    ? *                 Offset Coverage Offset to Coverage table-from beginning of Substitution
    ? *                 table
     d  Coverage                           like(offset)
    ? *                 Offset ClassDef Offset to glyph ClassDef table-from beginning of
    ? *                 Substitution table
     d  ClassDef                           like(offset)
    ? *                 uint16 SubClassSetCnt Number of SubClassSet tables
     d  SubClassSetCnt...
     d                                     like(uint16)
    ? *                 Offset SubClassSet
    ? *                  [SubClassSetCnt] Array of offsets to SubClassSet tables-from beginning of
    ? *                 Substitution table-ordered by class-may be NULL
     d  SubClassSet                        like(offset) dim(1000)

    ? * ClassDefFormat1 table: Class array
     d ClasDef1        ds                  qualified based(pClassDef)
    ? *                uint16 ClassFormat Format identifier-format = 1
     d  ClassFormat                        like(uint16)
    ? *                GlyphID StartGlyph First GlyphID of the ClassValueArray
     d   StartGlyph                        like(Glyphid)
    ? *                uint16 GlyphCount Size of the ClassValueArray
     d  GlyphCount                         like(uint16)
    ? *                uint16 ClassValueArray[GlyphCount] Array of Class Values-one per GlyphID
     d  ClassValue                         like(uint16) dim(1000)

    ? *                 ClassDefFormat2 table: Class ranges
     d ClasDef2        ds                  qualified based(pClassDef)
    ? *                 uint16 ClassFormat Format identifier-format = 2
     d  ClassFormat                        like(uint16)
    ? *                 uint16 ClassRangeCount Number of ClassRangeRecords
     d  ClassRangeCount...
     d                                     like(uint16)
    ? *                 struct ClassRangeRecord
    ? *                 [ClassRangeCount] Array of ClassRangeRecords-ordered by Start GlyphID
     d  ClassRangeRecord...
     d                                1

    ? *                 ClassRangeRecord
     d ClassRange...
     d                 ds                  qualified based(pClassRange)
    ? *                 GlyphID Start First GlyphID in the range
     d   Start                             like(GlyphID )
    ? *                 GlyphID End Last GlyphID in the range
     d   End                               like(GlyphID )
    ? *                 uint16 Class Applied to all glyphs in the range
     d   Class                             like(uint16)

    ? * SubClassSet subtable
     d SubClassSet     ds                  qualified based(pSubClassSet)
    ? *                uint16 SubClassRuleCnt Number of SubClassRule tables
     d  SubClassRuleCnt...
     d                                     like(uint16)
    ? *                Offset SubClassRule
    ? *                 [SubClassRuleCount] Array of offsets to SubClassRule tables-from beginning
    ? *                of SubClassSet-ordered by preference
     d  SubClassRule                       like(offset) dim(1000)

    ? * SubClassRule table: Context definition for one class
     d SubClassRule    ds                  qualified based(pSubClassRule)
    ? *                 uint16 GlyphCount Total number of classes specified for the context in the
    ? *                 rule-includes the first class
     d  GlyphCount                         like(uint16)
    ? *                 uint16 SubstCount Number of SubstLookupRecords
     d  SubstCount                         like(uint16)
    ? *                 uint16 Class
    ? *                  [GlyphCount - 1] Array of classes-beginning with the second class-to be
    ? *                 matched to the input glyph class sequence
     d  Class                              like(uint16) dim(1000)
    ? *                 struct SubstLookupRecord
    ? *                  [SubstCount] Array of Substitution lookups-in design order



    ? *SubstLookupRecord
     d SubstLookupRecord...
     d                 ds                  qualified based(pSubstLookupRecord)
    ? *                uint16 SequenceIndex Index into current glyph sequence-first glyph = 0
     d  SequenceIndex                      like(uint16)
    ? *                uint16 LookupListIndex Lookup to apply to that position-zero-based
     d  LookupListIndex...
     d                                     like(uint16)


    ? *Context3 subtable: Coverage-based context glyph substitution
    ? *                 uint16 SubstFormat Format identifier-format = 3
    ? *                 uint16 GlyphCount Number of glyphs in the input glyph sequence
    ? *                 uint16 SubstCount Number of SubstLookupRecords
    ? *                 Offset Coverage[GlyphCount] Array of offsets to Coverage table-from
    ? *                 beginning of Substitution table-in glyph sequence order
    ? *                 struct SubstLookupRecord
    ? *                  [SubstCount] Array of SubstLookupRecords-in design order

    ?d*ContextSubst    ds                  qualified based(pContext)
    ? *                uint16 SequenceIndex Index into current glyph sequence-first glyph = 0
    ? *                uint16 LookupListIndex Lookup to apply to that position-zero-based

    ? *Chain1 subtable: Simple context glyph substitution
     d chain1          ds                  qualified based(pChain)
    ? *                uint16 SubstFormat Format identifier-format = 1
     d   SubstFormat                       like(uint16)
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
     d   Coverage                          like(offset)
    ? *                uint16 ChainSubRuleSetCount Number of ChainSubRuleSet tables-must equal
    ? *                GlyphCount in Coverage table
    ? *                Offset ChainSubRuleSet
    ? *                 [ChainSubRuleSetCount] Array of offsets to ChainSubRuleSet tables-from
    ? *                beginning of Substitution table-ordered by Coverage Index

    ? *ChainSubRuleSet table: All contexts beginning with the same glyph
    ? *                uint16 ChainSubRuleCount Number of ChainSubRule tables
    ? *                Offset ChainSubRule
    ? *                 [ChainSubRuleCount] Array of offsets to ChainSubRule tables-from beginning
    ? *                of ChainSubRuleSet table-ordered by preference

    ? *ChainSubRule subtable
    ? *                uint16 BacktrackGlyphCount Total number of glyphs in the backtrack sequence
    ? *                (number of glyphs to be matched before the first glyph)
    ? *                GlyphID Backtrack
    ? *                 [BacktrackGlyphCount] Array of backtracking GlyphID's (to be matched before
    ? *                the input sequence)
    ? *                uint16 InputGlyphCount Total number of glyphs in the input sequence (includes
    ? *                the first glyph)
    ? *                GlyphID Input
    ? *                 [InputGlyphCount - 1] Array of input GlyphIDs (start with second glyph)
    ? *                uint16 LookaheadGlyphCount Total number of glyphs in the look ahead sequence
    ? *                (number of glyphs to be matched after the input sequence)
    ? *                GlyphID LookAhead
    ? *                 [LookAheadGlyphCount] Array of lookahead GlyphID's (to be matched after the
    ? *                input sequence)
    ? *                uint16 SubstCount Number of SubstLookupRecords
    ? *                struct SubstLookupRecord
    ? *                 [SubstCount] Array of SubstLookupRecords (in design order)

    ? *Chain2 subtable: Class-based chaining context glyph
    ? *                substitution
    ? *                uint16 SubstFormat Format identifier-format = 2
    ? *                Offset Coverage Offset to Coverage table-from beginning of Substitution table
    ? *                Offset BacktrackClassDef Offset to glyph ClassDef table containing backtrack
    ? *                sequence data-from beginning of Substitution table
    ? *                Offset InputClassDef Offset to glyph ClassDef table containing input sequence
    ? *                data-from beginning of Substitution table
    ? *                Offset LookaheadClassDef Offset to glyph ClassDef table containing lookahead
    ? *                sequence data-from beginning of Substitution table
    ? *                uint16 ChainSubClassSetCnt Number of ChainSubClassSet tables
    ? *                Offset ChainSubClassSet
    ? *                 [ChainSubClassSetCnt] Array of offsets to ChainSubClassSet tables-from
    ? *                beginning of Substitution table-ordered by input class-may be NULL

    ? *ChainSubClassSet subtable
    ? *                uint16 ChainSubClassRuleCnt Number of ChainSubClassRule tables
    ? *                Offset ChainSubClassRule
    ? *                 [ChainSubClassRuleCount] Array of offsets to ChainSubClassRule tables-from
    ? *                beginning of ChainSubClassSet-ordered by preference

    ? *                ChainSubClassRule table: Chaining context definition for one class
    ? *                uint16 BacktrackGlyphCount Total number of glyphs in the backtrack sequence
    ? *                (number of glyphs to be matched before the first glyph)
    ? *                uint16 Backtrack
    ? *                 [BacktrackGlyphCount] Array of backtracking classes(to be matched before the
    ? *                input sequence)
    ? *                uint16 InputGlyphCount Total number of classes in the input sequence
    ? *                (includes the first class)
    ? *                uint16 Input
    ? *                 [InputGlyphCount - 1] Array of input classes(start with second class; to be
    ? *                matched with the input glyph sequence)
    ? *                uint16 LookaheadGlyphCount Total number of classes in the look ahead sequence
    ? *                (number of classes to be matched after the input sequence)
    ? *                uint16 LookAhead
    ? *                 [LookAheadGlyphCount] Array of lookahead classes(to be matched after the
    ? *                input sequence)
    ? *                uint16 SubstCount Number of SubstLookupRecords
    ? *                struct SubstLookupRecord
    ? *                 [SubstCount] Array of SubstLookupRecords (in design order)

    ? *Chain3 subtable: Coverage-based chaining context glyph
    ? *                 uint16 SubstFormat Format identifier-format = 3
    ? *                 uint16 BacktrackGlyphCount Number of glyphs in the backtracking sequence
    ? *                 Offset Coverage[BacktrackGlyphCount] Array of offsets to coverage tables in
    ? *                 backtracking sequence, in glyph sequence order
    ? *                 uint16 InputGlyphCount Number of glyphs in input sequence
    ? *                 Offset Coverage[InputGlyphCount] Array of offsets to coverage tables in
    ? *                 input sequence, in glyph sequence order
    ? *                 uint16 LookaheadGlyphCount Number of glyphs in lookahead sequence
    ? *                 Offset Coverage[LookaheadGlyphCount] Array of offsets to coverage tables in
    ? *                 lookahead sequence, in glyph sequence order
    ? *                 uint16 SubstCount Number of SubstLookupRecords
    ? *                 struct SubstLookupRecord
    ? *                  [SubstCount] Array of SubstLookupRecords, in design order

     d Extension       DS                  qualified based(pExtension)
    ? *                  USHORT SubstFormat Format identifier. Set to 1.
     d  SubstFormat                        like(ushort)
    ? *                  USHORT ExtensionLookupType Lookup type of subtable referenced by
    ? *                  ExtensionOffset (i.e. the extension subtable).
     d  LookupType                         like(ushort)
    ? *                  ULONG ExtensionOffset Offset to the extension subtable, of lookup type
    ? *                  ExtensionLookupType, relative to the start of the ExtensionSubstFormat1
    ? *                  subtable.
     d  Offset                             like(ulong)

     d Reverse         ds                  qualified based(pReverse)
    ? *                ReverseChainSingleSubstFormat1 subtable: Coverage-based Reverse Chaining
    ? *                Contextual Single Glyph substitution .
    ? *                uint16 SubstFormat Format identifier-format = 1
     d  SubstFormat                        like(uint16 )
    ? *                Offset Coverage Offset to Coverage table - from beginning of Substitution
    ? *                table
     d  coverage                           like(offset)
    ? *                uint16 BacktrackGlyphCount Number of glyphs in the backtracking sequence
     d  BackCount                          like(uint16 )
    ? *                Offset Coverage[BacktrackGlyphCount] Array of offsets to coverage tables in
    ? *                backtracking sequence, in glyph sequence order
     d  Backcoverage                       like(offset)
    ? *                uint16 LookaheadGlyphCount Number of glyphs in lookahead sequence
     d  AheadCount                         like(uint16 )
    ? *                Offset Coverage[LookaheadGlyphCount] Array of offsets to coverage tables in
    ? *                lookahead sequence, in glyph sequence order
     d  AheadCoverage                      like(offset)
    ? *                uint16 GlyphCount Number of GlyphIDs in the Substitute array
     d  GlyphCount                         like(uint16 )
    ? *                GlyphID Substitute[GlyphCount] Array of substitute GlyphIDs-ordered by
    ? *                Coverage Index
     d  GlyphID                            like(GlyphID) dim(1000)

    ?d*                CoverageFormat1 table: Individual glyph indices
     d coverage1       ds                  qualified based(pcoverage )

    ?d*                uint16 CoverageFormat Format identifier-format = 1
     d coverageformat                      like(uint16)
    ?d*                uint16 GlyphCount Number of glyphs in the GlyphArray
     d  glyphcount                         like(uint16)
    ?d*                GlyphID GlyphArray[GlyphCount] Array of GlyphIDs-in numerical order
     d   GlyphID                           like(glyphid) dim(1000)

    ?d*                CoverageFormat2 table: Range of glyphs
     d coverage2       ds                  qualified based(pcoverage )

    ?d*                uint16 CoverageFormat Format identifier-format = 2
     d coverageformat                      like(uint16)
    ?d*                uint16 RangeCount Number of RangeRecords
     d   rangecount                        like(uint16)
    ?d*                struct RangeRecord Array of glyph ranges-ordered by Start GlyphID
    ?d*                 [RangeCount]
     d   rangerecord                  1

    ?d*                RangeRecord
     d RangeRecord     ds                  qualified based(prange    )

    ?d*                GlyphID Start First GlyphID in the range
     d   start                             like(glyphid)
    ?d*                GlyphID End Last GlyphID in the range
     d   end                               like(glyphid)
    ?d*                uint16 StartCoverageIndex Coverage Index of first GlyphID in range
     d   StartcoverageIndex...
     d                                     like(uint16)

    ?d*Class Definition Table
    ? *ClassDefFormat1 table: Class array
    ? *ClassDefFormat2 table: Class ranges
    ? *ClassRangeRecord
    ? *Device table

     d CoverageList    s              5i00 dim(1000)
     d iCL             s              5i00




     d iIndex          s              5i 0
     d iList           s              5i 0
     d iLookup         s              5i 0
     d iSubTable       s              5i 0
     d iSubSubTable    s              5i 0
     d iFeature        s              5i 0
     d iCoverage       s              5i 0
     d iLiga           s              5i00
     d iLigaSet        s              5i00
     d iLigaTab        s              5i00
     d iRange          s              5i00
     d iSubClassSet    s              5i00
     d iSubClassRule   s              5i00
     d iClassRange     s              5i00
     d iClass          s              5i00
     d iLookupList     s              5i00
     d iScriptList     s              5i00
     d ipos            s              5i 0
     d iScript         s              5i00
     d jpos            s              5i 0
     d iLangSys        s              5i00
     d kpos            s              5i 0
     d TheTag          s                   like(tag)
     d ApplyClass      s              5i00
     d arab            ds                  qualified
     d   prev                         1
     d   cur                          1
     d   next                         1








     d
    ? *=-----------------------------------------------------------------------------------------=*

      /free
       //?* programme principal
       //?input
       //?- structure pdffont
       //?- texte à transformer
       //?- script (par defaut, le premier)
       //?- langsys (par defaut, le defaultlang)
       //
       //
       //
       *inlr = *on;
       pTheFont=%Addr(p_font);
       //?ajouter un espace au debut et à la fin du texte
       //? charger la table bc (bidi class) selon le texte et curfont.bc
       wk.String = Uspace + thestring +Uspace;
B01    For i = 1 To wk.len;
B02       If wk.Uni(i) = 0;
             wk.bc(i)=0;
             wk.glyf(i)=0;
X02       Else;
             wk.bc(i)=thefont.bc(wk.Uni(i));
             wk.glyf(i)=thefont.U2g(wk.Uni(i));
E02       Endif;
E01    Endfor;
B01    If GsubDebug;
          GsubMsg='Uni(1-'+%Char(wk.len)+')=';
B02       For i = 1 To wk.len;
             GsubMsg+=%Char(wk.Uni(i))+' ';
E02       Endfor;
          Message('':GsubMsg);
          GsubMsg='Glyf(1-'+%Char(wk.len)+')=';
B02       For i = 1 To wk.len;
             GsubMsg+=%Char(wk.glyf(i))+' ';
E02       Endfor;
          Message('':GsubMsg);
E01    Endif;












       //?si on a déjà chargé gsub, en tirer parti
B01    If thefont.Pgsub <> *null;
          pgsub_h=thefont.Pgsub;
          Exsr Gsubsr;
X01    Else;
          Clear ifs;
          ifs.name = thefont.Ttfname ;
          ifs.FileHandleA= Open( %Trim(ifs.name ) : O_rdonly ) ;
B02       If ifs.FileHandleA= -1;
             Message(Errnomsg(Errno()):'':'':'QCPFMSG':'*ESCAPE':'*': 2);
             Return;
E02       Endif;
          AsciiFrom = 0;
          rc = Fstat(ifs.FileHandleA : myStat);
          rc = myStat.St_size * 2 ;
          ifs.AsciiTo= myStat.St_size ;
          ifs.AsciiRead=0;
          thefont.Ttfccsid =myStat.St_ccsid;
          Getbytes(%Addr(sfnt):ifs:0:%Size(sfnt));

          //?Structure('sfnt');
B02       For iTable = 0 To sfnt.numTables-1;
             AtOff = %Size(sfnt) + iTable * %Size(tablerec) ;
             Getbytes(%Addr(tablerec) : ifs
                :AtOff
                :%Size(tablerec));
             TheTag = Convccsid(thefont.Ttfccsid:0:tablerec.name);
B03          Select;
X03             When TheTag = 'GSUB';
                   pgsub_h=%Alloc(tablerec.length ) ;
                   thefont.Pgsub = pgsub_h;
                   Getbytes( pgsub_h :ifs:tablerec.offset:tablerec.length );
                   Exsr Gsubsr ;
                   Leave;
E03          Endsl;
E02       Endfor;
E01    Endif;   //?pgsub
       iUni = 0;
B01    For iGlyf = 1 To wk.len;
          //?supprimer les pseudo caractères insérés pour ALEF et compagnie
          //?ce qui vire en passant les caractères qui ne sont pas dans la fonte
          //?donc simplifiera le calcul de la longueur
          //?ben non, faut les laisser... ou pas
B02       If wk.glyf(iGlyf) = 0;
X02       Else;
B03          If thefont.G2u(wk.glyf(iGlyf)) > 0;
                //?wk.Uni(iglyf)=thefont.G2u(wk.glyf(iGlyf));
                iUni+=1;
                wk.Uni(iUni )=thefont.G2u(wk.glyf(iGlyf));
E03          Endif;
E02       Endif;
E01    Endfor;
       wk.len = iGlyf;
       wk.len = iUni ;
B01    If GsubDebug;
          GsubMsg='Return:Uni(1-'+%Char(wk.len)+')=';
B02       For i = 1 To wk.len;
             GsubMsg+=%Char(wk.Uni(i))+' ';
E02       Endfor;
          Message('':GsubMsg);
E01    Endif;
       if wk.len > 2;
       thestring = %Subst(wk.String:2);
       %Len(thestring)-=1;
       else;
       thestring='';
       endif;


       rc = Close(ifs.FileHandleA) ;
       Return;
       //?---------------------------------------------------------------
B00    Begsr Gsubsr ;
B01    If gsub_h.version <> x'00010000';
          //?Version of the GSUB table-initially set to 0x00010000
          Message('':'GSUB version' +
             %Char(gsub_h.version.Left)+'.'+%Char(gsub_h.version.Right)
             + ' not supported');
          Return;
E01    Endif;
       pscriptlist=pgsub_h+gsub_h.ScriptList;
       //?ScriptLists, FeatureLists, and LookupLists
       //?structure commune à GSUB, GPOS, BASE, JSTF, and GDEF tables.
       //?parcourir les scripts
B01    For iScriptList = 0 To %Int(ScriptList.count) - 1;
          pScriptRecord = %Addr(ScriptList.record) +
             iScriptList * %Size(ScriptRecord);
          //?4-byte ScriptTag identifier
          TheTag = Convccsid(thefont.Ttfccsid:0:ScriptRecord.ID);
B02       If TheTag <> TheScript
X..          And TheScript <> '';
             Iter;
E02       Endif;

          //?traitement des cas particulier des caractères arabes
B02       If TheTag = 'arab';

             //?cas particulier des lettres arabes qui ne s'accrochent pas à la suivante
             //?ALEF DAL  THAL REH  ZAIN WAW
             //?1570 1774 1584 1775 1586 1738
             //?1571 1583      1585      1743
             //?1573 1674      1682      1732
             //?1575 1675      1683      1572
             //?1609 1679      1684      1608
             //?1649 1673      1685      1912
             //?1650 1680      1686      1913
             //?1651 1882      1687
             //?1907 1881      1689
             //?1908           1883
             //?               1899
             //?               1900
             //?               1905
             //?intercaler apres ces caractère un x'200C' (taggé en bc=10) ZERO WIDTH NON-JOINER


             //?utiliser le BMG des caractères qui en ont (Bidi Mirroring Glyf)
             // un caractère BMG au début ou à la fin ne change pas de BMG
             // mouais, c'est pas si clair que ca
             // faudrait déjà comprendre pourquoi/comment BIDI fait des invertions des OtherNeutral.

             // Each mirrored character in an odd BiDi level is assigned a mirrored glyph.

B03       // For iUni = 3 To wk.len-2 ; // ! ajout 1 espace début et fin
B04       //    If thefont.Bmg(wk.Uni(iUni)) <> 0; // genre parenthese ouvrante et fermante
          //       // seulement si le caractère à gauche ou a droite est AR (.bc=5)
          //       usebmg=false;
          //       for ibmg = iuni-1 downto 1;
          //           if wk.Uni(ibmg) <> 0;
          //              if thefont.Bc(wk.Uni(ibmg)) = 12
          //              or thefont.Bc(wk.Uni(ibmg)) = 0  ;
          //              iter;
          //              endif;
          //              if        thefont.Bc(wk.Uni(ibmg)) = 5   ;
          //                usebmg = true;
          //              endif;
          //              leave;
          //           endif;
          //       endfor;
          //       for ibmg = iuni+1     to wk.len;
          //           if wk.Uni(ibmg) <> 0;
          //              if thefont.Bc(wk.Uni(ibmg)) = 12
          //              or thefont.Bc(wk.Uni(ibmg)) = 0  ;
          //              iter;
          //              endif;
          //              if        thefont.Bc(wk.Uni(ibmg)) = 5   ;
          //                usebmg = true;
          //              endif;
          //              leave;
          //           endif;
          //       endfor;
          //
          //       if usebmg;
          //       // utiliser le .bmg à la place
          //          wk.Uni(iUni) = thefont.Bmg(wk.Uni(iUni));
   E0     //       Endif;
E04       //    Endif;
          // endfor;



             wuni = wk.Uni;
             maxwuni = wk.len;
             wk.string = *loval;  // donc wk.len = 1000

             iUni = 0 ;
B03          For iWUni = 1 To MaxWUni;
                iUni+=1;
                wk.Uni(iUni) = wuni(iWUni);
                wk.bc(iUni)=thefont.bc(wk.Uni(iUni));
                wk.glyf(iUni)=thefont.U2g(wk.Uni(iUni));
B04             If wk.Uni(iUni) = 1570   //?alef
X04             Or wk.Uni(iUni) = 1571
X04             Or wk.Uni(iUni) = 1573
X04             Or wk.Uni(iUni) = 1575
X04             Or wk.Uni(iUni) = 1609
X04             Or wk.Uni(iUni) = 1649
X04             Or wk.Uni(iUni) = 1650
X04             Or wk.Uni(iUni) = 1651
X04             Or wk.Uni(iUni) = 1907
X04             Or wk.Uni(iUni) = 1908
X04             Or wk.Uni(iUni) = 1774   //?dal
X04             Or wk.Uni(iUni) = 1583
X04             Or wk.Uni(iUni) = 1674
X04             Or wk.Uni(iUni) = 1675
X04             Or wk.Uni(iUni) = 1679
X04             Or wk.Uni(iUni) = 1673
X04             Or wk.Uni(iUni) = 1680
X04             Or wk.Uni(iUni) = 1882
X04             Or wk.Uni(iUni) = 1881
X04             Or wk.Uni(iUni) = 1584   //?thal
X04             Or wk.Uni(iUni) = 1775   //?reh
X04             Or wk.Uni(iUni) = 1585
X04             Or wk.Uni(iUni) = 1682
X04             Or wk.Uni(iUni) = 1683
X04             Or wk.Uni(iUni) = 1684
X04             Or wk.Uni(iUni) = 1685
X04             Or wk.Uni(iUni) = 1686
X04             Or wk.Uni(iUni) = 1687
X04             Or wk.Uni(iUni) = 1689
X04             Or wk.Uni(iUni) = 1586   //?zain
X04             Or wk.Uni(iUni) = 1738   //?waw
X04             Or wk.Uni(iUni) = 1743
X04             Or wk.Uni(iUni) = 1732
X04             Or wk.Uni(iUni) = 1572
X04             Or wk.Uni(iUni) = 1608
X04             Or wk.Uni(iUni) = 1912
X04             Or wk.Uni(iUni) = 1913
                      ;
                   //?ajouter le x'0000 après les BC=6 qui suivent ce caractère
B05                For Ever;
B06                   If thefont.bc(wuni(iWUni+1) ) = 6;
                         iUni+=1;
                         iWUni+=1;
                         wk.Uni(iUni) = wuni(iWUni);
B07                      If thefont.Bmg(wk.Uni(iUni)) <> 0;
                            wk.Uni(iUni) = thefont.Bmg(wk.Uni(iUni));
E07                      Endif;
                         wk.bc(iUni)=thefont.bc(wk.Uni(iUni));
                         wk.glyf(iUni)=thefont.U2g(wk.Uni(iUni));
X06                   Else;
                         Leave;
E06                   Endif;
E05                Endfor;
                   iUni+=1;
                   wk.Uni(iUni)=8205 ;
                   //?wk.glyf(i)=thefont.U2g(wk.Uni(i));
                   wk.glyf(iUni)=0 ;   //?pour pouvoir l'enlever en sortant
                   wk.bc(iUni) = 10;
E04             Endif;
E03          Endfor;
             wk.len = iUni ;


B03          If GsubDebug;
                GsubMsg='Arab:Uni(1-'+%Char(wk.len)+')=';
B04             For i = 1 To wk.len;
                   GsubMsg+=%Char(wk.Uni(i))+' ';
E04             Endfor;
                Message('':GsubMsg);
E03          Endif;







E02       Endif;
          pScript = pscriptlist + ScriptRecord.offset;
B02       For iScript = 0 To %Int(Script.count) ;
B03          If iScript = 0;
B04             If TheLang <> '';   //?on veut une langue precise, pas la langue par defaut
                   Iter;
E04             Endif;
                pLangSys = pScript + Script.defaultlang;
X03          Else;
B04             If TheLang = '';   //?la langue par défaut vient d'être traitée
                   Leave;
E04             Endif;
                pLangSysRec = %Addr(Script.record)
                   + ((iScript-1) * %Size(LangSysRec )) ;
                TheTag = Convccsid(thefont.Ttfccsid:0:LangSysRec.Tag );
B04             If TheTag <> TheLang;
                   Iter;
E04             Endif;
                //?LangSys table -> Array of indices into the FeatureList
                pLangSys = pScript + LangSysRec.offset ;
E03          Endif;
             //?langsys.index
B03          If LangSys.count > 0;
B04             For iLangSys = 0 To LangSys.count - 1;
                   //?appliquer les features de la langue, dans l'ordre indiqué
                   iList = LangSys.index(iLangSys+1) ;
                   Exsr Feature_sr ;
E04             Endfor;
E03          Endif;
             Leave;   //?la langue demandée vient d'être traitée
E02       Endfor;
          //?le script recherché vient d'être traité
          Leave;
E01    Endfor;
E00    Endsr;
B00    Begsr Feature_sr;
       //?LookupType 1: Single Substitution Subtable
       //? Single Substitution Format 1
       //? Single Substitution Format 2
       //?LookupType 2: Multiple Substitution Subtable
       //?LookupType 3: Alternate Substitution Subtable
       //?LookupType 4: Ligature Substitution Subtable
       //?LookupType 5: Contextual Substitution Subtable
       //? Context Substitution Format 1
       //? Context Substitution Format 2
       //? Context Substitution Format 3
       //?LookupType 6: Chaining Contextual Substitution Subtable
       //? Chaining Context Substitution Format 1: Simple Chaining Context Glyph Substitution
       //? Chaining Context Substitution Format 2: Class-based Chaining Context Glyph Substitutio
       //? Chaining Context Substitution Format 3: Coverage-based Chaining Context Glyph Substitu
       //?LookupType 7: Extension Substitution
       //? Substitution Lookup Record
       //?LookupType 8: Reverse Chaining Contextual Single Substitution Subtable
       //? Reverse Chaining Contextual Single Substitution  Format 1: Coverage Based Reverse Chai
       //? Single Glyph Substitution.

       //?FeatureList table -> array de featurerecord
       pfeaturelist = pgsub_h + gsub_h.FeatureList ;
B01    If iList > FeatureList.featurecount;
          Return;
E01    Endif;
       //?Feature Record -> offset of Feature table-from beginning of FeatureList
       pfeaturerecord=%Addr(FeatureList.featurerecord)
          + iList *%size(featurerecord);
       TheTag =
          Convccsid(thefont.Ttfccsid:0:featurerecord.FeatureTag);
B01    If GsubDebug;
          GsubMsg=TheTag+':';
          Message('':GsubMsg);
E01    Endif;
       //?isol, init, medi, fina : sensibles à la BidiClass
       //?liga, mset : autonomes
       //?Feature table -> array de lookuplist
       pfeature = pfeaturelist + featurerecord.featureOffset ;
       //?LookupList -> array of offset of lookup table
       plookuplist = pgsub_h+gsub_h.LookupList ;
B01    For iFeature = 0 To feature.lookupcount-1 ;   //?iFeature
          iLookup=( feature.LookupListIndex(iFeature+1)) ;
          GsubMsg ='Lokup('+%Char(iLookup)+')';
          plookup = plookuplist + LookupList.Lookup(iLookup+1);
B02       For iSubTable = 0 To Lookup.subtablecount-1 ;   //?iSubTable
             //?subtable offset
             pLookupType =plookup+Lookup.subtable(iSubTable+1);
             pcoverage = pLookupType + lookuptype.Coverage ;
             //?parcourir wk.uni, et
             //?selon FeatureTag (isol, init, medi, fina) ou pas
             //?identifier si le caractère en cours est dans le coverage,
             //?et à quel index.
             //
             //?on a ajouté un espace au debut et à la fin pour encadrer
B03          For iUni = 2 To wk.len - 1;   //?iUni
                GsubMsg+=' '+%Char(wk.glyf(iUni));
                //?règle standard unicode :
                //?feature previous+current+next    -> current
                //?isol : spacing + char + spacing  -> char isol
                //?init : ALEF    +char  + char     -> char init (le alef va devenir fina)
                //?medi : char    + char + char     -> char medi
                //?fina : char    + char + spacing  -> char fina
                //?cas particulier des lettres arabes qui ne s'accrochent pas à la suivante
                //?ALEF DAL THAL REH ZAIN WAW
                //? ces lettre n'ont pas de forme initiale ni mediale
                //? elles se comporte toujours comme si elles étaient suivies d'un espace

        //?un Non-spacing-Mark ne doit pas masquer la position du Arabic-Letter precedent ou suivant
                //?le string est borné à gauche et à droite par un bc=12
             //?parcourir le string, passer les NSM à la recherche du premier non NSM suivant et dec
B04             If wk.bc(iUni-1) = 5;
                   arab.prev = True;
X04             Elseif wk.bc(iUni-1) = 6;
B05                If wk.bc(iUni-2) = 5;
                      arab.prev = True;
X05                Elseif wk.bc(iUni-2) = 6;
B06                   If wk.bc(iUni-3) = 5;
                         arab.prev = True;
X06                   Else;
                         arab.prev = False;
E06                   Endif;
X05                Else;
                      arab.prev = False;
E05                Endif;
X04             Else;
                   arab.prev = False;
E04             Endif;
                arab.cur =( wk.bc(iUni ) = 5);

B04             If wk.bc(iUni+1) = 5;
                   arab.Next = True;
X04             Elseif wk.bc(iUni+1) = 6;
B05                If wk.bc(iUni+2) = 5;
                      arab.Next = True;
X05                Elseif wk.bc(iUni+2) = 6;
B06                   If wk.bc(iUni+3) = 5;
                         arab.Next = True;
X06                   Else;
                         arab.Next = False;
E06                   Endif;
X05                Else;
                      arab.Next = False;
E05                Endif;
X04             Else;
                   arab.Next = False;
E04             Endif;

B04             If TheTag='isol';   //?format NC C NC  (NotChar Char NotChar)
B05                If arab = '010';
X05                Else ;
                      Iter;
E05                Endif;
X04             Elseif TheTag='init';   //?format NC C C
B05                If arab = '011';


X05                Else;
                      Iter;
E05                Endif;
X04             Elseif TheTag='medi';   //?format C C C
B05                If arab = '111';
X05                Else;

                      Iter;
E05                Endif;
X04             Elseif TheTag='fina';   //?format C C NC
B05                If arab = '110';
X05                Else;

                      Iter;
E05                Endif;
E04             Endif;
                //?pour les autres features: pas de filtrage
                iIndex = -1;
                //?Format identifier-format = 1
B04             If coverage1.coverageformat = 1;   //?iCoverage
B05                For iCoverage = 0 To coverage1.GlyphCount-1 ;
B06                   If coverage1.GlyphID(iCoverage+1)
                            = wk.glyf(iUni);
                         iIndex = iCoverage ;
                         Leave;
E06                   Endif;
E05                Endfor;
X04             Elseif coverage1.coverageformat = 2;   //?iCoverage
B05                For iCoverage = 0 To coverage2.rangecount - 1;
                      prange = %Addr(coverage2.rangerecord)
                         +Icoverage*%size(rangerecord);
B06                   If wk.glyf(iUni) < rangerecord.start;
                         Leave;
E06                   Endif;
B06                   If wk.glyf(iUni) > rangerecord.End ;
                         Iter;
E06                   Endif;
                      iIndex = rangerecord.StartcoverageIndex
                         + wk.glyf(iUni)
                         - rangerecord.start ;
                      Leave;
E05                Endfor;
E04             Endif;   //?iCoverage
B04             If iIndex >= 0;   //?iIndex
                   GsubMsg+=':C'+%Char(Lookup.lookuptype);
                   //?chercher la substitution selon le lookuptype
                   //?decortiquer selon Lookup.lookuptype
B05                Select;   //?lookuptype
X05                   When Lookup.lookuptype = 1;   //?1 Single  Replace one glyph with one glyph
                         //?poser single a l'offset du lookuptype
                         pSingle=plookup+Lookup.subtable(iSubTable+1);
B06                      Select;
X06                         When Single.SubstFormat = 1;
X06                         When Single.SubstFormat = 2;
                               //?Checkbc(wk.glyf(iUni):single2.GlyphID(iIndex+1) :thefont);
                               wk.glyf(iUni) = single2.GlyphID(iIndex+1);
                               GsubMsg+='->'+%Char(wk.glyf(iUni));
E06                      Endsl;
                         //?2 Multiple  Replace one glyph with more than one glyph
                         //?When Lookup.lookuptype = 2;
                         //?      pMultiple=plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pMultiple - pgsub_h );
                         //?      fld('multiple is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('multiple.SubstFormat':%Char(multiple.SubstFormat));
                         //?      fld('multiple.Coverage' :%Char(multiple.Coverage ));
                         //
                         //?3 Alternate  Replace one glyph with one of many glyphs
                         //?When Lookup.lookuptype = 3;
                         //?      pAlternate=plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pAlternate - pgsub_h );
                         //?      fld('alternate is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('alternate.SubstFormat':%Char(alternate.SubstFormat));
                         //?      fld('alternate.Coverage' :%Char(alternate.Coverage ));
                         //
                         //?4 Ligature  Replace multiple glyphs with one glyp
X05                   When Lookup.lookuptype = 4;
                         pLigature=plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pLigature - pgsub_h );
                         //?      fld('ligature is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('ligature.SubstFormat':%Char(Ligature.SubstFormat));
                         //?      fld('ligature.Coverage' :%Char(Ligature.Coverage ));
                         //?      pcoverage = pLigature + Ligature.Coverage ;
                         //?      Exsr Coveragetable;
                         //?      fld('ligature.SetCount':%Char(Ligature.SetCount));
                         //?      level+=1;
                         //?      For iLiga = 0 To Ligature.SetCount - 1;
                         pLigatureSet = pLigature + Ligature.Set(iIndex+1);
                         //?         AtOff = table.offset + %Int(pLigatureSet - pgsub_h );
                         //?         fld('ligatureset('+%Char(iLiga)+') is at Offset'
                         //?            :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?         fld('ligatureSet.LigatureCount'
                         //?            :%Char(LigatureSet.LigatureCount));
                         //?         level+=1;
B06                      For iLigaSet = 0 To LigatureSet.LigatureCount -1;   //?iLigaSet
                            pLigatureTable = pLigatureSet
                               + LigatureSet.Ligature(iLigaSet+1);
                            //?            AtOff = table.offset + %Int(pLigatureTable - pgsub_h );
                            //?            fld('ligaturetable('+%Char(iLigaSet)+') is at Offset'
                            //?               :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                            //?            fld('LigatureTable.LigGlyph'
                            //?               :%Char(LigatureTable.LigGlyph));
                            //?            fld('LigatureTable.CompCount'
                            //?               :%Char(LigatureTable.CompCount));
                            //?          WriteData= 'FinalLigature '+%Char(LigatureTable.LigGlyph)
                            //?               + ' '+%Char(CoverageList(iLiga+1))+' ';
                            iLiga = iUni ;
B07                         For iLigaTab = 0 To LigatureTable.CompCount -2;   //?iLigaTab
                               //?               fld('LigatureTable.Component'
                               //?                  :%Char(LigatureTable.Component(iLigaTab+1)));
                              //?       WriteData+= %Char(LigatureTable.Component(iLigaTab+1)) +' ';
                               iLiga+=1;
B08                            If LigatureTable.Component(iLigaTab+1)
                                     <> wk.glyf(iLiga);
                                  Leave;
E08                            Endif;
                               GsubMsg+='+'+%Char(wk.glyf(iLiga));
B08                            If iLigaTab = LigatureTable.CompCount -2;
                                  //?matching ok
                                  //?Checkbc(wk.glyf(iUni):LigatureTable.LigGlyph :thefont);
                                  wk.glyf(iUni) = LigatureTable.LigGlyph ;
                                  GsubMsg+='->'+%Char(wk.glyf(iUni));
B09                               For iLigaTab = 0 To
                                        LigatureTable.CompCount -2;
                                     iUni+=1;
                                     wk.glyf(iUni) = 0;
                                     wk.Uni (iUni) = 0;
E09                               Endfor;   //?cleanup replaced
E08                            Endif;   //?matchink ok
E07                         Endfor;   //?ligatab
E06                      Endfor;   //?ligaset
                         //
                         //
                         //?            Info=WriteData;
                         //?            Write Line;
                         //?         Endfor;
                         //?         level-=1;
                         //?      Endfor;
                         //?      level-=1;
                         //?5 Context  Replace one or more glyphs in context
X05                   When Lookup.lookuptype = 5;
                         Exsr Lookuptype5;

                         //?         When Context1.SubstFormat = 3;
                         //?          Info = 'context.substformat 3 not supported, no example';
                         //?            Write Line;
                         //?      Endsl;
                         //
                         //?6 Chaining Context  Replace one or more glyphs in chained
                         //?        When Lookup.lookuptype = 6;
                         //?      //?context
                         //?      pChain =plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pChain - pgsub_h );
                         //?      fld('chain1 is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('chain1.SubstFormat':%Char(chain1.SubstFormat));
                         //?      fld('chain1.Coverage' :%Char(chain1.Coverage ));
                         //
                         //?When Lookup.lookuptype = 7;
                         //?7 Extension Substitution  Extension mechanism for other
                         //?      //?substitutions (i.e. this excludes the Extension type
                         //?      //?substitution itself)
                         //?      pExtension=plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pExtension - pgsub_h );
                         //?      fld('extension is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('extension.SubstFormat':%Char(Extension.SubstFormat));
                         //
                         //
                         //?  When Lookup.lookuptype = 8;
                         //?8 Reverse chaining context single Applied in reverse
                         //?      //?order, replace single glyph in chaining context
                         //?      pReverse=plookup+Lookup.subtable(iSubTable+1);
                         //?      AtOff = table.offset + %Int(pReverse - pgsub_h );
                         //?      fld('reverse is at Offset'
                         //?         :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                         //?      fld('reverse.SubstFormat':%Char(Reverse.SubstFormat));
                         //?      fld('reverse.Coverage' :%Char(Reverse.Coverage ));
                         //
                         //?   When Lookup.lookuptype = 9;
                         //?9+ Reserved For future use (set to zero)
E05                Endsl;   //?LookupType
E04             Endif;   //?iIndex

E03          Endfor;   //?iUni
E02       Endfor;   //?iSubTable
B02       If GsubDebug;
             Message('':GsubMsg);
E02       Endif;
E01    Endfor;   //?iFeature
B01    If GsubDebug;

          GsubMsg='Uni(1-'+%Char(wk.len)+')=';
B02       For i = 1 To wk.len;
B03          If wk.glyf(i ) > 0;
                GsubMsg+=%Char(thefont.G2u(wk.glyf(i )))+' ';
X03          Else;
                GsubMsg+='0 ';
E03          Endif;
E02       Endfor;
          Message('':GsubMsg);
E01    Endif;
       //?rafraichir wk
       iUni = 0;
B01    For iUni = 1 To wk.len;

          //?rafraichir l'unicode et le BC selon les nouveaux glyf
          //?sauf pour glyf = 0, qui pointe hors de la table
B02       If wk.glyf(iUni ) > 0;
             wk.Uni(iUni)=thefont.G2u(wk.glyf(iUni ));
E02       Endif;
B02       If wk.Uni (iUni ) > 0;
             wk.bc(iUni)=thefont.bc(wk.Uni(iUni));
E02       Endif;
E01    Endfor;

E00    Endsr;
       //?---------------------------------------------------------------
B00    Begsr Lookuptype5;
       pContext =plookup+Lookup.subtable(iSubTable+1);
       //?AtOff = table.offset + %Int(pContext - pgsub_h );
       //?fld('context is at Offset'
       //?:%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
       //?fld('context.SubstFormat':%Char(Context1.SubstFormat));
       //?fld('context.Coverage' :%Char(Context1.Coverage ));
       //?le coverage est deja verifie.
       //?determiner la classe du caractère en cours
       //?donc la règle qui doit s'appliquer

B01    Select;   //?SubstFormat
X01       When Context1.SubstFormat = 1;
             //?     context.substformat 1 not supported, no example';

X01       When Context1.SubstFormat = 2;
             //?Offset to glyph ClassDef table-from beginning of Substitution table
             //?fld('context2.ClassDef' :%Char(Context2.ClassDef ));

             pClassDef=pContext +Context2.ClassDef ;
             //?AtOff = table.offset + %Int(pClassDef - pgsub_h );
             //?fld('ClassDef is at Offset'
             //?   :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
             //?fld('ClasDef.ClassFormat':%Char(ClasDef1.ClassFormat));
B02          Select;   //?ClassFormat
X02             When ClasDef1.ClassFormat=1;

                   //? clasdef.classformat=1 not supported, no example';

X02             When ClasDef1.ClassFormat=2;
                   //?fld('ClasDef2.ClassRangeCount'
                   //?   :%Char(ClasDef2.ClassRangeCount));

                   pClassRange =%Addr(ClasDef2.ClassRangeRecord);
                   ApplyClass=-1;
B03                For iClassRange = 0 To
                         ClasDef2.ClassRangeCount - 1;   //?iClassRange
B04                   If ClassRange.start<= wk.glyf(iUni) And
                            wk.glyf(iUni) <= ClassRange.End ;
                         ApplyClass= ClassRange.Class;
                         Leave;
E04                   Endif;
                      pClassRange +=%Size(ClassRange );
E03                Endfor;   //?iClassRange
E02          Endsl;   //?ClassFormat

             //?   Fld('context2.SubClassSetCnt'
             //?      :%Char(Context2.SubClassSetCnt));
             //?iSubClassSet
           //?Array of offsets to SubClassSet tables-from beginning of Substitution table-ordered by
             //?class-may be NULL
B02          If ApplyClass > -1;   //?In iClassRange
                iSubClassSet = ApplyClass ;
B03             If Context2.SubClassSet(iSubClassSet+1) <> 0;   //?iSubClassSet
                   pSubClassSet = pContext+
                      Context2.SubClassSet(iSubClassSet+1);
                   //?AtOff = table.offset
                   //?   + %Int(pSubClassSet - pgsub_h );
                   //?fld('SubClassSet('
                   //?   +%Char(iSubClassSet)
                   //?   +') is at Offset'
                   //?   :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));

                   //?fld('SubClassSet.SubClassRuleCnt'
                   //?   :%Char(SubClassSet.SubClassRuleCnt));

B04                For iSubClassRule = 0 To
                         SubClassSet.SubClassRuleCnt - 1;   //?iSubClassRule
                      pSubClassRule = pSubClassSet +
                         SubClassSet.SubClassRule(iSubClassRule+1);
                      //?AtOff = table.offset
                      //?   + %Int(pSubClassRule - pgsub_h );
                      //?fld('SubClassRule('
                      //?   +%Char(iSubClassRule)+') is at Offset'
                      //?   :%Char(AtOff)+'='+hexap(%Addr(AtOff):4));
                      //?fld('SubClassRule.GlyphCount':
                      //?   %Char(SubClassRule.GlyphCount));
                      //?fld('SubClassRule.SubstCount':
                      //?   %Char(SubClassRule.SubstCount));
                      //?iClass
                      //?determiner si les n caractères suivants sont dans la bonne classe
B05                   If iUni+SubClassRule.GlyphCount-1 <= wk.len - 1 ;   //?iClassLen
B06                      For iClass = 0 To SubClassRule.GlyphCount-2;   //?iclass
                            //? fld('SubClassRule.Class('+%Char(iClass)+')':
                            //?     %Char(SubClassRule.Class(iClass+1)));

                            pClassRange =%Addr(ClasDef2.ClassRangeRecord);
                            ApplyClass=-1;
B07                         For iClassRange = 0 To
                                  ClasDef2.ClassRangeCount - 1;   //?iClassRange
B08                            If ClassRange.start<= wk.glyf(iUni+iClass+1) And
                                     wk.glyf(iUni+iClass+1) <= ClassRange.End ;   //?ClassRange.Star
B09                        If SubClassRule.Class(iClass+1) = ClassRange.Class;   //?ClassRange.Class
                                     ApplyClass= ClassRange.Class;
                                     iUni = iUni+iClass+1;
                                     GsubMsg+='+...+'+%Char(wk.glyf(iUni));
E09                               Endif;   //?ClassRange.Class
                                  Leave;
E08                            Endif;   //?ClassRange.Start

                               pClassRange +=%Size(ClassRange );

E07                         Endfor;   //?iClassRange
E06                      Endfor;   //?for iclass
E05                   Endif;   //?iClassLen
                      //?si la règle est applicable, appliquer le lookup
B05                   If ApplyClass > -1;   //?ApplyClassRule


                         pSubstLookupRecord = %Addr(SubClassRule.Class(
                            SubClassRule.GlyphCount ));

B06                      For iLookupList = 0 To
                               SubClassRule.SubstCount - 1;   //?iLookupList
                            pSubLookup = plookuplist + LookupList.Lookup(
                               SubstLookupRecord.LookupListIndex +1);
                GsubMsg+='SL('+%Char(SubstLookupRecord.LookupListIndex +1 )+')';
B07                         For iSubSubTable = 0 To SubLookup.subtablecount-1 ;   //?iSubsubTable
                         pLookupType=pSubLookup+SubLookup.subtable(iSubTable+1);
                               pcoverage = pLookupType + lookuptype.Coverage ;
                               //?trouver le glyf dans le coverage du sublookup
                               iIndex = -1;
                               //?Format identifier-format = 1
B08                            If coverage1.coverageformat = 1;
B09                               For iCoverage = 0 To coverage1.GlyphCount-1 ;
B10                                  If coverage1.GlyphID(iCoverage+1)
                                           = wk.glyf(iUni);
                                        iIndex = iCoverage ;
                                        Leave;
E10                                  Endif;
E09                               Endfor;
X08                            Elseif coverage1.coverageformat = 2;
B09                               For iCoverage = 0 To coverage2.rangecount - 1;
                                     prange = %Addr(coverage2.rangerecord)
                                        +Icoverage*%size(rangerecord);
B10                                  If wk.glyf(iUni) < rangerecord.start;
                                        Leave;
E10                                  Endif;
B10                                  If wk.glyf(iUni) > rangerecord.End ;
                                        Iter;
E10                                  Endif;
                                     iIndex = rangerecord.StartcoverageIndex
                                        + wk.glyf(iUni)
                                        - rangerecord.start ;
                                     Leave;
E09                               Endfor;
E08                            Endif;   //?if coverage format
B08                            If iIndex >= 0;
                                  //?chercher la substitution selon le lookuptype
                                  //?decortiquer selon Lookup.lookuptype
                                  GsubMsg+=':SC'+%Char(SubLookup.lookuptype);
B09                               Select;
X09                      When SubLookup.lookuptype = 1;   //?1 Single  Replace one glyph with one gl
                                        //?poser single a l'offset du lookuptype
                          pSingle=pSubLookup+SubLookup.subtable(iSubSubTable+1);
B10                                     Select;
X10                                        When Single.SubstFormat = 1;
X10                                        When Single.SubstFormat = 2;
                                       //?Checkbc(wk.glyf(iUni):single2.GlyphID(iIndex+1) :thefont);
                                      wk.glyf(iUni) = single2.GlyphID(iIndex+1);
                                             GsubMsg+='->'+%Char(wk.glyf(iUni));
E10                                     Endsl;
E09                               Endsl;
E08                            Endif;


E07                         Endfor ;   //?iSubSubTable
                            pSubstLookupRecord +=%Size(SubstLookupRecord);
E06                      Endfor;   //?iLookupList
E05                   Endif ;   //?ApplyClassRule

E04                Endfor;   //?for isubclassrule

E03             Endif;   //?If Context2.SubClassSet
E02          Endif;   //?In iClassRange




















E01    Endsl;   //?SubstFormat
E00    Endsr;
       //?---------------------------------------------------------------
B00    Begsr *pssr;
          message('TRC0003':psds:'JPLTOOLS':'JPLTOOLS');
E00    Endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
    ?p*CheckBC         b
    ?d*CheckBC         pi
    ?d*  fromglyf                     5u00
    ?d*  toglyf                       5u00
    ?d*  thefont                           likeds(pdffont)
    ?d*=----------------------------------
    ?d*  fromUni       s              5u00
    ?d*  toUni         s              5u00
    ? *free
    ? *fromUni=thefont.G2u( fromglyf );
    ? *toUni=thefont.G2u( toglyf );
    ? *//?corriger le BC du caractère substitué
    ? *thefont.bc( toUni )= thefont.bc( fromUni );
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *end-free
    ?p*CheckBC         e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p getbytes        b
     d getbytes        pi
     d   mem                           *   value
     d   ifs                               likeds(ifs_t)
     d   pos                         10i 0 const
     d   len                         10i 0 const

     d ttf0001         ds                  qualified
     d   name                       500
     d   size                        10i 0
     d   pos                         10i 0
     d   len                         10i 0

      /free
B01    If Pos+len >ifs.AsciiTo;
          ttf0001.name = ifs.name;
          ttf0001.size = ifs.AsciiTo;
          ttf0001.Pos = Pos;
          ttf0001.len = len;
          Message('TTF0001': ttf0001 :'':'':'*ESCAPE':'*': 2);
E01    Endif;
       ifs.AsciiRead =Pread (ifs.FileHandleA: mem : len : Pos ) ;
B01    If ifs.AsciiRead < 0;
          Message(Errnomsg(Errno()):'':'':'QCPFMSG':'*ESCAPE':'*': 2);
E01    Endif;
       Return ;
B00    Begsr *pssr;
B01    If Needdump;
          Dumpcallstack();
          Needdump=False;
E01    Endif;
E00    Endsr;
      /end-free
EPR  p                 e
    ? * = ------------------------------------------------------------------------
      /endif











