             CMD        PROMPT('Retrieve WRKREGINF info')

             PARM       KWD(EXIT) TYPE(*GENERIC) LEN(20) DFT(*ALL) +
                          SPCVAL((*ALL *N) (*REGISTERED *N) +
                          (*UNREGISTERED *N)) EXPR(*YES) +
                          PROMPT('Exit Points to scan')
             PARM       KWD(FORMAT) TYPE(*NAME) LEN(08) DFT(*ALL) +
                          SPCVAL((*ALL *N)) EXPR(*YES) +
                          PROMPT('Library')



             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(EXTI0100) TYPE(QUALEXTI01) PROMPT('Exit +
                          Point Information Outfile')
 QUALEXTI01: QUAL       TYPE(*NAME) LEN(10) DFT(EXTI0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(EXTI0200) TYPE(QUALEXTI02) +
                          PROMPT('ExitProgram Basic Info outfile')
 QUALEXTI02: QUAL       TYPE(*NAME) LEN(10) DFT(EXTI0200) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(EXTI0300) TYPE(QUALEXTI03) +
                          PROMPT('ExitProgram Extended Info file')

 QUALEXTI03: QUAL       TYPE(*NAME) LEN(10) DFT(EXTI0300) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')

