


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_atlo0100o    e             disk    usropn extfile(f_atlo0100)
     f                                     rename(t_atlo0100:atlo0100f)
     f                                     prefix('AT0.')
     fT_atlo0110o    e             disk    usropn extfile(f_atlo0110)
     f                                     rename(t_atlo0110:atlo0110f)
     f                                     prefix('AT1.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_atlo0100      s             21
     d f_atlo0110      s             21

     d at0           e ds                  extname(t_atlo0100:*output) qualified
     d at1           e ds                  extname(t_atlo0110:*output) qualified

     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)

      * List Objects Secured by Authorization List (QSYLATLO) API
     d QSYLATLO        pr                  extpgm('QSYLATLO')
     d usrspc                        20    const
     d format                         8    const
     d Qualautl                      20    const
     d Error_code                   255           options( *varsize )


     d atlo0100        ds          5000    qualified based(patlo0100)
     d  name                         10
     d  lib                          10
     d  type                         10
     d  holder                        1
     d  asplib                       10
     d  aspname                      10


    ?
    ?

     d atlo0110        ds          5000    qualified based(patlo0110)
     d   PathOff                     10i00
     d   PathLen                     10i00
     d   Type                        10
     d   holder                       1
     d                                1
     d   ASPname                     10

     d Path            ds                  qualified based(pPath)
     d   ccsid                       10i00
     d   country                      2
     d   language                     3
     d                                3
     d   flag                        10i00
     d   bytesInPath                 10i00
     d   Delimiter                    2
     d                               10
     d   name                       500c   ccsid(1200)
     d
     d

     d AutList         s             20    inz('AUTLIST   QTEMP     ')


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



     d  SPGIobj        s             20

     d rtvautlr        pr
     d p_OBJ                         10

     d p_mbropt                      10
     d p_atlo0100                    20
     d p_atlo0110                    20

     d rtvautlr        pi
     d p_OBJ                         10
     d p_mbropt                      10
     d p_atlo0100                    20
     d p_atlo0110                    20

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










     c/free

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl
          ;
       f_atlo0100 = %Trim(%Subst(p_atlo0100:11:10))
          +'/'+%Subst(p_atlo0100:01:10);
       f_atlo0110 = %Trim(%Subst(p_atlo0110:11:10))
          +'/'+%Subst(p_atlo0110:01:10);

       cleanup_outfile(p_atlo0100: 'T_ATLO0100':p_mbropt
          :'QSYS Object list                           ');
       cleanup_outfile(p_atlo0110: 'T_ATLO0110':p_mbropt
          :'IFS object list                            ');

       //? create the user space
       Quscrtus (autList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib : autList : Attributes : ech );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       Open(E) T_atlo0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_atlo0110;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

B01
          Do_Objlist()         ;

       Close(E) T_atlo0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_atlo0110;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Qusdltus (autList:ech);

       message ('':'to transform object list to GRTOBJAUT, use iNavSql:'
       +'select ''cl:GRTOBJAUT OBJ(''concat trim( lib) concat ''/'' concat '
       +'name concat '') OBJTYPE('' concat "TYPE" concat '') '
       +'AUTL(newautl);'' cmd from mylib.atlo0100 '
       );





       message ('':'To transform path list to CHGAUT, use iNav:'
       +'select ''cl:CHGAUT OBJ(''''''concat trim( path)  concat '''''') '
       +'AUTL(newautl);'' cmd    from mylib.atlo0110 '
       );



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
     d   text                        50    const
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
       // LABEL ON TABLE QJRN_UTILS/MODL0300 IS 'MODs: procedures'
          MySQL = 'label on table '
             + %Subst(qualfile :11:10) + '/'
             + %Subst(qualfile :01:10)
             + ' is ''' + text + '''';
          Exec Sql execute Immediate : MySQL;
B02       If Sqlcode <> 0 And Sqlcode <> 100;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e




BPR ?p do_objlist      b
    ? *=-----------------------------------------------------------------------
     d do_objlist      pi

    ?d*=---------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s             10i 0
      /free
       ech .available=0;
       qsylatlo
          (autList
          :'ATLO0110'
          :p_OBJ   //?parametre pgm
          :ech
          );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       Qusptrus(autList : pLAH);
          patlo0110 = pLAH + lah.Data_offset;
B01    For i = 0 To lah.Count - 1;
B02       ppath = plah           +atlo0110.pathoff;

X02
       //?export API data to DS
       at1.TYPE        = atlo0110.TYPE     ;
       at1.HOLDER      = atlo0110.HOLDER    ;
       at1.ASPNAME     = atlo0110.ASPNAME    ;
       at1.path = %subst(path.name:1:%int(path.bytesinpath/2));

X02
       Write atlo0110f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

          patlo0110+= lah.entry_size + atlo0110.pathlen;
E02
E01    Endfor;
       ech .available=0;
       qsylatlo
          (autList
          :'ATLO0100'
          :p_OBJ   //?parametre pgm
          :ech
          );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       Qusptrus(autList : pLAH);
B01    For i = 0 To lah.Count - 1;
          patlo0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
B02

X02
       //?export API data to DS
       at0.NAME          = atlo0100.name     ;
       at0.LIB           = atlo0100.lib       ;
       at0.TYPE          = atlo0100.type       ;
       at0.HOLDER        = atlo0100.holder      ;
       at0.ASPLIB        = atlo0100.asplib       ;
       at0.ASPNAME       = atlo0100.aspname       ;





X02
       Write atlo0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

E02
E01    Endfor;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e


