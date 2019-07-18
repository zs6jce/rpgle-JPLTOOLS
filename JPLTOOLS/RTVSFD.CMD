             CMD        PROMPT('Retrieve SQL field info')

             PARM       KWD(FILE) TYPE(QUALFILE) MIN(1) +
                          PROMPT('Files to scan')


 QUALFILE:   QUAL       TYPE(*GENERIC) LEN(10) SPCVAL((*ALL)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')






             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(FLDDSC) TYPE(QUALFLDDSC) PROMPT('SQL +
                          field Information Outfile')
 QUALFLDDSC: QUAL       TYPE(*NAME) LEN(10) DFT(FLDDSC) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

