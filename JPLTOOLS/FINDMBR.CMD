             CMD        PROMPT('Trouver un membre')
             PARM       KWD(LIBRARY) TYPE(*NAME) LEN(10) +
                          SPCVAL((*LIBL *LIBL) (*CURLIB *CURLIB) +
                          (*USRLIBL *USRLIBL)) MIN(1) +
                          PROMPT('Bibliotheque')
             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Fichier')
             PARM       KWD(MEMBER) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Membre')
             PARM       KWD(RTNLIB) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('Variable pour RTNLIB   (10)')
