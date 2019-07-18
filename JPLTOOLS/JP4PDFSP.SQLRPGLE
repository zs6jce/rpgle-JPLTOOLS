    ? *=------------------------------------------------------------------------------------------=*
    ? *
    ? *  If you need to change anything in this code, feed back !
    ? *  so, I will take care of the update in next version
    ? *
    ? *=------------------------------------------------------------------------------------------=*
    ? * TODO
    ? *=------------------------------------------------------------------------------------------=*
      * major change
      * 2015
      *   plugging external fonts works. not easy, need a full test of each font, but works.
      *   this feature is not free. ask for it.
      * 2013-04-21
      *   procedure PdfTextStrLen requiers a font object instead of a font name
      *   ... if ever someone used the 2nd and 3th parm
    ? *=------------------------------------------------------------------------------------------=*
     d PdfS1           s            100    varying      Based( Template )
     d PdfS2           s           1000    varying      Based( Template )
     d PdfS3           s          65000    varying      Based( Template )
    ?d* attn, hard coded redefinition of pdfU2 in proc PdfTextAddU16
     d PdfU2           s           1000c   varying      Based( Template )
     d                                     ccsid(1200)
     d PdfStream       s                   like(PdfS3)  Based( Template )
     d PdfObj          s             10i 0              Based( Template )
     D PdfContent      ds                  qualified    Based( Template )
     d    Obj                              like(pdfobj)
     d    length                           like(pdfobj)
     d    stream                           like(pdfs3 )

     D PdfFont         ds                  qualified    Based(pPdfFont  )
     d    Obj                              like(pdfobj)
     d    SubType                          like(pdfs1 )
     d    Basefont                         like(pdfs1 )
     d    Encoding                         like(pdfs1 )
     d    Name                             like(pdfs1 )
     d    IsUnicode                    n
      /IF DEFINED(*V6R1M0)
     d    ForceLRE                     n
     d    TTFName                          like(pdfs1 )
     d    TTFccsid                    5u00
     d    pgsub                        *
     d*fontmetrics
     d  AvgWidth                      5i 0
     d  FontWeight                    5i 0
     d  FirstChar                     5u 0
     d  LastChar                      5u 0
     d  Ascent                        5i 0
     d  Descent                       5i 0
     d  NumGlyphs                     5u 0
     d  IndexToLocFmt                 5i00
     d  xMin                          5i00
     d  yMin                          5i00
     d  xMax                          5i00
     d  yMax                          5i00
     d  nbrHMetrics                   5i00

     d  CapsHeight                    5i00
     d  Flags                        10u00
     d  StemV                         5i00
     d  ItalicAngle                   5i00
     d  MissingWidth                  5i00
     d  FlateDecode                   5i00
     d  EmbedFont                     5i00
     d  FontSubset                    5i00
     d  width                         5u00 dim(65535)
     d  adjust                        5i00 dim(65535)
     d  bc                            3u00 dim(65535)
     d  bmg                           5u00 dim(65535)
     d  U2G                           5u00 dim(65535)
     d  G2U                           5u00 dim(65535)

       // add LRE at position 1
       // CP   NAME                    BC
       // 202A LEFT-TO-RIGHT EMBEDDING LRE
       // 202B RIGHT-TO-LEFT EMBEDDING RLE
       // to inform BIDI to give preference to Left-Right writing of non-arabic words
     d PdfLRE          s              1c   ccsid(1200) inz(u'202a')
     d PdfRLE          s              1c   ccsid(1200) inz(u'202b')
      /endif

     D PdfProcset      ds                  qualified    based(template)
     d    Count                            like(pdfobj)
     d    Set                              like(pdfs1 ) dim(10)
     D PdfResource     ds                  qualified
     d                                     Based( Template )
     d    Obj                              like(pdfobj)
     d    Procset                          like(pdfs1 )
     d    XObject                          like(pdfs2 )
     d    Font                             like(pdfs2 )
     D PdfImage        ds                  qualified
     d                                     Based( Template )
     d    Obj                              like(pdfobj)
     d    Width                            like(pdfobj)
     d    Height                           like(pdfobj)
     d    BPC                              like(pdfobj)
     d    ColorSPace                       like(pdfs1 )
     d    Filter                           like(pdfS1 )
     d    Name                             like(pdfs1 )
     d    preloaded                    n
     d    preloadable                  n
     d    damaged                      n
     D    FileName                  512a   varying
     d    Stream                  64000    varying                              pdfs3 is too long
     D PdfCloseFile    pr
     d PdfCloseOutLines...
     d                 pr
     d PdfClosePage    pr
     d PdfClosePages   pr
     d PdfCloseResource...
     d                 pr
     d   theResource                       likeds(PdfResource)
     d PdfCloseRoot    pr
     d p1                                  like(pdfs1) const options(*nopass)
     d PdfDrawAddBezier...
     d                 pr                  like(pdfs1)
     d x1                             5i 0 value
     d y1                             5i 0 value
     d x2                             5i 0 value
     d y2                             5i 0 value
     d x3                             5i 0 value
     d y3                             5i 0 value
     d PdfDrawAddLine...
     d                 pr                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d PdfDrawAddRectangle...
     d                 pr                  like(pdfs1)
     d x                              6p 1 value
     d y                              6p 1 value
     d w                              6p 1 value
     d h                              6p 1 value
     d PdfDrawClosePath...
     d                 pr                  like(pdfs1)
     d p1                                  like(pdfs1) const
     d p2                                  like(pdfs1) const options(*nopass)
     d p3                                  like(pdfs1) const options(*nopass)
     d PdfDrawCloseSubPath...
     d                 pr                  like(pdfs1)
     d PdfDrawDashedLine...
     d                 pr                  like(pdfs1)
     d black                          5u 0 value options(*nopass)
     d white                          5u 0 value options(*nopass)
     d start                          5u 0 value options(*nopass)
     d PdfDrawGoto     pr                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d PdfDrawImage    pr                  like(pdfs1)
     d theImage                            likeds(pdfImage) const
     d x                              5i 0 value
     d y                              5i 0 value
     d zoom                           5p 4 value options(*nopass)
     d VerticalZoom                   5p 4 value options(*nopass)
     d PdfDrawLineCap  pr                  like(pdfs1)
     d LineCap                             like(pdfS1) const
     d PdfDrawLineJoin...
     d                 pr                  like(pdfs1)
     d LineJoin                            like(pdfS1) const
     d PdfDrawLineWidth...
     d                 pr                  like(pdfs1)
     d width                          5p 0 value
     d PdfDrawMiterLimit...
     d                 pr                  like(pdfs1)
     d limit                          5p 3 value
    ?
    ?
    ?
    ?
    ?
    ?
    ?
    ?
    ?
    ?
     dPdfPreLoadBmp24  pr                  likeds(PdfImage)
     D  FileName                    512a   varying const
     dPdfMemLoadBMP24  pr
     D TheImage                            likeds(PdfImage)

     dPdfPreLoadJpeg   pr                  likeds(PdfImage)
     D  FileName                    512a   varying const
     dPdfMemLoadJpeg   pr
     D TheImage                            likeds(PdfImage)
     d PdfLoadContent  pr                  likeds(pdfContent)
     d   thestream                         like(pdfS3 ) const
     d    inHexa                       n   options(*nopass) const
     d PdfNewFile      pr
     D  FileName                    512a   varying const
     D  Title                       512a   varying const options(*nopass)
     d  permission                   10i 0 options(*nopass) const
     d  p_userpwd                    32    options(*nopass) const
     d  p_OwnerPwd                   32    options(*nopass) const
     d  p_OpenMode                   10i 0 options(*nopass) const
    ? * target for OpenMode :
    ? *   Data authority is fixed when the file is created.
    ? *     if you want to be sure of resulting authority on pdf file,
    ? *     you must use PdfOpen_Unlink to force the file deletion.
    ? *   for sensitive files, if you want to force the file to have public exclude,
    ? *     you can use PdfOpen_ObjAut to force a CHGAUT to remove any public authority
    ? *     because the Open take care of data authority, but apply *PUBLIC*ALL to object level
    ? *   for "normal" files, classic MODE values can be used.
    ? *   Default value if Openmode is not given is
    ? *     Unlink + Public:Exclude + owner:Read-Write-eXecute
    ? * values for OpenMode :
    ? * 0 to 511 : equal to MODE flags for authority - see JP4IFS, lines 86 & below
     d PdfOpen_Unlink  c                   512
     d PdfOpen_ObjAut  c                   1024
     d PdfLoadFont1    pr                  likeds(pdfFont)
     d   name                              like(pdfs1) const
     d   font                              like(pdfs1) const
     d   attr1                             like(pdfs1) const options(*nopass)
     d   attr2                             like(pdfs1) const options(*nopass)
     d   attr3                             like(pdfs1) const options(*nopass)
     d PdfLoadFont2    pr                  likeds(pdfFont)
     d   name                              like(pdfs1) const
     d   font                              like(pdfs1) const
     d   encoding                          like(pdfs1) const
      /IF DEFINED(*V6R1M0)
      // external ttf font
     d PdfLoadFont3    pr
     d   name                              like(pdfs1) const
     d   pgmname                     21                const
     d   ifsname                           like(pdfs2) const
     d   font                              likeds(pdffont)
      /endif

     d PdfNewOutline   pr
     d   theTitle                          like(PdfS1) const
     d PdfNewPage      pr
     d   theformat                         like(PdfS1) const
     d   theTitle                          like(PdfS1) const
     d   width                        5i 0 const options(*nopass)
     d   height                       5i 0 const options(*nopass)
     d   leftmargin                   5i 0 const options(*nopass)
     d   rightmargin                  5i 0 const options(*nopass)
     d   topmargin                    5i 0 const options(*nopass)
     d   bottommargin                 5i 0 const options(*nopass)
     d PdfNewPages     pr
     d PdfLoadProcset  pr                  likeds(pdfProcSet)
     d   p1                                like(pdfs1) const options(*nopass)
     d   p2                                like(pdfs1) const options(*nopass)
     d   p3                                like(pdfs1) const options(*nopass)
     d   p4                                like(pdfs1) const options(*nopass)
     d   p5                                like(pdfs1) const options(*nopass)
    ?
     d PdfNewOutlines  pr
     d PdfNewResource  pr                  likeds(PdfResource)
     d   theProcSet                        likeds(pdfProcSet) const
     d PdfNewRoot      pr
    ?
    ?
     d PdfPageContent...
     d                 pr
     d    theContent                       likeds(PdfContent) const
     d PdfPageResource...
     d                 pr
     d    theresource                      likeds(PdfResource) const
    ?
    ?
    ?
     d PdfResourceAddFont...
     d                 pr
     d   theResource                       likeds(PdfResource)
     d   thefont                           likeds(pdfFont) const
     d PdfResourceAddImage...
     d                 pr
     d   theResource                       likeds(PdfResource)
     d   theimage                          likeds(pdfImage) const
     d PdfStrmFillingColorGray...
     d                 pr                  like(pdfs1)
     d gray                           5p 4 value
     d PdfStrmFillingColorRGB...
     d                 pr                  like(pdfs1)
     d red                            5p 4 value
     d green                          5p 4 value
     d blue                           5p 4 value
     d PdfStrmFillingColorCMYK...
     d                 pr                  like(pdfs1)
     d cyan                           5p 4 value
     d magenta                        5p 4 value
     d yellow                         5p 4 value
     d black                          5p 4 value
     d PdfStrmStrokingColorGray...
     d                 pr                  like(pdfs1)
     d gray                           5p 4 value
     d PdfStrmStrokingColorRGB...
     d                 pr                  like(pdfs1)
     d red                            5p 4 value
     d green                          5p 4 value
     d blue                           5p 4 value
     d PdfStrmStrokingColorCMYK...
     d                 pr                  like(pdfs1)
     d cyan                           5p 4 value
     d magenta                        5p 4 value
     d yellow                         5p 4 value
     d black                          5p 4 value
     d PdfStrmRestoreGraphicState...
     d                 pr                  like(pdfs1)
    ?
    ?
    ?
    ?
     d PdfStrmRotate...
     d                 pr                  like(pdfs1)
     d alpha                          8f   value
    ?
    ?
    ?
    ?
     d PdfStrmSaveGraphicState...
     d                 pr                  like(pdfs1)
     d PdfStrmScale...
     d                 pr                  like(pdfs1)
     d x                              7p 2 value
     d y                              7p 2 value
     d PdfStrmSkew...
     d                 pr                  like(pdfs1)
     d alpha                          8f   value
     d beta                           8f   value


     d PdfStrmTranslate...
     d                 pr                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d PdfTextAdd...
     d                 pr                  like(pdfs3)
     d text                                like(pdfs2) const
     d PdfTextAddU8...
     d                 pr                  like(pdfs3)
     d text                                like(pdfs2) const
     d PdfTextAddU16...
     d                 pr                  like(pdfs3)
     d text                                like(pdfU2) const




     d PdfTextCharSpace...
     d                 pr                  like(pdfS1)
     d    spacing                     5s 3 value
     d PdfTextClose...
     d                 pr                  like(pdfs1)
     d PdfTextCondensed...
     d                 pr                  like(pdfS1)
     d    spacing                     5i 0 value
     d PdfFontSize     pr             5i 0
     d PdfFontName     pr           100    varying
     d PdfTextFont...
     d                 pr                  like(pdfs1)
     d font                                likeds(pdffont)
     d size                           5i 0 value
     d lead                           5i 0 value options(*nopass)
     d PdfTextRow      pr                  like(pdfobj)
     d PdfTextCol      pr                  like(pdfobj)
     d PdfTextGoTo     pr                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d PdfTextMoveTo   pr                  like(pdfs1)
     d x                              5i 0 value
     d y                              5i 0 value
     d PdfCanvas       pr                  like(pdfstream)
     d font                                likeds(PdfFont)
     d Hspacing                       5i 0 value
     d Vspacing                       5i 0 value
     d PdfTextNewLine...
     d                 pr                  like(pdfs1)
     d PdfTextToLeft...
     d                 pr                  like(pdfs1)
     d PdfTextOpen...
     d                 pr                  like(pdfs1)
     d PdfTextRendering...
     d                 pr                  like(pdfs1)
     d p1                                  like(pdfs1) const options(*nopass)
     d p2                                  like(pdfs1) const options(*nopass)
     d PdfTextWordSpace...
     d                 pr                  like(pdfS1)
     d    spacing                     5s 3 value
    ?
    ?
    ?
    ?
    ?
     D PdfTextStrlen   pr             8f
     d Str                                 like(PdfS2) const
     d fontSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d font                                likeds(pdffont) const

     d                                     options(*nopass)
    ? * same as previous but incorporate a trim of the string
     D PdfTextFStrlen  pr             8f
     d Str                                 like(PdfS2) const
     d fontSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d font                                likeds(pdffont) const

     d                                     options(*nopass)
    ? *
     d PdfTextStrlenU16...
     d                 pr             8f
     d  Str                                like(pdfu2) const
     d  fntSiz                             like(PdfFontSize)
     d                                     options(*nopass) const
     d font                                likeds(pdffont) const

     d                                     options(*nopass)
     D PdfTextCenter   pr             5i 0
     d endpos                         5i 0 value
     d Str                                 like(PdfS1) const
     D PdfTextRight    pr             5i 0
     d endpos                         5i 0 value
     d Str                                 like(PdfS1) const
     D PdfTextRightU16...
     D                 pr             5i 0
     d endpos                         5i 0 value
     d Str                                 like(PdfU2) const


    ?d*Pdf------------------------------------------------------------------------------------------
    ?d*Pdf common declarations
    ?d*Pdf------------------------------------------------------------------------------------------
      /if not defined(NoBasicFont)
      * font size is now 750Kb instead of 500 bytes. 18 fonts is a big quantity of memory
    ? * 4 ARIAL   font (normal, bold, italic, bold-italic)
     d PdfArial        ds                  likeds(PdfFont)
     d PdfArialB       ds                  likeds(PdfFont)
     d PdfArialI       ds                  likeds(PdfFont)
     d PdfArialBI      ds                  likeds(PdfFont)
    ? * 4 courier font (normal, bold, italic, bold-italic)
     d PdfCourier      ds                  likeds(PdfFont)
     d PdfCourierB     ds                  likeds(PdfFont)
     d PdfCourierI     ds                  likeds(PdfFont)
     d PdfCourierBI    ds                  likeds(PdfFont)
    ? * 4 Helvet (or arial)
     d PdfHelvet       ds                  likeds(PdfFont)
     d PdfHelvetB      ds                  likeds(PdfFont)
     d PdfHelvetI      ds                  likeds(PdfFont)
     d PdfHelvetBI     ds                  likeds(PdfFont)
    ? * 4 times
     d PdfTimes        ds                  likeds(PdfFont)
     d PdfTimesB       ds                  likeds(PdfFont)
     d PdfTimesI       ds                  likeds(PdfFont)
     d PdfTimesBI      ds                  likeds(PdfFont)
    ? * 1 symbol
     d PdfSymbol       ds                  likeds(PdfFont)
    ? * 1 dingbat
     d PdfZapf         ds                  likeds(PdfFont)
      /endif
    ?d* CONSTANTS
     d pdf_Arial       c                   'arial'
     d pdf_Courier     c                   'courier'
     d pdf_Helvet      c                   'helvetica'
     d pdf_Times       c                   'times'
     d pdf_Symbol      c                   'symbol'
     d pdf_zapf        c                   'zapfdingbats'
     d pdf_bold        c                   'bold'
     d pdf_italic      c                   'italic'
     d pdf_fixedpitch  c                   'widths'
    ? * constants for unicode external fonts
     d pdf_AdobePiStd  c                   '/AdobePiStd'
     d pdf_ArialUnicodeMS...
     d                 c                   '/ArialUnicodeMS'
     d pdf_unicns      c                   'UniCNS-UTF16-H'
     d pdf_unigb       c                   'UniGB-UTF16-H'
     d pdf_unijis      c                   'UniJIS-UTF16-H'
     d pdf_uniks       c                   'UniKS-UTF16-H'





     d pdf_Procpdf     c                   'PDF'
     d pdf_Proctext    c                   'Text'
     d pdf_ProcImageB  c                   'ImageB'
     d pdf_ProcImageC  c                   'ImageC'
     d pdf_ProcImageI  c                   'ImageI'
     d pdf_Stroke      c                   'Stroke'
     d pdf_Fill        c                   'FillNotZero'
     d pdf_FillEvenOdd...
     d                 c                   'FillEvenOdd'
     d pdf_Close       c                   'Close'
     d pdf_Custom      c                   'cus'
     d pdf_A4Portrait  c                   'A4P'
     d pdf_A4Landscape...
     d                 c                   'A4L'
     d Pdf_LineCapButt...
     d                 c                   'ButtCap'
     d Pdf_LineCapRound...
     d                 c                   'RoundCap'
     d Pdf_LineCapProjecting...
     d                 c                   'ProjectingCap'
     d Pdf_JoinMiter   c                   'MiterJoin'
     d Pdf_JoinRound   c                   'RoundJoin'
     d Pdf_JoinBevel   c                   'BevelJoin'
    ? * values for Alignment
     d Pdf_CENTER      C                   'Center'
     d Pdf_LEFT        c                   'Left'
     d Pdf_RIGHT       c                   'Right'
     d Pdf_TOP         c                   'Top'
     d Pdf_BOTTOM      c                   'Bottom'
    ? * values for PageMode at CloseRoot
     d Pdf_None        c                   '/UseNone'
     d Pdf_Outlines    c                   '/UseOutlines'
     d Pdf_Thumbs      c                   '/UseThumbs'
     d Pdf_FullScreen  c                   '/FullScreen'

     d PdfHexa         pr             2
     d  txt                           1            const
     d WinBin4         pr            10u 0
     d  x4                            4    value

    ?d* autorisations resultantes :
    ? *list of properties, in the order and with the names showed by Reader9FR
    ? *               2048 1024 0512 0256 0128 0064 0032 0016 0008 0004 0002 0001 -3904
    ? * Reader 9........v    v    v    v    v    v    v    v    v    v    v    v     v
    ? * Pro 8............v   .v    v    v    v    v   .v    v    v    v    v    v    .v
    ? *                 ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..    ..
    ? * impression      ..   ..   ..   ..   ..   ..   ..   ..   ..   xx   ..   ..    ..
    ? * modification    ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..    ..
    ? * assemblage      ..   .x   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..    ..
    ? * copie           ..   ..   ..   ..   ..   ..   ..   xx   xx   ..   ..   ..    ..
    ? * accessibilité   ..   ..   xx   ..   ..   ..   ..   xx   xx   ..   ..   ..    ..
    ? * extraction      ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..   ..    ..
    ? * commentaires    ..   ..   ..   ..   ..   ..   .x   ..   ..   ..   ..   ..    ..
    ? * remplissage     ..   ..   ..   xx   xx   xx   xx   ..   ..   ..   ..   ..    ..
    ? * signature       ..   ..   ..   .x    x    x   .x   ..   ..   ..   ..   ..    ..
    ? * modèle          ..   ..   ..   .x    x    x   ..   ..   ..   ..   ..   ..    ..
    ? *
    ? *  . = not accorded
    ? *  x = accorded
    ? *
    ? *                                                   1111000011000000
     dPdf_Allow_Reset  s              5i 0 inz(-3904)                           reset
    ? *                                                       100000000000
     dPdf_Allow_hqprint...
     d                 s              5i 0 inz( 2048)                           bit 12 - need bit 4
    ? *                                                        10000000000
     dPdf_Allow_assemble...
     d                 s              5i 0 inz( 1024)                           bit 11
    ? *                                                         1000000000
     dPdf_Allow_extract...
     d                 s              5i 0 inz( 0512)                           bit 10
    ? *                                                          100000000
     dPdf_Allow_fill   s              5i 0 inz( 0256)                           bit 9
    ? *                                                             100000
     dPdf_Allow_annote...
     d                 s              5i 0 inz( 0032)                           bit 6
    ? *                                                              10000
     dPdf_Allow_copy   s              5i 0 inz( 0016)                           bit 5(! 10)
    ? *                                                               1000
     dPdf_Allow_modify...
     d                 s              5i 0 inz( 0008)                           bit 4(! 6 9 11)
    ? *                                                                100
     dPdf_Allow_print  s              5i 0 inz( 0004)                           bit 3
    ? *

     d PdfInz          pr

     d PdfDaisy        pr                  like(PdfS2)
     d    Xorigin                     5i 0 const
     d    Yorigin                     5i 0 const
     d    alpha                       8f   const
     d    beta                        8f   const
     d    length                      5i 0 const
     d    Color                            Likeds(PdfColor) const
     d    Emphasis                    5i 0 const options(*nopass)
     d    text                             like(pdfstream)     const
     d                                     options(*nopass)
     d    textlen                          like(PdfTextStrlen) const
     d                                     options(*nopass)


     d PdfColorHTML    ds                  qualified
     d        Red                     5p 4
     d        Green                   5p 4
     d        Blue                    5p 4
     d PdfColor        ds                  qualified
     d  Device                        4                                         RGB or CMYK
     d  strokeRed                     5p 4
     d  strokeGreen                   5p 4
     d  strokeBlue                    5p 4
     d  FillRed                       5p 4
     d  FillGreen                     5p 4
     d  FillBlue                      5p 4
     d  CmykDevice                         overlay(PdfColor)
     d  CMYK                          4    overlay(CmykDevice)
     d  strokeCyan                    5p 4 overlay(CmykDevice:*next)
     d  strokeMagenta                 5p 4 overlay(CmykDevice:*next)
     d  strokeYellow                  5p 4 overlay(CmykDevice:*next)
     d  strokeBlack                   5p 4 overlay(CmykDevice:*next)
     d  FillCyan                      5p 4 overlay(CmykDevice:*next)
     d  FillMagenta                   5p 4 overlay(CmykDevice:*next)
     d  FillYellow                    5p 4 overlay(CmykDevice:*next)
     d  FillBlack                     5p 4 overlay(CmykDevice:*next)

     d PdfSetColorRGB  pr                  likeds(PdfColor)
     d    strokeRed                   5p 4 const
     d    strokeGreen                 5p 4 const
     d    strokeBlue                  5p 4 const
     d    FillRed                     5p 4 const
     d    FillGreen                   5p 4 const
     d    FillBlue                    5p 4 const
     d PdfSetColorCMYK...
     d                 pr                  likeds(PdfColor)
     d  strokeCyan                    5p 4 const
     d  strokeMagenta                 5p 4 const
     d  strokeYellow                  5p 4 const
     d  strokeBlack                   5p 4 const
     d  FillCyan                      5p 4 const
     d  FillMagenta                   5p 4 const
     d  FillYellow                    5p 4 const
     d  FillBlack                     5p 4 const
     d PdfSetColorHTML...
     d                 pr                  likeds(PdfColor)
     d  NamedColor                   50    const varying
     d  NamedColor                   50    const varying

     d PdfCheckcolorHTML...
     d                 pr                  likeds(PdfColorHTML)
     d  NamedColor                   50    value varying

     d PdfRandomColorHTML...
     d                 pr            50          varying
     d  NamedColor                   50    value varying

     d PdfStrmFillingColorHTML...
     d                 pr                  like(pdfs1)
     d  NamedColor                   50    value varying

     d PdfStrmStrokingColorHTML...
     d                 pr                  like(pdfs1)
     d  NamedColor                   50    value varying


     d PdfPie          pr                  like(PdfS2)
     d    Xorigin                     5i 0                     const
     d    Yorigin                     5i 0                     const
     d    alpha                       8f                       const
     d    beta                        8f                       const
     d    length                      5i 0                     const
     d    Color                            Likeds(PdfColor)    const
     d    Emphasis                    5i 0 const options(*nopass)
     d    text                             like(pdfstream)     const
     d                                     options(*nopass)
     d    textlen                          like(PdfTextStrlen) const
     d                                     options(*nopass)

     d PdfComment      pr
     d    comment                   256    const varying

     d PdfDrawAddArc   pr                  like(PdfS2)
     d    beta                        8f                       const
     d    length                      5i 0                     const
     d    gotoa                        n   options(*nopass)    const

     d PdfDrawAddConcave...
     d                 pr                  like(PdfS2)
     d    beta                        8f                       const
     d    length                      5i 0                     const
     d    gotoa                        n   options(*nopass)    const
     d    length                      5i 0 options(*nopass)    const

     d PdfDrawAddConvexe...
     d                 pr                  like(PdfS2)
     d    beta                        8f                       const
     d    length                      5i 0                     const
     d    gotoa                        n   options(*nopass)    const
     d    length                      5i 0 options(*nopass)    const

     d PdfDrawAddCorona...
     d                 pr                  like(pdfs2)
     d    beta                        8f                      const
     d    length0A                    5i 0                    const
     d    length0B                    5i 0                    const

     d PdfDrawAddDaisy...
     d                 pr                  like(pdfs2)
     d    beta                        8f                      const
     d    length0A                    5i 0                    const
     d    length0B                    5i 0                    const
     d    lengthAA1                   5i 0 options(*nopass)   const
     d    lengthBB1                   5i 0 options(*nopass)   const

     d PdfCalcArc      pr                  likeds(pdfbezier)
     d    beta                        8f                      const
     d    length                      5i 0                    const

     d PdfCalcConcave  pr                  likeds(pdfbezier)
     d    beta                        8f                      const
     d    length1                     5i 0                    const
     d    length2                     5i 0 options(*nopass)   const

     d PdfCalcConvexe  pr                  likeds(pdfbezier)
     d    beta                        8f                      const
     d    length1                     5i 0                    const
     d    length2                     5i 0 options(*nopass)   const

     d PdfBezier       ds                  qualified based(template)
     d xA                             8f
     d yA                             8f
     d xB                             8f
     d yB                             8f
     d xC                             8f
     d yC                             8f
     d xD                             8f
     d yD                             8f

       //?** =  = --------------------------------------------------------------
       //?ce code ira dans l'include jp4pdfs*
     d PdfChartStyle_t...
     d                 ds                  qualified based(template)
     d   X                            8f
     d   Y                            8f
     d  width                         8f
     d  height                        8f
     d  StrokeColor                  50    varying
     d  LineWidth                     8f
     d  FillColor                    50    varying
     d  BackColor                    50    varying
     d  Font                               likeds(PdfFont)
     d  alignment                    50    varying
     d  FontSize                      8f
    ? * special values for rotate degrees :
    ? * 00 has no special meaning, just say don't rotate
    ? * -1 means rotate as a fan , origin = upper left corner ; for xaxe and yaxe only
    ? * -2 means equal to the default value
    ? * -3 means equal to ( default value * - 1), for column-to-bar graphing
     d  rotate_degree                 5i 0
     d  visible                       1
     d  background                    1
     d  Emphasis                      4f

     d PdfChart_t      ds                  qualified based(template)
     d  High                          8f
     d  MaxVal                        8f
     d  MinVal                        8f
     d  Low                           8f
     d  Spacing                       8f
     d  Ticks                         5i 0
     d  range                         8f
    ?
    ?
    ?
    ?
     d  Floating_zero                  n
    ? *           line pie column
     d  Aspect                       10
     d  DoubleTicks                    n
     d  TicksInside                    n
     d  rotate_degree                 5i 0
     d  Frame                              likeds(  PdfChartAxe_t)
     d  Title                              likeds(PdfChartTitle_t)
     d  Xaxe                               likeds(  PdfChartAxe_t)
     d  Yaxe                               likeds(  PdfChartAxe_t)
     d  Data                               likeds(  PdfChartAxe_t)
     d  default                            likeds(PdfChartElement_t)
     d  Elt_Len                      10i 0
     d  Elt_Count                     5i 0
     d  Elt_Pos                       5i 0
     d  pElements                      *
     d  pElement                       *
     d  serie_Len                    10i 0
     d  serie_Count                   5i 0
     d  serie_Pos                     5i 0
     d  pSeries                        *
     d  pSerie                         *

     d PdfChartTitle_t...
     d                 ds                  qualified based(template)
     d   Text                        50    varying
     d   Style                             likeds(PdfChartStyle_t)
    ?
    ?
    ?
    ?

     d PdfChartAxe_t...
     d                 ds                  qualified based(template)
    ?
    ?
    ?
    ?
     d   margin                       5i 0
     d   xzero                        5i 0
     d   yzero                        5i 0
     d   guide                         n
     d   Style                             likeds(PdfChartStyle_t)
     d PdfChartSerie_t...
     d                 ds                  qualified based(template)
     d   Text                        50    varying
     d   style                             likeds(PdfChartStyle_t)
     d   FromElt                      5i 0
     d   ToElt                        5i 0
     d   range                        8f
     d   sumneg                       8f
     d   sumpos                       8f
     d   mini                         8f
     d   maxi                         8f
     d PdfChartElement_t...
     d                 ds                  qualified based(template)
     d   number                       3i 0
     d   Value                        8f
    ? *  oupss %DEC can not handle dynamic values for Precision & decimals !!!
    ? *  same for %EDTIC and %EDITW
     d   EditCode                     1
     d   EditWord                    50    varying
    ?d*  precision = TOTAL number of digits, INCLUDING decimals. Such as in COBOL.
    ?d*  between 1 and 31, QECEDT is an old API.
     d   Precision                    2s 0
     d   Decimal                      2s 0
     d   style                             likeds(PdfChartStyle_t)



    ? * API QECCVTEC CONVERT EDIT CODE QECCVTEW QECEDT
    ? * Convert Edit Code (QECCVTEC) API
     d  qeccvtec       pr                  extpgm('QECCVTEC')
     d  Edit_mask                   256
     d  mask_length                  10i 0
     d  Receiver_len                 10i 0
     d  Zero_balance                  1
     d  Edit_code                     1    const
     d  Fill                          1    const
     d  precision                    10i 0 const
     d  decimal                      10i 0 const
     d  Error_code                  255    options(*varsize)

    ? * Convert Edit Word (QECCVTEW) API
     d  qeccvtew       pr                  extpgm('QECCVTEW')
     d  Edit_mask                   256
     d  mask_length                  10i 0
     d  Receiver_len                 10i 0
     d  Edit_word                    50    const
     d  Edit_word_len                10i 0 const
     d  Error_code                  255    options(*varsize)

    ? * Edit (QECEDT) API
     d  qecedt         pr                  extpgm('QECEDT')
     d  Receiver                    256    options(*varsize)
     d  Receiver_len                 10i 0 const
     d  Source                       60    const
     d  Source_class                 10    const
     d  precision                    10i 0 const
     d  Edit_mask                   256    const
     d  mask_length                  10i 0 const
     d  Zero_balance                  1
     d  Error_code                  255    options(*varsize)




     d PdfElement      pr
     d  elt                                likeds(PdfChartElement_t)
     d  gal                                likeds(PdfChartElement_t)

     d PdfEdit         pr            50    varying
     d  elt                                likeds(PdfChartElement_t)

     d PdfStyle        pr                  likeds(PdfChartStyle_t)
     d  elt                                likeds(PdfChartStyle_t)
     d  gal                                likeds(PdfChartStyle_t)

     D PdfCalculateTicks...
     d                 pr
     d chart                               likeds(PdfChart_t)

     D PdfScale        pr
     d chart                               likeds(PdfChart_t)









     d PdfChartInit    pr                  likeds(PdfChart_t)
     d PdfSeriesInit   pr
     d   chart                             likeds(PdfChart_t)
     d PdfSerieOpen    pr
     d   chart                             likeds(PdfChart_t)
     d   Serie                             likeds(pdfchartSerie_t)

     d PdfElementAdd   pr
     d   chart                             likeds(PdfChart_t)
     d   Element
     d                                     likeds(pdfchartelement_t)
     d PdfSerieClose   pr
     d   chart                             likeds(PdfChart_t)
     d PdfChartFree    pr
     d   chart                             likeds(PdfChart_t)
     D PdfDrawChart    pr                  like(pdfstream)
     d chart                               likeds(PdfChart_t)
    ?d*pElements                       *

    ? * iconv job to latin1
     d Latin1          pr                  like(PdfS3)
     d thestream                           like(pdfS3) const

     d U16             pr                  like(Pdfu2)
     d thestream                           like(pdfs2) const

     d U16Latin1       pr                  like(PdfS3)
     d thestream                           like(pdfu2) const
       //?** =  = --------------------------------------------------------------
       //?** draw bar code, function offered by Martin LORANG.
       //?** =  = --------------------------------------------------------------

     d PdfDrawBC128    pr                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)
     d zoom                           5p 2 value options(*nopass)

     d PdfDrawBC2o5i   pr                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)
     d nwfact                         5p 1 value options(*nopass)
     d zoom                           5p 2 value options(*nopass)

     d PdfDrawBC39     pr                  like(PdfStream)
     d x                              6p 1 value
     d y                              6p 1 value
     d thebarcode                          like(pdfS1) const
     d height                         5p 1 value options(*nopass)
     d nwfact                         5p 1 value options(*nopass)
     d zoom                           5p 2 value options(*nopass)

