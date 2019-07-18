             CMD        PROMPT('Reindent a RPGLE soirce code')
             PARM       KWD(LIBRARY) TYPE(*NAME) LEN(10) +
                          SPCVAL((*LIBL *LIBL) (*CURLIB *CURLIB) +
                          (*USRLIBL *USRLIBL)) MIN(1) PROMPT('Library')
             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Source file')
             PARM       KWD(MEMBER) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Member')
             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) DFT(RPGLE) +
                          PROMPT('Type of code')
             PARM       KWD(ERASE5) TYPE(*LGL) DFT(*NO) SPCVAL((*YES +
                          '1') (*NO '0')) PROMPT('Erase leftmost 5 +
                          chars')
             PARM       KWD(CASECONV) TYPE(CASECONV) PROMPT('Convert +
                          to lower/upper case')
 CASECONV:   ELEM       TYPE(*CHAR) LEN(11) RSTD(*YES) DFT(*NONE) +
                          VALUES(*NONE *LOWER *UPPER *CAMELCASE +
                          *DICTIONARY) PROMPT('The operation codes')
             ELEM       TYPE(*CHAR) LEN(11) RSTD(*YES) DFT(*NONE) +
                          VALUES(*NONE *LOWER *UPPER *CAMELCASE +
                          *DEFN *DICTIONARY) PROMPT('Field names in +
                          D cards')
             ELEM       TYPE(*CHAR) LEN(11) RSTD(*YES) DFT(*NONE) +
                          VALUES(*NONE *LOWER *UPPER *CAMELCASE +
                          *DICTIONARY) PROMPT('the other words')
