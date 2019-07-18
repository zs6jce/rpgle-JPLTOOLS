             CMD        PROMPT('Retrieve PGM, MOD, SRVPGM info')

             PARM       KWD(PGM) TYPE(QUALPGM) MIN(1) +
                          PROMPT('Objects to scan')


 QUALPGM:    QUAL       TYPE(*GENERIC) LEN(10) SPCVAL((*ALL)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')


             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*CMD) VALUES(*CMD) EXPR(*YES) +
                          PROMPT('Object types')

             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(CMDI0100) TYPE(QUALCMDI01) +
                          PROMPT('Command Information Outfile')
 QUALCMDI01: QUAL       TYPE(*NAME) LEN(10) DFT(CMDI0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

