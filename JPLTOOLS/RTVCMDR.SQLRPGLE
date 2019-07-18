


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_cmdI0100o    e             disk    usropn extfile(f_cmdI0100)
     f                                     rename(t_cmdI0100:cmdI0100f)
     f                                     prefix('CI1.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_cmdI0100      s             21
     d cI1           e ds                  extname(t_cmdI0100:*output) qualified
     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)
    ? * Retrieve Command Information (QCDRCMDI) API
     d QCDRCMDI        pr                  extpgm('QCDRCMDI')
     d receiver                       1           options( *varsize )
     d len                           10i 0 const
     d format                         8    const
     d Qualcmd                       20    const
     d Error_code                   255           options( *varsize )

     d CMDI0100        ds          5000    qualified
     d   returned                    10i00
     d   available                   10i00
     d   cmd                         10
     d   cmdlib                      10
     d   cmdpgm                      10
     d   cmdpgmlib                   10
     d   src                         10
     d   srclib                      10
     d   srcmbr                      10
     d   vckpgm                      10
     d   vckpgmlib                   10
     d   mode                        10
     d   allowed                     15
     d   alwlmtusr                    1
     d   maxpos                      10i00
     d   pmtf                        10
     d   pmtflib                     10
     d   msgf                        10
     d   msgflib                     10
     d   hlp                         10
     d   hlplib                      10
     d   hlpid                       10
     d   schidx                      10
     d   schidxlib                   10
     d   curlib                      10
     d   prdlib                      10
     d   pop                         10
     d   poplib                      10
     d   tgtrls                       6
     d   text                        50
     d   cpp_state                    2
     d   vck_state                    2
     d   pop_state                    2
     d   bksinfoff                   10i00
     d   bksinflen                   10i00
     d   ccsid                       10i00
     d   gui                          1
     d   threadsafe                   1
     d   multithr                     1
     d   proxy                        1
     d   pmtmsgf                      1



     d CmdList         s             20    inz('CMDLIST   QTEMP     ')


     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_cmdlist      pr
     d   type                        10    const




     d un_cmd          pr
     d   cmd                         10    const
     d   lib                         10    const






     d rtvcmdr         pr
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_cmdI0100                    20

     d rtvcmdr         pi
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_cmdI0100                    20

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

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl
          ;
       f_cmdI0100 = %Trim(%Subst(p_cmdI0100:11:10))
          +'/'+%Subst(p_cmdI0100:01:10);

       cleanup_outfile(p_cmdI0100: 'T_CMDI0100':p_mbropt);

       //? create the user space
       Quscrtus (cmdList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib : cmdList : Attributes : ech );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       Open(E) T_cmdi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
B01
          Do_Cmdlist('*CMD');

       Close(E) T_cmdi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Qusdltus (cmdlist:ech);

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
B01    If ech.available>0;
B02       If ech.Msgid <> 'CPF9812';
            Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
X02       Else;
             //?file is unknown, create it
             //?CRTDUPOBJ OBJ(T_MODI0100) FROMLIB(pgm_LIB) OBJTYPE(*FILE) TOLIB(TOLIB)
             Cmd = 'CRTDUPOBJ OBJ('+ modele + ') FROMLIB('
                + Sppglb + ') OBJTYPE(*FILE) TOLIB('
                + %Trim(%Subst(qualfile :11:10)) + ') NEWOBJ('
                + %Trim(%Subst(qualfile :01:10)) + ')';
             QCmdExc ( Cmd : %Len(Cmd));
E02       Endif;
X01    Else;
          //?mode append ?
          if mbropt = '*REPLACE';
          MySQL = 'delete from  '
             + %Subst(qualfile :11:10) + '/'
             + %Subst(qualfile :01:10) ;
          Exec Sql execute Immediate : MySQL;
B02       If Sqlcode <> 0 And Sqlcode <> 100;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          endif;
E01    Endif;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e




BPR ?p do_cmdlist      b
    ? *=-----------------------------------------------------------------------
     d do_cmdlist      pi
     d   type                        10    const
    ?d*=---------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s              5i 0
      /free
       ech .available=0;
       quslobj
          (cmdList
          :'OBJL0100'
          :p_OBJ   //?parametre pgm
          : type   //?parametre proc
          :ech
          );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       Qusptrus(cmdList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pOBJL0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
B02    // If OBJL0100.type = '*MODULE';
             un_CMD    (OBJL0100.name:OBJL0100.lib );
E01    Endfor;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e


BPR ?p un_cmd          b
     d                 pi
     d   cmd                         10    const
     d   lib                         10    const

     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d lah2            ds                  likeds(ListApiHeader) based(pLAH2)
     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       //? Retrieve Command Information (QCDRCMDI) API
       ech.available=0;
       QCDRCMDI
          ( CMDI0100
          : %Len(CMDI0100)
          : 'CMDI0100'
          : cmd+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //?export API data to DS
       eval-corr ci1 = cmdi0100;
       ci1.prd_mode = %subst(cmdi0100.MODE:1:1);
       ci1.dbg_mode = %subst(cmdi0100.MODE:2:1);
       ci1.svc_mode = %subst(cmdi0100.MODE:3:1);
       ci1.bpgm     = %subst(cmdi0100.allowed:1:1);
       ci1.ipgm     = %subst(cmdi0100.allowed:2:1);
       ci1.exec     = %subst(cmdi0100.allowed:3:1);
       ci1.interact = %subst(cmdi0100.allowed:4:1);
       ci1.batch    = %subst(cmdi0100.allowed:5:1);
       ci1.brexx    = %subst(cmdi0100.allowed:6:1);
       ci1.irexx    = %subst(cmdi0100.allowed:7:1);

       Write cmdi0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e

