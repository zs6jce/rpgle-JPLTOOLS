--  Generate SQL
--  Version:                   V7R1M0 100423
--  Generated on:              07/02/12 21:04:07
--  Relational Database:
--  Standards Option:          DB2 for i

DROP TABLE QSYS.QABNDBND ;

CREATE TABLE QSYS.QABNDBND (
--  SQL150B   10   REUSEDLT(*NO) in table QABNDBND in QSYS ignored.
--  SQL1505   20   Number of members for QABNDBND in QSYS not valid.
  BNDCEN CHAR(1) CCSID 37 NOT NULL DEFAULT '' ,
  BNDDAT CHAR(6) CCSID 37 NOT NULL DEFAULT '' ,
  BNDTIM CHAR(6) CCSID 37 NOT NULL DEFAULT '' ,
  BNOLNM CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
  BNOBNM CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
  BNOBTP CHAR(7) CCSID 37 NOT NULL DEFAULT '' ,
  BNOCEN CHAR(1) CCSID 37 NOT NULL DEFAULT '' ,
  BNODAT CHAR(6) CCSID 37 NOT NULL DEFAULT '' ,
  BNOTIM CHAR(6) CCSID 37 NOT NULL DEFAULT '' ,
  BNDRLB CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
  BNDRNM CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
  BNMOSY CHAR(8) CCSID 37 NOT NULL DEFAULT '' ,
  BNOACT CHAR(10) CCSID 37 NOT NULL DEFAULT '' )

  RCDFMT QBNDSPBD   ;

LABEL ON TABLE QSYS.QABNDBND
  IS 'System supplied outfile for DSPBNDDIR command.' ;

LABEL ON COLUMN QSYS.QABNDBND
( BNDCEN IS 'Display             Century' ,
  BNDDAT IS 'Display             Date' ,
  BNDTIM IS 'Display             Time' ,
  BNOLNM IS 'Library             Name' ,
  BNOBNM IS 'Object              Name' ,
  BNOBTP IS 'Object              Type' ,
  BNOCEN IS 'Object              Create              Century' ,
  BNODAT IS 'Object              Create              Date' ,
  BNOTIM IS 'Object              Create              Time' ,
  BNDRLB IS 'Library' ,
  BNDRNM IS 'Binding             Directory' ,
  BNMOSY IS 'System              Name' ,
  BNOACT IS 'Activation' ) ;

LABEL ON COLUMN QSYS.QABNDBND
( BNDCEN TEXT IS 'Display Century' ,
  BNDDAT TEXT IS 'Display date: format - Job date format' ,
  BNDTIM TEXT IS 'Display Time' ,
  BNOLNM TEXT IS 'Library Name' ,
  BNOBNM TEXT IS 'Object Name' ,
  BNOBTP TEXT IS 'Object Type' ,
  BNOCEN TEXT IS 'Object Create Century' ,
  BNODAT TEXT IS 'Object Create Date' ,
  BNOTIM TEXT IS 'Object Create Time' ,
  BNDRLB TEXT IS 'Library' ,
  BNDRNM TEXT IS 'Binding Directory' ,
  BNMOSY TEXT IS 'System Name' ,
  BNOACT TEXT IS 'Activation' ) ;

--  SQL7040   40   Message severity 20 exceeds specified severity level 0.
--  SQL7046   40   Generate SQL for QABNDBND in QSYS object type TABLE failed.
