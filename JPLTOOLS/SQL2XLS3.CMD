





             CMD        PROMPT('Export SQL to Excel')
             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
                          EXPR(*YES) PROMPT('SQL statement')
             PARM       KWD(NULLVALUE) TYPE(*CHAR) LEN(30) +
                          DFT('#N/A') EXPR(*YES) PROMPT('Show NULL as')
             PARM       KWD(IFSROOT) TYPE(*CHAR) LEN(132) +
                          DFT(*COMMON) EXPR(*YES) PROMPT('IFS root')
             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(132) EXPR(*YES) +
                          PROMPT('IFS folder')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(132) +
                          DFT('sql2xml.xls') EXPR(*YES) PROMPT('IFS +
                          file')
             PARM       KWD(DTAAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*RWX) VALUES(*SAME *NONE *RWX *RX *RW +
                          *WX *R *W *X *EXCLUDE *DONTAPPLY) +
                          EXPR(*YES) PROMPT('PUBLIC data authority')
             PARM       KWD(OBJAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ALL) VALUES(*NONE *ALL *OBJEXIST +
                          *OBJMGT *OBJALTER *OBJREF *DONTAPPLY) +
                          EXPR(*YES) PROMPT('PUBLIC object authority')
