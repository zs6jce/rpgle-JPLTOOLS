             CMD        PROMPT('Retrieve AUTL info')

             PARM       KWD(AUTL) TYPE(*NAME) MIN(1) PROMPT('Objects +
                          to scan')
              /* *GENERIC : PLUS TARD */







             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(ATLO0100) TYPE(QUALATLO10) PROMPT('QSYS +
                          objects')
 QUALATLO10: QUAL       TYPE(*NAME) LEN(10) DFT(ATLO0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(ATLO0110) TYPE(QUALATLO11) PROMPT('IFS +
                          objects ')
 QUALATLO11: QUAL       TYPE(*NAME) LEN(10) DFT(ATLO0110) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')




