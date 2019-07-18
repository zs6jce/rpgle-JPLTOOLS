    ? * CRTSQLRPGI OBJ(ECOLIB/EXECUTESQR) SRCFILE(ECOLIB/QPGMSRC) COMMIT(*NONE) OBJTYPE(*MODULE)
    ? * OUTPUT(*PRINT) OPTION(*NOSEQSRC *XREF *SECLVL) CLOSQLCSR(*ENDMOD) REPLACE(*YES)
    ? * SQLPATH(*LIBL) DBGVIEW(*SOURCE) TOSRCFILE(ECOLIB/QSQLSRC)
    ? *
    ? * CRTPGM PGM(ECOLIB/EXECUTESQR)
    ? *
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
     D EscSqlEr        Pr
     D   sqlcod                       9b 0 const
     d message         pr
     d    msgno                       7    const         options(*omit)         n°
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
     d MessageFile     c                   'JPLTOOLS'
     D die             Pr
     D    msg                       256A   const

    ? * parametres du programme
     d executesqr      pr
     d  mySQL                      5000
     d executesqr      pi
     d  mySQL                      5000
      /free
         EXEC SQL
            Set Option Commit = *none
            , CloSQLCsr = *ENDACTGRP
            , DatFmt = *ISO
            , TimFmt = *ISO
            , Naming = *SYS
            , SqlPath= *LIBL
            ;
       message(*blank : mySQL:'':'':'*INFO');

       EXEC SQL
        prepare somesql from : mySQL
       ;

B01    if sqlcod<>0;
          message('SQL8888' :sqlca);
          callp escsqler (sqlcod);
E01    endif;

       EXEC SQL
        execute somesql
       ;

       message('SQL8888' :sqlca);
B01    if sqlcod<>0;
          callp escsqler (sqlcod);
E01    endif;
       *inlr = *on;

B01    begsr *PSSR ;
          DUMP ;
E01    ENDSR     '*CANCL'   ;

      /end-free
    ? *=------------------------------------------------------------------------------------------
    ? *
    ? *=------------------------------------------------------------------------------------------
BPR  P EscSqlEr        B
     D EscSqlEr        PI
     D   pa_cod                       9b 0 const
     D   sqlcod        ds
     D   sqlcod3                      3
     D   sqlcod4                      4s 0

     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                      1A   Const
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

     D TheKey          S              4A
     D MsgID           S              7A
      /free
B01    if pa_cod < 0 ;
          eval sqlcod4= - pa_cod ;
X01    else ;
          eval sqlcod4= pa_cod ;
E01    endif ;
       sqlcod3 = 'SQL';
       msgid=sqlcod;

       QMHSNDPM(MsgID: 'QSQLMSG   *LIBL':
          ' ': 0: '*ESCAPE':
          '*': 3: TheKey: dsEC)              ;

       //?*                  return    *off
       /end-free
EPR  P                 E
    ? *=------------------------------------------------------------------=*
BPR  p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n°
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
    ? *
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
    ?D********************
    ?D*
    ?D* ERROR CODE HANDLING FIELDS
    ?D*
    ?D********************
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
     d  w_msgcsc       s              4B 0 inz(2)
     d  w_msgkey       s              4    inz(*blank)
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
      /free

       callp QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL':
          Msg: MsgLen: '*ESCAPE':'*': 1: TheKey: dsEC) ;

B01    BEGSR *PSSR ;
          DUMP ;
E01    ENDSR ;
       /end-free
EPR  P                 E
