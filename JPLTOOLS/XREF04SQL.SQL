
************************ rules 501 to 761 **********************************

set current schema &CURLIB
;

-- metadata files are created with XREF02, one library at a time
monmsg ST02000
-- objets

insert into XREFOBJ (
SELECT ODLBNM, ODOBNM, ODOBTP
,    trim(ODOBTP) concat '.' concat ODOBAT ,ODOBTX ,
case when oducen = '' then 'LASTUSED(*NONE)' else
'LASTUSED(' concat trim(char( oducen+ 19)) concat odudat concat
') DAYSUSED(' concat trim( char(oducnt ) ) concat ')' end
, now()     ,''    , 501
FROM OBJS
where odobnm not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;


--Membres source

insert into XREFOBJ (
SELECT MLLIB, trim( MLFILE) concat '.' concat MLNAME, 'SRCMBR',
'SRCMBR.' concat MLSEU2, MLMTXT , case when MLCHGc = '' then ' ' else trim(char(
MLCHGC+ 19)) concat MLCHGD concat '-' concat MLCHGt end , now() ,'' , 511
FROM MBRLIST
left join fd_atr
on PHFILE=mlfile and
   PHLIB=mllib
where  PHDTAT ='S'
)
;



--xref                       *CMD-*PGM
monmsg ST02000
insert into XREFDEP (
SELECT CMDPGMLIB, CMDPGM, '*PGM' , COMMAND_LIBRARY_NAME,
COMMAND_NAME, '*CMD'
, '','','',now(), 521
fROM CMDI0100
                           )
;

--xref                       SRCMBR-*CMD

insert into XREFDEP (
SELECT SOURCE_FILE_LIBRARY_NAME, trim( SOURCE_FILE_NAME) concat '.'
concat SOURCE_FILE_MEMBER_NAME, 'SRCMBR', COMMAND_LIBRARY_NAME,
COMMAND_NAME, '*CMD'
, '','','',now() , 531
FROM CMDI0100
)
;

--xref programmes

--                           SRCMBR-MODULE

insert into XREFDEP (
SELECT SOURCE_LIB, trim(SOURCE_NAME) concat '.' concat
  SOURCE_MBR, 'SRCMBR', MODULE_LIB,
MODULE_NAME, '*MODULE' ,        MODULE_ATTR
    ,'','',now() , 541 FROM MODI0100
)
;

--                           MODULE-PROC

insert into XREFDEP (
SELECT MODULE_LIB, MODULE, '*MODULE', '', EXPORTED_SYMBOL, case
SYMBOL_TYPE when 'P' then 'NativeProc' else 'SymbolData' end
, 'Export','','',now() , 551 from MODl0100
)
;

--                           PROC(=SYMBOL)-MODULE

insert into XREFDEP (
SELECT '', IMPORTED_SYMBOL , case SYMBOL_TYPE when 'P' then
'NativeProc' else 'Data' end ,MODULE_LIB, MODULE, '*MODULE'
, 'Import','','',now() , 561
FROM MODl0200
)
;

--                           SRCMBR-OLDPGM

insert into XREFDEP (
SELECT SOURCE_FILE_LIBRARY_NAME, trim( SOURCE_FILE_NAME) concat '.'
concat SOURCE_FILE_MEMBER_NAME , 'SRCMBR', PROGRAM_LIBRARY_NAME,
PROGRAM_NAME, '*PGM' , 'No Module','','',now() , 571
FROM pgmi0100 WHERE SOURCE_FILE_MEMBER_NAME <> ''
)
;


--                           MODULE-PGM

insert into XREFDEP (
SELECT MODULE_LIB, MODULE_NAME, '*MODULE', PROGRAM_LIB,
PROGRAM_NAME, "TYPE" , MODATTR ,'','',now() , 581 FROM pgml0100
)
;
-- compilations directes : via un module dans QTEMP
-- ajouter l'objet module et la reference au source
insert into XREFOBJ (
SELECT module_lIB, module_name, '*MODULE'
,     '*MODULE.' concat module_attr,
'' text, module_date concat '<-' concat source_date  info
, now(),'' , 591
FROM pgml0100 where module_lib = 'QTEMP'
)
;
--QTEMPSRC                   SRCMBR-*MODULE
insert into XREFDEP (
SELECT SOURCE_LIB, trim(SOURCE_NAME) concat '.' concat
  SOURCE_MemBeR, 'SRCMBR', MODULE_LIB,
MODULE_NAME, '*MODULE' ,        MODULE_ATTR
    ,'','',now() , 601 FROM pgml0100   where module_lib = 'QTEMP'
)
;











--                           SRVPGM-PGM

insert into XREFDEP (
SELECT case when SRVPGM_LIB < ' ' then ' ' else srvpgm_lib end ,
SRVPGM_NAME , '*SRVPGM' ,PROGRAM_LIB, PROGRAM_NAME, "TYPE" ,
'','','',now() , 611 FROM pgml0200 WHERE SRVPGM_LIB <> 'QSYS' )
;

--                           SRVPGM-NativeProc

insert into XREFDEP (
SELECT SRVPGMLIB, SRVPGM, '*SRVPGM', '', PROC_NAME , 'NativeProc'
, 'Export','','',now() , 621
FROM spgl0600   WHERE               SRVPGMLIB <> 'QSYS'
)
;


--pgmref


alter table pgmref add column whptyp char (10 ) not null
with default
;

UPDATE PGMREF
SET WHPTYP = case
when whspkg ='P' then '*PGM'
when whspkg ='S'then '*SQLPKG'
when whspkg ='V' then '*SRVPGM'
when whspkg ='M' then '*MODULE'
when whspkg ='Q' then'*QRYDFN' end
;


insert into XREFDEP (
SELECT DISTINCT
  cast(whlnam as char(10)) called_lib
, cast(whfnam as char(10)) called
, whotyp called_type
, whlib caller_lib
, whpnam caller
, cast (case
   when whspkg ='P' then '*PGM'
   when whspkg ='S' then '*SQLPKG'
   when whspkg ='V' then '*SRVPGM'
   when whspkg ='M' then '*MODULE'
   when whspkg ='Q' then '*QRYDFN' end as  char(10)) as caller_type
, case WHFUSG
   when 1 then 'I'
   when 2 then  'O'
   when 3 then 'I/O'
   when 4 then 'U'
   when 5 then 'I/U'
   when 6 then 'O/U'
   when 7 then 'I/O/U'
   when 8 then 'N/S'
   else ' ' end usage
,'','',now() , 631
FROM pgmref
)
;


--Fichiers
--zones noms interne, externe, alias. le nom sql long (plus de 32) ? -> xrref0x via qsys/QADBxx
insert into XREFOBJ (
SELECT whlib  lIB, trim(whfile) concat '.' concat trim(WHFLDe) obj
 , 'FIELD', 'FIELD' atr , WHFTXT texte , ' ' info , now(),'' , 641
FROM ffd_atr
where whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
* fldi is different than fdle and is not already selected as flde
insert into XREFOBJ (
SELECT distinct whlib  lIB, trim(whfile) concat '.' concat
trim(WHFLDi) obj
 , 'FIELD', 'FIELD' atr , WHFTXT texte , ' ' info , now(),'' , 741
FROM ffd_atr fldi  where fldi.whfldi <> fldi.whflde     and
not exists ( select 1 from  ffd_atr flde where
fldi.whlib = flde.whlib
and fldi.whfile=flde.whfile and fldi.whfldi = flde.whflde)
and fldi.whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
                      )
;
-- GET SQL LONG NAMES WITH LENGTH <= 32
-- DUPLICATES RULES 171 ? YES
--insert into XREFOBJ (
--SELECT whlib  lIB, trim(whfile) concat '.' concat trim(WHalis) obj
-- , 'FIELD', 'FIELD' atr , WHFTXT texte , ' ' info , now(),'' , 661
--FROM ffd_atr  where whalis <> ''
--and   whfile not in (
--'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
--'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
--'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
--'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
--'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
--)
--;
--                           *FILE-FIELD
insert into XREFDEP (
SELECT whlib    , whfile, '*FILE',  ' '  lib  ,
       trim(whfile) concat '.' concat trim(whflde)      obj
, 'FIELD ',       whftxt info ,'','' ,now()  , 671
 FROM       ffd_atr
where whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                           *FILE-FIELD
insert into XREFDEP (
SELECT distinct whlib    , whfile, '*FILE',  ' '  lib  ,
       trim(whfile) concat '.' concat trim(whfldi)      obj
, 'FIELD ',       whftxt info ,'','' ,now()  , 751
 FROM       ffd_atr  fldi  where whflde <> whfldi and
not exists ( select 1 from  ffd_atr flde where
fldi.whlib = flde.whlib
and fldi.whfile=flde.whfile and fldi.whfldi = flde.whflde)
and   whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                           FIELD-FIELD
insert into XREFDEP (
SELECT whlib  lIB, trim(whfile) concat '.' concat trim(whfldi)obj, 'FIELD'
     , whlib  lIB, trim(whfile) concat '.' concat trim(whflde)obj
, 'FIELD ', '1-' concat whftxt info ,'','' ,now() , 681
 FROM       ffd_atr   where whfldi <> whflde
and whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                           FIELD-FIELD
-- COBOL ALIAS NAMES : LONG FIELD NAME (<= 32 CHARS) IN PF
insert into XREFDEP (
SELECT whlib  lIB, trim(whfile) concat '.' concat trim(whflde)obj, 'FIELD'
     , whlib  lIB, trim(whfile) concat '.' concat trim(whalis)obj
, 'FIELD ', '2-' concat whftxt info ,'','' ,now() , 691
 FROM       ffd_atr  where whalis <> ''   and whflde <> whalis
and whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                           FIELD-FIELD
insert into XREFDEP (
SELECT whrlib lIB, trim(whrfil) concat '.' concat trim(whrfld), 'FIELD'
     , whlib  lIB, trim(whfile) concat '.' concat trim(whflde) obj
, 'FIELD ', 'REFFLD' concat
'(' concat char(whrcde) concat ')'
       info ,'','' ,now() , 701
 FROM       ffd_atr    where whrfil <> ''
-- and WHFTYP  in ('P', 'L')
--   and whrfld <> whflde
and whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
--                           *FILE-*FILE
insert into XREFDEP (
SELECT distinct whrlib , whrfil, '*FILE', whlib  , whfile obj
, '*FILE', 'REFFLD'     info ,'','' ,now() , 711
 FROM       ffd_atr    where whrfil <> ''
-- and WHFTYP  in ('P', 'L')
     and whrfil <> whfile
and whfile not in (
'SYSCHKCST ', 'SYSCOLUMNS', 'SYSCST    ', 'SYSCSTCOL ',
'SYSCSTDEP ', 'SYSFIELDS ', 'SYSINDEXES', 'SYSKEYCST ',
'SYSKEYS   ', 'SYSPACKAGE', 'SYSREFCST ', 'SYSTABDEP ',
'SYSTABLES ', 'SYSTRIGCOL', 'SYSTRIGDEP', 'SYSTRIGGER',
'SYSTRIGUPD', 'SYSVIEWDEP', 'SYSVIEWS  ' )
)
;
-- les dependances de VIEW a TABLE     FIELD-FIELD
-- mais sans les zones calculées
insert into XREFDEP (  select
  BASE_lib    , trim(BASEsystab) concat '.' concat basesyscol , 'FIELD'
, view_lib    , trim(viewsystab) concat '.' concat     syscol , 'FIELD'
, 'PF2LF' info
,'','' ,now() , 721
 FROM       flddsc
 where base_lib <> base_sch or
       basesystab <> base_tab or
       basesyscol <> syscol
   and (base_lib is not null and basesystab is not null
        and basesyscol is not null and COL_GENERATED = 0)
)
;
insert into XREFDEP (  select
  BASE_sch    , trim(BASE_tab) concat '.' concat base_col , 'FIELD'
, view_sch    , trim(view_tab) concat '.' concat view_col , 'FIELD'
, 'PF2LF' info
,'','' ,now() , 761
 FROM       flddsc
 where  base_sch is not null and base_tab is not null
        and base_col is not null  and COL_GENERATED = 0
        and base_sch <> view_sch
)
;
--les fichiers systeme


-- LES PROFILS UTILISATEURS

-- LES AUTORISATIONS SUR LES OBJETS



