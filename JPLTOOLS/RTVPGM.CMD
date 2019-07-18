             CMD        PROMPT('Retrieve PGM, MOD, SRVPGM info')

             PARM       KWD(PGM) TYPE(QUALPGM) MIN(1) +
                          PROMPT('Objects to scan')


 QUALPGM:    QUAL       TYPE(*GENERIC) LEN(10) SPCVAL((*ALL)) MIN(1) +
                          EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) EXPR(*YES) -
                          PROMPT('Library')


             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ALL) VALUES(*MODULE *PGM *SRVPGM +
                          *ALL) EXPR(*YES) PROMPT('Object types')

             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                          PROMPT(' Replace or add records')

             PARM       KWD(MODI0100) TYPE(QUALMODI01)             +
                          PROMPT('Module Information Outfile')
 QUALMODI01: QUAL       TYPE(*NAME) LEN(10) DFT(MODI0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(MODL0100) TYPE(QUALMODL01) PROMPT('MODs: +
                          Exported Symbols')
 QUALMODL01: QUAL       TYPE(*NAME) LEN(10) DFT(MODL0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(MODL0200) TYPE(QUALMODL02) PROMPT('MODs: +
                          unresolved Symbols')
 QUALMODL02: QUAL       TYPE(*NAME) LEN(10) DFT(MODL0200) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(MODL0300) TYPE(QUALMODL03) PROMPT('MODs: +
                          procedures')
 QUALMODL03: QUAL       TYPE(*NAME) LEN(10) DFT(MODL0300) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(MODL0400) TYPE(QUALMODL04) PROMPT('MODs: +
                          referenced objects')
 QUALMODL04: QUAL       TYPE(*NAME) LEN(10) DFT(MODL0400) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(MODL0500) TYPE(QUALMODL05) PROMPT('MODs: +
                          the copyrights ')
 QUALMODL05: QUAL       TYPE(*NAME) LEN(10) DFT(MODL0500) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')


             PARM       KWD(PGMI0100) TYPE(QUALPGMI01) +
                          PROMPT('Program Information Outfile')
 QUALPGMI01: QUAL       TYPE(*NAME) LEN(10) DFT(PGMI0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(VEWL0100) TYPE(QUALVEWL01) PROMPT('Debug +
                          Views Outfile')
 QUALVEWL01: QUAL       TYPE(*NAME) LEN(10) DFT(VEWL0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(SPGI0100) TYPE(QUALSPGI01) +
                          PROMPT('Service Pgm Info Outfile')
 QUALSPGI01: QUAL       TYPE(*NAME) LEN(10) DFT(SPGI0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(PGML0100) TYPE(QUALPGML01) PROMPT('SRV & +
                          PGM: the modules')
 QUALPGML01: QUAL       TYPE(*NAME) LEN(10) DFT(PGML0100) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(PGML0200) TYPE(QUALPGML02) +
                          PROMPT('SRV & PGM: the service pgms')
 QUALPGML02: QUAL       TYPE(*NAME) LEN(10) DFT(PGML0200) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(PGML0300) TYPE(QUALPGML03) PROMPT('SRV & +
                          PGM: items exported')
 QUALPGML03: QUAL       TYPE(*NAME) LEN(10) DFT(PGML0300) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(PGML0400) TYPE(QUALPGML04) PROMPT('SRV & +
                          PGM: item imports   ')
 QUALPGML04: QUAL       TYPE(*NAME) LEN(10) DFT(PGML0400) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(PGML0500) TYPE(QUALPGML05) PROMPT('SRV & +
                          PGM: the copyrights ')
 QUALPGML05: QUAL       TYPE(*NAME) LEN(10) DFT(PGML0500) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(SPGL0600) TYPE(QUALSPGL06) +
                          PROMPT('SRVPGM: procedure export info')
 QUALSPGL06: QUAL       TYPE(*NAME) LEN(10) DFT(SPGL0600) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(SPGL0700) TYPE(QUALSPGL07) +
                          PROMPT('SRVPGM: Data Export info')
 QUALSPGL07: QUAL       TYPE(*NAME) LEN(10) DFT(SPGL0700) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')

             PARM       KWD(SPGL0800) TYPE(QUALSPGL08) +
                          PROMPT('SRVPGM: Signature info')
 QUALSPGL08: QUAL       TYPE(*NAME) LEN(10) DFT(SPGL0800) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) +
                          SPCVAL((*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')




















