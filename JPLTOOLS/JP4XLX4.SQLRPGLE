      /if defined(XLXML)                                                        xlxml
      /if defined(FILE_SECTION)
      /if defined(XLXML3)                                                        xlxml
     fxmldbuI0  uf a e           k disk    prefix('XL.')
     f                                     infds(fids)
     f                                     usropn
     f                                     extfile('QTEMP/XMLDBUI0')
     f                                     rename(xmldbuT :xmldbuf)
      /else
     fxmldb2p   uf a e           k disk    prefix('XL.')
     f                                     infds(fids)
      /endif
      /endif
      /if defined(DATA_SECTION)
      /if defined(XLXML3)                                                        xlxml
     D  hIconv0        ds                  likeds(iconv_t) inz
     d xl            e ds                  qualified extname(xmldbuI0)
      /else
     d xl            e ds                  qualified extname(xmldb2p)
      /endif
    ?d*Excel xlxml Vocabulary : constants
     d Reset           C                   'Reset'
     d BOTTOM          C                   'Bottom'
     d CENTER          C                   'Center'
     d JUSTIFY         c                   'Justify'
     d LEFT            c                   'Left'
     d RIGHT           c                   'Right'
     d DiagonalLeft    c                   'DiagonalLeft'
     d DiagonalRight   c                   'DiagonalRight'
     d Top             c                   'Top'
     d Continuous      c                   'Continuous'
     d Dash            c                   'Dash'
     d DashDot         c                   'DashDot'
     d DashDotDot      c                   'DashDotDot'
     d Dot             c                   'Dot'
     d Double          c                   'Double'
     d Single          c                   'Single'
     d SingleAccounting...
     d                 C                   'SingleAccounting'
     d DoubleAccounting...
     d                 C                   'DoubleAccounting'
     d Superscript     c                   'Superscript'
     d Subscript       c                   'Subscript'
     D black...
     d                 c                   '#000000'
     D navy...
     d                 c                   '#000080'
     D blue...
     d                 c                   '#0000FF'
     D darkgreen...
     d                 c                   '#003300'
     D darkblue...
     d                 c                   '#003366'
     D mediumblue...
     d                 c                   '#0066CC'
     D forestgreen...
     d                 c                   '#008000'
     D darkseagreen...
     d                 c                   '#008080'
     D darkcyan...
     d                 c                   '#00CCFF'
     D green...
     d                 c                   '#00FF00'
     D cyan...
     d                 c                   '#00FFFF'
     D maroon...
     d                 c                   '#333300'
     D darkgrey...
     d                 c                   '#333333'
     D lightnavy...
     d                 c                   '#333399'
     D lightblue...
     d                 c                   '#3366FF'
     D seagreen...
     d                 c                   '#339966'
     D lightcyan...
     d                 c                   '#33CCCC'
     D violet...
     d                 c                   '#660066'
     D blueviolet...
     d                 c                   '#666699'
     D darkred...
     d                 c                   '#800000'
     D purple...
     d                 c                   '#800080'
     D khaki...
     d                 c                   '#808000'
     D grey...
     d                 c                   '#808080'
     D lightgrey...
     d                 c                   '#969696'
     D firebrick...
     d                 c                   '#993300'
     D orchid...
     d                 c                   '#993366'
     D lightblueviolet...
     d                 c                   '#9999FF'
     D greenyellow...
     d                 c                   '#99CC00'
     D skyblue...
     d                 c                   '#99CCFF'
     D azuregrey...
     d                 c                   '#C0C0C0'
     D lightpurple...
     d                 c                   '#CC99FF'
     D thistle...
     d                 c                   '#CCCCFF'
     D gainsboro...
     d                 c                   '#CCFFCC'
     D azure...
     d                 c                   '#CCFFFF'
     D red...
     d                 c                   '#FF0000'
     D magenta...
     d                 c                   '#FF00FF'
     D orange...
     d                 c                   '#FF6600'
     D salmon...
     d                 c                   '#FF8080'
     D oldgold...
     d                 c                   '#FF9900'
     D pink...
     d                 c                   '#FF99CC'
     D gold...
     d                 c                   '#FFCC00'
     D wheat...
     d                 c                   '#FFCC99'
     D yellow...
     d                 c                   '#FFFF00'
     D cornsilk...
     d                 c                   '#FFFF99'
     D snow...
     d                 c                   '#FFFFCC'
     D white...
     d                 c                   '#FFFFFF'
    ? * numberformat predefined
     d  standard       c                   'Standard'
     d  general        c                   'General'
     d  zerodec        c                   '0'
     d  GNumber        c                   'General Number'
     d  twodec         c                   'Fixed'
     d  zerodecsep     c                   '#,##0'
     d  twodecsep      c                   '#,##0.00'
     d  Eur0dec        c                   '#,##0\ "¤";\-#,##0\ "¤"'
     d  Eur0decRed     c                   '#,##0\ "¤";[Red]\-#,##0\ "¤"'
     d  Eur2Dec        c                   '#,##0.00\ "¤";\-#,##0.00\ "¤"'
     d  Currency       c                   'Currency'
     d  pct0dec        c                   '0%'
     d  pct2dec        c                   'Percent'
     d  scientific     c                   'Scientific'
     d  scientific3    c                   '##0.0E+0'
     d  frac1          c                   '#" "?/?'
     d  frac2          c                   '#" "??/??'
     d  ShortDate      c                   'Short Date'
     d  MediumDate     c                   'Medium Date'
     d  LongDate       c                   'Long Date'
     d  ddmmm          c                   'dd\-mmm'
     d  mmmyy          c                   'mmm\-yy'
     d  mediumtime     c                   'Medium Time'
     d  longtime       c                   'Long Time'
     d  shorttime      c                   'Short Time'
     d  Date           c                   'General Date'
     d  hours          c                   'mm:ss'
     d  text           c                   '@'
     d  BigHours       c                   '[h]:mm:ss'
     d  dateiso        c                   'yyyy\-mm\-dd'
     d  houriso        c                   'hh:mm:ss'
     d  datehouriso    c                   'yyyy\-mm\-dd\ hh:mm:ss'
     d  timeiso        c                   'hh:mm:ss'
     d  datetimeiso    c                   'yyyy\-mm\-dd\ hh:mm:ss'
     d  TrueFalseNF    c                   'True/False'
     d  OnOff          c                   'On/Off'
     d DiagCross       c                   'DiagCross'
     d DiagStripe      c                   'DiagStripe'
     d Gray0625        c                   'Gray0625'
     d Gray125         c                   'Gray125'
     d Gray25          c                   'Gray25'
     d Gray50          c                   'Gray50'
     d Gray75          c                   'Gray75'
     d HorzStripe      c                   'HorzStripe'
     d ReverseDiagStripe...
     d                 c                   'ReverseDiagStripe'
     d Solid           c                   'Solid'
     d ThickDiagCross  c                   'ThickDiagCross'
     d ThinDiagCross   c                   'ThinDiagCross'
     d ThinDiagStripe  c                   'ThinDiagStripe'
     d ThinHorzCross   c                   'ThinHorzCross'
     d ThinHorzStripe  c                   'ThinHorzStripe'
     d ThinReverseDiagStripe...
     d                 c                   'ThinReverseDiagStripe'
     d ThinVertStripe  c                   'ThinVertStripe'
     d VertStripe      c                   'VertStripe'
     d NoSelection     c                   'NoSelection'
     d UnlockedCells   c                   'UnlockedCells'
     d SheetHidden     c                   'SheetHidden'
     d SheetVeryHidden...
     d                 c                   'SheetVeryHidden'
     d Boolean         c                   'Boolean'
     d DateTime        c                   'DateTime'
     d Number          c                   'Number'
     d String          c                   'String'
     d Utf8            c                   'Utf8'
     d Bin             c                   'Bin'
     d Error           c                   'Error'
     d tag             s            300    varying
     d LongTag         s           1000    varying
     d TopLeft         c                   3
     d TopRight        c                   1
     d Bottomleft      c                   2
     d BottomRight     c                   0
     d xlxml           ds                  qualified
     d CurRow                         5u 0 inz(0)
     d CurCol                         5u 0 inz(0)
     d MinCol                         5u 0 inz(*hival)
     d MaxCol                         5u 0 inz(*loval)
     d CellIsOpen                      n
     d RowIsOpen                       n
     d TableIsOpen                     n
     d SheetIsOpen                     n
     d colsize                        5i 0 dim(256) inz(0)
     d PointPerChar                   5u 0          inz(6)
     d style                               likeds(dsstyle)
     d dsstyle         ds                  qualified
     d number                              like(x_style)
     d date                                like(x_style)
     d time                                like(x_style)
     d dts                                 like(x_style)
     d integer                             like(x_style)
    ? * build frames, one frame per group
    ? * a group is like an open file; it is a point where
    ? * you can write. Something like a binary tree
    ? * xmldoc
    ? *   WorkBook
    ? *     SmartTagType
    ? *     DocumentProperties
    ? *     CustomerDocumentProperties
    ? *     ExcelWorkbook
    ? *     Styles
    ? *     Names
    ? *     Worksheets
    ? *       Worksheet
    ? *         Worksheetoptions
    ? *         Table
    ? *           Column
    ? *           Row
    ? *             RowData
    ? *             Cell
    ? *               CellData
    ? *         ConditionalFormatting
    ? *     PivotCache
    ? *     MapInfo
    ? *     Binding
    ? * the frame model
     d dsFrame         ds                  qualified based(pFrame)
     d   deep                         3u 0
     d   level                        5u 0 dim(09)
     d   ManualNumber                  n
    ? * the current frame
     d InFrame         ds                  likeds(dsFrame) based(pInFrame)
    ? * the frame stack (every frames are opened simultaneously)
     d xml             ds                  qualified
     d xmldoc...
     d                                     likeds(dsFrame)
     d WorkBook...
     d                                     likeds(dsFrame)
     d SmartTagType...
     d                                     likeds(dsFrame)
     d DocumentProperties...
     d                                     likeds(dsFrame)
     d CustomerDocumentProperties...
     d                                     likeds(dsFrame)
     d ExcelWorkbook...
     d                                     likeds(dsFrame)
     d Styles...
     d                                     likeds(dsFrame)
     d Names...
     d                                     likeds(dsFrame)
     d Worksheets...
     d                                     likeds(dsFrame)
     d Worksheet...
     d                                     likeds(dsFrame)
     d WorksheetOptions...
     d                                     likeds(dsFrame)
     d Table...
     d                                     likeds(dsFrame)
     d Column...
     d                                     likeds(dsFrame)
     d Rows...
     d                                     likeds(dsFrame)
     d Row...
     d                                     likeds(dsFrame)
     d RowData...
     d                                     likeds(dsFrame)
     d cell...
     d                                     likeds(dsFrame)
     d CellData...
     d                                     likeds(dsFrame)
     d ConditionalFormatting...
     d                                     likeds(dsFrame)
     d PivotCache...
     d                                     likeds(dsFrame)
     d MapInfo...
     d                                     likeds(dsFrame)
     d Binding...
     d                                     likeds(dsFrame)
     d dsrange         ds                  qualified based(pRange)
     d   row                         10u 0
     d   col                         10u 0
     d   cell                        10    varying
      /endif
      /if defined(DATA_SECTION)
     d NewFrame        pr                  likeds(dsFrame)
     d   CurFrame                          likeds(dsFrame)
     d   ManualNumber                  n   options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p NewFrame        b
     d NewFrame        pi                  likeds(dsFrame)
     d   Parent                            likeds(dsFrame)
     d   ManualNumber                  n   options(*nopass) const
     d child           ds                  likeds(dsFrame)
      /free
       child = parent;
       child.deep+=1;
B01    if %parms >= 2;
          child.manualnumber=manualnumber;
X01    else;
          child.manualnumber=false;
E01    endif;
B01    if parent.ManualNumber=false;
          parent.level(parent.deep)+=1;
E01    endif;
       return child;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     D x_OpenXlXml     pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_OpenXlXml     b
     D x_OpenXlXml     PI
      /free
      /if defined(XLXML3)
       //?non, RPGPPOPT(*LVL2) renumerote le source /include qpgmsrc,xmldbuk
       //?default converter from jobccsid to 1208, for x_write
       iconvfromcode.ccsid = 0 ;
       iconvtocode.ccsid = 1208;
       hIconv0= iconv_open(%addr(iconvtoCode) :
          %addr(iconvfromCode) ) ;
B01    if hiconv0.rc <> 0;
B02       if errno() <> 0;
             message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
E02       endif;
E01    endif;
      /endif
       clear xml;
       xml.xmldoc.deep=1;
       pinFrame=%addr(xml.xmldoc);
      /if defined(XLXML3)
       x_write('<?xml version="1.0"?>');
      /else
       x_write('<?xml version="1.0" encoding="ISO-8859-1"?>');
      /endif
       x_write('<?mso-application progid="Excel.Sheet"?>');
       x_write('<Workbook '+
          'xmlns="urn:schemas-microsoft-com:office:spreadsheet"');
       x_write('xmlns:o="urn:schemas-microsoft-com:office:office"');
       x_write('xmlns:x="urn:schemas-microsoft-com:office:excel"');
       x_write('xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"');
       x_write('xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"');
       x_write('xmlns:html="http://www.w3.org/TR/REC-html40">');
       xml.WorkBook=NewFrame(xml.xmldoc);
       xml.SmartTagType = newFrame(xml.WorkBook);
       xml.DocumentProperties = newFrame(xml.WorkBook);
       xml.CustomerDocumentProperties = newFrame(xml.WorkBook);
       xml.ExcelWorkbook = newFrame(xml.WorkBook);
       xml.Styles = newFrame(xml.WorkBook);
       xml.Names = newFrame(xml.WorkBook);
       xml.Worksheets = newFrame(xml.WorkBook);
       xml.PivotCache = newFrame(xml.WorkBook);
       xml.MapInfo = newFrame(xml.WorkBook);
       xml.Binding = newFrame(xml.WorkBook);
       pinFrame=%addr(xml.Styles);
       x_write('<Styles>');
       pinFrame=%addr(xml.Names);
       x_write('<Names>');
       pinFrame=%addr(xml.PivotCache);
       x_write('<PivotCache/>');
       pinFrame=%addr(xml.MapInfo);
       x_write('<MapInfo/>');
       pinFrame=%addr(xml.Binding);
       x_write('<Binding/>');
       clear documentproperties;
       DocumentProperties.flushed=true;
       Author(SPJBUS);
       Created(Znow) ;
       //?  *CustomerDocumentProperties
       clear ExcelWorkbook;
       //?no, inz ! clear Styles;
       /if defined(xlxml4)
       Style=NewStyle();
       /else
       clear Style;
       /endif
       clear NamedRange;
       //?   Worksheets           ;
       clear Worksheet ;
       clear WorksheetOptions ;
       clear FreezePanes;
       clear Table ;
       clear Column ;
       //?   Rows                      ;
       clear Row ;
       clear cell ;
       clear Data ;
       clear Comment ;
       comment.flushed = true ;
       clear Condition ;
       //?   PivotCache                     ;
       //?   MapInfo                         ;
       //?   Binding                          ;
       //?insert all predefined tags
       NumberFormat(GNumber);
       xlxml.style.number = x_style();
       NumberFormat(ShortDate);
       xlxml.style.date = x_style();
       NumberFormat(ShortTime);
       xlxml.style.time = x_style();
       NumberFormat(DateTimeIso);
       xlxml.style.dts = x_style();
       NumberFormat(zerodec);
       xlxml.style.integer = x_style();
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d DocumentProperties...
     d                 ds                  qualified
     d   Author                            like(tag          )
     d   LastAuthor                        like(tag          )
     d   Created                           like(tag          )
     d   Company                           like(tag          )
     d   version                           like(tag          )
     d   flushed                       n
     d x_DocumentProperties...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_DocumentProperties...
BPR  p                 b
     d x_DocumentProperties...
     d                 PI
      /free
       pinFrame=%addr(xml.DocumentProperties);
       x_write('<DocumentProperties ' +
          'xmlns="urn:schemas-microsoft-com:office:office">');
B01    if %len(documentproperties.author) > 1;
          x_write(documentproperties.author);
E01    endif;
B01    if %len(documentproperties.LastAuthor ) > 1;
          x_write(documentproperties.LastAuthor );
E01    endif;
B01    if %len(documentproperties.created) > 1;
          x_write(documentproperties.created);
E01    endif;
B01    if %len(documentproperties.Company) > 1;
          x_write(documentproperties.Company);
E01    endif;
B01    if %len(documentproperties.Version) > 1;
          x_write(documentproperties.Version);
E01    endif;
       x_write('</DocumentProperties>');
       clear DocumentProperties;
       DocumentProperties.flushed=true;
       x_CustomerDocumentProperties();
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Author          pr
     d p1                                  like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Author          b
     d Author          PI
     d p1                                  like(tag) options(*nopass) const
      /free
       documentproperties.author='<Author>'+p1+'</Author>';
       DocumentProperties.flushed=false;
       return ;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d LastAuthor      pr
     d                              300    varying options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p LastAuthor      b
     d LastAuthor      PI
     d p1                                  like(tag) options(*nopass) const
      /free
       documentproperties.Lastauthor='<LastAuthor>'+p1+'</LastAuthor>';
       DocumentProperties.flushed=false;
       return ;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Created         pr
     d                                 z                            const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Created         b
     d Created         PI
     d p1                              z                            const
     d ztochar         s             26    static
    ? * exemple de valeur initiale: Z'2005-04-01-13.45.18'
    ? * exemple de date convertie : '2005-04-01-13.45.18.000000'
    ? * format excel :              '2005-04-01T13.45.18Z'
      /free
       ztochar=%char(p1:*iso);
       %subst(ztochar:11:1)='T';
       %subst(ztochar:20:1)='Z';
       documentproperties.Created=
          '<Created>'+%subst(ztochar:1:20)
          +'</Created>';
       DocumentProperties.flushed=false;
       return ;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Company         pr
     d p1                                  like(tag)                  const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Company         b
     d Company         PI
     d p1                                  like(tag)                  const
      /free
       documentproperties.Company='<Company>'+p1+'</Company>';
       DocumentProperties.flushed=false;
       return ;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d version         pr
     d p1                                  like(tag)                  const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p version         b
     d version         PI
     d p1                                  like(tag)                  const
      /free
       documentproperties.Version='<Version>'+p1+'</Version>';
       DocumentProperties.flushed=false;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CustomerDocumentProperties...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_CustomerDocumentProperties...
