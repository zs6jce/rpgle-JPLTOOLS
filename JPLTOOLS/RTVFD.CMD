             CMD        PROMPT('Print file description')

             PARM       KWD(FILE) TYPE(QUAL01) MIN(1) PROMPT('File')
 QUAL01:     QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL) +
                          (*CURLIB) (*USRLIBL)) PROMPT('Library')
