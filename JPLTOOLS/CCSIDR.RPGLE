      /define ICONV
      /define ECH
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define DATA_SECTION
      /include jpltools,jp4inc
      /undefine DATA_SECTION
     d ccsidr          pr
     d  text1                        25
     d  text2                        25
     d ccsidr          pi
     d  text1                        25
     d  text2                        25
      /free
       *inlr = *on;
       PortableChar = ConvCcsid(PortablecharInz.ccsid:0:PortableCharInz);
B01    dump;
       return;
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