BPR  p                 b
     d x_CustomerDocumentProperties...
     d                 PI
      /free
       pinFrame=%addr(xml.CustomerDocumentProperties);

       x_write('<CustomDocumentProperties'
          +     ' xmlns="urn:schemas-microsoft-com:office:office">');
       x_write('<Generator dt:dt="string">jpltools</Generator>');
       x_write('</CustomDocumentProperties>');
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ExcelWorkbook   ds                  qualified
     d   WindowHeight                      like(tag)
     d   WindowWidth                       like(tag)
     d   WindowTopX                        like(tag)
     d   WindowTopY                        like(tag)
     d   ProtectStructure...
     d                                     like(tag)
     d   ProtectWindows...
     d                                     like(tag)
     d   ActiveSheet                       like(tag)
     d   WindowHidden                      like(tag)
     d x_ExcelWorkbook...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_ExcelWorkbook...
BPR  p                 b
     d x_ExcelWorkbook...
     d                 PI
      /free
       pinFrame=%addr(xml.ExcelWorkbook);
       x_write('<ExcelWorkbook      ' +
          'xmlns="urn:schemas-microsoft-com:office:excel">');
B01    if %len( ExcelWorkbook.WindowHeight ) > 0;
          x_write(ExcelWorkbook.WindowHeight );
E01    endif;
B01    if %len( ExcelWorkbook.WindowWidth ) > 0;
          x_write(ExcelWorkbook.WindowWidth );
E01    endif;
B01    if %len( ExcelWorkbook.WindowTopX ) > 0;
          x_write(ExcelWorkbook.WindowTopX );
E01    endif;
B01    if %len( ExcelWorkbook.WindowTopY ) > 0;
          x_write(ExcelWorkbook.WindowTopY );
E01    endif;
B01    if %len( ExcelWorkbook.ProtectStructure) > 0;
          x_write(ExcelWorkbook.ProtectStructure);
E01    endif;
B01    if %len( ExcelWorkbook.ProtectWindows ) > 0;
          x_write(ExcelWorkbook.ProtectWindows );
E01    endif;
B01    if %len( ExcelWorkbook.ActiveSheet ) > 0;
          x_write(ExcelWorkbook.ActiveSheet );
E01    endif;
B01    if %len( ExcelWorkbook.WindowHidden ) > 0;
          x_write(ExcelWorkbook.WindowHidden );
E01    endif;
       x_write('</ExcelWorkbook>');
       clear ExcelWorkBook;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WindowHeight    pr
     d                               10u 0                          const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WindowHeight    b
     d WindowHeight    PI
     d p1                            10u 0                          const
      /free
       ExcelWorkbook.WindowHeight =
          '<WindowHeight>'+%char(p1)+'</WindowHeight>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WindowWidth     pr
     d                               10u 0                          const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WindowWidth     b
     d WindowWidth     PI
     d p1                            10u 0                          const
      /free
       ExcelWorkbook.WindowWidth =
          '<WindowWidth>'+%char(p1)+'</WindowWidth>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WindowTopX      pr
     d                               10u 0                          const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WindowTopX      b
     d WindowTopX      PI
     d p1                            10u 0                          const
      /free
       ExcelWorkbook.WindowTopX =
          '<WindowTopX>'+%char(p1)+'</WindowTopX>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WindowTopY      pr
     d                               10u 0                          const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WindowTopY      b
     d WindowTopY      PI
     d p1                            10u 0                          const
      /free
       ExcelWorkbook.WindowTopY =
          '<WindowTopY>'+%char(p1)+'</WindowTopY>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ProtectStructure...
     d                 pr
     d                                 n                            const
      /endif
      /if defined(PROCEDURE_SECTION)
     p ProtectStructure...
BPR  p                 b
     d ProtectStructure...
     d                 PI
     d p1                              n                            const
      /free
       ExcelWorkbook.ProtectStructure =
          '<ProtectStructure>'+TrueFalse(p1)+'</ProtectStructure>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ProtectWindows  pr
     d                                 n                            const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p ProtectWindows  b
     d ProtectWindows  PI
     d p1                              n                            const
      /free
       ExcelWorkbook.ProtectWindows =
          '<ProtectWindows>'+TrueFalse(p1)+'</ProtectWindows>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ActiveSheet     pr
     d                               10u 0                          const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p ActiveSheet     b
     d ActiveSheet     PI
     d p1                            10u 0                          const
      /free
       ExcelWorkbook.ActiveSheet =
          '<ActiveSheet>'+%char(p1)+'</ActiveSheet>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WindowHidden    pr
     d                                 n                            const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WindowHidden    b
     d WindowHidden    PI
     d p1                              n                            const
      /free
       ExcelWorkbook.WindowHidden =
          '<WindowHidden>'+TrueFalse(p1)+'</WindowHidden>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)                                                 xlxml
     d Styles          ds                  qualified
     d   StyleCount                   5u 0 inz(21)
      /if defined(XLXML4)                                                       xlxml4
     d NewStyle        pr                  likeds(style   )
     d InzStyle        pr
     d   p1                                like(x_style)             const
     d SetStyle        pr
     d   row                         10u 0                           const
     d   col                         10u 0                           const
     d P_Style                             like(x_style   )          const
     d SetBorder       pr
     d   uprow                       10u 0                           const
     d   leftcol                     10u 0                           const
     d   downrow                     10u 0                           const
     d   rightcol                    10u 0                           const
     d  olinestyle                   10    varying                   const
     d  oweight                      10u 0                           const
     d  ilinestyle                   10    varying options(*nopass)  const
     d  iweight                      10u 0         options(*nopass)  const
     d GetStyle        pr                  likeds(style   )
     d   row                         10u 0                           const
     d   col                         10u 0                           const
     d x_Style         pr                  likeds(style   )
     d   clearStyle                    n           options(*nopass) const
     d Style           ds                  qualified                            StyleDefinition
     d   IsNotNull                     n
     d   numberformat               100    varying
     d   hasBorders                    n
     d   iBorder                     10u 0
     d   ID                          10    varying
     d   SName                       10    varying
     d   Parent                      10    varying
     d   font                              likeds(FontDef)
     d   Alignment                         likeds(AlignmentDef)
     d   border                            likeds(BorderDef) dim(6)
     d   interior                          likeds(InteriorDef)
     d   protection                        likeds(ProtectionDef)
     d alignmentdef    ds                  qualified based(template)
     d   IsNotNull                     n
     d  Vertical                     10    varying
     d  Horizontal                   10    varying
     d  WrapText                       n
     d  Rotate                       10i00
     d borderdef       ds                  qualified based(template)
     d   IsNotNull                     n
     d  position                     15    varying
     d  linestyle                    10    varying
     d  weight                       10u00
     d fontdef         ds                  qualified based(template)
     d   IsNotNull                     n
     d  Name                        100    varying
     d  Family                      100    varying
     d  Bold                           n
     d  Size                         10u00
     d  Italic                         n
     d  Underline                    20    varying
     d  StrikeThrough                  n
     d  VerticalAlign                15    varying

     d interiordef     ds                  qualified based(template)
     d   IsNotNull                     n
     d  color                        20    varying
     d  pattern                      25    varying

     d protectiondef   ds                  qualified based(template)
     d   IsNotNull                     n
     d  protected                      n
     d   hideformula                   n
     d WriteStyles     pr
      /else                                                                     xlxml, xlxml3
     d Style           ds                  qualified
     d   StyleNo                           like(tag)
     d   StyleName                         like(tag)
     d   Parent                            like(tag)
     d   Alignment                         like(tag)
     d   Borders                           like(tag)
     d   font                              like(tag)
     d   interior                          like(tag)
     d   NumberFormat                      like(tag)
     d   Protection                        like(tag)
     d x_Style         pr            30    varying
     d   clearStyle                    n           options(*nopass) const
      /endif                                                                    xl
      /endif                                                                    data
      /if defined(PROCEDURE_SECTION)                                            procedure
      /if defined(XLXML4)                                                       xlxml4
BPR  p WriteStyles     b
     d                 PI
     d k1            e ds                  qualified extname(xmldbuI0)
     d prev_style      ds                  likeds(style)
     d curr_style      ds                  likeds(style)
     d work_style      ds                  likeds(style)
     d border          ds                  likeds(BorderDef)  based(pBorder)
     d font            ds                  likeds(FontDef)    based(pFont)
     d interior        ds                  likeds(InteriorDef) based(pInterior)
     d protection      ds                  likeds(ProtectionDef)
     d                                     based(pProtection)
     d alignment       ds                  likeds(AlignmentDef)
     d                                     based(pAlignment)
     c*
       //?search for all style lines in bin data tree
       //?convert them into xml style

       //?ID message . . . . . . :   SQL5021
       //?can not order a select on a field under update
       //?-> use sql select to retrieve data
       //?then use rla chain-update to update data
     c/EXEC SQL
     C+ DECLARE XML4K1 CURSOR FOR SELECT * FROM qtemp/xmldbut WHERE
     C+ LEVEL8 =110 ORDER BY data
     C/End-Exec
      /free
       //?yes, i know, i would have coded this with a dynamic sql
       //?and calculate LEVEL8 field name based on xml.celldata.deep
       //?but it will pass a lot of time before xml.celldata.deep will change.
       EXEC SQL open xml4k1 ;
       clear prev_style;
       clear curr_style;
B01    dow true;
          EXEC SQL fetch xml4k1 into : k1 ;
B02       if sqlcod = 100;
             leave;
E02       endif;
B02       if sqlcod <> *zero;
             diagsqler (sqlcod);
             diagemis=true;
             leave;
E02       endif;
          curr_style = k1.data;
B02       if curr_style = prev_style;//?same again, work_style is already updated
X02       else;
             work_style = curr_style;
             prev_style = curr_style;

             pinFrame=%addr(xml.Styles);
             tag = '<Style';
B03          if work_style.ID      =''; //ID non fourni, le calculer
                   work_style.ID = 'S' +%char(styles.StyleCount);
                styles.StyleCount+=1;
E03          endif;
             tag+=' ss:ID="'+work_style.ID     +'"';
B03          if work_style.SName<>''; // NAME fourni, ajouter
                   tag+=' '+work_style.SName;
E03          endif;
B03          if work_style.Parent<>'';
                tag+=' '+work_style.Parent;
E03          endif;
             tag+='>';
             x_write(tag);
B03          if work_style.Alignment.isnotnull;
            pAlignment = %addr(work_style.Alignment);
                tag='<Alignment ';
B04             if alignment.vertical <>'';
                   tag+=' ss:Vertical="'+alignment.vertical +'"';
E04             endif;
B04             if alignment.horizontal<>'';
                   tag+=' ss:Horizontal="'+alignment.horizontal+'"';
E04             endif;
B04             if alignment.rotate<>0 ;
                   tag+=' ss:Rotate ="'+%char(alignment.rotate)+'"';
E04             endif;
                tag+=' ss:WrapText ="'+ZerOne(alignment.wraptext)+'"';
                tag+='/>';
                x_write(tag);
E03          endif;
B03          if work_style.hasBorders;
                tag='<Borders>';
                x_write(tag);
B04             for work_style.iBorder = 1 to 6;
                   pborder = %addr(work_style.Border(work_style.iBorder));
B05                if Border.IsNotNull;
                      tag='<Border ';
B06                   if border.position <>'';
                         tag+=' ss:Position="'+ border.position +'"';
E06                   endif;
B06                   if border.linestyle<>'';
                         tag+=' ss:LineStyle="'+ border.linestyle +'"';
E06                   endif;
B06                   if border.weight <> 0;
                         tag+=' ss:Weight="'+%char(border.weight)+'"';
E06                   endif;
                      tag+='/>';
                      x_write(tag);
E05                endif;
E04             endfor;
                tag='</Borders>';
                x_write(tag);
E03          endif;
B03          if work_style.font.IsNotNull;
                pfont = %addr(work_style.font);
                tag='<Font ';
B04             if font.name <>'';
                   tag+=' ss:FontName="'+encode(
                      font.name )+'"';
E04             endif;
B04             if font.family <>'';
                   tag+=' x:Family="'+encode(
                      font.family)+'"';
E04             endif;
                tag+=' ss:Bold="'+ZerOne(
                   font.bold)+'"';
B04             if font.size <> 0;
                   tag+=' ss:Size="'+%char(
                      font.size)+'"';
E04             endif;
                tag+=' ss:Italic="'+ZerOne(
                   font.italic)+'"';
B04             if font.underline <> '';
                   tag+=' ss:Underline="'+
                      font.underline +'"';
E04             endif;
                tag+=' ss:StrikeThrough="'+ZerOne(
                   font.StrikeThrough)+'"';
B04             if font.VerticalAlign<>'';
                   tag+=' ss:VerticalAlign="'+
                      font.VerticalAlign +'"';
E04             endif;
                tag+='/>';
                x_write(tag);
E03          endif;
B03          if work_style.interior.isnotnull;
                pInterior =%addr(work_style.interior);
                tag='<Interior';
B04             if interior.color<>'';
                   tag+=' ss:Color="'+
                      interior.color       +'"';
E04             endif;
B04             if interior.pattern<>'';
                   tag+=' ss:Pattern="'+
                      interior.pattern       +'"';
E04             endif;
                tag+='/>';
                x_write(tag);
E03          endif;
B03          if       work_style.NumberFormat<>'';
                tag='<NumberFormat '
                   + ' ss:Format="'+encode(
B01                work_style.NumberFormat)+'"';
                tag+='/>';
                x_write(tag);
E03          endif;
B03          if work_style.Protection.isnotnull;
                pProtection=%addr(work_style.Protection);
                tag='<ss:Protection';
                tag+=' ss:Protected="'+ZerOne(
                   protection.protected         )+'"';
                tag+=' ss:HideFormula="'+ZerOne(
                   protection.hideformula         )+'"';
                tag+='/>';
                x_write(tag);
E03          endif;
             x_write('</Style>');
E02       endif;
          //?read for update
          chain (k1.level1:
             k1.level2:
             k1.level3:
             k1.level4:
             k1.level5:
             k1.level6:
             k1.level7:
             k1.level8:
             k1.level9) xmldbuf;//?read xmldbuf into xl.*
B02       if not %found();
             message ('':'error when reread xmldbut') ;
X02       else;
             xl.data = toutf8(
                ' ss:StyleID="'+encode(
                work_style.ID         )+'"');
             update xmldbuf;
B03          if %status() <> 0 ;
                message('':'error when update xmldbut');
E03          endif;
E02       endif;
E01    enddo;






       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e

BPR  p GetStyle        b
     d                 pi                  likeds(style   )
     d   row                         10u 0                         const
     d   col                         10u 0                         const
     d rtndta          ds                  likeds(style   ) static
     d cell            ds                  likeds(dsFrame)
      /free
       rtndta=newstyle();
       cell = xml.celldata;
       cell.level(cell.deep)=110;
       cell.level(cell.deep-1)=col;
       cell.level(cell.deep-2)=row;
       //?read only
       chain(n) (cell.level(1):
          cell.level(2):
          cell.level(3):
          cell.level(4):
          cell.level(5):
          cell.level(6):
          cell.level(7):
          cell.level(8):
          cell.level(9)) xmldbuf;//?read xmldbuf into xl.*
B01    if not %found();
          message ('':'error when reread xmldbut') ;
X01    else;
          rtndta= xl.data;
E01    endif;
       return rtndta;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e


BPR  p SetStyle        b
     d                 pi
     d   row                         10u 0                         const
     d   col                         10u 0                         const
     d p_style                             like(x_style   )        const
     d UpdateRcd       s               n
     d cell            ds                  likeds(dsFrame)
      /free

       cell = xml.celldata;
       cell.level(cell.deep)=100;
       cell.level(cell.deep-1)=col;
       cell.level(cell.deep-2)=row;
       //?read only
       chain(n)  (cell.level(1):
          cell.level(2):
          cell.level(3):
          cell.level(4):
          cell.level(5):
          cell.level(6):
          cell.level(7):
          cell.level(8):
          cell.level(9)) xmldbuf;//?read xmldbuf into xl.*
B01    if not %found();
         message('':'try to change the style of a not loaded cell. Row='
         + %char(row)+', Col='+%char(Col));
         dumpcallstack();
         diagemis=true;
       else;





       cell.level(cell.deep)=110;
       cell.level(cell.deep-1)=col;
       cell.level(cell.deep-2)=row;
       //?read for update
       chain (cell.level(1):
          cell.level(2):
          cell.level(3):
          cell.level(4):
          cell.level(5):
          cell.level(6):
          cell.level(7):
          cell.level(8):
          cell.level(9)) xmldbuf;//?read xmldbuf into xl.*
