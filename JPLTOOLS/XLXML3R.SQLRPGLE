    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
      /define SQL
    ? /define SQLDESCRIBE
    ? /define LOWERCASE
      /define XLXML3
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')

    ? * file declaration for xmldb2p
      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d xlxml3r         pr
     d   filename                   500
     d xlxml3r         pi
     d   filename                   500
    ? * have a look in the include at the xlxml vocabulary

    ? * prototype for intranal procedures
     D Proc            Pr
     D DemoColor       Pr
     D   name                              like(tag) const
     D   color                             like(tag) const




     d Courier11       s                   like(style.font)
     d MyRange         ds                  likeds(dsrange)

     d NumLeft         s                   like(x_style)
     d NumCenter       s                   like(x_style)
     d MyStyle         s                   like(x_style)
     d Arial36         s                   like(x_style)
     d MyFloat         s              8f

     c/EXEC SQL
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec

      * l'option RPGPPOPT(*LVL2) de CRTSQLRPGI permettrait d'éviter cette copie,
      * mais il impose une renumérotation des lignes source. Fort désagréable
      /copy jpltools,xmldbuk

      /free
       //?*=----------------------------------------------------------------------------------=*
       //? procédure principale
       //?*=----------------------------------------------------------------------------------=*

       //?create the "file", prepare header and some common values :
       //?xlxml.style.number
       //?xlxml.style.date
       //?xlxml.style.time
       //?xlxml.style.dts
       //?xlxml.style.integer
       //?
       x_OpenXlXml();

       //?if requested, set properties for the "DocumentProperties" tag
       //?Author(SPJBUS);
       //?LastAuthor('?');
       //?version('?');
       //?Created(Znow) ;
       Company('MyCompany')         ;
       //?flush the "DocumentProperties" tag to the xml file
       x_DocumentProperties( );

       //?nothing implemented for this xlxml element
       //?x_CustomerDocumentProperties();
       //?
       //?if requested, set properties for the "ExcelWorkBook" tag
       //?WindowHeight(10005) ;
       //?WindowWidth(10005) ;
       //?WindowTopX(120) ;
       //?WindowTopY(135) ;
       //?ProtectStructure(False) ;
       //?ProtectWindows(False) ;
       //?ActiveSheet(true)          ;
       //?WindowHidden()           ;
       //?flush the tags to the xml file
       x_ExcelWorkbook( );

       //?demo create a style
       //?set style properties
       //?ID('Default');
       //?Sname('Normal');
       //?Parent('?'); not tested
       Alignment(Vertical( Bottom )//?justify center
          : Horizontal( Center )) ;//?left right
       Borders(
          Border(Position( Bottom )//?DiagonalLeft DiagonalRight Left Right Top
          :LineStyle( Continuous )//?Dash DashDot DashDotDot Dot Double
          :Weight(1) )
          ) ;
       Font(FontName('Courier New')
          :Family('Swiss')
          :Bold()//?true false
          :Size(11)
          :Italic()//?true false
          :Underline( Single )//?Double  SingleAccounting DoubleAccounting
          :StrikeThrough()//?true false
          :VerticalAlign( Superscript )//?Subscript
          ) ;
       Interior(Color(NAVY )//?names : see demo color
          : Pattern( Solid ) ) ;//?names : see demo motif
       //?numberformat names : look at numberformat predefined in the include
       NumberFormat('yyyy\-mm\-dd\ hh:mm:ss')  ;
       Protection(SProtected(false)//?true false
          : HideFormula(false) ) ;//?true false
       //?now, it is possible to save a style tag property
       courier11 = style.font;
       //?flush the tag to the xml file and clear style data
       MyStyle=x_Style();
       //?in this case, style data is not cleared, next style will be based on current style
       //?MyStyle=x_Style(false);
       //?now the style tag is cleaned, ready for a new style tag.
       //?It is here possible to restore a style tag property

       //?demo naming a range  (at workbook level)
       //?don't type the formulas, do the work with excel, save as xml, open
       //?with notepad, search NamedRange then cut & paste
       Rname('sna_id');
       RefersTo('=ExcelDemo!R1C1:R19C1') ;
       x_NamedRange();

       //?loading a Worksheet
       WName('ExcelDemo')  ;
       //?protected(true); // false
       x_OpenWorksheet() ;//?auto-close previous opened work sheet if any
       // therefore you can not write into 2 sheets simultaneously
       //?if requested, set WorkSheetOptions properties
       Selected() ;
       //?zoom(100);
       //?AllowDeleteCols() // true false
       //?AllowDeleteRows() // true false
       //?AllowInsertCols() // true false
       //?AllowInsertRows() // true false
       //?EnableSelection(NoSelection); // UnlockedCells
       //?ProtectObjects() // true false
       //?ProtectScenarios() // true false
       //?Visible(SheetHidden); // SheetVeryHidden
       DoNotDisplayZeros();
       //?here split the sheet into 4 freezed panes
       //?line count for panes starts from 0, but excel shows from 1
       SplitHorizontal(6);//?split between lines 6 & 7
       TopRowBottomPane(7 );//?bottom is showed from line 8
       SplitVertical(1);//?split between cols 1 & 2
       LeftColumnRightPane(2);//?right is showed from col 3
       ActivePane(BottomRight);
       pane(Pnumber(TopLeft )) ;//?this pane is mandatory
       pane(Pnumber(TopRight )) ;
       pane(Pnumber(Bottomleft )) ;
       //?pane row & pane col  : count from 0
       pane(Pnumber(BottomRight):PRow(9):PCol(2));//?set active cell in active pane

       //?vertical split only :
       //?
       //?SplitVertical(1); // split between cols 1 & 2
       //?LeftColumnRightPane(4); // right is showed from col 5
       //?ActivePane(TopRight);
       //?pane(Pnumber(TopLeft )) ;
       //?pane(Pnumber(TopRight):PRow(9):PCol(2));//?set active cell in active pane

       //?horizontal split only :
       //?
       //?SplitHorizontal(6); // split between lines 6 & 7
       //?TopRowBottomPane(10); // bottom is showed from line 11
       //?ActivePane(BottomLeft);
       //?pane(Pnumber(TopLeft )) ;
       //?pane(Pnumber(BottomLeft):PRow(9):PCol(2));//?set active cell in active pane







       x_WorksheetOptions();

       //?ExpandedColumnCount()
       //?ExpandedRowCount()
       //?FullColumns()
       //?FullRows()
       //?DefaultColumnWidth()
       //?DefaultRowHeight()
       //?LeftCell()
       //?TopCell()
       //?
       x_openTable( );

       // When writing an xlxml program, have in mind that you have
       // to write something in each cell. data or style.
       // So you have a big interest into organizing your coding in 3 steps :
       // 1) calculate the value you want in cells. It's the userdata level.
       //    do this with sql, outside of the xlxml program
       //    don't forget break data, totals,
       // 2) calculate an implantation plan : the list of all the cells
       //    you will target. Do this in sql with
       //    - a list (a table) of each row
       //    - a list of each column
       //    - a cartesian product of these lists : the massplan
       //    - massplan left join userdata
       //    this provide ALL the data, details and totals, values and break data
       // 3) run this file with xlxml program. carefully separate
       //    - styles calculation
       //    - styles choice depending on break levels, totals, ...
       //    - styles usage when loading each cell.
       //

       //?
       //? Width()
       //? AutoFitWidth() // true false
       //? Hidden()       // true false
       //? span()
       //? ColIndex()
       //? x_Column()

       //?RowIndex(GoToLineNumber); // auto-close previous row if any
       //?RowIndex() ; // go to next line +  "
       x_OpenRow();

       //?detailled functions for cell manipulation, rarely used
       //?Index() // next column - auto-close previous cell
       //?Formula()
       //?HRef()
       //?MergeAcross()
       //?MergeDown()
       //?StyleID()
       //?x_OpenCell() ; auto-open next row if necessary; auto-close previous cell if any
       //?type(Boolean) // DateTime Number String Error ;
       //?value('texte')
       //?x_data()
       //?Cauthor('comment author')
       //?ShowAlways(true) // false
       //?html('html tags')
       //?x_comment()
       //?functions you will probably never need
       //?x_CloseCell()
       //?x_CloseRow() // autoclose cell
       //?x_CloseTable // autoclose row
       //?x_CloseWorksheet() autoclose table
       //?mandatory function
       //?x_CloseXlXml() autoclose worksheet
       //?
       //?high level function to load cells
       //?reserved value col=0 means next col
       //?x_string (col:string[:style]);
       //?x_formula(col:string[:style]);
       //?x_number (col:31S10 [:style]);
       //?x_Float  (col:8F    [:style]);
       //?x_DTS    (col:DTS   [:style]);
       //?x_Date   (col:Date  [:style]);
       //?x_Time   (col:Time  [:style]);

       //?demo : change font size, rewrite a cell
       font(size(36));
       Arial36=x_style();

       x_string(0:'Cellule S36':Arial36);
       x_string(0:'Cellule');
       x_string(10:'Bad Boy':Arial36); // to be overwritten later

          x_OpenRow();

       font(size(11));
       MyStyle=x_style();
       x_string(0:'Cellule S11':MyStyle);
       //?because I don't take care of reusing the style, I reuses MyStyle field
       font(size(12));
       MyStyle=x_style();
       x_string(0:'Cellule S12':MyStyle);

       font(size(13)) ;
       MyStyle=x_style();
       x_string(0:'Cellule S13':MyStyle);

       font(size(14));
       MyStyle=x_style();
       x_string(0:'Cellule S14':MyStyle);

       font(size(15):italic());
       MyStyle=x_style();
       x_string(0:'Cellule S15i':MyStyle);

       font(size(16):Bold());
       MyStyle=x_style();
       x_string(0:'Cellule S16b':MyStyle);

       //?span cells
       Borders(
          Border(Position( left ):LineStyle( Continuous ):Weight(2) ) :
          Border(Position( right ):LineStyle( Continuous ):Weight(2) ) :
          Border(Position( top ):LineStyle( Continuous ):Weight(2) ) :
          Border(Position( Bottom ):LineStyle( Continuous ):Weight(2) )
          ) ;
       Alignment(Vertical( center )
          : Horizontal( Center )) ;
       font(size(15));
       MyStyle=x_style();
       MergeAcross(2);//?ie current cell + 2 cells at the right
       x_string(0:'Merge accross 3 cells':MyStyle);
       MergeDown(2);
       x_string(0:'Merge Down 3 cells':MyStyle);
       //?comments

       Cauthor('Jean-Paul Lamontre');
       ShowAlways(false);
       html( // attention, it's xhtml code : tags must be closed (look at BR tag)
          '<B><Font Face="Tahoma" Size="8" Color="#000000">'
          +'Le chef a dit :'
          +'</Font></B><Font Face="Tahoma" Size="8" Color="#000000"><br/>'
          +'bonjo</Font>'
          +'<Font Face="Tahoma" x:Family="Swiss" Size="8" Color="#00FF00">'
          +'ur v</Font><Font Face="Tahoma" Size="8" Color="#000000">'
          +'ous</Font>'      );
       x_string(0:'Commented cell');

       //?demo numeric cell, alignment & formula
       x_OpenRow();

       alignment(horizontal(left));
       NumLeft=x_style( );

       x_Number(2:100:NumLeft) ;

       x_OpenRow();

       alignment(horizontal(center));
       NumCenter=x_style( );
       x_Number(2:100:Numcenter) ;

       x_OpenRow();

       x_formula(2:'=SUM(R[-2]C:R[-1]C)') ;

       //?remember current position
       myrange=activecell();
       //?go back to 1:10, overide cell
       rowindex(1);//?not necessary to x_openrow() if no other property

       x_string(10:'Pretty Woman':Arial36);

       //?continue interrupted loading : reopen next row (after myrange.row)
       rowindex(myRange.row+1);

       //?demo motif
       x_OpenRow();

       interior(pattern(DiagCross ));
       MyStyle=x_style();
       x_string(0: DiagCross :MyStyle);
       x_string(0: DiagCross );

       interior(pattern(DiagStripe )) ;
       MyStyle=x_style();
       x_string(0: DiagStripe :MyStyle);
       x_string(0: DiagStripe );

       interior(pattern(Gray0625 ));
       MyStyle=x_style();
       x_string(0: Gray0625 :MyStyle);
       x_string(0: Gray0625 );

       interior(pattern(Gray125 )) ;
       MyStyle=x_style();
       x_string(0: Gray125 :MyStyle);
       x_string(0: Gray125 );

       interior(pattern(Gray25 )) ;
       MyStyle=x_style();
       x_string(0: Gray25 :MyStyle);
       x_string(0: Gray25 );


       interior(pattern(Gray50 )) ;
       MyStyle=x_style();
       x_string(0: Gray50 :MyStyle);
       x_string(0: Gray50 );

       interior(pattern(Gray75 )) ;
       MyStyle=x_style();
       x_string(0: Gray75 :MyStyle);
       x_string(0: Gray75 );

       interior(pattern(HorzStripe )) ;
       MyStyle=x_style();
       x_string(0: HorzStripe :MyStyle);
       x_string(0: HorzStripe );

       interior(pattern(ReverseDiagStripe )) ;
       MyStyle=x_style();
       x_string(0: ReverseDiagStripe :MyStyle);
       x_string(0: ReverseDiagStripe );

       interior(pattern(solid )) ;
       MyStyle=x_style();
       x_string(0: Solid :MyStyle);
       x_string(0: Solid );

       interior(pattern(ThickDiagCross )) ;
       MyStyle=x_style();
       x_string(0: ThickDiagCross :MyStyle);
       x_string(0: ThickDiagCross );

       interior(pattern(ThinDiagCross )) ;
       MyStyle=x_style();
       x_string(0: ThinDiagCross :MyStyle);
       x_string(0: ThinDiagCross );

       interior(pattern(ThinDiagStripe )) ;
       MyStyle=x_style();
       x_string(0: ThinDiagStripe :MyStyle);
       x_string(0: ThinDiagStripe );

       interior(pattern(ThinHorzCross )) ;
       MyStyle=x_style();
       x_string(0: ThinHorzCross :MyStyle);
       x_string(0: ThinHorzCross );

       interior(pattern(ThinHorzStripe )) ;
       MyStyle=x_style();
       x_string(0: ThinHorzStripe :MyStyle);
       x_string(0: ThinHorzStripe );

       interior(pattern(ThinReverseDiagStripe)) ;
       MyStyle=x_style();
       x_string(0: ThinReverseDiagStripe :MyStyle);
       x_string(0: ThinReverseDiagStripe );

       interior(pattern(ThinVertStripe )) ;
       MyStyle=x_style();
       x_string(0: ThinVertStripe :MyStyle);
       x_string(0: ThinVertStripe );

       interior(pattern(VertStripe )) ;
       MyStyle=x_style();
       x_string(0: VertStripe :MyStyle);
       x_string(0: VertStripe );


       //?demo date
       NumberFormat(DateTimeIso);
       MyStyle=x_style();
       x_openrow();
       x_dts(0:%timestamp());
       x_dts(0:%timestamp():MyStyle);

       NumberFormat(ShortDate);
       MyStyle=x_style();
       x_openrow();
       x_date(0:%date());
       x_date(0:%date():MyStyle);

       NumberFormat(ShortTime);
       MyStyle=x_style();
       x_openrow();
       x_time(0:%time());
       x_time(0:%time():MyStyle);

       //?demo conditionnal style
       x_openrow();
       MyFloat=-2.225073858507201E-306;
       x_float(0:MyFloat);
       MyFloat=+1.797693134862315E+307;
       x_float(0:MyFloat);

       MyRange=ActiveCell();

       x_Range(MyRange.cell);
       Qualifier('Between') ;
       Value1('1')          ;
       Value2('3')           ;
       Format(
          fcolor( red )
          :font_weight(700)
          :text_underline_style( single )
          :text_line_through( single )
          ) ;
       x_Condition();


       //?demo colors
       DemoColor('black'             : black           );
       DemoColor('navy'              : navy            );
       DemoColor('blue'              : blue            );
       DemoColor('darkgreen'         : darkgreen       );
       DemoColor('darkblue'          : darkblue        );
       DemoColor('mediumblue'        : mediumblue      );
       DemoColor('forestgreen'       : forestgreen     );
       DemoColor('darkseagreen'      : darkseagreen    );
       DemoColor('darkcyan'          : darkcyan        );
       DemoColor('green'             : green           );
       DemoColor('cyan'              : cyan            );
       DemoColor('maroon'            : maroon          );
       DemoColor('darkgrey'          : darkgrey        );
       DemoColor('lightnavy'         : lightnavy       );
       DemoColor('lightblue'         : lightblue       );
       DemoColor('seagreen'          : seagreen        );
       DemoColor('lightcyan'         : lightcyan       );
       DemoColor('violet'            : violet          );
       DemoColor('blueviolet'        : blueviolet      );
       DemoColor('darkred'           : darkred         );
       DemoColor('purple'            : purple          );
       DemoColor('khaki'             : khaki           );
       DemoColor('grey'              : grey            );
       DemoColor('lightgrey'         : lightgrey       );
       DemoColor('firebrick'         : firebrick       );
       DemoColor('orchid'            : orchid          );
       DemoColor('lightblueviolet'   : lightblueviolet );
       DemoColor('greenyellow'       : greenyellow     );
       DemoColor('skyblue'           : skyblue         );
       DemoColor('azuregrey'         : azuregrey       );
       DemoColor('lightpurple'       : lightpurple     );
       DemoColor('thistle'           : thistle         );
       DemoColor('gainsboro'         : gainsboro       );
       DemoColor('azure'             : azure           );
       DemoColor('red'               : red             );
       DemoColor('magenta'           : magenta         );
       DemoColor('orange'            : orange          );
       DemoColor('salmon'            : salmon          );
       DemoColor('oldgold'           : oldgold         );
       DemoColor('pink'              : pink            );
       DemoColor('gold'              : gold            );
       DemoColor('wheat'             : wheat           );
       DemoColor('yellow'            : yellow          );
       DemoColor('cornsilk'          : cornsilk        );
       DemoColor('snow'              : snow            );
       DemoColor('white'             : white           );

       //?demo numberformat
       rowindex(10);
       x_openrow();
       numberformat( standard );
       MyStyle=x_style();
       x_string(5:                     'standard'          );
       x_string(0: standard );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( general );
       MyStyle=x_style();
       x_string(5:                     'general'           );
       x_string(0: general );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( zerodec );
       MyStyle=x_style();
       x_string(5:                     'zerodec'           );
       x_string(0: zerodec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( GNumber );
       MyStyle=x_style();
       x_string(5:                     'GNumber'           );
       x_string(0: GNumber );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( twodec );
       MyStyle=x_style();
       x_string(5:                     'twodec'            );
       x_string(0: twodec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( zerodecsep );
       MyStyle=x_style();
       x_string(5:                     'zerodecsep'        );
       x_string(0: zerodecsep );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( twodecsep );
       MyStyle=x_style();
       x_string(5:                     'twodecsep'         );
       x_string(0: twodecsep );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( Eur0dec );
       MyStyle=x_style();
       x_string(5:                     'Eur0dec'           );
       x_string(0: Eur0dec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( Eur0decRed );
       MyStyle=x_style();
       x_string(5:                     'Eur0decRed'        );
       x_string(0: Eur0decRed );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( Eur2Dec );
       MyStyle=x_style();
       x_string(5:                     'Eur2Dec'           );
       x_string(0: Eur2Dec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat(Currency );
       MyStyle=x_style();
       x_string(5:                     'Currency'           );
       x_string(0:Currency );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( pct0dec );
       MyStyle=x_style();
       x_string(5:                     'pct0dec'           );
       x_string(0: pct0dec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( pct2dec );
       MyStyle=x_style();
       x_string(5:                     'pct2dec'           );
       x_string(0: pct2dec );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( scientific );
       MyStyle=x_style();
       x_string(5:                     'scientific'        );
       x_string(0: scientific );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( scientific3 );
       MyStyle=x_style();
       x_string(5:                     'scientific3'       );
       x_string(0: scientific3 );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( frac1 );
       MyStyle=x_style();
       x_string(5:                     'frac1'             );
       x_string(0: frac1 );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( frac2 );
       MyStyle=x_style();
       x_string(5:                     'frac2'             );
       x_string(0: frac2 );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( ShortDate );
       MyStyle=x_style();
       x_string(5:                     'ShortDate'         );
       x_string(0: ShortDate );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( MediumDate );
       MyStyle=x_style();
       x_string(5:                     'MediumDate'        );
       x_string(0: MediumDate );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( longDate );
       MyStyle=x_style();
       x_string(5:                     'longDate'        );
       x_string(0: LongDate );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( ddmmm );
       MyStyle=x_style();
       x_string(5:                     'ddmmm'             );
       x_string(0: ddmmm );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( mmmyy );
       MyStyle=x_style();
       x_string(5:                     'mmmyy'             );
       x_string(0: mmmyy );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( mediumtime );
       MyStyle=x_style();
       x_string(5:                     'mediumtime'        );
       x_string(0: mediumtime );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( longtime );
       MyStyle=x_style();
       x_string(5:                     'longtime'          );
       x_string(0: longtime );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( shorttime );
       MyStyle=x_style();
       x_string(5:                     'shorttime'         );
       x_string(0: shorttime );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( Date );
       MyStyle=x_style();
       x_string(5:                     'Date'          );
       x_string(0: Date );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( hours );
       MyStyle=x_style();
       x_string(5:                     'hours'             );
       x_string(0: hours );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( text );
       MyStyle=x_style();
       x_string(5:                     'text'              );
       x_string(0: text );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( BigHours );
       MyStyle=x_style();
       x_string(5:                     'BigHours'          );
       x_string(0: BigHours );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( dateiso );
       MyStyle=x_style();
       x_string(5:                     'dateiso'           );
       x_string(0: dateiso );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( houriso );
       MyStyle=x_style();
       x_string(5:                     'houriso'           );
       x_string(0: houriso );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( datehouriso );
       MyStyle=x_style();
       x_string(5:                     'datehouriso'       );
       x_string(0: datehouriso );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( timeiso );
       MyStyle=x_style();
       x_string(5:                     'timeiso'           );
       x_string(0: timeiso );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( datetimeiso );
       MyStyle=x_style();
       x_string(5:                     'datetimeiso'       );
       x_string(0: datetimeiso );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( TrueFalseNF );
       MyStyle=x_style();
       x_string(5:                     'truefalseNF'       );
       x_string(0: truefalsenf );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       x_openrow();
       numberformat( onoff );
       MyStyle=x_style();
       x_string(5:                     'OnOff      '       );
       x_string(0: onoff );
       x_number(0:38771.12345:mystyle) ;
       x_number(0:-38771.12345:mystyle) ;
       x_number(0:0:mystyle) ;
       x_string(0:'Hello, <"How''> are you ?':mystyle);

       //?check the limits
       rowindex(65536);
       // clear mystyle;//?test message for undefined style
       // x_string(256:'TheEnd':mystyle);
       x_string(256:'TheEnd');

       //?*=----------------------------------------------------------------------------------=*
       //?some sql procedure
       //?*=----------------------------------------------------------------------------------=*
       proc();


       //?to be done before x_closetable(), only ONE time per table.
       x_autofitcolumn();



       //?optional functions
       //?x_CloseTable // autoclose row
       //?x_CloseWorksheet() autoclose table
       x_CloseXlXml();

       //?copy temporary xml data to the ifs file
       x_Copy2Ifs(FileName);

       //?end abnormaly the program if *DIAG have been sent to the job log
       //?this procedure must be called in the main procedure to obtain
       //?a message sent to the caller and no dump
       x_returncode();
       *inlr = *on;

      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
    ??*=----------------------------------------------------------------------------------=*
    ? * working procedure : SQL read, format & write
    ??*=----------------------------------------------------------------------------------=*
BPR  P Proc            B
     D Proc            PI

     d MySFW           s           5000

     d row             s              5u 0 inz(50)
     d col             s              5u 0 inz(05)

     d  USERID         s              8
     d  ADDRESS        s              8
     d  usrprf         s             10
     d  MAIL           s            281    VARying
     d  curdate        s               d
     d  curtime        s               t
     d  curdts         s               z
     d  curpath        s           3843    VARying
     d  curschema      s            128    VARying
     d  curserver      s             18    VARying
     d  curtimz        s              6p 0
     d  curuser        s             18    VARying
     d  packed         s              7p 0
     d  zoned          s              7s 0
     d  float          s              8f
     d  Integer        s             20i 0

     d  String         s            256    varying
     d  Exceldate0     s               d   inz(d'1899-12-30')

     d  SDate          s                   like(x_style)
     d  STime          s                   like(x_style)
     d  SDTS           s                   like(x_style)
     d  STitre         s                   like(x_style)

      /free

       font(size(12):bold());
       STitre=x_style();

       numberformat(dateiso);
       SDate=x_style();

       numberformat(houriso);
       STime=x_style();

       numberformat(dateHourIso);
       SDTS = x_style();

       mySelect='SELECT '
         + '   current date today'
         + ' , current time now'
         + ' , current timestamp a_timestamp'
         + ' , current path the_path'
         + ' , current schema the_schema'
         + ' , current server the_server'
         + ' , current timezone our_time_zone'
         + ' , decimal(days(current date), 7, 0) a_decimal_data'
         + ' , zoned(days(current date), 7, 0) a_zoned_data'
         + ' , double(days(current date) ** 12 ) float8_data'
         + ' , bigint(days(current date) ** 3 ) Integer8_data'
          + ' from qsys2/QSQPTABL' ;




       // + '  current date today '
       // + ', current time now '
       // + ', current timestamp a_timestamp '
       // + ', user me '
       // + ', decimal(days(current date), 7, 0) a_decimal_data '
       // + ', zoned(days(current date), 7, 0) a_zoned_data '
       // + ', double(days(current date) ** 12 ) float8_data '
       // + ', bigint(days(current date) ** 3 ) Integer8_data'
       // + ', cast( UX''015B01480111'' as varchar(50) ccsid 870) poland'
       // + ', cast( UX''03910392039303940395'' as varchar(50) '
       // + ' ccsid 875   ) grece '
       // + ', cast(UX''B300D55CBBFCAD6D'' as varchar(50) '
       // + ' ccsid 933   ) korea '
       // + ', cast(UX''4E2D570B00204E2D570B'' as varchar(50) '
       // + ' ccsid 935   ) chinese_simplified '
       // + ', cast(UX''4E2D570B00204E2D570B'' as varchar(50) '
       // + ' ccsid 937   ) chinese_traditional '
       // + ', cast( UX''65E5672C002065E5672C'' as varchar(50) '
       // + ' ccsid 1399 ) japan1399 '
       // + ', cast( UX''65E5672C002065E5672C'' as varchar(50) '
       // + ' ccsid 5035 ) JAPAN5035 '
       // + ', cast( UX''015B0148011103910392039303940395B300D55CBBFC'' '
       // + 'concat  UX''AD6D4E2D570B00204E2D570B65E5672C002065E5672C'' '
       // + ' as vargraphic(50) ccsid 13488) UCS2 '
       // + ', cast( UX''015B0148011103910392039303940395B300D55CBBFC'' '
       // + 'concat  UX''AD6D4E2D570B00204E2D570B65E5672C002065E5672C'' '
       // + ' as vargraphic(50) ccsid 1200) UTF16 '
       // + ', cast( UX''015B0148011103910392039303940395B300D55CBBFC'' '
       // + 'concat  UX''AD6D4E2D570B00204E2D570B65E5672C002065E5672C'' '
       // + ' as varchar(100) ccsid 1208) UTF8 '
       // + ' from qsys2/QSQPTABL' ;

       mySFW = mySelect;
       message(*blank : mySFW:'':'':'*INFO');

      /end-free
     C/EXEC SQL
     C+ declare k1 cursor for k1prepa
     C/END-EXEC
     C/EXEC SQL
     C+ prepare k1prepa from : mySFW
     C/END-EXEC
      /free
B01    if sqlcod<>0;
          callp escsqler (sqlcod);
E01    endif;

       //?selda is zero bytes ! avoid out of memory  pointer (MCH36..)
       callp ReallocSELDA( 100);
      /end-free
     C/EXEC SQL
     C+ describe k1prepa into : selda using names
     C/END-EXEC
      /free
B01    if sqlcod<>0 ;
          callp escsqler (sqlcod) ;
E01    endif ;
       //?retrieve the name & type of each column
       rowindex(row);
       cellindex(col);
B01    for ifor = 1 to sqld;
          x_string(0: lcase(sqlname(ifor)):STitre);
E01    endfor;
      /end-free
     C/EXEC SQL
     C+ OPEN K1
     C/END-EXEC
     c/free
       x_openrow();
       x_string(col:'List is empty');

      /end-free
B01  c                   do        *hival
     C/EXEC SQL
     C+  FETCH K1 INTO
     C+                : curdate
     C+              , : curtime
     C+              , : curdts
     C+              , : curpath
     C+              , : curschema
     C+              , : curserver
     C+              , : curtimz
     C+              , : packed
     C+              , : zoned
     C+              , : float
     C+              , : integer
     C/END-EXEC
     c/free
B02       if sqlcod=100 ;
             leave ;
E02       endif ;
B02       if sqlcod<>0 ;
             callp escsqler (sqlcod) ;
E02       endif ;
          x_date ( col+0 : curdate :Sdate);
          x_time ( col+1 : curtime :STime);
          x_dts ( col+2 : curdts :SDTS );
          x_string( col+3 : %trim(curpath) );
          x_string( col+4 : %trim(curschema) );
          x_string( col+5 : curserver );
          x_number( col+6 : curtimz );
          x_number( col+7 : packed );
          x_number( col+8 : zoned );
          x_float( col+9 : float);
          x_number( col+10: integer );
          x_openrow();

B02       if xlxml.currow - row > 15;
             leave;
E02       endif;

      /end-free
E01  c                   enddo
     C/EXEC SQL
     C+ close K1
     C/END-EXEC
      /free
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  P                 E

BPR  P DemoColor       B
     D DemoColor       Pi
     D   TheName                           like(tag) const
     D   TheColor                          like(tag) const
      /free


       interior(pattern(solid):color( TheColor ));
       MyStyle=x_style();
       x_openrow();
       x_string(0:TheName :MyStyle);
       x_string(0:TheName + '='+ TheColor     );
       Font(color( TheColor ));
       MyStyle=x_style();
       x_string(0:TheName + '='+ TheColor:mystyle);
       //?x_number(0:0);
       interior(pattern(solid):color( Black ));
       Font(color( TheColor ));
       MyStyle=x_style();
       x_string(0:TheName + '='+ TheColor:mystyle);
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  P                 E
