

    ?
    ?
    ?
    ?
    ?
    ?
    ? * base SQLRPGLE de programme de création de fichier SYLK
    ? * la doc complete est dans SYLK_H, la copie RPG pour les prototypes des fonctions
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
     h debug datedit(*ymd) datfmt(*iso) decedit('0.')
     H OPTION(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
     fsql2sylkp uf a e             disk
     f                                     infds(fids)
    ? *copy qpgmsrc,SYLK_H2     RPGLE
     D SylkQuote       PR         32767    varying
     D InString                   32767    varying const
    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                          250A
     D cmdlen                        15P 5 CONST
     D cmd             S            250A
     D Pos             S              5  0

     D s_ouvrirEntete  PR
     D s_polices       Pr
     D s_style         Pr             5u 0
     D   sylkdata                    80    varying const
     D s_police        Pr             5u 0
     D   sylkdata                    80    varying const
     D s_fermerEntete  PR
     D c_style         Pr
     d   row                          5u 0 const
     d   col                          5u 0 const
     d   stylenumero                  5u 0 const         options(*omit)
     d   police                       5u 0         const options(*omit:*nopass)
     d   bordure                      5    varying const options(*omit:*nopass)
     d   libre                       20    varying const options(*nopass)
     D c_police        pr
     d   row                          5u 0 const
     d   col                          5u 0 const
     d   police                       5u 0 const
     D c_hauteur       Pr
     d   row                          5u 0 const
     d   twips                        5u 0 const
     D c_largeur       Pr
     d   coldebut                     5u 0 const
     d   colfin                       5u 0 const
     d   caracteres                   5u 0 const
     D c_text          Pr
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                 30000    varying const
     d   Unquoted                      n   options(*nopass) const
     D c_num           Pr
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                    31s10 const
     D c_formula       Pr
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                 30000    varying const
     D s_write         Pr
     D   sylkdata                 30000    varying const
    ?D*die             Pr             1N
     D die             Pr
     D    msg                       256A   const
    ?D*EscSqlEr        Pr             1N
     D EscSqlEr        Pr
     D   sqlcod                       9b 0 const
     D s_close         PR

    ? * variables globales
    ?D*sylk            s             80    varying
     d styleNombre...
     d                 s              5u 0
     d policeNombre...
     d                 s              5u 0
     d sylkcolsize     s              5u 0 dim(256) inz(0)
    ?c* The SYLK File Format
    ?c* SYLK format is an ASCII text file designed to completely represent a template in a format
    ?c* external to the native file format of any given product.  It has a strong orientation
    ?c* towards MultiPlan in that the formatting commands, formula representations and
    ?c* row-and-column references used are MultiPlan-derived.  It is, however, a program-independent
    ?c* interchange format, much like DIF or SDI.  Because Microsoft may extend SYLK further,
    ?c* programs using the format should be
    ?c* written to ignore records and fields they aren't prepared to handle.
    ?c*
    ?c* SYLK Overview
    ?c*
    ?c* SYLK files are divided into records by carriage return/linefeed characters. Empty records
    ?c* are ignored. Non-empty records take the format
    ?c*
    ?c*    < RTD > < FTD > < Fields >
    ?c*
    ?c*   where
    ?c*
    ?c*   < RTD > is a record type descriptor
    ?c*   < FTD > is an optional field type descriptor
    ?c*   < Fields > is an optional and variable number of data items
    ?c*
    ?c*   The interpretation of the FTD depends on which RTD is used; the interpretation of the
    ?c* Fields often depends on which FTD is used. FTDs within a particular RTD may or may not be
    ?c* mutually exclusive, depending on use.
    ?c*
    ?c*   An RTD may be up to two letters long. By convention, all RTDs are capitalized. The FTD
    ?c* takes the form of a semicolon followed by a single letter: ;< letter >. The FTDs ;U, ;V, ;W,
    ?c* ;X, ;Y and ;Z are the same for all records. Others vary. Fields may not contain carriage
    ?c* return or linefeed characters. Any field containing the reserved semicolon
    ?c* character must have two of them, as is the practice in some programming languages.
    ?c*
    ?c*   In entries labeled as (diff), the last prior field values will be substituted if the field
    ?c* value of the current entry is empty. For example, if formatting commands are given for
    ?c* different cells in a given row, only the column number needs to be supplied. The row number
    ?c* will be assumed to be the last prior given field value.
    ?c*
    ?c*   The FTDs ;X and ;Y determine the column and row coordinates, respectively. The spreadsheet
    ?c* origin is 1,1.
    ?c* SYLK Record Type Descriptors (RTD)
    ?c* In the descriptions that follow, items enclosed in angle brackets ( < > ) signify fields;
    ?c* the character [S] signifies an ASCII space character (20h).
    ?c*
    ?c* RTD ID      First record in SYLK file
    ?c* RTD F       Formatting of entire template or cell
    ?c* RTD B       Defines the boundaries of the rows and columns. Appears
    ?c* RTD C       Supplies the numerical or text value of a cell, the formula it
    ?c*             contains, whether it is protected, and other properties.
    ?c* RTD NN      Defines a MultiPlan name as a union of rectangular
    ?c*             spreadsheet areas, expressed as absolh(te references.
    ?c* RTD NE      Defines a link to another (inactive) spreadsheet
    ?c* RTD NV      External filename substitution
    ?c* RTD O       ?               O;L;D;V0;K47;G100 0.001
    ?c*             suit souvent le B;Y11;X2;D0 0 10 1
    ?c* RTD W       MultiPlan window structure
    ?c*             Before trying to set up a window structure from scratch, Microsoft
    ?c*             recommends dumping an available window structure to see how it is
    ?c*             organized.
    ?c* RTD E       End of SYLK file.
    ?c*
    ?c*
    ?c*
    ?c* SYLK Overview
    ?c*
    ?c* SYLK files are divided into records by carriage return/linefeed characters. Empty records
    ?c* are ignored. Non-empty records take the format
    ?c*
    ?c*    < RTD > < FTD > < Fields >
    ?c*
    ?c*   where
    ?c*
    ?c*   < RTD > is a record type descriptor
    ?c*   < FTD > is an optional field type descriptor
    ?c*   < Fields > is an optional and variable number of data items
    ?c*
    ?c*   The interpretation of the FTD depends on which RTD is used; the interpretation of the
    ?c* Fields often depends on which FTD is used. FTDs within a particular RTD may or may not be
    ?c* mutually exclusive, depending on use.
    ?c*
    ?c*   An RTD may be up to two letters long. By convention, all RTDs are capitalized. The FTD
    ?c* takes the form of a semicolon followed by a single letter: ;< letter >. The FTDs ;U, ;V, ;W,
    ?c* ;X, ;Y and ;Z are the same for all records. Others vary. Fields may not contain carriage
    ?c* return or linefeed characters. Any field containing the reserved semicolon
    ?c* character must have two of them, as is the practice in some programming languages.
    ?c*
    ?c*   In entries labeled as (diff), the last prior field values will be substituted if the field
    ?c* value of the current entry is empty. For example, if formatting commands are given for
    ?c* different cells in a given row, only the column number needs to be supplied. The row number
    ?c* will be assumed to be the last prior given field value.
    ?c*
    ?c*   The FTDs ;X and ;Y determine the column and row coordinates, respectively. The spreadsheet
    ?c* origin is 1,1.
    ?c*
    ?c* SYLK Record Type Descriptors (RTD)
    ?c* In the descriptions that follow, items enclosed in angle brackets ( < > ) signify fields;
    ?c* the character [S] signifies an ASCII space character (20h).
    ?c*
    ?c* RTD ID       First record in SYLK file
    ?c*              FTD       ;P < name >
    ?c*              < name > is the name of the program that produced the file.
    ?c*
    ?c* RTD F        Formatting of entire template or cell
    ?c*              There are seven possi ble FTDs to consider:
    ?c*              (1) ;X ;Y
    ?c*              (diff) cell coordinates
    ?c*              (2) ;F < cl > [S] < n > [S] < c2 >
    ?c*              (diff) cell formatting properties
    ?c*                       < cl > is one of the following 1-character format-
    ?c*                       ting codes:
    ?c*                        D default
    ?c*                        C continuous cross-cell display
    ?c*                        E scientific exponentiation
    ?c*                        F fixed decimal point
    ?c*                        G general format
    ?c*                        $ leading$and2decimal points
    ?c*                         *  bar graph, one asterisk per unit
    ?c*                          (5 would be *****)
    ?c*                        < n > is the number of digits.
    ?c*                        <c2 > is one of the following 1-character align-
    ?c*                       ment codes:
    ?c*                         D default
    ?c*                         C center
    ?c*                         G general(textleft, numbersright)
    ?c*                         L leftjustify
    ?c*                         R right justify
    ?c*              (3) ;R ;c
    ?c*              iF properties applied to an entire row or column
    ?c*              (4) ;D < cl > [S] < n > [S] < c2 > [S] < n3 >
    ?c*              default format defined as in ;F. ;D codes cannot be used.
    ?c*                        < n3 > is the default column width
    ?c*
    ?c*              (5);K
    ?c*              if present, commas are set
    ?c*              (S);E
    ?c*              if present, the formula format option is set
    ?c*
    ?c*             (7);W< n1 > [S] < n2 > [S] < n3 >
    ?c*             defines the widths of a group of columns:
    ?c*                        < n1 > is the first column
    ?c*                        < n2 > is the last column
    ?c*                        < n3 > is the width of columns in number of char-
    ?c*                             acters
    ?c* RTD B       Defines the boundaries of the rows and columns. Appears
    ?c*             near the beginning of a SYLK file.
    ?c*             FTD       ;Y ;X
    ?c*                      row and column numbers
    ?c*
    ?c* RTD C       Supplies the numerical or text value of a cell, the formula it
    ?c*             contains, whether it is protected, and other properties.
    ?c*             There are eight possi ble FTDs to consider:
    ?c*
    ?c*             FTD        (1) ;X ;Y
    ?c*                        (diff) cell coordinates
    ?c*                        (2);K
    ?c*                        Value of the cell, either numerical or textual, follows.
    ?c*                        Text values must be in double quotes. Logical
    ?c*                        values "TRUE" and "FALSE" must also be quoted.
    ?c*                        An ERROR value is preceded by #.
    ?c*                        (3);P
    ?c*                        if present, cell is locked (protected)
    ?c*                        (4) ;E < expr >
    ?c*                        MultiPlan formula (expression) follows
    ?c*                        (5) ;R ;C
    ?c*                        (diff) see ;S, below
    ?c*                        (6);S
    ?c*                        expression for this cell is given by another
    ?c*                        coordinate, where X = C and Y = R. The field
    ?c*                        contents are decimal coordinates. ;E cannot appear
    ?c*                        in the same set of FTDs with ;S. The cell at ;R ;C
    ?c*                        must be marked with either a ;D or a ;G.
    ?c*                        (7);D
    ?c*                        ;E expression is shared with another cell
    ?c*                        (8);G
    ?c*                        ;K value is shared with another cell. ;E does not
    ?c*                        appear.
    ?c*
    ?c* RTD NN      Defines a MultiPlan name as a union of rectangular
    ?c*             spreadsheet areas, expressed as absolh(te references.
    ?c*             There are two possible FTDs to consider:
    ?c*
    ?c*             FTD       (1) ;N < name >
    ?c*                       name of the area
    ?c*                       (2) ;E < expr >
    ?c*                       expression describing the area
    ?c*
    ?c* RTD NE      Defines a link to another (inactive) spreadsheet
    ?c*             There are three possible FTDs to consider:
    ?c*
    ?c*             FTD       (1) ;F < name >
    ?c*                       filename of the source sheet
    ?c*                       (2);S
    ?c*                       description of the source area (name of the cell
    ?c*                       group)
    ?c*                       (3);E
    ?c*                       expression describing the area
    ?c*
    ?c* RTD NV      External filename substitution
    ?c*             There are two possible FTDs to consider:
    ?c*
    ?c*             FTD       (1);L
    ?c*                       filename
    ?c*
    ?c*                       (2);F
    ?c*                       filename to be used instead
    ?c*
    ?c*  RTD W      MultiPlan window structure
    ?c*             Before trying to set up a window structure from scratch, Microsoft
    ?c*             recommends dumping an available window structure to see how it is
    ?c*             organized.
    ?c*
    ?c*             FTD       (1) ;N
    ?c*                       window number
    ?c*
    ?c*                       (2) ;A y x
    ?c*                       coordinates of current cell as shown in upper left
    ?c*                       corner of window cited in ;N
    ?c*
    ?c*                       (3) ;B
    ?c*                       bordered flag
    ?c*
    ?c*
    ?c*                      (4) ;ST cy cx
    ?c*                      split window with title. cx is cursor position in new
    ?c*                      window. cy is number of screen lines in new
    ?c*                      window.
    ?c*
    ?c*                      (5) ;SH 1cy
    ?c*                      split window horizontal. cx is cursor position in new
    ?c*                      window. cy is number of screen lines in new
    ?c*                      window. 1 = L if windows are linked or scrolling.
    ?c*
    ?c*                      (6) ;SV 1cx
    ?c*                      split window vertical. cx is cursor position in new
    ?c*                      window. cy is number of screen lines in new
    ?c*                      window. 1 = L if windows are linked or scrolling.
    ?c*
    ?c* RTD E       End of SYLK file.
    ?c*
    ?c* Organization of a SYLK File
    ?c*
    ?c*  1. ID must be the first record.
    ?c*  2.  The B RTD should be used for MultiPlan input, although it is not required.
    ?c*  3.  For MultiPlan ;C records: ;D or ;G must appear before another C record that refers to
    ?c* it (with ;S, ;R, ;C)
    ?c*  4.  Name definition should precede name use for efficiency, although not required.
    ?c*  5.  Window splits and window properties must be in strict logical order.
    ?c*  6.  NU records must precede NE records.
    ?c*  7.  E must be the last record.
    ?c*
    ?c* liste des RTD par FTD utilisées
    ?c* RTD FTD
    ?c*W    ;A y x  coordinates of current cell as shown in upper left
    ?c*             corner of window cited in ;N
    ?c*W    ;B      bordered flag
    ?c*C    ;D      ;E expression is shared with another cell
    ?c*F    ;D < cl > [S] < n > [S] < c2 > [S] < n3 >
    ?c*             default format defined as in ;F. ;D codes cannot be used.
    ?c*             < n3 > is the default column width
    ?c*C    ;E < expr > MultiPlan formula (expression) follows
    ?c*F    ;E      if present, the formula format option is set
    ?c*NN   ;E < expr > expression describing the area
    ?c*F    ;F < cl > [S] < n > [S] < c2 >
    ?c*             (diff) cell formatting properties
    ?c*             < cl > is one of the following 1-character formatting codes:
    ?c*             D default
    ?c*             C continuous cross-cell display
    ?c*             E scientific exponentiation
    ?c*             F fixed decimal point
    ?c*             G general format
    ?c*             $ leading$and2decimal points
    ?c*             *  bar graph, one asterisk per unit
    ?c*                 (5 would be *****)
    ?c*             < n > is the number of digits.
    ?c*             <c2 > is one of the following 1-character alignment codes:
    ?c*             D default
    ?c*             C center
    ?c*             G general(textleft, numbersright)
    ?c*             L leftjustify
    ?c*             R right justify
    ?c*NE   ;F < name > filename of the source sheet
    ?c*NV   ;F      filename to be used instead
    ?c*C    ;G      ;K value is shared with another cell. ;E does not
    ?c*             appear.
    ?c*F    ;K      if present, commas are set
    ?c*C    ;K      Value of the cell, either numerical or textual, follows.
    ?c*             Text values must be in double quotes. Logical
    ?c*             values "TRUE" and "FALSE" must also be quoted.
    ?c*             An ERROR value is preceded by #.
    ?c*NV   ;L      filename
    ?c*F P  ;M      hauteur de fonte, de ligne   F;M990;R1  P;FArial;M800
    ?c*NN   ;N < name > name of the area
    ?c*W    ;N      window number
    ?c*ID   ;P < name >
    ?c*             < name > is the name of the program that produced the file.
    ?c*C    ;P      if present, cell is locked (protected)
    ?c*F    ;R ;c        If properties applied to an entire row or column
    ?c*C    ;S      expression for this cell is given by another
    ?c*             coordinate, where X = C and Y = R. The field
    ?c*             contents are decimal coordinates. ;E cannot appear
    ?c*             in the same set of FTDs with ;S. The cell at ;R ;C
    ?c*             must be marked with either a ;D or a ;G.
    ?c*F    ;S <bordure> <grisé> M0      exemple F;SLRTBSM0
    ?c*             <bordure> = 0 à 4 parmi ces codes
    ?c*             L left
    ?c*             R right
    ?c*             T top
    ?c*             B bottom
    ?c*             <grisé>
    ?c*             S grisé 12%
    ?c*NE   ;S      description of the source area (name of the cell group)
    ?c*W    ;ST cy cx
    ?c*             split window with title. cx is cursor position in new
    ?c*             window. cy is number of screen lines in new
    ?c*             window.
    ?c*W    ;SH 1cy split window horizontal. cx is cursor position in new
    ?c*             window. cy is number of screen lines in new
    ?c*             window. 1 = L if windows are linked or scrolling.
    ?c*W    ;SV 1cx split window vertical. cx is cursor position in new
    ?c*             window. cy is number of screen lines in new
    ?c*             window. 1 = L if windows are linked or scrolling.
    ?c*F B C;X ;Y    (diff) cell coordinates
    ?c*F    ;W< n1 > [S] < n2 > [S] < n3 >
    ?c*             defines the widths of a group of columns:
    ?c*             < n1 > is the first column
    ?c*             < n2 > is the last column
    ?c*             < n3 > is the width of columns in number of characters
    ?c*=--------------------------------------------------------------------------------------------
    ?c* styles standard et affichage obtenu
    ?c* p0       38711,66666 -38711,5 0 toto
    ?c* p1             38712 -38712 0 toto
    ?c* p2          38711,67 -38711,50 0,00 toto
    ?c* p3            38 712 -38 712 0 toto
    ?c* p4         38 711,67 -38 711,50 0,00 toto
    ?c* p5 (pourri)
    ?c* p6 (pourri)
    ?c* p7 (pourri)
    ?c* p8 (pourri)
    ?c* p9          38 712 ¤     -38 712 ¤ 0 ¤              toto
    ?c* p10      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p11      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p12      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p13         3871167%     -3871150% 0%               toto
    ?c* p14      3871166,67%  -3871150,00% 0,00%            toto
    ?c* p15         3,87E+04     -3,87E+04 0,00E+00         toto
    ?c* p16          38,7E+3      -38,7E+3 000,0E+0         toto
    ?c* p17        38711 2/3    -38711 1/2 0                toto
    ?c* p18       38711  2/3   -38711  1/2 0                toto
    ?c* p19       25/12/2005               00/01/1900       toto
    ?c* p20        25-déc-05               00-janv-00       toto
    ?c* p21           25-déc               00-janv          toto
    ?c* p22           déc-05               janv-00          toto
    ?c* p23          3:59 PM               12:00 AM         toto
    ?c* p24       3:59:59 PM               12:00:00 AM      toto
    ?c* p25            15:59               00:00            toto
    ?c* p26         15:59:59               00:00:00         toto
    ?c* p27 25/12/2005 15:59               00/01/1900 00:00 toto
    ?c* p28            59:59               00:00            toto
    ?c* p29          59:59,4               00:00,0          toto
    ?c* p30 38711,66666      -38711,5      0                toto
    ?c* p31     929079:59:59               0:00:00          toto
    ?c* p32         38 712 ¤     -38 712 ¤              - ¤  toto
    ?c* p33           38 712     -38 712                -    toto
    ?c* p34      38 711,67 ¤  -38 711,50 ¤            - ¤    toto
    ?c* p35        38 711,67  -38 711,50              -      toto
    ?c* p36          ¤38 712    (¤38 712)  ¤0               toto
    ?c* p37          ¤38 712    (¤38 712)  ¤0               toto
    ?c* p38       ¤38 711,67  (¤38 711,50) ¤0,00            toto
    ?c* p39       ¤38 711,67  (¤38 711,50) ¤0,00            toto
    ?c* p40 ¤         38 712 ¤    (38 712) ¤            -    toto
    ?c* p41           38 712      (38 712)              -    toto
    ?c* p42 ¤      38 711,67 ¤ (38 711,50) ¤          -      toto
    ?c* p43        38 711,67   (38 711,50)            -      toto
    ?c* p44       2005-12-25               1900-01-00       toto
    ?c*
    ?c* structure du style de nombre :
    ?c* ;P nombre positif ;; nombre négatif ;; nombre zero ;; texte
    ?c*
    ?c*
    ?c*
    ?c* autre source de doc, d'origine microsoft
    ?c*
    ?c*
    ?c*     /*-------------------------------------------------------------------
    ?c*                                 sylksum.doc
    ?c*
    ?c*         Author:     MCK, Microsoft.
    ?c*         Purpose:    Summary of all currently used sylk fields.  Emphasis on
    ?c*                     fields relavent to Mac Plan and Excel.
    ?c*         Feature:    Add at least a list of other SYLK records and field
    ?c*                     used by other products (need not explain semantics -
    ?c*                     just to avoid ambiguous usage).
    ?c*         Reference:  See Draft Proposed American National Standard Videotex/
    ?c*                     Teletext Presentation Level Protocol Syntax for full ISO
    ?c*                     escape documentation.
    ?c*
    ?c*         History:
    ?c*         Date     By  Modification
    ?c*         ------------------------------------------------------------
    ?c*          10/31/86 MCK Added character quoting section.
    ?c*           9/27/85 MCK Added ISO sections and misc clean ups.
    ?c*     -------------------------------------------------------------------*/
    ?c* - Note that Mac Plan allocates a 350 character buffer for holding input
    ?c*   lines.
    ?c*
    ?c* - Common FTD's:
    ?c*     - ;U: Reserved for future use.
    ?c*     - ;V: Reserved for future use.
    ?c*     - ;X col: (diff) Column of cell.
    ?c*     - ;Y row: (diff) Row of cell.
    ?c*     - ;Z: Reserved for future use.
    ?c*
    ?c* - ID record: File type and creator (first record).
    ?c*     - ;P prog: Producing program; e.g., MP, MC, MF, XL.
    ?c*     - ;N: File uses ;N style cell protection (not ;P style).
    ?c* *   - ;E: NE records are redundant as formulas support external ref's
    ?c* *         directly.
    ?c*
    ?c* - B record: Sheet bounds at current cell (should be before C and F
    ?c*       records for optimal usage).
    ?c* - C record: Cell definition.
    ?c*     - ;E exp: Expression for cell.
    ?c*     - ;K value: Value of the cell.
    ?c*     - ;C col: (diff) Cell reference.
    ?c*     - ;R row: (diff) Row reference.
    ?c*     - ;G: Defines shared value (may not have an ;E for this record).
    ?c*     - ;D: Defines shared expression.
    ?c*     - ;S: Shared expression/value given at row ;R, col ;C.  C record
    ?c*           for ;R, ;C must precede this one.  Note that no ;E or ;K
    ?c*           fields are written here (not allowed on Excel macro sheets).
    ?c*
    ?c*     - ;N: Cell NOT protected/locked (if ;N present in ;ID record).
    ?c*     - ;P: Cell protected/locked (if ;N not present in ;ID record).
    ?c*           Note if this occurs for any cell, we protect the entire
    ?c*           sheet.
    ?c*
    ?c* *   - ;H: Cell hidden.
    ?c* *   - ;M exp: Expression stored with UL corner of matrix (;R ;C defines
    ?c* *         the lower right corner).  If the ;M field is supported, the
    ?c* *         ;K record is ignored.  Note that no ;E field is written.
    ?c* *   - ;Tref,ref: UL corner of table (;R ;C defines the lower left
    ?c* *         corner).  Note that the defined rectangle is the INSIDE of
    ?c* *         the table only.  Formulas and input cells are above and to
    ?c* *         the left of this rectangle.  The row and column input cells
    ?c* *         are given in by the two refs (possibly only one).  Note that
    ?c* *         Excel's input refs are single cells only.
    ?c*
    ?c* *   - ;I: Inside a matrix or table (at row ;R, col ;C) C record for UL
    ?c* *         corner must precede this record.  Note that any ;K field is
    ?c* *         ignored if the ;I field is supported.  No ;E field is written
    ?c* *         out.
    ?c*
    ?c* *- P record: Picture format (precedes all F records).
    ?c* *   - ;P picture: Excel style picture format.
    ?c*
    ?c* - F record: Formats.
    ?c*     - ;C col: Whole column format.
    ?c*     - ;R row: Whole row format.
    ?c*     - ;F ch1 digs ch2: Single cell format.
    ?c*         ch1: Number format: DCEFG$*%
    ?c*             - default, currency (extended), exponent, fixed, general,
    ?c*               dollar, graph, percent.  Note that Plan does not read
    ?c*               currency (converts to general).
    ?c*
    ?c*         digs: Number of digits.
    ?c*         ch2: Alignment: DCGLR-X
    ?c*             - Default, center, standard, left, right, ignored, fill.
    ?c*               Fill is for Excel style alcFill.
    ?c*
    ?c*         Note that Mac Plan 1.XX screws up on '-' formats and
    ?c*         alignments.  Also, very few early versions (1.0, 1.01) mess up
    ?c*         on 'C' format.
    ?c*
    ?c*     - ;D ch1 digs ch2 width: Default format.  Like ;F but ch's can't be
    ?c*           'D'.
    ?c*
    ?c*           width: Default column width.  Note that for Excel, this
    ?c*               record should precede the B record to ensure all cells
    ?c*               without explicit formats get set to the default.
    ?c*
    ?c*     - ;E: Show formulas (sheet wide).
    ?c*     - ;K: Show commas (sheet wide).
    ?c*     - ;W: n1 n2 n3: Column widths (first col, last col, width).
    ?c* *   - ;N fontid size: Font to use (sheet wide).
    ?c* *   - ;P index: Excel picture (based on order of FP records - 0 based).
    ?c* *   - ;S[IDTLBR]: Style: Italic, bolD, gridlines Top, Left, Bottom,
    ?c* *         Right.
    ?c*
    ?c* *   - ;H: Don't show row/column headers (sheet wide).
    ?c* *   - ;G: Don't show default gridlines.
    ?c*
    ?c* - NU record: File name substitution (not supported on Mac) (precedes all NE).
    ?c*     - ;L filename: Old file name.
    ?c*     - ;F filename: New file name.
    ?c*
    ?c* - NN record: Names (most efficient if NN appears before name use).
    ?c*     - ;N name: The name string.
    ?c*     - ;E exp: Expression desribing the value of the name.
    ?c* *   - ;G ch1 ch2: Runable name (macro) with command key alias (Mac uses
    ?c* *         only first character).
    ?c* *   - ;K ch1 ch2: Ordinary name with unused command aliases (Plan
    ?c* *         2.0).
    ?c*
    ?c* *   - ;F: Usable as a function.
    ?c*
    ?c* - O record: Global options.
    ?c* *   - ;A cIter numDelta: Iteration on.  The parameters are not used by
    ?c* *         plan but are for Excel.
    ?c*
    ?c*     - ;C: Completion test at current cell.
    ?c*     - ;P: Sheet is protected (but no password).
    ?c* *   - ;L: Use A1 mode references (R1C1 always used in SYLK file expressions).
    ?c* *   - ;M: Manual recalc.
    ?c* *   - ;R: Precision as formated (!fPrec).
    ?c* *   - ;E: Macro (executable) sheet.  Note that this should appear
    ?c* *         before the first occurance of ;G or ;F field in an NN record
    ?c* *         (otherwise not enabled in Excel).  Also before first C record
    ?c* *         which uses a macro-only function.
    ?c*
    ?c* - NE record: External link (ignored if ;E present in ID record).
    ?c*     - ;E exp: Taget area on current sheet.
    ?c*     - ;F filename: Source document.
    ?c*     - ;S exp: Source area on external sheet.
    ?c*
    ?c* - W record: Window record.
    ?c*     - ;R n1 n2 ... n14: (Mac Plan only)
    ?c*           n1..n8: Title freeze info.
    ?c*           n9..n12: Scroll bar info.
    ?c*           n13..n14: Split bar info.
    ?c*
    ?c*     - ;A row col: UL window corner (character based - only).
    ?c*     - ;B: Window is bordered (character based - only).
    ?c*     - ;N n: Window index (character based - only).
    ?c*     - ;S ...: Window split (character based - only).
    ?c*     - ;C n1 n2 n3: Foreground, background and border colors (IBM).
    ?c*
    ?c* - NL Record: Chart external link.
    ?c*     - ;C n: Destination series index.
    ?c*     - ;D exp: Name or ref for dependent variable source area.
    ?c*     - ;E[RC] n: Relative row of column from a dependent name.
    ?c*     - ;I exp: Name or ref for independent variable source area.
    ?c*     - ;J[RC] n: Relative row of column from a independent name.
    ?c*     - ;F filename: Source area.
    ?c*
    ?c* - E record: End of file (last record).
    ?c*
    ?c* ISO characters
    ?c*
    ?c* Note that all non-printing ASCII characters must be (conceptually)
    ?c* filtered before writting to SYLK and before reading the SYLK line.
    ?c* This filtering converts both the local machine character set characters
    ?c* into the corresponding ISO standard escape sequences.  Those
    ?c* non-printing characters not supported in the standard use an "ASCII
    ?c* escape" mechanism.
    ?c*
    ?c* ISO escape codes:
    ?c*
    ?c* All supported ISO sequences begin with "<Esc>N".  For accented
    ?c* characters, this is followed by the accent designator (e.g., the umlaut
    ?c* designator), followed by the "base character" - that character to be
    ?c* accented.  Note that all of the accent designators are in the range
    ?c* $40..$4F.
    ?c*
    ?c* Non-accented characters supported by ISO are sent as "<Esc>N" followed
    ?c* by a single special designator in the range $21..$3F, and $50..$7E.
    ?c*
    ?c* It is recommended that as many characters as possible be encoded using
    ?c* ISO sequences (rather than the "raw" ASCII escapes, below) as this
    ?c* allows for maximum portability of you SYLK file.
    ?c*
    ?c* When reading an unrealizable ISO accented escape, just the last
    ?c* character of the sequence should be used (yielding at least a
    ?c* recognizable string).  The same can be done for the "random" escapes,
    ?c* but this is not always guaranteed to produce a "nice" result.
    ?c*
    ?c* ASCII escapes:
    ?c*
    ?c* Characters not covered (or supported) under ISO can be encoded using a
    ?c* special 3-character ASCII escape sequence: "<Esc> $2M $3N", where the
    ?c* local character encoding is $MN, hex.
    ?c* Semi-colon Quoting
    ?c*
    ?c* There are a couple of places in SYLK files where characters need to be
    ?c* quoted.  Most obviously, anywhere a ";" appears that is not to be
    ?c* interpreted as as SYLK field seperator it must be quoted.  This is done
    ?c* by doubling the character: ";;".
    ?c*
    ?c* Picture Character Quoting
    ?c*
    ?c* A more specialized quoting is used in the P record (formatting
    ?c* pictures).  This is documented in the Excel manual.  Basically any
    ?c* non-special literal character must be quoted by a backslash (\).
    ?c* Quotes (") can also be used to quote a sequence of such characters.
    ?c* Note that normally, Excel only displays quoting for non-special literal
    ?c* characters ($, :, -, /).  But in SYLK we quote ALL literal characters.
    ?c*
    ?c* The reason all are quoted is for international considerations.  Not all
    ?c* countries share the same set of special literal and functional (h, m,
    ?c* s, d, y) characters.  If we did not quote all literals in SYLK, then
    ?c* they might be confused with US functional characters.
    ?c* We could have just quoted those that conflicted with the US functional
    ?c* set, but this is both more complicated and still ignores problems with
    ?c* future extensions to the functional characters.
    ?c*
    ?c* Also note that for any unrecognized unquoted characters, we just assume
    ?c* it is a literal (rather than give a SYLK read error).
    ?c*
    ?c* Exception: Excel 1.0 doesn't address these problems.  Literals are not
    ?c* all quoted on writing a SYLK file and unrecognized characters in a
    ?c* picture cause a failure on load.
    ?c*
    ?c* __END__
    ?
     Dreallocselda     Pr
     D sqlcols                        5u 0 CONST
     DBufTyp           Pr                  LIKE(RtnTyp)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
     DRtnTyp           S             20A
    ? * taille de selda : 16 + 80 * 818 = 65456 < 65535, mais pas de beaucoup
     DSelDA            DS                  BASED(pSelDA)                        SQLDA allocate heap.
     D SQLDAID                        8A
     D   SQLDOUBLED                   1    overlay(sqldaid:7)
     D SQLDABC                       10I 0
     D SQLN                           5u 0
     D SQLD                           5u 0
     D SQLVAR                        80A   DIM(818)
     D  SQLTYPE                       5u 0 OVERLAY(SQLVAR:1)
     D  SQLLEN                        5u 0 OVERLAY(SQLVAR:3)
     D  SQLRES                       12A   OVERLAY(SQLVAR:5)
     D  SQLDATA                        *   OVERLAY(SQLVAR:17)
     D  SQLIND                         *   OVERLAY(SQLVAR:33)
     D  SQLNAMELEN                    5u 0 OVERLAY(SQLVAR:49)
     D  SQLNAME                      30A   OVERLAY(SQLVAR:51)
     D nbcol           s              5u 0
     DSelDASiz         S              5U 0
     DAvlColCnt        S              5U 0 INZ(51)
     d                 ds             2
     d lenB2                   1      2i 0
     d   lenG                  1      1i 0
     d   lenD                  2      2i 0
    ?
     D FIDS            DS
    ? *-------------------------------------------------------------------------------------------
    ? * Descriptif du format . . . :  the File Information Data Structure
    ? *-------------------------------------------------------------------------------------------
    ?d*                    File name (same as subfield location *FILE).
     d SFFILE                         8A
    ?d*                    Open indication (1 = open).
     d SFOPEN                         1A
    ?d*                    End of file (1 = end of file)
     d SFEOF                          1A
    ?d*                    Status code (same as subfield location *STATUS).
     d SFSTAT                         9P 0
    ?d*                    Operation code (same as subfield location *OPCODE)
     d SFOPCO                         6A
    ?d*                    Name of the RPG/400 routine in which the exception
     d SFRTN                          8A
    ?d*                    RPG/400 source statement sequence number.
     d SFLINB                         8A
    ?d*                    For a program described file the record identifyin
     d SFRCRD                         8A
    ?d*                    Machine or system message number.
     d SFMSID                         7A
    ?d*                    MI/ODT (machine instruction/object definition temp
     d SFMINB                         4A
    ?d*                    Unused.me (same as subfield location *FILE).
     d SFFIL1                        10A
    ?d*                    Screen size (same as subfield location *SIZE).
     d SFSIZE                         7P 0
    ?d*                    The national language input capability of the devi
     d SFINP                          3P 0
    ?d*                    The national language output capability of the dev
     d SFOUTT                         3P 0
    ?d*                    The preferred national language mode of the device
     d SFMODE                         3P 0
    ?d*                    Name of the RPG/400 routine in which the exception
     d SFFIL9                         4A
    ?d*                    Open data path (ODP) type: DS   Device file DB   D
     d SFODPB                         2A
    ?d*                    Name of the file. For a nonspooled file, this is t
     d SFFLNM                        10A
    ?d*                    Name of the library containing the file.  For a sp
     d SFFLLB                        10A
    ?d*                    Name of the spooled file.  This entry is set onlyp
     d SFSPLF                        10A
    ?d*                    Name of the library where the spooled file is loca
     d SFSPLL                        10A
    ?d*                    Spooled file number (supplied only for spooled out
     d SFSPLN                         4B 0
    ?d*                    Record length (number of bytes transferred at a ti
     d SFRCDL                         4B 0
    ?d*                    Reserved.
     d SFFIL2                         2A
    ?d*                    Member name: -   If ODP type is DB, this entry is
     d SFFLMB                        10A
    ?d*                    Not used.
     d SFFIL3                         4A
    ?d*                    Not used.
     d SFFIL4                         4A
    ?d*                    File type (supplied only if the ODP type is DS or
     d SFFLTP                         4B 0
    ?d*                    Reserved.
     d SFFIL5                         3A
    ?d*                    Number of rows on a display screen or number of li
     d SFROWS                         4B 0
    ?d*                    Number of columns on a display screen ornumber of
     d SFCOLS                         4B 0
    ?d*                    Number of records in the member at open time.  Thi
     d SFRCNB                         9B 0
    ?d*                    Access type (supplied only if ODP type is DB): KU
     d SFACTP                         2A
    ?d*                    Duplicate key indication.  This entry is set only
     d SFDUPK                         1A
    ?d*                    Source file indication. This entry contains Y if t
     d SFSRCF                         1A
    ?d*                    User file control block (UFCB) parameters.  This e
     d SFFCBP                        10A
    ?d*                    User file control block (UFCB) overrides.  This en
     d SFFCBO                        10A
    ?d*                    Offset to volume label fields of open feedback are
     d SFOFST                         4B 0
    ?d*                    Maximum number of records that can be sent or rece
     d SFBLCK                         4B 0
    ?d*                    Overflow line number(supplied only for a printer f
     d SFSPLO                         4B 0
    ?d*                    Blocked record I/O record increment.This is the nu
     d SFBLRC                         4B 0
    ?d*                    Unused.
     d SFFIL6                         5A
    ?d*                    Name of the requester program device.
     d SFRQPD                        10A
    ?d*                    File open count.  If the file is opened nonshareab
     d SFFCBC                         2B 0
    ?d*                    Reserved.
     d SFFIL7                         2A
    ?d*                    Number of based-on physical members opened.  For l
     d SFOPPF                         4B 0
    ?d*                    Miscellaneous flags.  See the Data Management Guid
     d SFMIS1                         1A
    ?d*                    Open Identifier.  Value is unique for a full open
     d SFOPID                         2A
    ?d*                    Maximum Record Length.  This value includes the da
     d SFMXRL                         4B 0
    ?d*                    the Input/Output Feedback Information
     d SFFILA                        23A
    ?d*                    Offset to file-dependent feedback information.  Se
     d SFIOFI                         4B 0
    ?d*                    Write operation count.  This entry is updated only
     d SFWRIC                         9B 0
    ?d*                    Read operation count.  This entry is updated only
     d SFREAC                         9B 0
    ?d*                    Write/Read operation count.  This entry is updated
     d SFWRRC                         9B 0
    ?d*                    Other I/O operation count.  Number of successful o
     d SFOIOC                         9B 0
    ?d*                    Unused.
     d SFFIL8                         1A
    ?d*                    Current operation.  This entry represents the last
     d SFCUOP                         1A
    ?d*                    Name of the record format just processed, which is
     d SFRFMT                        10A
    ?d*                    Device class. In the Data Management Guide, see th
     d SFDVCL                         2A
    ?d*                    Program device name.  This entry is the name of th
     d SFPDNM                        10A
    ?d*                    Length of the record processed by the last I/O ope
     d SFLNRC                         9B 0
    ?d*                    relative rank number (FILE)
     d  sfrrn                397    400b 0
    ?d*
     D PSDS           SDS
    ?d*                     Program name (same as subfield location *PROGRAM)
     d SPNAME                        10A                                         Program name (sam
    ?d*                     Status code (same as subfield location *STATUS).
     d SPSTAT                         5A                                         Status code (same
    ?d*                     Previous status code.
     d SPPSTA                         5A                                         Previous status c
    ?d*                     RPG/400 source statement sequence number.
     d SPLINB                         8A                                         RPG/400 source st
    ?d*                     Name of the RPG/400 routine in which the exceptio
     d SPRTN                          8A                                         Name of the RPG/4
    ?d*                     Number of parameters passed to this program (same
     d SPPARM                         5P 0                                       Number of paramet
    ?d*                     Exception type (CPF for a OS/400 system exception
     d SPMSID                         7A                                         Exception type (C
    ?d*                     MI/ODT (machine instruction / object definition t
     d SPMINB                         4A                                         MI/ODT (machine i
    ?d*                     Work area for messages.  This area is only meant
     d SPFIL1                        30A                                         Work area for mes
    ?d*                     Name of library in which the program is located.
     d SPPGLB                        10A                                         Name of library i
    ?d*                     Retrieved exception data. CPF messages are placed
     d SPMSDA                        80A                                         Retrieved excepti
    ?d*                     Identification of the exception that caused RPG90
     d SPMSIP                         4A                                         Identification of
    ?d*                     Unused.
     d SPFIL2                        24A                                         Unused.
    ?d*                     First 2 digits of a 4-digit year. The same as the
     d SPSIEC                         2A                                         First 2 digits of
    ?d*                     Name of file on which the last file operation occ
     d SPFILE                         8A                                         Name of file on w
    ?d*                     Status information on the last file used.  This i
     d SPFSTA                        35A                                         Status informatio
    ?d*                     Job name.
     d SPJBNM                        10A                                         Job name.
    ?d*                     User name from the user profile.
     d SPJBUS                        10A                                         User name from th
    ?d*                     Job number.
     d SPJBNB                         6S 0                                       Job number.
    ?d*                     Date (in UDATE format) the program started runnin
     d SPUDAT                         6S 0                                       Date (in UDATE fo
    ?d*                     Date of program running (the system date in UDATE
     d SPSYDT                         6S 0                                       Date of program r
    ?d*                     Time of program running in the format hhmmss.
     d SPSYTM                         6S 0                                       Time of program r
    ?d*                     Date (in UDATE format) the program was compiled.
     d SPCPLD                         6A                                         Date (in UDATE fo
    ?d*                     Time (in the format hhmmss) the program was compi
     d SPCPLT                         6A                                         Time (in the form
    ?d*                     Level of the compiler.
     d SPCPLL                         4A                                         Level of the comp
    ?d*                     Source file name.
     d SPSRCF                        10A                                         Source file name.
    ?d*                     Source library name.
     d SPSRCL                        10A                                         Source library na
    ?d*                     Source file member name.
     d SPSRCM                        10A                                         Source file membe
    ?d*                     Unused.
     d SPFIL3                        96A                                         Unused.
    ? * Programme driver
     D                 DS
     D  W0FLSP                 1      4
     D  W1FLSP                 1      2
     D  W2FLSP                 3      4
    ? * index par defaut pour boucle for infinie (=do *hival) ou une fois (=do 1)
     d  iFor           s              5u 0
     d  Ever           s              5u 0
    ?
     d lcase           pr         32787    varying
     d  FromString                32787    varying const
    ?
    ? * protocoles d'appel des procédures
    ? * effacer la pile de messages du sous-fichier de messages
     d pmqcln          pr
    ? * ajouter un message, 1 paramètre : n° de message
     d pmqmsg          pr
     d    msgno                       7    const
    ? *                     2 paramètres : n° de message et texte de message
     d pmqmsg2         pr
     d    msgno                       7    const
     d    msgdata                  6000    const varying
    ? *                     4 paramètres : message, data et fichier
     d pmqmsg4         pr
     d    msgno                       7    const                                n°
     d    msgdata                  6000    const varying                        variables
     d    msgflib                    10    const                                *LIBL
     d    msgffile                   10    const                                MESSAGE
    ? *                     9 paramètres : toutes les informations
     d pmqmsg8         pr
     d    msgno                       7    const                                n°
     d    msgflib                    10    const                                *LIBL
     d    msgffile                   10    const                                MESSAGE
     d    msgdata                  6000    const varying                        variables
     d    msgtype                    10    const                                *DIAG
     d    msgcse                     10    const                                call stack entry
     d    msgcsc                      4B 0 const                                call stack counter
     d    msgkey                      4                                         message key
     d message         pr
     d    msgno                       7    const         options(*omit)         n°
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
     d pmqpgm          s              1    inz('*')                             pas de sfl, batch !
    ? * prototype des procédures externes
     D RtnLen          s              5u 0 INZ(*ZEROS)
     DSQLBufLen        PR                  LIKE(RtnLen)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
     D InpLen                              LIKE(SQLLen) CONST
    ? **********************************************************************************************
    ? * Odd            Return flag indicating whether value is odd or even.                        *
    ? *  Input:                                                                                    *
    ? *   Val          Value to test.                                                              *
    ? *  Return:                                                                                   *
    ? *   Flg          Return *on if field is odd.                                                 *
    ? **********************************************************************************************
     DOdd              PR             1N                                        Return odd flag.
     d    Val                         5u 0 CONST
     D SQL2SYLK        pr
     d  row                           5u 0
     d  col                           5u 0
     d  p1                           80
     d hexa            pr         30000    varying
     d  txt                       15000    varying const
    ? * prototype des procédures internes
     D Proc            Pr
    ? * Paramètres du programme
     D sql2sylkr       PR
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   debugMode                    1
     d   NullValue                   30
     D sql2sylkr       PI
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   debugMode                    1
     d   NullValue                   30
    ? * variables globales
    ?d* styles perso
     d styleDateIso    s              5u 0
     d formatDateIso   c                   'yyyy\-mm\-dd'
     d styleDTSIso     s              5u 0
     d formatDTSIso    c                   'yyyy\-mm\-dd hh:mm:ss'
     d styleDec01      s              5u 0
     d formatDec01     c                   '0.0'
     d styleDec02      s              5u 0
     d formatDec02     c                   '0.00'
     d styleDec03      s              5u 0
     d formatDec03     c                   '0.000'
     d styleDec04      s              5u 0
     d formatDec04     c                   '0.0000'
     d styleDec05      s              5u 0
     d formatDec05     c                   '0.00000'
     d styleDec06      s              5u 0
     d formatDec06     c                   '0.000000'
     d styleDec07      s              5u 0
     d formatDec07     c                   '0.0000000'
     d styleDec08      s              5u 0
     d formatDec08     c                   '0.00000000'
     d styleDec09      s              5u 0
     d formatDec09     c                   '0.000000000'
     d styleDec10      s              5u 0
     d formatDec10     c                   '0.0000000000'
     d styleDec11      s              5u 0
     d formatDec11     c                   '0.00000000000'
     d styleDec12      s              5u 0
     d formatDec12     c                   '0.000000000000'
     d styleDec13      s              5u 0
     d formatDec13     c                   '0.0000000000000'
     d styleDec14      s              5u 0
     d formatDec14     c                   '0.00000000000000'
     d styleDec15      s              5u 0
     d formatDec15     c                   '0.000000000000000'
     d styleDec16      s              5u 0
     d formatDec16     c                   '0.0000000000000000'
     d styleDec17      s              5u 0
     d formatDec17     c                   '0.00000000000000000'
     d styleDec18      s              5u 0
     d formatDec18     c                   '0.000000000000000000'
     d styleDec19      s              5u 0
     d formatDec19     c                   '0.0000000000000000000'
     d styleDec20      s              5u 0
     d formatDec20     c                   '0.00000000000000000000'
     d styleDec21      s              5u 0
     d formatDec21     c                   '0.000000000000000000000'
     d styleDec22      s              5u 0
     d formatDec22     c                   '0.0000000000000000000000'
     d styleDec23      s              5u 0
     d formatDec23     c                   '0.00000000000000000000000'
     d styleDec24      s              5u 0
     d formatDec24     c                   '0.000000000000000000000000'
     d styleDec25      s              5u 0
     d formatDec25     c                   '0.0000000000000000000000000'
     d styleDec26      s              5u 0
     d formatDec26     c                   '0.00000000000000000000000000'
     d styleDec27      s              5u 0
     d formatDec27     c                   '0.000000000000000000000000000'
     d styleDec28      s              5u 0
     d formatDec28     c                   '0.0000000000000000000000000000'
     d styleDec29      s              5u 0
     d formatDec29     c                   '0.00000000000000000000000000000'
     d styleDec30      s              5u 0
     d formatDec30     c                   '0.000000000000000000000000000000'
     d styleDec31      s              5u 0
     d formatDec31     c                   '0.000000000000000000000000000000'
    ?d* police perso, la taille (;M) est en twips (20 twips par point)
     d policeArial40   s              5u 0
     d formatArial40   c                   'Arial;M800'
     d DiagEmis        s               n   inz(*off)
      /free
       //?*=----------------------------------------------------------------------------------=*
       //? procédure principale
       //?*=----------------------------------------------------------------------------------=*
       //?nom du fichier à générer
       //?creer le fichier, preparer la feuille de style
       s_ouvrirEntete();
       //?format de nombres supplementaires
       styleDateIso=s_style(formatDateIso);
       styleDTSIso=s_style(formatDTSIso);
       styleDec01 =s_style(formatDec01 );
       styleDec02 =s_style(formatDec02 );
       styleDec03 =s_style(formatDec03 );
       styleDec04 =s_style(formatDec04 );
       styleDec05 =s_style(formatDec05 );
       styleDec06 =s_style(formatDec06 );
       styleDec07 =s_style(formatDec07 );
       styleDec08 =s_style(formatDec08 );
       styleDec09 =s_style(formatDec09 );
       styleDec10 =s_style(formatDec10 );
       styleDec11 =s_style(formatDec11 );
       styleDec12 =s_style(formatDec12 );
       styleDec13 =s_style(formatDec13 );
       styleDec14 =s_style(formatDec14 );
       styleDec15 =s_style(formatDec15 );
       styleDec16 =s_style(formatDec16 );
       styleDec17 =s_style(formatDec17 );
       styleDec18 =s_style(formatDec18 );
       styleDec19 =s_style(formatDec19 );
       styleDec20 =s_style(formatDec20 );
       styleDec21 =s_style(formatDec21 );
       styleDec22 =s_style(formatDec22 );
       styleDec23 =s_style(formatDec23 );
       styleDec24 =s_style(formatDec24 );
       styleDec25 =s_style(formatDec25 );
       styleDec26 =s_style(formatDec26 );
       styleDec27 =s_style(formatDec27 );
       styleDec28 =s_style(formatDec28 );
       styleDec29 =s_style(formatDec29 );
       styleDec30 =s_style(formatDec30 );
       styleDec31 =s_style(formatDec31 );
       //?ajouter les polices de base
       s_polices();
       //?puis polices supplementaires
       policeArial40=s_police(formatArial40);
       //?fermer la feuille de style
       s_fermerEntete();
       //?un petit coup de sql
       proc();
       //?largeur des colonnes
B01    for iFor=1 to 256;
B02       if SylkColSize(iFor) > 0;
B03          if SylkColSize(iFor) > 100;
                c_largeur(iFor:iFor:100);
X03          else;
                c_largeur(iFor:iFor:SylkColSize(iFor));
E03          endif;
E02       endif;
E01    endfor;
       s_close();
B01    if DiagEmis;
          die('Fin anormale. Des diagnostics ont été émis');
E01    endif;
       *inlr = *on;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR     '*CANCL'
    ?C*=------------------------------------------------------------------------
    ?
     c*=------------------------------------------------------------------------
     p lcase           b
     d lcase           pi         32787    varying
     d  FromString                32787    varying const
      * table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
      * table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   return    %xlate(up:lo:fromString)
     p lcase           e
    ? *=----------------------------------------------------------------------------------=*
    ? *
    ? *=----------------------------------------------------------------------------------=*
BPR  P Proc            B
     D Proc            PI
     d mySFW           s           6000
     d sqlCount        s              9b 0
     d MyData          s           1000    based(pMyData)
     D InpSiz          s              5U 0
     DIdxSqlVar        S              5U 0                                      Field count index.
     DOffInp           S              5U 0 INZ(*ZEROS)                          Offset to field.
     d num42           s              4  2
     d row             s              5u 0 inz(01)
     d col             s              5u 0
     d NulFnd          s               n
      /free
       mySFW = sqlorder;
       callp message(*blank:mySFW);
       //?c_text(row  : 1  : 'sqlname');
       //?c_text(row+1: 1  : 'sqltype');
       //?c_text(row+2: 1  : 'rpgtype');
       //?c_text(row+3: 1  : 'sqllen ');
       //?c_text(row+4: 1  : 'sqlnamelen');
       c_police(row:0:5) ;
      /end-free
     C/EXEC SQL
     C+ declare k1 cursor for k1prepa
     C/END-EXEC
     C/EXEC SQL
     C+ prepare k1prepa from : mySFW
     C/END-EXEC
      /free
B01    if sqlcod<>0 ;
          callp escsqler (sqlcod);
E01    endif ;
       //?selda fait zero octet ! eviter le pointeur hors memoire (MCH36..)
      /end-free
B01  c                   if        debugMode <> '0'
     C                   callp     ReallocSELDA( 818)
    ?c* names    system names     labels      any     both     all
     C/EXEC SQL
     C+ describe k1prepa into : selda using all
     C/END-EXEC
X01  c                   else
     c                   callp     ReallocSELDA( 256)
    ?c* names    system names     labels      any     both     all
     C/EXEC SQL
     C+ describe k1prepa into : selda using any
     C/END-EXEC
E01  c                   endif
      /free
B01    if sqlcod<>0;
          callp escsqler (sqlcod);
E01    endif;
       //?select;
       //?  when sqldoubled = '2';
       //?     nbcol = sqld/2;
       //?  when sqldoubled = '3';
       //?     nbcol = sqld/3;
       //?  when sqldoubled = '4';
       //?     nbcol = sqld/4;
       //?  other;
               nbcol = sqld;
       //?endsl;
       //?limiter l'extraction à 256 colonnes
B01    if nbcol> 256;
          die('more than 256 columns, Excel limit exceeded');
E01    endif;
       //?*decortiquer les noms et types de colonnes
B01    for col = 1 to nbcol;
          ifor = col;
          c_text(row :col : lcase(sqlname(ifor)));
B02       if debugMode <> '0';
             c_num (row+1:col : sqltype(ifor));
             c_text(row+2:col : buftyp(sqltype(ifor)));
B03          if 484 <= sqltype(ifor) and sqltype(ifor) <= 489;
                c_style(row+3:ifor : 2);
                lenB2 = sqllen(iFOR);
                num42 = lenG + lenD / 100;
                c_num (row+3:col : num42 );
X03          else;
                c_num (row+3:col : sqllen (ifor));
E03          endif;
             c_style(row+4:col :0);
             c_num (row+4:col : sqlnamelen(ifor));
B03          if sqldoubled >= '2';
                ifor = nbcol+col ;
                c_text(row+5:col : lcase(sqlname(ifor)));
             c_num (row+6:col : sqlnamelen(ifor));
E03          endif;
B03          if sqldoubled >= '3';
                ifor = 2*nbcol+col ;
                c_text(row+07:col : lcase(sqlname(ifor)));
             c_num (row+8:col : sqlnamelen(ifor));
E03          endif;
E02       endif;
E01    endfor;
B02       if debugMode <> '0';
          row+=08;
E02       endif;
       //?calculer la taille du buffer nécessaire (avec indicateurs zones nulles)
       InpSiz = *ZEROS;
B01    for IdxSqlvar = 1 to SQLD;
B02       IF Odd(SQLTYPE(IdxSqlVar));//?Only if even.
             NulFnd = *ON;
             eval inpSiz +=2;
E02       ENDIF;
          InpSiz = InpSiz +
             SQLBufLen(SQLType(IdxSqlVar):SQLLEN(IdxSqlVar));
E01    endfor;
       //?allouer le buffer
       //?debug : pour dump sans mch, taille fixe
       //?inpsiz = 1000 ;
B01    IF pMyData = *NULL;
          pmyData=%ALLOC(InpSiz);
X01    else;
          pMyData=%realloc(pMyData:inpsiz);
E01    ENDif;
       //?Set pointers in SQLDA to input area.
B01    for idxSqlVar = 1 to SQLD;
B02       IF Odd(SQLTYPE(IdxSqlVar));//?Allow for null.
             SQLIND(IdxSqlVar) = pMyData + OffInp;
             offinp +=2;
E02       ENDIF;
          SQLDATA(IdxSqlVar) = pMyData + OffInp;
          OffInp = OffInp + SQLBufLen( SQLType(IdxSqlVar):SQLLEN(IdxSqlVar));
E01    ENDfor;
      /end-free
     C/EXEC SQL
     C+ OPEN K1
     C/END-EXEC
     c/free
       row+=1;
       c_text(row:1 :'Liste vide');
       c_police(0:0:0);
       /end-free
B01  c                   do        *hival
     c*



     c/EXEC SQL
     c+  fetch K1 using descriptor :selda
     c/end-exec









     c/free
B02       if sqlcod=100;
             leave;
E02       endif;
B02       if sqlcod<>0;
             callp escsqler (sqlcod);
E02       endif;
          //?dump;
          col = 1;
B02       for IdxSqlVar =1 to SQLD;
             callp sql2sylk(row:col:sqlvar(idxSqlVar)) ;
             col+=1;
E02       endfor;
          row+=1;
      /end-free
E01  c                   enddo
     C/EXEC SQL
     C+ close K1
     C/END-EXEC
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ?D**********************************************************************************************
    ?D* *SQLBufLen   - Return buffer length for field.                                             *
    ?D**********************************************************************************************
BPR  PSQLBufLen        B                   EXPORT
     DSQLBufLen        PI                  LIKE(RtnLen)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
     D InpLen                              LIKE(SQLLen) CONST
     D                 DS
     D RtnLn                   1      2I 0 INZ(*ZEROS)
      /free
       lenB2 = InpLen;
B01    SELECT;
X01       WHEN BufTyp(InpTyp) = 'DEC'; // Packed Decimal.
             lenB2 = InpLen;
             RtnLn = %INT( lenG / 2 ) + 1 ;
X01       WHEN BufTyp(InpTyp) = 'NUMERIC' OR   //Zoned Decimal.
             BufTyp(InpTyp) = 'SIGN LEADING';//Leading sign.
             rtnln = lenG ;
X01       WHEN BufTyp(InpTyp) = 'DATE';
             RtnLn = 8;
X01       WHEN BufTyp(InpTyp) = 'TIME';
             RtnLn = 8;
X01       WHEN BufTyp(InpTyp) = 'TIMESTAMP';
             RtnLn = 26;
X01       WHEN BufTyp(InpTyp) = 'VARCHAR';
             RtnLn = InpLen + 2;
X01       OTHER ;
             RtnLn = InpLen;
E01    ENDSL;
       RETURN RtnLn;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *      Odd - Return *ON if field odd, *OFF if even.
    ?D**********************************************************************************************
    ?D* *Odd         - Evaluate whether field odd or even.                                         *
    ?D**********************************************************************************************
BPR  POdd              B
     DOdd              PI             1N                                        Return odd/even.
     d    Val                         5u 0 CONST
      /free
B01    IF %rem(val:2) = *ZEROS ;//?Even number.
          RETURN *OFF;
X01    ELSE ;
          RETURN *ON;
E01    ENDif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=----------------------------------------------------------------------------------=*
    ? *
    ? *=----------------------------------------------------------------------------------=*
BPR  P SQL2SYLK        b
     d SQL2SYLK        pi
     d  row                           5u 0
     d  col                           5u 0
     d  p1                           80

     D SQLVAR          ds            80
     D  SQLTYPE                       5u 0 OVERLAY(SQLVAR:1)
     D  SQLLEN                        5u 0 OVERLAY(SQLVAR:3)
     D  SQLRES                       12A   OVERLAY(SQLVAR:5)
     D  SQLDATA                        *   OVERLAY(SQLVAR:17)
     D  SQLIND                         *   OVERLAY(SQLVAR:33)
     D  SQLNAMELEN                    5u 0 OVERLAY(SQLVAR:49)
     D  SQLNAME                      30A   OVERLAY(SQLVAR:51)
     d  nullind        s              5u 0 based(pNullInd)
     d  dateds         ds                  based(pDate)
     d  date8                         8a   overlay(dateds:1)
     d  date7                         7a   overlay(dateds:1)
     d  dateymd                        d   overlay(dateds:1) datfmt(*ymd-)
     d  datedmy                        d   overlay(dateds:1) datfmt(*dmy-)
     d  datemdy                        d   overlay(dateds:1) datfmt(*mdy-)
     d  datejul                        d   overlay(dateds:1) datfmt(*jul-)
     d  dateserial     s             10i 0
     d  dateserial0    s             10i 0
     d  wData          s          32000    based(pData)
     d  uData          s          32000    varying
     d  wVarChar       s          32000    based(pVarChar) varying
     d wLen            s              5u 0
     d wdays           s             10i 0
    ? * prototypes to date routines
     D CEEFMDA         PR                  ExtProc('CEEFMDA') OpDesc
     D   Country                      2A   Const
     D   FormatString                32A
     D   Error                       12A   Options(*Omit)
     D CEEDAYS         PR                  ExtProc('CEEDAYS') OpDesc
     D   DateString                  32A   Const
     D   FormatString                32A   Const
     D   LilianDate                  10I 0
     D   Error                       12A   Options(*Omit)
     D CEEDATE         PR                  ExtProc('CEEDATE') OpDesc
     D   LilianDate                  10I 0 Const
     D   FormatString                32A   Const
     D   DateString                  32A
     D   Error                       12A   Options(*Omit)
     D CEEISEC         PR                  ExtProc('CEEISEC') OpDesc
     D   year                        10I 0 Const
     D   month                       10I 0 Const
     D   day                         10I 0 Const
     D   hours                       10I 0 Const
     D   minutes                     10I 0 Const
     D   seconds                     10I 0 Const
     D   milli                       10I 0 Const
     D   out_seconds                  8f
     D   Error                       12A   Options(*Omit)
     D CEESECI         PR                  ExtProc('CEESECI') OpDesc
     D   in_seconds                   8f   const
     D   year                        10I 0
     D   month                       10I 0
     D   day                         10I 0
     D   hours                       10I 0
     D   minutes                     10I 0
     D   seconds                     10I 0
     D   milli                       10I 0
     D   Error                       12A   Options(*Omit)
     D CEESECS         PR                  ExtProc('CEESECS') OpDesc
     D   TimeStamp                   26a   const
     D   TSPicture                   26a   const
     D   out_seconds                  8f
     D   Error                       12A   Options(*Omit)
    ?D* local
     D sWorkDate       S              8A
     D sDateInWords    S             32A
     D nLil            S             10I 0
     D sFormat         S             32A
     d wTime           s              8a   based(pTime)
     d dsTime          ds             8
     d  whh                    1      2s 0
     d  wmm                    4      5s 0
     d  wss                    7      8s 0
     d wTimeSec        s              8f
     d wTime0          s              8f
     d wTimeStamp26    ds            26    based(pTimeStamp)
     d  wdtsYYYY               1      4s 0
     d  wdtsMM                 6      7s 0
     d  wdtsDD                 9     10s 0
     d  wdtsHH                12     13s 0
     d  wdtsMI                15     16s 0
     d  wdtsSS                18     19s 0
     d  wdtsCC                21     23s 0
     d wReal8          s              8f   based(pReal8)
     d uReal8          s              8f
     d wReal4          s              4f   based(pReal4)
     d uReal4          s              4f
     d UnQuoted        s               n   inz(*on)
     d wDec            s             16    based(pDec)
     d uDec            ds            16
     d uDec00                        31p00 overlay(uDec:1)
     d uDec01                        31p01 overlay(uDec:1)
     d uDec02                        31p02 overlay(uDec:1)
     d uDec03                        31p03 overlay(uDec:1)
     d uDec04                        31p04 overlay(uDec:1)
     d uDec05                        31p05 overlay(uDec:1)
     d uDec06                        31p06 overlay(uDec:1)
     d uDec07                        31p07 overlay(uDec:1)
     d uDec08                        31p08 overlay(uDec:1)
     d uDec09                        31p09 overlay(uDec:1)
     d uDec10                        31p10 overlay(uDec:1)
     d uDec11                        31p11 overlay(uDec:1)
     d uDec12                        31p12 overlay(uDec:1)
     d uDec13                        31p13 overlay(uDec:1)
     d uDec14                        31p14 overlay(uDec:1)
     d uDec15                        31p15 overlay(uDec:1)
     d uDec16                        31p16 overlay(uDec:1)
     d uDec17                        31p17 overlay(uDec:1)
     d uDec18                        31p18 overlay(uDec:1)
     d uDec19                        31p19 overlay(uDec:1)
     d uDec20                        31p20 overlay(uDec:1)
     d uDec21                        31p21 overlay(uDec:1)
     d uDec22                        31p22 overlay(uDec:1)
     d uDec23                        31p23 overlay(uDec:1)
     d uDec24                        31p24 overlay(uDec:1)
     d uDec25                        31p25 overlay(uDec:1)
     d uDec26                        31p26 overlay(uDec:1)
     d uDec27                        31p27 overlay(uDec:1)
     d uDec28                        31p28 overlay(uDec:1)
     d uDec29                        31p29 overlay(uDec:1)
     d uDec30                        31p30 overlay(uDec:1)
     d uDec31                        31p31 overlay(uDec:1)
     d DecLen          ds             2
     d lenB2                   1      2i 0
     d   lenG                  1      1i 0
     d   lenD                  2      2i 0
     d num42           s              4  2
     d wNum            s             31    based(pNum)
     d uNum            ds            31
     d uNum00                        31 00 overlay(uNum:1)
     d uNum01                        31 01 overlay(uNum:1)
     d uNum02                        31 02 overlay(uNum:1)
     d uNum03                        31 03 overlay(uNum:1)
     d uNum04                        31 04 overlay(uNum:1)
     d uNum05                        31 05 overlay(uNum:1)
     d uNum06                        31 06 overlay(uNum:1)
     d uNum07                        31 07 overlay(uNum:1)
     d uNum08                        31 08 overlay(uNum:1)
     d uNum09                        31 09 overlay(uNum:1)
     d uNum10                        31 10 overlay(uNum:1)
     d uNum11                        31 11 overlay(uNum:1)
     d uNum12                        31 12 overlay(uNum:1)
     d uNum13                        31 13 overlay(uNum:1)
     d uNum14                        31 14 overlay(uNum:1)
     d uNum15                        31 15 overlay(uNum:1)
     d uNum16                        31 16 overlay(uNum:1)
     d uNum17                        31 17 overlay(uNum:1)
     d uNum18                        31 18 overlay(uNum:1)
     d uNum19                        31 19 overlay(uNum:1)
     d uNum20                        31 20 overlay(uNum:1)
     d uNum21                        31 21 overlay(uNum:1)
     d uNum22                        31 22 overlay(uNum:1)
     d uNum23                        31 23 overlay(uNum:1)
     d uNum24                        31 24 overlay(uNum:1)
     d uNum25                        31 25 overlay(uNum:1)
     d uNum26                        31 26 overlay(uNum:1)
     d uNum27                        31 27 overlay(uNum:1)
     d uNum28                        31 28 overlay(uNum:1)
     d uNum29                        31 29 overlay(uNum:1)
     d uNum30                        31 30 overlay(uNum:1)
     d uNum31                        31 31 overlay(uNum:1)
     d wBin8           s             20i 0 based(pBin8)
     d uBin8           s             20i 0
     d wBin4           s             10i 0 based(pBin4)
     d uBin4           s             10i 0
     d wBin2           s              5u 0 based(pBin2)
     d uBin2           s              5u 0
      /free
       sqlvar = p1;
B01    select;
X01       when sqltype = 384 or sqltype = 385;
             exsr sqldate;
             //?  exsr sqlhexa;
X01       when sqltype = 388 or sqltype = 389;
             exsr sqltime;
             //?  exsr sqlhexa;
X01       when sqltype = 392 or sqltype = 393;
             exsr sqltimestamp;
             //?  exsr sqlhexa;
X01       when sqltype = 448 or sqltype = 449;
             exsr sqlVarChar;
             //?exsr sqlhexa;
X01       when sqltype = 452 or sqltype = 453;
             exsr sqlchar;
             //?  exsr sqlhexa;
X01       when sqltype = 480 or sqltype = 481;
             exsr sqlreal;
             //?  exsr sqlhexa;
X01       when sqltype = 484 or sqltype = 485;
             exsr sqldec ;
             //?exsr sqlhexa;
X01       when sqltype = 488 or sqltype = 489;
             exsr sqlnumeric;
             //?exsr sqlhexa;
X01       when sqltype = 492 or sqltype = 493;
             exsr sqlint8;
             //?exsr sqlhexa;
X01       when sqltype = 496 or sqltype = 497;
             exsr sqlint4;
             //?exsr sqlhexa;
X01       when sqltype = 500 or sqltype = 501;
             exsr sqlint2;
             //?exsr sqlhexa;
X01       other;
             exsr sqlunsupported;
E01    endsl;
       return;
       //?*=----------------------------------------------------------------------------------=*
       //?* vidage hexa
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlhexa;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pData = sqldata;
B02       select;
X02          when sqltype = 484 or sqltype = 485;
                //?decimal packed
                wLen=sqllen / 256 ;
B03             if odd(wlen);
                   wlen+=1;
E03             endif;
                wlen=wlen/2;
X02          when sqltype = 488 or sqltype = 489;
                //?numeric
                wLen=sqllen / 256 ;
X02          other;
                wLen=sqllen;
E02       endsl;
          uData = %subst(wData:1:wLen);
          c_style(row:col:0);
          c_text(row:col:hexa(uData));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  date
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqldate;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pDate = sqldata;
          //?marche pas, retourne le format DD/MM/YYYY au lieu de DD/MM/YY
          //?callp ceefmda('  ':sformat:*omit);
          //?if %error;
          //?sFormat='DD/MM/YY';
          //?endif;
          callp ceedays('1899-12-30':'YYYY-MM-DD':DateSerial0:*omit);
B02       if %error;
             dateSerial =0;
E02       endif;
B02       select;
X02          when jobdatfmt='*YMD';
                sformat = 'YY' + jobdatsep + 'MM' + jobdatsep + 'DD';
                callp ceedays(date8 :sformat :DateSerial :*omit);
                dateserial-=dateserial0;
                c_style(row:col:styleDateIso);
                c_num (row:col:dateserial);
X02          when jobdatfmt='*DMY';
                sformat = 'DD' + jobdatsep + 'MM' + jobdatsep + 'YY';
                callp ceedays(date8 :sformat :DateSerial :*omit);
                dateserial-=dateserial0;
                c_style(row:col:styleDateIso);
                c_num (row:col:dateserial);
X02          when jobdatfmt='*MDY';
                sformat = 'MM' + jobdatsep + 'DD' + jobdatsep + 'YY';
                callp ceedays(date8 :sformat :DateSerial :*omit);
                dateserial-=dateserial0;
                c_style(row:col:styleDateIso);
                c_num (row:col:dateserial);
X02          when jobdatfmt='*JUL';
                sformat = 'YY' + jobdatsep + 'DDD';
                callp ceedays(date7 :sformat :DateSerial :*omit);
                dateserial-=dateserial0;
                c_style(row:col:styleDateIso);
                c_num (row:col:dateserial);
X02          other;
                c_style(row:col:0);
                c_text(row:col:dateds );
E02       endsl;
B02       if sylkcolsize(col) < 10;
             sylkcolsize(col) = 10;
E02       endif;
E01    endsr;
       //?*=------------------------------------------------------=*//
       //?TIME
       //?*=------------------------------------------------------=*//
B01    begsr sqltime;
          //?c_text(row:col:'time         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pTime = sqldata;
          dstime = wtime;
          //?heure = nb secondes pour la date pivot
          callp ceeisec(1899:12:30:whh:wmm:wss:0:wtimesec:*omit);
B02       if %error;
             wtimesec=0;
E02       endif;
          //?heure0= nb secondes pour la date pivot
          callp ceeisec(1899:12:30:00:00:00:0:wTime0:*omit) ;
B02       if %error;
             wtime0=0;
E02       endif;
          //?nb secondes exact
          wTimesec-=wTime0;
          //?converti en jour
          wtimesec=wtimesec / 86400;
          c_style(row:col:26);
          c_num(row:col:wTimeSec);
B02       if sylkcolsize(col) < 08;
             sylkcolsize(col) = 08;
E02       endif;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  DateTimeStamp
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqltimestamp;
          //?c_text(row:col:'timestamp    ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pTimeStamp = sqldata;
          callp ceeisec(wdtsYYYY:wdtsMM:wdtsDD
             :wdtsHH:wdtsMI:wdtsSS:wdtsCC
             :wTimeSec:*omit);
B02       if %error;
             wtimesec=0;
E02       endif;
          //?heure0= nb secondes pour la date pivot
          callp ceeisec(1899:12:30:00:00:00:0:wTime0:*omit) ;
B02       if %error;
             wtime0=0;
E02       endif;
          //?nb secondes exact ... si l'année est >= 1900
B02       if wtimesec > wtime0;
             wTimesec-=wTime0;
X02       else;
             wTimeSec=0;
E02       endif;
          //?converti en jour
          wtimesec=wtimesec / 86400;
          c_style(row:col:styleDTSiso);
          c_num(row:col:wTimeSec);
B02       if sylkcolsize(col) < 23;
             sylkcolsize(col) = 23;
E02       endif;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* VARCHAR
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlvarchar;
          //?c_text(row:col:'char         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pvarchar = sqldata;
          uData = wvarchar;
          c_style(row:col:0);
          c_text(row:col:uData);
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* CHAR
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlchar;
          //?c_text(row:col:'char         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pData = sqldata;
          uData = %subst(wData:1:sqlLen);
          c_style(row:col:0);
          c_text(row:col:uData);
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  Float
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlreal;
          //?c_text(row:col:'real         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
B02       if sqllen = 4;
             preal4= sqldata;
             ureal4= wreal4;
             uData = %char(uReal4);
B03          if %subst(uData : 1 : 1) = '+';
                %subst(uData : 1 : 1) = ' ';
E03          endif;
             c_style(row:col:0);
             c_text(row:col: uData:Unquoted);
E02       endif;
B02       if sqllen = 8;
             preal8= sqldata;
             ureal8= wreal8;
             uData = %char(uReal8);
B03          if %subst(uData : 1 : 1) = '+';
                %subst(uData : 1 : 1) = ' ';
E03          endif;
             c_style(row:col:0);
             c_text(row:col:uData:Unquoted);
E02       endif;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  packed decimal
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqldec ;
          //?c_text(row:col:'dec          ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pDec = sqldata;
          lenB2 = sqllen;
          lenG+=1;//?pour le signe
B02       if odd(lenG);
             lenG+=1;
E02       endif;
          lenG=lenG/2;
          uDec=*loval;
          %subst(uDec: 16 - lenG + 1: lenG) = %subst(wDec :1:lenG);
          c_style(row:col:0);
B02       select;
X02          when lenD = 1;
                c_style(row:col:styleDec01);
                c_num(row:col:uDec01 );
X02          when lenD = 2;
                c_style(row:col:styleDec02);
                c_num(row:col:uDec02 );
X02          when lenD = 3;
                c_style(row:col:styleDec03);
                c_num(row:col:uDec03 );
X02          when lenD = 4;
                c_style(row:col:styleDec04);
                c_num(row:col:uDec04 );
X02          when lenD = 5;
                c_style(row:col:styleDec05);
                c_num(row:col:uDec05 );
X02          when lenD = 6;
                c_style(row:col:styleDec06);
                c_num(row:col:uDec06 );
X02          when lenD = 7;
                c_style(row:col:styleDec07);
                c_num(row:col:uDec07 );
X02          when lenD = 8;
                c_style(row:col:styleDec08);
                c_num(row:col:uDec08 );
X02          when lenD = 9;
                c_style(row:col:styleDec09);
                c_num(row:col:uDec09 );
X02          when lenD = 10;
                c_style(row:col:styleDec10);
                c_num(row:col: uDec10 );
X02          when lenD = 11;
                c_style(row:col:styleDec11);
                c_num(row:col: uDec11 );
X02          when lenD = 12;
                c_style(row:col:styleDec12);
                c_num(row:col: uDec12 );
X02          when lenD = 13;
                c_style(row:col:styleDec13);
                c_num(row:col: uDec13 );
X02          when lenD = 14;
                c_style(row:col:styleDec14);
                c_num(row:col: uDec14 );
X02          when lenD = 15;
                c_style(row:col:styleDec15);
                c_num(row:col: uDec15 );
X02          when lenD = 16;
                c_style(row:col:styleDec16);
                c_num(row:col: uDec16 );
X02          when lenD = 17;
                c_style(row:col:styleDec17);
                c_num(row:col: uDec17 );
X02          when lenD = 18;
                c_style(row:col:styleDec18);
                c_num(row:col: uDec18 );
X02          when lenD = 19;
                c_style(row:col:styleDec19);
                c_num(row:col: uDec19 );
X02          when lenD = 20;
                c_style(row:col:styleDec20);
                c_num(row:col: uDec20 );
X02          when lenD = 21;
                c_style(row:col:styleDec21);
                c_num(row:col: uDec21 );
X02          when lenD = 22;
                c_style(row:col:styleDec22);
                c_num(row:col: uDec22 );
X02          when lenD = 23;
                c_style(row:col:styleDec23);
                c_num(row:col: uDec23 );
X02          when lenD = 24;
                c_style(row:col:styleDec24);
                c_num(row:col: uDec24 );
X02          when lenD = 25;
                c_style(row:col:styleDec25);
                c_num(row:col: uDec25 );
X02          when lenD = 26;
                c_style(row:col:styleDec26);
                c_num(row:col: uDec26 );
X02          when lenD = 27;
                c_style(row:col:styleDec27);
                c_num(row:col: uDec27 );
X02          when lenD = 28;
                c_style(row:col:styleDec28);
                c_num(row:col: uDec28 );
X02          when lenD = 29;
                c_style(row:col:styleDec29);
                c_num(row:col: uDec29 );
X02          when lenD = 30;
                c_style(row:col:styleDec30);
                c_num(row:col: uDec30 );
X02          when lenD = 31;
                c_style(row:col:styleDec31);
                c_num(row:col: uDec31 );
X02          other ;
                c_style(row:col:1);
                c_num(row:col:uDec00 );
E02       endsl;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* numeric etendu
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlnumeric;
          //?c_text(row:col:'numeric      ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pNum = sqldata;
          lenB2 = sqllen;
          uNum=*zero ;
          %subst(uNum: 31 - lenG + 1: lenG) = %subst(wNum :1:lenG);
          c_style(row:col:0);
B02       select;
X02          when lenD = 1;
                c_style(row:col:styleDec01);
                c_num(row:col:uNum01 );
X02          when lenD = 2;
                c_style(row:col:styleDec02);
                c_num(row:col:uNum02 );
X02          when lenD = 3;
                c_style(row:col:styleDec03);
                c_num(row:col:uNum03 );
X02          when lenD = 4;
                c_style(row:col:styleDec04);
                c_num(row:col:uNum04 );
X02          when lenD = 5;
                c_style(row:col:styleDec05);
                c_num(row:col:uNum05 );
X02          when lenD = 6;
                c_style(row:col:styleDec06);
                c_num(row:col:uNum06 );
X02          when lenD = 7;
                c_style(row:col:styleDec07);
                c_num(row:col:uNum07 );
X02          when lenD = 8;
                c_style(row:col:styleDec08);
                c_num(row:col:uNum08 );
X02          when lenD = 9;
                c_style(row:col:styleDec09);
                c_num(row:col:uNum09 );
X02          when lenD = 10;
                c_style(row:col:styleDec10);
                c_num(row:col: uNum10 );
X02          when lenD = 11;
                c_style(row:col:styleDec11);
                c_num(row:col: uNum11 );
X02          when lenD = 12;
                c_style(row:col:styleDec12);
                c_num(row:col: uNum12 );
X02          when lenD = 13;
                c_style(row:col:styleDec13);
                c_num(row:col: uNum13 );
X02          when lenD = 14;
                c_style(row:col:styleDec14);
                c_num(row:col: uNum14 );
X02          when lenD = 15;
                c_style(row:col:styleDec15);
                c_num(row:col: uNum15 );
X02          when lenD = 16;
                c_style(row:col:styleDec16);
                c_num(row:col: uNum16 );
X02          when lenD = 17;
                c_style(row:col:styleDec17);
                c_num(row:col: uNum17 );
X02          when lenD = 18;
                c_style(row:col:styleDec18);
                c_num(row:col: uNum18 );
X02          when lenD = 19;
                c_style(row:col:styleDec19);
                c_num(row:col: uNum19 );
X02          when lenD = 20;
                c_style(row:col:styleDec20);
                c_num(row:col: uNum20 );
X02          when lenD = 21;
                c_style(row:col:styleDec21);
                c_num(row:col: uNum21 );
X02          when lenD = 22;
                c_style(row:col:styleDec22);
                c_num(row:col: uNum22 );
X02          when lenD = 23;
                c_style(row:col:styleDec23);
                c_num(row:col: uNum23 );
X02          when lenD = 24;
                c_style(row:col:styleDec24);
                c_num(row:col: uNum24 );
X02          when lenD = 25;
                c_style(row:col:styleDec25);
                c_num(row:col: uNum25 );
X02          when lenD = 26;
                c_style(row:col:styleDec26);
                c_num(row:col: uNum26 );
X02          when lenD = 27;
                c_style(row:col:styleDec27);
                c_num(row:col: uNum27 );
X02          when lenD = 28;
                c_style(row:col:styleDec28);
                c_num(row:col: uNum28 );
X02          when lenD = 29;
                c_style(row:col:styleDec29);
                c_num(row:col: uNum29 );
X02          when lenD = 30;
                c_style(row:col:styleDec30);
                c_num(row:col: uNum30 );
X02          when lenD = 31;
                c_style(row:col:styleDec31);
                c_num(row:col: uNum31 );
X02          other ;
                c_style(row:col:1);
                c_num(row:col:uNum00 );
E02       endsl;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  binaire 8 octets
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint8;
          //?c_text(row:col:'int8         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pBin8 = sqldata;
          uBin8 = wBin8;
          c_style(row:col:0);
          c_num(row:col:uBin8 );
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* binaire 4
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint4;
          //?c_text(row:col:'int4         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pBin4 = sqldata;
          uBin4 = wBin4;
          c_style(row:col:0);
          c_num(row:col:uBin4 );
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* binaire 2
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint2;
          //?c_text(row:col:'int2         ');
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                c_style(row:col:0);
                c_text(row:col:%trim(NullValue));
                leavesr;
E03          endif;
E02       endif;
          pBin2 = sqldata;
          uBin2 = wBin2;
          c_style(row:col:0);
          c_num(row:col:uBin2 );
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* autre
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlunsupported;
          uData='unsupported.' ;
          uData+=' type' ;
          uData+=%editc(sqltype:'Z') ;
          uData+='; RPG type ' ;
          uData+= %trim(buftyp(sqltype));
          uData +='; longueur ' + %editc(sqllen:'P');
          c_text(row:col:uData);
E01    endsr;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 e
    ? *=----------------------------------------------------------------------------------=*
    ? *
    ? *=----------------------------------------------------------------------------------=*
BPR  P hexa            b
     d hexa            pi         30000    varying
     d  txt                       15000    varying const
     d  i              s              5u 0
     d  hex            s          30000    varying
     d  h              ds             2
     d  h1                     1      1i 0
     d  h2                     2      2i 0
     d  c                      1      1
     d  h12                    1      2i 0
     d  x12                    1      2
     d  w12            s              2
      /free
B01    for i = 1 to %len(txt);
          h12 = 0;
          c = %subst(txt:i:1);
          h12=h12/ 16;
          h2 =h2 / 16;
          w12 = x12;
          x12 = %bitand(x12:x'0F0F');
B02       select;
X02          when h1 = 0;
                hex +='0';
X02          when h1 = 1;
                hex +='1';
X02          when h1 = 2;
                hex +='2';
X02          when h1 = 3;
                hex +='3';
X02          when h1 = 4;
                hex +='4';
X02          when h1 = 5;
                hex +='5';
X02          when h1 = 6;
                hex +='6';
X02          when h1 = 7;
                hex +='7';
X02          when h1 = 8;
                hex +='8';
X02          when h1 = 9;
                hex +='9';
X02          when h1 =10;
                hex +='A';
X02          when h1 =11;
                hex +='B';
X02          when h1 =12;
                hex +='c';
X02          when h1 =13;
                hex +='D';
X02          when h1 =14;
                hex +='E';
X02          when h1 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
B02       select;
X02          when h2 = 0;
                hex +='0';
X02          when h2 = 1;
                hex +='1';
X02          when h2 = 2;
                hex +='2';
X02          when h2 = 3;
                hex +='3';
X02          when h2 = 4;
                hex +='4';
X02          when h2 = 5;
                hex +='5';
X02          when h2 = 6;
                hex +='6';
X02          when h2 = 7;
                hex +='7';
X02          when h2 = 8;
                hex +='8';
X02          when h2 = 9;
                hex +='9';
X02          when h2 =10;
                hex +='A';
X02          when h2 =11;
                hex +='B';
X02          when h2 =12;
                hex +='c';
X02          when h2 =13;
                hex +='D';
X02          when h2 =14;
                hex +='E';
X02          when h2 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
E01    endfor;
       return hex;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 e
    ?
    ?D**********************************************************************************************
    ?D* *BufTyp      - Return buffer field type.                                                   *
    ?D**********************************************************************************************
BPR  PBufTyp           B
     DBufTyp           PI                  LIKE(RtnTyp)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
    ? *********************
    ? * Return field type *
    ? *********************
      /free
B01    SELECT;
X01       WHEN InpTyp = 384 OR
                InpTyp = 385;
             RtnTyp = 'DATE';
X01       WHEN InpTyp = 388 OR
                InpTyp = 389 ;
             RtnTyp = 'TIME';
X01       WHEN InpTyp = 392 OR
                InpTyp = 393;
             RtnTyp = 'TIMESTAMP';
X01       WHEN InpTyp = 400 OR
                InpTyp = 401 ;
             //?Unsupported Nul-term graphic.
             RtnTyp = 'NUL-TERM GRAPHIC';
X01       WHEN InpTyp = 404 OR
                InpTyp = 405 ;
             RtnTyp = 'BLOB';
X01       WHEN InpTyp = 408 OR
                InpTyp = 409 ;
             RtnTyp = 'CLOB' ;
X01       WHEN InpTyp = 412 OR
                InpTyp = 413 ;
             RtnTyp = 'DBCLOB';
X01       WHEN InpTyp = 448 OR
                InpTyp = 449 ;
             RtnTyp = 'VARCHAR';
X01       WHEN InpTyp = 452 OR
                InpTyp = 453 ;
             RtnTyp = 'CHAR' ;
X01       WHEN InpTyp = 456 OR
                InpTyp = 457 ;
             RtnTyp = 'LONG VARCHAR';
X01       WHEN InpTyp = 460 OR
                InpTyp = 461;
             //?Unsupported Nul-term character.
             RtnTyp = 'NUL-TERM CHAR';
X01       WHEN InpTyp = 464 OR
                InpTyp = 465 ;
             RtnTyp = 'VARGRAPHIC';
X01       WHEN InpTyp = 468 OR
                InpTyp = 469 ;
             RtnTyp = 'GRAPHIC';
X01       WHEN InpTyp = 472 OR
                InpTyp = 473 ;
             RtnTyp = 'LONG VARGRAPHIC';
X01       WHEN InpTyp = 476 OR
                InpTyp = 477 ;
             //?Unsupported  PASCAL L
             RtnTyp = 'PASCAL L-STRING';
X01       WHEN InpTyp = 480 OR
                InpTyp = 481 ;
             RtnTyp = 'REAL';
X01       WHEN InpTyp = 484 OR
                InpTyp = 485 ;
             RtnTyp = 'DEC';
X01       WHEN InpTyp = 488 OR
                InpTyp = 489 ;
             //?Unsupported
             RtnTyp = 'NUMERIC';
X01       WHEN InpTyp = 496 OR
                InpTyp = 497 ;
             RtnTyp = 'INT';
X01       WHEN InpTyp = 500 OR
                InpTyp = 501 ;
             RtnTyp = 'SMALLINT';
X01       WHEN InpTyp = 504 OR
                InpTyp = 505 ;
             //?Unsupported
             RtnTyp = 'SIGN LEADING';
X01       WHEN InpTyp = 960 OR
                InpTyp = 961;
             RtnTyp = 'BLOB DATALINK';
X01       WHEN InpTyp = 964 OR
                InpTyp = 965;
             RtnTyp = 'CLOB DATALINK';
X01       WHEN InpTyp = 968 OR
                InpTyp = 969 ;
             RtnTyp = 'DBCLOB DATALINK';
E01    ENDSL;
       RETURN RtnTyp ;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
BPR  preallocselda     b
     Dreallocselda     Pi
     D sqlcols                        5u 0 CONST
      /free
       SelDASiz = sqlcols * %SIZE(SQLVAR) + 16;
B01    IF pSelDA <> *NULL;
          pselda= %REALLOC(pSelDA:SelDASiz);
X01    ELSE;
          pselda= %ALLOC(SelDASiz);
E01    ENDif;
       SQLN = sqlcols;//?Available fields.
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ?
    ?C*=------------------------------------------------------------------------
BPR  p pmqcln          b
     d pmqcln          pi
    ? * prototype de QMHRMVMPM
    ? *                                    Required Parameter Group:
    ? *                                    1 Call stack entry Input Char(*) or Pointer
    ? *                                    2 Call stack counter Input Binary(4)
    ? *                                    3 Message key Input Char(4)
    ? *                                    4 Messages to remove Input Char(10)
    ? *                                    5 Error code I/O Char(*)
    ? *                                    Optional Parameter Group 1:
    ? *                                    6 Length of call stack entry Input Binary(4)
    ? *                                    7 Call stack entry qualification Input Char(20)
    ? *                                    8 Remove unhandled exceptions Input Char(10)
    ? *                                    Optional Parameter Group 2:
    ? *                                    9 Call stack entry data type Input Char(10)
    ? *                                    Threadsafe: Yes
     d qmhrmvpm        pr                  extpgm('QMHRMVPM')
     D  callstackentr                10      const
     D  callstackcoun                 9B 0   const
     D  messagekey                    4      const
     D  messagetoremo                10      const
     d    errorhandle               255
    ?D********************
    ?D*
    ?D* ERROR CODE HANDLING FIELDS
    ?D*
    ?D********************
     D ECH             DS
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZONE
     D  ECH02                  5      8B 0                                      lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERREUR
     D  ECH5A                 17    117
    ? * effacer la pile de messages du sous-fichier de messages
    ? *=------------------------------------------------------------------=*
      /free
       //?initialisation sous-fichier de messages
       eval      pmqpgm = '*';
       //?Clear messages from program message queue
       //?stack count : on est 1 niveau en dessous de la procedure qui fait le write du pmqctl
       ECH03=*blank;
       CALLp      QMHRMVPM    ('*':1:' ' :'*ALL' :ECH);
B01    IF ECH03 <> *BLANK;
          eval spmsid = ECH03;
          eval      spmsda = 'ERR S/QMHRMVPM';
          dump;
E01    ENDIF;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------=*
    ? * ajouter un message, 1 paramètre : n° de message
BPR  p pmqmsg          b
     d pmqmsg          pi
     d    msgno                       7    const
     d  w_msgkey       s              4    inz(*blank)
    ? *stack count : on est 1 niveau en dessous de la procedure qui fait le write du pmqctl
    ? *donc la procedure qui fait le QMHSNDPM est 2 niveaux en dessous du write du pmqctl
     c                   callp     pmqmsg8(msgno : '*LIBL' : 'LMESSAGE' :
     c                                     *blank  : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------=*
    ? *                     2 paramètres : n° de message et texte de message
BPR  p pmqmsg2         b
     d pmqmsg2         pi
     d    msgno                       7    const
     d    msgdata                  6000    const varying
     d  w_msgkey       s              4    inz(*blank)
     c                   callp     pmqmsg8(msgno : '*LIBL' : 'LMESSAGE' :
     c                                     msgdata : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------=*
    ? *                     4 paramètres : n° de message, texte de message et fichier
BPR  p pmqmsg4         b
     d pmqmsg4         pi
     d    msgno                       7    const
     d    msgdata                  6000    const varying
     d    msglib                     10    const
     d    msgfile                    10    const
     d  w_msgkey       s              4    inz(*blank)
     c                   callp     pmqmsg8(msgno : msglib  : msgfile   :
     c                                     msgdata : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)

    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------=*
    ? *                     8 paramètres : toutes les informations
BPR  p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE
     d  p_msgtype                    10    const         options(*nopass)       *DIAG
     d  p_msgcse                     10    const         options(*nopass)       call stack entry
     d  p_msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d  p_msgkey                      4                  options(*nopass)       message key

     d  w_msgno        s              7
     d  w_msgflib      s             10    inz('*LIBL')
     d  w_msgffile     s             10    inz('LMESSAGE')
     d  w_msgdata      s           6000    varying inz('')
     d  w_msgtype      s             10    inz('*DIAG')
     d  w_msgcse       s             10    inz('*')
     d  w_msgcsc       s              4B 0 inz(2)
     d  w_msgkey       s              4    inz(*blank)
      /free
B01    if %parms >= 7;
          w_msgcsc = p_msgcsc;
E01    endif;
B01    if %parms >= 6;
          w_msgcse = p_msgcse;
E01    endif;
B01    if %parms >= 5;
          w_msgtype = p_msgtype;
E01    endif;
B01    if %parms >= 4;
          w_msgffile = p_msgffile;
E01    endif;
B01    if %parms >= 3;
          w_msgflib = p_msgflib;
E01    endif;
B01    if %parms >= 2;
          w_msgdata = p_msgdata;
E01    endif;
B01    if %addr(p_msgno) <> *null;
          w_msgno = p_msgno;
E01    endif;
       callp pmqmsg8(w_msgno : w_msgflib : w_msgffile :
          w_msgdata : w_msgtype : w_msgcse :
          w_msgcsc : w_msgkey );
B01    if %parms >= 8;
          eval p_msgkey = w_msgkey;
E01    endif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------=*
    ? *                     8 paramètres : toutes les informations
BPR  p pmqmsg8         b
     d pmqmsg8         pi
     d  p_msgno                       7    const                                n°
     d  p_msgflib                    10    const                                *LIBL
     d  p_msgffile                   10    const                                MESSAGE
     d  p_msgdata                  6000    const varying                        variables
     d  p_msgtype                    10    const                                *DIAG
     d  p_msgcse                     10    const                                call stack entry
     d  p_msgcsc                      4B 0 const                                call stack counter
     d  p_msgkey                      4                                         message key
     D                 DS
     d    msgno                       7
     d    msgflib                    10
     d    msgffile                   10
     d    msgdata                  6000
     d    msgtype                    10
     d    msgcse                     10
     d    msgcsc                      4B 0
     d    msgkey                      4
    ? * prototype de QMHSNDMPM
    ? *  Required Parameters Group:
    ? *   1 Message identifier Input Char(7)
    ? *   2 Qualified message file name Input Char(20)
    ? *   3 Message data or immediate text Input Char(*)
    ? *   4 Length of message data or immediate text Input Binary(4
    ? *   5 Message type Input Char(10)
    ? *   6 Call stack entry Input Char(*) or Pointer
    ? *   7 Call stack counter Input Binary(4)
    ? *   8 Message key Output Char(4)
    ? *   9 Error code I/O Char(*)
    ? *  Optional Parameter Group 1:
    ? *   10 Length of call stack entry Input Binary(4)
    ? *   11 Call stack entry qualification Input Char(20)
    ? *   12 Display program messages screen wait time Input Binary
    ? *  Optional Parameter Group 2:
    ? *   13 Call stack entry data type Input Char(10)
    ? *   14 Coded character set identifier Input Binary(4)
    ? *  Threadsafe: Yes
    ? *
     d qmhsndpm        pr                  extpgm('QMHSNDPM')
     d    msgno                       7      const
     d    msgf                       20      const
     d    msgdata                  6000      const
     d    msgdatalen                  9b 0   const
     d    msgtype                    10      const
     d    stackentry                 10      const
     d    stackcount                  9b 0   const
     d    msgkey                      4      const
     d    errorhandle               255
    ?D********************
    ?D*
    ?D* ERROR CODE HANDLING FIELDS
    ?D*
    ?D********************
     D ECH             DS
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZONE
     D  ECH02                  5      8B 0                                      lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERREUR
     D  ECH5A                 17    117
      /free
       msgno = p_msgno;
       msgflib = p_msgflib;
       msgffile = p_msgffile;
       msgdata = p_msgdata;
       msgtype = p_msgtype;
       msgcse = p_msgcse;
       msgcsc = p_msgcsc;
       msgkey = p_msgkey;
       //?================================================================
       //?Send message to program's message queue
       //?================================================================
       //?If no message file specified, use default
B01    IF msgffile = *BLANK;
          msgffile = 'QCPFMSG';
E01    ENDif;
B01    IF msgflib = *BLANK ;
          msgflib  = '*LIBL';
E01    ENDif;
B01    IF msgtype = *BLANK;
          msgtype  = '*DIAG';
E01    ENDif;
B01    IF msgcse = *BLANK;
          msgcse   = '*';
E01    ENDif;
       CALLp QMHSNDPM ( msgno
          : msgffile + msgflib
          : msgdata
          : %len(msgdata)
          : msgtype
          : msgcse
          : msgcsc
          : msgkey
          : ECH );
B01    IF ech03 <> *BLANK;
          eval spmsid = ECH03;
          eval       spmsda = 'ERR S/QMHSNDPM';
          dump;
          //?planter le programme
          die('erreur' + ech03+ ';' + ech05);
E01    ENDIF;
       eval p_msgkey = msgkey;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ?c*=------------------------------------------------------------------------
    ?
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  PSylkQuote        B
     D SylkQuote       PI         32767    varying
     D InString                   32767    varying const
     D OutString       S          32767    varying
     D Pos             S              4  0
      /free
B01    if %len(instring) > 0 ;
          outstring = %trim(instring) ;
          pos = 1 ;
B02       for ever;
B03          if pos > %len(outstring);
                leave ;
E03          endif;
             pos = %scan(';' : outstring : pos) ;
B03          if pos = 0 ;
                leave ;
E03          endif;
             outstring = %replace(';;' :
             outstring :
                pos :
                1);
             pos = pos + 2 ;
E02       endfor;
E01    endif ;
       outstring = '"' + outstring + '"';
       return outstring;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_OuvrirEntete  B
     D s_OuvrirEntete  PI
    ?c*=-----------------
    ?c* styles standard et affichage obtenu
    ?c* p0       38711,66666 -38711,5 0 toto
    ?c* p1             38712 -38712 0 toto
    ?c* p2          38711,67 -38711,50 0,00 toto
    ?c* p3            38 712 -38 712 0 toto
    ?c* p4         38 711,67 -38 711,50 0,00 toto
    ?c* p5 (pourri)
    ?c* p6 (pourri)
    ?c* p7 (pourri)
    ?c* p8 (pourri)
    ?c* p9          38 712 ¤     -38 712 ¤ 0 ¤              toto
    ?c* p10      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p11      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p12      38 711,67 ¤  -38 711,50 ¤ 0,00 ¤           toto
    ?c* p13         3871167%     -3871150% 0%               toto
    ?c* p14      3871166,67%  -3871150,00% 0,00%            toto
    ?c* p15         3,87E+04     -3,87E+04 0,00E+00         toto
    ?c* p16          38,7E+3      -38,7E+3 000,0E+0         toto
    ?c* p17        38711 2/3    -38711 1/2 0                toto
    ?c* p18       38711  2/3   -38711  1/2 0                toto
    ?c* p19       25/12/2005               00/01/1900       toto
    ?c* p20        25-déc-05               00-janv-00       toto
    ?c* p21           25-déc               00-janv          toto
    ?c* p22           déc-05               janv-00          toto
    ?c* p23          3:59 PM               12:00 AM         toto
    ?c* p24       3:59:59 PM               12:00:00 AM      toto
    ?c* p25            15:59               00:00            toto
    ?c* p26         15:59:59               00:00:00         toto
    ?c* p27 25/12/2005 15:59               00/01/1900 00:00 toto
    ?c* p28            59:59               00:00            toto
    ?c* p29          59:59,4               00:00,0          toto
    ?c* p30 38711,66666      -38711,5      0                toto
    ?c* p31     929079:59:59               0:00:00          toto
    ?c* p32         38 712 ¤     -38 712 ¤              - ¤  toto
    ?c* p33           38 712     -38 712                -    toto
    ?c* p34      38 711,67 ¤  -38 711,50 ¤            - ¤    toto
    ?c* p35        38 711,67  -38 711,50              -      toto
    ?c* p36          ¤38 712    (¤38 712)  ¤0               toto
    ?c* p37          ¤38 712    (¤38 712)  ¤0               toto
    ?c* p38       ¤38 711,67  (¤38 711,50) ¤0,00            toto
    ?c* p39       ¤38 711,67  (¤38 711,50) ¤0,00            toto
    ?c* p40 ¤         38 712 ¤    (38 712) ¤            -    toto
    ?c* p41           38 712      (38 712)              -    toto
    ?c* p42 ¤      38 711,67 ¤ (38 711,50) ¤          -      toto
    ?c* p43        38 711,67   (38 711,50)            -      toto
    ?c* p44       2005-12-25               1900-01-00       toto
    ?c*
    ?c* structure du style de nombre :
    ?c* ;P nombre positif ;; nombre négatif ;; nombre zero ;; texte
    ?c*
    ?c*
    ?c*
      /free
       s_write('ID;PRPG;N;E');  //ID marqueur de sylk
       //?style P0
       s_write('P;PGeneral');
       //?style P1
       s_write('P;P0');
       //?style P2
       s_write('P;P0.00');
       //?style P3
       s_write('P;P#,##0');
       //?style P4
       s_write('P;P#,##0.00');
       //?style P5
       s_write('P;P#,##0\ "¤";;\-#,##0\ "¤"');
       //?style P6
       s_write('P;P#,##0\ "¤";;[Red]\-#,##0\ "¤"');
       //?style P7
       s_write('P;P#,##0.00\ "¤";;\-#,##0.00\ "¤"');
       //?style P8
       s_write('P;P#,##0.00\ "¤";;[Red]\-#,##0.00\ "¤"');
       //?style P9
       s_write('P;P#,##0\ "$";;\-#,##0\ "$"');
       //?style P10
       s_write('P;P#,##0\ "$";;[Red]\-#,##0\ "$"');
       //?style P11
       s_write('P;P#,##0.00\ "$";;\-#,##0.00\ "$"');
       //?style P12
       s_write('P;P#,##0.00\ "$";;[Red]\-#,##0.00\ "$"');
       //?style P13
       s_write('P;P0%');
       //?style P14
       s_write('P;P0.00%');
       //?style P15
       s_write('P;P0.00E+00');
       //?style P16
       s_write('P;P##0.0E+0');
       //?style P17
       s_write('P;P#" "?/?');
       //?style P18
       s_write('P;P#" "??/??');
       //?style P19
       s_write('P;Pdd/mm/yyyy');
       //?style P20
       s_write('P;Pdd\-mmm\-yy');
       //?style P21
       s_write('P;Pdd\-mmm');
       //?style P22
       s_write('P;Pmmm\-yy');
       //?style P23
       s_write('P;Ph:mm\ AM/PM');
       //?style P24
       s_write('P;Ph:mm:ss\ AM/PM');
       //?style P25
       s_write('P;Phh:mm');
       //?style P26
       s_write('P;Phh:mm:ss');
       //?style P27
       s_write('P;Pdd/mm/yyyy\ hh:mm');
       //?style P28
       s_write('P;Pmm:ss');
       //?style P29
       s_write('P;Pmm:ss.0');
       //?style P30
       s_write('P;P@');
       //?style P31
       s_write('P;P[h]:mm:ss');
       //?style P32
       s_write('P;P_-* #,##0\ "$"_-;;\-* #,##0\ "$"_-;'+
       ';_-* "-"\ "$"_-;;_-@_-');
       //?style P33
       s_write('P;P_-* #,##0\ "¤"-;;\-* #,##0\ "¤"-;'+
       ';_-* "-"\ "¤"-;;_-@_-');
       //?style P34
       s_write('P;P_-* #,##0.00\ "$"_-;;\-* #,##0.00\ "$"_-;' +
       ';_-* "-"??\ "$"_-;;_-@_-');
       //?style P35
       s_write('P;P_-* #,##0.00\ "¤"-;;\-* #,##0.00\ "¤"-;' +
       ';_-* "-"??\ "¤"-;;_-@_-');
       //?style P36
       s_write('P;P"$"#,##0_);;\("$"#,##0\)');
       //?style P37
       s_write('P;P"$"#,##0_);;[Red]\("$"#,##0\)');
       //?style P38
       s_write('P;P"$"#,##0.00_);;\("$"#,##0.00\)');
       //?style P39
       s_write('P;P"$"#,##0.00_);;[Red]\("$"#,##0.00\)');
       //?style P40
       s_write('P;P_("$"* #,##0_);;_("$"* \(#,##0\);;_("$"* "-"_);;_(@_)');
       //?style P41
       s_write('P;P_(* #,##0_);;_(* \(#,##0\);;_(* "-"_);;_(@_)');
       //?style P42
       s_write('P;P_("$"* #,##0.00_);;_("$"* \(#,##0.00\);'+
       ';_("$"* "-"_);;_(@_)');
       //?style P43
       s_write('P;P_(* #,##0.00_);;_(* \(#,##0.00\);;_(* "-"??_);;_(@_)');
       styleNombre = 43;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_style         B
     D s_style         PI             5u 0
     D   sylkdata                    80    varying const
      /free
       s_write('P;P' + %trim(sylkdata));
       styleNombre+=1;
       return styleNombre;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_polices       B
     D s_polices       PI
      /free
       //?style SM0
       s_write('P;FArial;M200');
       //?style SM1
       s_write('P;FArial;M220');
       //?style SM2
       s_write('P;FArial;M240');
       //?style SM3
       s_write('P;FArial;M260');
       //?style SM4 : fixe, = SM0 + gras
       //?style SM5
       s_write('P;EArial;M280');
       //?style SM6
       s_write('P;EArial;M300');
       //?style SM7
       s_write('P;EArial;M320');
       policenombre = 7;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_police        B
     D s_police        PI             5u 0
     D   sylkdata                    80    varying const
      /free
       s_write('P;E' + %trim(sylkdata));
       policeNombre+=1;
       return policeNombre;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_FermerEntete  B
     D s_FermerEntete  PI
      /free
       //?format par defaut d'une cellule
       s_write('F;P0;DG0G10;M255');
       //?limites de la feuille. Précisé avant de la remplir ... donc 65535 lignes de 256 cellules
       s_write('B;Y65536;X256;D0 0 65535 255');
       //?uuuuuuuh ?
       s_write('O;L;D;V0;K47;G100 0.001');
       //?fixer la largeur par défaut des colonnes
       s_write('F;W1 256 11');
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P c_style         B
     D c_style         PI
     d  prow                          5u 0 const
     d  pcol                          5u 0 const
     d   styleNumero                  5u 0         const options(*omit)
     d   police                       5u 0         const options(*omit:*nopass)
     d   bordure                      5    varying const options(*omit:*nopass)
     d   libre                       20    varying const options(*nopass)
     d wformat         s             20    varying
     d P3              s               n   inz(*off)
     d P4              s               n   inz(*off)
     d P5              s               n   inz(*off)
     d P6              s               n   inz(*off)
    ? *
    ? *
    ? *
     d   row           s              5u 0
     d   col           s              5u 0
      /free
       row =prow ;
       col =pcol ;
B01    if row > 65535;
          row = 0;
E01    endif;
B01    if col > 256;
          col = 0;
E01    endif;
B01    if %parms >= 3;
B02       if %addr(styleNumero ) <> *null ;
             p3=*on;
E02       endif;
E01    endif;
B01    if %parms >= 4;
B02       if %addr(police ) <> *null ;
             p4=*on;
E02       endif;
E01    endif;
B01    if %parms >= 5;
B02       if %addr(bordure ) <> *null ;
             p5=*on;
E02       endif;
E01    endif;
B01    if %parms >= 6;
B02       if %addr(libre ) <> *null ;
             p6=*on;
E02       endif;
E01    endif;
       wformat='F' ;

B01    if row > 0 and col > 0;
          wFormat  +=';Y' + %trim(%editc(row:'Z'))  ;
          wFormat  +=';X' + %trim(%editc(col:'Z'))  ;
X01    else;
B02       if row > 0;//?toute la ligne
             wFormat  +=';R' + %trim(%editc(row:'Z'))  ;
E02       endif;
B02       if col > 0;//?toute la colonne
             wFormat  +=';C' + %trim(%editc(col:'Z'))  ;
E02       endif;
E01    endif;


B01    if p3;
B02       if (styleNumero <= styleNombre) ;
             wformat    += ';P' + %trim(%editc(styleNumero:'3')) ;
E02       endif;
E01    endif;
B01    if p4 and p5;
          wformat += ';S' + bordure + 'M'+
          %trim(%editc(police:'3')) ;
X01    else ;
B02       if p4;
             wformat += ';SM'+
             %trim(%editc(police:'3')) ;
E02       endif;
B02       if p5;
             wformat += ';S' + bordure + 'M0';
E02       endif;
E01    endif;
B01    if p6;
B02       if %addr(libre) <> *null;
             wformat += libre;
E02       endif;
E01    endif;

B01    if %len(wformat) > 1;
          s_write(wformat);
E01    endif;
       return;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  p c_hauteur       b
     D c_hauteur       pi
     d  prow                          5u 0 const
     d  ptwips                        5u 0 const
     d   row           s              5u 0
     d   twips         s              5u 0
      /free
       row =prow ;
       twips =ptwips ;
       //?F;Mtwips;Rrow
B01    if twips < 1;
          twips = 1;
E01    endif;
B01    if row < 1;
          row = 1;
E01    endif;
B01    if row > 65535;
          row = 65535;
E01    endif;
       s_write('F;M' + %trim(%editc(twips:'Z')) +
       ';R' + %trim(%editc(row:'Z')) );
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  p c_largeur       b
     D c_largeur       pi
     d  pcoldeb                       5u 0 const
     d  pcolfin                       5u 0 const
     d  pcaracteres                   5u 0 const
     d   coldeb        s              5u 0
     d   colfin        s              5u 0
     d   caracteres    s              5u 0
      /free
       coldeb =pcoldeb ;
       colfin =pcolfin ;
       caracteres =pcaracteres;
       //?F;Mtwips;Rrow
B01    if coldeb < 1;
          coldeb= 1;
E01    endif;
B01    if coldeb > 256;
          coldeb = 256;
E01    endif;
B01    if colfin < 1;
          colfin= 1;
E01    endif;
B01    if colfin > 256;
          colfin = 256;
E01    endif;
B01    if coldeb > colfin;
          colfin = coldeb;
E01    endif;
B01    if caracteres < 0;
          caracteres = 0;
E01    endif;
B01    if caracteres > 255;
          caracteres = 255;
E01    endif;
       s_write('F;W' + %trim(%editc(coldeb:'Z')) +
       ' ' + %trim(%editc(colfin:'Z')) +
       ' ' + %trim(%editc(caracteres:'Z')) );
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  p c_police        b
     D c_police        pi
     d  prow                          5u 0 const
     d  pcol                          5u 0 const
     d  ppolice                       5u 0 const
     d   police        s              5u 0
     d   row           s              5u 0
     d   col           s              5u 0
     d   sylkdata      s             80    varying
      /free
       police =ppolice ;
       row =prow ;
       col =pcol ;
B01    if police < 0 ;
          police = 0;
E01    endif;
B01    if row > 65535;
          row = 0;
E01    endif;
B01    if col > 256;
          col = 0;
E01    endif;
       sylkdata='F;SM' + %trim(%editc(police:'3')) ;
B01    if row > 0 and col > 0;//?une seule cellule
          sylkdata +=';Y' + %trim(%editc(row:'Z'))
          + ';X' + %trim(%editc(col:'Z')) ;
X01    else;
B02       if row > 0;//?toute la ligne
             sylkdata +=';R' + %trim(%editc(row:'Z'))  ;
E02       endif;
B02       if col > 0;//?toute la colonne
             sylkdata +=';C' + %trim(%editc(col:'Z'))  ;
E02       endif;
E01    endif;
       s_write(sylkdata);
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P c_text          B
     D c_text          PI
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                 30000    varying const
     d   p4                            n   options(*nopass) const
     d   unquoted      s               n   inz(*off)
     D   sylk256       s            256    varying
      /free
B01    if %len(sylkdata) > 256 ;
          s_write('C;K"EXCEL capacity overflow"');
          callp message(
             'CPF9897'
          :' Line ' + %trim(%editc(row:'Z')) +
          ' Colmn ' + %trim(%editc(col:'Z')) +
          ' EXCEL capacity overflow.' +
          ' try to write TEXT ' +
          %trim(%editc(%len(sylkdata):'Z')) +
          ' character ( > 256)'
          :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
          sylk256 = %subst(sylkdata:1:250)+'...';
          DiagEmis=*on;
X01    else;
          sylk256 = sylkdata;
E01    endif;
B01    if %parms >=4;
          unquoted = p4;
E01    endif;
B01    if unquoted=*on;
          s_write('C' +
          ';Y' + %trim(%editc(row:'Z')) +
          ';X' + %trim(%editc(col:'Z')) +
          ';K' + sylk256 );
X01    else;
          s_write('C' +
          ';Y' + %trim(%editc(row:'Z')) +
          ';X' + %trim(%editc(col:'Z')) +
          ';K' + SylkQuote(sylk256 ));
E01    endif;
B01    if sylkcolsize(col) < %len(%trim(sylk256 ));
          sylkcolsize(col) = %len(%trim(sylk256 ));
E01    endif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P c_num           B
     D c_num           PI
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                    31s10 const
     d  texte          s             40    varying
      /free
       //?convertion en texte
       texte = %editc(sylkdata:'P');
       //?recherche zeros à droite (0 à 10, le nombre de décimales est fixe)
       %len(texte) = %checkr('0':texte);
       s_write('C' +
       ';Y' + %trim(%editc(row:'Z')) +
       ';X' + %trim(%editc(col:'Z')) +
       ';K' + %trim(texte)          );
B01    if sylkcolsize(col) < %len(%trim(texte ) );
          sylkcolsize(col) = %len(%trim(texte ) );
E01    endif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P c_formula       B
     D c_formula       PI
     d   row                          5u 0 const
     d   col                          5u 0 const
     D   sylkdata                 30000    varying const
     D   sylk256       s            256    varying
      /free
B01    if %len(sylkdata) > 256 ;
          s_write('C;K"EXCEL capacity overflow"');
          callp message(
             'CPF9897'
          :' Line ' + %trim(%editc(row:'Z')) +
          ' Column ' + %trim(%editc(col:'Z')) +
          ' EXCEL capacity overflow.' +
          ' try to write TEXT ' +
          %trim(%editc(%len(sylkdata):'Z')) +
          ' characters ( > 256)'
          :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
          sylk256 = %subst(sylkdata:1:250)+'...';
          DiagEmis=*on;
X01    else;
          sylk256 = sylkdata;
E01    endif;
       s_write('C' +
       ';Y' + %trim(%editc(row:'Z')) +
       ';X' + %trim(%editc(col:'Z')) +
       ';E' + %trim(sylk256 )       );
B01    if sylkcolsize(col) < %len(%trim(sylk256 ));
          sylkcolsize(col) = %len(%trim(sylk256 ));
E01    endif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_close         B
     D s_close         PI
      /free
       s_write('E');
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P s_write         B
     D s_write         PI
     D   sylkdata                 30000    varying const
      /free
B01    if %len(sylkdata) > %size(sql2sylkd);
          sql2sylkd='C;K"dépassement de capacité RPG DDS"';
          write sql2sylkf;
E01    endif;
       sql2sylkd=sylkdata;
       write sql2sylkf;
       //?erreur ?
B01    if %eof(sql2sylkp);
          die('S_Write, erreur d''ecriture');
E01    endif;
      /end-free
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P die             B
    ?D*die             PI             1N
     D die             PI
     D    msg                       256A   const
     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                  256A
     D dsEC            DS
     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
     D  dsECBytesA             5      8I 0 inz(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
     D MsgLen          S             10I 0
     D TheKey          S              4A
     c     ' '           checkr    msg           MsgLen
B01  c                   if        MsgLen<1
    ?c*                  return    *off
E01  c                   endif
     c                   callp     QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL':
     c                               Msg: MsgLen: '*ESCAPE':
     c                               '*': 3: TheKey: dsEC)
    ?c*                  return    *off
    ?C*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
    ? *=--------------------------------------------------------------------------------------------
    ? *
    ? *=--------------------------------------------------------------------------------------------
BPR  P EscSqlEr        B
    ?D*EscSqlEr        PI             1N
     D EscSqlEr        PI
     D   pa_cod                       9b 0 const
     D   sqlcod        s              9s 0
     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                      1A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                  256A
     D dsEC            DS
     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
     D  dsECBytesA             5      8I 0 inz(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
     D TheKey          S              4A
     D MsgID           S              7A
B01  c                   if        pa_cod < 0
     c                   eval      sqlcod = - pa_cod
X01  c                   else
     c                   eval      sqlcod =   pa_cod
E01  c                   endif
     c                   move      sqlcod        MsgID
     c                   movel     'SQL'         MsgID
     c                   callp     QMHSNDPM(MsgID: 'QSQLMSG   *LIBL':
     c                               ' ': 0: '*ESCAPE':
     c                               '*': 1: TheKey: dsEC)
    ?c*                  return    *off
    ?c*=------------------------------------------------------------------------
B01  C     *PSSR         BEGSR
     C                   DUMP
E01  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 E