B01    if not %found();
          updatercd = false;
X01    else;
          updatercd = true ;
E01    endif;
       xl.level1 = cell.level(1);
       xl.level2 = cell.level(2);
       xl.level3 = cell.level(3);
       xl.level4 = cell.level(4);
       xl.level5 = cell.level(5);
       xl.level6 = cell.level(6);
       xl.level7 = cell.level(7);
       xl.level8 = cell.level(8);
       xl.level9 = cell.level(9);
                  xl.data=p_style;
                  if updatercd;
                  update xmldbuf;
                  else;
                  write xmldbuf;
                  endif;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e





     p SetBorder       b
     d                 pi
     d   uprow                       10u 0                           const
     d   leftcol                     10u 0                           const
     d   downrow                     10u 0                           const
     d   rightcol                    10u 0                           const
     d   outlinestyle                10    varying                   const
     d   outweight                   10u 0                           const
     d    inlinestyle                10    varying  options(*nopass) const
     d    inweight                   10u 0          options(*nopass) const
     d  sty            ds                  likeds(style)
BPR  d  c              s             10u 0
     d  r              s             10u 0
     d  z              s             10u 0

      /free

       if     outLineStyle=Continuous
          or  outLineStyle=Dash
          or  outLineStyle=DashDot
          or  outLineStyle=DashDotDot
          or  outLineStyle=Dot
          or  outLineStyle=Reset
          or  outLineStyle=Double ;
          else;
          message('':
                 'LineStyle="'+outlinestyle
                               +' is incorrect, possible values are ' +
             Reset                     +', '+
             Continuous                +', '+
             Dash                      +', '+
             DashDot                   +', '+
             DashDotDot                +', '+
             Dot                       +', '+
             Double                    +'"');
               dumpcallstack();
             diagemis=true;
                           return;
                                  endif;
        if 1<= outweight and outweight <=3;
        else;
        message('':
        'Weight="'+%char(outweight)+' is incorrect, possible values are '+
           '1 to 3"');
               dumpcallstack();
             diagemis=true;
                           return;
                                  endif;
        if 1<= uprow and uprow <= 65535 and
           1<= downrow and downrow <= 65535 and
          uprow <= downrow and
          1<= leftcol and leftcol <= 256 and
          1<= rightcol and rightcol <= 256 and
          leftcol <= rightcol;
        else;
        message('':'rectangle to set borders out of the sheet. R'+
        %char(uprow)+'C'+%char(leftcol)+':R'+
        %char(downrow)+'C'+%char(rightcol));
               dumpcallstack();
             diagemis=true;
                           return;
                                  endif;

        if %parms >= 7;

       if      inLineStyle=Continuous
          or   inLineStyle=Dash
          or   inLineStyle=DashDot
          or   inLineStyle=DashDotDot
          or   inLineStyle=Dot
          or   inLineStyle=Reset
          or   inLineStyle=Double ;
          else;
          message('':
                 'LineStyle="'+ inlinestyle
                               +' is incorrect, possible values are ' +
             Reset                     +', '+
             Continuous                +', '+
             Dash                      +', '+
             DashDot                   +', '+
             DashDotDot                +', '+
             Dot                       +', '+
             Double                    +'"');
               dumpcallstack();
             diagemis=true;
                           return;
                                  endif;


        endif;
        if %parms >= 8;

        if 0<=  inweight and  inweight <=3;
        else;
        message('':
        'Weight="'+%char( inweight)+' is incorrect, possible values are '+
           '1 to 3"');
               dumpcallstack();
             diagemis=true;
                           return;
                                  endif;


        endif;





        for r = uprow to downrow;
        for c = leftcol to rightcol;
        sty = getstyle(r:c);
          if %parms >=8; // borders have to be set

          // set all borders to InLineStyle
             sty.border(1).position=bottom;
             sty.border(1).IsNotNull=inlinestyle<>reset;
             sty.border(1).linestyle=inlinestyle;
             sty.border(1).weight   =inweight   ;
             sty.border(4).position=Left  ;
             sty.border(4).IsNotNull=inlinestyle<>reset;
             sty.border(4).linestyle=inlinestyle;
             sty.border(4).weight   =inweight   ;
             sty.border(5).position=Right ;
             sty.border(5).IsNotNull=inlinestyle<>reset;
             sty.border(5).linestyle=inlinestyle;
             sty.border(5).weight   =inweight   ;
             sty.border(6).position=Top ;
             sty.border(6).IsNotNull=inlinestyle<>reset;
             sty.border(6).linestyle=inlinestyle;
             sty.border(6).weight   =inweight   ;

          endif;
          // set outline when apply
          if r = uprow; // top border
             sty.border(6).position=top;
             sty.border(6).IsNotNull=outlinestyle<>reset;
             sty.border(6).linestyle=outlinestyle;
             sty.border(6).weight   =outweight   ;
          endif;
          if r = downrow;
             sty.border(1).position=bottom;
             sty.border(1).IsNotNull=outlinestyle<>reset;
             sty.border(1).linestyle=outlinestyle;
             sty.border(1).weight   =outweight   ;
          endif;
          if c = leftcol ;
             sty.border(4).position=Left  ;
             sty.border(4).IsNotNull=outlinestyle<>reset;
             sty.border(4).linestyle=outlinestyle;
             sty.border(4).weight   =outweight   ;
          endif;
          if c = rightcol ;
             sty.border(5).position=Right;
             sty.border(5).IsNotNull=outlinestyle<>reset;
             sty.border(5).linestyle=outlinestyle;
             sty.border(5).weight   =outweight   ;
          endif;
        if sty.border(1).IsNotNull or
           sty.border(2).IsNotNull or
           sty.border(3).IsNotNull or
           sty.border(4).IsNotNull or
           sty.border(5).IsNotNull or
           sty.border(6).IsNotNull ;
           sty.hasborders=true;
        else;
           sty.hasborders=false;
        endif;
       setstyle(r:c:sty);
       endfor;
       endfor;


       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e


BPR  p InzStyle        b
     d                 PI
     d    p1                               like(x_style)             const
      /free
       style=p1;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e



BPR  p NewStyle        b
     d                 PI                  likeds(style)
     d rtndta          ds                  likeds(style   ) static
      /free
       clear rtndta;
       rtndta.IsNotNull=false;
       rtndta.iBorder=1;
       return rtndta;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p x_Style         b
     d x_Style         PI                  likeds(style)
     d   clearStyle                    n           options(*nopass) const
     d rtndta          s                   like(x_style   ) static
    ? * for building the style tag
    ? * return data
      /free
       rtndta=style;

B01    if %parms() > 0;
B02       if clearstyle;
             style=newstyle();
X02       else;
             clear style.id ;
E02       endif;
X01    else;
          style=newstyle();
E01    endif;
       return rtndta;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /else                                                                     < xlxml4
BPR  p x_Style         b
     d x_Style         PI            30    varying
     d   clearStyle                    n           options(*nopass) const
    ? * for building the style tag
    ? * return data
     d RtnDta          s                   like(tag) static
      /free
       pinFrame=%addr(xml.Styles);
       tag = '<Style';
B01    if style.StyleNo =''; //ID non fourni, le calculer
             style.StyleNo = 'S' +%char(styles.StyleCount);
          styles.StyleCount+=1;
E01    endif;
       RtnDta=style.StyleNo;
       tag+=' ss:ID="'+style.StyleNo+'"';
B01    if style.StyleName<>''; // NAME fourni, ajouter
             tag+=' '+style.StyleName;
E01    endif;
B01    if style.Parent<>'';
          tag+=' '+style.Parent;
E01    endif;
       tag+='>';
       x_write(tag);
B01    if %len( style.Alignment ) > 0;
          x_write(style.Alignment );
E01    endif;
B01    if %len( style.Borders ) > 0;
          x_write(style.Borders );
E01    endif;
B01    if %len( style.font ) > 0;
          x_write(style.font );
E01    endif;
B01    if %len( style.interior ) > 0;
          x_write(style.interior );
E01    endif;
B01    if %len( style.NumberFormat) > 0;
          x_write(style.NumberFormat);
E01    endif;
B01    if %len( style.Protection ) > 0;
          x_write(style.Protection );
E01    endif;
       x_write('</Style>');
B01    if %parms() > 0;
B02       if clearstyle;
             clear style;
X02       else;
             clear style.StyleNo;
E02       endif;
X01    else;
          clear style;
E01    endif;
       return RtnDta;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif                                                                    < xlxml4
      /endif                                                                    procedure

      /if defined(xlxml4)                                                       xlxml4
      /if defined(DATA_SECTION)
     d ID              pr
     d p1                                  like(tag)                  const
     d SName           pr
     d p1                                  like(tag)                  const
     d Parent          pr
     d p1                                  like(tag)                  const
     d Alignment       pr
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
     d   Vertical      pr                  like(tag)
     d   p                                 like(tag) options(*nopass) const
     d   Horizontal    pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
     d   WrapText      pr                  like(tag)
     d   p1                            n             options(*nopass) const
     d   Rotate        pr                  like(tag)
     d   p1                          10i 0           options(*nopass) const
     d   Borders       pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d     Border      pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
     d     p4                              like(tag) options(*nopass) const
     d       Position  pr                  like(tag)
     d       p1                            like(tag) options(*nopass) const
     d       LineStyle...
     d                 Pr                  like(tag)
     d       p1                            like(tag) options(*nopass) const
     d       Weight    pr                  like(tag)
     d       p1                      10u 0         options(*nopass) const
     d   font          pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d   p7                                like(tag) options(*nopass) const
     d   p8                                like(tag) options(*nopass) const
     d     FontName    pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     Family      pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     Bold        pr                  like(tag)
     d     p1                          n           options(*nopass) const
     d     Size        pr                  like(tag)
     d     p1                        10u 0         options(*nopass) const
     d     Italic      pr                  like(tag)
     d     p1                          n           options(*nopass) const
     d     Underline   pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     StrikeThrough...
     d                 pr                  like(tag)
     d     p1                          n           options(*nopass) const
     d     VerticalAlign...
     d                 pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d   Interior      pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d     Color       pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     Pattern     pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d   NumberFormat  pr
     d   p1                                like(tag) options(*nopass) const
     d   Protection    pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d    SProtected   pr                  like(tag)
     d     p1                          n           options(*nopass) const
     d     HideFormula...
     d                 pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p ID              b
     d ID              PI
     d p1                                  like(tag)                  const
      /free
       style.IsNotNull=True;
       style.id = p1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p SName           b
     d SName           PI
     d p1                                  like(tag)                  const
      /free
       style.IsNotNull=True;
       style.SName=p1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p Parent          b
     d Parent          PI
     d p1                                  like(tag)                  const
      /free
       style.IsNotNull=True;
       style.Parent =p1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p Alignment       b
     d Alignment       PI
     d p1                                  like(tag) options(*nopass) const
     d p2                                  like(tag) options(*nopass) const
     d p3                                  like(tag) options(*nopass) const
     d p4                                  like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       style.IsNotNull=True;
       style.alignment.IsNotNull=True;
B01    select;
X01       when %parms = 1;
             msgdta= p1;
X01       when %parms = 2;
             msgdta= p1+p2;
X01       when %parms = 3;
             msgdta= p1+p2+p3;
X01       when %parms = 4;
             msgdta= p1+p2+p3+p4;
             //? when %parms  = 5;
             //? msgdta= p1+p2+p3+p4+p5;
             //? when %parms  = 6;
             //? msgdta= p1+p2+p3+p4+p5+p6;
             //? when %parms  = 7;
             //? msgdta= p1+p2+p3+p4+p5+p6+p7;
             //? when %parms  = 8;
             //? msgdta= p1+p2+p3+p4+p5+p6+P7+p8;
X01       other;
             msgdta='';
E01    endsl;
B01    if %len(msgdta)>0;
          message('':msgdta);
          dumpcallstack();
          diagemis=true;
E01    endif;




B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Vertical      b
     d   Vertical      PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
       style.alignment.vertical='';
B01    if %parms >=1;
B02       if
B02             p1=justify
X..          or p1=center
X..          or p1=bottom
X..          or p1=top ;
             style.alignment.vertical=p1 ;
             return '';
X02       else;
             return ' ss:Vertical="'+p1+' is incorrect, possible values are ' +
                top+', '+
                justify+', '+
                center+', '+
                bottom+'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Horizontal    b
     d   Horizontal    PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
       style.alignment.horizontal='';
B01    if %parms >=1;
B02       if p1=left
X..          or p1=center
X..          or p1=right ;
             style.alignment.horizontal=p1;
             return '';
X02       else;
            return ' ss:Horizontal="'+p1+' is incorrect, possible values are ' +
                left   +', '+
                center +', '+
                right  +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   WrapText      b
     d   WrapText      PI                  like(tag)
     d   p1                            n             options(*nopass) const
      /free
B01    if %parms >=1 ;
          style.alignment.wraptext= p1 ;
X01    else ;
          style.alignment.wraptext=true ;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Rotate        b
     d   Rotate        PI                  like(tag)
     d   p1                          10i 0           options(*nopass) const
      /free
B01    if %parms >=1 ;
          style.alignment.rotate = p1 ;
X01    else ;
          style.alignment.rotate =0 ;
E01    endif;
       return '';


B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Borders       b
     d   Borders       PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       style.IsNotNull=True;
       style.hasborders=True;
B01    select;
X01       when %parms = 1;
             msgdta= p1;
X01       when %parms = 2;
             msgdta= p1+p2;
X01       when %parms = 3;
             msgdta= p1+p2+p3;
X01       when %parms = 4;
             msgdta= p1+p2+p3+p4;
X01       when %parms = 5;
             msgdta= p1+p2+p3+p4+p5;
X01       when %parms = 6;
             msgdta= p1+p2+p3+p4+p5+p6;
             //? when %parms  = 7;
             //? msgdta= p1+p2+p3+p4+p5+p6+p7;
             //? when %parms  = 8;
             //? msgdta= p1+p2+p3+p4+p5+p6+P7+p8;
X01       other;
             msgdta='';
E01    endsl;
B01    if %len(msgdta)>0;
          message('':msgdta);
          dumpcallstack();
          diagemis=true;
E01    endif;




B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Border      b
     d     Border      PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
     d     p4                              like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       select;
X00    when %parms = 1;
       msgdta= p1;
X00    when %parms = 2;
       msgdta= p1+p2;
X00    when %parms = 3;
       msgdta= p1+p2+p3;
X00    when %parms = 4;
       msgdta= p1+p2+p3+p4;
       //? when %parms  = 5;
       //? msgdta= p1+p2+p3+p4+p5;
       //? when %parms  = 6;
       //? msgdta= p1+p2+p3+p4+p5+p6;
       //? when %parms  = 7;
       //? msgdta= p1+p2+p3+p4+p5+p6+p7;
       //? when %parms  = 8;
       //? msgdta= p1+p2+p3+p4+p5+p6+P7+p8;
X00    other;
       msgdta='';
E00    endsl;





       return msgdta;



B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p       Position  b
     d       Position  PI                  like(tag)
     d       p1                            like(tag) options(*nopass) const
     d rtndta          s                   like(tag) static
      /free
       rtndta='';
       style.iBorder=1;
B01    if %parms >=1;
B02    select;
X02       when p1=Bottom ;
             style.iBorder=1;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;
X02       when p1=DiagonalLeft ;
             style.iBorder=2;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;
X02       when p1=DiagonalRight ;
             style.iBorder=3;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;
X02       when p1=Left ;
             style.iBorder=4;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;
X02       when p1=Right ;
             style.iBorder=5;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;
X02       when p1=Top ;
             style.iBorder=6;
             style.border(style.iborder).position=p1;
             style.border(style.iborder).IsNotNull=True;

X02       other;
           rtndta=   ' ss:Position="'+p1+' is incorrect, possible values are ' +
                Bottom                    +', '+
                DiagonalLeft              +', '+
                DiagonalRight             +', '+
                Left                      +', '+
                Right                     +', '+
                Top                       +'"';
E02    endsl;
E01    endif;
       return rtndta;
E01
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
     p       LineStyle...
BPR  p                 b
     d       LineStyle...
     d                 PI                  like(tag)
     d       p1                            like(tag) options(*nopass) const
      /free
       style.border(style.iborder).linestyle='';
B01    if %parms >=1;
B02    if p1=Continuous
X..       or p1=Dash
X..       or p1=DashDot
X..       or p1=DashDotDot
X..       or p1=Dot
X..       or p1=Double ;
          style.border(style.iborder).linestyle=p1;
          return '';
X02    else;
          return ' ss:LineStyle="'+p1+' is incorrect, possible values are ' +
             Continuous                +', '+
             Dash                      +', '+
             DashDot                   +', '+
             DashDotDot                +', '+
             Dot                       +', '+
             Double                    +'"';
E02    endif;
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p       Weight    b
     d       Weight    PI                  like(tag)
     d       p1                      10u 0         options(*nopass) const
      /free
       style.border(style.iborder).weight=0 ;
B01    if %parms >=1;
B02    if 1<= p1 and p1 <= 3;
          style.border(style.iborder).weight=p1 ;
          return '';
X02    else;
          return ' ss:Weight="'+%char(p1)+' is incorrect, possible values are '+
             '1 to 3"';
E02    endif;
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   font          b
     d   font          PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d   p7                                like(tag) options(*nopass) const
     d   p8                                like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       style.IsNotNull=True;
       style.font.IsNotNull=True;
B01    select;
X01    when %parms = 1;
          msgdta= p1;
X01    when %parms = 2;
          msgdta= p1+p2;
X01    when %parms = 3;
          msgdta= p1+p2+p3;
