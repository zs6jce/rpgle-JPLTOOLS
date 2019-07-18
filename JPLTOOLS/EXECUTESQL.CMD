/* USAGE SAMPLE :                                                   -
EXECUTESQL SQL('CREATE TABLE QTEMP/TENLIBS AS (                     -
SELECT DIOBLI, DIOBNM, DIOBTP, DIOBAT, DIOBTX, DIOBSZ               -
FROM QUSRSYS/QAEZDISK WHERE DIOBTP = ''LIB''                        -
FETCH FIRST 10 ROWS ONLY) WITH DATA')                               -
*/
             CMD        PROMPT('EXECUTE SQL STATEMENT')

             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
                          EXPR(*YES) PROMPT('SQL STATEMENT (*SYS +
                          SYNTAX)')
