set current schema &CURLIB
;
monmsg ST02000
-- delete NativeProc inherited from the Operating System
-- otherwise the analysis is at instruction level. Too deep.

DELETE FROM XREFDEP XR
WHERE PARENT_TYP ='NativeProc'
  and exists (
    select 1 from XRbndprcp pr
    where XR.parent_obj = pr.procname)
;

-- refresh ATTR for *FILE with the SQL attribute

--update XREFobj XR set attr =                        coalesce(
--   (select dbxatr from qsys.qadbxref db
--    where XR.lib=db.dbxlib and XR.object = db.dbxfil
--                 and XR."TYPE" = '*FILE'   )
--   , attr)
--;
--preparation du xref recursif

update XREFdep set parent_lib = '' where parent_lib < ' '
;

UPDATE XREFDEP SET PARENT_LIB = trim(PARENT_LIB),
PARENT_OBJ = trim(PARENT_OBJ), PARENT_TYP = trim(PARENT_TYP),
CHILD_LIB = trim(CHILD_LIB ), CHILD_OBJ = trim(CHILD_OBJ ),
CHILD_TYP = trim(CHILD_TYP ), CHILD_INFO = trim(CHILD_INFO )
;

UPDATE XREFobj
set LIB    = trim(LIB   ),
    OBJECT = trim(OBJECT),
    "TYPE" = trim("TYPE"),
    ATTR   = trim(ATTR  ),
    TEXT   = trim(TEXT  ),
    INFO   = trim(INFO  )
;
-- lib ? pas lib ? pas lib.
UPDATE XREFDEP SET PARENT_KEY = parent_object concat '.'
concat parent_type, CHILD_KEY = child_object concat '.' concat
child_type
;
UPDATE XREFobj SET object_KEY =        object concat '.'
concat        type
;


-- delete duplicates
create table qtemp.wwrefobj as (
SELECT DISTINCT LIB, OBJECT, "TYPE", ATTR, TEXT, INFO,
min(RTV_TIME) rtv_time, OBJECT_KEY, sum(RULE_NUMBER) rule_number
FROM XREFobj
GROUP BY LIB, OBJECT, "TYPE", ATTR, TEXT, INFO, OBJECT_KEY
) with data
;
 MONMSG ST42704
 DROP TABLE    XREFobjWITHDUP
;
 MONMSG ST01567
 CREATE TABLE  XREFOBJWITHDUP AS (SELECT * FROM XREFOBJ ) WITH DATA
;
 MONMSG *ESCAPE
 delete   from XREFobj
;
 insert into XREFobj select * from qtemp.wwrefobj
;
* child_info varie beaucoup, en particulier sur les dep FIELD-FIELD
create table qtemp.wwrefdep as (
   SELECT DISTINCT PARENT_LIB, PARENT_OBJ, PARENT_TYP, CHILD_LIB,
   CHILD_OBJ, CHILD_TYP, min( CHILD_INFO) CHILD_INFO, PARENT_KEY, CHILD_KEY,
   min(RTV_TIME) RTV_TIME, sum( rule_number) rule_number
   FROM XREFdep GROUP BY PARENT_LIB, PARENT_OBJ,
   PARENT_TYP, CHILD_LIB, CHILD_OBJ, CHILD_TYP, PARENT_KEY, CHILD_KEY

                               ) with data
;
 MONMSG ST42704
 DROP TABLE    XREFDEPWITHDUP
;
 MONMSG ST01567
 CREATE TABLE  XREFDEPWITHDUP AS (SELECT * FROM XREFDEP ) WITH DATA
;
 MONMSG *ESCAPE
 delete   from XREFdep
;
 insert into XREFdep select * from qtemp.wwrefdep
;

----------------------------------------------------------------------------------------------------
--set current schema &CURLIB
--;
--/* search for the childs, building a title with the links */
--with cascade (Parent, title_Parent, Child, title_Child , level, Child_key) as (
--    select parent_key Parent,
--        cast(trim(parent_lib) concat '/'  concat trim(parent_key)
--          as varchar(1000) ) title_Parent
--      , child_key Child
--      , cast(trim(child_lib) concat '/'  concat trim(child_key)   as varchar(100) ) title_Child
--      , 1 level
--      , child_key Child_key
--    from XREFdep
--/* here choose the Parent to analyze */
--  where parent_obj='CUSTOMER'
--    union all
--    select
--        cascade.Parent
--      , cascade.title_Parent concat ' > '  concat cascade.title_Child
--      , child.child_key
--      , cast(trim(child.child_lib) concat '/'   concat trim(child.child_key)   as varchar(100) )
--          title_Child
--      ,  level + 1
--      , child.child_key
--    from  cascade, XREFdep child
--    where cascade.Child_key = child.parent_key
--/* here is a loop stopper */
--        and cascade.title_Child not like '% ' concat trim(child.child_obj) concat ' %'
--/* here is another loop stopper */
--       -- and cascade.level <= 3
--/* here choose the Child to follow */
----
--) select cascade.* from cascade  order by title_Parent
--;
--select count(*) from XREFdep
--;
----------------------------------------------------------------------------------------------------
--/* search for the dependent objects */
--
--with cascade (lib, object, type, level, object_key, direction, link) as (
--select lib, object, type, 1 level, object_key, 'O',
--cast(object_key as varchar(100))
--from XREFobj
--WHERE OBJECT='ORDERS' and "TYPE" = '*FILE'
--/* search for the childs*/
--union all
--select child_lib, child_object, child_type, level + 1, child.child_key, 'C',
--cascade.link concat '>' concat child.child_key
--from  cascade, XREFdep child
--where cascade.object_key = child.parent_key
--/* here are the loop stoppers */
--and cascade.link not like '%' concat child.child_key concat '%'
--and cascade.level <= 3
--/* search for the parents*/
--union all
--select parent_lib, parent_object, parent_type, level + 1, parent.parent_key, 'P',
--cascade.link concat '<' concat parent.parent_key
--from  cascade, XREFdep parent
--where cascade.object_key = parent.child_key
--/* here are the loop stoppers */
--and cascade.link not like '%' concat parent.parent_key concat '%'
--and cascade.level <=3
--) , dedup as (select distinct lib, object, type from cascade)
----select type, count(*) nb from dedup group by type
--select * from dedup order by type, object, lib
--;
----------------------------------------------------------------------------------------------------
--/* search for dependencies between objects
--with cascade (level, parent_key, child_key, direction, link) as (
--    select 1 level, object_key,object_key, 'O', cast(object_key as varchar(100))
--    from XREFobj
--/* here choose the Parent to analyze */
-- WHERE OBJECT='ORDERS' and "TYPE" = '*FILE'
--    union all
--    select level + 1, cascade.child_key, child.child_key, 'C',
--    cascade.link concat '>' concat child.child_key
--    from  cascade, XREFdep child
--    where cascade.child_key = child.parent_key
--/* here is a loop stopper */
--        and cascade.link not like '%' concat child.child_key concat '%'
--/* here is a loop stopper */
--       and cascade.level <= 3
--/* here choose the Child to follow */
----
--   union all
--    select level + 1, parent.parent_key, cascade.parent_key, 'P',
--    cascade.link concat '<' concat parent.parent_key
--    from  cascade, XREFdep parent
--    where cascade.parent_key = parent.child_key
--/* here is a loop stopper */
--        and cascade.link not like '%' concat parent.parent_key concat '%'
--/* here is a loop stopper */
--       and cascade.level <=3
--/* here choose the Child to follow */
----
--), dedup as (select distinct parent_key, child_key from cascade)
--
--select * from dedup
--;
----------------------------------------------------------------------------------------------------
