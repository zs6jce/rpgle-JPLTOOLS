    ? * test :
    ? * SELECT DATEJ, LIBJOU, LIBMOI, JOUSEM, JULANN, JULSIE, SEMAIN,
    ? * SEMIND, JOUVRE, nullif( 1 , 1 ) nullcol, current date today ,
    ? * current time now , current timestamp a_timestamp , current path
    ? * the_path , current schema the_schema , current server the_server ,
    ? * current timezone our_time_zone , user me , decimal(days(current
    ? * date), 7, 0) a_decimal_data , zoned(days(current date), 7, 0)
    ? * a_zoned_data , double(days(current date) ** 12 ) float8_data ,
    ? * bigint(days(current date) ** 3 ) Integer8_data FROM ficdatp WHERE
    ? * DATEJ between 20060101 and 20060133
    ? * Le fichier JPL de la bibliothèque JPL a été remplacé.
    ? *
    ? * SQL2XLS SQL('select * from jpl/jpl')
    ? *
    ?
    ?
    ?
    ?
    ?
    ?
    ? *
      /define INFDS
    ? *define VBEL
    ? *define ECOPRO
      /define SQL
      /define SQLDESCRIBE
      /define LOWERCASE
    ? *define QUOTE
      /define XLXML
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')

      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

    ? * styles de cellules
    ? * styles de base
     d Titre           s                   like(x_style)
     d evenline        s                   like(x_style)
     d oddline         s                   like(x_style)
     d evendate        s                   like(x_style)
     d odddate         s                   like(x_style)
     d eventime        s                   like(x_style)
     d oddtime         s                   like(x_style)
     d evendts         s                   like(x_style)
     d odddts          s                   like(x_style)
     d evennumber      s                   like(x_style)
     d oddnumber       s                   like(x_style)
     d evenInt         s                   like(x_style)
     d oddInt          s                   like(x_style)
     d savestyle       s                   like(style)
    ? * styles selon le type de colonne
     d CellStyle       ds                  qualified
     d row                                 dim(2)
     d                                     likeds(CellCol)
     d CellCol         ds                  qualified
     d col                                 like(x_style)
     d                                     dim(256)

     D nbcol           s              5u 0
     d FreezePaneAt    s              5u 0 inz(01)

     d                 ds             2
     d lenB2                   1      2i 0
     d   lenG                  1      1i 0
     d   lenD                  2      2i 0

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
     D sql2ssml        pr
     d  row                           5u 0
     d  col                           5u 0
     d  p1                           80
     d hexa            pr         30000    varying
     d  txt                       15000    varying const
    ? * prototype des procédures internes
     D Proc            Pr
    ? * Paramètres du programme
     D sql2xlsr        PR
     d   ifs                        250
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   debugMod                     1
     d   NullValue                   30
     D sql2xlsr        PI
     d   ifs                        250
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   debugMod                     1
     d   NullValue                   30

     D    wVAR         ds            80    qualified based(pwVar)
     D    wTYPE                       5u 0 OVERLAY(  wVAR:1)
     D    wLEN                        5u 0 OVERLAY(  wVAR:3)
     D    wRES                       12A   OVERLAY(  wVAR:5)
     D    wDATA                        *   OVERLAY(  wVAR:17)
     D    wIND                         *   OVERLAY(  wVAR:33)
     D    wNAMELEN                    5u 0 OVERLAY(  wVAR:49)
     D    wNAME                      30A   OVERLAY(  wVAR:51)

     c/EXEC SQL
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec

      /free
       //?*=----------------------------------------------------------------------------------=*
       //? procédure principale
       //?*=----------------------------------------------------------------------------------=*
       //?creer le fichier, preparer l'entete
       x_OpenXlXml();
       Created(Znow) ;
       //?flush the "DocumentProperties" tag to the xml file
       x_DocumentProperties( );
       //?flush the tag to the xml file
       x_ExcelWorkbook( );
       //?loading a Worksheet
       WName('sql')  ;
       x_OpenWorksheet() ;
       //?prepare styles
       //?style for header lines
       Alignment(Vertical( Bottom ) : Horizontal( Center )) ;

       Borders(
          Border(Position( Bottom )
          :LineStyle( Continuous )
          :Color(black)
          :Weight(1)
          )
          :Border(Position( Top )
          :LineStyle( Continuous )
          :Color(darkSeaGreen)
          :Weight(3)
          )
          ) ;
       Font( color(darkred) :bold():italic() );
       Interior(Color(azuregrey) :Pattern( Solid ) ) ;
       titre=x_style();
       //?style for odd  lines
       Font( color(black )  );
       Interior(Color(azuregrey) :Pattern( Solid ) ) ;
       savestyle=style;
       Borders(
          Border(Position( Left )
          :LineStyle( Continuous )
          :Color(Grey )
          :Weight(1) )
          : Border(Position(Right)
          :LineStyle( Continuous )
          :Color(Grey)
          :Weight(1) )
          ) ;
       savestyle=style;
       oddline =x_style();

       style=savestyle;
       NumberFormat(ShortDate);
       oddDate =x_style();
       style=savestyle;
       NumberFormat(ShortTime);
       oddTime =x_style();
       style=savestyle;
       NumberFormat(DateTimeIso);
       oddDTS =x_style();
       style=savestyle;
       NumberFormat(GNumber);
       oddNumber =x_style();
       style=savestyle;
       NumberFormat(zerodec);
       oddInt =x_style();

       //?style for even lines
       Font( color(black )  );
       savestyle = style;
       evenline =x_style();

       style=savestyle;
       NumberFormat(ShortDate);
       evenDate =x_style();
       style=savestyle;
       NumberFormat(ShortTime);
       evenTime =x_style();
       style=savestyle;
       NumberFormat(DateTimeIso);
       evenDTS =x_style();
       style=savestyle;
       NumberFormat(GNumber);
       evenNumber =x_style();
       style=savestyle;
       NumberFormat(zerodec);
       evenInt =x_style();

       x_openTable( );

       //?un petit coup de sql
       proc();

       //? set WorkSheetOptions properties
       Selected() ;
       //?here define a 4 freezed panes sheet
       SplitHorizontal(freezepaneat);
       TopRowBottomPane(freezepaneat);
       ActivePane(BottomLeft );
       pane(Pnumber(TopLeft )) ;
       pane(Pnumber(Bottomleft )) ;
       x_WorksheetOptions();
       x_autofitcolumn();
       //?clore la feuille
       x_CloseXlXml();
