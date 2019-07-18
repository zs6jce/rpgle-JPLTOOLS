SET CURRENT SCHEMA JPLTOOLS
;
DROP TABLE          Flddsc
monmsg ST42704
;
CREATE TABLE          Flddsc   (
--1234567890                1234567890

  DATETIME_CODE  for column datetime   bigint ,
  BASE_CATALOG   for column base_cat   varchar(128) ,
  BASE_COLUMN    for column base_col   varchar(128) ,
  BASE_sys_COLUMN    for column basesyscol   varchar(10) ,
  BASE_SCHEMA    for column base_sch   varchar(128) ,
  BASE_sys_SCHema    for column base_lib   varchar(10) ,
  BASE_TABLE     for column base_tab   varchar(128) ,
  BASE_sys_TABLE     for column basesystab   varchar(10) ,
  CCSID                                bigint ,
  COLUMN_CAT_NAM for column col_cat    varchar(128) ,
  COL_GENERATED  for column col_gen    bigint ,
  COL_GEN_TYPE   for column col_type   bigint ,

  view_column    for column view_col   varchar(128) ,

  view_sys_schema for column view_lib            varchar(10 ) ,
  view_schema for column view_sch            varchar(128) ,
  view_sys_TABLE  for column viewsystab          varchar(10 ) ,
  view_TABLE  for column view_tab          varchar(128) ,
  UPDATABILITY   for column col_upd    bigint ,
  CORRELATION    for column correl     varchar(128) ,
--CURSOR                               varchar(128) ,
  LABEL                                varchar( 60) ,
  PARAMETER_NAME for column param_name varchar(128) ,


  SYSCOL_NAME    for column syscol     char(10),

  KEY_MEMBER                           bigint ,
  LENGTH                               bigint ,
  LEVEL                                bigint ,
  NAME                                 varchar(128) ,
  NULLABLE                             bigint ,
  OCTET_LENGTH   for column len_octet  bigint ,
  PAR_MODE                             bigint ,
  PAR_ORDINAL    for column par_ord    bigint ,
  PAR_CATALOG    for column par_cat    varchar(128) ,
  PAR_NAME                             varchar(128) ,
  PAR_SCHEMA                           varchar(128) ,
  PRECISION                            bigint ,

  RETN_LENGTH    for column rtn_len    bigint ,
  RETN_OCTET_LEN for column rtn_octet  bigint ,
  SCALE                                bigint ,
  TYPE                                 bigint ,
  UNNAMED                              bigint ,
  UDEF_CATALOG   for column udef_cat   varchar(128) ,
  UDEF_NAME                            varchar(128) ,
  UDEF_SCHEMA    for column udef_sch   varchar(128) ,
  UDEF_CODE                            varchar(128)
  )
monmsg ST01567
;

LABEL ON COLUMN          FLDDSC
( BASE_CATALOG IS 'Base Sys Database'
, BASE_COLUMN IS 'Base Sql Column'
, BASE_sys_SCHEMA IS 'Base Sys Library'
, BASE_TABLE IS 'Base Sql Table'
, COLUMN_CAT_NAM IS 'View Sys Database'
, view_COLumn IS 'View Sql Column'
, view_sys_schema IS 'View Sys Library'
, view_sys_table IS 'View Sys View'
, SYSCOL_NAME IS 'View Sys Column'
, NAME IS 'View Sql Column(2)'
, base_sys_column is 'base Sys Column'
, base_schema     is 'base Schema'
, base_sys_table  is 'base Sys Table'
)
;
LABEL ON COLUMN          FLDDSC
( BASE_CATALOG text IS 'Base Sys Database'
, BASE_COLUMN text IS 'Base Sql Column'
, BASE_sys_SCHEMA text IS 'Base Sys Library'
, BASE_TABLE text IS 'Base Sql Table'
, COLUMN_CAT_NAM text IS 'View Sys Database'
, view_column text IS 'View Sql Column'
, view_sys_schema text IS 'View Sys Library'
, view_sys_table text IS 'View Sys View'
, SYSCOL_NAME text IS 'View Sys Column'
, NAME text IS 'View Sql Column(2)'
, base_sys_column text is 'base Sys Column'
, base_schema     text is 'base Schema'
, base_sys_table  text is 'base Sys Table'
)
;



