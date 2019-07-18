             CMD        PROMPT('Retrieve JRN info')

             PARM       KWD(PGM) TYPE(QUALPGM) MIN(1) +
                          PROMPT('Objects to scan')


 QUALPGM:    QUAL       TYPE(*GENERIC) LEN(10) SPCVAL((*ALL)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')


             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*JRN) VALUES(*JRN) EXPR(*YES) +
                          PROMPT('Object types')

             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(RJRN0100) TYPE(QUALRJRN00) +
                          PROMPT('Journal Information Outfile')
 QUALRJRN00: QUAL       TYPE(*NAME) LEN(10) DFT(RJRN0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(RJRN0101) TYPE(QUALRJRN01) +
                          PROMPT('Receiver names Outfile')
 QUALRJRN01: QUAL       TYPE(*NAME) LEN(10) DFT(RJRN0101) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
/* ''Journaled objects Outfile' */
             PARM       KWD(RJRN0102) TYPE(*CHAR) LEN(20) +
                          CONSTANT(*NONE)
 QUALRJRN02: QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) +
                          SPCVAL((RJRN0102 *N) (*NONE *N)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(RJRN0103) TYPE(*CHAR) LEN(20) +
                          CONSTANT(*NONE)
                       /* PROMPT('Remote Journal Outfile')  */
 QUALRJRN03: QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) +
                          SPCVAL((RJRN0103 *N) (*NONE *N)) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(RRCV0100) TYPE(QUALRRCV01) +
                          PROMPT('Receiver attributes Outfile')
 QUALRRCV01: QUAL       TYPE(*NAME) LEN(10) DFT(RRCV0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

