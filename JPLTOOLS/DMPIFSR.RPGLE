    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
      /define INFDS
    ? /define IFS






     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION
     FQSYSPRT   O    F  198        PRINTER OFLIND(*INOF)

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
    ?
    ?
    ?











     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? * exemple :
    ? *d rc              s              9b 0
    ? *         rc =  c_system(cmde );
    ? *         if rc <> 0;
    ? *         dsply msgid;
    ? *         endif;



     d rc              s             10i 0
     d errcpe          ds
     d cpetxt                         3    inz('CPE')
     d cpenum                         4s 0
     D FileHandleA     s             10i 0
     D FileHandleE     s             10i 0
     D ASCIIData       s             50
     D Hexa_Data       ds           100
     d sbHex1                        10
     d sbHex2                        10
     d sbHex3                        10
     d sbHex4                        10
     D iConvData       ds            50
     d iData                          1    dim(50)
     D BytesIn         S             10i 0
     D curPos          S             10i 0
     d AtEof           s               n
     d hexa            pr         30000    varying
     d  txt                       15000    varying const

    ? * pour opendir

     D pathdir         S            500    varying
     D pathdirs        S            500
     D pathfile        S            500    varying
     D pathfiles       S            500
     D pathp           S               *   INZ
     D diropn          S             10I 0
     D diropnp         S               *   INZ
    ? * pour readdir
     Dentry            ds                  BASED(entryp)
     D  reserv1                      16
     D  filenogenid                  10U 0
     D  fileno                       10U 0
     D  reclen                       10U 0
     D  reserv3                      10I 0
     D  reserv4                       8A
     D  ccsid                        10I 0
     D  countryid                     2A
     D  langid                        3A
     D  nlsreserv                     3A
     D  namelen                      10I 0
     D  namedir                     256
     D entryp          S               *
     Dname             s            500    varying
     Dnamefile         s            500    varying
    ? *
    ? * pour stat  - attributs du fichier *stmf
     Dattr             ds                  likeds(statds)
    ? *
     Dnomifs           s            256
     Dstatp            S               *   INZ
     Dpathtot          s            256
     Dpathtotp         s               *   INZ
     Dpathtotlg        s              4  0
     Dperrorp          s               *   INZ
     Dperrordta        s             20    INZ('path() error')


    ? * HERE program name & parameters
     d dmpifsr         pr
    ?d  FaIfs                        80
     d dmpifsr         pi
    ?d  FaIfs                        80

      /free
             dow 1=1;
                //?check           ?
                rc = access(%trim(faifs ): F_OK);
B03             if (rc <> 0);
                   cpenum=errno ;
                   message(errcpe:'':'':'QCPFMSG');
                   leave;
E03             endif;
        except entete;
       FileHandleE= open( %trim(faIFS)
          : O_TEXTDATA + O_RDONLY ) ;
B01    if filehandleE= -1;
          cpenum= errno();
          message(errcpe:'':'':'QCPFMSG');
          leave;
E01    endif;
       FileHandleA= open( %trim(faIFS)
          : O_RDONLY ) ;
B01    if filehandleA= -1;
          cpenum= errno();
          message(errcpe:'':'':'QCPFMSG');
          leave;
E01    endif;
       ateof=false;
B01    dow ateof=false;  //main loop
                iConvData = *allx'00';
                AsciiData = *allx'00';
                BytesIn =pread (FileHandleE: %addr(iConvData) : 50 :curpos) ;
                BytesIn =pread (FileHandleA: %addr(AsciiData) : 50 :curpos) ;

B03             if bytesin < 50;
                   ateof = true;
E03             endif;

                hexa_data = hexa(asciidata);
B03             for iFor = 1 to 20;
B04                if idata(ifor) < x'40';
                      idata(ifor) = '.';
E04                endif;
E03             endfor;
B03             if bytesin < 50;
                   %subst(hexa_data : bytesin  * 2 +1) = *all'_';
                   %subst(iConvData : bytesin +1) = *blank ;
E03             endif;
                except hexaout;
                curpos +=bytesin;
E01    enddo ;
       leave;
E01    enddo ;
       Rc = close(FileHandleE) ;
       Rc = close(FileHandleA) ;
       except pied;
       *inlr = *on ;

       //?---------------------------------------------------------------
       //?begsr        ;



       //?endsr;
       //?---------------------------------------------------------------
       /end-free
    ? *----------------------------------------------------------------
    ? * *inzsr, sr pmqsnd, sp *pssr , ...
    ? *----------------------------------------------------------------

      /DEFINE PSSR
      /free
       begsr *pssr ;
        dump ;



        endsr '*CANCL';
      /end-free
      /define INZSR
     C     *INZSR        BEGSR








     C                   ENDSR












     OQSYSPRT   E            ENTETE      1  1  2
     O                                              'DMPIFS'
     O                       *DATE         Y   +010
     o                       faifs             +001
     O          E            PIED
     O                                           40 '====end of dmpifs===='
     O          E            hexaout
     O                       hexa_data
     O                       iconvdata           +1
EPR   /free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
      /end-free
BPR  P hexa            b
     d hexa            pi         30000    varying
     d  txt                       15000    varying const
     d  i              s              5u 0
     d  hex            s          30000    varying
     d  h              ds             2
     d  h1                     1      1i 0
     d  h2                     2      2i 0
     d  c                      1      1
     d  h12                    1      2i 0
     d  x12                    1      2
     d  w12            s              2
      /free
B01    for i = 1 to %len(txt);
          h12 = 0;
          c = %subst(txt:i:1);
          h12=h12/ 16;
          h2 =h2 / 16;
          w12 = x12;
          x12 = %bitand(x12:x'0F0F');
B02       select;
X02          when h1 = 0;
                hex +='0';
X02          when h1 = 1;
                hex +='1';
X02          when h1 = 2;
                hex +='2';
X02          when h1 = 3;
                hex +='3';
X02          when h1 = 4;
                hex +='4';
X02          when h1 = 5;
                hex +='5';
X02          when h1 = 6;
                hex +='6';
X02          when h1 = 7;
                hex +='7';
X02          when h1 = 8;
                hex +='8';
X02          when h1 = 9;
                hex +='9';
X02          when h1 =10;
                hex +='A';
X02          when h1 =11;
                hex +='B';
X02          when h1 =12;
                hex +='c';
X02          when h1 =13;
                hex +='D';
X02          when h1 =14;
                hex +='E';
X02          when h1 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
B02       select;
X02          when h2 = 0;
                hex +='0';
X02          when h2 = 1;
                hex +='1';
X02          when h2 = 2;
                hex +='2';
X02          when h2 = 3;
                hex +='3';
X02          when h2 = 4;
                hex +='4';
X02          when h2 = 5;
                hex +='5';
X02          when h2 = 6;
                hex +='6';
X02          when h2 = 7;
                hex +='7';
X02          when h2 = 8;
                hex +='8';
X02          when h2 = 9;
                hex +='9';
X02          when h2 =10;
                hex +='A';
X02          when h2 =11;
                hex +='B';
X02          when h2 =12;
                hex +='c';
X02          when h2 =13;
                hex +='D';
X02          when h2 =14;
                hex +='E';
X02          when h2 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
E01    endfor;
       return hex;
      /end-free
    ?C*=------------------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 e
