

             CMD        PROMPT('Compiler un source')
/* PARAMETRES LES PLUS UTILISES */
             PARM       KWD(S) TYPE(*CHAR) LEN(10) MIN(1) EXPR(*YES) +
                          PROMPT('Element type (without *)')
             PARM       KWD(N) TYPE(*CHAR) LEN(10) MIN(1) EXPR(*YES) +
                          PROMPT('&N=Member Name')
             PARM       KWD(O) TYPE(*CHAR) LEN(10) MIN(1) EXPR(*YES) +
                          PROMPT('&O=Object Library')
             PARM       KWD(L) TYPE(*CHAR) LEN(10)        EXPR(*YES) +
                          PROMPT('&L=Source Library')
             PARM       KWD(F) TYPE(*CHAR) LEN(10)        EXPR(*YES) +
                          PROMPT('&F=Source File')
             PARM       KWD(I) TYPE(*CHAR) LEN(500) EXPR(*YES) +
                          PROMPT('&I=Ifs Link')
             PARM       KWD(COMPILER) TYPE(*CHAR) LEN(10) EXPR(*YES) +
                          PROMPT('Compiler')
/* AUTRES PARAMETRES */
             PARM       KWD(P) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          VALUES(*NO *YES) MIN(1) +
                          PROMPT('Compilation in Batch')
             PARM       KWD(G) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('JOBD library (not used)''')
             PARM       KWD(H) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('JOBD (not used)')
             PARM       KWD(J) TYPE(*CHAR) LEN(21) MIN(1) +
                          PROMPT('Qualified JOBD(not used)')
             PARM       KWD(E) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          VALUES(*NO *YES) MIN(1) PROMPT('Run in +
                          Batch (not used)')
             PARM       KWD(R) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          VALUES(*NO *YES) MIN(1) +
                          PROMPT('&R=Replace object')
             PARM       KWD(X) TYPE(*CHAR) LEN(50) PROMPT('Member +
                          text')
             PARM       KWD(C) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Confirm +
                          the stack')
             PARM       KWD(SCDDATE) TYPE(*DATE) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 000000)) +
                          PROMPT('Schedule compil, date')
             PARM       KWD(SCDTIME) TYPE(*TIME) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 000000)) +
                          PROMPT('Schedule compil, time')
