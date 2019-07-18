
/*-
CRTCMD CMD(ECOLIB/SQL2SYLK) PGM(*LIBL/SQL2SYLKC) SRCFILE(ECOLIB/QPGMSRC)               -
SRCMBR(SQL2SYLK) THDSAFE(*YES) REPLACE(*YES)                                           -
*/


             CMD        PROMPT('Exporter SQL vers SYLK')
             PARM       KWD(SQL) TYPE(*CHAR) LEN(5000) MIN(1) +
                          PROMPT('Ordre SQL') EXPR(*YES)
             PARM       KWD(NULLVALUE) TYPE(*CHAR) LEN(30) +
                          DFT('#N/A') EXPR(*YES) +
                          PROMPT('Representation des NULL')
             PARM       KWD(IFSROOT) TYPE(*CHAR) LEN(132) +
                          DFT('ExtractionExcel') EXPR(*YES) +
                          PROMPT('Racine IFS')
             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(132) EXPR(*YES) +
                          PROMPT('Dossier IFS')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(132) +
                          DFT('sql2sylk.slk') EXPR(*YES) +
                          PROMPT('Fichier IFS')
             PARM       KWD(DTAAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*RWX) VALUES(*SAME *NONE *RWX *RX *RW +
                          *WX *R *W *X *EXCLUDE) EXPR(*YES) +
                          PROMPT('droits sur données')
             PARM       KWD(OBJAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ALL) VALUES(*NONE *ALL *OBJEXIST +
                          *OBJMGT *OBJALTER *OBJREF) EXPR(*YES) +
                          PROMPT('droits sur l''objet')
