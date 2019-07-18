set current schema &CURLIB
;
monmsg ST02000

--les fichiers SQL

insert into XREFOBJ (
SELECT DBXLB2, DBXLFI , 'SQLFILE ' ,
   'SQLFILE.'  concat DBXATR  , dBXTXT , ''     , now(),'', 11
FROM qsys.qadbxref
WHERE DBXLIB ='&LIB' and ( DBXLB2 <> DBXLIB or  DBXLFI <> DBXFIL )
and dbxfil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;


--le lien               SQLFILE-*FILE

insert into XREFDEP(
SELECT
       DBXLIB, DBXFIL, '*FILE'
     , DBXLB2, DBXLFI , 'SQLFILE'
     , DBXATR, '','',now(), 21
FROM qsys.qadbxref
WHERE DBXLIB ='&LIB' and ( DBXLB2 <> DBXLIB or DBXLFI <> DBXFIL )
and dbxfil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;


--FDEP                  *FILE-*FILE

insert into XREFDEP(
SELECT DBFLB2 , DBFFIL,
case DBFTDP
   when   'D' then '*FILE'
   when 'I' then '*FILE'
   when 'V' then '*FILE'
   when   'F' then 'SqlFunc'
   when 'T' then 'Sqltype'
   else DBFTDP end
, DBFLDP, DBFFDP, '*FILE'
, case DBFTDP
   when 'D' then 'Table'
   when 'I' then 'FarTable'
   when 'V' then 'View'
   else '' end
, '','',now()          , 31
FROM qsys.qadbfdep
WHERE DBFLIB ='&LIB'
and dbffil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;



--Alias-File             ALIAS-*FILE

insert into XREFDEP    (
SELECT DBXALB, trim(DBXAFL) concat '.' concat DBXAMB, 'ALIAS' ,
DBXLib, DBXfil , '*FILE' , '','','',now() , 41
FROM qsys.qadbxref WHERE DBXAMB is not
null and DBXAMB <> '*FIRST'   and dbxalb = '&LIB'
and dbxfil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;


--routines



insert into XREFOBJ    (
SELECT SPECSCHEMA, SPECNAME, RTNTYPE
,    RTNTYPE concat '.' concat routine_body attr ,
coalesce(external_name , '' )text , coalesce(
long_comment, '') ,now(),'' , 51 FROM QSYS2.SYSROUTine
WHERE SPECSCHEMA ='&LIB'
)
;

--polymorphisme          PROCEDURE-PROCEDURE
--                       FUNCTION-FUNCTION
insert into XREFDEP    (
SELECT SPECSCHEMA, SPECNAME, RTNTYPE , RTNSCHEMA, RTNNAME, RTNTYPE
, routine_body ,'','',now() , 61 FROM QSYS2.SYSROUTine WHERE SPECSCHEMA
='&LIB' and SPECNAME <> RTNNAME
)
;

--dependences des routines (func+sqlproc)  (PROCEDURE,FUNCTION)-(FUNCTION,FILE,PROCEDURE,VARIABLE)


insert into XREFDEP    (
SELECT QSYS2.SYSROUTDEP.SPECSCHEMA, QSYS2.SYSROUTDEP.SPECNAME,
QSYS2.SYSROUTINE.RTNTYPE, QSYS2.SYSROUTDEP.BSCHEMA,
QSYS2.SYSROUTDEP.BNAME, QSYS2.SYSROUTDEP.BTYPE , '','','',now() , 71
FROM
QSYS2.SYSROUTDEP, qsys2.sysroutine WHERE
QSYS2.SYSROUTDEP.SPECSCHEMA ='&LIB' and
QSYS2.SYSROUTDEP.SPECSCHEMA= QSYS2.SYSROUTINE.SPECSCHEMA and
QSYS2.SYSROUTDEP.SPECNAME= QSYS2.SYSROUTINE.SPECNAME
)
;

--MQT                        *FILE-*FILE


insert into XREFDEP    (
SELECT BSCHEMA, BNAME, '*FILE ' , TABSCHEMA, TABNAME , '*FILE',
'MQT' ,'','',now()  , 81 FROM QSYS2.SYStableDEP WHERE TABSCHEMA
='&LIB'
)
;

--Constraint

insert into XREFOBJ    (
SELECT DBCCNL, DBCCNM, DBCCTY , dbccty attr, '' text, '' info, now(),'' , 91
FROM QSYS.QADBFCST WHERE dbccn2 = '&LIB'
and dbccnm not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;

--PK, Check               *FILE-(PRIMARY KEY,CHECK,FOREIGN KEY,UNIQUE)
insert into XREFDEP    (
SELECT DBXLB2, DBXLFI, '*FILE' ,DBCCNl, DBCCNM , dbccty ,
'','','',now() , 101 FROM QSYS.QADBFCST, QSYS.QADBXREF WHERE dBCCFF =
DBXFIL AND DBCCFL = DBXLIB and dbccn2 = '&LIB' and dbccty <>
'FOREIGN KEY'
and dbxlfi not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;

--Foreign parent          *FILE-(PRIMARY KEY,CHECK,FOREIGN KEY,UNIQUE)

insert into XREFDEP    (
SELECT DBCPFL, DBCPFF, '*FILE' , DBCCNL, DBCCNM , dbccty , ''
attr,'' text,'' info,now() , 111 FROM QSYS.QADBFCST WHERE dbccn2 =
'&LIB' and dbccty = 'FOREIGN KEY'
and dbcpff not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;

--Foreign Child           (PRIMARY KEY,CHECK,FOREIGN KEY,UNIQUE)-*FILE

insert into XREFDEP    (
SELECT DBCCNL, DBCCNM , dbccty , DBCCFL, DBCCFF , '*FILE', ''
attr,'' text,'' info,now() , 121 FROM QSYS.QADBFCST WHERE dbccn2 =
'&LIB' and dbccty = 'FOREIGN KEY'
and dbccnm not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;




--domain-file


insert into XREFOBJ    (
SELECT TYPESCHEMA, TYPENAME, 'TYPE',
  'TYPE.' concat SRCTYPE , '' text, '' info  , now(),'' , 131
FROM qsys2.systypes  WHERE TYPESCHEMA ='&LIB'
)
;

--                           TYPE-*FILE
insert into XREFDEP    (
SELECT TYPESCHEMA, TYPENAME , 'TYPE', SYS_DNAME, SYS_TNAME,
'*FILE', SYS_CNAME ,'','',now() , 141 FROM qsys2.syscolumns WHERE
SYS_DNAME ='&LIB' and TYPENAME is not null
and sys_tname not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;


---------------------------------------------------------------------------------


--triggers-                  *FILE-TRIGGER

insert into XREFOBJ    (
SELECT                             TRIGSCHEMA, TRIGNAME, 'TRIGGER',
substr(  'TRIGGER.' concat TRIGTIME concat ' ' concat TRIGEVENT , 1, 20)
                                    , '' text, '' info, now(),'' , 151 FROM
qsys2.systriggers WHERE TRIGSCHEMA ='&LIB'
)
;
insert into XREFDEP    (
SELECT TABSCHEMA, TABNAME,'*FILE', TRIGSCHEMA, TRIGNAME, 'TRIGGER',
TRIGTIME concat ' ' concat TRIGEVENT, '' text, '' info, now() , 161 FROM
qsys2.systriggers WHERE TRIGSCHEMA ='&LIB'
and tabname not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;

--fieldproc-


--mask-

--permission-


--Variable-

--fields-- GET ALL THE sql long names
insert into XREFOBJ (
SELECT DBILB2
, trim( DBILFI ) concat '.' concat trim( DBILFL)
, 'FIELD', 'FIELD' atr, coalesce(
dbitxt, ' ' ) texte , ' ' info , now(),'' , 171
FROM QSYS.QADBIFLD
WHERE dbilib     ='&LIB' /* and dbilfl <> dbifld  */
and dbilfl <> ''   and substr(dbilfl, 1, 3)  <> '*IN'
and dbifil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                               FIELD-FIELD
-- SQL LONG NAMES ARE CHILD OF PF SYSTEM SHORT NAMES
-- GOOD CHOICE ?
insert into XREFDEP (  select
       dbilib lIB, trim(dbifil) concat '.' concat trim(dbiFLD)obj, 'FIELD'
     , dbilb2 lIB, trim(dbilfi) concat '.' concat trim(dbilfl)obj, 'FIELD '
          ,   '1'        info ,'','' ,now() , 181
FROM QSYS.QADBIFLD
WHERE dbilib     ='&LIB'
and (dbilfl <> dbifld  OR DBIFIL <> DBILFI)
and dbilfl <> ''   and substr(dbilfl, 1, 3)  <> '*IN'
and dbifil not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )

)
;


--eliminer les NativesProcs héritées du système : le BNDDIR QC2LE
--revoir WRKBNDPRC2 : pb de detection de _RNI_

--eliminer les exports de symbolProc, ce sont les procédures non exportées (pas difference avec Nati




--série issue des REFFLD : via DSPFFD

--(PF   LF      DSPF    PRTF    table   mqt     view    index)
--est pere de
--(PF   LF      DSPF    PRTF                    table)





