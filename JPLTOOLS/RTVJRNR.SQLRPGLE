


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_rjrn0100o    e             disk    usropn extfile(f_rjrn0100)
     f                                     rename(t_rjrn0100:rjrn0100f)
     f                                     prefix('JN0.')
     fT_rjrn0101o    e             disk    usropn extfile(f_rjrn0101)
     f                                     rename(t_rjrn0101:rjrn0101f)
     f                                     prefix('JN1.')
     fT_rrcv0100o    e             disk    usropn extfile(f_rrcv0100)
     f                                     rename(t_rrcv0100:rrcv0100f)
     f                                     prefix('RC1.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_rjrn0100      s             21
     d f_rjrn0101      s             21
     d f_rrcv0100      s             21

     d jn0           e ds                  extname(t_rjrn0100:*output) qualified
     d jn1           e ds                  extname(t_rjrn0101:*output) qualified
     d rc1           e ds                  extname(t_rrcv0100:*output) qualified
     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)
    ? * Retrieve Journal Information (QjoRetrieveJournalInformation) API
     d QjoRtvJrnC      c                   'QjoRetrieveJournalInformation'
     d Qjortvjrn       pr                  extproc(QjoRtvJrnC)
     d receiver                       1           options( *varsize )
     d len                           10i 0 const
     d Qualjrn                       20    const
     d format                         8    const
     d JrnInf                         1    const  options( *varsize )
     d Error_code                   255           options( *varsize )

    ? * Retrieve Journal Receiver Information (QjoRtvJrnReceiverInformation) API

     d QjoRtvRcvC      c                   'QjoRtvJrnReceiverInformation'
     d QjortvRcv       pr                  extproc(QjoRtvRcvC)
     d receiver                       1           options( *varsize )
     d len                           10i 0 const
     d Qualjrn                       20    const
     d format                         8    const
     d Error_code                   255           options( *varsize )

     d jrninf          ds                  qualified
     d   keynbr                      10i 0 inz(1)
     d   k1_len                      10i 0 inz(12)
     d   k1_val                      10i 0 inz(1)
     d   k1_dtalen                   10i 0 inz(0)

     d
     d rrcv0100        ds                  qualified
     d   returned                    10i00
     d   available                   10i00
     d   rcv                         10
     d   rcvlib                      10
     d   jrn                         10
     d   jrnlib                      10
     d                               10i00
     d                               10i00
     d   asp                         10i00
     d   entries                     10i00
     d   max_spe                     10i00
     d   max_null                    10i00
     d   first_seq                   10i00
     d   min_dtaara                   1
     d   min_file                     1
     d                                2
     d   last_seq                    10i00
     d                               10i00
     d                                1
     d   minfixopt                    1
     d   maxopt                       1
     d                                4
     d   attached                    13
     d   detaced                     13
     d   saved                       13
     d                               50
     d   pending                      1
     d   remote                       1
     d   local                       10
     d   locallib                    10
     d   localsys                     8
     d   localrcvlb                  10
     d   srcjrn                      10
     d   srcjrnlib                   10
     d   srcjrnsys                    8
     d   srcrcvl                     10
     d   redirlib                    10
     d   dualrcv                     10
     d   dualrcvlib                  10
     d   prevrcv                     10
     d   prevrcvlib                  10
     d   prdurcv                     10
     d   prdurcvlib                  10
     d   nextrcv                     10
     d   nextrcvlib                  10
     d   nxdurcv                     10
     d   nxdurcvlib                  10
     d   entriesl                    20
     d   max_speL                    20
     d   first_seqL                  20
     d   last_seqL                   20
     d   aspdev                      10
     d   locaspgrp                   10
     d   srcaspgrp                   10
     d   fix_job                      1
     d   fix_usr                      1
     d   fix_pgm                      1
     d   fix_pgmlib                   1
     d   fix_sysseq                   1
     d   fix_rmtadr                   1
     d   fix_thd                      1
     d   fix_luw                      1
     d   fix_xid                      1

     d   rjrn0100      ds                  qualified based(pRjrn0100)
     d   returned                    10i00
     d   available                   10i00
     d   key_off                     10i00
     d   jrn                         10
     d   jrnlib                      10
     d   asp                         10i00
     d   msgq                        10
     d   msgqlib                     10
     d   manage                       1
     d   delete                       1
     d   o_rmvinten                   1
     d   o_minfixle                   1
     d   o_maxopt1                    1
     d   o_maxopt2                    1
     d   o_maxopt3                    1
     d                                2
     d   jrntyp                       1
     d   rmtjrntyp                    1
     d   state                        1
     d   delivery                     1
     d   local                       10
     d   locallib                    10
     d   localsys                     8
     d   srcjrn                      10
     d   srcjrnlib                   10
     d   srcjrnsys                    8
     d   redirlib                    10
     d   text                        50
     d   min_dtaara                   1
     d   min_file                     1
     d                                8
     d   cache                        1
     d   attachednb                  10i00
     d   attrcv                      10
     d   attrcvlib                   10
     d   localatt                     8
     d   srcatt                       8
     d   attdual                     10
     d   attduallib                  10
     d   managedly                   10i00
     d   deletedly                   10i00
     d   aspdev                      10
     d   localasp                    10
     d   srcasp                      10
     d   fix_job                      1
     d   fix_usr                      1
     d   fix_pgm                      1
     d   fix_pgmlib                   1
     d   fix_sysreq                   1
     d   fix_rmtadr                   1
     d   fix_thd                      1
     d   fix_luw                      1
     d   fix_xid                      1
     d                                4
     d   obj_limit                    1
     d   nb_obj                      10i00
     d   nb_file                     10i00
     d   nb_mbr                      10i00
     d   nb_dtaara                   10i00
     d   nb_dtaq                     10i00
     d   nb_ifs                      10i00
     d   nb_path                     10i00
     d   nb_commit                   10i00
     d   rec_count                   10i00
     d   nb_lib                      10i00
     d                              100
     d   nb_key                      10i00
     d   rjrn0100k     ds                  qualified based(prjrn0100k)
     d   key                         10i00
     d   off                         10i00
     d   headlen                     10i00
     d   count                       10i00
     d   entrylen                    10i00
     d   rjrnk1        ds                  qualified based(prjrnk1)
     d   nb_rcv                      10i00
     d   size_rcv                    10i00
     d   size_rcv_m                  10i00
     d                                8
     d   rjrnk2        ds                  qualified based(prjrnk2)
     d   nb_file                     10i00
     d   nb_mbr                      10i00
     d   nb_dtaara                   10i00
     d   nb_dtaq                     10i00
     d   nb_ifs                      10i00
     d   nb_lib                      10i00
     d                               12
     d   rjrnk3        ds                  qualified based(prjrnk3   )
     d   nb_rmt                      10i00
     d                               16
     d
     d   rjrn0101      ds                  qualified based(prjrn0101 )
     d   rcv                         10
     d   rcvlib                      10
     d   rcv_nbr                      5
     d   attached                    13
     d   status                       1
     d   saved                       13
     d   localjrn                     8
     d   srcjrn                       8
     d   rcv_size                    10i00
     d                               56

     d   rjrn0102      ds                  qualified based(prjrn010  )
     d   type                        10
     d   name                        10
     d   lib                         10
     d   id                          16
     d   file_type                    1
     d                                1

     d   rjrn0103      ds                  qualified based(prjrn0103 )
     d   rdb                         18
     d   rmtjrn                      10
     d   rmtjrnlib                   10
     d   rmtrcvlib                   10
     d   inacrcv                     10
     d   inacrcvlib                  10
     d   inacrcvseq                  10i00
     d                               10i00
     d   rmtjrntyp                    1
     d   rmtjrnstat                   1
     d   rmtjrnmod                    1
     d   validity                     1
     d   pri                         10i00
     d                               20
     d   time_out                    10i00
     d   behind                      10i00
     d   behindmax                   10i00
     d   behindtim                   13
     d                                3
     d   hsec                        10i00
     d   hsecmax                     10i00
     d
     d   hsectim                     13
     d                               11
     d   rdbdtl                     512
     d   node                         8
     d   email_off                   10i00
     d   email_nb                    10i00
     d   email_nba                   10i00
     d   email_tim                   13
     d   catchup                     13
     d   active                      13
     d                                1
     d   bundles_nb                  10i00
     d   bundlesmax                  10i00
     d   bundlestim                  13
     d                                3
     d   bundlescnt                  10i00
     d                               80
     d   email                      450

     d JRNList         s             20    inz('JRNLIST   QTEMP     ')


     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_Jrnlist      pr
     d   type                        10    const




     d un_jrn          pr
     d   jrn                         10    const
     d   lib                         10    const
     d un_rcv          pr
     d   rcv                         10    const
     d   lib                         10    const

     d rjrn0100_len    s             10i 0




     d rtvjrnr         pr
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_rjrn0100                    20
     d p_rjrn0101                    20
     d p_rjrn0102                    20
     d p_rjrn0103                    20
     d p_rrcv0100                    20

     d rtvjrnr         pi
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_rjrn0100                    20
     d p_rjrn0101                    20
     d p_rjrn0102                    20
     d p_rjrn0103                    20
     d p_rrcv0100                    20

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










     c/free

       EXEC SQL
          SET OPTION Commit = *NONE
          , CLOSQLCSR = *ENDACTGRP
          , DATFMT = *ISO
          , TIMFMT = *ISO
          , NAMING = *SYS
          , SQLPATH= *LIBL
          ;
       f_rjrn0100 = %Trim(%Subst(p_rjrn0100:11:10))
          +'/'+%Subst(p_rjrn0100:01:10);
       f_rjrn0101 = %Trim(%Subst(p_rjrn0101:11:10))
          +'/'+%Subst(p_rjrn0101:01:10);
       f_rrcv0100 = %Trim(%Subst(p_rrcv0100:11:10))
          +'/'+%Subst(p_rrcv0100:01:10);

       cleanup_outfile(p_rjrn0100: 'T_RJRN0100':p_mbropt);
       cleanup_outfile(p_rjrn0101: 'T_RJRN0101':p_mbropt);
       cleanup_outfile(p_rrcv0100: 'T_RRCV0100':p_mbropt);

       //? create the user space
       QUSCRTUS (JRNList:*Blank:1:X'00':'*ALL':*Blank:'*YES':ech:'*USER');
