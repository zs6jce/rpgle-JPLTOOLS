     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define IFS
      /define LOWERCASE
      /define CSYSTEM
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
     D FileName        s            512a   varying
     D BIN2B64         pr
     D B642BIN         pr



     d base64r         pr
     d fromifs                      255
     d toifs                        255
     d type                           7

     d base64r         pi
     d fromifs                      255
     d toifs                        255
     d type                           7


      /free
       *inlr = *on;
       useerrno();
B01    Select ;
X01       When type='*BASE64';
             B642BIN();
X01       When type='*BIN   ';
             BIN2B64();
E01    Endsl;




      /define PSSR
B01    Begsr *pssr ;
B02       If needdump;
             dumpcallstack();
             Dump ;
             needdump=false;
E02       Endif;
E01    Endsr '*CANCL';
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
    ? *=---------------------------------------------------------------=*

    ? *=---------------------------------------------------------------=*
    ? *  BASE64 conversion- How it works
    ? *
    ? *  1. Read IFS file (UNIX-type APIs)
    ? *  2. Split the read 'string' into 3 byte chunks.
    ? *  3. Each chunk has to be converted as follow:
    ? *     Split 24 bits of the chunk into four 6bit binary numbers,
    ? *     convert each number to decimal and using the table below
    ? *     assign a character to the number.
    ? *      ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef
    ? *      ghijklmnopqrstuvwxyz0123456789+/
    ? *
    ? *  A is character for weight 0, B for 1,...,/ for 63.
    ? *  4. Last chunk of the file may not be 3 bytes; if so:
    ? *     For 1 byte chunk return two converted characters
    ? *     and '==', for 2 byte chunk return 3 converted characters
    ? *     and '='.
    ? *
    ? *  5. Each output record cannot exceed 76 char
    ? *
    ? *=====================================================================
    ? *   position IN data  :01234567.01234567.01234567.
    ? *   Value             :abcdefgh ijklmnop qrstuvwx
    ? *
    ? *   position OUT data :01234567.01234567.01234567.01234567.
    ? *   index value in B64:00abcdef 00ghijkl 00mnopqr 00stuvwx
    ? *
    ? *==================================================================

    ? *  Copy a binary file to a text file using BASE64 conversion


