      *  CRTPF FILE(xmldb2w) RCDLEN(300) SIZE(*NOMAX)









      /define INFDS
      *define VBEL
      *define ECOPRO
      /define SQL
      *define SQLDESCRIBE
      *define LOWERCASE
      *define QUOTE
     h debug datedit(*ymd) datfmt(*ymd-)

    ? *================================================================
    ? * copy the DB2 xml file to a no-dds file
    ? *================================================================
     fxmldb2w   uf a e             disk    infsr(*pssr)
     f                                     infds(fids)
     f                                     rename(xmldb2w:xmldb2f)
     d data            s           1000    varying

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
     d len             s              5u 0 inz(%len(xmldb2))
     ixmldb2f
     i              xmldb2w                     xmldb2

    ?
     c/EXEC SQL
     c+     declare xmldb2K1 cursor for
     c+ SELECT DATA FROM XMLDB2P WHERE DATA<>'' ORDER BY LEVEL1,
     c+ LEVEL2, LEVEL3, LEVEL4, LEVEL5, LEVEL6, LEVEL7, LEVEL8, LEVEL9
     c/END-EXEC
     c/EXEC SQL
     c+     open    xmldb2k1
     c/END-EXEC
B04  c                   if        sqlcod <> *zero
     c                   callp     escsqler (sqlcod)
E04  c                   endif
     c                   do        *hival
     c/EXEC SQL
     c+     fetch   xmldb2K1  into : data
     c/END-EXEC
     c                   if        sqlcod = 100
     c                   leave
     c                   endif
B04  c                   if        sqlcod <> *zero
     c                   callp     escsqler (sqlcod)
E04  c                   endif
     c                   if        %len(data) > len
     c                   eval      xmldb2 = %subst(data: 1: len)
     c                   else
     c                   eval      xmldb2=data
     c                   endif
     c                   write     xmldb2f
     c                   enddo
     c/EXEC SQL
     c+     close   xmldb2K1
     c/END-EXEC
     c                   seton                                        lr

      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

