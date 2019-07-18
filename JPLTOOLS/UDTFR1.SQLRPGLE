    ? *  this sample shows how to code in RPG the inside-code of a
    ? *  sql procedure that returns a result set.
    ? *
    ? *  based on data from qiws/qcustcdt.
    ? *  Take care of having QIWS in your library list
    ? *
    ? *  Create Procedure udtfproc1 ()
    ? *         Dynamic Result Sets 1
    ? *         Language RPGLE
    ? *         not deterministic
    ? *         Reads SQL Data
    ? *         external name udtfr1
    ? *
    ? * compilation :
    ? *
    ? * test : with iSeries Navigator, myserver/database/mylocalrdb/schemas, in low right corner
    ? *        run sql script : call udtfproc1()
    ? *
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')

    ? *================================================================
    ? * sample of program for sql procedure returns a resultset
    ? *================================================================
    ? * define the output recordset, occursing the external output record format
     d recordset     e ds                  extname(qcustcdt)
     d                                     occurs(32765)                        it's the max value
     d count           s             10u 0 inz(0)
     d MySFW           s          32740    varying
      /free
       EXEC SQL
          Set Option Commit = *NONE
          , CloSQLCsr = *ENDMOD
          , DatFmt = *ISO
          , TimFmt = *ISO
          , Naming = *SYS
          ;
       mySFW = 'select * from qiws/qcustcdt';
       EXEC SQL prepare jpl021p2 from : mysfw ;
B01    if sqlcod <> *zero;
          exsr *pssr ;
E01    endif;
       EXEC SQL declare jpl021K2 cursor for jpl021p2  ;
B01    if sqlcod <> *zero;
          exsr *pssr;
E01    endif;
       EXEC SQL open jpl021k2  ;
B01    if sqlcod <> *zero;
          exsr *pssr ;
E01    endif;
B01    for count=1 to 32765;
          %occur (recordset)=count;
          EXEC SQL fetch jpl021k2 into : recordset ;
B02       if sqlcod = 100;
             count-=1;
             leave;
E02       endif;
B02       if sqlcod <> *zero;
             exsr *pssr;
E02       endif;
E01    endfor;
       EXEC SQL close jpl021k2 ;
       EXEC SQL Set result sets array : recordset for : count rows ;
       *inlr = *on ;
B01    begsr *pssr ;
          dump ;
E01    endsr '*CANCL';
      /end-free