B01    if DiagEmis;
          die('Fin anormale. Des diagnostics ont été émis');
E01    endif;
       *inlr = *on;
      /end-free

      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
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
       message(*blank:mySFW);
       //?c_text(row  : 1  : 'sqlname');
       //?c_text(row+1: 1  : 'sqltype');
       //?c_text(row+2: 1  : 'rpgtype');
       //?c_text(row+3: 1  : 'sqllen ');
       //?c_text(row+4: 1  : 'sqlnamelen');

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
B01    if        debugMod  <> '0'    ;
          ReallocSELDA( 818) ;
      /end-free
    ?c* names    system names     labels      any     both     all
     c*selda description
     c* C:\IseriesInformationCenterV5R2\info\sqlp\rbafymst271.htm
     C/EXEC SQL
     C+ describe k1prepa into : selda using all
     C/END-EXEC
      /free
X01    else ;
          ReallocSELDA( 256) ;
      /end-free
    ?c* names    system names     labels      any     both     all
     C/EXEC SQL
     C+ describe k1prepa into : selda using any
     C/END-EXEC
E01  c                   endif
      /free
B01    if sqlcod<>0;
          escsqler (sqlcod);
E01    endif;
       nbcol = sqld;
       //?limiter l'extraction à 256 colonnes
B01    if nbcol> 256;
          die('more than 256 columns, Excel limit exceeded');
E01    endif;
       //?*decortiquer les noms et types de colonnes
