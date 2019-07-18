
/*  CHECK OBJECT LINK   */
             CMD        PROMPT('CHECK OBJECT LINK')

             PARM       KWD(OBJ) TYPE(*PNAME) LEN(255) MIN(1) +
                          EXPR(*YES) PROMPT('object to check')
             PARM       KWD(AUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*EXISTS) VALUES(*EXISTS *R *RW *RWX +
                          *RX *W *WX *X) PROMPT('Check for authority')


