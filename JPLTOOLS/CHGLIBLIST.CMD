             CMD        PROMPT('Changer de liste de biblio')

             PARM       KWD(JOBD) TYPE(QFILE) MIN(1) +
                          PROMPT('Description de travail')
 QFILE:      QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) +
                          PROMPT('Bibliothèque')
