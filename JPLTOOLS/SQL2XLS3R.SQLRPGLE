    ? * test :
    ? * SELECT DATEJ, LIBJOU, LIBMOI, JOUSEM, JULANN, JULSIE, SEMAIN,
    ? * SEMIND, JOUVRE, nullif( 1 , 1 ) nullcol, current date today ,
    ? * '0001-01-01' mindate,
    ? * cast('var UCS2         ccsid 13488' as varGRAPHIC(100  ) CCSID 13488 )
    ? * cast('var utf8         ccsid 1208 ' as varchar   (100  ) CCSID  1208 )
    ? * cast('var utf16        ccsid 1200 ' as varGRAPHIC(100  ) CCSID  1200 )
    ? * cast(
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

      /define INFDS
      *define VBEL
      *define ECOPRO
      /define SQL
      /define SQLDESCRIBE
    ? /define LOWERCASE
      *define QUOTE
      /define XLXML3

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
     d  hiconv                             likeds(iconv_t)
     d bufferlen                     10i 0
     d hexa            pr         30000    varying
     d  txt                       15000    varying const
    ? * prototype des procédures internes
     D Proc            Pr
    ? * Paramètres du programme
     D sql2xls3r       PR
     d   ifs                        250
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   DebugSQL                     1
     d   NullValue                   30
     D sql2xls3r       PI
     d   ifs                        250
     d   sqlorder                  5000
     d   jobdatFmt                    4
     d   jobdatsep                    1
     d   DebugSQL                     1
     d   NullValue                   30


     D   wVAR          DS            80    based(pwVAR) qualified
     D     TYPE                1      2B 0
     D     LEN                 3      4B 0
     D     precision           3      3i 0
     D     scale               4      4i 0
     D     RES                 5     16A
     D     DATA               17     32*
     D     ccsid1             17     20b 0
     D     IND                33     48*
     D     NAMELEN            49     50B 0
     D     NAME               51     80A
     D     ccsid2             51     54b 0
    ?D*  End of SQLDA
    ?D*  Extended SQLDA
     D   wVAR2         DS            80    based(pwVAR) qualified
     D     LONGL               1      4B 0
     D     RSVDL               5     32A
     D     DATAL              33     48*
     D     TNAMELN            49     50B 0
     D     TNAME              51     80A
















    ? *==================================================================
    ? * Type definitions for Code Conversion APIs
    ? *==================================================================
     D* iconv_t        ds                  based(pDummy)
     d*                                    qualified
     D*  rc                          10i 0
     D*  cd                          10i 0 dim(12)
    ? *==================================================================
    ? * Prototype for iconv_open()--Code Conversion Allocation API
    ? *==================================================================
     D*iconv_open      pr                  extproc('QtqIconvOpen') like(iconv_t)
     D* pToCode                        *   value
     D* pFromCode                      *   value
    ? *==================================================================
    ? * Prototype for iconv()--Code Conversion API
    ? *==================================================================
     D*iconv           pr            10i 0 extproc('iconv')
     D*  cd                                value  like(iconv_t)
     D*  pInBuf                        *   const
     D*  inBytesLft                  10i 0
     D*  pOutBuf                       *   const
     D*  outBytesLft                 10i 0
    ? *==================================================================
    ? * Prototype for iconv_close()--Code Conversion Deallocation API
    ? *==================================================================
     D*iconv_close     pr            10i 0 extproc('iconv_close')
     D*  cd                                value  like(iconv_t)
    ? *==================================================================
    ? * VARIABLES USED BY SUBPROCEDURE "iconv*"
     D  isInitIconv    s               n   inz(*off)
     D  toCode         ds                  qualified
     D         ccsid                 10i 0 inz(500)
     D         convA                 10i 0                                      ignored
     D         subA                  10i 0                                      ignored
     D         shftA                 10i 0                                      ignored
     D         lnOpt                 10i 0                                      ignored
     D         erOpt                 10i 0                                      ignored
     D         res                   12a   inz(*ALLx'00')
     D  fromCode       ds                  qualified
     D          ccsid                10i 0 inz(0)
     D          convA                10i 0 inz(0)                               Ibm Defined
     D          subA                 10i 0 inz(0)                               no rtn nb substitutn
     D          shftA                10i 0 inz(1)                               restore shift state
     D          lnOpt                10i 0 inz(0)                               P1 len is in P2
     D          erOpt                10i 0 inz(0)                               cvt DBCS to CDRA
     D          res                  12a   inz(*ALLx'00')
     D  hIconv         ds                  likeds(iconv_t) inz
    ?d*default converter (jobccsid to 1208)
     D* hIconv0        ds                  likeds(iconv_t) inz
     d  SqlIconv       ds                  qualified inz
     d                                     dim(256)
     d  hiconv                             likeds(iconv_t)
     d  bufferLen                    10i 0



     d rc              s             10i 0
     d uDec            ds            32
     d uDec00                        63p00 overlay(uDec:1)
     d uDec01                        63p01 overlay(uDec:1)
     d uDec02                        63p02 overlay(uDec:1)
     d uDec03                        63p03 overlay(uDec:1)
     d uDec04                        63p04 overlay(uDec:1)
     d uDec05                        63p05 overlay(uDec:1)
     d uDec06                        63p06 overlay(uDec:1)
     d uDec07                        63p07 overlay(uDec:1)
     d uDec08                        63p08 overlay(uDec:1)
     d uDec09                        63p09 overlay(uDec:1)
     d uDec10                        63p10 overlay(uDec:1)
     d uDec11                        63p11 overlay(uDec:1)
     d uDec12                        63p12 overlay(uDec:1)
     d uDec13                        63p13 overlay(uDec:1)
     d uDec14                        63p14 overlay(uDec:1)
     d uDec15                        63p15 overlay(uDec:1)
     d uDec16                        63p16 overlay(uDec:1)
     d uDec17                        63p17 overlay(uDec:1)
     d uDec18                        63p18 overlay(uDec:1)
     d uDec19                        63p19 overlay(uDec:1)
     d uDec20                        63p20 overlay(uDec:1)
     d uDec21                        63p21 overlay(uDec:1)
     d uDec22                        63p22 overlay(uDec:1)
     d uDec23                        63p23 overlay(uDec:1)
     d uDec24                        63p24 overlay(uDec:1)
     d uDec25                        63p25 overlay(uDec:1)
     d uDec26                        63p26 overlay(uDec:1)
     d uDec27                        63p27 overlay(uDec:1)
     d uDec28                        63p28 overlay(uDec:1)
     d uDec29                        63p29 overlay(uDec:1)
     d uDec30                        63p30 overlay(uDec:1)
     d uDec31                        63p31 overlay(uDec:1)
     d uDec32                        63p32 overlay(uDec:1)
     d uDec33                        63p33 overlay(uDec:1)
     d uDec34                        63p34 overlay(uDec:1)
     d uDec35                        63p35 overlay(uDec:1)
     d uDec36                        63p36 overlay(uDec:1)
     d uDec37                        63p37 overlay(uDec:1)
     d uDec38                        63p38 overlay(uDec:1)
     d uDec39                        63p39 overlay(uDec:1)
     d uDec40                        63p40 overlay(uDec:1)
     d uDec41                        63p41 overlay(uDec:1)
     d uDec42                        63p42 overlay(uDec:1)
     d uDec43                        63p43 overlay(uDec:1)
     d uDec44                        63p44 overlay(uDec:1)
     d uDec45                        63p45 overlay(uDec:1)
     d uDec46                        63p46 overlay(uDec:1)
     d uDec47                        63p47 overlay(uDec:1)
     d uDec48                        63p48 overlay(uDec:1)
     d uDec49                        63p49 overlay(uDec:1)
     d uDec50                        63p50 overlay(uDec:1)
     d uDec51                        63p51 overlay(uDec:1)
     d uDec52                        63p52 overlay(uDec:1)
     d uDec53                        63p53 overlay(uDec:1)
     d uDec54                        63p54 overlay(uDec:1)
     d uDec55                        63p55 overlay(uDec:1)
     d uDec56                        63p56 overlay(uDec:1)
     d uDec57                        63p57 overlay(uDec:1)
     d uDec58                        63p58 overlay(uDec:1)
     d uDec59                        63p59 overlay(uDec:1)
     d uDec60                        63p60 overlay(uDec:1)
     d uDec61                        63p61 overlay(uDec:1)
     d uDec62                        63p62 overlay(uDec:1)
     d uDec63                        63p63 overlay(uDec:1)
    ? * the standard receiver
    ? *                                G Graphic (valid for graphic data)
    ? *                                C UCS-2 (valid for UCS-2 data)
    ? *                                A alpha
    ? *                                O open dbcs
    ? *                                J Only dbcs
    ? *                                E Either DBCS or SBCS
    ? *
     d wrk_char        s          65535                based(pwrk_cli)
     d wrk_NUMERIC     s             63s 0             based(pwrk_cli)
     d wrk_DECIMAL     s             63p 0             based(pwrk_cli)
     d wrk_BIGINT      s             20i 0             based(pwrk_cli)
     d wrk_INTEGER     s             10i 0             based(pwrk_cli)
     d wrk_SMALLINT    s              5i 0             based(pwrk_cli)
     d wrk_FLOAT       s              4f               based(pwrk_cli)
    ?d*wrk_REAL        s              4f               based(pwrk_cli)
     d wrk_DOUBLE      s              8f               based(pwrk_cli)
     d wrk_DATETIME    s               d               based(pwrk_cli)
     d wrk_DATEISO     s             10                based(pwrk_cli)
     d wrk_TIMEISO     s              8                based(pwrk_cli)
     d wrk_DTS_ISO     s             26                based(pwrk_cli)
     d wrk_VARCHAR     s          65535    varying     based(pwrk_cli)
    ?d*wrk_BLOB        s                               based(pwrk_cli)
    ?d*wrk_CLOB        s                               based(pwrk_cli)
    ?d*wrk_DBCLOB      s                               based(pwrk_cli)
    ?d*wrk_DATALINK    s                               based(pwrk_cli)
     d wrk_WCHAR       s          16383c   ccsid(1200) based(pwrk_cli)
     d wrk_WVARCHAR    s          16383c   ccsid(1200) based(pwrk_cli) varying
    ?d*wrk_GRAPHIC     s          16383g               based(pwrk_cli)
    ?d*wrk_VARGRAPHIC  s          16383g   varying     based(pwrk_cli)
    ?d*wrk_BINARY      s          65535                based(pwrk_cli)
    ?d*wrk_VARBINARY   s          65535    varying     based(pwrk_cli)
    ?d*wrk_DATE        s               d               based(pwrk_cli)
    ?d*wrk_TIME        s               t               based(pwrk_cli)
    ?d*wrk_TIMESTAMP   s               z               based(pwrk_cli)


     d rcv_char        s                   like(wrk_char      ) based(prcv_cli)
    ?d*rcv_NUMERIC     s                   like(wrk_NUMERIC   ) based(prcv_cli)
    ?d*rcv_DECIMAL     s                   like(wrk_DECIMAL   ) based(prcv_cli)
    ?d*rcv_BIGINT      s                   like(wrk_bigint)     based(prcv_cli)
    ?d*rcv_INTEGER     s                   like(wrk_INTEGER   ) based(prcv_cli)
    ?d*rcv_SMALLINT    s                   like(wrk_SMALLINT  ) based(prcv_cli)
    ?d*rcv_FLOAT       s                   like(wrk_FLOAT     ) based(prcv_cli)
    ?d*rcv_REAL        s                   like(wrk_REAL      ) based(prcv_cli)
    ?d*rcv_DOUBLE      s                   like(wrk_DOUBLE    ) based(prcv_cli)
    ?d*rcv_DATETIME    s                   like(wrk_DATETIME  ) based(prcv_cli)
    ?d*rcv_DATEISO     s                   like(wrk_DATEISO   ) based(prcv_cli)
    ?d*rcv_TIMEISO     s                   like(wrk_TIMEISO   ) based(prcv_cli)
    ?d*rcv_DTS_ISO     s                   like(wrk_DTS_ISO   ) based(prcv_cli)
    ?d*rcv_VARCHAR     s                   like(wrk_VARCHAR   ) based(prcv_cli)
    ?d*rcv_BLOB        s                   like(wrk_BLOB      ) based(prcv_cli)
    ?d*rcv_CLOB        s                   like(wrk_CLOB      ) based(prcv_cli)
    ?d*rcv_DBCLOB      s                   like(wrk_DBCLOB    ) based(prcv_cli)
    ?d*rcv_DATALINK    s                   like(wrk_DATALINK  ) based(prcv_cli)
    ?d*rcv_WCHAR       s                   like(wrk_WCHAR     ) based(prcv_cli)
    ?d*rcv_WVARCHAR    s                   like(wrk_WVARCHAR  ) based(prcv_cli)
    ?d*rcv_GRAPHIC     s                   like(wrk_GRAPHIC   ) based(prcv_cli)
    ?d*rcv_VARGRAPHIC  s                   like(wrk_VARGRAPHIC) based(prcv_cli)
    ?d*rcv_BINARY      s                   like(wrk_BINARY    ) based(prcv_cli)
    ?d*rcv_VARBINARY   s                   like(wrk_VARBINARY ) based(prcv_cli)
    ?d*rcv_DATE        s                   like(wrk_DATE      ) based(prcv_cli)
    ?d*rcv_TIME        s                   like(wrk_TIME      ) based(prcv_cli)
    ?d*rcv_TIMESTAMP   s                   like(wrk_TIMESTAMP ) based(prcv_cli)








     c/EXEC SQL
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec

      /free
       pwrk_cli=%ALLOC(65535 );

       //?default converter from jobccsid to 1208, for x_write
       //  fromcode.ccsid = 0 ;
       //  tocode.ccsid = 1208;
       //  hIconv0= iconv_open(%addr(toCode) :
       //     %addr(fromCode) ) ;
       //  if hiconv.rc <> 0;
       //     if errno() <> 0;
       //        message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //     endif;
       //  endif;
       //?*=----------------------------------------------------------------------------------=*
       //? procédure principale
       //?*=----------------------------------------------------------------------------------=*
       UseErrno();
      /end-free
     c/exec sql
     c+   CREATE TABLE qtemp/XMLDBUt (
     c+     LEVEL1 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL2 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL3 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL4 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL5 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL6 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL7 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL8 INTEGER NOT NULL DEFAULT 0 ,
     c+     LEVEL9 INTEGER NOT NULL DEFAULT 0 ,
     c+     DATA VARbinary (1000) NOT NULL DEFAULT)
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod =-601
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c/exec sql
     c+   CREATE INDEX QTEMP/xmldbuI0 ON QTEMP/XMLDBUT (
     c+     LEVEL1 ASC
     c+   , LEVEL2 ASC
     c+   , LEVEL3 ASC
     c+   , LEVEL4 ASC
     c+   , LEVEL5 ASC
     c+   , LEVEL6 ASC
     c+   , LEVEL7 ASC
     c+   , LEVEL8 ASC
     c+   , LEVEL9 ASC
     c+   )
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod =-601
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c/exec sql
     c+   delete from  QTEMP/xmldbut
     c/end-exec
B01  c                   if        sqlcod = 0 or sqlcod = 100
X01  c                   else
     c                   callp     EscSqlEr(sqlcod:sqlerm)
E01  c                   endif
     c                   open      xmldbuI0
      /free
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
       Font( color(black ) );
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
       Font( color(black ) );
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
       //?copy temporary xml data to the ifs file
       x_Copy2Ifs(ifs );
B01    if DiagEmis;
          die('Fin anormale. Des diagnostics ont été émis');
E01    endif;
       *inlr = *on;
      /end-free

    ? /define PROCEDURE_SECTION
    ? /include jpltools,JP4inc
    ? *=----------------------------------------------------------------------------------=*
    ? *
    ? *=----------------------------------------------------------------------------------=*
BPR  P Proc            B
     D Proc            PI
     d mySFW           s           6000
     d sqlCount        s              9b 0
     d MyData          s          65535    based(pMyData)
     D InpSiz          s              5U 0
     DIdxSqlVar        S              5U 0                                      Field count index.
     DOffInp           S              5U 0 INZ(*ZEROS)                          Offset to field.
     d num42           s              4  2
     d row             s              5u 0 inz(01)
     d col             s              5u 0
     d NulFnd          s               n
      /free
       mySFW = sqlorder;
       message(*blank:%trim(mySFW));
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
B01    if        DebugSQL  <> '0'    ;
          ReallocSELDA( 818) ;
      /end-free
    ?c* names    system names     labels      any     both     all
    ?c*selda description
    ?c* C:\IseriesInformationCenterV5R2\info\sqlp\rbafymst271.htm
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
       //?*debugger    les noms et types de colonnes
B01    if sqldoubled=' ';
          sqldoubled='1';
E01    endif;
       //?for iFor = 0 to SQLthe7 * (sqld)-1;
       //?pwVar = %addr(selda) + 16 + 80*iFor;
       //?debug
       pwvar = %addr(sqlvar(ifor+1));//?debugg
       //?if iFor < sqld ;
       //?message ('':'SQLDA 1 ' + %char(wvar.TYPE)
       //?   +', ' +  %char(wvar.LEN )
       //?//?+ SQLRES
       //?   +', ' + %char(wvar.ccsid1 )
       //?   +', ' + %char(wvar.NAMELEN)
       //?   +', ' + wvar.NAME );
       //?else;
       //?//?hexa(sqlvar) +
       //?message ('':'SQLDA'+%char(iFor)+'= '+
       //?//?%char(sqllongl)+', ' +
       //?   wvar2.rsvdl + ', '+
       //?   %char(wvar2.TNAMELN)
       //?   +', ' + wvar2.TNAME );
       //?endif;
       //?endfor;
       //?*decortiquer les noms et types de colonnes
B01    for col = 1 to nbcol;
          ifor = col;
          rowindex(row);

          //?build title header line
          x_string(col : lcase(sqlname(ifor)):titre);
          //?build the style for each column depending on even/odd line and sqltype
          //?of each column, store result in cellstyle.row(even/odd).col(ifor)
B02       select;
X02          when sqltype(iFor) = 384 or sqltype(iFor) = 385;//?date
                cellstyle.row(1).col(ifor)=odddate ;
                cellstyle.row(2).col(ifor)=evendate ;
X02          when sqltype(iFor) = 388 or sqltype(iFor) = 389;//?time
                cellstyle.row(1).col(ifor)=oddTime ;
                cellstyle.row(2).col(ifor)=evenTime ;
X02          when sqltype(iFor) = 392 or sqltype(iFor) = 393;//?dts
                cellstyle.row(1).col(ifor)=oddDTS ;
                cellstyle.row(2).col(ifor)=evenDTS ;
X02          when sqltype(iFor) = 480 or sqltype(iFor) = 481;//?real
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 484 or sqltype(iFor) = 485;//?decimal
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 488 or sqltype(iFor) = 489;//?numeric
                cellstyle.row(1).col(ifor)=oddNumber;
                cellstyle.row(2).col(ifor)=evenNumber;
X02          when sqltype(iFor) = 492 or sqltype(iFor) = 493;//?int 8
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          when sqltype(iFor) = 496 or sqltype(iFor) = 497;//?int 4
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          when sqltype(iFor) = 500 or sqltype(iFor) = 501;//?int 2
                cellstyle.row(1).col(ifor) =oddInt ;
                cellstyle.row(2).col(ifor) =evenInt ;
X02          other;
                cellstyle.row(1).col(ifor)=oddLine ;
                cellstyle.row(2).col(ifor)=evenLine ;
E02       endsl;
          //?patch selda : graphic columns are in characters, not in bytes
          //? if 464 <= sqltype(ifor) and sqltype(ifor) <= 469;
          //?    sqllen(ifor) *=2;
          //? endif;
B02       if DebugSQL  <> '0';
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
                pwvar = %addr(sqlvar(ifor ));//?debugg
                rowindex(row+5);
                x_string( col : lcase(sqlname(ifor)));
                rowindex(row+6);
                x_number( col : sqlnamelen(ifor));
E03          endif;
B03          if sqldoubled >= '3';
                ifor = 2*nbcol+col ;
                pwvar = %addr(sqlvar(ifor ));//?debugg
                rowindex(row+7);
                x_string( col : lcase(sqlname(ifor)));
                rowindex(row+8);
                x_number( col : sqlnamelen(ifor));
E03          endif;
E02       endif;
E01    endfor;
B01    if DebugSQL  <> '0';
          row+=08;
E01    endif;
       freezepaneat = row;
       //? //?calculer la taille du buffer nécessaire (avec indicateurs zones nulles)
       //? InpSiz = *ZEROS;
       //? for IdxSqlvar = 1 to SQLD;
       //?    pwvar = %addr(sqlvar(IdxSqlVar));//?debugg
       //?    IF Odd(SQLTYPE(IdxSqlVar));//?Only if even.
       //?       NulFnd = *ON;
       //?       eval inpSiz +=2;
       //?    ENDIF;
       //?    InpSiz = InpSiz +
       //?       SQLBufLen(SQLType(IdxSqlVar):SQLLEN(IdxSqlVar));
       //? endfor;
       //?allouer le buffer
       //?taille fixée par DB2 : toujours <= 32768 ; taille maxi un record
       //?inpsiz = 1000 ;
B01    IF pMyData = *NULL;
          pmyData=%ALLOC(65535);
X01    else;
          pMyData=%realloc(pMyData:65535);
E01    ENDif;
       //?Set pointers in SQLDA to input area.
B01    for idxSqlVar = 1 to SQLD;
          pwvar = %addr(sqlvar(IdxSqlVar));//?debugg
B02       IF Odd(SQLTYPE(IdxSqlVar));//?Allow for null.
             SQLIND(IdxSqlVar) = pMyData + OffInp;
             offinp +=2;
E02       ENDIF;

          fromcode.ccsid = sqlccsid1(IdxSqlVar) ;
          tocode.ccsid = 1208;

          hIconv = iconv_open(%addr(toCode) :
             %addr(fromCode) ) ;
B02       if hiconv.rc <> 0;
B03          if errno() <> 0;
                message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
E03          endif;
E02       endif;

          sqliconv(IdxSqlVar).hiconv = hiconv;

          SQLccsid2(IdxSqlVar)= sqlccsid1(IdxSqlVar);
          SQLnamelen(IdxSqlVar)= 8;
          SQLDATA(IdxSqlVar) = pMyData + OffInp;
          sqliconv(IdxSqlVar).bufferlen=
             SQLBufLen( SQLType(IdxSqlVar):SQLLEN(IdxSqlVar));
          OffInp = OffInp + sqliconv(IdxSqlVar).bufferlen ;
E01    ENDfor;
       //?default converter from jobccsid to 1208, for x_write
       //?fromcode.ccsid = 0                    ;
       //?tocode.ccsid = 1208;
       //?
       //?hIconv = iconv_open(%addr(toCode) :
       //?   %addr(fromCode) ) ;
       //?if hiconv.rc <> 0;
       //?   if errno() <> 0;
       //?      message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?   endif;
       //?endif;
















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
     C+ FETCH NEXT FROM K1 USING DESCRIPTOR :selda
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
             callp sql2ssml(row:col:sqlvar(idxSqlVar)
                :sqliconv(IdxSqlVar).hiconv
                :sqliconv(IdxSqlVar).bufferlen );
             col+=1;
E02       endfor;
          row+=1;
      /end-free
E01  c                   enddo
     C/EXEC SQL
     C+ CLOSE K1
     C/END-EXEC
      /free
       //?close iconv handlers
       // iconv_close(hiconv);
B01    for idxSqlVar = 1 to SQLD;

          iconv_close(
             sqliconv(IdxSqlVar).hiconv ) ;
E01    endfor;









      /end-free
    ?C*=--------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=--------------------------------------------------------------
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
X01       WHEN inptyp=484 or inptyp=485 ;//?Packed Decimal.
             lenB2 = InpLen;
             RtnLn = %INT( lenG / 2 ) + 1 ;
X01       WHEN inptyp=488 or inptyp=489 OR//?Zoned Decimal.
                inptyp=504 or inptyp=505 ;//?Leading sign.
             rtnln = lenG ;
X01       WHEN inptyp=384 or inptyp=385 ;//?date
             RtnLn =10;
X01       WHEN inptyp=388 or inptyp=389 ;//?time
             RtnLn = 8;
X01       WHEN inptyp=392 or inptyp=393 ;//?timestamp
             RtnLn = 26;
X01       WHEN inptyp=448 or inptyp=449 ;//?varchar
             RtnLn = InpLen + 2;
X01       WHEN inptyp=464 or inptyp=465 ;//?vargraphic
             RtnLn = InpLen*2 + 2;
X01       WHEN inptyp=468 or inptyp=469 ;//?vargraphic
             RtnLn = InpLen*2;
X01       OTHER ;
             RtnLn = InpLen;
E01    ENDSL;
       RETURN RtnLn;
      /end-free
    ?C*=--------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=--------------------------------------------------------------
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
    ?C*=--------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=--------------------------------------------------------------
EPR  P                 E
    ? *=----------------------------------------------------------------------------------=*
    ? *
    ? *=----------------------------------------------------------------------------------=*
BPR  P sql2ssml        b
     d sql2ssml        pi
     d  row                           5u 0
     d  col                           5u 0
     d  p1                           80
     d  hiconv                             likeds(iconv_t)
     d bufferlen                     10i 0
     d  evenodd        s              5u 0
     D SQLVAR          ds            80
     D  SQLTYPE                       5u 0 OVERLAY(SQLVAR:1)
     D  SQLLEN                        5u 0 OVERLAY(SQLVAR:3)
    ?D* SQLRES                       12A   OVERLAY(SQLVAR:5)
     D  SQLDATA                        *   OVERLAY(SQLVAR:17)
     D  SQLIND                         *   OVERLAY(SQLVAR:33)
    ?D* SQLNAMELEN                    5u 0 OVERLAY(SQLVAR:49)
    ?D* SQLNAME                      30A   OVERLAY(SQLVAR:51)

    ?D* SQLTYPE                1      2B 0
    ?D* SQLLEN                 3      4B 0
     D  SQLprecision           3      3i 0
     D  SQLscale               4      4i 0
    ?D* SQLRES                 5     16A
    ?D* SQLDATA               17     32*
    ?D* SQLccsid1             17     20b 0
    ?D* SQLIND                33     48*
    ?D* SQLNAMELEN            49     50B 0
    ?D* SQLNAME               51     80A
    ?d*=---
    ?D* SQLccsid2             51     54b 0
     d  nullind        s              5u 0 based(pNullInd)
     d* dateds         ds                  based(pDate)
    ?d* datiso                       10a   overlay(dateds:1)
    ?d* date8                         8a   overlay(dateds:1)
    ?d* date7                         7a   overlay(dateds:1)
    ?d* dateymd                        d   overlay(dateds:1) datfmt(*ymd-)
    ?d* datedmy                        d   overlay(dateds:1) datfmt(*dmy-)
    ?d* datemdy                        d   overlay(dateds:1) datfmt(*mdy-)
    ?d* datejul                        d   overlay(dateds:1) datfmt(*jul-)
     d  adate          s               d
    ?d* dateserial     s             10i 0
    ?d* dateserial0    s             10i 0
    ?d* wData          s          32000    based(pData)
     d  uData          s          32000    varying
    ?d* wVarChar       s          32000    based(pVarChar) varying
     d  utf8data       s          32000
     d  utf8len        s             10i 0
     d  ebcdlen        s             10i 0
    ?d*wLen            s              5u 0
    ?d*wdays           s             10i 0
    ? * prototypes to date routines
    ?D*CEEFMDA         PR                  ExtProc('CEEFMDA') OpDesc
    ?D*  Country                      2A   Const
    ?D*  FormatString                32A
    ?D*  Error                       12A   Options(*Omit)
    ?D*CEEDAYS         PR                  ExtProc('CEEDAYS') OpDesc
    ?D*  DateString                  32A   Const
    ?D*  FormatString                32A   Const
    ?D*  LilianDate                  10I 0
    ?D*  Error                       12A   Options(*Omit)
    ?D*CEEDATE         PR                  ExtProc('CEEDATE') OpDesc
    ?D*  LilianDate                  10I 0 Const
    ?D*  FormatString                32A   Const
    ?D*  DateString                  32A
    ?D*  Error                       12A   Options(*Omit)
    ?D*CEEISEC         PR                  ExtProc('CEEISEC') OpDesc
    ?D*  year                        10I 0 Const
    ?D*  month                       10I 0 Const
    ?D*  day                         10I 0 Const
    ?D*  hours                       10I 0 Const
    ?D*  minutes                     10I 0 Const
    ?D*  seconds                     10I 0 Const
    ?D*  milli                       10I 0 Const
    ?D*  out_seconds                  8f
    ?D*  Error                       12A   Options(*Omit)
    ?D*CEESECI         PR                  ExtProc('CEESECI') OpDesc
    ?D*  in_seconds                   8f   const
    ?D*  year                        10I 0
    ?D*  month                       10I 0
    ?D*  day                         10I 0
    ?D*  hours                       10I 0
    ?D*  minutes                     10I 0
    ?D*  seconds                     10I 0
    ?D*  milli                       10I 0
    ?D*  Error                       12A   Options(*Omit)
    ?D*CEESECS         PR                  ExtProc('CEESECS') OpDesc
    ?D*  TimeStamp                   26a   const
    ?D*  TSPicture                   26a   const
    ?D*  out_seconds                  8f
    ?D*  Error                       12A   Options(*Omit)
    ?D* local
    ?D*sWorkDate       S              8A
    ?D*sDateInWords    S             32A
    ?D*nLil            S             10I 0
    ?D*sFormat         S             32A
    ?d*wTime           s              8a   based(pTime)
    ?d*dsTime          ds             8
    ?d* whh                    1      2s 0
    ?d* wmm                    4      5s 0
    ?d* wss                    7      8s 0
     d  atime          s               t
    ?d*wTimeSec        s              8f
    ?d*wTime0          s              8f
    ?d*wTimeStamp26    ds            26    based(pTimeStamp)
    ?d* wdtsYYYY               1      4s 0
    ?d* wdtsMM                 6      7s 0
    ?d* wdtsDD                 9     10s 0
    ?d* wdtsHH                12     13s 0
    ?d* wdtsMI                15     16s 0
    ?d* wdtsSS                18     19s 0
    ?d* wdtsCC                21     23s 0
     d adts            s               z
    ?d*wReal8          s              8f   based(pReal8)
    ?d*uReal8          s              8f
    ?d*wReal4          s              4f   based(pReal4)
    ?d*uReal4          s              4f
    ?d*UnQuoted        s               n   inz(*on)
    ?d*wDec            s             16    based(pDec)
    ?d*DecLen          ds             2
    ?d*lenB2                   1      2i 0
    ?d*  lenG                  1      1i 0
    ?d*  lenD                  2      2i 0
    ?d*num42           s              4  2
    ?d*wNum            s             31    based(pNum)
    ?d*uNum            ds            31
    ?d*uNum00                        31 00 overlay(uNum:1)
    ?d*uNum01                        31 01 overlay(uNum:1)
    ?d*uNum02                        31 02 overlay(uNum:1)
    ?d*uNum03                        31 03 overlay(uNum:1)
    ?d*uNum04                        31 04 overlay(uNum:1)
    ?d*uNum05                        31 05 overlay(uNum:1)
    ?d*uNum06                        31 06 overlay(uNum:1)
    ?d*uNum07                        31 07 overlay(uNum:1)
    ?d*uNum08                        31 08 overlay(uNum:1)
    ?d*uNum09                        31 09 overlay(uNum:1)
    ?d*uNum10                        31 10 overlay(uNum:1)
    ?d*uNum11                        31 11 overlay(uNum:1)
    ?d*uNum12                        31 12 overlay(uNum:1)
    ?d*uNum13                        31 13 overlay(uNum:1)
    ?d*uNum14                        31 14 overlay(uNum:1)
    ?d*uNum15                        31 15 overlay(uNum:1)
    ?d*uNum16                        31 16 overlay(uNum:1)
    ?d*uNum17                        31 17 overlay(uNum:1)
    ?d*uNum18                        31 18 overlay(uNum:1)
    ?d*uNum19                        31 19 overlay(uNum:1)
    ?d*uNum20                        31 20 overlay(uNum:1)
    ?d*uNum21                        31 21 overlay(uNum:1)
    ?d*uNum22                        31 22 overlay(uNum:1)
    ?d*uNum23                        31 23 overlay(uNum:1)
    ?d*uNum24                        31 24 overlay(uNum:1)
    ?d*uNum25                        31 25 overlay(uNum:1)
    ?d*uNum26                        31 26 overlay(uNum:1)
    ?d*uNum27                        31 27 overlay(uNum:1)
    ?d*uNum28                        31 28 overlay(uNum:1)
    ?d*uNum29                        31 29 overlay(uNum:1)
    ?d*uNum30                        31 30 overlay(uNum:1)
    ?d*uNum31                        31 31 overlay(uNum:1)
    ?d*wBin8           s             20i 0 based(pBin8)
    ?d*uBin8           s             20i 0
    ?d*wBin4           s             10i 0 based(pBin4)
    ?d*uBin4           s             10i 0
    ?d*wBin2           s              5u 0 based(pBin2)
    ?d*uBin2           s              5u 0
     d rc              s                   like(size_t)

     d WithData        s               n



     d RpgLen          s              5i 0

      /free
       //?convert to excel format
       evenodd = %rem(row:2);
B01    if evenodd = 0;
          evenodd = 2;
E01    endif;
       rowindex(row);

       sqlvar = p1;



       //?test procedure : analyse in data
       prcv_cli = sqldata;
B01    if sqltype = 484 or
             sqltype = 485 or
             sqltype = 488 or
             sqltype = 489 ;
          rpglen = sqlprecision ;
X01    else;
          rpglen=sqllen;
E01    endif;
       //?   message ('':'Col ' + %char(ifor + 1) + ', type=' + %char(SQLTYPE)
       //?      +', len=' +  %char(SQLLEN )
       //?      +', CCSID='+%char(sqlccsid2)
       //?      +', hexa='+ hexa(%subst(rcv_char:1:rpglen ) )
       //?
       //?
       //?     );
       withData = true;
B01    if odd(sqltype);//?nullable
          pNullInd = sqlind;
B02       if nullind<> 0;
             //?cell is null
             //?nullind = nullind;
             x_string( col:%trim(NullValue):cellStyle.row(evenodd).col(col));
             withdata=false;
E02       endif;
E01    endif;
B01    if withdata;
B02       select;
X02          when sqltype = 384 or sqltype = 385;//? Date
                clear wrk_DATEISO ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_DATEISO = wrk_DATEISO ;
                //?message('':wrk_dateiso);
                adate =%date(wrk_dateiso:*iso);
                x_date(col:adate:cellStyle.row(evenodd).col(col));
X02          when sqltype = 388 or sqltype = 389;//? Time
                clear wrk_TIMEISO ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_TIMEISO = wrk_TIMEISO ;
                //?  message('':wrk_timeiso);
                atime = %time( wrk_timeiso:*ISO);
                x_time( col:aTime :cellStyle.row(evenodd).col(col));
X02          when sqltype = 392 or sqltype = 393;//? Timestamp
                clear wrk_DTS_ISO ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_DTS_ISO = wrk_DTS_ISO ;
                //?   message('':wrk_dts_iso);
                adts = %timestamp(wrk_dts_iso :*ISO);
                x_dts( col:adts :cellStyle.row(evenodd).col(col));
X02          when sqltype = 396 or sqltype = 397;//? DataLink

X02          when sqltype = 400 or sqltype = 401;//? Not Applicable Unsupported Nul-term graphic

X02          when sqltype = 404 or sqltype = 405;//? BLOB

X02          when sqltype = 408 or sqltype = 409;//? CLOB

X02          when sqltype = 412 or sqltype = 413;//? DBCLOB

X02          when sqltype = 448 or sqltype = 449//? Varying-length character string
X..             or sqltype = 456 or sqltype = 457;//? Long varying-length character string
                clear wrk_VARCHAR ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_VARCHAR = wrk_VARCHAR ;
                //?   message('':wrk_VARCHAR);
                utf8data = *loval;
                utf8len = %size(utf8data);
                ebcdlen=%len(wrk_varchar);
                rc = iconv(hIconv :
                   %addr(wrk_varchar)+2: ebcdlen :
                   %addr(utf8data): utf8len ) ;
B03             if rc< 0;
B04                if c_errno <> 0;
                      message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E04                endif;
X03             else;
                   x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
                      :cellStyle.row(evenodd).col(col));
