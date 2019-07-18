      /if defined(DATA_SECTION)
      /if defined(SQL)                                                          sql
     D EscSqlEr        Pr
     D   sqlcod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
      /if defined(getmessage)
     D GetSqlEr        Pr            70
     D   sqlcod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
      /endif
     D DiagSqlEr       Pr
     D   sqlcod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
     D SqlEr104        Pr
     D   sqlcads                           const likeds(sqlca)
     D   sqlStm                   32000    const varying
     d SQL0001         ds
     d  sql000101                     9b 0
     d  sql000102                    10
     d sql8880         ds                  qualified
     d   er5                         10i 0
     d   sqlleft                    500
     d   sqlright                   500
     d myWith          s          32787    varying
     d mySelect        s          32787    varying
     d myFrom          s          32787    varying
     d myWhere         s          32787    varying
    ?d*mySFW           s           5000        useless, sqlrgp don't work with /include
     d WhereAnd        s          32787    varying
    ?d*sqlCount        s              9b 0     useless, sqlrgp don't work with /include
     d mySelectMore    s          32787    varying
      /endif                                                                    sql
      /if defined(SQLDESCRIBE)                                                  sqldescribe
     Dreallocselda     Pr
     D sqlcols                        5i 0 CONST
     DBufTyp           Pr                  LIKE(RtnTyp)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
     DRtnTyp           S             20A
     DSelDA            DS                  BASED(pSelDA)                        SQLDA allocate heap.
     D SQLDAID                        8A
     D   SQLDOUBLED                   1    overlay(sqldaid:7)
     D   SQLthe7                      1s 0 overlay(sqldaid:7)
     D SQLDABC                       10I 0
     D SQLN                           5I 0
     D SQLD                           5I 0
     D SQLVAR                        80A   DIM(256)
     D  SQLTYPE                       5I 0 OVERLAY(SQLVAR:1)
     D  SQLLEN                        5I 0 OVERLAY(SQLVAR:3)
     D  SQLprecision                  3i 0 OVERLAY(SQLVAR:3)
     D  SQLscale                      3i 0 OVERLAY(SQLVAR:4)
     D  SQLRES                       12A   OVERLAY(SQLVAR:5)
     D  SQLDATA                        *   OVERLAY(SQLVAR:17)
     D  SQLccsid1                     9b 0 OVERLAY(SQLVAR:17)
     D  SQLIND                         *   OVERLAY(SQLVAR:33)
     D  SQLNAMELEN                    5I 0 OVERLAY(SQLVAR:49)
     D  SQLNAME                      30A   OVERLAY(SQLVAR:51)
     D  SQLccsid2                     9b 0 OVERLAY(SQLVAR:51)
     DSelDASiz         S              5U 0
     DAvlColCnt        S              5U 0 INZ(51)
      /endif                                                                    sqldescribe
      /endif                                                                    sqldescribe
      /if defined(PROCEDURE_SECTION)                                            calc
      /if defined(SQL)                                                          sql
BPR  P EscSqlEr        B
     D EscSqlEr        PI
     D   pa_cod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
     D   sqlcod        ds
     D   sqlcod3                      3
     D   sqlcod4                      4s 0
     D TheKey          S              4A
     D MsgID           S              7A
      /free
B01    if pa_cod < 0 ;
          eval sqlcod4= - pa_cod ;
X01    else ;
          eval sqlcod4= pa_cod ;
E01    endif ;
       sqlcod3 = 'SQL';
       msgid=sqlcod;
B01    if %parms >= 2 ;
          message(msgid:sqlerm:'*LIBL':'QSQLMSG':'*ESCAPE':'*':2)  ;
X01    else;
          message(msgid:'':'*LIBL':'QSQLMSG':'*ESCAPE':'*':2)       ;
E01    endif;
      /end-free
EPR  P                 E
      /if defined(getmessage)
BPR  P GetSqlEr        B
     D GetSqlEr        PI            70
     D   pa_cod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
     D   sqlcod        ds
     D   sqlcod3                      3
     D   sqlcod4                      4s 0
     D TheKey          S              4A
     D MsgID           S              7A
      /free
B01    if pa_cod < 0 ;
          eval sqlcod4= - pa_cod ;
