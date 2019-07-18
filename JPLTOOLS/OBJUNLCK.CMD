             CMD        PROMPT('Liberer un objet')

             PARM       KWD(OBJ) TYPE(QFILE) MIN(1) PROMPT('Objet')
             PARM       KWD(OBJTYPE) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Type d''objet')
             PARM       KWD(SCDDATE) TYPE(*DATE) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 000000)) PROMPT('Date de +
                          soumission')
             PARM       KWD(SCDTIME) TYPE(*TIME) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 000000)) PROMPT('Heure +
                          de soumission')
             PARM       KWD(SUBMIT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*YES *NO) +
                          PROMPT('Soumettre en batch')
             PARM       KWD(RMVTYPE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) PROMPT('ENDJOB +
                          selon le type')
             PARM       KWD(RMVTYPEA) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  An +
                          autostart job.')
             PARM       KWD(RMVTYPEB) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          batch job. ')
             PARM       KWD(RMVTYPEI) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  An +
                          interactive job ')
             PARM       KWD(RMVTYPEM) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          subsystem monitor job. ')
             PARM       KWD(RMVTYPER) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          spooled reader job. ')
             PARM       KWD(RMVTYPES) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          system job. ')
             PARM       KWD(RMVTYPEW) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          spooled writer job. ')
             PARM       KWD(RMVTYPEX) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  The +
                          SCPF system job. ')




             PARM       KWD(RMVSUB) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) PROMPT('ENDJOB +
                          selon le sous-type')
             PARM       KWD(RMVSUB_) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  No +
                          sub-type')
             PARM       KWD(RMVSUBD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  an +
                          immediate job. ')
             PARM       KWD(RMVSUBE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  +
                          started with a PSR. ')
             PARM       KWD(RMVSUBF) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  an +
                          AS/400 Advanced 36 server')
             PARM       KWD(RMVSUBJ) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  a +
                          prestart job. ')
             PARM       KWD(RMVSUBP) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          print driver job.')
             PARM       KWD(RMVSUBT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  A +
                          system/36 MRT job. ')
             PARM       KWD(RMVSUBU) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO ) VALUES(*YES *NO) PROMPT('  +
                          Alternate spool user. ')
 QFILE:      QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) +
                          PROMPT('Bibliothèque')