B01    for col = 1 to nbcol;
          ifor = col;
          rowindex(row);
          pwvar = %addr(sqlvar(ifor     )); // debugg
          x_string(col : lcase(sqlname(ifor)):titre);
          //?build the style for each column depending on even/odd line and sqltype
          //?of each column, store result in cellstyle.row(even/odd).col(ifor)
B02       select;
X02          when sqltype(iFor) = 384 or sqltype(iFor) = 385;// date
                cellstyle.row(1).col(ifor)=odddate ;
                cellstyle.row(2).col(ifor)=evendate ;
X02          when sqltype(iFor) = 388 or sqltype(iFor) = 389;// time
                cellstyle.row(1).col(ifor)=oddTime ;
                cellstyle.row(2).col(ifor)=evenTime ;
X02          when sqltype(iFor) = 392 or sqltype(iFor) = 393;// dts
                cellstyle.row(1).col(ifor)=oddDTS ;
                cellstyle.row(2).col(ifor)=evenDTS ;
X02          when sqltype(iFor) = 480 or sqltype(iFor) = 481;// real
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 484 or sqltype(iFor) = 485;// decimal
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 488 or sqltype(iFor) = 489;// numeric
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 492 or sqltype(iFor) = 493;// int 8
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          when sqltype(iFor) = 496 or sqltype(iFor) = 497;// int 4
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          when sqltype(iFor) = 500 or sqltype(iFor) = 501;// int 2
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          other;
                cellstyle.row(1).col(ifor)=oddLine ;
                cellstyle.row(2).col(ifor)=evenLine ;
E02       endsl;
          // patch selda : graphic columns are in characters, not in bytes
       //  if 464 <= sqltype(ifor) and sqltype(ifor) <= 469;
       //     sqllen(ifor) *=2;
       //  endif;
B02       if debugMod  <> '0';
             rowindex(row+1);
             x_number(col : sqltype(ifor));
             rowindex(row+2);
             x_string( col : buftyp(sqltype(ifor)));
             rowindex(row+3);
B03          if 484 <= sqltype(ifor) and sqltype(ifor) <= 489;
                //?c_style(row+3:ifor : 2);
                lenB2 = sqllen(iFOR);
                num42 = lenG + lenD / 100;
                x_number( col : num42 );
X03          else;
                x_number( col : sqllen (ifor));
E03          endif;
             rowindex(row+4);
             //?c_style(row+4:col :0);
             x_number( col : sqlnamelen(ifor));
B03          if sqldoubled >= '2';
                ifor = nbcol+col ;
          pwvar = %addr(sqlvar(ifor     )); // debugg
                rowindex(row+5);
                x_string( col : lcase(sqlname(ifor)));
                rowindex(row+6);
                x_number( col : sqlnamelen(ifor));
E03          endif;
B03          if sqldoubled >= '3';
                ifor = 2*nbcol+col ;
          pwvar = %addr(sqlvar(ifor     )); // debugg
                rowindex(row+7);
                x_string( col : lcase(sqlname(ifor)));
                rowindex(row+8);
                x_number( col : sqlnamelen(ifor));
E03          endif;
E02       endif;
E01    endfor;
B01    if debugMod  <> '0';
          row+=08;
E01    endif;
       freezepaneat = row;
       //?calculer la taille du buffer nécessaire (avec indicateurs zones nulles)
       InpSiz = *ZEROS;
B01    for IdxSqlvar = 1 to SQLD;
          pwvar = %addr(sqlvar(IdxSqlVar)); // debugg
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
          pwvar = %addr(sqlvar(IdxSqlVar)); // debugg
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
       rowindex(row );
       x_string(  1 :'Liste vide');
       clear xlxml.colsize;
      /end-free
B01  c                   do        *hival
     C/EXEC SQL
     C+  FETCH K1 using descriptor :selda
     C/END-EXEC
      /free
B02       if sqlcod=100;
             leave;
E02       endif;
B02       if sqlcod<>0;
             callp escsqler (sqlcod);
E02       endif;
          col = 1;