X01    when %parms = 4;
          msgdta= p1+p2+p3+p4;
X01    when %parms = 5;
          msgdta= p1+p2+p3+p4+p5;
X01    when %parms = 6;
          msgdta= p1+p2+p3+p4+p5+p6;
X01    when %parms = 7;
          msgdta= p1+p2+p3+p4+p5+p6+p7;
X01    when %parms = 8;
          msgdta= p1+p2+p3+p4+p5+p6+P7+p8;
X01    other;
          msgdta='';
E01    endsl;
B01    if %len(msgdta)>0;
       message('':msgdta);
       dumpcallstack();
       diagemis=true;
E01    endif;




B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     FontName    b
     d     FontName    PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.font.name='';
B01    if %parms >=1;
       style.font.name=encode(p1) ;
       return '';
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Family      b
     d     Family      PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.font.family='';
B01    if %parms >=1;
       style.font.family=encode(p1);
       return '';
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Bold        b
     d     Bold        PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
       style.font.bold=p1 ;
X01    else ;
       style.font.bold=true;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Size        b
     d     Size        PI                  like(tag)
     d     p1                        10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
       style.font.size=p1;
X01    else;
       style.font.size=0;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Italic      b
     d     Italic      PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
       style.font.italic=p1;
X01    else ;
       style.font.italic=true;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Underline   b
     d     Underline   PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.font.Underline='';
B01    if %parms >=1;
B02    if p1=Single
X..       or p1=Double
X..       or p1=SingleAccounting
X..       or p1=DoubleAccounting ;
          style.font.Underline=p1;
          return '';
X02    else;
          return ' ss:Underline="'+p1+' is incorrect, possible values are ' +
             Single                   +', '+
             Double                   +', '+
             SingleAccounting         +', '+
             DoubleAccounting         +'"';
E02    endif;
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
     p     StrikeThrough...
BPR  p                 b
     d     StrikeThrough...
     d                 PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
       style.font.strikethrough=p1;
X01    else ;
       style.font.strikethrough=true;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
     p     VerticalAlign...
BPR  p                 b
     d     VerticalAlign...
     d                 PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.font.verticalalign='';
B01    if %parms >=1;
B02    if p1=Superscript
X..       or p1=Subscript ;
          style.font.verticalalign=p1;
          return '';
X02    else;
         return ' ss:VerticalAlign="'+p1+' is incorrect, possible values are ' +
             Superscript             +', '+
             Subscript               +'"';
E02    endif;
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Interior      b
     d   Interior      PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       style.IsNotNull=True;
       style.interior.IsNotNull=True;
B01    select;
X01    when %parms = 1;
          msgdta= p1;
X01    when %parms = 2;
          msgdta= p1+p2;
          //? when %parms  = 3;
          //? msgdta= p1+p2+p3;
          //? when %parms  = 4;
          //? msgdta= p1+p2+p3+p4;
          //? when %parms  = 5;
          //? msgdta= p1+p2+p3+p4+p5;
          //? when %parms  = 6;
          //? msgdta= p1+p2+p3+p4+p5+p6;
          //? when %parms  = 7;
          //? msgdta= p1+p2+p3+p4+p5+p6+p7;
          //? when %parms  = 8;
          //? msgdta= p1+p2+p3+p4+p5+p6+P7+p8;
X01    other;
          msgdta='';
E01    endsl;
B01    if %len(msgdta)>0;
       message('':msgdta);
       dumpcallstack();
       diagemis=true;
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Color       b
     d     Color       PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.interior.color='';
B01    if %parms >=1;
B02    if p1 =black
X..       or p1 = navy
X..       or p1 = blue
X..       or p1 = darkgreen
X..       or p1 = darkblue
X..       or p1 = mediumblue
X..       or p1 = forestgreen
X..       or p1 = darkseagreen
X..       or p1 = darkcyan
X..       or p1 = green
X..       or p1 = cyan
X..       or p1 = maroon
X..       or p1 = darkgrey
X..       or p1 = lightnavy
X..       or p1 = lightblue
X..       or p1 = seagreen
X..       or p1 = lightcyan
X..       or p1 = violet
X..       or p1 = blueviolet
X..       or p1 = darkred
X..       or p1 = purple
X..       or p1 = khaki
X..       or p1 = grey
X..       or p1 = lightgrey
X..       or p1 = firebrick
X..       or p1 = orchid
X..       or p1 = lightblueviolet
X..       or p1 = greenyellow
X..       or p1 = skyblue
X..       or p1 = azuregrey
X..       or p1 = lightpurple
X..       or p1 = thistle
X..       or p1 = gainsboro
X..       or p1 = azure
X..       or p1 = red
X..       or p1 = magenta
X..       or p1 = orange
X..       or p1 = salmon
X..       or p1 = oldgold
X..       or p1 = pink
X..       or p1 = gold
X..       or p1 = wheat
X..       or p1 = yellow
X..       or p1 = cornsilk
X..       or p1 = snow
X..       or p1 = white ;
          style.interior.color=p1;
          return '';
X02    else;
          tag=   ' ss:Color="'+p1+' is incorrect, possible values are ' +
             'black'                 +', '+
             'navy'                  +', '+
             'blue'                  +', '+
             'darkgreen'             +', '+
             'darkblue'              +', '+
             'mediumblue'            +', '+
             'forestgreen'           +', '+
             'darkseagreen'          +', '+
             'darkcyan'              +', '+
             'green'                 +', '+
             'cyan'                  +', '+
             'maroon'                +', '+
             'darkgrey'              +', '+
             'lightnavy'             +', '+
             'lightblue'             +', '+
             'seagreen'              +', '+
             'lightcyan'             +', '+
             'violet'                +', '+
             'blueviolet'            +', '+
             'darkred'               +', '+
             'purple'                +', '+
             'khaki'                 +', '+
             'grey'                  +', '+
             'lightgrey'             +', '+
             'firebrick'             +', '+
             'orchid'                +', '+
             'lightblueviolet'       +', '+
             'greenyellow'           +', '+
             'skyblue'               +', '+
             'azuregrey'             +', '+
             'lightpurple'           +', '+
             'thistle'               +', '+
             'gainsboro'             +', '+
             'azure'                 +', '+
             'red'                   +', '+
             'magenta'               +', '+
             'orange'                +', '+
             'salmon'                +', '+
             'oldgold'               +', '+
             'pink'                  +', '+
             'gold'                  +', '+
             'wheat'                 +', '+
             'yellow'                +', '+
             'cornsilk'              +', '+
             'snow'                  +', '+
             'white'                      ;
          %len(tag) = 200;
          tag+='..."';
          return tag;
E02    endif;
X01    else;
       return '';
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p     Pattern     b
     d     Pattern     PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       style.interior.pattern='';
B01    if %parms >=1;
B02    if p1= DiagCross
X..       or p1= DiagStripe
X..       or p1= Gray0625
X..       or p1= Gray125
X..       or p1= Gray25
X..       or p1= Gray50
X..       or p1= Gray75
X..       or p1= HorzStripe
X..       or p1= ReverseDiagStripe
X..       or p1= Solid
X..       or p1= ThickDiagCross
X..       or p1= ThinDiagCross
X..       or p1= ThinDiagStripe
X..       or p1= ThinHorzCross
X..       or p1= ThinHorzStripe
X..       or p1= ThinReverseDiagStripe
X..       or p1= ThinVertStripe
X..       or p1= VertStripe
             ;
          style.interior.pattern=p1;
          return '';
X02    else;
          return ' ss:Pattern="'+p1+' is incorrect, possible values are ' +
             DiagCross                +', '+
             DiagStripe               +', '+
             Gray0625                 +', '+
             Gray125                  +', '+
             Gray25                   +', '+
             Gray50                   +', '+
             Gray75                   +', '+
             HorzStripe               +', '+
             ReverseDiagStripe        +', '+
             Solid                    +', '+
             ThickDiagCross           +', '+
             ThinDiagCross            +', '+
             ThinDiagStripe           +', '+
             ThinHorzCross            +', '+
             ThinHorzStripe           +', '+
             ThinReverseDiagStripe    +', '+
             ThinVertStripe           +', '+
             VertStripe               +'"';
E02    endif;
X01    else;
       return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   NumberFormat  b
     d   NumberFormat  PI
     d   p1                                like(tag) options(*nopass) const
      /free
       style.IsNotNull=True;
       style.numberformat='';

B01    if %parms >= 1;
       style.numberformat=p1;
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p   Protection    b
     d   Protection    PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   msgdta        s                   like(tag)
      /free
       style.IsNotNull=True;
       style.protection.IsNotNull=True;
B01    select;
X01    when %parms = 1;
E01       msgdta= p1;
X01    when %parms = 2;
          msgdta= p1+p2;
          //? when %parms  = 3;
          //? msgdta= p1+p2+p3;
          //? when %parms  = 4;
          //? msgdta= p1+p2+p3+p4;
          //? when %parms  = 5;
          //? msgdta= p1+p2+p3+p4+p5;
          //? when %parms  = 6;
          //? msgdta= p1+p2+p3+p4+p5+p6;
          //? when %parms  = 7;
          //? msgdta= p1+p2+p3+p4+p5+p6+p7;
          //? when %parms  = 8;
          //? msgdta= p1+p2+p3+p4+p5+p6+p7+p8;
X01    other;
          msgdta='';
E01    endsl;
B01    if %len(msgdta)>0;
       message('':msgdta);
       dumpcallstack();
       diagemis=true;
E01    endif;




B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p    SProtected   b
     d    SProtected   PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free

B01    if %parms >=1 ;
       style.protection.protected=p1;
X01    else ;
       style.protection.protected=true;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
     p     HideFormula...
BPR  p                 b
     d     HideFormula...
     d                 PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
       style.protection.hideformula=p1;
X01    else ;
       style.protection.hideformula=true;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /else                                                                     < xlxml4


      /if defined(DATA_SECTION)
     d ID              pr
     d p1                                  like(tag)                  const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p ID              b
     d ID              PI
     d p1                                  like(tag)                  const
      /free
       style.StyleNo = p1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d SName           pr
     d p1                                  like(tag)                  const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p SName           b
     d SName           PI
     d p1                                  like(tag)                  const
      /free
       style.StyleName=p1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Parent          pr
     d p1                                  like(tag)                  const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Parent          b
     d Parent          PI
     d p1                                  like(tag)                  const
      /free
       style.Parent =' Parent="' +p1+'"';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Alignment       pr
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
     d p                                   like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Alignment       b
     d Alignment       PI
     d p1                                  like(tag) options(*nopass) const
     d p2                                  like(tag) options(*nopass) const
     d p3                                  like(tag) options(*nopass) const
     d p4                                  like(tag) options(*nopass) const
      /free
       tag='<Alignment ';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
B01    if %parms >= 3;
          tag+=p3;
E01    endif;
B01    if %parms >= 4;
          tag+=p4;
E01    endif;
       tag+='/>';
       style.Alignment=tag;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Vertical      pr                  like(tag)
     d   p                                 like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Vertical      b
     d   Vertical      PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=justify
X..          or p1=center
X..          or p1=bottom
X..          or p1=top   ;
             return ' ss:Vertical="'+p1+'"';
X02       else;
             return ' ss:Vertical="'+p1+' is incorrect, possible values are ' +
                top+', '+
                justify+', '+
                center+', '+
                bottom+'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Horizontal    pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Horizontal    b
     d   Horizontal    PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=left
X..          or p1=center
X..          or p1=right ;
             return ' ss:Horizontal="'+p1+'"';
X02       else;
            return ' ss:Horizontal="'+p1+' is incorrect, possible values are ' +
                left   +', '+
                center +', '+
                right  +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   WrapText      pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   WrapText      b
     d   WrapText      PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1 ;
       return ' ss:WrapText ="'+ZerOne(p1)+'"';
X01    else ;
       return ' ss:WrapText ="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Rotate        pr                  like(tag)
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   Rotate        b
     d   Rotate        PI                  like(tag)
     d   p1                          10u 0           options(*nopass) const
      /free
       return ' ss:Rotate ="'+%char(p1)+'"';
       BEGSR *pssr;
       DUMP ;
       ENDSR ;
      /end-free
     p                 e
      /endif

      /if defined(DATA_SECTION)
     d   Borders       pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Borders       b
     d   Borders       PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
      /free
       tag='<Borders>';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
B01    if %parms >= 3;
          tag+=p3;
E01    endif;
B01    if %parms >= 4;
          tag+=p4;
E01    endif;
B01    if %parms >= 5;
          tag+=p5;
E01    endif;
B01    if %parms >= 6;
          tag+=p6;
E01    endif;
       tag+='</Borders>';
       style.borders=tag;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Border      pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
     d     p4                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Border      b
     d     Border      PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
     d     p4                              like(tag) options(*nopass) const
      /free
       tag='<Border ';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
B01    if %parms >= 3;
          tag+=p3;
E01    endif;
B01    if %parms >= 4;
          tag+=p4;
E01    endif;
       tag+='/>';
       return tag;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d       Position  pr                  like(tag)
     d       p1                            like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p       Position  b
     d       Position  PI                  like(tag)
     d       p1                            like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=Bottom
X..          or p1=DiagonalLeft
X..          or p1=DiagonalRight
X..          or p1=Left
X..          or p1=Right
X..          or p1=Top ;
             return ' ss:Position="'+p1+'"';
X02       else;
             return ' ss:Position="'+p1+' is incorrect, possible values are ' +
                Bottom                    +', '+
                DiagonalLeft              +', '+
                DiagonalRight             +', '+
                Left                      +', '+
                Right                     +', '+
                Top                       +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d       LineStyle...
     d                 Pr                  like(tag)
     d       p1                            like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p       LineStyle...
BPR  p                 b
     d       LineStyle...
     d                 PI                  like(tag)
     d       p1                            like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=Continuous
X..          or p1=Dash
X..          or p1=DashDot
X..          or p1=DashDotDot
X..          or p1=Dot
X..          or p1=Double ;
             return ' ss:LineStyle="'+p1+'"';
X02       else;
             return ' ss:LineStyle="'+p1+' is incorrect, possible values are ' +
                Continuous                +', '+
                Dash                      +', '+
                DashDot                   +', '+
                DashDotDot                +', '+
                Dot                       +', '+
                Double                    +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d       Weight    pr                  like(tag)
     d       p1                      10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p       Weight    b
     d       Weight    PI                  like(tag)
     d       p1                      10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
B02       if 1<= p1 and p1 <= 3;
             return ' ss:Weight="'+%char(p1)+'"';
X02       else;
          return ' ss:Weight="'+%char(p1)+' is incorrect, possible values are '+
                '1 to 3"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   font          pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d   p7                                like(tag) options(*nopass) const
     d   p8                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   font          b
     d   font          PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
     d   p5                                like(tag) options(*nopass) const
     d   p6                                like(tag) options(*nopass) const
     d   p7                                like(tag) options(*nopass) const
     d   p8                                like(tag) options(*nopass) const
      /free
       tag='<Font ';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
B01    if %parms >= 3;
          tag+=p3;
E01    endif;
B01    if %parms >= 4;
          tag+=p4;
E01    endif;
B01    if %parms >= 5;
          tag+=p5;
E01    endif;
B01    if %parms >= 6;
          tag+=p6;
E01    endif;
B01    if %parms >= 7;
          tag+=p7;
E01    endif;
B01    if %parms >= 8;
          tag+=p8;
E01    endif;
       tag+='/>';
       style.font=tag;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     FontName    pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     FontName    b
     d     FontName    PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          return ' ss:FontName="'+encode(p1)+'"';
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Family      pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Family      b
     d     Family      PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          return ' x:Family="'+encode(p1)+'"';
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Bold        pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Bold        b
     d     Bold        PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          return ' ss:Bold="'+ZerOne(p1)+'"';
X01    else ;
          return ' ss:Bold="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Size        pr                  like(tag)
     d     p1                        10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Size        b
     d     Size        PI                  like(tag)
     d     p1                        10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          return ' ss:Size="'+%char(p1)+'"';
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Italic      pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Italic      b
     d     Italic      PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          return ' ss:Italic="'+ZerOne(p1)+'"';
X01    else ;
          return ' ss:Italic="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Underline   pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Underline   b
     d     Underline   PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=Single
X..          or p1=Double
X..          or p1=SingleAccounting
X..          or p1=DoubleAccounting ;
             return ' ss:Underline="'+p1+'"';
X02       else;
             return ' ss:Underline="'+p1+' is incorrect, possible values are ' +
                Single                   +', '+
                Double                   +', '+
                SingleAccounting         +', '+
                DoubleAccounting         +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     StrikeThrough...
     d                 pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     StrikeThrough...
BPR  p                 b
     d     StrikeThrough...
     d                 PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          return ' ss:StrikeThrough="'+ZerOne(p1)+'"';
X01    else ;
          return ' ss:StrikeThrough="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     VerticalAlign...
     d                 pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     VerticalAlign...
BPR  p                 b
     d     VerticalAlign...
     d                 PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=Superscript
X..          or p1=Subscript ;
             return ' ss:VerticalAlign="'+p1+'"';
X02       else;
         return ' ss:VerticalAlign="'+p1+' is incorrect, possible values are ' +
                Superscript             +', '+
                Subscript               +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Interior      pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Interior      b
     d   Interior      PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
      /free
       tag='<Interior';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
       tag+='/>';
       style.interior=tag;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Color       pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Color       b
     d     Color       PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1 =black
