










             CMD        PROMPT('Transform a spool into a PDF') /* +
                          This command is used to take data from a +
                          spooled file and transform it into an +
                          ASCII PDF file. */
             PARM       KWD(FILE) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          MIN(1) MAX(1) FILE(*OUT) FULL(*NO) +
                          EXPR(*YES) VARY(*NO) PASSATR(*NO) +
                          PROMPT('Spooled File Name')
             PARM       KWD(SPLNBR) TYPE(*DEC) LEN(5 0) RSTD(*NO) +
                          DFT(*LAST) RANGE(1 9999) SPCVAL((*ONLY 0) +
                          (*LAST -1)) MIN(0) MAX(1) EXPR(*YES) +
                          VARY(*NO) PASSATR(*NO) PROMPT('Spooled +
                          File Number')
             PARM       KWD(JOBNAME) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          SPCVAL((*)) MIN(1) MAX(1) EXPR(*YES) +
                          VARY(*NO) PASSATR(*NO) PROMPT('Job Name')
             PARM       KWD(JOBUSER) TYPE(*NAME) LEN(10) RSTD(*NO) +
                          EXPR(*YES) VARY(*NO) PROMPT('User Name')
             PARM       KWD(JOBNBR) TYPE(*CHAR) LEN(6) RSTD(*NO) +
                          RANGE(000000 999999) FULL(*YES) +
                          EXPR(*YES) VARY(*NO) PROMPT('Job Number')
             PARM       KWD(STRPAGE) TYPE(*DEC) LEN(5) RSTD(*NO) +
                          DFT(1) RANGE(1 9999) MIN(0) MAX(1) +
                          EXPR(*YES) VARY(*NO) PASSATR(*NO) +
                          PROMPT('Start Page Number')
             PARM       KWD(ENDPAGE) TYPE(*DEC) LEN(5) RSTD(*NO) +
                          DFT(*LAST) RANGE(1 9999) SPCVAL((*LAST +
                          -1)) MIN(0) MAX(1) EXPR(*YES) VARY(*NO) +
                          PASSATR(*NO) PROMPT('End Page Number')
             PARM       KWD(DATATYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SCS) VALUES(*SCS *AFP) PROMPT('Spool +
                          data type')
             PARM       KWD(ENHANCED) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('use +
                          data from file')
             PARM       KWD(ENHFILE) TYPE(QUALFILE) PROMPT('File +
                          *PRTCTL cpysplf enhanced')
             PARM       KWD(PAGESIZE) TYPE(PAGESIZE) PROMPT('Page +
                          size for *PRTCTL file')

             PARM       KWD(IFSROOT) TYPE(*CHAR) LEN(132) DFT(*NONE) +
                          EXPR(*YES) PROMPT('IFS root')
             PARM       KWD(IFSDIR) TYPE(*CHAR) LEN(132) DFT(*NONE) +
                          EXPR(*YES) PROMPT('IFS folder')
             PARM       KWD(IFSFILE) TYPE(*CHAR) LEN(132) +
                          DFT('splf2pdf.pdf') EXPR(*YES) +
                          PROMPT('IFS file')
             PARM       KWD(DTAAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*RWX) VALUES(*SAME *NONE *RWX *RX *RW +
                          *WX *R *W *X *EXCLUDE *DONTAPPLY) +
                          EXPR(*YES) PROMPT('*PUBLIC data authority')
             PARM       KWD(OBJAUT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ALL) VALUES(*NONE *ALL *OBJEXIST +
                          *OBJMGT *OBJALTER *OBJREF *DONTAPPLY) +
                          EXPR(*YES) PROMPT('*PUBLIC Object authority')
             PARM       KWD(PAGEMODE) TYPE(*CHAR) LEN(11) RSTD(*YES) +
                          DFT(USEOUTLINES) VALUES(USENONE +
                          USEOUTLINES USETHUMBS FULLSCREEN) +
                          PROMPT('PageMode at open')
             PARM       KWD(MARGINS) TYPE(MARGIN) PROMPT('Margins +
                          (72 DPI)')
             PARM       KWD(LOGO) TYPE(LOGO) PROMPT('Background +
                          picture')
             PARM       KWD(WATERMARK) TYPE(WATERMARK) +
                          PROMPT('Watermark')
             PARM       KWD(PERMISSION) TYPE(PERMISSION) +
                          PROMPT('Permissions allowed')

 PAGESIZE:   ELEM       TYPE(*DEC) LEN(3) DFT(66) +
                          PROMPT('Length--lines per page')
             ELEM       TYPE(*DEC) LEN(3) DFT(132) +
                          PROMPT('Width--positions per line')
             ELEM       TYPE(*DEC) LEN(3) DFT(6) PROMPT('Lines per +
                          inch')
             ELEM       TYPE(*DEC) LEN(3) DFT(10) PROMPT('Characters +
                          per inch')
 MARGIN:     ELEM       TYPE(*DEC) LEN(3) DFT(20) PROMPT('Left +
                          margin')
             ELEM       TYPE(*DEC) LEN(3) DFT(*LEFT) SPCVAL((*LEFT +
                          -1)) PROMPT('Right margin')
             ELEM       TYPE(*DEC) LEN(3) DFT(*LEFT) SPCVAL((*LEFT +
                          -1)) PROMPT('Top margin')
             ELEM       TYPE(*DEC) LEN(3) DFT(*LEFT) SPCVAL((*LEFT +
                          -1)) PROMPT('Bottom margin')

 LOGO:       ELEM       TYPE(*PNAME) LEN(255) PROMPT('Picture file +
                          name (IFS syntax)')
             ELEM       TYPE(*CHAR) LEN(5) RSTD(*YES) DFT(JPEG) +
                          VALUES(JPEG BMP24) PROMPT('File type')
             ELEM       TYPE(*INT2) DFT(0) PROMPT('X position from +
                          left 72 DPI')
             ELEM       TYPE(*INT2) DFT(0) PROMPT('Y position from +
                          bottom 72 DPI')
             ELEM       TYPE(*DEC) LEN(5 2) DFT(100) PROMPT('Zoom (%)')

 WATERMARK:  ELEM       TYPE(*CHAR) LEN(100) DFT(*NONE) PROMPT('Text')
             ELEM       TYPE(*CHAR) LEN(12) RSTD(*YES) +
                          DFT(HELVETICA) VALUES(COURIER HELVETICA +
                          TIMES SYMBOL ZAPFDINGBATS) PROMPT('Font')
             ELEM       TYPE(*LGL) DFT(*YES) SPCVAL((*YES '1') (*NO +
                          '0')) PROMPT('Bold')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*YES '1') (*NO +
                          '0')) PROMPT('Italic')
             ELEM       TYPE(*INT2) DFT(40) PROMPT('Font Size')
             ELEM       TYPE(*INT2) DFT(200) PROMPT('X position from +
                          left 72 DPI')
             ELEM       TYPE(*INT2) DFT(000) PROMPT('Y position from +
                          bottom 72 DPI')
             ELEM       TYPE(*INT2) DFT(00) RANGE(0 359) +
                          PROMPT('Orientation (degree)')
             ELEM       TYPE(*CHAR) LEN(7) DFT(BLACK) +
                          SPCVAL((ALICEBLUE '#F0F8FF') +
                          (ANTIQUEWHITE '#FAEBD7') (AQUA '#00FFFF') +
                          (AQUAMARINE '#7FFFD4') (AZURE '#F0FFFF') +
                          (BEIGE '#F5F5DC') (BISQUE '#FFE4C4') +
                          (BLACK '#000000') (BLANCHEDALMOND +
                          '#FFEBCD') (BLUE '#0000FF') (BLUEVIOLET +
                          '#8A2BE2') (BROWN '#A52A2A') (BURLYWOOD +
                          '#DEB887') (CADETBLUE '#5F9EA0') +
                          (CHARTREUSE '#7FFF00') (CHOCOLATE +
                          '#D2691E') (CORAL '#FF7F50') (CORNFLOWER +
                          '#6495ED') (CORNSILK '#FFF8DC') (CRIMSON +
                          '#DC143C') (CYAN '#00FFFF') (DARKBLUE +
                          '#00008B') (DARKCYAN '#008B8B') +
                          (DARKGOLDENROD '#B8860B') (DARKGRAY +
                          '#A9A9A9') (DARKGREY '#A9A9A9') +
                          (DARKGREEN '#006400') (DARKKHAKI +
                          '#BDB76B') (DARKMAGENTA '#8B008B') +
                          (DARKOLIVEGREEN '#556B2F') (DARKORANGE +
                          '#FF8C00') (DARKORCHID '#9932CC') +
                          (DARKRED '#8B0000') (DARKSALMON +
                          '#E9967A') (DARKSEAGREEN '#8FBC8B') +
                          (DARKSLATEBLUE '#483D8B') (DARKSLATEGRAY +
                          '#2F4F4F') (DARKSLATEGREY '#2F4F4F') +
                          (DARKTURQUOISE '#00CED1') (DARKVIOLET +
                          '#9400D3') (DEEPPINK '#FF1493') +
                          (DEEPSKYBLUE '#00BFFF') (DIMGRAY +
                          '#696969') (DIMGREY '#696969') +
                          (DODGERBLUE '#1E90FF') (FIREBRICK +
                          '#B22222') (FLORALWHITE '#FFFAF0') +
                          (FORESTGREEN '#228B22') (FUCHIA +
                          '#FF00FF') (GAINSBORO '#DCDCDC') +
                          (GHOSTWHITE '#F8F8FF') (GOLD '#FFD700') +
                          (GOLDENROD '#DAA520') (GRAY '#808080') +
                          (GREY '#808080') (GREEN '#008000') +
                          (GREENYELLOW '#ADFF2F') (HONEYDEW +
                          '#F0FFF0') (HOTPINK '#FF69B4') (INDIANRED +
                          '#CD5C5C') (INDIGO '#4B0082') (IVORY +
                          '#FFFFF0') (KHAKI '#F0E68C') (LAVENDER +
                          '#E6E6FA') (LAVENDERBLUSH '#FFF0F5') +
                          (LAWNGREEN '#7CFC00') (LEMONCHIFFON +
                          '#FFFACD') (LIGHTBLUE '#ADD8E6') +
                          (LIGHTCORAL '#F08080') (LIGHTCYAN +
                          '#E0FFFF') (LIGHTGOLDENRODYELLOW +
                          '#FAFAD2') (LIGHTGREEN '#90EE90') +
                          (LIGHTGRAY '#D3D3D3') (LIGHTGREY +
                          '#D3D3D3') (LIGHTPINK '#FFB6C1') +
                          (LIGHTSALMON '#FFA07A') (LIGHTSEAGREEN +
                          '#20B2AA') (LIGHTSKYBLUE '#87CEFA') +
                          (LIGHTSLATEGRAY '#778899') +
                          (LIGHTSLATEGREY '#778899') +
                          (LIGHTSTEELBLUE '#B0C4DE') (LIGHTYELLOW +
                          '#FFFFE0') (LIME '#00FF00') (LIMEGREEN +
                          '#32CD32') (LINEN '#FAF0E6') (MAGENTA +
                          '#FF00FF') (MAROON '#800000') +
                          (MEDIUMAQUAMARINE '#66CDAA') (MEDIUMBLUE +
                          '#0000CD') (MEDIUMORCHID '#BA55D3') +
                          (MEDIUMPURPLE '#9370DB') (MEDIUMSEAGREEN +
                          '#3CB371') (MEDIUMSLATEBLUE '#7B68EE') +
                          (MEDIUMSPRINGGREEN '#00FA9A') +
                          (MEDIUMTURQUOISE '#48D1CC') +
                          (MEDIUMVIOLETRED '#C71585') (MIDNIGHTBLUE +
                          '#191970') (MINTCREAM '#F5FFFA') +
                          (MISTYROSE '#FFE4E1') (MOCCASIN +
                          '#FFE4B5') (NAVAJOWHITE '#FFDEAD') (NAVY +
                          '#000080') (OLDLACE '#FDF5E6') (OLIVE +
                          '#808000') (OLIVEDRAB '#6B8E23') (ORANGE +
                          '#FFA500') (ORANGERED '#FF4500') (ORCHID +
                          '#DA70D6') (PALEGOLDENROD '#EEE8AA') +
                          (PALEGREEN '#98FB98') (PALETURQUOISE +
                          '#AFEEEE') (PALEVIOLETRED '#DB7093') +
                          (PAPAYAWHIP '#FFEFD5') (PEACHPUFF +
                          '#FFDAB9') (PERU '#CD853F') (PINK +
                          '#FFC0CB') (PLUM '#DDA0DD') (POWDERBLUE +
                          '#B0E0E6') (PURPLE '#800080') (RED +
                          '#FF0000') (ROSYBROWN '#BC8F8F') +
                          (ROYALBLUE '#4169E1') (SADDLEBROWN +
                          '#8B4513') (SALMON '#FA8072') (SANDYBROWN +
                          '#F4A460') (SEAGREEN '#2E8B57') (SEASHELL +
                          '#FFF5EE') (SIENNA '#A0522D') (SILVER +
                          '#C0C0C0') (SKYBLUE '#87CEEB') (SLATEBLUE +
                          '#6A5ACD') (SLATEGRAY '#708090') +
                          (SLATEGREY '#708090') (SNOW '#FFFAFA') +
                          (SPRINGGREEN '#00FF7F') (STEELBLUE +
                          '#4682B4') (TAN '#D2B48C') (TEAL +
                          '#008080') (THISTLE '#D8BFD8') (TOMATO +
                          '#FF6347') (TURQUOISE '#40E0D0') (VIOLET +
                          '#EE82EE') (WHEAT '#F5DEB3') (WHITE +
                          '#FFFFFF') (WHITESMOKE '#F5F5F5') (YELLOW +
                          '#FFFF00') (YELLOWGREEN '#9ACD32')) +
                          PROMPT('Stroke Color')

             ELEM       TYPE(*CHAR) LEN(7) DFT(LIGHTCYAN) +
                          PROMPT('Fill Color')   +
                          SPCVAL((ALICEBLUE '#F0F8FF') +
                          (ANTIQUEWHITE '#FAEBD7') (AQUA '#00FFFF') +
                          (AQUAMARINE '#7FFFD4') (AZURE '#F0FFFF') +
                          (BEIGE '#F5F5DC') (BISQUE '#FFE4C4') +
                          (BLACK '#000000') (BLANCHEDALMOND +
                          '#FFEBCD') (BLUE '#0000FF') (BLUEVIOLET +
                          '#8A2BE2') (BROWN '#A52A2A') (BURLYWOOD +
                          '#DEB887') (CADETBLUE '#5F9EA0') +
                          (CHARTREUSE '#7FFF00') (CHOCOLATE +
                          '#D2691E') (CORAL '#FF7F50') (CORNFLOWER +
                          '#6495ED') (CORNSILK '#FFF8DC') (CRIMSON +
                          '#DC143C') (CYAN '#00FFFF') (DARKBLUE +
                          '#00008B') (DARKCYAN '#008B8B') +
                          (DARKGOLDENROD '#B8860B') (DARKGRAY +
                          '#A9A9A9') (DARKGREY '#A9A9A9') +
                          (DARKGREEN '#006400') (DARKKHAKI +
                          '#BDB76B') (DARKMAGENTA '#8B008B') +
                          (DARKOLIVEGREEN '#556B2F') (DARKORANGE +
                          '#FF8C00') (DARKORCHID '#9932CC') +
                          (DARKRED '#8B0000') (DARKSALMON +
                          '#E9967A') (DARKSEAGREEN '#8FBC8B') +
                          (DARKSLATEBLUE '#483D8B') (DARKSLATEGRAY +
                          '#2F4F4F') (DARKSLATEGREY '#2F4F4F') +
                          (DARKTURQUOISE '#00CED1') (DARKVIOLET +
                          '#9400D3') (DEEPPINK '#FF1493') +
                          (DEEPSKYBLUE '#00BFFF') (DIMGRAY +
                          '#696969') (DIMGREY '#696969') +
                          (DODGERBLUE '#1E90FF') (FIREBRICK +
                          '#B22222') (FLORALWHITE '#FFFAF0') +
                          (FORESTGREEN '#228B22') (FUCHIA +
                          '#FF00FF') (GAINSBORO '#DCDCDC') +
                          (GHOSTWHITE '#F8F8FF') (GOLD '#FFD700') +
                          (GOLDENROD '#DAA520') (GRAY '#808080') +
                          (GREY '#808080') (GREEN '#008000') +
                          (GREENYELLOW '#ADFF2F') (HONEYDEW +
                          '#F0FFF0') (HOTPINK '#FF69B4') (INDIANRED +
                          '#CD5C5C') (INDIGO '#4B0082') (IVORY +
                          '#FFFFF0') (KHAKI '#F0E68C') (LAVENDER +
                          '#E6E6FA') (LAVENDERBLUSH '#FFF0F5') +
                          (LAWNGREEN '#7CFC00') (LEMONCHIFFON +
                          '#FFFACD') (LIGHTBLUE '#ADD8E6') +
                          (LIGHTCORAL '#F08080') (LIGHTCYAN +
                          '#E0FFFF') (LIGHTGOLDENRODYELLOW +
                          '#FAFAD2') (LIGHTGREEN '#90EE90') +
                          (LIGHTGRAY '#D3D3D3') (LIGHTGREY +
                          '#D3D3D3') (LIGHTPINK '#FFB6C1') +
                          (LIGHTSALMON '#FFA07A') (LIGHTSEAGREEN +
                          '#20B2AA') (LIGHTSKYBLUE '#87CEFA') +
                          (LIGHTSLATEGRAY '#778899') +
                          (LIGHTSLATEGREY '#778899') +
                          (LIGHTSTEELBLUE '#B0C4DE') (LIGHTYELLOW +
                          '#FFFFE0') (LIME '#00FF00') (LIMEGREEN +
                          '#32CD32') (LINEN '#FAF0E6') (MAGENTA +
                          '#FF00FF') (MAROON '#800000') +
                          (MEDIUMAQUAMARINE '#66CDAA') (MEDIUMBLUE +
                          '#0000CD') (MEDIUMORCHID '#BA55D3') +
                          (MEDIUMPURPLE '#9370DB') (MEDIUMSEAGREEN +
                          '#3CB371') (MEDIUMSLATEBLUE '#7B68EE') +
                          (MEDIUMSPRINGGREEN '#00FA9A') +
                          (MEDIUMTURQUOISE '#48D1CC') +
                          (MEDIUMVIOLETRED '#C71585') (MIDNIGHTBLUE +
                          '#191970') (MINTCREAM '#F5FFFA') +
                          (MISTYROSE '#FFE4E1') (MOCCASIN +
                          '#FFE4B5') (NAVAJOWHITE '#FFDEAD') (NAVY +
                          '#000080') (OLDLACE '#FDF5E6') (OLIVE +
                          '#808000') (OLIVEDRAB '#6B8E23') (ORANGE +
                          '#FFA500') (ORANGERED '#FF4500') (ORCHID +
                          '#DA70D6') (PALEGOLDENROD '#EEE8AA') +
                          (PALEGREEN '#98FB98') (PALETURQUOISE +
                          '#AFEEEE') (PALEVIOLETRED '#DB7093') +
                          (PAPAYAWHIP '#FFEFD5') (PEACHPUFF +
                          '#FFDAB9') (PERU '#CD853F') (PINK +
                          '#FFC0CB') (PLUM '#DDA0DD') (POWDERBLUE +
                          '#B0E0E6') (PURPLE '#800080') (RED +
                          '#FF0000') (ROSYBROWN '#BC8F8F') +
                          (ROYALBLUE '#4169E1') (SADDLEBROWN +
                          '#8B4513') (SALMON '#FA8072') (SANDYBROWN +
                          '#F4A460') (SEAGREEN '#2E8B57') (SEASHELL +
                          '#FFF5EE') (SIENNA '#A0522D') (SILVER +
                          '#C0C0C0') (SKYBLUE '#87CEEB') (SLATEBLUE +
                          '#6A5ACD') (SLATEGRAY '#708090') +
                          (SLATEGREY '#708090') (SNOW '#FFFAFA') +
                          (SPRINGGREEN '#00FF7F') (STEELBLUE +
                          '#4682B4') (TAN '#D2B48C') (TEAL +
                          '#008080') (THISTLE '#D8BFD8') (TOMATO +
                          '#FF6347') (TURQUOISE '#40E0D0') (VIOLET +
                          '#EE82EE') (WHEAT '#F5DEB3') (WHITE +
                          '#FFFFFF') (WHITESMOKE '#F5F5F5') (YELLOW +
                          '#FFFF00') (YELLOWGREEN '#9ACD32'))


 PERMISSION: ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES '1'))  +
                                PROMPT('Set permission & password')
             ELEM       TYPE(*CHAR) LEN(32) DFT(*NONE) +
                          SPCVAL(( *NONE  '')) PROMPT('User password')
             ELEM       TYPE(*CHAR) LEN(32) RSTD(*NO) DFT(*NONE) +
                          SPCVAL((*NONE '')) PROMPT('Owner password')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Print')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow assemble')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Extract (accessibility)')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Fill')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Annote')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Copy')
             ELEM       TYPE(*LGL) DFT(*NO) SPCVAL((*NO '0') (*YES +
                          '1')) PROMPT('Allow Modify')
 QUALFILE:   QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')