B02       for IdxSqlVar =1 to SQLD;
             callp sql2ssml(row:col:sqlvar(idxSqlVar)) ;
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
             RtnLn =10;
X01       WHEN BufTyp(InpTyp) = 'TIME';
             RtnLn = 8;
X01       WHEN BufTyp(InpTyp) = 'TIMESTAMP';
             RtnLn = 26;
X01       WHEN BufTyp(InpTyp) = 'VARCHAR';
             RtnLn = InpLen + 2;
X01       WHEN BufTyp(InpTyp) = 'VARGRAPHIC';
             RtnLn = InpLen*2 + 2;
X01       WHEN BufTyp(InpTyp) = 'GRAPHIC';
             RtnLn = InpLen*2;
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
BPR  P sql2ssml        b
     d sql2ssml        pi
     d  row                           5u 0
     d  col                           5u 0
     d  p1                           80
     d  evenodd        s              5u 0
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
     d  datiso                       10a   overlay(dateds:1)
     d  date8                         8a   overlay(dateds:1)
     d  date7                         7a   overlay(dateds:1)
     d  dateymd                        d   overlay(dateds:1) datfmt(*ymd-)
     d  datedmy                        d   overlay(dateds:1) datfmt(*dmy-)
     d  datemdy                        d   overlay(dateds:1) datfmt(*mdy-)
     d  datejul                        d   overlay(dateds:1) datfmt(*jul-)
     d  adate          s               d
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
     d  atime          s               t
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
     d adts            s               z
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
       evenodd = %rem(row:2);
B01    if evenodd = 0;
          evenodd = 2;