E03             endif;
X02          when sqltype = 452 or sqltype = 453;//? Fixed-length character string
                clear wrk_CHAR ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_CHAR = wrk_CHAR ;
                //?   message('':wrk_char   );

                utf8data = *loval;
                utf8len = %size(utf8data);
                ebcdlen=bufferlen ;
                rc = iconv(hIconv :
                   %addr(wrk_char) : ebcdlen :
                   %addr(utf8data): utf8len ) ;
B03             if rc< 0;
B04                if c_errno <> 0;
                      message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E04                endif;
X03             else;
                   x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
                      :cellStyle.row(evenodd).col(col));
E03             endif;
X01             //?when sqltype = 456 or sqltype = 457;//? Long varying-length character string
                //?clear wrk_CHAR ;
                //?wrk_char = %subst(rcv_char:1:sqllen               );
                //?   wrk_VARCHAR = wrk_VARCHAR ;
                //?   message('':wrk_varchar);
X02          when sqltype = 460 or sqltype = 461;//? Not Applicable Unsupported Nul-term character

X02          when sqltype = 464 or sqltype = 465//? Varying-length graphic string
X..             or sqltype = 472 or sqltype = 473;//? Long varying-length graphic string
                clear wrk_CHAR ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_WVARCHAR=wrk_WVARCHAR;
                //?message('':'wrk_wvarchar');
                utf8data = *loval;
                utf8len = %size(utf8data);
                ebcdlen=%len(wrk_wvarchar)*2;
                rc = iconv(hIconv :
                   %addr(wrk_wvarchar)+2: ebcdlen :
                   %addr(utf8data): utf8len ) ;