X..          or p1 = navy
X..          or p1 = blue
X..          or p1 = darkgreen
X..          or p1 = darkblue
X..          or p1 = mediumblue
X..          or p1 = forestgreen
X..          or p1 = darkseagreen
X..          or p1 = darkcyan
X..          or p1 = green
X..          or p1 = cyan
X..          or p1 = maroon
X..          or p1 = darkgrey
X..          or p1 = lightnavy
X..          or p1 = lightblue
X..          or p1 = seagreen
X..          or p1 = lightcyan
X..          or p1 = violet
X..          or p1 = blueviolet
X..          or p1 = darkred
X..          or p1 = purple
X..          or p1 = khaki
X..          or p1 = grey
X..          or p1 = lightgrey
X..          or p1 = firebrick
X..          or p1 = orchid
X..          or p1 = lightblueviolet
X..          or p1 = greenyellow
X..          or p1 = skyblue
X..          or p1 = azuregrey
X..          or p1 = lightpurple
X..          or p1 = thistle
X..          or p1 = gainsboro
X..          or p1 = azure
X..          or p1 = red
X..          or p1 = magenta
X..          or p1 = orange
X..          or p1 = salmon
X..          or p1 = oldgold
X..          or p1 = pink
X..          or p1 = gold
X..          or p1 = wheat
X..          or p1 = yellow
X..          or p1 = cornsilk
X..          or p1 = snow
X..          or p1 = white ;
             return ' ss:Color="'+p1+'"';
X02       else;
             tag=   ' ss:Color="'+p1+' is incorrect, possible values are ' +
                'black'                 +', '+
                'navy'                  +', '+
                'blue'                  +', '+
                'darkgreen'             +', '+
                'darkblue'              +', '+
                'mediumblue'            +', '+
                'forestgreen'           +', '+
                'darkseagreen'          +', '+
                'darkcyan'              +', '+
                'green'                 +', '+
                'cyan'                  +', '+
                'maroon'                +', '+
                'darkgrey'              +', '+
                'lightnavy'             +', '+
                'lightblue'             +', '+
                'seagreen'              +', '+
                'lightcyan'             +', '+
                'violet'                +', '+
                'blueviolet'            +', '+
                'darkred'               +', '+
                'purple'                +', '+
                'khaki'                 +', '+
                'grey'                  +', '+
                'lightgrey'             +', '+
                'firebrick'             +', '+
                'orchid'                +', '+
                'lightblueviolet'       +', '+
                'greenyellow'           +', '+
                'skyblue'               +', '+
                'azuregrey'             +', '+
                'lightpurple'           +', '+
                'thistle'               +', '+
                'gainsboro'             +', '+
                'azure'                 +', '+
                'red'                   +', '+
                'magenta'               +', '+
                'orange'                +', '+
                'salmon'                +', '+
                'oldgold'               +', '+
                'pink'                  +', '+
                'gold'                  +', '+
                'wheat'                 +', '+
                'yellow'                +', '+
                'cornsilk'              +', '+
                'snow'                  +', '+
                'white'                      ;
             %len(tag) = 200;
             tag+='..."';
             return tag;
E02       endif;
X01    else;
          return '';
E01    endif;
       return 'OK';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Pattern     pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Pattern     b
     d     Pattern     PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1= DiagCross
X..          or p1= DiagStripe
X..          or p1= Gray0625
X..          or p1= Gray125
X..          or p1= Gray25
X..          or p1= Gray50
X..          or p1= Gray75
X..          or p1= HorzStripe
X..          or p1= ReverseDiagStripe
X..          or p1= Solid
X..          or p1= ThickDiagCross
X..          or p1= ThinDiagCross
X..          or p1= ThinDiagStripe
X..          or p1= ThinHorzCross
X..          or p1= ThinHorzStripe
X..          or p1= ThinReverseDiagStripe
X..          or p1= ThinVertStripe
X..          or p1= VertStripe
                ;
             return ' ss:Pattern="'+p1+'"';
X02       else;
             return ' ss:Pattern="'+p1+' is incorrect, possible values are ' +
                DiagCross                +', '+
                DiagStripe               +', '+
                Gray0625                 +', '+
                Gray125                  +', '+
                Gray25                   +', '+
                Gray50                   +', '+
                Gray75                   +', '+
                HorzStripe               +', '+
                ReverseDiagStripe        +', '+
                Solid                    +', '+
                ThickDiagCross           +', '+
                ThinDiagCross            +', '+
                ThinDiagStripe           +', '+
                ThinHorzCross            +', '+
                ThinHorzStripe           +', '+
                ThinReverseDiagStripe    +', '+
                ThinVertStripe           +', '+
                VertStripe               +'"';
E02       endif;
X01    else;
          return '';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   NumberFormat  pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   NumberFormat  b
     d   NumberFormat  PI
     d   p1                                like(tag) options(*nopass) const
      /free
       tag='<NumberFormat ';
B01    if %parms >= 1;
          tag+=' ss:Format="'+encode(p1)+'"';
E01    endif;
       tag+='/>';
       style.NumberFormat=tag;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Protection    pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Protection    b
     d   Protection    PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
      /free
       tag='<ss:Protection';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
       tag+='/>';
       style.protection=tag;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d    SProtected   pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p    SProtected   b
     d    SProtected   PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          return ' ss:Protected="'+ZerOne(p1)+'"';
X01    else ;
          return ' ss:Protected="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     HideFormula...
     d                 pr                  like(tag)
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     HideFormula...
BPR  p                 b
     d     HideFormula...
     d                 PI                  like(tag)
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          return ' ss:HideFormula="'+ZerOne(p1)+'"';
X01    else ;
          return ' ss:HideFormula="1"';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif
      /if defined(DATA_SECTION)
    ?d*Names           ds                  qualified
     d NamedRange      ds                  qualified
     d   RName                             like(tag)
     d   RefersTo                          like(tag)
     d x_NamedRange    pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_NamedRange    b
     d x_NamedRange    PI
      /free
       pinFrame=%addr(xml.Names);
       tag='<NamedRange';
       tag+=NamedRange.RName;
       tag+=NamedRange.Refersto;
       tag+='/>';
       x_write(tag);
       clear namedrange;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d RName           pr
     d p1                                  like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p RName           b
     d RName           PI
     d p1                                  like(tag) options(*nopass) const
      /free
