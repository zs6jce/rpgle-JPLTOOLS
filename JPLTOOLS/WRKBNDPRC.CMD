             CMD        PROMPT('Work with BNDIR procedures')

             PARM       KWD(BNDDIR) TYPE(QUAL) MIN(1) +
                          PROMPT('Objects to scan')


 QUAL:       QUAL       TYPE(*NAME) LEN(10) SPCVAL((*ALL *N)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')