B03             if rc< 0;
B04                if c_errno <> 0;
                      message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E04                endif;
X03             else;
                   x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
                      :cellStyle.row(evenodd).col(col));
E03             endif;
X02          when sqltype = 468 or sqltype = 469;//? Fixed-length graphic string
                clear wrk_CHAR ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_WCHAR =wrk_WCHAR ;
                //?message('':'wrk_wchar'  );
                utf8data = *loval;
                utf8len = %size(utf8data);
                ebcdlen=bufferlen ;
                rc = iconv(hIconv :
                   %addr(wrk_wchar) : ebcdlen :
                   %addr(utf8data): utf8len ) ;
B03             if rc< 0;
B04                if c_errno <> 0;
                      message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E04                endif;
X03             else;
                   x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
                      :cellStyle.row(evenodd).col(col));
E03             endif;
X02          when sqltype = 472 or sqltype = 473;//? Long varying-length graphic string
                clear wrk_CHAR ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_WVARCHAR=wrk_WVARCHAR;
                message('':'wrk_wvarchar');
X02          when sqltype = 476 or sqltype = 477;//? Not Applicable Unsupported  PASCAL L

X02          when sqltype = 480 or sqltype = 481;//? Floating point
B03             if sqllen = 4;
                   clear wrk_FLOAT ;
                   wrk_char = %subst(rcv_char:1:bufferlen );
                   wrk_FLOAT = wrk_FLOAT ;
                   //?    message('':%char(wrk_float ) );
                   x_float (col: wrk_float :cellStyle.row(evenodd).col(col));
