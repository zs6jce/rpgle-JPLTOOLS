     c/exec sql
     c+   CREATE TABLE qtemp/XMLDBUt (
     c+     LEVEL1 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL2 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL3 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL4 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL5 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL6 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL7 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL8 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL9 INTEGER NOT NULL DEFAULT 0 ,
     c+     DATA VARbinary (1000) NOT NULL DEFAULT)
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod =-601
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c/exec sql
     c+   CREATE INDEX QTEMP/xmldbuI0 ON QTEMP/XMLDBUT (
     c+     LEVEL1 ASC
     c+   , LEVEL2 ASC
     c+   , LEVEL3 ASC
     c+   , LEVEL4 ASC
     c+   , LEVEL5 ASC
     c+   , LEVEL6 ASC
     c+   , LEVEL7 ASC
     c+   , LEVEL8 ASC
     c+   , LEVEL9 ASC
     c+   )
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod =-601
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c/exec sql
     c+   delete from  QTEMP/xmldbut
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod = 100
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c                   open      xmldbuI0
