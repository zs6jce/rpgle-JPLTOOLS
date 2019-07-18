


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fflddsc    o    e             disk    usropn extfile(f_flddsc  )
     f                                     rename(flddsc  :flddscf)
    ?f*****************                    prefix('SFD.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_flddsc        s             21
     d sfd           e ds                  extname(flddsc  :*output)
     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)











     d FileList        s             20    inz('FILELIST  QTEMP     ')


     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_FileList     pr





     d un_File         pr
     d   file                        10    const
     d   lib                         10    const






     d main            pr                  extpgm('MAIN')
     d p_OBJ                         20

     d p_mbropt                      10
     d p_flddsc                      20

     d main            pi
     d p_OBJ                         20

     d p_mbropt                      10
     d p_flddsc                      20

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
       f_flddsc = %Trim(%Subst(p_flddsc :11:10))
          +'/'+%Subst(p_flddsc :01:10);

       cleanup_outfile(p_flddsc : 'FLDDSC  ':p_mbropt);

       //? create the user space
       Quscrtus (FileList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib :FileList : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       Open(E) flddsc ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Do_FileList();

       Close(E) flddsc ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Qusdltus (FileList:ech);

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
B01    If ech.Available>0;
B02       If ech.Msgid <> 'CPF9812';
            Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
X02       Else;
             //?file is unknown, create it

             Cmd = 'CRTDUPOBJ OBJ('+ modele + ') FROMLIB('
                + Sppglb + ') OBJTYPE(*FILE) TOLIB('
                + %Trim(%Subst(qualfile :11:10)) + ') NEWOBJ('
                + %Trim(%Subst(qualfile :01:10)) + ')';
             QCmdExc ( Cmd : %Len(Cmd));
E02       Endif;
X01    Else;
          //?mode append ?
B02       If mbropt = '*REPLACE';
             MySQL = 'delete from  '
                + %Subst(qualfile :11:10) + '/'
                + %Subst(qualfile :01:10) ;
             Exec Sql execute Immediate : MySQL;
B03          If Sqlcode <> 0 And Sqlcode <> 100;
                Escsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;
E01    Endif;
B00    Begsr *pssr;
       Dump;
E00    Endsr;

      /end-free
EPR  p                 e




BPR ?p do_Filelist     b
    ? *=-----------------------------------------------------------------------
     d                 pi

    ?d*=---------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s              5i 0
      /free
       ech .Available=0;
       quslobj
          (FileList
          :'OBJL0100'
          :p_OBJ   //?parametre pgm
          :'*FILE'   //?parametre proc
          :ech
          );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       Qusptrus(FileList: pLAH);
B01    For i = 0 To lah.Count - 1;
          pOBJL0100 = pLAH + lah.Data_offset + i * lah.Entry_size ;
B02       If OBJL0100.name = 'SYSCHKCST '
X02       Or OBJL0100.name = 'SYSCOLUMNS'
X02       Or OBJL0100.name = 'SYSCST    '
X02       Or OBJL0100.name = 'SYSCSTCOL '
X02       Or OBJL0100.name = 'SYSCSTDEP '
X02       Or OBJL0100.name = 'SYSFIELDS '
X02       Or OBJL0100.name = 'SYSINDEXES'
X02       Or OBJL0100.name = 'SYSKEYCST '
X02       Or OBJL0100.name = 'SYSKEYS   '
X02       Or OBJL0100.name = 'SYSPACKAGE'
X02       Or OBJL0100.name = 'SYSREFCST '
X02       Or OBJL0100.name = 'SYSTABDEP '
X02       Or OBJL0100.name = 'SYSTABLES '
X02       Or OBJL0100.name = 'SYSTRIGCOL'
X02       Or OBJL0100.name = 'SYSTRIGDEP'
X02       Or OBJL0100.name = 'SYSTRIGGER'
X02       Or OBJL0100.name = 'SYSTRIGUPD'
X02       Or OBJL0100.name = 'SYSVIEWDEP'
X02       Or OBJL0100.name = 'SYSVIEWS  ';
             Iter;
X02       Else;
             un_File (OBJL0100.name:OBJL0100.lib );
E02       Endif;
E01    Endfor;
B00    Begsr *pssr;
       Dump;
E00    Endsr;

      /end-free
EPR  p                 e


BPR ?p un_file         b
     d                 pi
     d   file                        10    const
     d   lib                         10    const



     d iCol            s              5i 0
     d nbcol           s              5i 0

      /free

       MySQL = 'select * from ' + lib +'/'+file;
       Exec Sql Prepare Somesql From : MySQL ;
B01    If Sqlcod <> 0;
             // Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;

       Exec Sql Allocate Descriptor 'MyDescriptor' With Max 1024 ;
B01    If Sqlcod <> 0;
          escsqler(sqlcod:sqlerm);
          Return;
E01    Endif;
       Exec Sql Describe Somesql Using Descriptor
          Local 'MyDescriptor';
B01    If Sqlcod <> 0;

          Return;
E01    Endif;

       Exec Sql Get Descriptor 'MyDescriptor' : nbcol = Count;
B01    If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;

B01    For iCol = 1 To nbcol;
          Clear sfd ;
          Exec Sql Get Descriptor 'MyDescriptor' Value :iCol
          // : Cardinality = Cardinality                   not compatible with V5R4
               : Datetime = Datetime_interval_code
             , : Base_cat = Db2_base_catalog_name
             , : Base_col = Db2_base_column_name
             , : Base_lib = Db2_base_schema_name
             , : Base_tab = Db2_base_table_name
             , : Ccsid = Db2_ccsid
             , : Col_cat = Db2_column_catalog_name
             , : Col_gen = Db2_column_generated
             , : Col_type = Db2_column_generation_type
          // , : Col_hidden = Db2_column_hidden            not compatible with V5R4
             , : view_col    = Db2_column_name
          // , : Col_chg = Db2_column_row_change           not compatible with V5R4
             , : view_lib = Db2_column_schema_name
             , : viewsystab = Db2_column_table_name
             , : Col_upd = Db2_column_updatability
             , : Correl = Db2_correlation_name
             , : Label = Db2_label
             , : Param_name = Db2_parameter_name
             , : Syscol = Db2_system_column_name
             , : Key_member = Key_member
             , : Length = Length
             , : Level = Level
             , : name = name
             , : Nullable = Nullable
             , : Len_octet = Octet_length
             , : Par_mode = Parameter_mode
             , : Par_ord = Parameter_ordinal_position
             , : Par_cat = Parameter_specific_catalog
             , : Par_name = Parameter_specific_name
             , : Par_schema = Parameter_specific_schema
             , : Precision = Precision
          // , : Rtn_card = Returned_cardinality           not compatible with V5R4
             , : Rtn_len = Returned_length
             , : Rtn_octet = Returned_octet_length
             , : Scale = Scale
             , : type = type
             , : Unnamed = Unnamed
             , : Udef_cat = User_defined_type_catalog
             , : Udef_name = User_defined_type_name
             , : Udef_sch = User_defined_type_schema
             , : Udef_code = User_defined_type_code ;
B02       If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
             Return;
E02       Endif;
          Write Flddscf ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;



       Exec Sql Deallocate Descriptor 'MyDescriptor' ;
B01    If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;

          // view info
          //   schema  sys     -> syscolumns -> sql
          //   table   sys     -> syscolumns -> sql
          //   column  sql sys
       mysql =
          'update '
          +       %Trim(%Subst(p_flddsc :11:10))
          +'.'+%Subst(p_flddsc :01:10)
          + ' fld '
        + 'SEt   (view_schema, view_TABLE , view_column ) = '
        + '(select '
        + 'COL.TABLE_SCHEMA ,'
        + 'col.TABLE_NAME ,'
        + 'COL.COLUMN_NAME '
        + 'from qsys2.syscolumns col WHERE '
        + 'fld.VIEW_LIB=COL.SYS_DNAME and '
        + 'fld.VIEWSYSTAB=COL.SYS_TNAME and '
        + 'fld.sYSCOL = COL.SYS_CNAME '
        + ')';

       exec sql execute immediate : mysql
        ;
B01    If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;
          // base info
          //   schema  sys -> qadbxref idx qadbxlfi -> sql
          //   table   sql ->                       -> sql
          //   column  sql

       mysql =
          'update '
          +       %Trim(%Subst(p_flddsc :11:10))
          +'.'+%Subst(p_flddsc :01:10)
          + ' fld '
         + 'SET (fld.base_schema, fld.base_sys_table) = '
         + '(select SYS.DBXLB2, SYS.DBXFIL FROM qsys.qadbxref sys WHERE '
         + 'fld.BASE_SYS_SCHEMA = sys.dbxlib and '
         + 'fld. BASE_TABLE = sys.dbxlfi )';
       exec sql execute immediate : mysql
        ;
B01    If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;
       mysql =
          'update '
          +       %Trim(%Subst(p_flddsc :11:10))
          +'.'+%Subst(p_flddsc :01:10)
          + ' fld '
        + 'SET FLD.BASESYSCOL= (select COL.SYS_CNAME '
        + 'FROM qsys2.syscolumns col '
        + 'WHERE FLD.BASE_SCH= COL.DBNAME and '
        + 'FLD.BASE_TAB= COL.TBNAME and '
        + 'FLD.BASE_COL= COL.NAME )';
       exec sql execute immediate : mysql
        ;
B01    If Sqlcod <> 0;
                Escsqler (Sqlcod:Sqlerm);
          Return;
E01    Endif;
       Return;
B00    Begsr *pssr;
       Dump;
E00    Endsr;
      /end-free
EPR  p                 e