BPR ?P bin2B64         b
     D                 pi

    ? *==================================================================
     d FromFileHandle  s             10i 0
     d ToFileHandle    s             10i 0
     d rc              s             10i 0
     D InputHand       s             10i 0
     d cvtbase64       ds
     d b64                            1    dim(64)
     D cvtTable                      64a   inz('ABCDEFGHIJKLMNOPQRSTUVWXYZabcde+
     D                                     fghijklmnopqrstuvwxyz0123456789+/')
     d In              ds             4
     d in1u                           3u00
     d in234                          3a
     d   in2a                         1    overlay(in234)
     d   in3a                         1    overlay(in234:*next)
     d   in4a                         1    overlay(in234:*next)
     d in4u                          10u00 overlay(in)
     d Out             ds             4
     d out1a                          1
     d out2a                          1
     d out3a                          1
     d out4a                          1
     d MimeOut         s              3u00
     D BytesIn         s             10i 0
     D BytesOut        s             10i 0

      /free
       cvtbase64 = cvtTable;
       //?*  Open INPUT BINARY file
       //?*  for binary process
       InputHand = Open(%Trim(fromifs )
          : o_rdonly) ;
B01    If InputHand < 0;

          escerrno(errno);

E01    Endif;


       //?open Outputfile
       FileName = %Trim(toifs );
       //?delete the file
       rc= unlink (FileName );
B01    If rc <> 0;
B02       If errno <> 3025;
             escerrno(errno);
E02       Endif;
E01    Endif;
       //?create a file & declare implicit code page converter
       ToFileHandle = Open(FileName
          : o_creat + o_wronly + o_trunc + o_codepage
          : s_irwxu + s_iroth
          : cp_iso8859_1 ) ;
B01    If ToFileHandle = -1;
          escerrno(errno);
E01    Endif;
       //?close the file to be able
       Rc = close(  toFileHandle) ;
       //?to reopen it with O_TEXTDATA flag, the ones that controls code page convertion
         toFileHandle = open(FileName
          : O_TEXTDATA + O_RDWR + O_APPEND) ;





       MimeOut = 0;
B01    For ever;
          //?* Copy converting data
          BytesIn = Read(InputHand
             : %Addr(in234 )
             : 3 ) ;
B02       If BytesIn<= 2;
             in4a=x'00';
E02       Endif;
B02       If BytesIn<= 1;
             in3a= x'00';
E02       Endif;
          in1u=0;
          in4u*=64;
          out1a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out2a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out3a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out4a= b64(in1u+1);

B02       If BytesIn<= 2;
             out4a= '=';
E02       Endif;
B02       If BytesIn<= 1;
             out3a= '=';
E02       Endif;

          BytesOut = Write( ToFileHandle
             : %Addr(Out )
             : 4 ) ;

          MimeOut+=BytesOut ;
B02       If MimeOut>=76;
             BytesOut=Write( ToFileHandle: crlf : 2);
             MimeOut=0;
E02       Endif;
B02       If BytesIn < 3;
             Leave;
E02       Endif;
E01    Endfor ;
       //?* Close the files
       rc = Close(InputHand) ;
       rc = Close(ToFileHandle);
       Return ;

B01    Begsr *pssr;
B02       If needdump;
             dumpcallstack();
             Dump ;
             needdump=false;
E02       Endif;

E01    Endsr;
    ? /end-free
EPR  P                 e
    ? *==================================================================


BPR ?P B642bin         b
     D                 pi

    ? *==================================================================
     d FromFileHandle  s             10i 0
     d ToFileHandle    s             10i 0
     d rc              s             10i 0
     D InputHand       s             10i 0
     d cvtbase64       ds
     d b64                            1    dim(64)
     D cvtTable                      64a   inz('ABCDEFGHIJKLMNOPQRSTUVWXYZabcde+
     D                                     fghijklmnopqrstuvwxyz0123456789+/')
     d In              ds             4
     d in234                          3a   overlay(in:1)
     d   in2a                         1    overlay(in234)
     d   in3a                         1    overlay(in234:*next)
     d   in4a                         1    overlay(in234:*next)
     d in1u                           3u00 overlay(in:4)
     d in4u                          10u00 overlay(in)
     d Out             ds             4
     d out1a                          1
     d out2a                          1
     d out3a                          1
     d out4a                          1
     d MimeIn          s              3u00
     D BytesIn         s             10i 0
     D BytesOff        s             10i 0
     D BytesOut        s             10i 0

      /free
       cvtbase64 = cvtTable;
       //?*  Open INPUT BINARY file
       //?*  for binary process
       InputHand = Open(%Trim(fromifs )
          : o_rdonly + o_textdata );



B01    If InputHand < 0;

          escerrno(errno);

E01    Endif;


       //?open Outputfile
       FileName = %Trim(toifs );
       //?delete the file
       rc= unlink (FileName );
B01    If rc <> 0;
B02       If errno <> 3025;
             escerrno(errno);
E02       Endif;
E01    Endif;
       //?create a file & declare implicit code page converter
       ToFileHandle = Open(FileName
          : o_creat + o_wronly + o_trunc + o_codepage
          : s_irwxu + s_iroth
          : cp_iso8859_1 ) ;
B01    If ToFileHandle = -1;
          escerrno(errno);
E01    Endif;
       // l'outfile est en binaire !!
       //  //?close the file to be able
       //  rc = Close( ToFileHandle) ;
       //  //?to reopen it with O_TEXTDATA flag, the ones that controls code page convertion
       //  ToFileHandle = Open(FileName
       //     //?: O_RDWR + O_APPEND) ;
       //     : o_textdata + o_rdwr + o_append) ;




       MimeIn = 0;
B01    For ever;
          //?passer les crlf
B02       If MimeIn >= 76;
B03          For ever;
                //?read one character, don't move the file pointer position
                BytesIn =pread(InputHand
                   : %Addr(Out )
                   : 1
                   :bytesoff    );
B04             If BytesIn = 0;
                   Leave;
E04             Endif;


                //?cr or lf ? read again
B04             If out1a=x'0D' Or out1a=x'25';
                   BytesIn = Read(InputHand
                      : %Addr(Out )
                      : 1 ) ;
B05                If BytesIn = 0;
                      Leave;
E05                Endif;
                   MimeIn +=BytesIn;
                   BytesOff +=BytesIn;
X04             Else;
                   MimeIn=0;
                   Leave;
E04             Endif;
E03          Endfor;
E02       Endif;
          //?* Copy converting data
          BytesIn = Read(InputHand
             : %Addr(Out )
             : 4 ) ;
B02       If BytesIn = 0;
             Leave;
E02       Endif;
          MimeIn +=BytesIn;
          BytesOff +=BytesIn;

          in4u=0;
          in1u=%Scan(out1a:cvtbase64) - 1;
          in1u*=4;
          in4u*=64;
          in1u=%Scan(out2a:cvtbase64) - 1;
          in1u*=4;
          in4u*=64;
B02       If out3a = '=';
             in1u=0;
             BytesIn -= 1;
X02       Else;
             in1u=%Scan(out3a:cvtbase64) - 1;
E02       Endif;
          in1u*=4;
          in4u*=64;
B02       If out4a = '=';
             in1u=0;
             BytesIn -= 1;
X02       Else;
             in1u=%Scan(out4a:cvtbase64) - 1;
E02       Endif;
          in1u*=4;
          in4u*=64;

             BytesIn -= 1;

          BytesOut = Write(ToFileHandle
             : %Addr(in234 )
             : BytesIn ) ;

B02       If BytesOut< 3;
             Leave;
E02       Endif;
E01    Endfor ;
       //?* Close the files
       rc = Close(InputHand) ;
       rc = Close(ToFileHandle);
       Return ;

B01    Begsr *pssr;
B02       If needdump;
             dumpcallstack();
             Dump ;
             needdump=false;
E02       Endif;

E01    Endsr;
    ? /end-free
EPR  P                 e
    ? *==================================================================


