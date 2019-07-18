      * sql typing to rpg : http://www.itjungle.com/fhg/fhg031704-story02.html
      *       * Numeric Definitions
      *      D SmallInteger    S              5I 0
      *      D SmallInteger    S              4B 0
      *      D Integer         S             10I 0
      *      D Integer         S              9B 0
      *      D BigInteger      S             20I 0
      *      D Decimal         S             31P 9
      *      D Numeric         S             31S 9
      *      D Float_Single    S              4F
      *      D Float_Double    S              8F
     H DEBUG DATEDIT(*YMD)
     H NoMain
     h copyright('Author is Jean-Paul Lamontre')
     D N2Date          PR              D
     D   num                         20i 0 CONST
     D   format                      10    CONST varying
     d   nullin                       4b 0 dim(2)
     d   nulldate                     4b 0
     D x2Date          PR              D
     D   car                         10    CONST varying
     D   format                      10    CONST varying
     d   nullin                       4b 0 dim(2)
     d   nulldate                     4b 0
     d message         pr
     d    msgno                       7    const         options(*omit)         n[
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
     d PmqPgm          s             10
     D die             Pr
     D    msg                       256A   const

       //?si la date (IN ou OUT) est hors domaine SQL (1940-01-01 2039-12-31)
       //?SQL se charge de retourner une erreur.


       //?convertir une zone numérique contenant une date *YYMD dans une date
BPR  P N2Date          B                   export
     D N2Date          PI              d
     D  In8                          20i 0 const
     D  FMT                          10    const VARYING
     D  InIsNull                      4b 0 dim(2)
     D  DateIsNull                    4b 0
     D  TheDate        s               d
     D  Num8           s              8S 0
     D  format         s             10
       //?table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
       //?table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')

      /FREE
       DateIsNull = 0;
       //?default for input value
B01    if InIsNull(1) >= 0;
          num8 = In8;
X01    else;
          num8 = 19400101;
E01    endif;
       //?default for format
B01    if InIsNull(2) >= 0;
          format = fmt;
X01    else;
          format = '*ISO';
E01    endif;
       // inz outvalues
          DateIsNull = -1;
          thedate=d'1940-01-01';
       //?convert the value
       format=%xlate(up:lo: format);
B01    select;
X01       when format='*ymd';
          test(de) *ymd num8;
          if %error();
          exsr incorrectdate;
          return TheDate;
          else;
             TheDate=%date(num8:*ymd );
             endif;
X01       when format='*dmy';
             TheDate=%date(num8:*dmy );
X01       when format='*mdy';
             TheDate=%date(num8:*mdy );
X01       when format='*jul';
             TheDate=%date(num8:*jul );
X01       when format='*cymd';
             TheDate=%date(num8:*cymd );
X01       when format='*cdmy';
             TheDate=%date(num8:*cdmy );
X01       when format='*cmdy';
             TheDate=%date(num8:*cmdy );
X01       when format='*iso';
             TheDate=%date(num8:*iso );
X01       when format='*usa';
             TheDate=%date(num8:*usa );
X01       when format='*eur';
             TheDate=%date(num8:*eur );
X01       when format='*jis';
             TheDate=%date(num8:*jis );
X01       when format='*longjul';
             TheDate=%date(num8:*longjul );
X01       other;
             TheDate=%date(num8:*iso );
E01    endsl;
          DateIsNull =  0;
       return TheDate;
         begsr incorrectdate;
         message ('':%char(num8) + ' is not a ' + %trim(format) + ' date');
E01    endsr;
B01    begsr *PSSR;
          DateIsNull = -1;
          thedate=d'1940-01-01';
          return TheDate;
E01    endsr;
      /END-FREE
EPR  P N2Date          E

       //?convertir une zone alpha     contenant une date *YYMD dans une date
BPR  P x2Date          B                   export
     D x2Date          PI              d
     D  alpha                        10    const varying
     D  FMT                          10    const VARYING
     D  InIsNull                      4b 0 dim(2)
     D  DateIsNull                    4b 0
     D  TheDate        s               d
     d  x10            s             10
     D  format         s             10
       //?table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
       //?table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')

      /FREE
       DateIsNull = 0;
       //?default for input value
B01    if InIsNull(1) >= 0;
          x10 = alpha;
X01    else;
          x10  ='1940-01-01';
E01    endif;
       //?default for format
B01    if InIsNull(2) >= 0;
          format = fmt;
X01    else;
          format = '*ISO';
E01    endif;
       //?convert the value
       format=%xlate(up:lo: format);
B01    select;
X01       when format='*ymd';
             TheDate=%date( x10:*ymd );
X01       when format='*dmy';
             TheDate=%date( x10:*dmy );
X01       when format='*mdy';
             TheDate=%date( x10:*mdy );
X01       when format='*jul';
             TheDate=%date( x10:*jul );
X01       when format='*cymd';
             TheDate=%date( x10:*cymd );
X01       when format='*cdmy';
             TheDate=%date( x10:*cdmy );
X01       when format='*cmdy';
             TheDate=%date( x10:*cmdy );
X01       when format='*iso';
             TheDate=%date( x10:*iso );
X01       when format='*usa';
             TheDate=%date( x10:*usa );
X01       when format='*eur';
             TheDate=%date( x10:*eur );
X01       when format='*jis';
             TheDate=%date( x10:*jis );
X01       when format='*longjul';
             TheDate=%date( x10:*longjul );
X01       when format='*ymd0';
             TheDate=%date( x10:*ymd0);
X01       when format='*dmy0';
             TheDate=%date( x10:*dmy0);
X01       when format='*mdy0';
             TheDate=%date( x10:*mdy0);
X01       when format='*jul0';
             TheDate=%date( x10:*jul0);
X01       when format='*cymd0';
             TheDate=%date( x10:*cymd0);
X01       when format='*cdmy0';
             TheDate=%date( x10:*cdmy0);
X01       when format='*cmdy0';
             TheDate=%date( x10:*cmdy0);
X01       when format='*iso0';
             TheDate=%date( x10:*iso0);
X01       when format='*usa0';
             TheDate=%date( x10:*usa0);
X01       when format='*eur0';
             TheDate=%date( x10:*eur0);
X01       when format='*jis0';
             TheDate=%date( x10:*jis0);
X01       when format='*longjul0';
             TheDate=%date( x10:*longjul0);
X01       other;
             TheDate=%date( x10:*iso );
E01    endsl;
       return TheDate;
B01    begsr *PSSR;
          DateIsNull = -1;
          thedate=d'1940-01-01';
          return TheDate;
E01    endsr;
      /END-FREE
EPR  P x2Date          E


BPR  p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n[
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE
     d  p_msgtype                    10    const         options(*nopass)       *DIAG
     d  p_msgcse                     10    const         options(*nopass)       call stack entry
     d  p_msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d  p_msgkey                      4                  options(*nopass)       message key
    ? * prototype de QMHSNDMPM
    ? *  Required Parameters Group:
    ? *   1 Message identifier Input Char(7)
    ? *   2 Qualified message file name Input Char(20)
    ? *   3 Message data or immediate text Input Char(*)
    ? *   4 Length of message data or immediate text Input Binary(4
    ? *   5 Message type Input Char(10)
    ? *   6 Call stack entry Input Char(*) or Pointer
    ? *   7 Call stack counter Input Binary(4)
    ? *   8 Message key Output Char(4)
    ? *   9 Error code I/O Char(*)
    ? *  Optional Parameter Group 1:
    ? *   10 Length of call stack entry Input Binary(4)
    ? *   11 Call stack entry qualification Input Char(20)
    ? *   12 Display program messages screen wait time Input Binary
    ? *  Optional Parameter Group 2:
    ? *   13 Call stack entry data type Input Char(10)
    ? *   14 Coded character set identifier Input Binary(4)
    ? *  Threadsafe: Yes
     d qmhsndpm        pr                  extpgm('QMHSNDPM')
     d    msgno                       7      const
     d    msgf                       20      const
     d    msgdata                  6000      const
     d    msgdatalen                  9b 0   const
     d    msgtype                    10      const
     d    stackentry                 10      const
     d    stackcount                  9b 0   const
     d    msgkey                      4      const
     d    errorhandle               255
    ?D* ERROR CODE HANDLING FIELDS
     D ECH             DS           255
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZON
     D  ECH02                  5      8B 0                                      lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERRE
     D  ECH5A                 17    117
     d  w_msgno        s              7
     d  w_msgflib      s             10    inz('*LIBL')
     d  w_msgffile     s             10    inz(MessageFile)
     d  w_msgdata      s           6000    varying inz('')
     d  w_msgtype      s             10    inz('*DIAG')
     d  w_msgcse       s             10    inz('*')
     d  w_msgcsc       s              4B 0 inz(1)
     d  w_msgkey       s              4    inz(*blank)
     d MessageFile     c                   'QCPFMSG'
      /free
B01    if %parms >= 7 ;
          eval w_msgcsc = p_msgcsc ;
E01    endif ;
B01    if %parms >= 6 ;
          eval w_msgcse = p_msgcse ;
E01    endif ;
B01    if %parms >= 5 ;
          eval w_msgtype = p_msgtype ;
E01    endif ;
B01    if %parms >= 4 ;
          eval w_msgffile = p_msgffile ;
E01    endif ;
B01    if %parms >= 3 ;
          eval w_msgflib = p_msgflib ;
E01    endif ;
B01    if %parms >= 2 ;
          eval w_msgdata = p_msgdata ;
E01    endif ;
B01    if %addr(p_msgno) <> *null ;
          eval w_msgno = p_msgno ;
E01    endif ;
B01    if w_msgflib = '' ;
          w_msgflib = '*LIBL';
E01    endif;
B01    if    w_msgffile = '' ;
          w_msgffile =MessageFile ;
E01    endif;
B01    if    w_msgtype  = '' ;
          w_msgtype = '*DIAG'       ;
E01    endif;
B01    if    w_msgcse   = '' ;
          w_msgcse  = '*'            ;
E01    endif;
B01    if w_msgcsc = 0 ;
          w_msgcsc = 2 ;
E01    endif;
       CALLp QMHSNDPM ( w_msgno
          : w_msgffile + w_msgflib
          : w_msgdata
          : %len(w_msgdata)
          : w_msgtype
          : w_msgcse
          : w_msgcsc
          : w_msgkey
          : ECH ) ;
B01    IF ech03 <> *BLANK ;
          dump ;
          callp     die('ERR S/QMHSNDPM, look at ECH03')   ;
E01    ENDIF ;
B01    if %parms >= 8 ;
          eval p_msgkey = w_msgkey ;
E01    endif ;
B01    begsr *pssr ;
          dump ;
E01    endsr ;
      /end-free
EPR  p message         e

BPR  P die             B
     D die             PI
     D    msg                       256A   const
     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                  256A
     D dsEC            DS
     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
     D  dsECBytesA             5      8I 0 inz(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
     D MsgLen          S             10I 0
     D TheKey          S              4A
     c     ' '           checkr    msg           MsgLen
B01  c                   if        MsgLen<1
    ?c*                  return    *off
E01  c                   endif
     c                   callp     QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL':
     c                               Msg: MsgLen: '*ESCAPE':
     c                               '*': 1: TheKey: dsEC)
    ?c*                  return    *off
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  P                 E