X03             else;
                   clear wrk_double;
                   wrk_char = %subst(rcv_char:1:bufferlen );
                   wrk_double= wrk_double;
                   //? message('':%char(wrk_double) );
                   x_float (col:wrk_double :cellStyle.row(evenodd).col(col));
E03             endif;
X02          when sqltype = 484 or sqltype = 485;//? Packed decimal
                rpglen = %INT( sqlprecision / 2 ) + 1 ;
                clear wrk_DECIMAL ;
                %subst(wrk_char:33-rpglen :rpglen )
                   = %subst(rcv_char:1:rpglen );
                wrk_DECIMAL = wrk_DECIMAL ;
                //? message('':%char(wrk_decimal));
                udec00 = wrk_decimal ;
B03             select;
X03                when SqlScale = 1;
                      x_number( col:uDec01 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 2;
                      x_number(col:uDec02 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 3;
                      x_number(col:uDec03 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 4;
                      x_number(col:uDec04 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 5;
                      x_number(col:uDec05 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 6;
                      x_number(col:uDec06 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 7;
                      x_number(col:uDec07 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 8;
                      x_number(col:uDec08 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 9;
                      x_number(col:uDec09 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 10;
                      x_number(col:uDec10 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 11;
                      x_number(col:uDec11 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 12;
                      x_number(col:uDec12 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 13;
                      x_number(col:uDec13 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 14;
                      x_number(col:uDec14 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 15;
                      x_number(col:uDec15 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 16;
                      x_number(col:uDec16 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 17;
                      x_number(col:uDec17 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 18;
                      x_number(col:uDec18 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 19;
                      x_number(col:uDec19 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 20;
                      x_number(col:uDec20 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 21;
                      x_number(col:uDec21 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 22;
                      x_number(col:uDec22 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 23;
                      x_number(col:uDec23 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 24;
                      x_number(col:uDec24 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 25;
                      x_number(col:uDec25 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 26;
                      x_number(col:uDec26 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 27;
                      x_number(col:uDec27 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 28;
                      x_number(col:uDec28 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 29;
                      x_number(col:uDec29 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 30;
                      x_number(col:uDec30 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 31;
                      x_number(col:uDec31 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 32;
                      x_number(col:uDec32 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 33;
                      x_number(col:uDec33 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 34;
                      x_number(col:uDec34 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 35;
                      x_number(col:uDec35 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 36;
                      x_number(col:uDec36 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 37;
                      x_number(col:uDec37 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 38;
                      x_number(col:uDec38 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 39;
                      x_number(col:uDec39 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 40;
                      x_number(col:uDec40 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 41;
                      x_number(col:uDec41 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 42;
                      x_number(col:uDec42 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 43;
                      x_number(col:uDec43 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 44;
                      x_number(col:uDec44 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 45;
                      x_number(col:uDec45 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 46;
                      x_number(col:uDec46 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 47;
                      x_number(col:uDec47 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 48;
                      x_number(col:uDec48 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 49;
                      x_number(col:uDec49 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 50;
                      x_number(col:uDec50 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 51;
                      x_number(col:uDec51 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 52;
                      x_number(col:uDec52 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 53;
                      x_number(col:uDec53 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 54;
                      x_number(col:uDec54 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 55;
                      x_number(col:uDec55 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 56;
                      x_number(col:uDec56 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 57;
                      x_number(col:uDec57 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 58;
                      x_number(col:uDec58 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 59;
                      x_number(col:uDec59 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 60;
                      x_number(col:uDec60 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 61;
                      x_number(col:uDec61 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 62;
                      x_number(col:uDec62 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 63;
                      x_number(col:uDec63 :cellStyle.row(evenodd).col(col));
X03                other ;
                      x_number(col:uDec00 :cellStyle.row(evenodd).col(col));
E03             endsl;
X02          when sqltype = 488 or sqltype = 489;//? Zoned decimal
                clear wrk_NUMERIC ;
                %subst(wrk_char:64-sqlprecision :sqlprecision )
                   = %subst(rcv_char:1:sqlprecision );
                wrk_NUMERIC = wrk_NUMERIC ;
                //?message('':%char(wrk_numeric));
                udec00 = wrk_numeric ;
B03             select;
X03                when SqlScale = 1;
                      x_number( col:uDec01 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 2;
                      x_number(col:uDec02 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 3;
                      x_number(col:uDec03 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 4;
                      x_number(col:uDec04 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 5;
                      x_number(col:uDec05 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 6;
                      x_number(col:uDec06 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 7;
                      x_number(col:uDec07 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 8;
                      x_number(col:uDec08 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 9;
                      x_number(col:uDec09 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 10;
                      x_number(col:uDec10 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 11;
                      x_number(col:uDec11 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 12;
                      x_number(col:uDec12 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 13;
                      x_number(col:uDec13 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 14;
                      x_number(col:uDec14 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 15;
                      x_number(col:uDec15 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 16;
                      x_number(col:uDec16 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 17;
                      x_number(col:uDec17 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 18;
                      x_number(col:uDec18 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 19;
                      x_number(col:uDec19 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 20;
                      x_number(col:uDec20 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 21;
                      x_number(col:uDec21 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 22;
                      x_number(col:uDec22 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 23;
                      x_number(col:uDec23 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 24;
                      x_number(col:uDec24 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 25;
                      x_number(col:uDec25 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 26;
                      x_number(col:uDec26 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 27;
                      x_number(col:uDec27 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 28;
                      x_number(col:uDec28 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 29;
                      x_number(col:uDec29 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 30;
                      x_number(col:uDec30 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 31;
                      x_number(col:uDec31 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 32;
                      x_number(col:uDec32 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 33;
                      x_number(col:uDec33 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 34;
                      x_number(col:uDec34 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 35;
                      x_number(col:uDec35 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 36;
                      x_number(col:uDec36 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 37;
                      x_number(col:uDec37 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 38;
                      x_number(col:uDec38 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 39;
                      x_number(col:uDec39 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 40;
                      x_number(col:uDec40 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 41;
                      x_number(col:uDec41 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 42;
                      x_number(col:uDec42 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 43;
                      x_number(col:uDec43 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 44;
                      x_number(col:uDec44 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 45;
                      x_number(col:uDec45 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 46;
                      x_number(col:uDec46 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 47;
                      x_number(col:uDec47 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 48;
                      x_number(col:uDec48 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 49;
                      x_number(col:uDec49 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 50;
                      x_number(col:uDec50 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 51;
                      x_number(col:uDec51 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 52;
                      x_number(col:uDec52 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 53;
                      x_number(col:uDec53 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 54;
                      x_number(col:uDec54 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 55;
                      x_number(col:uDec55 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 56;
                      x_number(col:uDec56 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 57;
                      x_number(col:uDec57 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 58;
                      x_number(col:uDec58 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 59;
                      x_number(col:uDec59 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 60;
                      x_number(col:uDec60 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 61;
                      x_number(col:uDec61 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 62;
                      x_number(col:uDec62 :cellStyle.row(evenodd).col(col));
X03                when SqlScale = 63;
                      x_number(col:uDec63 :cellStyle.row(evenodd).col(col));
X03                other ;
                      x_number(col:uDec00 :cellStyle.row(evenodd).col(col));
E03             endsl;
X02          when sqltype = 492 or sqltype = 493;//? Big integer
                clear wrk_bigINT ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_bigINT = wrk_bigINT ;
                //?message('':%char(wrk_bigint));
                x_number(col:wrk_bigint :cellStyle.row(evenodd).col(col));
X02          when sqltype = 496 or sqltype = 497;//? Large integer
                clear wrk_INTEGER ;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_INTEGER = wrk_INTEGER ;
                //?message('':%char(wrk_integer));
                x_number(col:wrk_integer :cellStyle.row(evenodd).col(col));
X02          when sqltype = 500 or sqltype = 501;//? Small integer
                clear wrk_SMALLINT;
                wrk_char = %subst(rcv_char:1:bufferlen );
                wrk_SMALLINT= wrk_SMALLINT;
                //?message('':%char(wrk_smallint));
                x_number(col:wrk_smallint :cellStyle.row(evenodd).col(col));
X02          when sqltype = 504 or sqltype = 505;//? Not Applicable Unsupported SIGN LEADING

X02          when sqltype = 904 or sqltype = 905;//? ROWID

X02          when sqltype = 960 or sqltype = 961;//? Not Applicable BLOB DATALINK

X02          when sqltype = 964 or sqltype = 965;//? Not Applicable CLOB DATALINK

X02          when sqltype = 968 or sqltype = 969;//? Not Applicable DBCLOB DATALINK

X02          when sqltype = 916 or sqltype = 917;//? Not Applicable

X02          when sqltype = 920 or sqltype = 921;//? Not Applicable

X02          when sqltype = 924 or sqltype = 925;//? Not Applicable

X02          other;
                uData='unsupported.' ;
                uData+=' type' ;
                uData+=%editc(sqltype:'Z') ;
                uData+='; RPG type ' ;
                uData+= %trim(buftyp(sqltype));
                uData +='; longueur ' + %editc(bufferlen:'P');
                x_string(col:uData:cellStyle.row(evenodd).col(col));

E02       endsl;
E01    endif;

B01    //?select;
X01    //?when sqltype = 384 or sqltype = 385;
       //?exsr sqldate;
       //?  exsr sqlhexa;
X01    //?when sqltype = 388 or sqltype = 389;
       //? exsr sqltime;
       //?  exsr sqlhexa;
X01    //?when sqltype = 392 or sqltype = 393;
       //?exsr sqltimestamp;
       //?  exsr sqlhexa;
X01    //?when sqltype = 448 or sqltype = 449;
       //?exsr sqlVarChar;
       //?exsr sqlhexa;
X01    //?when sqltype = 452 or sqltype = 453;
       //?exsr sqlchar;
       //?  exsr sqlhexa;
X01    //?when sqltype = 480 or sqltype = 481;
       //?   exsr sqlreal;
       //?  exsr sqlhexa;
X01    //?when sqltype = 484 or sqltype = 485;
       //?   exsr sqldec ;
       //?exsr sqlhexa;
X01    //?when sqltype = 488 or sqltype = 489;
       //?   exsr sqlnumeric;
       //?exsr sqlhexa;
X01    //?when sqltype = 492 or sqltype = 493;
       //?   exsr sqlint8;
       //?exsr sqlhexa;
X01    //?when sqltype = 496 or sqltype = 497;
       //?   exsr sqlint4;
       //?exsr sqlhexa;
X01    //?when sqltype = 500 or sqltype = 501;
       //?   exsr sqlint2;
       //?exsr sqlhexa;
X01    //?other;
       //?   exsr sqlunsupported;
E01    //?endsl;
       return;

       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* vidage hexa
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlhexa;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pData = sqldata;
       //? select;
       //?    when sqltype = 484 or sqltype = 485;
       //?       //?decimal packed
       //?       wLen=sqllen / 256 ;
       //?       if odd(wlen);
       //?          wlen+=1;
       //?       endif;
       //?       wlen=wlen/2;
       //?    when sqltype = 488 or sqltype = 489;
       //?       //?numeric
       //?       wLen=sqllen / 256 ;
       //?    other;
       //?       wLen=sqllen;
       //? endsl;
       //? uData = %subst(wData:1:wLen);
       //? x_string( col:hexa(uData):cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?*  date
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqldate;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       //?c_style(row:col:0);
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pDate = sqldata;
       //? endsr;
       //? //?*=------------------------------------------------------=*//
       //? //?TIME
       //? //?*=------------------------------------------------------=*//
       //? begsr sqltime;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pTime = sqldata;
       //? dstime = wtime;
       //? atime = %time( wtime:*ISO);
       //? x_time( col:aTime :cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?*  DateTimeStamp
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqltimestamp;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pTimeStamp = sqldata;
       //? adts = %timestamp(wTimeStamp26:*ISO);
       //? x_dts( col:adts :cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* VARCHAR
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlvarchar;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? //? pvarchar = sqldata;
       //? //? uData = wvarchar;
       //? //? x_string(col:uData:cellStyle.row(evenodd).col(col));
       //? pvarchar = sqldata;
       //? utf8data = *loval;
       //? utf8len = %size(utf8data);
       //? ebcdlen=%len(wvarchar);
       //? rc = iconv(hIconv :
       //?    %addr(wvarchar)+2: ebcdlen :
       //?    %addr(utf8data): utf8len ) ;
       //? if rc< 0;
       //?    if c_errno <> 0;
       //?       message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
       //?    endif;
       //? else;
       //?    x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
       //?       :cellStyle.row(evenodd).col(col));
       //? endif;
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* CHAR
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlchar;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? //? pData = sqldata;
       //? //? uData = %subst(wData:1:sqlLen);
       //? //? x_string(col:uData:cellStyle.row(evenodd).col(col));
       //? pvarchar = sqldata;
       //? utf8data = *loval;
       //? utf8len = %size(utf8data);
       //? ebcdlen=sqllen ;
       //? rc = iconv(hIconv :
       //?    %addr(wvarchar) : ebcdlen :
       //?    %addr(utf8data): utf8len ) ;
       //? if rc< 0;
       //?    if c_errno <> 0;
       //?       message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
       //?    endif;
       //? else;
       //?    x_utf8 (col:%subst(utf8Data:1: %size(utf8data)-utf8len)
       //?       :cellStyle.row(evenodd).col(col));
       //? endif;
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?*  Float
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlreal;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? if sqllen = 4;
       //?    preal4= sqldata;
       //?    ureal4= wreal4;
       //?    //?c_style(row:col:0);
       //?    x_float (col: ureal4 :cellStyle.row(evenodd).col(col));
       //? endif;
       //? if sqllen = 8;
       //?    preal8= sqldata;
       //?    ureal8= wreal8;
       //?    //?c_style(row:col:0);
       //?    x_float (col:ureal8 :cellStyle.row(evenodd).col(col));
       //? endif;
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?*  packed decimal
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqldec ;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pDec = sqldata;
       //? lenB2 = sqllen;
       //? lenG+=1;//?pour le signe
       //? if odd(lenG);
       //?    lenG+=1;
       //? endif;
       //? lenG=lenG/2;
       //? uDec=*loval;
       //? %subst(uDec: 16 - lenG + 1: lenG) = %subst(wDec :1:lenG);
       //? select;
       //?    when lenD = 1;
       //?       x_number( col:uDec01 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 2;
       //?       x_number(col:uDec02 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 3;
       //?       x_number(col:uDec03 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 4;
       //?       x_number(col:uDec04 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 5;
       //?       x_number(col:uDec05 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 6;
       //?       x_number(col:uDec06 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 7;
       //?       x_number(col:uDec07 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 8;
       //?       x_number(col:uDec08 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 9;
       //?       x_number(col:uDec09 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 10;
       //?       x_number(col: uDec10 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 11;
       //?       x_number(col: uDec11 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 12;
       //?       x_number(col: uDec12 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 13;
       //?       x_number(col: uDec13 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 14;
       //?       x_number(col: uDec14 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 15;
       //?       x_number(col: uDec15 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 16;
       //?       x_number(col: uDec16 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 17;
       //?       x_number(col: uDec17 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 18;
       //?       x_number(col: uDec18 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 19;
       //?       x_number(col: uDec19 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 20;
       //?       x_number(col: uDec20 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 21;
       //?       x_number(col: uDec21 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 22;
       //?       x_number(col: uDec22 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 23;
       //?       x_number(col: uDec23 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 24;
       //?       x_number(col: uDec24 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 25;
       //?       x_number(col: uDec25 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 26;
       //?       x_number(col: uDec26 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 27;
       //?       x_number(col: uDec27 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 28;
       //?       x_number(col: uDec28 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 29;
       //?       x_number(col: uDec29 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 30;
       //?       x_number(col: uDec30 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 31;
       //?       x_number(col: uDec31 :cellStyle.row(evenodd).col(col));
       //?    other ;
       //?       x_number(col:uDec00 :cellStyle.row(evenodd).col(col));
       //? endsl;
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* numeric etendu
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlnumeric;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pNum = sqldata;
       //? lenB2 = sqllen;
       //? uNum=*zero ;
       //? %subst(uNum: 31 - lenG + 1: lenG) = %subst(wNum :1:lenG);
       //? select;
       //?    when lenD = 1;
       //?       x_number(col:uNum01 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 2;
       //?       x_number(col:uNum02 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 3;
       //?       x_number(col:uNum03 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 4;
       //?       x_number(col:uNum04 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 5;
       //?       x_number(col:uNum05 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 6;
       //?       x_number(col:uNum06 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 7;
       //?       x_number(col:uNum07 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 8;
       //?       x_number(col:uNum08 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 9;
       //?       x_number(col:uNum09 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 10;
       //?       x_number(col: uNum10 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 11;
       //?       x_number(col: uNum11 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 12;
       //?       x_number(col: uNum12 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 13;
       //?       x_number(col: uNum13 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 14;
       //?       x_number(col: uNum14 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 15;
       //?       x_number(col: uNum15 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 16;
       //?       x_number(col: uNum16 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 17;
       //?       x_number(col: uNum17 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 18;
       //?       x_number(col: uNum18 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 19;
       //?       x_number(col: uNum19 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 20;
       //?       x_number(col: uNum20 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 21;
       //?       x_number(col: uNum21 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 22;
       //?       x_number(col: uNum22 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 23;
       //?       x_number(col: uNum23 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 24;
       //?       x_number(col: uNum24 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 25;
       //?       x_number(col: uNum25 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 26;
       //?       x_number(col: uNum26 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 27;
       //?       x_number(col: uNum27 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 28;
       //?       x_number(col: uNum28 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 29;
       //?       x_number(col: uNum29 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 30;
       //?       x_number(col: uNum30 :cellStyle.row(evenodd).col(col));
       //?    when lenD = 31;
       //?       x_number(col: uNum31 :cellStyle.row(evenodd).col(col));
       //?    other ;
       //?       x_number(col:uNum00 :cellStyle.row(evenodd).col(col));
       //? endsl;
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?*  binaire 8 octets
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlint8;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pBin8 = sqldata;
       //? uBin8 = wBin8;
       //? x_number(col:uBin8 :cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* binaire 4
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlint4;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pBin4 = sqldata;
       //? uBin4 = wBin4;
       //? x_number(col:uBin4 :cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* binaire 2
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlint2;
       //? if odd(sqltype);//?nullable
       //?    pNullInd = sqlind;
       //?    if nullind<> 0;
       //?       x_string(col:%trim(NullValue):cellStyle.row(evenodd).col(col));
       //?       leavesr;
       //?    endif;
       //? endif;
       //? pBin2 = sqldata;
       //? uBin2 = wBin2;
       //? x_number(col:uBin2 :cellStyle.row(evenodd).col(col));
       //? endsr;
       //? //?*=----------------------------------------------------------------------------------=*
       //? //?* autre
       //? //?*=----------------------------------------------------------------------------------=*
       //? begsr sqlunsupported;
       //? uData='unsupported.' ;
       //? uData+=' type' ;
       //? uData+=%editc(sqltype:'Z') ;
       //? uData+='; RPG type ' ;
       //? uData+= %trim(buftyp(sqltype));
       //? uData +='; longueur ' + %editc(sqllen:'P');
       //? x_string(col:uData:cellStyle.row(evenodd).col(col));
       //? endsr;
      /end-free
    ?C*=--------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=--------------------------------------------------------------
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
                hex +='a';
X02          when h2 =11;
                hex +='b';
X02          when h2 =12;
                hex +='c';
X02          when h2 =13;
                hex +='d';
X02          when h2 =14;
                hex +='e';
X02          when h2 =15;
                hex +='f';
X02          other;
                hex+='?';
E02       endsl;
E01    endfor;
       return hex;
      /end-free
    ?C*=--------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=--------------------------------------------------------------
EPR  P                 e