X01    else ;
          eval sqlcod4= pa_cod ;
E01    endif ;
       sqlcod3 = 'SQL';
       msgid=sqlcod;
B01    if %parms >= 2 ;
       return getmessage(msgid:sqlerm:'*LIBL':'QSQLMSG')  ;
X01    else;
       return getmessage(msgid:'':'*LIBL':'QSQLMSG')       ;
E01    endif;
      /end-free
EPR  P                 E
      /endif
BPR  P DiagSqlEr       B
     D DiagSqlEr       PI
     D   pa_cod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)
     D   sqlcod        ds
     D   sqlcod3                      3
     D   sqlcod4                      4s 0
     D TheKey          S              4A
     D MsgID           S              7A
      /free
B01    if pa_cod < 0 ;
          eval sqlcod4= - pa_cod ;
X01    else ;
          eval sqlcod4= pa_cod ;
E01    endif ;
       sqlcod3 = 'SQL';
       msgid=sqlcod;
B01    if %parms >= 2 ;
          message(msgid:sqlerm:'*LIBL':'QSQLMSG':'*DIAG':'*':2)  ;
X01    else;
          message(msgid:'':'*LIBL':'QSQLMSG':'*DIAG':'*':2)       ;
E01    endif;
      /end-free
EPR  P                 E
     p SqlEr104        b
     D SqlEr104        Pi
     D   sqlcads                           const likeds(sqlca)
     D   sqlStm                   32000    const varying
      /free
         If Sqlcod = -104;   // syntax error at &SQLER5
            sql8880.er5 = Sqler5 ;
            If Sqler5 > 500;
               sql8880.sqlleft = %Subst(SQLstm:Sqler5-500:500);
            Else;
               sql8880.sqlleft = %Subst(SQLstm:1:Sqler5  );
            Endif;
            If %Len(SQLstm) - Sqler5 > 500 ;
               sql8880.sqlright = %Subst(SQLstm:Sqler5+1:500) ;
            Else;
               sql8880.sqlright = %Subst(SQLstm:Sqler5+1) ;
            Endif;
            message('SQL8880' :sql8880:'*LIBL':'XCASE');
         endif;
      /end-free
     p                 e
      /endif                                                                    sql
      /if defined(SQLDESCRIBE)                                                  sqldescribe
    ?D* *BufTyp      - Return buffer field type.                                                   *
BPR  PBufTyp           B
     DBufTyp           PI                  LIKE(RtnTyp)                         Return length.
     D InpTyp                              LIKE(SQLType) CONST
    ? * Return field type *
B01  C                   SELECT
X01  C                   WHEN      InpTyp      = 384 OR                         Date.
     C                             InpTyp      = 385
     C                   EVAL      RtnTyp      = 'DATE'
X01  C                   WHEN      InpTyp      = 388 OR                         Time.
     C                             InpTyp      = 389
     C                   EVAL      RtnTyp      = 'TIME'
X01  C                   WHEN      InpTyp      = 392 OR                         Timestamp.
     C                             InpTyp      = 393
     C                   EVAL      RtnTyp      = 'TIMESTAMP'
X01  C                   WHEN      InpTyp      = 400 OR                         Nul-term graphic.
     C                             InpTyp      = 401
    ? * Unsupported
     C                   EVAL      RtnTyp      = 'NUL-TERM GRAPHIC'
X01  C                   WHEN      InpTyp      = 404 OR                         BLOB.
     C                             InpTyp      = 405
     C                   EVAL      RtnTyp      = 'BLOB'
X01  C                   WHEN      InpTyp      = 408 OR                         CLOB.
     C                             InpTyp      = 409
     C                   EVAL      RtnTyp      = 'CLOB'
X01  C                   WHEN      InpTyp      = 412 OR                         DBCLOB
     C                             InpTyp      = 413
     C                   EVAL      RtnTyp      = 'DBCLOB'
X01  C                   WHEN      InpTyp      = 448 OR                         Varying character.
     C                             InpTyp      = 449
     C                   EVAL      RtnTyp      = 'VARCHAR'
X01  C                   WHEN      InpTyp      = 452 OR                         Fixed character.
     C                             InpTyp      = 453
     C                   EVAL      RtnTyp      = 'CHAR'
