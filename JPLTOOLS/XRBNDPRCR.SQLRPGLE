


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE
      /define  getmessage
      /define  lowercase

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)


    ? * List Module Information (QBNLMODI) API
     d QBNLMODI        pr                  extpgm('QBNLMODI')
     d usrspc                        20    const
     d format                         8    const
     d QualPgm                       20    const
     d Error_code                   255           options( *varsize )

     d MODL0100        ds          5000    qualified based(pMODL0100)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   symbol_type                  1
     d   Reserved                     3
     d   symbol_off                  10i 0
     d   symbol_len                  10i 0
     d   ARGOPT                      10
    ? *=----------------------------------------
     d PGML0100        ds                  qualified  based(pPGML0100)
     d   Program_name                10
     d   Program_lib                 10
     d   module_name                 10
     d   module_lib                  10
     d   Source_name                 10
     d   Source_lib                  10
     d   Source_member...
     d                               10
     d   Module_attr                 10
     d   Module_date                 13
     d   Source_date                 13
     d   Sort_name                   10
     d   Sort_lib                    10
     d   Lang_id                     10
     d   Optimization                10i 0
     d   Maximum_opt                 10i 0
     d   Debug_data                  10
     d   Release_on                   6
     d   Release_for                  6
     d   Reserved1                   20
     d   User_modif                   1
     d   Licpgm                      13
     d   PTF_number                   5
     d   APAR_ID                      6
     d   Creation_data...
     d                                1
     d   Module_CCSID                10i 0
     d   Object_control_level...
     d                                8
     d   perf_coll                    1
     d   Prof_data                   10
     d   Reserved2                    1
     d   Nb_proc                     10i 0
     d   Nb_proc_reordered...
     d                               10i 0
     d   Nb_proc_measured...
     d                               10i 0
     d   Teraspace                    1
     d   Storage_model...
     d                                1
     d   Reserved3                   74
     d   Nb_SQL_stmt                 10i 0
     d   Relational_database...
     d                               18
     d   Commitment_control...
     d                               10
     d   Allow_copy_of_data...
     d                               10
     d   Close_SQL_cursors...
     d                               10
     d   Naming_convention...
     d                               10
     d   Date_format                 10
     d   Date_separator...
     d                                1
     d   Time_format                 10
     d   Time_separator...
     d                                1
     d   Delay_PREPARE...
     d                               10
     d   Allow_blocking...
     d                               10
     d   Default_collection_name...
     d                               10
     d   SQL_package_name...
     d                               10
     d   SQL_package_lib...
     d                               10
     d   Dynamic_user_profile...
     d                               10
     d   SQL_sort_name...
     d                               10
     d   SQL_sort_lib                10
     d   SQL_lang_id                 10
     d   Connection_method...
     d                               10
     d   SQL_path_length...
     d                               10i 0
     d   SQL_path                  3483

     d  SPGL0600       ds                  qualified based(pSPGL0600)
     d  Service_program...
     d                               10
     d  Service_program_library...
     d                               10
     d  Procedure_export_CCSID...
     d                               10i 0
     d  Procedure_export_name_length...
     d                               10i 0
     d  Procedure_export_name...
     d                              256
     d  Uses_argument_optimization...
     d                               10
     d
    ? * List Service Program Information (QBNLSPGM) API
     d qbnlspgm        pr                  extpgm('QBNLSPGM')
     d   UserSpace                   20    const
     d   format                       8    const
     d   QualSrvPgm                  20    const
     d   Error_Code                 256          options(*varsize)

    ? *
     d ModList         s             20    inz('MODLIST   QTEMP     ')
     d srvList         s             20    inz('SRVLIST   QTEMP     ')
     d srvProc         s             20    inz('SRVPROC   QTEMP     ')
     d ProcLah         ds                  likeds(ListApiHeader) based(pProcLah)
     d iProc           s              5i 0
     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_Objlist      pr
     d   type                        10    const

     d un_Module       pr
     d getprc          pr




     d un_SrvPgm       pr



     d  SPGIobj        s             20

     d main            pr                  extpgm('MAIN')
     d main            pi
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
     d   text                        50    const

     d x10             s             10


     d bnd_LIB         s             10
     d bnd_name        s             10
     d OBJ_LIB         s             10
     d rtn_LIB         s             10
     d OBJ_name        s             10
     d OBJ_TYPE        s             10
     d procname        s            256


     d obj_rtnLIB      s             10
     d mod_LIB         s             10
     d mod_rtnLIB      s             10
     d mod_name        s             10

     c/free

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl
          ;
       //?modules user space
       Quscrtus (ModList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : ModList : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?service programs user space
       Quscrtus (srvList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : srvList : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?service procs    user space
       Quscrtus (srvProc:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : srvProc : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?*SYS -> *LIBL
       Exec Sql
          Declare C1 Cursor For
          Select Bndrlb, Bndrnm, Bnolnm, Bnobnm, Bnobtp From  xrbndprcb
          ;
       Exec Sql Open C1;
B01    If Sqlcod <> *zero;
          Escsqler (Sqlcod:Sqlerm);
E01    Endif;

B01    For Ever;
          Exec Sql Fetch C1 Into
             : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             ;
B02       If Sqlcod = 100 ;
             Leave;
E02       Endif;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Getprc();
E01    Endfor;
       Exec Sql Close C1;
B01    If Sqlcod <> *zero;
          Escsqler (Sqlcod:Sqlerm);
E01    Endif;


       Qusdltus (ModList:ech);
       Qusdltus (srvList:ech);



       Return;
    ? /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc


BPR ?p getprc          b
    ? *=-----------------------------------------------------------------------
     d                 pi
     d
    ?d*=---------------------------------

     d i               s              5i 0
      /free
       ech .Available=0;
       //?check object exists
       RtvObjD (OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : OBJ_name +OBJ_LIB
          : OBJ_TYPE
          : ech
          );
B01    If ech.Available>0;
          procname=Getmessage(ech.Msgid:ech.Msgdta);
          obj_rtnLIB = '*NOTFOUND';
          Exec Sql
             Insert Into xrbndprcp  Values
             ( : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             , : obj_rtnLIB
             , ''
             , ''
             , ''
             , : procname )
             ;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Return;
E01    Endif;

       obj_rtnLIB = OBJD0200.Return_lib ;
B01    If OBJ_TYPE = '*MODULE';
          mod_LIB = OBJD0200.Return_lib ;
          mod_name = OBJ_name;
          obj_rtnLIB = '*MODULE';
          OBJ_name = '*MODULE';
          un_Module ( );
X01    Elseif OBJ_TYPE = '*SRVPGM';
          un_SrvPgm ( );
E01    Endif;

B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e




BPR ?p un_module       b
     d                 pi


     d len             s              5i 0
     d off             s              5i 0
     d i               s              5i 0
     d IsExported      s               n
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d USP             s          65535    based(pUSP)
      /free
       ech.Available=0;
       //?The MODL0100 format lists the symbols defined in the module and that are exported to other
       //?modules
       RtvObjD (OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : mod_name +mod_LIB
          : '*MODULE'
          : ech
          );
B01    If ech.Available>0;
          procname=Getmessage(ech.Msgid:ech.Msgdta);
          mod_rtnLIB = '*NOTFOUND';
          Exec Sql
             Insert Into xrbndprcp  Values
             ( : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             , : obj_rtnLIB
             , : mod_LIB
             , : mod_rtnLIB
             , : mod_name
             , : procname )
             ;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Return;
E01    Endif;
       mod_rtnLIB = OBJD0200.Return_lib ;
       ech.Available=0;
       QBNLMODI (ModList
          : 'MODL0100'
          : mod_name+mod_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(ModList : pLAH);
       pMODL0100 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          //?When MODL0100.symbol_type = X'00';
          //?   ML1.Exporttype ='P';
          //?When MODL0100.symbol_type = X'01';
          //?   ML1.Exporttype ='D';
          off = MODL0100.symbol_off;
          len = MODL0100.symbol_len ;
B02       If len > %Size(procname );
             len = %Size(procname );
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             procname = %Subst(usp:1:len) ;
X02       Else;
             procname='*NONE';
E02       Endif;
          //?pour un module de srvpgm, verifier que la procedure est effectivement exportée
B02       If OBJ_TYPE = '*MODULE';
             IsExported = True ;
X02       Else;
             IsExported = False;
B03          For iProc = 0 To ProcLah.Count - 1;
                pSPGL0600 = pProcLah + ProcLah.Data_offset
                   + iProc * ProcLah.entry_size ;
B04             If procname = SPGL0600.Procedure_export_name ;
                   SPGL0600.Procedure_export_name = '';
                   IsExported = True;
                   Leave;
E04             Endif;
E03          Endfor;
E02       Endif;
B02       If IsExported;
             Exec Sql
                Insert Into xrbndprcp  Values
                ( : bnd_LIB
                , : bnd_name
                , : OBJ_LIB
                , : OBJ_name
                , : OBJ_TYPE
                , : obj_rtnLIB
                , : mod_LIB
                , : mod_rtnLIB
                , : mod_name
                , : procname )
                ;
B03          If Sqlcod <> *zero;
                Escsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;
          pMODL0100 += MODL0100.entry_size ;

E01    Endfor;
       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e

BPR ?p un_srvpgm       b
     d                 pi


    ? *=----------------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)

     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       ech.Available=0;
       //?get srv program info - list of all exported procs
       qbnlspgm (srvProc
          : 'SPGL0600'
          : OBJ_name+OBJ_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(srvProc : pProcLah);
       //?get srv program info - list of all modules
       //?2010/02/19 : les structures PGML0100 et SPGL0100 se mappent parfaitement
       qbnlspgm (srvList
          : 'SPGL0100'
          : OBJ_name+OBJ_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? for each module
       //  Qusptrus(srvList : pLAH);
    B  //  For i = 0 To lah.Count - 1;
       //     pPGML0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
       //     mod_name = PGML0100.module_name ;
       //     mod_LIB = PGML0100.Module_lib ;
       //     un_Module();
    E  //  Endfor;

       //?les procedures exportées par le SRVPGM
B01    For iProc = 0 To ProcLah.Count - 1;
          pSPGL0600 = pProcLah + ProcLah.Data_offset
             + iProc * ProcLah.entry_size ;
          procname = SPGL0600.Procedure_export_name ;
B02       If procname <> '';
             Exec Sql
                Insert Into xrbndprcp  Values
                ( : bnd_LIB
                , : bnd_name
                , : OBJ_LIB
                , : OBJ_name
                , : OBJ_TYPE
                , : obj_rtnLIB
                , '*UNKNOWN'
                , '*UNKNOWN'
                , '*UNKNOWN'
                , : procname )
                ;
B03          If Sqlcod <> *zero;
                Escsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;





E01    Endfor;

       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
