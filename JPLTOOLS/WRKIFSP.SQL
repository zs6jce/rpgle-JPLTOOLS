drop table   JPLTOOLS.WRKIFSP
monmsg ignore
executesql




CREATE TABLE jpltools.WRKIFSp (
  keyword  varchar(10)                            NOT NULL ,
  cmd                     VARCHAR(1000)           not NULL DEFAULT '' ,
  CONSTRAINT jpltools.WRKIFSk    primary KEY( keyword ) )
monmsg ST01567
EXECUTESQL

LABEL ON TABLE jpltools.WRKIFSp
  IS 'WRKIFS, template of Commands   '
monmsg escape
EXECUTESQL