B01    if (ech.available>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       QUSCUSAT ( lib : JRNList : ATTRIBUTES : ech );
B01    if (ech.available>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       Open(E) T_RJRN0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_RJRN0101;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_RRCV0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       rjrn0100_len = 8;
       pRjrn0100 = %Alloc(rjrn0100_len);
       Do_Jrnlist('*JRN');
       Dealloc pRjrn0100 ;

       Close(E) T_RJRN0100;
       Close(E) T_RJRN0101;
       Close(E) T_RRCV0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       QUSDLTUS (JRNList:ech);

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
B02       if ech.MSGID <> 'CPF9812';
            MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
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




BPR ?p do_jrnlist      b
    ? *=-----------------------------------------------------------------------
     d do_jrnlist      pi
     d   type                        10    const
    ?d*=---------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s              5i 0
      /free
       ech .available=0;
       quslobj
          (JRNList
          :'OBJL0100'
          :p_OBJ   //?parametre pgm
          : type   //?parametre proc
          :ech
          );
B01    if (ech.available>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       QUSPTRUS(JRNList : pLAH);
B01    For i = 0 TO lah.count - 1;
          pOBJL0100 = pLAH + lah.DATA_OFFSET + i * lah.ENTRY_SIZE ;
          //?If OBJL0100.type = '*MODULE';
          un_jrn (OBJL0100.name:OBJL0100.lib );
E01    EndFor;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;

      /end-free
EPR  p                 e


BPR ?p un_jrn          b
     d                 pi
     d   jrn                         10    const
     d   lib                         10    const

     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d lah2            ds                  likeds(ListApiHeader) based(pLAH2)
     d i               s              5i 0
     d j               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       //? Retrieve Journal Information (QjoRetrieveJournalInformation) API
       ech.available=0;
       Qjortvjrn
          (rjrn0100
          :rjrn0100_len
          :jrn+lib
          :'RJRN0100'
          :JrnInf
          :ech
          );
B01    if (ech.available>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

B01    if rjrn0100.returned < rjrn0100.available;
          rjrn0100_len = rjrn0100.available ;
          pRjrn0100 = %realloc(pRjrn0100:rjrn0100_len);
          Qjortvjrn
             (rjrn0100
             :rjrn0100_len
             :jrn+lib
             :'RJRN0100'
             :JrnInf
             :ech
             );
B02       if (ech.available>0);
            MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endif;

       //?export API data to DS
       Clear jn0;
       Eval-Corr jn0 = rjrn0100;

       //?parcourir les keys

B01    For i = 0 TO rjrn0100.nb_key - 1;
          //?pointer juste après NB_KEY
          //?.key_off offset points to the Number of keys in key section field.
          prjrn0100k = %Addr(rjrn0100) + rjrn0100.key_off + 4
             + I*(%Size(rjrn0100k));
B02       Select;
X02          When rjrn0100k.key = 1;
                prjrnk1 =%Addr(rjrn0100k) + rjrn0100k.off;
                Eval-Corr jn0 = rjrnk1;
                //?parcourir les receivers
B03             For j = 0 TO rjrn0100k.count - 1;
                   prjrn0101 = prjrnk1
                      + rjrn0100k.headlen + J*RJRN0100K.entrylen;
                   Eval-Corr jn1 = jn0 ;   //?jrn name
                   Eval-Corr jn1 = rjrn0101;
                   un_rcv(jn1.rcv:jn1.rcvlib);
                   Write RJRN0101F ;
B04                if %Error();
                      MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
                         :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E04                Endif;
E03             EndFor;
X02          Other;
E02       EndSl;


E01    EndFor;
       Write RJRN0100F ;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e

BPR ?p un_rcv          b
     d                 pi
     d   rcv                         10    const
     d   lib                         10    const
      /free
       //? Retrieve Journal Receiver Information (QjoRtvJrnReceiverInformation) API
       ech.available=0;
       QjortvRcv
          (RRCV0100
          :%Size(RRCV0100)
          :rcv+lib
          :'RRCV0100'
          :ech
          );
B01    if (ech.available>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //?export API data to DS
       Clear rc1;
       Eval-Corr rc1 = RRCV0100;
       Write Rrcv0100F ;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e

