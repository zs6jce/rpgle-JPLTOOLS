


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.') EXTBININT(*YES)
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_exti0100o    e             disk    usropn extfile(f_exti0100)
     f                                     rename(t_exti0100:exti0100f)
     f                                     prefix('EX1.')
     fT_exti0200o    e             disk    usropn extfile(f_exti0200)
     f                                     rename(t_exti0200:exti0200f)
     f                                     prefix('EX2.')
     fT_exti0300o    e             disk    usropn extfile(f_exti0300)
     f                                     rename(t_exti0300:exti0300f)
     f                                     prefix('EX3.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_exti0100      s             21
     d f_exti0200      s             21
     d f_exti0300      s             21

     d ex1           e ds                  extname(t_exti0100:*output) qualified
     d ex2           e ds                  extname(t_exti0200:*output) qualified
     d ex3           e ds                  extname(t_exti0300:*output) qualified

     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)

     d rtvei           pr                  extproc('QusRetrieveExitInformation')
     d   Continuation                16                      const
     d   Receiver                     1    options(*varsize)
     d   RcvLen                      10i 0                   const
     d   Format                       8                      const
     d   Exitpoint                   20                      const
     d   Exitformat                   8                      const
     d   Exitnumber                  10i 0                   const
     d   selection                    1    options(*varsize) const
     d   Errorcode                  256    options(*varsize)

     d EXTI0100        ds         10000    qualified
     d  returned                     10i 0
     d  available                    10i 0
     d  continuation                 16
     d  offset                       10i 0
     d  count                        10i 0
     d  length                       10i 0

     d EXTI0100e       ds                  qualified based(pexti0100e)
     d  exit_point                   20
     d  format                        8
     d  max_pgm                      10i 0
     d  pgm_count                    10i 0
     d  deregister                    1
     d  changeable                    1
     d  registered                    1
     d  addpgm                       10
     d  addpgmlib                    10
     d  addpgmfmt                     8
     d  rmvpgm                       10
     d  rmvpgmlib                    10
     d  rmvpgmfmt                     8
     d  rtvpgm                       10
     d  rtvpgmlib                    10
     d  rtvpgmfmt                     8
     d  desc_ind                      1
     d  msgf                         10
     d  msgflib                      10
     d  msgid                         7
     d  text                         50

     d EXTI0200        ds         65000    qualified
     d  returned                     10i 0
     d  available                    10i 0
     d  continuation                 16
     d  offset                       10i 0
     d  count                        10i 0
     d  length                       10i 0

     d EXTI0200e       ds                  qualified based(pexti0200e)
     d  next                         10i 0
     d  exit_point                   20
     d  format                        8
     d  registered                    1
     d  complete                      1
     d                                2
     d  number                       10i 0
     d  pgm                          10
     d  pgmlib                       10
     d  ccsid                        10i 0
     d  offset                       10i 0
     d  length                       10i 0
     d  Threadsafe                    1
     d  multi_act                     1
     d  qmltthdacn                    1

     d EXTI0200d       ds                  qualified based(pexti0200d)
     d  data                      65000


     d EXTI0300        ds         65000    qualified
     d  returned                     10i 0
     d  available                    10i 0
     d  continuation                 16
     d  offset                       10i 0
     d  count                        10i 0
     d  length                       10i 0

     d EXTI0300e       ds          1000    qualified based(pexti0300e)
     d  next                         10i 0
     d  exit_point                   20
     d  format                        8
     d  registered                    1
     d  complete                      1
     d                                2
     d  number                       10i 0
     d  pgm                          10
     d  pgmlib                       10
     d  desc_ind                      1
     d  msgf                         10
     d  msgflib                      10
     d  msgid                         7
     d  text                         50
     d                                2
     d  ccsid                        10i 0
     d  offset                       10i 0
     d  length                       10i 0
     d  Threadsafe                    1
     d  multi_act                     1
     d  qmltthdacn                    1

     d EXTI0300d       ds                  qualified based(pexti0300d)
     d  data                      65000

     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const


     d Do_Exti0100     pr
     d p_OBJ                         20
     d p_fmt                          8
    ?d Do_Exti0200     pr
    ?d p_OBJ                         20
    ?d p_fmt                          8
    ?d Do_Exti0300     pr
    ?d p_OBJ                         20
    ?d p_fmt                          8
















     d rtvexitr        pr
     d p_OBJ                         20
     d p_fmt                          8
     d p_mbropt                      10
     d p_exti0100                    20
     d p_exti0200                    20
     d p_exti0300                    20

     d rtvexitr        pi
     d p_OBJ                         20
     d p_fmt                          8
     d p_mbropt                      10
     d p_exti0100                    20
     d p_exti0200                    20
     d p_exti0300                    20

    ?**-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )

     d OBJD0200        ds                  qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Object_name                   10
     d Object_lib                    10
     d Object_type                   10
     d Return_lib                    10
     d Obj_ASP_nbr                   10i 0
     d Object_owner                  10
     d Object_domain                 02
     d Creation_dts                  13
     d change_dts                    13
     d obj_attr                      10
     d Text                          50
     d Src_file_name                 10
     d Src_file_lib                  10
     d Src_file_mbr                  10

    ? *List Objects (QUSLOBJ) API
     d quslobj         pr                  extpgm('QUSLOBJ')
     d   usp                         20    const
     d   Format                       8    const
     d   qualobjname                 20    const
     d   objtype                     10    const
     d   Error_Code                1000    const options(*nopass:*varsize)
     d   Authority                 1000    const options(*nopass:*varsize)
     d   Selection                 1000    const options(*nopass:*varsize)
     d   ASP                       1000    const options(*nopass:*varsize)

     d OBJL0100        ds                  qualified based(pOBJL0100)
     d   name                        10
     d   lib                         10
     d   type                        10

     D QCmdExc         PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     d cleanup_outfile...
     d                 pr
     d   qualfile                    20    const
     d   modele                      10    const
     d   mbropt                      10    const

     d x10             s             10

     d selection       ds                  qualified
     d   count                       10i 0
     d   size                        10i 0
     d   comparison                  10i 0
     d   start                       10i 0
     d   len                         10i 0
     d   data                        10









     c/free

       EXEC SQL
          SET OPTION Commit = *NONE
          , CLOSQLCSR = *ENDACTGRP
          , DATFMT = *ISO
          , TIMFMT = *ISO
          , NAMING = *SYS
          , SQLPATH= *LIBL
          ;
       f_exti0100 = %Trim(%Subst(p_exti0100:11:10))
          +'/'+%Subst(p_exti0100:01:10);
       f_exti0200 = %Trim(%Subst(p_exti0200:11:10))
          +'/'+%Subst(p_exti0200:01:10);
       f_exti0300 = %Trim(%Subst(p_exti0300:11:10))
          +'/'+%Subst(p_exti0300:01:10);

       cleanup_outfile(p_exti0100: 'T_EXTI0100':p_mbropt);
       cleanup_outfile(p_exti0200: 'T_EXTI0200':p_mbropt);
       cleanup_outfile(p_exti0300: 'T_EXTI0300':p_mbropt);

       Open(E) T_EXTI0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_EXTI0200;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_EXTI0300;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       selection.count=  0 ;
       selection.size = 26 ;
       selection.comparison = 1 ;
       selection.start = 0 ;
       selection.len = 0 ;
       selection.data = '';

       Do_Exti0100(p_OBJ:p_fmt);
       Do_Exti0200(p_obj:p_fmt);
       Do_Exti0300(p_obj:p_fmt);

       Close(E) T_EXTI0100;
       Close(E) T_EXTI0200;
       Close(E) T_EXTI0300;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;



       Return;
    ? /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

     p cleanup_outfile...
