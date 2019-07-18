             CMD        PROMPT('List sleeping programs')
             PARM       KWD(JOB) TYPE(Q1) DFT('*') SNGVAL((* *) +
                          (*INT *INT)) FILE(*NO) PROMPT('Job Name')
 Q1:         QUAL       TYPE(*NAME) LEN(10) RSTD(*NO)          +
                                                  MIN(0) EXPR(*YES) +
                          VARY(*NO) PASSATR(*NO)
             QUAL       TYPE(*NAME) LEN(10) RSTD(*NO) MIN(1) +
                          EXPR(*YES) VARY(*NO) PROMPT('User Name')
             QUAL       TYPE(*CHAR) LEN(6) RSTD(*NO) RANGE(000000 +
                          999999) MIN(1) FULL(*YES) EXPR(*YES) +
                          VARY(*NO) PROMPT('Job Number')
             PARM       KWD(INTERNAL) TYPE(*CHAR) LEN(16) +
                          PROMPT('Internal job number (hex 16)')
             PARM       KWD(API) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(SLEEP) SPCVAL((STACK QWVRCSTK) (SLEEP +
                          QWVOLACT) (QWVOLACT) (QWVRCSTK)) +
                          PROMPT('API to use')
