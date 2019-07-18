/*-
CRTCMD CMD(ECOLIB/CHGOBJATR) PGM(*LIBL/CHGOBJATRC)                 -
SRCFILE(ECOLIB/QPGMSRC) SRCMBR(CHGOBJATR) THDSAFE(*YES)            -
REPLACE(*YES)                                                      -
*/
             CMD        PROMPT('changer attributs')

             PARM       KWD(OBJ) TYPE(QOBJ) MIN(1) PROMPT('Object')
             PARM       KWD(OBJTYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          VALUES(*ALRTBL *AUTL *BNDDIR *CFGL +
                          *CHTFMT *CLD *CLS *CMD *CNNL *COSD *CRG +
                          *CRQD *CSI *CSPMAP *CSPTBL *CTLD *DEVD +
                          *DTAARA *DTADCT *DTAQ *EDTD *EXITRG *FCT +
                          *FILE *FNTRSC *FNTTBL *FORMDF *FTR *GSS +
                          *IPXD *JOBD *JOBQ *JOBSCD *JRN *JRNRCV +
                          *LIB *LIND *LOCALE *MEDDFN *MENU *MGTCOL +
                          *MODD *MODULE *MSGF *MSGQ *M36 *M36CFG +
                          *NODGRP *NODL *NTBD *NWID *NWSD *OUTQ +
                          *OVL *PAGDFN *PAGSEG *PDG *PGM *PNLGRP +
                          *PRDAVL *PRDDFN *PRDLOD *PSFCFG *QMFORM +
                          *QMQRY *QRYDFN *RCT *SBSD *SCHIDX *SPADCT +
                          *SQLPKG *SQLUDT *SRVPGM *SSND *SVRSTG +
                          *S36 *TBL *USRIDX *USRPRF *USRQ *USRSPC +
                          *VLDL *WSCST) MIN(1) PROMPT('Object type')

             PARM       KWD(KEY01) TYPE(QMBR) PROMPT('Source file +
                          name')

             PARM       KWD(KEY02) TYPE(*CHAR) LEN(13) +
                          DFT(CYYMMDDHHMMSS) RANGE(0400101000000 +
                          1391231235959) SPCVAL((CYYMMDDHHMMSS =) +
                          (*SAME =)) PROMPT('Source changed date & +
                          time')
/*           PARM       KWD(KEY02D) TYPE(*DATE) DFT(CYYMMDD) +            */
/*                        SPCVAL((CYYMMDD 0000000) (*SAME 0000000)) +     */
/*                        PROMPT('Source changed date')                   */
/*           PARM       KWD(KEY02T) TYPE(*TIME) DFT(HHMMSS) +             */
/*                        SPCVAL((HHMMSS 000000) (*SAME 000000)) +        */
/*                        PROMPT('Source changed date & time')            */

             PARM       KWD(KEY03) TYPE(*CHAR) LEN(13) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Compiler')

             PARM       KWD(KEY04) TYPE(*CHAR) LEN(8) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Object control +
                          level')

             PARM       KWD(KEY05) TYPE(LICPGM) PROMPT('Licensed +
                          program name')

             PARM       KWD(KEY06) TYPE(*CHAR) LEN(7) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Program +
                          temporary fix')

             PARM       KWD(KEY07) TYPE(*CHAR) LEN(6) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Authrzed Pgm +
                          Analysis Report')

             PARM       KWD(KEY08) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*SAME) VALUES(0 1) SPCVAL((*SAME =) +
                          (*NO 0) (*YES 1)) PROMPT('Allow Change by +
                          program')

             PARM       KWD(KEY09) TYPE(*CHAR) LEN(10)            +
                          DFT(*SAME) SPCVAL((*SAME =)) +
                          PROMPT('User-defined attribute')

             PARM       KWD(KEY10) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Text')

             PARM       KWD(KEY11) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*SAME) VALUES(0 1) SPCVAL((*SAME =) +
                          (*NO 0) (*YES 1)) PROMPT('Reset Days used +
                          count')

             PARM       KWD(KEY12) TYPE(*CHAR) LEN(5)            +
                          DFT(*SAME) SPCVAL((*SAME =)) +
                          PROMPT('Product option lang ID')

             PARM       KWD(KEY13) TYPE(*CHAR) LEN(5) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Product option ID')

             PARM       KWD(KEY14) TYPE(*CHAR) LEN(5) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Component ID')

             PARM       KWD(KEY15) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*SAME) VALUES(0 1) SPCVAL((*SAME =) +
                          (*NO 0) (*YES 1)) PROMPT('Update Last +
                          Used Date')

             PARM       KWD(KEY16) TYPE(*CHAR) LEN(5) RSTD(*YES) +
                          DFT(*SAME) VALUES(0 1) SPCVAL((*SAME =) +
                          (*NO 0) (*YES 1)) PROMPT('Update changed +
                          date & time')

             PARM       KWD(KEY17) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME =)) PROMPT('Reset this mbr +
                          day used count')

/*           PARM       KWD(KEY__) TYPE(*CHAR) LEN(5)            +                            */
/*                        DFT(*SAME) SPCVAL((*SAME))                                          */
/*                                                                                            */
/*           PARM       KWD(KEY__) TYPE(*CHAR) LEN(5)            +                            */
/*                        DFT(*SAME) SPCVAL((*SAME))                                          */

 QOBJ:       QUAL       TYPE(*NAME) LEN(10) SPCVAL((*SAME =)) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')

 QMBR:       QUAL       TYPE(*NAME) LEN(10) DFT(*SAME) SPCVAL((*SAME +
                          =))
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')
             QUAL       TYPE(*NAME) LEN(10) PROMPT('Membre')

 LICPGM:     QUAL       TYPE(*NAME) LEN(7) DFT(*SAME) SPCVAL((*SAME =))
             QUAL       TYPE(*CHAR) LEN(6) RANGE(V0R0MA V9R9M9)
