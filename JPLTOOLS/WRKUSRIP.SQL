drop table   JPLTOOLS.WRKusriP
monmsg ignore
executesql




CREATE TABLE jpltools.wrkusrip (
  USRPRF   varchar(10)                            NOT NULL ,
  keyword  varchar(10)                            NOT NULL ,
  value                   VARCHAR(100)           not NULL DEFAULT '' ,
  CONSTRAINT jpltools.wrkusrik    primary KEY( usrprf, keyword ) )
monmsg ST01567
EXECUTESQL

LABEL ON TABLE jpltools.wrkusrip
  IS 'work with user default values  '
monmsg escape
EXECUTESQL

