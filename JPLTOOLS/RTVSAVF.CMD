             CMD        PROMPT('Retrieve *FILE SAVF info')

             PARM       KWD(SAVF) TYPE(QUALSAVF) MIN(1) +
                          PROMPT('Objects to scan')


 QUALSAVF:   QUAL       TYPE(*GENERIC) LEN(10) SPCVAL((*ALL)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')






             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(SAVF0100) TYPE(QUALSAVF01) +
                          PROMPT('Command Information Outfile')
 QUALSAVF01: QUAL       TYPE(*NAME) LEN(10) DFT(SAVF0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

