      *  ADDEXITPGM   EXITPNT(QIBM_QCA_RTV_COMMAND)
      *               FORMAT(RTVC0100)
      *               PGMNBR(*LOW)
      *               PGM(JPLTOOLS/EXITRTVCMD)
      *               TEXT('try the exit point')
      *               REPLACE(*NO)
      *               PGMDTA(*JOB 20 'RTVEXIT   JPLTOOLS')
      *
      *
      *
  18 H ALWNULL(*USRCTL)
1059  *    -----------------------------------------------------------------
1060  *    http://publib.boulder.ibm.com/infocenter/iseries/v6r1m0/index.jsp?topic=/apis/xcartv.htm
1061  *    -----------------------------------------------------------------
     d rtvc0100_t      ds          6100    qualified
     d Point                         20
     d Format                         8
     d Cmd                           10
     d Cmdlib                        10
     d                                4
     d Offset                        10i 0
     d Length                        10i 0

     d CmdString       s           6000    based(pCmdString)


 790+d psds           sds                  qualified
 791+d  program          *proc
 792+d  status                11     15
 793+d  prevStatus            16     20
 794+d  SrcStmt               21     28
 795+d  Routine          *routine
 796+d  parms            *parms
 797+d  msgid                 40     46
 798+d  pgmlib                81     90
 799+d  msgdta                91    170
 800+d  rnx9001except        171    174
 801+d  FileInError          175    184
 802+d  StartDate            191    198
 803+d  FileStatus           209    243
 804+d    fstatus            209    213
 805+d    fopcode            214    219
 806+d    froutine           220    227
 807+d    fstatement         228    230
 808+d    frecord            231    243
 809+d    frnb               236    243
 810+d  JobName              244    253
 811+d  JobUser              254    263
 812+d  JobNbr               264    269
 813+d  JobNbr0              264    269s00
 814+d  StartTime            282    287
 815+d  CompileDate          288    293
 816+d  CompileTime          294    299
 817+d  CompileLevel         300    303
 818+d  CompileSrcFil        304    313
 819+d  CompileSrcLib        314    323
 820+d  CompileSrcMbr        324    333
 821+
 822+d  pgm                  334    343a
 823+d  mod                  344    353a
 824+d  SourceId1            354    355i00
 825+d  SourceId2            356    357i00
 826+d  CurrentUser          358    367a
 827+d  ExtError             368    371i00
 828+d  XmlElement           372    379i00
 829+d  TheEnd               380    429
 830+
 831+ * definitions avec des noms courts, pour le code en RPG pas free
 832+ * le nom doit tenir dans 14 car, Moins PSDS., reste 10
 833+d  CurUser              358    367a
 834+
     d true            s               n   inz(*on )
     d false           s               n   inz(*off)

    ? *-------------------------------------------------------------------------------------------
    ? * send a message
    ? *-------------------------------------------------------------------------------------------
     d message         pr
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE
     d  p_msgtype                    10    const         options(*nopass)       *DIAG
     d  p_msgcse                     20    const         options(*nopass)       call stack entry
     d  p_msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d  p_msgkey                      4                  options(*nopass)       message key

     d i               s              5i 0



 694+  // ECH Error Code Handler
 697+D  ErrorCode      DS                  qualified
 698+D  provided               1      4B 0 INZ(%size(errorcode))                LONGUEUR DE LA ZON
 699+D  available              5      8B 0 inz(0)                               lng DE LA REPONSE
 700+D  msgid                  9     15                                         NUMERO DE L'ERREUR
 701+D  msgdta                17    255                                         MSGDTA POUR L'ERRE

1068 d exitrtvcmd      pr                  extpgm('EXITRTVCMD')
1069 d  rtvc0100                           likeds(rtvc0100_t)
1076 d exitrtvcmd      pi
1069 d  rtvc0100                           likeds(rtvc0100_t)
1083
1089  /free
1090   Monitor;
        pcmdstring = %addr(rtvc0100)+rtvc0100.offset;
        message('':%subst(cmdstring:1:rtvc0100.length));
1120         Return;
1149   On-error;
1150
1151   Endmon;
1153   Return;
1226+ /end-free
    ? *-------------------------------------------------------------------------------------------
    ? * message
    ? *-------------------------------------------------------------------------------------------
BPR ?p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE
     d  p_msgtype                    10    const         options(*nopass)       *DIAG
     d  p_msgcse                     20    const         options(*nopass)       call stack entry
     d  p_msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d  p_msgkey                      4                  options(*nopass)       message key
     d Pos             s              5u 0
     d msgqlib         s             10
     d msgqnam         s             10
     d  w_msgno        s              7
     d  w_msgflib      s             10    inz('*LIBL')
     d  w_msgffile     s             10    inz('')
     d  w_msgdata      s           6000    varying inz('')
     d  w_msgtype      s             10    inz('*DIAG')
     d  w_msgcse       s             20    inz('*')
     d  w_msgcsc       s              4B 0 inz(-1)
     d  w_msgkey       s              4    inz(*blank)
    ? *-------------------------------------------------------------------------------------------
    ? * QMHSNDPM
    ? *-------------------------------------------------------------------------------------------
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
    ? *-------------------------------------------------------------------------------------------
    ? * error code handler
    ? *-------------------------------------------------------------------------------------------
     d  ErrorCode...
     D                 DS                  qualified
     D  provided               1      4B 0 INZ(%size(errorcode))                LONGUEUR DE LA ZON
     D  available              5      8B 0 inz(0)                               lng DE LA REPONSE
     D  msgid                  9     15                                         NUMERO DE L'ERREUR
     D  msgdta                17    255                                         MSGDTA POUR L'ERRE
1893+ /free
B01    if %Parms >= 7 ;
          Eval w_msgcsc = p_msgcsc ;
E01    Endif ;
B01    if %Parms >= 6 ;
          Eval w_msgcse = p_msgcse ;
E01    Endif ;
B01    if %Parms >= 5 ;
          Eval w_msgtype = p_msgtype ;
E01    Endif ;
B01    if %Parms >= 4 ;
          Eval w_msgffile = p_msgffile ;
E01    Endif ;
B01    if %Parms >= 3 ;
          Eval w_msgflib = p_msgflib ;
E01    Endif ;
B01    if %Parms >= 2 ;
          Eval w_msgdata = p_msgdata ;
E01    Endif ;
B01    if %Addr(p_msgno) <> *NULL ;
          Eval w_msgno = p_msgno ;
E01    Endif ;
B01    if w_msgflib = '' ;
          w_msgflib = '*LIBL';
E01    Endif;
B01    if w_msgffile = '' ;
          w_msgffile ='QCPFMSG' ;
E01    Endif;
B01    if w_msgtype = '' ;
          w_msgtype = '*DIAG' ;
E01    Endif;
B01    if w_msgcse = '' ;
          w_msgcse = '*' ;
E01    Endif;
B01    if w_msgcsc =-1 ;
          w_msgcsc = 2 ;
E01    Endif;
       //?send a program message
       qmhsndpm ( w_msgno
          : w_msgffile + w_msgflib
          : w_msgdata
          : %Len(w_msgdata)
          : w_msgtype
          : w_msgcse
          : w_msgcsc
          : w_msgkey
          : ErrorCode ) ;
B01    if ErrorCode.available > 0 ;
          Dump(A) ;
E01    Endif ;
B01    if %Parms >= 8 ;
          Eval p_msgkey = w_msgkey ;
E01    Endif ;
B01    BegSr *PSSR ;
          Dump(A) ;
E01    EndSr ;
1992+ /end-free
EPR  p                 e