X01  C                   WHEN      InpTyp      = 456 OR                         Long varying char.
     C                             InpTyp      = 457
     C                   EVAL      RtnTyp      = 'LONG VARCHAR'
X01  C                   WHEN      InpTyp      = 460 OR                         Nul-term character.
     C                             InpTyp      = 461
    ? * Unsupported
     C                   EVAL      RtnTyp      = 'NUL-TERM CHAR'
X01  C                   WHEN      InpTyp      = 464 OR                         Varying graphic.
     C                             InpTyp      = 465
     C                   EVAL      RtnTyp      = 'VARGRAPHIC'
X01  C                   WHEN      InpTyp      = 468 OR                         Fixed graphic.
     C                             InpTyp      = 469
     C                   EVAL      RtnTyp      = 'GRAPHIC'
X01  C                   WHEN      InpTyp      = 472 OR                         Long varying graph.
     C                             InpTyp      = 473
     C                   EVAL      RtnTyp      = 'LONG VARGRAPHIC'
X01  C                   WHEN      InpTyp      = 476 OR                         PASCAL L-string.
     C                             InpTyp      = 477
    ? * Unsupported
     C                   EVAL      RtnTyp      = 'PASCAL L-STRING'
X01  C                   WHEN      InpTyp      = 480 OR                         Floating point.
     C                             InpTyp      = 481
     C                   EVAL      RtnTyp      = 'REAL'
X01  C                   WHEN      InpTyp      = 484 OR                         Packed decimal.
     C                             InpTyp      = 485
     C                   EVAL      RtnTyp      = 'DEC'
X01  C                   WHEN      InpTyp      = 488 OR                         Zoned decimal.
     C                             InpTyp      = 489
     C                   EVAL      RtnTyp      = 'NUMERIC'
X01  C                   WHEN      InpTyp      = 492 OR                         Big integer (8b).
     C                             InpTyp      = 493
     C                   EVAL      RtnTyp      = 'BIGINT'
X01  C                   WHEN      InpTyp      = 496 OR                         Large integer(4b).
     C                             InpTyp      = 497
     C                   EVAL      RtnTyp      = 'INT'
X01  C                   WHEN      InpTyp      = 500 OR                         Small integer(2b).
     C                             InpTyp      = 501
     C                   EVAL      RtnTyp      = 'SMALLINT'
X01  C                   WHEN      InpTyp      = 504 OR                         Sign leading.
     C                             InpTyp      = 505
    ? * Unsupported
     C                   EVAL      RtnTyp      = 'SIGN LEADING'
X01  C                   WHEN      InpTyp      = 960 OR                         BLOB locator.
     C                             InpTyp      = 961
     C                   EVAL      RtnTyp      = 'BLOB DATALINK'
X01  C                   WHEN      InpTyp      = 964 OR                         CLOB locator.
     C                             InpTyp      = 965
     C                   EVAL      RtnTyp      = 'CLOB DATALINK'
X01  C                   WHEN      InpTyp      = 968 OR                         DBCLOB locator.
     C                             InpTyp      = 969
     C                   EVAL      RtnTyp      = 'DBCLOB DATALINK'
E01  C                   ENDSL
     C                   RETURN    RtnTyp
EPR  PBufTyp           E
BPR  preallocselda     b
     Dreallocselda     Pi
     D sqlcols                        5i 0 CONST
    ?c*256 mini, largeur de excel
B01  c                   if        sqlcols < 256
     C                   EVAL      SelDASiz = 256 * %SIZE(SQLVAR) + 16
X01  c                   else
     C                   EVAL      SelDASiz = sqlcols * %SIZE(SQLVAR) + 16
E01  c                   endif
B01  C                   IF        pSelDA     <> *NULL                          Still held.
     C                   REALLOC   SelDASiz      pSelDA                         Release storage.
X01  C                   ELSE
     C                   ALLOC     SelDASiz      pSelDA
E01  C                   END
     c                   clear                   selda
     C                   EVAL      SQLN        = sqlcols                        Available fields.
EPR  p                 e
      /endif                                                                    sqldescribe
      /endif                                                                    calc