E01    endif;
       rowindex(row);
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
                x_string( col:%trim(NullValue):cellStyle.row(evenodd).col(col));
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
          x_string( col:hexa(uData):cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  date
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqldate;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                //?c_style(row:col:0);
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pDate = sqldata;
B02    // select;
X02    //    when jobdatfmt='*YMD';
       //       adate =%date(date8:*YMD);
       //       x_date(col:adate:cellStyle.row(evenodd).col(col));
X02    //    when jobdatfmt='*DMY';
       //       adate =%date(date8:*DMY);
       //       x_date(col:adate:cellStyle.row(evenodd).col(col));
X02    //    when jobdatfmt='*MDY';
       //       adate =%date(date8:*MDY);
       //       x_date(col:adate:cellStyle.row(evenodd).col(col));
X02    //    when jobdatfmt='*JUL';
       //       adate =%date(date8:*JUL);
       //       x_date(col:adate:cellStyle.row(evenodd).col(col));
X02    //    other;
       //       x_string(col:dateds :cellStyle.row(evenodd).col(col));
E02    // endsl;
                adate =%date(datiso:*iso);
                x_date(col:adate:cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=------------------------------------------------------=*//
       //?TIME
       //?*=------------------------------------------------------=*//
B01    begsr sqltime;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pTime = sqldata;
          dstime = wtime;
          atime = %time(dstime:*ISO);
          x_time( col:aTime :cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  DateTimeStamp
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqltimestamp;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pTimeStamp = sqldata;
          adts = %timestamp(wTimeStamp26:*ISO);
          x_dts( col:adts :cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* VARCHAR
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlvarchar;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pvarchar = sqldata;
          uData = wvarchar;
          x_string(col:uData:cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* CHAR
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlchar;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pData = sqldata;
          uData = %subst(wData:1:sqlLen);
          x_string(col:uData:cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  Float
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlreal;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
B02       if sqllen = 4;
             preal4= sqldata;
             ureal4= wreal4;
             //?c_style(row:col:0);
             x_float (col: ureal4 :cellStyle.row(evenodd).col(col));
E02       endif;
B02       if sqllen = 8;
             preal8= sqldata;
             ureal8= wreal8;
             //?c_style(row:col:0);
             x_float (col:ureal8 :cellStyle.row(evenodd).col(col));
E02       endif;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  packed decimal
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqldec ;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
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
B02       select;
X02          when lenD = 1;
                x_number( col:uDec01 :cellStyle.row(evenodd).col(col));
X02          when lenD = 2;
                x_number(col:uDec02 :cellStyle.row(evenodd).col(col));
X02          when lenD = 3;
                x_number(col:uDec03 :cellStyle.row(evenodd).col(col));
X02          when lenD = 4;
                x_number(col:uDec04 :cellStyle.row(evenodd).col(col));
X02          when lenD = 5;
                x_number(col:uDec05 :cellStyle.row(evenodd).col(col));
X02          when lenD = 6;
                x_number(col:uDec06 :cellStyle.row(evenodd).col(col));
X02          when lenD = 7;
                x_number(col:uDec07 :cellStyle.row(evenodd).col(col));
X02          when lenD = 8;
                x_number(col:uDec08 :cellStyle.row(evenodd).col(col));
X02          when lenD = 9;
                x_number(col:uDec09 :cellStyle.row(evenodd).col(col));
X02          when lenD = 10;
                x_number(col: uDec10 :cellStyle.row(evenodd).col(col));
X02          when lenD = 11;
                x_number(col: uDec11 :cellStyle.row(evenodd).col(col));
X02          when lenD = 12;
                x_number(col: uDec12 :cellStyle.row(evenodd).col(col));
X02          when lenD = 13;
                x_number(col: uDec13 :cellStyle.row(evenodd).col(col));
X02          when lenD = 14;
                x_number(col: uDec14 :cellStyle.row(evenodd).col(col));
X02          when lenD = 15;
                x_number(col: uDec15 :cellStyle.row(evenodd).col(col));
X02          when lenD = 16;
                x_number(col: uDec16 :cellStyle.row(evenodd).col(col));
X02          when lenD = 17;
                x_number(col: uDec17 :cellStyle.row(evenodd).col(col));
X02          when lenD = 18;
                x_number(col: uDec18 :cellStyle.row(evenodd).col(col));
X02          when lenD = 19;
                x_number(col: uDec19 :cellStyle.row(evenodd).col(col));
X02          when lenD = 20;
                x_number(col: uDec20 :cellStyle.row(evenodd).col(col));
X02          when lenD = 21;
                x_number(col: uDec21 :cellStyle.row(evenodd).col(col));
X02          when lenD = 22;
                x_number(col: uDec22 :cellStyle.row(evenodd).col(col));
X02          when lenD = 23;
                x_number(col: uDec23 :cellStyle.row(evenodd).col(col));
X02          when lenD = 24;
                x_number(col: uDec24 :cellStyle.row(evenodd).col(col));
X02          when lenD = 25;
                x_number(col: uDec25 :cellStyle.row(evenodd).col(col));
X02          when lenD = 26;
                x_number(col: uDec26 :cellStyle.row(evenodd).col(col));
X02          when lenD = 27;
                x_number(col: uDec27 :cellStyle.row(evenodd).col(col));
X02          when lenD = 28;
                x_number(col: uDec28 :cellStyle.row(evenodd).col(col));
X02          when lenD = 29;
                x_number(col: uDec29 :cellStyle.row(evenodd).col(col));
X02          when lenD = 30;
                x_number(col: uDec30 :cellStyle.row(evenodd).col(col));
X02          when lenD = 31;
                x_number(col: uDec31 :cellStyle.row(evenodd).col(col));
X02          other ;
                x_number(col:uDec00 :cellStyle.row(evenodd).col(col));
E02       endsl;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* numeric etendu
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlnumeric;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pNum = sqldata;
          lenB2 = sqllen;
          uNum=*zero ;
          %subst(uNum: 31 - lenG + 1: lenG) = %subst(wNum :1:lenG);
B02       select;
X02          when lenD = 1;
                x_number(col:uNum01 :cellStyle.row(evenodd).col(col));
X02          when lenD = 2;
                x_number(col:uNum02 :cellStyle.row(evenodd).col(col));
X02          when lenD = 3;
                x_number(col:uNum03 :cellStyle.row(evenodd).col(col));
X02          when lenD = 4;
                x_number(col:uNum04 :cellStyle.row(evenodd).col(col));
X02          when lenD = 5;
                x_number(col:uNum05 :cellStyle.row(evenodd).col(col));
X02          when lenD = 6;
                x_number(col:uNum06 :cellStyle.row(evenodd).col(col));
X02          when lenD = 7;
                x_number(col:uNum07 :cellStyle.row(evenodd).col(col));
X02          when lenD = 8;
                x_number(col:uNum08 :cellStyle.row(evenodd).col(col));
X02          when lenD = 9;
                x_number(col:uNum09 :cellStyle.row(evenodd).col(col));
X02          when lenD = 10;
                x_number(col: uNum10 :cellStyle.row(evenodd).col(col));
X02          when lenD = 11;
                x_number(col: uNum11 :cellStyle.row(evenodd).col(col));
X02          when lenD = 12;
                x_number(col: uNum12 :cellStyle.row(evenodd).col(col));
X02          when lenD = 13;
                x_number(col: uNum13 :cellStyle.row(evenodd).col(col));
X02          when lenD = 14;
                x_number(col: uNum14 :cellStyle.row(evenodd).col(col));
X02          when lenD = 15;
                x_number(col: uNum15 :cellStyle.row(evenodd).col(col));
X02          when lenD = 16;
                x_number(col: uNum16 :cellStyle.row(evenodd).col(col));
X02          when lenD = 17;
                x_number(col: uNum17 :cellStyle.row(evenodd).col(col));
X02          when lenD = 18;
                x_number(col: uNum18 :cellStyle.row(evenodd).col(col));
X02          when lenD = 19;
                x_number(col: uNum19 :cellStyle.row(evenodd).col(col));
X02          when lenD = 20;
                x_number(col: uNum20 :cellStyle.row(evenodd).col(col));
X02          when lenD = 21;
                x_number(col: uNum21 :cellStyle.row(evenodd).col(col));
X02          when lenD = 22;
                x_number(col: uNum22 :cellStyle.row(evenodd).col(col));
X02          when lenD = 23;
                x_number(col: uNum23 :cellStyle.row(evenodd).col(col));
X02          when lenD = 24;
                x_number(col: uNum24 :cellStyle.row(evenodd).col(col));
X02          when lenD = 25;
                x_number(col: uNum25 :cellStyle.row(evenodd).col(col));
X02          when lenD = 26;
                x_number(col: uNum26 :cellStyle.row(evenodd).col(col));
X02          when lenD = 27;
                x_number(col: uNum27 :cellStyle.row(evenodd).col(col));
X02          when lenD = 28;
                x_number(col: uNum28 :cellStyle.row(evenodd).col(col));
X02          when lenD = 29;
                x_number(col: uNum29 :cellStyle.row(evenodd).col(col));
X02          when lenD = 30;
                x_number(col: uNum30 :cellStyle.row(evenodd).col(col));
X02          when lenD = 31;
                x_number(col: uNum31 :cellStyle.row(evenodd).col(col));
X02          other ;
                x_number(col:uNum00 :cellStyle.row(evenodd).col(col));
E02       endsl;
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?*  binaire 8 octets
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint8;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pBin8 = sqldata;
          uBin8 = wBin8;
          x_number(col:uBin8 :cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* binaire 4
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint4;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pBin4 = sqldata;
          uBin4 = wBin4;
          x_number(col:uBin4 :cellStyle.row(evenodd).col(col));
E01    endsr;
       //?*=----------------------------------------------------------------------------------=*
       //?* binaire 2
       //?*=----------------------------------------------------------------------------------=*
B01    begsr sqlint2;
B02       if odd(sqltype);//?nullable
             pNullInd = sqlind;
B03          if nullind<> 0;
                x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
                leavesr;
E03          endif;
E02       endif;
          pBin2 = sqldata;
          uBin2 = wBin2;
          x_number(col:uBin2 :cellStyle.row(evenodd).col(col));
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
          x_string(col:uData:cellStyle.row(evenodd).col(col));
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
