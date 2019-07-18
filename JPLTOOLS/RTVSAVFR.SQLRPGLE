


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_savf0100o    e             disk    usropn extfile(f_savf0100)
     f                                     rename(t_savf0100:savf0100f)
     f                                     prefix('SA1.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_savf0100      s             21
     d SA1           e ds                  extname(t_savf0100:*output) qualified
     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)
    ? * Retrieve Command Information (QCDRCMDI) API
     d QCDRCMDI        pr                  extpgm('QCDRCMDI')
     d receiver                       1           options( *varsize )
     d len                           10i 0 const
     d format                         8    const
     d Qualcmd                       20    const
     d Error_code                   255           options( *varsize )

    ? * List Save File (QSRLSAVF) API
     d QSRLSAVF        pr                  extpgm('QSRLSAVF')
     d   UserSpace                   20    const
     d   Format                       8    const
     d   Savf                        20    const
     d   NameFilter                  10    const
     d   TypeFilter                  10    const
     d   Continuation                36    const
     d   ErrorCode                  255    options(*varsize)
     d savf0100        ds          5000    qualified based(psavf0100)
     d   library                     10
     d   commande                    10
     d   sysdts                       8
     d   asp                         10i00
     d   records                     10u00
     d   objects                     10i00
     d   path                        10i00
     d   WhileActiv                  10
     d   release                      6
     d   compress                     1
     d   system                       8
     d   authority                    1
     d                                2
     d   aspdev                      10
     d                                2
     d   members                     10i00
     d   spools                      10i00
     d   synchID                     10



     d SavfList        s             20    inz('SAVFLIST  QTEMP     ')
     d SavfInfo        s             20    inz('SAVFINFO  QTEMP     ')


     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_Savflist     pr

     d*  Convert Date and Time Format (  CCVTDT) API
     d QWCCVTDT        pr                  extpgm('QWCCVTDT')
     d InFmt                         10    const
     d inVar                          1    const options(*varsize)
     d OutFmt                        10    const
     d OutVar                         1          options(*varsize)
     d Errorcode                      1          options(*varsize)
     d Inputtimezone                 10    options(*nopass) const
     d Outputtimezone                10    options(*nopass) const
     d TimeZoneInf                  115    options(*nopass)
     d TimeZoneInfLen                10i 0 options(*nopass) const
     d Precision                      1    options(*nopass) const
     d Inputtimeind                   1    options(*nopass) const




     d un_savf         pr
     d   cmd                         10    const
     d   lib                         10    const






     d rtvsavfr        pr
     d p_OBJ                         20
     d p_mbropt                      10
     d p_savf0100                    20

     d rtvsavfr        pi
     d p_OBJ                         20
     d p_mbropt                      10
     d p_savf0100                    20

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

     d OBJL0200        ds                  qualified based(pOBJL0200)
    ? *OBJL0100
     d   name                        10
     d   lib                         10
     d   type                        10
    ? *OBJL0200
     d   status                       1
     d   attribute                   10
     d   text                        50
     d   userattr                    10
     d                                7

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
       f_savf0100 = %Trim(%Subst(p_savf0100:11:10))
          +'/'+%Subst(p_savf0100:01:10);

       cleanup_outfile(p_savf0100: 'T_SAVF0100':p_mbropt);

       //? create the user space
       QUSCRTUS (SavfList:*Blank:1:X'00':'*ALL':*Blank:'*YES':ech:'*USER');
B01    if (ech.AVAILABLE>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       QUSCRTUS (SavfInfo:*Blank:1:X'00':'*ALL':*Blank:'*YES':ech:'*USER');
B01    if (ech.AVAILABLE>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       QUSCUSAT ( lib : SavfList : ATTRIBUTES : ech );
B01    if (ech.AVAILABLE>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       QUSCUSAT ( lib : SavfInfo : ATTRIBUTES : ech );
B01    if (ech.AVAILABLE>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       Open(E) T_SAVF0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Do_Savflist( );

       Close(E) T_SAVF0100;
B01    if %Error();
          MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       QUSDLTUS (SavfList:ech);
       QUSDLTUS (SavfInfo:ech);

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
B01    if ech.AVAILABLE>0;
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




BPR ?p do_Savflist     b
    ? *=-----------------------------------------------------------------------
     d do_Savflist     pi
    ?d*=---------------------------------
     d   type          s             10
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s              5i 0
      /free
       ech .AVAILABLE=0;
       quslobj
          (SavfList
          :'OBJL0200'
          :p_OBJ   //?parametre pgm
          : '*FILE'   //?parametre proc
          :ech
          );
B01    if (ech.AVAILABLE>0);
          MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       QUSPTRUS(SavfList : pLAH);
B01    For i = 0 TO lah.COUNT - 1;
          pOBJL0200 = pLAH + lah.DATA_OFFSET + i * lah.ENTRY_SIZE ;
B02       if OBJL0200.attribute = 'SAVF';
             un_savf (OBJL0200.name:OBJL0200.lib );
E02       Endif;
E01    EndFor;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;

      /end-free
EPR  p                 e


BPR ?p un_savf         b
     d                 pi
     d   file                        10    const
     d   lib                         10    const

     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d lah2            ds                  likeds(ListApiHeader) based(pLAH2)
     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
     d continuation    s             16
     d JobDate         s               z
     d TimeStmp        s             20a
     d sysdts          s              8
     d TZI             s            115

      /free
       Continuation='';
       QSRLSAVF
          (SavfInfo
          :'SAVF0100'
          :file+lib
          : '*ALL'
          : '*ALL'
          : Continuation
          :ech
          );
B01    if (ech.AVAILABLE>0);
             if ECH.MSGID = 'CPF3743'; // savf en version superieure
                clear sa1;
             sa1.savflib = lib ;
             sa1.savefile  = file;
             Write SAVF0100F ;
             return;
             else;
           MESSAGE(ech.MSGID:ech.MSGDTA:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
             endif;
E01    Endif;


       //? for each object
       QUSPTRUS(SavfInfo : pLAH);
B01    For i = 0 TO lah.COUNT - 1;
          psavf0100 = pLAH + lah.DATA_OFFSET + i * lah.ENTRY_SIZE ;

          //?export API data to DS
          Eval-Corr SA1 = savf0100;
          sa1.savflib = lib ;
          sa1.savefile  = file;
           sysdts = savf0100.sysdts ;
                       //?qwccvtdt : parm 2 MUST be Non-dotted name or results are unpredictable
                       QWCCVTDT('*DTS'
                          :sysdts
                          :'*YYMD'
                          :TimeStmp
                          :Ech
                          :'*SYS':'*SYS':TZI:0:'1');

                   sa1.dts     = %Timestamp(TimeStmp:*ISO0);
          Write SAVF0100F ;
B02       if %Error();
             MESSAGE('CPF9801':SPMSID+'-'+SPMSDA
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    EndFor;
       Return;
B01    BegSr *PSSR;
          Dump;
E01    EndSr;
      /end-free
EPR  p                 e

