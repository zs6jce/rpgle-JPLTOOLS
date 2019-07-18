             CMD        PROMPT('les variables d''un programme')
             PARM       KWD(FILE) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          MIN(1) MAX(1) FILE(*OUT) FULL(*NO) +
                          EXPR(*YES) VARY(*NO) PASSATR(*NO) +
                          PROMPT('Spooled File Name')
             PARM       KWD(SPLNBR) TYPE(*DEC) LEN(5 0) RSTD(*NO) +
                          DFT(*LAST) RANGE(1 9999) SPCVAL((*ONLY 0) +
                          (*LAST -1)) MIN(0) MAX(1) EXPR(*YES) +
                          VARY(*NO) PASSATR(*NO) PROMPT('Spooled +
                          File Number')
             PARM       KWD(JOBNAME) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          SPCVAL((*)) MIN(1) MAX(1) EXPR(*YES) +
                          VARY(*NO) PASSATR(*NO) PROMPT('Job Name')
             PARM       KWD(JOBUSER) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          EXPR(*YES) VARY(*NO) PROMPT('User Name')
             PARM       KWD(JOBNBR) TYPE(*CHAR) LEN(6) RSTD(*NO) +
                          RANGE(000000 999999) FULL(*YES) +
                          EXPR(*YES) VARY(*NO) PROMPT('Job Number')