B01    if %parms >=1 ;
          namedrange.rname=' ss:Name="'+encode(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   RefersTo      pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   RefersTo      b
     d   RefersTo      PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1 ;
          namedrange.refersto=' RefersTo="'+encode(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
    ?d*Worksheets      ds                  qualified
     d Worksheet       ds                  qualified
     d wname                               like(tag)
     d protected                           like(tag)
     d x_OpenWorksheet...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_OpenWorksheet...
BPR  p                 b
     d x_OpenWorksheet...
     d                 PI
      /free
B01    if xlxml.SheetIsOpen;
          x_closeWorkSheet();
E01    endif;
       xml.Worksheet=newFrame(xml.Worksheets);
       pinFrame=%addr(xml.Worksheet);
       tag='<Worksheet ';
       tag+=Worksheet.Wname;
       tag+=Worksheet.Protected;
       tag+='>';
       x_write(tag);
       clear worksheet;
       xml.Worksheetoptions =newFrame(xml.Worksheet);
       xml.Table =newFrame(xml.Worksheet);
       xml.ConditionalFormatting=newFrame(xml.Worksheet);
       x_OpenConditionalFormatting();
       xlxml.sheetisopen=*on;
       clear xlxml.colsize;
       //?for ifor = 1 to 256;
       //?  xlxml.colsize(iFor) = 0;
       //?endfor;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WName           pr
     d p1                                  like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p WName           b
     d WName           PI
     d p1                                  like(tag) options(*nopass) const
      /free
B01    if %parms >=1 ;
          worksheet.wname=' ss:Name="'+encode(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d wProtected      pr
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p wProtected      b
     d wProtected      PI
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          worksheet.protected= ' ss:Protected="'+ZerOne(p1)+'"';
X01    else ;
          worksheet.protected= ' ss:Protected="1"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d WorksheetOptions...
     d                 ds                  qualified
     d   Selected                          like(tag)
     d   Zoom                              like(tag)
     d   AllowDeleteCols...
     d                                     like(tag)
     d   AllowDeleteRows...
     d                                     like(tag)
     d   AllowInsertCols...
     d                                     like(tag)
     d   AllowInsertRows...
     d                                     like(tag)
     d   EnableSelection...
     d                                     like(tag)
     d   ProtectObjects...
     d                                     like(tag)
     d   ProtectScenarios...
     d                                     like(tag)
     d   Visible                           like(tag)
     d   DoNotDisplayZeros...
     d                                     like(tag)
     d FreezePanes     ds                  qualified
     d  define                         n
     d  SplitHorizontal...
     d                                     like(tag)
     d  TopRowBottomPane...
     d                                     like(tag)
     d  SplitVertical...
     d                                     like(tag)
     d  LeftColumnRightPane...
     d                                     like(tag)
     d  ActivePane...
     d                                     like(tag)
     d  pane...
     d                                     like(tag)
     d                                     dim(4)
     d  curpane                       3i 0
     d  panerow                       3i 0
     d  panecol                       3i 0
     d x_WorksheetOptions...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_WorksheetOptions...
BPR  p                 b
     d x_WorksheetOptions...
     d                 PI
      /free
       pinFrame=%addr(xml.WorkSheetOptions);
       x_write('<x:WorksheetOptions '+
          'xmlns="urn:schemas-microsoft-com:office:excel">') ;
B01    if %len( WorksheetOptions.Selected ) > 0;
          x_write(WorksheetOptions.Selected );
E01    endif;
B01    if %len( WorksheetOptions.Zoom ) > 0;
          x_write(WorksheetOptions.Zoom );
E01    endif;
B01    if %len( WorksheetOptions.AllowDeleteCols ) > 0;
          x_write(WorksheetOptions.AllowDeleteCols );
E01    endif;
B01    if %len( WorksheetOptions.AllowDeleteRows ) > 0;
          x_write(WorksheetOptions.AllowDeleteRows );
E01    endif;
B01    if %len( WorksheetOptions.AllowInsertCols ) > 0;
          x_write(WorksheetOptions.AllowInsertCols );
E01    endif;
B01    if %len( WorksheetOptions.AllowInsertRows ) > 0;
          x_write(WorksheetOptions.AllowInsertRows );
E01    endif;
B01    if %len( WorksheetOptions.EnableSelection ) > 0;
          x_write(WorksheetOptions.EnableSelection );
E01    endif;
B01    if %len( WorksheetOptions.ProtectObjects ) > 0;
          x_write(WorksheetOptions.ProtectObjects );
E01    endif;
B01    if %len( WorksheetOptions.ProtectScenarios) > 0;
          x_write(WorksheetOptions.ProtectScenarios);
E01    endif;
B01    if %len( WorksheetOptions.Visible ) > 0;
          x_write(WorksheetOptions.Visible );
E01    endif;
B01    if %len( WorksheetOptions.DONotDisplayZeros) > 0;
          x_write(WorksheetOptions.DoNotDisplayZeros);
E01    endif;
B01    if freezepanes.define;
B02       //?if freezepanes.SplitHorizontal=''
X..       //?   or freezepanes.TopRowBottomPane=''
X..       //?   or freezepanes.SplitVertical=''
X..       //?   or freezepanes.LeftColumnRightPane=''
X..       //?   or freezepanes.ActivePane=''
X..       //?   or freezepanes.Pane(4)='';
          //?   die('Freezepanes, minimum requested properties not found');
X02       //?else;
          x_write('<FreezePanes/>');
          x_write(freezepanes.SplitHorizontal );
          x_write(freezepanes.TopRowBottomPane );
          x_write(freezepanes.SplitVertical );
          x_write(freezepanes.LeftColumnRightPane );
          x_write(freezepanes.ActivePane );
          x_write('<Panes>');
B02       if %len(freezepanes.Pane(4)) > 0;
             x_write(freezepanes.Pane(4));
E02       endif;
B02       if %len(freezepanes.Pane(3)) > 0;
             x_write(freezepanes.Pane(3));
E02       endif;
B02       if %len(freezepanes.Pane(2)) > 0;
             x_write(freezepanes.Pane(2));
E02       endif;
B02       if %len(freezepanes.Pane(1)) > 0;
             x_write(freezepanes.Pane(1));
E02       endif;
          x_write('</Panes>');
E02       //?endif;
E01    endif;
       x_write('</x:WorksheetOptions>');
       clear WorkSheetOptions;
       clear FreezePanes;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Selected      pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Selected      b
     d   Selected      PI
      /free
       WorksheetOptions.selected='<x:Selected/>';
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Zoom          pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Zoom          b
     d   Zoom          PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >= 1;
          WorksheetOptions.zoom=
             '<x:Zoom>'+%char(p1)+'</x:Zoom>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   AllowDeleteCols...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   AllowDeleteCols...
BPR  p                 b
     d   AllowDeleteCols...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.AllowDeleteCols=
             '<x:AllowDeleteCols>'+ZerOne(p1)+'</x:AllowDeleteCols>';
X01    else ;
          worksheetoptions.AllowDeleteCols=
             '<x:AllowDeleteCols/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   AllowDeleteRows...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   AllowDeleteRows...
BPR  p                 b
     d   AllowDeleteRows...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.AllowDeleteRows=
             '<x:AllowDeleteRows>'+ZerOne(p1)+'</x:AllowDeleteRows>';
X01    else ;
          WorksheetOptions.AllowDeleteRows=
             '<x:AllowDeleteRows/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   AllowInsertCols...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   AllowInsertCols...
BPR  p                 b
     d   AllowInsertCols...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.AllowInsertCols=
             '<x:AllowInsertCols>'+ZerOne(p1)+'</x:AllowInsertCols>';
X01    else ;
          WorksheetOptions.AllowInsertCols=
             '<x:AllowInsertCols/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   AllowInsertRows...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   AllowInsertRows...
BPR  p                 b
     d   AllowInsertRows...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.AllowInsertRows=
             '<x:AllowInsertRows>'+ZerOne(p1)+'</x:AllowInsertRows>';
X01    else ;
          WorksheetOptions.AllowInsertRows=
             '<x:AllowInsertRows/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   EnableSelection...
     d                 pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   EnableSelection...
BPR  p                 b
     d   EnableSelection...
     d                 PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=NoSelection
X..          or p1=UnlockedCells ;
             WorksheetOptions.EnableSelection=
                '<x:EnableSelection>'+p1+'</x:EnableSelection>';
X02       else;
             WorksheetOptions.EnableSelection=
                '<x:EnableSelection>'+p1+' is incorrect, possible values are ' +
                NoSelection             +', '+
                UnlockedCells               +'</x:EnableSelection>';
E02       endif;
X01    else;
          WorksheetOptions.EnableSelection='';
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ProtectObjects...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   ProtectObjects...
BPR  p                 b
     d   ProtectObjects...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.ProtectObjects =
             '<x:ProtectObjects>'+TrueFalse(p1)+'</x:ProtectObjects>';
X01    else ;
          WorksheetOptions.ProtectObjects =
             '<x:ProtectObjects/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ProtectScenarios...
     d                 pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   ProtectScenarios...
BPR  p                 b
     d   ProtectScenarios...
     d                 PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1 ;
          WorksheetOptions.ProtectScenarios=
             '<x:ProtectScenarios>'+TrueFalse(p1)+'</x:ProtectScenarios>';
X01    else ;
          WorksheetOptions.ProtectScenarios=
             '<x:ProtectScenarios/>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Visible       pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Visible       b
     d   Visible       PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=SheetHidden
X..          or p1=SheetVeryHidden ;
             WorksheetOptions.Visible =
                '<x:Visible>'+p1+'</x:Visible>';
X02       else;
             WorksheetOptions.Visible =
                '<x:Visible>'+p1+' is incorrect, possible values are ' +
                SheetHidden             +', '+
                SheetVeryHidden       +'</x:Visible>';
E02       endif;
X01    else;
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   DoNotDisplayZeros...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p   DoNotDisplayZeros...
BPR  p                 b
     d   DoNotDisplayZeros...
     d                 PI
      /free
       WorksheetOptions.ProtectScenarios=
          '<x:DoNotDisplayZeros/>';
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   SplitHorizontal...
     d                 pr
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   SplitHorizontal...
BPR  p                 b
     d   SplitHorizontal...
     d                 pi
     d   p1                          10u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.define=true;
          freezepanes.SplitHorizontal =
             '<SplitHorizontal>'+%char(p1)+'</SplitHorizontal>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   TopRowBottomPane...
     d                 pr
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   TopRowBottomPane...
BPR  p                 b
     d   TopRowBottomPane...
     d                 pi
     d   p1                          10u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.define=true;
          freezepanes.TopRowBottomPane=
             '<TopRowBottomPane>'+%char(p1)+'</TopRowBottomPane>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   SplitVertical...
     d                 pr
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   SplitVertical...
BPR  p                 b
     d   SplitVertical...
     d                 pi
     d   p1                          10u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.define=true;
          freezepanes.SplitVertical =
             '<SplitVertical>'+%char(p1)+'</SplitVertical>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   LeftColumnRightPane...
     d                 pr
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   LeftColumnRightPane...
BPR  p                 b
     d   LeftColumnRightPane...
     d                 pi
     d   p1                          10u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.define=true;
          freezepanes.LeftColumnRightPane=
             '<LeftColumnRightPane>'+%char(p1)+'</LeftColumnRightPane>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ActivePane...
     d                 pr
     d   p1                          10u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   ActivePane...
BPR  p                 b
     d   ActivePane...
     d                 pi
     d   p1                          10u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.define=true;
          freezepanes.ActivePane=
             '<ActivePane>'+%char(p1)+'</ActivePane>';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     pane        pr
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     pane        b
     d     pane        PI
     d     p1                              like(tag) options(*nopass) const
     d     p2                              like(tag) options(*nopass) const
     d     p3                              like(tag) options(*nopass) const
      /free
       freezepanes.define=true;
       tag='<Pane ><Number>'+%char(freezepanes.curpane)+'</Number>';
B01    if freezepanes.panerow > 0;
          tag+='<ActiveRow>'+%char(freezepanes.panerow)+'</ActiveRow>';
E01    endif;
B01    if freezepanes.panecol > 0;
          tag+='<ActiveCol>'+%char(freezepanes.panecol)+'</ActiveCol>';
E01    endif;
       tag+='</Pane>';
       freezepanes.pane(freezepanes.curpane+1)=tag;
       freezepanes.curpane=-1;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d    PNumber      pr                  like(tag)
     d       p1                       3u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p    PNumber      b
     d    PNumber      PI                  like(tag)
     d       p1                       3u 0           options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1=TopLeft
X..          or p1=TopRight
X..          or p1=Bottomleft
X..          or p1=BottomRight ;
             freezepanes.curpane=p1 ;
X02       else;
             freezepanes.curpane=-1 ;
E02       endif;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d    PRow         Pr                  like(tag)
     d       p1                       3u 0           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p    PRow         b
     d    PRow         PI                  like(tag)
     d       p1                       3u 0           options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.panerow=p1;
X01    else;
          freezepanes.panerow=1;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d    PCol         pr                  like(tag)
     d       p1                       3u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p    PCol         b
     d    PCol         PI                  like(tag)
     d       p1                       3u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          freezepanes.panecol=p1;
X01    else;
          freezepanes.panecol=-1;
E01    endif;
       return '';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Table           ds                  qualified
     d  ExpandedColumnCount...
     d                                     like(tag)
     d  ExpandedRowCount...
     d                                     like(tag)
     d  FullColumns...
     d                                     like(tag)
     d  FullRows...
     d                                     like(tag)
     d  DefaultColumnWidth...
     d                                     like(tag)
     d  DefaultRowHeight...
     d                                     like(tag)
     d  LeftCell...
     d                                     like(tag)
     d  TopCell...
     d                                     like(tag)
     d x_openTable     pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_openTable     b
     d x_openTable     PI
      /free
B01    if xlxml.TableIsOpen;
          x_closetable();
E01    endif;
       pinFrame=%addr(xml.Table);
       tag='<Table';
       tag+=table.ExpandedColumnCount ;
       tag+=table.ExpandedRowCount ;
       tag+=table.FullColumns ;
       tag+=table.FullRows ;
       tag+=table.DefaultColumnWidth ;
       tag+=table.DefaultRowHeight ;
       tag+=table.LeftCell ;
       tag+=table.TopCell ;
       tag+='>';
       x_write(tag);
       clear table;
       xml.Column = newFrame(xml.Table);
       //?xml.Rows = newFrame(xml.Table);
       //?xml.Row = newFrame(xml.Rows);
       xml.Row = newFrame(xml.Table:true);
       xml.RowData= newFrame(xml.Row) ;
       xlxml.tableisopen=*on;
       xlxml.currow=0;
       xlxml.curcol=0;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ExpandedColumnCount...
     d                 pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   ExpandedColumnCount...
BPR  p                 b
     d   ExpandedColumnCount...
     d                 PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.ExpandedColumnCount =
             ' ss:ExpandedColumnCount="'+%char(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ExpandedRowCount...
     d                 pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   ExpandedRowCount...
BPR  p                 b
     d   ExpandedRowCount...
     d                 PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.ExpandedRowCount =
             ' ss:ExpandedRowCount="'+%char(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   FullColumns   pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   FullColumns   b
     d   FullColumns   PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1;
          table.FullColumns =
             ' ss:FullColumns="'+ZerOne(p1)+'"';
X01    else;
          table.FullColumns =
             ' ss:FullColumns="1"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   FullRows      pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   FullRows      b
     d   FullRows      PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1;
          table.FullRows =
             ' ss:FullRows="'+ZerOne(p1)+'"';
X01    else;
          table.FullRows =
             ' ss:FullRows="1"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   DefaultRowHeight...
     d                 pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   DefaultRowHeight...
BPR  p                 b
     d   DefaultRowHeight...
     d                 PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.DefaultRowHeight=
             ' ss:DefaultRowHeight="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   DefaultColumnWidth...
     d                 pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p   DefaultColumnWidth...
BPR  p                 b
     d   DefaultColumnWidth...
     d                 PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.DefaultColumnWidth=
             ' ss:DefaultColumnWidth="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   LeftCell      pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   LeftCell      b
     d   LeftCell      PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.LeftCell=
             ' ss:LeftCell="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   TopCell       pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   TopCell       b
     d   TopCell       PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          table.TopCell=
             ' ss:TopCell="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_AutoFitColumn...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_AutoFitColumn...
BPR  p                 b
     d x_AutoFitColumn...
     d                 PI
      /free
B01    for iFor = 1 to 256;
B02       if xlxml.colsize(iFor) <> 0;
B03          if xlxml.colsize(iFor) > 0;
                colindex(iFor);
                Width((xlxml.colsize(iFor)+ 1) * xlxml.PointPerChar);
                AutoFitWidth(true);
                x_column();
X03          else ;//?only numeric data
                colindex(iFor);
                AutoFitWidth(true);
                x_column();
E03          endif;
E02       endif;
E01    endfor;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Column          ds                  qualified
     d   Width                             like(tag)
     d   AutoFitWidth                      like(tag)
     d   Hidden                            like(tag)
     d   span                              like(tag)
     d   Index                             like(tag)
     d x_Column        pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Column        b
     d x_Column        PI
      /free
       tag='<Column';
       tag+=Column.Width ;
       tag+=Column.AutoFitWidth ;
       tag+=Column.Hidden ;
       tag+=Column.span ;
       tag+=Column.index;
       tag+='/>';
       pinFrame=%addr(xml.Column);
       x_write(tag);
       clear column;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Width         pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Width         b
     d   Width         PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          column.Width=
             ' ss:Width="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   AutoFitWidth  pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   AutoFitWidth  b
     d   AutoFitWidth  PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1;
          column.AutoFitWidth=
             ' ss:AutoFitWidth="'+ZerOne(p1)+'"';
X01    else;
          column.AutoFitWidth=
             ' ss:AutoFitWidth="1"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Hidden        pr
     d   p1                            n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Hidden        b
     d   Hidden        PI
     d   p1                            n           options(*nopass) const
      /free
B01    if %parms >=1;
          column.Hidden=
             ' ss:Hidden="'+ZerOne(p1)+'"';
X01    else;
          column.Hidden=
             ' ss:Hidden="1"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   span          pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   span          b
     d   span          PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          column.Span=
             ' ss:Span="'+%char(p1)+'"';
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   ColIndex      pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   ColIndex      b
     d   ColIndex      PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          column.index = ' ss:Index="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Row             ds                  qualified
     d   Index                             like(tag)
     d   hidden                            like(tag)
     d x_OpenRow       pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_OpenRow       b
     d x_OpenRow       PI
      /free
B01    if xlxml.RowIsOpen;
          x_closerow();
E01    endif;
       tag='<Row';
B01    if %len(row.index ) = 0 ;
          rowindex() ;
E01    endif;
       tag+=row.index ;
       tag+=row.hidden ;//?not implemented. to be done.
       tag+='>';
       pinFrame=%addr(xml.RowData);
       x_write(tag);
       clear row;
       xlxml.rowisopen=*on;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   RowIndex      pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   RowIndex      b
     d   RowIndex      PI
     d   p1                          10u 0         options(*nopass) const
      /free
       //?can not change the current row if row is not closed
B01    if xlxml.RowIsOpen;
          x_closerow();
E01    endif;
B01    if %parms >=1;
B02       if p1 > 65535;
             xlxml.currow=65535;
X02       else;
             xlxml.currow=p1;
E02       endif;
X01    else;
          xlxml.currow+=1;
E01    endif;
       row.index = ' ss:Index="'+%char(xlxml.currow)+'"';
       xlxml.curcol=0;
       xml.row.level(xml.row.deep )=xlxml.currow;
       xml.RowData= newFrame(xml.Row) ;
       xml.cell = newFrame(xml.row);
       xml.cellData = newFrame(xml.Cell);
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Cell            ds                  qualified
     d   Index                             like(tag)
     d   Formula                           like(tag)
     d   HRef                              like(tag)
     d   MergeAcross                       like(tag)
     d   MergeDown                         like(tag)
      /if defined(xlxml4)
     d   StyleID                           like(x_style)
      /else
     d   StyleID                           like(tag)
      /endif
     d   ColSpan                      3u00
     d x_OpenCell      Pr
      /endif
      /if defined(PROCEDURE_SECTION)
      /if defined(xlxml4)
BPR  p x_OpenCell      b
     d x_OpenCell      pi
      /free
B01    if not xlxml.RowIsOpen;
       x_OpenRow();
E01    endif;
B01    if xlxml.CellIsOpen;
       x_closecell();
E01    endif;
B01    if %len(cell.Index ) = 0 ;
       cellIndex();
E01    endif;
       //?now the frame Cell is uptodate
       pinFrame=%addr(xml.CellData);
       inframe.level(inframe.deep)=100;
       tag='<Cell';
       tag+=cell.Index ;
       tag+=cell.Formula ;
       tag+=cell.HRef ;
       tag+=cell.MergeAcross ;
       tag+=cell.MergeDown ;
       x_write(tag);
B01    if %subst(cell.styleid:1:1) = '1';//.IsNotNull=True
          inframe.level(inframe.deep)=110;
       x_write(cell.StyleID : bin);
E01    endif;
       clear cell.StyleID;
       inframe.level(inframe.deep)=120;
       tag='>';
       x_write(tag);
B01    if xlxml.mincol > xlxml.curcol;
       xlxml.mincol = xlxml.curcol;
E01    endif;
B01    if xlxml.maxcol < xlxml.curcol;
       xlxml.maxcol = xlxml.curcol;
E01    endif;
       xlxml.CellIsOpen=*on;
B01    if cell.colspan > 0;
       xlxml.curcol+=cell.colspan;
E01    endif;
       clear cell;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /else
BPR  p x_OpenCell      b
     d x_OpenCell      pi
      /free
B01    if not xlxml.RowIsOpen;
          x_OpenRow();
E01    endif;
B01    if xlxml.CellIsOpen;
          x_closecell();
E01    endif;
B01    if %len(cell.Index ) = 0 ;
          cellIndex();
E01    endif;
       //?now the frame Cell is uptodate
       pinFrame=%addr(xml.CellData);
       tag='<Cell';
       tag+=cell.Index ;
       tag+=cell.Formula ;
       tag+=cell.HRef ;
       tag+=cell.MergeAcross ;
       tag+=cell.MergeDown ;
       tag+=cell.StyleID ;
       tag+='>';
       x_write(tag);
B01    if xlxml.mincol > xlxml.curcol;
          xlxml.mincol = xlxml.curcol;
E01    endif;
B01    if xlxml.maxcol < xlxml.curcol;
          xlxml.maxcol = xlxml.curcol;
E01    endif;
       xlxml.CellIsOpen=*on;
B01    if cell.colspan > 0;
          xlxml.curcol+=cell.colspan;
E01    endif;
       clear cell;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif
      /if defined(DATA_SECTION)
     d  CellIndex      pr
     d   p1                          10u 0         options(*nopass) const
     d  kn             s              5u 0
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p  CellIndex      b
     d  CellIndex      PI
     d   p1                          10u 0         options(*nopass) const
      /if defined(XLXML3)
     d  kxml           ds                          likerec(xmldbuF :*key)
      /else
     d  kxml           ds                          likerec(xmldb2f:*key)
      /endif
      /free
B01    if xlxml.CellIsOpen;
          x_closecell();
E01    endif;
       xml.Cell = newFrame(xml.Row:true);
B01    if %parms >=1;
          xlxml.curcol=p1;
X01    else;
          xlxml.curcol+=1;
E01    endif;
       xml.cell.level(xml.cell.deep )=xlxml.curcol;
       cell.index=
          ' ss:Index="'+%char(xlxml.curcol)+'"';
       xml.CellData = newFrame(xml.Cell);
       //?xml.celldata is rebuild. cleanup an existing previous cell
       pinframe=%addr(xml.cell );
       kxml.level1 = inframe.level(1) ;
       kxml.level2 = inframe.level(2) ;
       kxml.level3 = inframe.level(3) ;
       kxml.level4 = inframe.level(4) ;
       kxml.level5 = inframe.level(5) ;
       kxml.level6 = inframe.level(6) ;
       kxml.level7 = inframe.level(7) ;
       kxml.level8 = inframe.level(8) ;
       kxml.level9 = inframe.level(9) ;
      /if defined(XLXML3)
       setll %kds(kxml) xmldbuf;
B01    for ever=1;
B02       select;
X02          when inframe.deep=1;
                reade %kds(kxml:1) xmldbuf;
X02          when inframe.deep=2;
                reade %kds(kxml:2) xmldbuf;
X02          when inframe.deep=3;
                reade %kds(kxml:3) xmldbuf;
X02          when inframe.deep=4;
                reade %kds(kxml:4) xmldbuf;
X02          when inframe.deep=5;
                reade %kds(kxml:5) xmldbuf;
X02          when inframe.deep=6;
                reade %kds(kxml:6) xmldbuf;
X02          when inframe.deep=7;
                reade %kds(kxml:7) xmldbuf;
X02          when inframe.deep=8;
                reade %kds(kxml:8) xmldbuf;
X02          when inframe.deep=9;
                reade %kds(kxml:9) xmldbuf;
E02       endsl;
B02       if %eof(xmldbui0);
             leave;
E02       endif;
          delete xmldbuf;
E01    endfor;
      /else
       setll %kds(kxml) xmldb2f;
B01    for ever=1;
B02       select;
X02          when inframe.deep=1;
                reade %kds(kxml:1) xmldb2p;
X02          when inframe.deep=2;
                reade %kds(kxml:2) xmldb2p;
X02          when inframe.deep=3;
                reade %kds(kxml:3) xmldb2p;
X02          when inframe.deep=4;
                reade %kds(kxml:4) xmldb2p;
X02          when inframe.deep=5;
                reade %kds(kxml:5) xmldb2p;
X02          when inframe.deep=6;
                reade %kds(kxml:6) xmldb2p;
X02          when inframe.deep=7;
                reade %kds(kxml:7) xmldb2p;
X02          when inframe.deep=8;
                reade %kds(kxml:8) xmldb2p;
X02          when inframe.deep=9;
                reade %kds(kxml:9) xmldb2p;
E02       endsl;
B02       if %eof(xmldb2p);
             leave;
E02       endif;
          delete xmldb2f;
E01    endfor;
      /endif
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Formula       pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Formula       b
     d   Formula       PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          cell.formula=
             ' ss:Formula="'+encode(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   HRef          pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   HRef          b
     d   HRef          PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          cell.href=
             ' ss:Href="'+encode(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   MergeAcross   pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   MergeAcross   b
     d   MergeAcross   PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          cell.MergeAcross=
             ' ss:MergeAcross="'+%char(p1)+'"';
          cell.colspan = p1;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   MergeDown     pr
     d   p1                          10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   MergeDown     b
     d   MergeDown     PI
     d   p1                          10u 0         options(*nopass) const
      /free
B01    if %parms >=1;
          cell.MergeDown=
             ' ss:MergeDown="'+%char(p1)+'"';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(xlxml4)
      /if defined(DATA_SECTION)
     d   StyleID       pr
     d   p1                                like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   StyleID       b
     d   StyleID       PI
     d   p1                                like(x_style) options(*nopass) const
     d   styledef      ds                  likeds(style)
      /free
B01    if %parms >=1;
       Styledef=p1;
B02    if styledef.IsNotNull=True;
          cell.StyleID= p1;

X02    else;
          message('CPF9897'
             : ' Undefined style. last loaded cell is R'
             + %char( xlxml.currow )
             + 'C'
             + %char( xlxml.curcol )
             :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
          dumpcallstack();
          DiagEmis=*on;
E02    endif;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /else                                                                     < xlxml4
      /if defined(DATA_SECTION)
     d   StyleID       pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   StyleID       b
     d   StyleID       PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
B02       if p1 <> *blank;
             cell.StyleID=
                ' ss:StyleID="'+encode(p1)+'"';
X02       else;
             message('CPF9897'
                : ' Undefined style. last loaded cell is R'
                + %char( xlxml.currow )
                + 'C'
                + %char( xlxml.curcol )
                :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
                dumpcallstack();
             DiagEmis=*on;
E02       endif;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif
      /if defined(DATA_SECTION)
     d data            ds                  qualified
     d   type                              like(tag)
     d   value                             like(tag)
     d   celltype                    10
     d x_data          pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_data          b
     d x_data          PI
      /free
      /if defined(XLXML3)
       pinFrame=%addr(xml.CellData);
B01    if data.celltype <> Utf8;
          //?data.value is ebcdic. convert when write
          longtag='<Data'+data.type+'>'+data.Value+'</Data>';
          x_write(longtag);
X01    else;
          //?data.value is utf8. mix writing ebcdic & utf8
          type(string);
          longtag = toutf8('<Data'+data.type+'>')
             + data.Value
             +     toutf8('</Data>');
          x_write( longtag :utf8);
E01    endif;
      /else
       longtag='<Data'+data.type+'>'+data.Value+'</Data>';
       pinFrame=%addr(xml.CellData);
       x_write(longtag);
      /endif
       clear data;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(XLXML3)
      /if defined(DATA_SECTION)
     d   utf8value     pr
     d   p1                                like(tag) options(*nopass) const
     d utf8Encode      pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
     d ToUtf8          Pr          1010    varying
     d   data                      1010    varying const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   utf8value     b
     d   utf8value     PI
     d   p1                                like(tag) options(*nopass) const
EPR   /free
EPR    Data.Value=utf8encode(p1);
EPR    return ;
B00    BEGSR *pssr;
EPR    DUMP ;
E00    ENDSR ;
EPR   /end-free
EPR  p                 e
BPR  p utf8Encode      b
     d utf8Encode      PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
     D OutString       S                   like(longtag)
     D Pos             S              5u 0           static
    ? * UTF8 Character Set
    ? * convert & " < > (déja codés en utf8) en equivalent html
    ? * <?xml version="1.0" encoding="UTF8"?>
      /free
       outstring =       p1   ;
B01    if %len(p1 ) > 0 ;
          //?replace & with &amp;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan(x'26' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace(x'26616D703B' : outstring :pos : 1) ;
                pos = pos + 5 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?replace " with &quot;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan(x'22' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace(x'2671756F743B' : outstring :pos : 1) ;
                pos = pos + 6 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?// replace ' with &pos;
          //?pos = 1 ;
          //?for ever=1 ;
          //?   if pos < %len(outstring);
          //?      pos = %scan('''' : outstring : pos)         ;
          //?      if pos = 0 ;
          //?         leave ;
          //?      endif ;
          //?      outstring = %replace('&pos;' : outstring :pos : 1)   ;
          //?      pos = pos + 5 ;
          //?   else;
          //?      leave;
          //?   endif;
          //?endfor ;
          //?replace < with &lt;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan(x'3C' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace(x'266C743B' : outstring :pos : 1)     ;
                pos = pos + 4 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?replace > with &gt;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan(x'3E' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace(x'2667743B' : outstring :pos : 1)      ;
                pos = pos + 4 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
E01    endif ;
       if %len(outstring) > %size(tag)-2;
          %len(outstring) = %size(tag)-2;
          message('':'data truncated at ' + %char(%size(tag)-2)
           + ' when ENCODE');
          message('':p1);
          message('':outstring);
                dumpcallstack();
       //    DiagEmis=*on;
       endif;
       return outstring ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p ToUtf8          b
     d ToUtf8          PI          1010    varying
     d   data                      1010    varying const

     d ebcdicdata      s           1010    varying   static
     D ebcdiclen       s             10i 0           static
     D utf8Data        s           1010              static
     D utf8Len         s             10i 0           static

     d ReturnData      s           1010    varying   static



     D rc              s             10i 0           static


      /free
       ebcdicdata = data;
       ebcdiclen=%len(ebcdicdata);
       utf8len=%size(utf8Data);
       rc = iconv(hIconv0:
          %addr(ebcdicdata )+2:ebcdiclen :
B01       %addr(utf8data): utf8len ) ;
B01    if rc< 0;
B02       if c_errno <> 0;
E02          message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E02       endif;
          return '';
E01    endif;
       returndata=%subst(utf8data:1:%size(utf8data)-utf8len);


B01
       return returndata;
E01
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif
      /if defined(DATA_SECTION)
     d       Type      pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p       Type      b
     d       Type      PI
     d   p1                                like(tag) options(*nopass) const
      /free
      /if defined(XLXML3)
B01    if %parms >=1;
B02       if p1=Boolean
X..          or p1=DateTime
X..          or p1=Number
X..          or p1=String
X..          or p1=Utf8
X..          or p1=Error ;
      /else
B03          if %parms >=1;
B04             if p1=Boolean
X..                or p1=DateTime
X..                or p1=Number
X..                or p1=String
X..                or p1=Utf8
X..                or p1=Error ;
      /endif
                   data.type=' ss:Type="'+p1+'"';
                   data.celltype=p1;
X04             else;
      /if defined(XLXML3)
                data.type='ss:Type="'+p1+' is incorrect, possible values are ' +
                      Boolean                 +', '+
                      DateTime                +', '+
                      Number                  +', '+
                      String                  +', '+
                      Utf8                    +', '+
                      Error                   +'"';
      /else
                data.type='ss:Type="'+p1+' is incorrect, possible values are ' +
                      Boolean                 +', '+
                      DateTime                +', '+
                      Number                  +', '+
                      String                  +', '+
                      Error                   +'"';
      /endif
                   data.celltype='';
E04             endif;
E03          endif;
             return ;
B00          BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d       value     pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p       value     b
     d       value     PI
     d   p1                                like(tag) options(*nopass) const
      /free
       Data.Value=encode(p1);
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Comment         ds                  qualified
     d   author                            like(tag)
     d   ShowAlways                        like(tag)
     d   html                              like(LongTag)
     d   flushed                       n
     d x_Comment       pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Comment       b
     d x_Comment       PI
      /free
       Longtag ='<Comment' + Comment.author + comment.showalways +'>'
          + Comment.html + '</Comment>';
       pinFrame=%addr(xml.CellData);
       x_write(Longtag);
       clear Comment;
       comment.flushed = true ;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d    CAuthor      pr
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR ?p    CAuthor      b
     d    CAuthor      PI
     d     p1                              like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          Comment.author=' ss:Author="'+encode(p1)+'"';
          comment.flushed = false;
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR ?p                 e
      /endif
      /if defined(DATA_SECTION)
     d     ShowAlways  pr
     d     p1                          n           options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     ShowAlways  b
     d     ShowAlways  PI
     d     p1                          n           options(*nopass) const
      /free
B01    if %parms >=1;
          Comment.showalways=' ss:ShowAlways="'+ZerOne(p1)+'"';
          comment.flushed = false;
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     Html        pr
     d     p1                              like(longtag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p     Html        b
     d     Html        PI
     d     p1                              like(longtag) options(*nopass) const
      /free
B01    if %parms >=1;
          Comment.html='<ss:Data xmlns:html="http://www.w3.org/TR/REC-html40" '
             + ' xmlns="http://www.w3.org/TR/REC-html40">'
             +p1+'</ss:Data>';
          comment.flushed = false;
E01    endif;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CloseCell     pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_CloseCell     b
     d x_CloseCell     PI
      /free
       pinFrame=%addr(xml.Celldata);
       inframe.level(inframe.deep)=11111;
       x_write('</Cell>');
       xlxml.CellIsOpen=*off;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CloseRow      pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_CloseRow      b
     d x_CloseRow      PI
      /free
B01    if xlxml.CellIsOpen;
          x_closecell();
E01    endif;
       pinFrame=%addr(xml.RowData);
       inframe.level(inframe.deep)=11111;
       x_write('</Row>');
       xlxml.RowIsOpen=*off;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CloseTable    pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_CloseTable    b
     d x_CloseTable    PI
      /free
B01    if xlxml.rowIsOpen;
          x_closeRow();
E01    endif;
       pinFrame=%addr(xml.Table);
       x_write('</Table>');
       xlxml.TableIsOpen=*off;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_OpenConditionalFormatting...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_OpenConditionalFormatting...
BPR  p                 b
     d x_OpenConditionalFormatting...
     d                 PI
      /free
       pinFrame=%addr(xml.ConditionalFormatting);
       x_write('<x:ConditionalFormatting>');
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_Range         pr
     d p1                                  like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Range         b
     d x_Range         PI
     d p1                                  like(tag) options(*nopass) const
      /free
       pinFrame=%addr(xml.ConditionalFormatting);
       x_write('<x:Range>'+p1+'</x:Range>');
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Condition       ds                  qualified
     d   Qualifier                         like(tag)
     d   Value1                            like(tag)
     d   Value2                            like(tag)
     d   Format                            like(tag)
     d x_Condition     pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Condition     b
     d x_Condition     PI
      /free
       pinFrame=%addr(xml.ConditionalFormatting);
       x_write('<x:Condition>');
B01    if %len( condition.qualifier)> 0 ;
          x_write(condition.qualifier) ;
E01    endif;
B01    if %len( condition.Value1 )> 0 ;
          x_write(condition.Value1 ) ;
E01    endif;
B01    if %len( condition.Value2 )> 0 ;
          x_write(condition.Value2 ) ;
E01    endif;
B01    if %len( condition.Format )> 0 ;
          x_write(condition.Format ) ;
E01    endif;
       x_write('</x:Condition>');
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Qualifier     pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Qualifier     b
     d   Qualifier     PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          condition.Qualifier =
             '<x:Qualifier>'+p1+'</x:Qualifier>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Value1        pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Value1        b
     d   Value1        PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          condition.Value1 =
             '<x:Value1>'+p1+'</x:Value1>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Value2        pr
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Value2        b
     d   Value2        PI
     d   p1                                like(tag) options(*nopass) const
      /free
B01    if %parms >=1;
          condition.Value2 =
             '<x:Value2>'+p1+'</x:Value2>';
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d   Format        pr
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p   Format        b
     d   Format        PI
     d   p1                                like(tag) options(*nopass) const
     d   p2                                like(tag) options(*nopass) const
     d   p3                                like(tag) options(*nopass) const
     d   p4                                like(tag) options(*nopass) const
      /free
       tag='<x:Format x:style=''';
B01    if %parms >= 1;
          tag+=p1;
E01    endif;
B01    if %parms >= 2;
          tag+=p2;
E01    endif;
B01    if %parms >= 3;
          tag+=p3;
E01    endif;
B01    if %parms >= 4;
          tag+=p4;
E01    endif;
       tag+='''/>';
       condition.format=tag;
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     fcolor...
     d                 pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     fcolor...
BPR  p                 b
     d     fcolor...
     d                 PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       return 'color:'+p1=';';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     font_weight...
     d                 pr                  like(tag)
     d     p1                        10u 0         options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     font_weight...
BPR  p                 b
     d     font_weight...
     d                 PI                  like(tag)
     d     p1                        10u 0         options(*nopass) const
      /free
       return 'font-weight:'+%char(p1)+';';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     text_underline_style...
     d                 pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     text_underline_style...
BPR  p                 b
     d     text_underline_style...
     d                 PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       return 'text-underline-style:'+p1+';';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d     text_line_through...
     d                 pr                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
     p     text_line_through...
BPR  p                 b
     d     text_line_through...
     d                 PI                  like(tag)
     d     p1                              like(tag) options(*nopass) const
      /free
       return 'text-line-through:'+p1+';';
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CloseConditionalFormatting...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_CloseConditionalFormatting...
BPR  p                 b
     d x_CloseConditionalFormatting...
     d                 PI
      /free
       pinFrame=%addr(xml.ConditionalFormatting);
       x_write('</x:ConditionalFormatting>');
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d x_CloseWorksheet...
     d                 pr
      /endif
      /if defined(PROCEDURE_SECTION)
     p x_CloseWorksheet...
BPR  p                 b
     d x_CloseWorksheet...
     d                 PI
      /free
B01    if xlxml.TableIsOpen=*on;
          x_closetable();
E01    endif;
       x_CloseConditionalFormatting();
       pinFrame=%addr(xml.Worksheet);
       x_write('</Worksheet>');
       xlxml.SheetIsOpen=*off;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif

      /if defined(DATA_SECTION)
     d x_CloseXlXml    pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_CloseXlXml    b
     d x_CloseXlXml    PI
      /free
B01    if xlxml.SheetIsOpen;
          x_closeworksheet();
E01    endif;
B01    if DocumentProperties.flushed=false;
          x_DocumentProperties();
E01    endif;
       pinFrame=%addr(xml.Workbook);
       x_write('</Workbook>');
      /if defined(xlxml4)
       WriteStyles();
      /endif
       pinFrame=%addr(xml.Styles);
       x_write('</Styles>');
       pinFrame=%addr(xml.Names);
       x_write('</Names>');
      /if defined(XLXML3)
       close xmldbuI0;
       //?close iconv handlers
       iconv_close(hiconv0);
      /endif
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?=*---------------------------------------------------------*=
      /endif

      /if defined(DATA_SECTION)
     d x_Copy2Ifs      pr
     D   FileName                   500    varying const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Copy2Ifs      b
     d x_Copy2Ifs      PI
     d   ifsFileName                500    varying const
      /if defined(XLXML3)
     d FileName        s            500    varying   static
     D UCSData         s          16382C             static
     d pUCSData        s               *   inz(%addr(UCSData))
     D WriteData       s          65000              static
     D XmlBuffer       s          65000    varying   static
     D WriteLen        s             10i 0           static
     D xmlFileHandle   s             10i 0           static
     D rc              s             10i 0           static

     d QlgTransformUCSData...
     d                 pr            10i 0 extproc('QlgTransformUCSData')
     d    Type_of_transformation_requested...
     d                               10i 0 value
     d    Address_of_pointer_to_buffer_to_transform...
     d                                 *
     d    Address_of_number_of_bytes_to_transform...
     d                                 *   value
     d    Address_of_pointer_to_resulting_transform...
     d                                 *
     d    Address_of_size_of_buffer_to_hold_result...
     d                                 *   value
     d    Address_of_space_needed_to_complete_request...
     d                                 *   value
     d inbytes         s             10i 0           static
     d outbytes        s             10i 0           static
     d outmissing      s             10i 0           static

     dpinbuf           s               *             static
     dpinbytes         s               *             static
     dpoutbuf          s               *             static
     dpoutbytes        s               *             static
     dpoutmissing      s               *             static

      /free
       filename=%trim(ifsfilename);
       //?delete the file
       rc= unlink (FileName );
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       //?create a file & declare implicit code page converter
       xmlFileHandle = open(FileName
          : O_CREAT + O_WRONLY + O_TRUNC + O_CODEPAGE
          : S_IRWXU + S_IROTH
          : CP_UTF8 ) ;
B01    if xmlFileHandle = -1;
          escerrno(errno);
E01    endif;
       //?UTF16 BOM
       //?rc = write(xmlFileHandle : x'FFFE'   : 2        ) ;
B02    //?if rc = -1;
       //?   escerrno(errno);
E02    //?endif;
       //?UTF8  BOM
       //?rc = write(xmlFileHandle : x'EFBBBF': 3 ) ;
B02    //?if rc = -1;
       //?   escerrno(errno);
E02    //?endif;
       clear xl.data;
       open xmldbuI0;
       setll (*loval) xmldbuf;
B01    for ever;
          read xmldbuf;
B02       if %eof;
             leave;
E02       endif;
B02       if %len(xl.data)=0;
             iter;
E02       endif;

          //?pInBuf = %addr( xl.data ) + 2 ;//?updated by api
          //?inbytes=%len(xl.data)*2;
          //?pInBytes= %addr(InBytes);//?updated by api
          //?clear writedata;
          //?pOutBuf = %addr( WriteData );//?updated by api
          //?outbytes=%size(WriteData);
          //?pOutBytes=%addr( outbytes );
          //?OutMissing = 0;
          //?pOutMissing = %addr( outmissing );
          //?rc = QlgTransformUCSData( 1 // 1=Transform from UCS-2 to UTF-8.
          //?   : pinbuf
          //?   : pinbytes
          //?   : poutbuf
          //?   : poutbytes
          //?   : poutmissing
          //?   ) ;
          //?WriteLen=%len(%trim(writedata));
          //?rc = write(xmlFileHandle : WriteData : WriteLEN ) ;
          WriteLen=%len(%trim(xl.data));
          rc = write(xmlFileHandle : xl.Data : WriteLEN ) ;
B02       if rc = -1;
             escerrno(errno);
E02       endif;
          rc = write(xmlFileHandle : x'0D0A' : 2 ) ;
B02       if rc = -1;
             escerrno(errno);
E02       endif;
E01    endfor;
       Rc = close(xmlFileHandle) ;
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       close xmldbuI0;
      /else
     d FileName        s            500    varying   static
     D WriteData       s          65535              static
     D XmlBuffer       s          65000    varying   static
     D WriteLen        s             10i 0           static
     D xmlFileHandle   s             10i 0           static
     D rc              s             10i 0           static

      /free
       filename=%trim(ifsfilename);
       //?delete the file
       rc= unlink (FileName );
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       //?create a file & declare implicit code page converter
       xmlFileHandle = open(FileName
          : O_CREAT + O_WRONLY + O_TRUNC + O_CODEPAGE
          : S_IRWXU + S_IROTH
          : CP_ISO8859_1 ) ;
B01    if xmlFileHandle = -1;
          escerrno(errno);
E01    endif;
       //?close the file to be able
       Rc = close(xmlFileHandle) ;
       //?to reopen it with O_TEXTDATA flag, the ones that controls code page convertion
       xmlFileHandle = open(FileName
       //?: O_RDWR + O_APPEND) ;
          : O_TEXTDATA + O_RDWR + O_APPEND) ;
       //?sql preprocessor don't work with /include. Recoded into native read
       //?C/EXEC SQL
       //?C+ DECLARE XMLDB2K1 CURSOR FOR SELECT DATA FROM XMLDB2P WHERE
       //?C+ DATA<>'' ORDER BY LEVEL1, LEVEL2, LEVEL3, LEVEL4, LEVEL5, LEVEL6,
       //?C+ LEVEL7, LEVEL8, LEVEL9
       //?c/END-EXEC
       //?c/EXEC SQL
       //?C+ OPEN XMLDB2K1
       //?c/END-EXEC
       //?c                   if        sqlcod <> *zero
       //?c                   callp     escsqler (sqlcod)
       //?c                   endif
       //?c                   do        *hival
       //?c/EXEC SQL
       //?C+ FETCH NEXT FROM XMLDB2K1 INTO :xl.data
       //?c/END-EXEC
       //?c                   if        sqlcod = 100
       //?c                   leave
       //?c                   endif
       //?c                   if        sqlcod <> *zero
       //?c                   callp     escsqler (sqlcod)
       //?c                   endif
       clear xl.data;
       setll (*loval) xmldb2p;
B01    for ever;
          read xmldb2p;
B02       if %eof;
             leave;
E02       endif;

          xl.data +=crlf;
          WriteLen=%len(xl.data );
          writedata = xl.data ;//?remove varlen (the first 2 chars)
          rc = write(xmlFileHandle : WriteData : WriteLEN ) ;
B02       if rc = -1;
             escerrno(errno);
E02       endif;


E01    endfor;

       //?c                   enddo
       //?c/EXEC SQL
       //?C+ CLOSE XMLDB2K1
       //?c/END-EXEC

       Rc = close(xmlFileHandle) ;
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
      /endif
       return;
B00    BEGSR *pssr;
       dumpcallstack();
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?=*---------------------------------------------------------*=
      /endif
      /if defined(DATA_SECTION)
     d x_ReturnCode    pr
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_ReturnCode    b
     d x_ReturnCode    PI

      /free
B01    if DiagEmis=*on;
          message('CPF9897'
             : ' Diag message have been sent'
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*':4);
E01    endif;
       return;
B00    BEGSR *pssr;
       //?DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?=*---------------------------------------------------------*=
      /endif

      /if defined(DATA_SECTION)
     D x_write         Pr
     D   xlxml                     1010    varying const
     d   type                        10              options(*nopass) const
     d DiagEmis        s               n   inz(*off)
      /endif
      /if defined(PROCEDURE_SECTION)
      /if defined(xlxml4)
    ? * write xml data to the sheet
BPR  P x_write         B
     D x_write         PI
     D   xlxml                     1010    varying const
     d  ptype                        10              options(*nopass) const
     d   type          s             10              static
     d xlupdate        s               n             static
     d maxsize         s             10u 0
     c     k9            klist
     c                   kfld                    xl.level1
     c                   kfld                    xl.level2
     c                   kfld                    xl.level3
     c                   kfld                    xl.level4
     c                   kfld                    xl.level5
     c                   kfld                    xl.level6
     c                   kfld                    xl.level7
     c                   kfld                    xl.level8
     c                   kfld                    xl.level9
      /free
B01    if %parms() >= 2;
       type = ptype;
X01    else ;
       type = string;
E01    endif;
       xl.level1 = inframe.level(1) ;
       xl.level2 = inframe.level(2) ;
       xl.level3 = inframe.level(3) ;
       xl.level4 = inframe.level(4) ;
       xl.level5 = inframe.level(5) ;
       xl.level6 = inframe.level(6) ;
       xl.level7 = inframe.level(7) ;
       xl.level8 = inframe.level(8) ;
       xl.level9 = inframe.level(9) ;
       chain k9 xmldbuf;
B01    if %found(xmldbui0);
       xlupdate=*on;
X01    else;
       xlupdate=*off;
E01    endif;
B01    if type = utf8 or type = bin;
       maxsize=%size(XL.DATA)-2;
X01    else;
       maxsize=(%size(XL.DATA)-2)/2;
E01    endif;
B01    if %len(xlxml) > maxsize ;
       XL.DATA= toutf8('<ERROR msg="out of boundary RPG DDS"/>');
       write xmldbuf;
       callp message('CPF9897'
          : ' out of boundary RPG DDS.'
          + ' try to write TEXT of '
          + %char( %len(xlxml) )
          + ' characters ( > '
          + %char(       %size(xl.data)     ) + ')'
          :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
       dumpcallstack();
       DiagEmis=*on;
E01    endif;
B01    if type = utf8 or type = bin;
       xl.data = xlxml;
X01    else;
       xl.data= toutf8(xlxml);
E01    endif;
       //?if inframe.manualnumber = false;
       inframe.level(inframe.deep)+=1;
       //?endif;
B01    if xlupdate;
       update(e) xmldbuf;
X01    else;
       write(e) xmldbuf;
E01    endif;
       //?erreur ?
B01    if %error();
       die('S_Write, abnormal end of file');
E01    endif;
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  P                 E
      /else
    ? * write xml data to the sheet
BPR  P x_write         B
     D x_write         PI
     D   xlxml                     1010    varying const
     d  ptype                        10              options(*nopass) const
     d   type          s             10              static
     d xlupdate        s               n             static
     c     k9            klist
     c                   kfld                    xl.level1
     c                   kfld                    xl.level2
     c                   kfld                    xl.level3
     c                   kfld                    xl.level4
     c                   kfld                    xl.level5
     c                   kfld                    xl.level6
     c                   kfld                    xl.level7
     c                   kfld                    xl.level8
     c                   kfld                    xl.level9
      /free
      /if defined(XLXML3)
B01    if %parms() >= 2;
          type = ptype;
X01    else ;
          type = string;
E01    endif;
       xl.level1 = inframe.level(1) ;
       xl.level2 = inframe.level(2) ;
       xl.level3 = inframe.level(3) ;
       xl.level4 = inframe.level(4) ;
       xl.level5 = inframe.level(5) ;
       xl.level6 = inframe.level(6) ;
       xl.level7 = inframe.level(7) ;
       xl.level8 = inframe.level(8) ;
       xl.level9 = inframe.level(9) ;
       chain k9 xmldbuf;
B01    if %found(xmldbui0);
          xlupdate=*on;
X01    else;
          xlupdate=*off;
E01    endif;
B01    if %len(xlxml) > (%size(XL.DATA)-2)/2;
          XL.DATA= toutf8('<ERROR msg="out of boundary RPG DDS"/>');
          write xmldbuf;
          callp message('CPF9897'
             : ' out of boundary RPG DDS.'
             + ' try to write TEXT of '
             + %char( %len(xlxml) )
             + ' characters ( > '
             + %char(       %size(xl.data)     ) + ')'
             :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
                dumpcallstack();
          DiagEmis=*on;
E01    endif;
B01    if type = utf8;
          xl.data = xlxml;
X01    else;
          xl.data= toutf8(xlxml);
E01    endif;
       //?if inframe.manualnumber = false;
       inframe.level(inframe.deep)+=1;
       //?endif;
B01    if xlupdate;
          update(e) xmldbuf;
X01    else;
          write(e) xmldbuf;
E01    endif;
       //?erreur ?
B01    if %error();
          die('S_Write, abnormal end of file');
E01    endif;
      /else
       xl.level1 = inframe.level(1) ;
       xl.level2 = inframe.level(2) ;
       xl.level3 = inframe.level(3) ;
       xl.level4 = inframe.level(4) ;
       xl.level5 = inframe.level(5) ;
       xl.level6 = inframe.level(6) ;
       xl.level7 = inframe.level(7) ;
       xl.level8 = inframe.level(8) ;
       xl.level9 = inframe.level(9) ;
       chain k9 xmldb2p;
B01    if %found(xmldb2p);
          xlupdate=*on;
X01    else;
          xlupdate=*off;
E01    endif;
B01    if %len(xlxml) > %size(XL.DATA)-2;
          XL.DATA='<ERROR msg="out of boundary RPG DDS"/>';
          write xmldb2f;
          callp message('CPF9897'
             : ' out of boundary RPG DDS.'
             + ' try to write TEXT of '
             + %char( %len(xlxml) )
             + ' characters ( > '
             + %char(       %len(xl.data)     ) + ')'
             :'*LIBL':'QCPFMSG':'*DIAG':'*':1);
                dumpcallstack();
          DiagEmis=*on;
E01    endif;
       xl.data=xlxml;
       //?if inframe.manualnumber = false;
       inframe.level(inframe.deep)+=1;
       //?endif;
B01    if xlupdate;
          update(e) xmldb2f;
X01    else;
          write(e) xmldb2f;
E01    endif;
       //?erreur ?
B01    if %error();
          die('S_Write, abnormal end of file');
E01    endif;
      /endif
      /end-free
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  P                 E
      /endif
      /endif
      /if defined(DATA_SECTION)
     d TrueFalse       pr                  like(tag)
     d p1                              n                            const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p TrueFalse       b
     d TrueFalse       PI                  like(tag)
     d p1                              n                            const
      /free
B01    if p1=*on ;
          return 'True';
X01    else ;
          return 'False';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ZerOne          pr                  like(tag)
     d p1                              n                            const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p ZerOne          b
     d ZerOne          PI                  like(tag)
     d p1                              n                            const
      /free
B01    if p1=*on ;
          return '1';
X01    else ;
          return '0';
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d Encode          pr                  like(tag)
     d   p1                                like(tag) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p Encode          b
     d Encode          PI                  like(tag)
     d   p1                                like(tag) options(*nopass) const
     D OutString       S                   like(longtag) static
     D Pos             S              5u 0           static
    ? * ISO Latin-1 Character Set
    ? * HTML Character Sets
    ? * <?xml version="1.0" encoding="ISO-8859-1"?>
      /free
       outstring = %trim(p1 ) ;
B01    if %len(p1 ) > 0 ;
          //?replace & with &amp;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan('&' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace('&amp;' : outstring :pos : 1) ;
                pos = pos + 5 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?replace " with &quot;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan('"' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace('&quot;' : outstring :pos : 1) ;
                pos = pos + 6 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?//?replace ' with &pos;
          //?pos = 1 ;
          //?for ever=1 ;
          //?   if pos < %len(outstring);
          //?      pos = %scan('''' : outstring : pos)         ;
          //?      if pos = 0 ;
          //?         leave ;
          //?      endif ;
          //?      outstring = %replace('&pos;' : outstring :pos : 1)   ;
          //?      pos = pos + 5 ;
          //?   else;
          //?      leave;
          //?   endif;
          //?endfor ;
          //?replace < with &lt;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan('<' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace('&lt;' : outstring :pos : 1)     ;
                pos = pos + 4 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
          //?replace > with &gt;
          pos = 1 ;
B02       for ever=1 ;
B03          if pos < %len(outstring);
                pos = %scan('>' : outstring : pos)         ;
B04             if pos = 0 ;
                   leave ;
E04             endif ;
                outstring = %replace('&gt;' : outstring :pos : 1)      ;
                pos = pos + 4 ;
X03          else;
                leave;
E03          endif;
E02       endfor ;
E01    endif ;
       if %len(outstring) > %size(tag)-2;
          %len(outstring) = %size(tag)-2;
          message('':'data truncated at ' + %char(%size(tag)-2)
              + ' when ENCODE');
          message('':p1);
          message('':outstring);
                dumpcallstack();
       //    DiagEmis=*on;
       endif;
       return outstring ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /if defined(DATA_SECTION)
     d ActiveCell      pr                  likeds(dsrange)
      /endif
      /if defined(PROCEDURE_SECTION)                                                               ²
BPR  p ActiveCell      b
     d ActiveCell      pi                  likeds(dsrange)
     d AC              ds                  likeds(dsrange) static
      /free
       AC.row = xlxml.currow;
       AC.col = xlxml.curcol;
       AC.cell = 'R' + %char(AC.row) + 'C' + %char(AC.col);
       return AC;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load text in a cell
      /if defined(DATA_SECTION)
     d x_string        pr
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
      /if defined(XLXML3)
     d x_UTF8          pr
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
     d x_empty         pr
     d   col                          5u 0 const
     d   style                             like(x_style)                  const
      /endif
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_string        b
     d x_string        pi
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
      /free
B01    if %parms >= 3;
          StyleID(style) ;
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       Type( String ) ;
       value(data) ;
       x_data( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
B01    if xlxml.colsize(xlxml.curcol) < %len(data );
          xlxml.colsize(xlxml.curcol) = %len(data );
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /if defined(XLXML3)
BPR  p x_utf8          b
     d x_utf8          pi
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
      /free
B01    if %parms >= 3;
          StyleID(style) ;
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       Type( Utf8 ) ;
       UTF8value(data) ;
       x_data( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
B01    if xlxml.colsize(xlxml.curcol) < %len(data );
          xlxml.colsize(xlxml.curcol) = %len(data );
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      * for a cell without darta but a style
BPR  p x_empty         b
     d x_empty         pi
     d   col                          5u 0 const
     d   style                             like(x_style)                  const
      /free
B01
          StyleID(style) ;
E01
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       x_CloseCell();
B01

E01
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif
    ? * load Formula in a cell
      /if defined(DATA_SECTION)
     d x_formula       pr
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_formula       b
     d x_formula       pi
     d   col                          5u 0 const
     D   data                              like(tag) const
     d   style                             like(x_style) options(*nopass) const
      /free
B01    if %parms >= 3;
          StyleID(style) ;
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       formula(data);
       x_openCell( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load number in a cell
      /if defined(DATA_SECTION)
     d x_Number        pr
     d   col                          5u 0 const
      /if defined(XLXML3)
     D   data                        63s10 const
      /else
     D   data                        31s10 const
      /endif
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Number        b
     d x_Number        pi
     d   col                          5u 0 const
      /if defined(XLXML3)
     D   data                        63s10 const
      /else
     D   data                        31s10 const
      /endif
     d   style                             like(x_style) options(*nopass) const
     d texte           s                   like(tag)       static
      /free
B01    if %parms >= 3;
          StyleID(style) ;
X01    else;
          styleID(xlxml.style.number) ;
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       Type( Number ) ;
       texte = %editc(data:'P');
       //?recherche zeros à droite (0 à 10, le nombre de décimales est fixe)
       %len(texte) = %checkr('0':texte);
       value(texte) ;
       x_data( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
B01    if xlxml.colsize(xlxml.curcol) = 0;
          xlxml.colsize(xlxml.curcol) = -1;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load float  in a cell
      /if defined(DATA_SECTION)
     d x_Float         pr
     d   col                          5u 0 const
     D   data                         8f   const
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Float         b
     d x_Float         pi
     d   col                          5u 0 const
     D   data                         8f   const
     d   style                             like(x_style) options(*nopass) const
     d texte           s                   like(tag)       static
      /free
B01    if %parms >= 3;
          StyleID(style) ;
X01    else;
          StyleiD(xlxml.style.number);
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       Type( Number ) ;
       texte = %char(data );
B01    if %subst(texte : 1 : 1) = '+';
          %subst(texte : 1 : 1) = ' ';
E01    endif;
       value(texte) ;
       x_data( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
B01    if xlxml.colsize(xlxml.curcol) = 0;
          xlxml.colsize(xlxml.curcol) = -1;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load DTS    in a cell
      /if defined(DATA_SECTION)
     d x_DTS           pr
     d   col                          5u 0 const
     D   data                          z   const
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_DTS           b
     d x_DTS           pi
     d   col                          5u 0 const
     D   data                          z   const
     d   style                             like(x_style) options(*nopass) const
     d texte           s                   like(tag)       static
     d ztochar         s             26                    static
    ? * exemple de valeur reçue   :Z'2005-04-01-13.45.18'
    ? * exemple de date convertie : '2005-04-01-13.45.18.000000'
    ? * format excel :              '2005-04-01T13:45:18.000'
      /free
       ztochar=%char(data:*iso);
       %subst(ztochar:11:1)='T';
       %subst(ztochar:14:1)=':';
       %subst(ztochar:17:1)=':';
       %subst(ztochar:20:4)='.000';
B01    if %parms >= 3;
          StyleID(style) ;
X01    else;
          styleid(xlxml.style.dts);
E01    endif;
B01    if col > 0;//?go to an other cell (otherwise go to next cell)
B02       //?if col <> xlxml.curcol;
          cellindex(col);
E02       //?endif;
E01    endif;
       x_openCell( );
       Type( DateTime ) ;
       value(%subst(ztochar:1:23));
       x_data( );
B01    if comment.flushed = false;
          x_comment();
E01    endif;
       x_CloseCell();
B01    if xlxml.colsize(xlxml.curcol) = 0;
          xlxml.colsize(xlxml.curcol) = -1;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load Date   in a cell
      /if defined(DATA_SECTION)
     d x_Date          pr
     d   col                          5u 0 const
     D   data                          d   const
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Date          b
     d x_Date          pi
     d   col                          5u 0 const
     D   data                          d   const
     d   style                             like(x_style) options(*nopass) const
     d zdata           s               z                   static
      /free
       zdata = %timestamp(data);
B01    if data < d'1901-01-01' ;
B02       if %parms >= 3;
             x_string(col:%char(zdata):style);
X02       else ;
             x_string(col:%char(zdata):xlxml.style.date);
E02       endif;
X01    else;
B02       if %parms >= 3;
             x_dts(col:zdata:style);
X02       else ;
             x_dts(col:zdata: xlxml.style.date);
E02       endif;
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
    ? * load Time   in a cell
      /if defined(DATA_SECTION)
     d x_Time          pr
     d   col                          5u 0 const
     D   data                          t   const
     d   style                             like(x_style) options(*nopass) const
      /endif
      /if defined(PROCEDURE_SECTION)
BPR  p x_Time          b
     d x_Time          pi
     d   col                          5u 0 const
     D   data                          t   const
     d   style                             like(x_style) options(*nopass) const
     d zexcelmin       s               z   inz(Z'1899-12-31-00.00.00.000000')
     d zdata           s               z                   static
      /free
       zdata = zexcelmin + %hours(%subdt(data:*H))
          + %minutes(%subdt(data:*MN))
          + %seconds(%subdt(data:*S)) ;
B01    if %parms >= 3;
          x_dts(col:zdata:style);
X01    else ;
          x_dts(col:zdata:xlxml.style.time);
E01    endif;
       return;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif
      /endif                                                                    xlxml
