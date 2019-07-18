/*-
*/
             CMD        PROMPT('Retrieve an IFS file name')

             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(132) MIN(1) +
                          EXPR(*YES) PROMPT('File IFS')
             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(132) DFT(*NONE) +
                          EXPR(*YES) PROMPT('Directory IFS')
             PARM       KWD(IFSROOT) TYPE(*CHAR) LEN(132) DFT(*NONE) +
                          SPCVAL((*COMMON) (*NONE)) EXPR(*YES) +
                          PROMPT('Root IFS')
             PARM       KWD(IFSNAME) TYPE(*CHAR) LEN(500) +
                          RTNVAL(*YES) PROMPT('Variable for IFSNAME +
                          (500)')