BPR ?p                 b
     d                 pi
     d   qualfile                    20    const
     d   modele                      10    const
     d   mbropt                      10    const
      /free

       //?check object exists
       RtvObjD( OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : qualfile
          : '*FILE'
          : ech
          );
B01    if ech.available>0;
B02       if ech.msgid <> 'CPF9812';
            MESSAGE(ech.msgid:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
X02       Else;
             //?file is unknown, create it
             //?CRTDUPOBJ OBJ(T_MODI0100) FROMLIB(pgm_LIB) OBJTYPE(*FILE) TOLIB(TOLIB)
             Cmd = 'CRTDUPOBJ OBJ('+ modele + ') FROMLIB('
                + SPPGLB + ') OBJTYPE(*FILE) TOLIB('
                + %Trim(%Subst(qualfile :11:10)) + ') NEWOBJ('
                + %Trim(%Subst(qualfile :01:10)) + ')';
             QCmdExc ( Cmd : %Len(Cmd));
E02       Endif;
X01    Else;
          //?mode append ?
B02       if mbropt = '*REPLACE';
             MySQL = 'delete from  '
                + %Subst(qualfile :11:10) + '/'
                + %Subst(qualfile :01:10) ;
             EXEC SQL execute IMMEDIATE : MySQL;
B03          if SQLCODE <> 0 And SQLCODE <> 100;
                ESCSQLER (SQLCOD:SQLERM);
E03          Endif;
E02       Endif;
E01    Endif;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;

      /end-free
EPR  p                 e




BPR ?p do_exti0100     b
    ? *=-----------------------------------------------------------------------
     d do_exti0100     pi
     d p_OBJ                         20
     d p_fmt                          8
    ?d*=---------------------------------
     d continuation    s             16
     d i               s              5i 0
      /free
       //? Retrieve Information
       ech.available=0;
       Continuation = ''    ;
B01    for ever;
          rtvei
             ( Continuation
             : EXTI0100
             : %Size(EXTI0100)
             : 'EXTI0100'
             : p_OBJ
             : p_fmt
             : -1
             : selection
             : ech
             );
B02       if (ech.available>0);
            MESSAGE(ech.msgid:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;

B02       For i = 0 TO EXTI0100.count - 1;
            pexti0100e = %Addr(EXTI0100)+ EXTI0100.offset + i * EXTI0100.length;
             //?export API data to DS
             Clear ex1;
             Eval-Corr ex1 = EXTI0100e;
             Write EXTI0100F ;
B03          if %Error();
                MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
                   :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E03          Endif;
E02       EndFor;
          if EXTI0100.Continuation = '';
             leave;
          endif;
          Continuation = EXTI0100.Continuation;
E01    Endfor;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e


BPR ?p do_exti0200     b
    ? *=-----------------------------------------------------------------------
     d do_exti0200     pi
     d p_OBJ                         20
     d p_fmt                          8
    ?d*=---------------------------------
     d continuation    s             16
     d i               s              5i 0
      /free
       //? Retrieve Information
       ech.available=0;
       Continuation = ''    ;
B01    for ever;
          rtvei
             ( Continuation
             : EXTI0200
             : %Size(EXTI0200)
             : 'EXTI0200'
             : p_OBJ
             : p_fmt
             : -1
             : selection
             : ech
             );
B02       if (ech.available>0);
            MESSAGE(ech.msgid:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;

          pexti0200e = %Addr(EXTI0200)+ EXTI0200.offset;
B02       For i = 0 TO EXTI0200.count - 1;
             //?export API data to DS
             Clear ex2;
             Eval-Corr ex2 = EXTI0200e;

            pexti0200d = %Addr(EXTI0200)+ EXTI0200e.offset;
            if exti0200e.length < 1000;
               ex2.data = %subst(exti0200d:1:exti0200e.length);
            else;
               ex2.data = %subst(exti0200d:1:1000);
            endif;

             Write EXTI0200F ;
B03          if %Error();
                MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
                   :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E03          Endif;
            pexti0200e = %Addr(EXTI0200)+ EXTI0200e.next;
E02       EndFor;
          if EXTI0200.Continuation = '';
             leave;
          endif;
          Continuation = EXTI0200.Continuation;
E01    Endfor;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e

BPR ?p do_exti0300     b
    ? *=-----------------------------------------------------------------------
     d do_exti0300     pi
     d p_OBJ                         20
     d p_fmt                          8
    ?d*=---------------------------------
     d continuation    s             16
     d i               s              5i 0
      /free
       //? Retrieve Information
       ech.available=0;
       Continuation = ''    ;
B01    for ever;
          rtvei
             ( Continuation
             : EXTI0300
             : %Size(EXTI0300)
             : 'EXTI0300'
             : p_OBJ
             : p_fmt
             : -1
             : selection
             : ech
             );
B02       if (ech.available>0);
            MESSAGE(ech.msgid:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;

          pexti0300e = %Addr(EXTI0300)+ EXTI0300.offset;
B02       For i = 0 TO EXTI0300.count - 1;
             //?export API data to DS
             Clear ex3;
             Eval-Corr ex3 = EXTI0300e;

            pexti0300d = %Addr(EXTI0300)+ EXTI0300e.offset;
            if exti0300e.length < 1000;
               ex3.data = %subst(exti0300d:1:exti0300e.length);
            else;
               ex3.data = %subst(exti0300d:1:1000);
            endif;

             Write EXTI0300F ;
B03          if %Error();
                MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
                   :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E03          Endif;
            pexti0300e = %Addr(EXTI0300)+ EXTI0300e.next;
E02       EndFor;
          if EXTI0300.Continuation = '';
             leave;
          endif;
          Continuation = EXTI0300.Continuation;
E01    Endfor;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e



