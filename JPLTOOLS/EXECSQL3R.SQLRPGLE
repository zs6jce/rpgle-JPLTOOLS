    ? *  EXECSQL3 STACK(*IFS) STREAM('/home/lamontre1/sqlstack.txt')
    ? *  STARTTAG(*BEGIN) STOPTAG(*END)

      /define INFDS
      /define IFS
      /define pssr
      /define SQL
      /define SQLDESCRIBE
      /define GPS
      /define getmessage

     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')

     fqtmpsrc   uf a e           k disk    usropn
     f                                     infds(fids)
     f                                     rename(qtmpsrc:qtmpf)

      /define DATA_SECTION
      /include jpltools,jp4inc
      /undefine DATA_SECTION




     D SQL_FALSE       C                   0
     D SQL_TRUE        C                   1
     D SQL_NTS         C                   -3
     D SQL_SQLSTATE_SIZE...
     D                 C                   5
     D SQL_MAX_MESSAGE_LENGTH...
     D                 C                   512
     D SQL_MAX_OPTION_STRING_LENGTH...
     D                 C                   128
    ? *
    ? * Templates for SQL data types
    ? *
     D SQLSMALLINT     s              5I 0 based(Template)
     D SQLUSMALLINT    s              5U 0 based(Template)
     D SQLUINTEGER     s             10U 0 based(Template)
     D SQLDOUBLE       s              8F   based(Template)
     D SQLREAL         s              4F   based(Template)
     D SQLINTEGER      s             10I 0 based(Template)
     D SQLHENV         s             10I 0 based(Template)
     D SQLHDBC         s             10I 0 based(Template)
     D SQLHSTMT        s             10I 0 based(Template)
     D SQLHDESC        s             10I 0 based(Template)
     D SQLHANDLE       s             10I 0 based(Template)
     D SQLRETURN       s                   like(SQLINTEGER) based(Template)
     D SFLOAT          s              4F   based(Template)
     D SQLPOINTER      s               *   based(Template)
     D SQLHWND         s               *   based(Template)
    ? *
    ? * null values
    ? *
     D SQL_NULL_HENV   C                   0
     D SQL_NULL_HDBC   C                   0
     D SQL_NULL_HSTMT  C                   0
    ? *
    ? * data types for SQLGetCol() and friends
    ? *
     D SQL_CHAR        C                   1
     D SQL_NUMERIC     C                   2
     D SQL_DECIMAL     C                   3
     D SQL_INTEGER     C                   4
     D SQL_SMALLINT    C                   5
     D SQL_FLOAT       C                   6
     D SQL_REAL        C                   7
     D SQL_DOUBLE      C                   8
     D SQL_DATETIME    C                   9
     D SQL_VARCHAR     C                   12
     D SQL_BLOB        C                   13
     D SQL_CLOB        C                   14
     D SQL_DBCLOB      C                   15
     D SQL_DATALINK    C                   16
     D SQL_WCHAR       C                   17
     D SQL_WUARCHAR    C                   18
     D SQL_BIGINT      C                   19
     D SQL_BLOB_LOCATOR...
     D                 C                   20
     D SQL_CLOB_LOCATOR...
     D                 C                   21
     D SQL_DBCLOB_LOCATOR...
     D                 C                   22
     D SQL_UTF8_CHAR...
     D                 C                   23
     D SQL_GRAPHIC     C                   95
     D SQL_VARGRAPHIC  C                   96
     D SQL_BINARY      C                   97
     D SQL_VARBINARY   C                   98
     D SQL_DATE        C                   91
     D SQL_TYPE_DATE   C                   91
     D SQL_TIME        C                   92
     D SQL_TYPE_TIME   C                   92
     D SQL_TIMESTAMP   C                   93
     D SQL_TYPE_TIMESTAMP...
     D                 C                   93
     D SQL_ALL_TYPES   C                   0
     D SQL_DEFAULT     C                   99
     D SQL_ARD_TYPE    C                   -99
    ? *
    ? * return values
    ? *
     D SQL_SUCCESS     c                   0
     D SQL_SUCCESS_WITH_INFO...
     D                 c                   1
     D SQL_NO_DATA_FOUND...
     D                 c                   100
     D SQL_NEED_DATA...
     D                 c                   99
     D SQL_NO_DATA...
     D                 c                   100
     D SQL_ERROR       c                   -1
     D SQL_INVALID_HANDLE...
     D                 c                   -2
     D SQL_STILL_EXECUTING...
     D                 c                   2
    ? *
    ? * values for SQLFreeStmt
    ? *
     D SQL_CLOSE       c                   0
     D SQL_DROP        c                   1
     D SQL_UNBIND      c                   2
     D SQL_RESET_PARAMS...
     D                 c                   3
    ? *
    ? * Connection attributes
    ? *
     D SQL_ATTR_AUTOCOMMIT...
     D                 c                   10003
     D SQL_ATTR_COMMIT...
     D                 c                   0
     D SQL_ATTR_DATE_FMT...
     D                 c                   10020
     D SQL_ATTR_DATE_SEP...
     D                 c                   10021
     D SQL_ATTR_DBC_DEFAULT_LIB...
     D                 c                   10005
     D SQL_ATTR_DBC_SYS_NAMING...
     D                 c                   10004
     D SQL_ATTR_DECIMAL_SEP...
     D                 c                   10024
     D SQL_ATTR_EXTENDED_COL_INFO...
     D                 c                   10019
     D SQL_ATTR_TIME_FMT...
     D                 c                   10022
     D SQL_ATTR_TIME_SEP...
     D                 c                   10023
     D SQL_SAVEPOINT_NAME...
     D                 c                   10028
     D SQL_2ND_LEVEL_TEXT...
     D                 c                   10027
    ? *
    ? * SQL_ATTR_COMMIT values:
    ? *
     D SQL_TXN_NO_COMMIT...
     D                 c                   1
     D SQL_TXN_READ_UNCOMMITTED...
     D                 c                   2
     D SQL_TXN_READ_COMMITTED...
     D                 c                   3
     D SQL_TXN_REPEATABLE_READ...
     D                 c                   4
     D SQL_TXN_SERIALIZABLE...
     D                 c                   5
       //?environment & connection values
     D  SQL_FMT_ISO...
     D                 c                   1
     D  SQL_FMT_USA...
     D                 c                   2
     D  SQL_FMT_EUR...
     D                 c                   3
     D  SQL_FMT_JIS...
     D                 c                   4
     D  SQL_FMT_MDY...
     D                 c                   5
     D  SQL_FMT_DMY...
     D                 c                   6
     D  SQL_FMT_YMD...
     D                 c                   7
     D  SQL_FMT_JUL...
     D                 c                   8
     D  SQL_FMT_HMS...
     D                 c                   9
     D  SQL_FMT_JOB...
     D                 c                   10
     D  SQL_SEP_SLASH...
     D                 c                   1
     D  SQL_SEP_DASH...
     D                 c                   2
     D  SQL_SEP_PERIOD...
     D                 c                   3
     D  SQL_SEP_COMMA...
     D                 c                   4
     D  SQL_SEP_BLANK...
     D                 c                   5
     D  SQL_SEP_COLON...
     D                 c                   6
     D  SQL_SEP_JOB...
     D                 c                   7
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLAllocEnv(): Allocate an environment for SQL and return
    ? *                an environment handle
    ? *
    ? *        phenv = (output) environment handle
    ? *
    ? * Returns SQL_SUCCESS or SQL_ERROR
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocEnv     PR                  ExtProc('SQLAllocEnv')
     D                                     like(SQLRETURN)
     D   phenv                             like(SQLHENV)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLAllocConnect(): Allocate a connection handle
    ? *
    ? *     henv = (input) environment to allocate in
    ? *    phdbc = (output) new connection handle
    ? *
    ? * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocConnect...
     D                 PR                  ExtProc('SQLAllocConnect')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   phdbc                             like(SQLHDBC)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLAllocStmt(): Allocate a new SQL statement handle
    ? *
    ? *    hdbc = (input) handle to database connection
    ? *  phstmt = (output) new statement handle
    ? *
    ? * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLAllocStmt    PR                  ExtProc('SQLAllocStmt')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    phstmt                           like(SQLHSTMT)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLBindCol(): Bind column to application variable
    ? *
    ? *      hstmt = (input) statement handle
    ? *       icol = (input) column number to bind
    ? *     fCType = (input) application data type for column
    ? *   rgbValue = (output) pointer to variable where data is placed
    ? * cbValueMax = (input) max size of variable (in bytes or DBCS chars))
    ? *   pcbValue = (output) number of bytes returned
    ? *
    ? * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindCol      PR                  ExtProc('SQLBindCol')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    icol                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    cbValueMax                       like(SQLINTEGER) value
     D    pcbValue                         like(SQLINTEGER) options(*omit)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLSetParam(): Set Parameter
    ? *
    ? *      hstmt = (input) statement handle
    ? *       ipar = (input) parameter marker number to bind
    ? *     fCType = (input) application data type for column
    ? *   fSqlType = (input) SQL data type for column
    ? *   fSqlType = (input) SQL data type for column
    ? * cbParamDef = (input) precision of corresponding param marker
    ? *    ibScale = (input) scale of parm marker (decimal places)
    ? *   rgbValue = (i/o)   pointer to variable for data
    ? *                        or SQL_NULL_DATA if no data.
    ? *   pcbValue = (input) length of data, or SQL_NTS, or zero
    ? *                        or *OMIT if no data
    ? *
    ? * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindParam    PR                  ExtProc('SQLBindParam')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    ipar                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    fSqlType                         like(SQLSMALLINT) value
     D    cbParamDef                       like(SQLINTEGER) value
     D    ibScale                          like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    pcbValue                         like(SQLINTEGER) const
     d                                     options(*omit)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLConnect(): Connect to a data source
    ? *
    ? *       hdbc = (input) connection handle
    ? *      szDSN = (input) Data source name to connect to
    ? *      cbDSN = (input) length of szDSN parameter
    ? *      szUID = (input) Autorization name (UserID)
    ? *      cbUID = (input) Length of szUID parameter
    ? *  szAuthStr = (input) Authentication-string (password)
    ? *  cbAuthStr = (input) Length of szUID parameter
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLConnect      PR                  Extproc('SQLConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    szDSN                        *   value options(*string)
     D    cbDSN                            like(SQLSMALLINT) value
     D    szUID                        *   value options(*string)
     D    cbUID                            like(SQLSMALLINT) value
     D    szAuthStr                    *   value options(*string)
     D    cbAuthStr                        like(SQLSMALLINT) value
    ? * SQLDescribeCol (hstmt, i+1, colname, sizeof (colname),
    ? *    &colnamelen, &coltype[i], &collen[i], &scale, &nullable);
    ? *
    ? * SQLRETURN SQLDescribeCol (
    ? *    SQLHSTMT       hstmt,
    ? *    SQLSMALLINT    icol,
    ? *    SQLCHAR        *szColName,
    ? *    SQLSMALLINT    cbColNameMax,
    ? *    SQLSMALLINT    *pcbColName,
    ? *    SQLSMALLINT    *pfSqlType,
    ? *    SQLINTEGER     *pcbColDef,
    ? *    SQLSMALLINT    *pibScale,
    ? *    SQLSMALLINT    *pfNullable);
    ? *
    ? *  Data Type     Argument     Use    Description
    ? *  SQLHSTMT      hstmt        Input  Statement handle
    ? *  SQLSMALLINT   icol         Input  Column number to be described
    ? *  SQLCHAR *     szColName    Output Pointer to column name buffer
    ? *  SQLSMALLINT   cbColNameMax Input  Size of szColName buffer
    ? *  SQLSMALLINT * pcbColName   Output Bytes available to return for szColName argument.
    ? *                                    Truncation of column name (szColName) to
    ? *                                    cbColNameMax - 1 bytes occurs if
    ? *                                    pcbColName is greater than or equal to cbColNameMax.
    ? *  SQLSMALLINT * pfSqlType    Output SQL data type of column
    ? *  SQLINTEGER *  pcbColDef    Output Precision of column as defined in the database.
    ? *                                    If fSqlType denotes a graphic SQL data type,
    ? *                                    then this variable
    ? *                                    indicates the maximum number
    ? *                                    of double-byte characters the column can hold.
    ? *  SQLSMALLINT * pibScale     Output Scale of column as defined in the database (only applie
    ? *                                    to SQL_DECIMAL, SQL_NUMERIC, SQL_TIMESTAMP).
    ? *  SQLSMALLINT * pfNullable   Output Indicates whether NULLS are allowed for this column
    ? *                                    SQL_NO_NULLS
    ? *                                    SQL_NULLABLE
     d SQLDescribeCol  pr                  extproc('SQLDescribeCol')
     d                                     like(SQLRETURN)
     d hstmt                               like(SQLHSTMT   ) value
     d icol                                like(SQLSMALLINT) value
     d  szColName                      *   options(*string ) value
     d cbColNameMax                        like(SQLSMALLINT) value
     d  pcbColName                     *                     value
     d  pfSqlType                      *                     value
     d  pcbColDef                      *                     value
     d  pibScale                       *                     value
     d  pfNullable                     *                     value
     dSQL_NO_NULLS     c                   0
     dSQL_NULLABLE     c                   1
     dSQL_NULLABLE_UNKNOWN...
     d                 c                   2
    ? * get display length for column
    ? * SQLColAttributes (hstmt, i+1, SQL_DESC_PRECISION, NULL, 0     ,
    ? *    NULL, &displaysize);
     d SQLColAttributes...
     d                 pr                  extproc('SQLColAttributes')
     d                                     like(SQLRETURN)
     d hstmt                               like(SQLHSTMT   ) value
     d icol                                like(SQLSMALLINT) value
     d fDescType                           like(SQLSMALLINT) value
     d rgbDesc                         *                     value
     d cbDescMax                           like(SQLINTEGER ) value
     d pcbDesc                         *                     value
     d pfDesc                          *                     value
    ? * SQLRETURN SQLNumResultCols (SQLHSTMT       hstmt,
    ? *                             SQLSMALLINT    *pccol);
    ? *
    ? * Function Arguments
    ? *
    ? *
    ? *
    ? * Data Type      Argument  Use     Description
    ? * SQLHSTMT       hstmt     Input   Statement handle
    ? * SQLSMALLINT *  pccol     Output  Number of columns in the result set
     dSQLNumResultCols...
     d                 pr                  extproc('SQLNumResultCols')
     d                                     like(SQLRETURN)
     d  hstmt                              like(SQLHSTMT   ) value
     d  pccol                          *                     value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLDisconnect(): Disconnect from a data source
    ? *
    ? *  hdbc = (input) database connection handle to disconnect
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDisconnect   PR                  Extproc('SQLDisconnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? *  SQLExecDirect(): Execute an SQL Statement Directly
    ? *
    ? *     hstmt = (input) handle of SQL Statement
    ? *  szSqlStr = (input) SQL statement to execute
    ? *  cbSqlStr = (input) length of SQL statement
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *         SQL_NO_DATA_FOUND
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecDirect...
     D                 PR                  Extproc('SQLExecDirect')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLExecute(): Execute a prepared statement
    ? *
    ? *     hstmt = (input) handle of prepared SQL Statement
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *         SQL_NO_DATA_FOUND
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecute      PR                  Extproc('SQLExecute')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLFetch(): Fetch next row from result set
    ? *
    ? *     hstmt = (input) handle of prepared SQL Statement
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *         SQL_NO_DATA_FOUND  (also indicates end of result set)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFetch        PR                  Extproc('SQLFetch')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLFreeConnect(): Free SQL connection handle
    ? *
    ? *     hdbc = (input) handle of data source connection
    ? *                   that has already been disconnected
    ? *                   by SQLDisconnect()
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeConnect  PR                  Extproc('SQLFreeConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLFreeEnv(): Free Environment Handle
    ? *              (SQLFreeConnect needs to be called first)
    ? *
    ? *     henv = (input) environment handle to free up
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeEnv      PR                  Extproc('SQLFreeEnv')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLFreeStmt(): Free or Reset an SQL Statement Handle
    ? *
    ? *    hstmt = (input) statement handle to free or reset
    ? *  fOption = (input) option to perform, the values are:
    ? *              SQL_CLOSE  = Close a cursor
    ? *              SQL_DROP   = Drop a statement handle/free resources
    ? *              SQL_UNBIND = unbind columns from variables
    ? *              SQL_RESET_PARAMS = Reset parameters
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeStmt     PR                  Extproc('SQLFreeStmt')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    fOption                          like(SQLSMALLINT) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLGetCol(): Gets a column from a fetched row
    ? *
    ? *     hstmt  = (input) statement handle of fetch
    ? *      icol  = (input) column number to get
    ? *    fCType  = (input) application (not database) data type
    ? *                      of column identified by icol
    ? *                      (SQL_CHAR, SQL_VARCHAR, etc...)
    ? *   rgbValue = (input) pointer to memory (variable) where the
    ? *                      retrieved column data will be stored
    ? * cbValueMax = (input) maximum size of data to return
    ? *                        for DECIMAL or NUMERIC, this is
    ? *                        (precision * 256) + scale.
    ? *                        For anything else, it's bytes.
    ? *   pcbValue = (output) size of data available in database
    ? *                        or, amount remaining if fetching in pieces
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *         SQL_NO_DATA_FOUND (also indicates end of result set)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetCol       PR                  ExtProc('SQLGetCol')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   icol                              like(SQLSMALLINT) value
     D   fCType                            like(SQLSMALLINT) value
     D   rgbValue                          like(SQLPOINTER) value
     D   cbValueMax                        like(SQLINTEGER) value
     D   pcbValue                          like(SQLINTEGER) options(*omit)
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLPrepare(): Prepare an SQL statement to be executed
    ? *               one or more times.
    ? *
    ? *    hstmt = (input) statement handle to prepare into
    ? * szSqlStr = (input) SQL Statement to prepare
    ? * cbSqlStr = (input) length of SQL statement
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLPrepare      PR                  Extproc('SQLPrepare')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLSetConnectAttr(): Set connection attributes
    ? *
    ? *    hdbc = (input) connection handle to set attributes of
    ? *   fAttr = (input) Attribute to set
    ? *  vParam = (input) pointer to new attribute value
    ? *    sLen = (input) length of new attribute value
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_SUCCESS_WITH_INFO
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetConnectAttr...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrI...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLINTEGER) const
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrS...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                  32767A   options(*varsize) const
     D    sLen                             like(SQLINTEGER) value
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ? * SQLError(): Retrieve Error Information
    ? *
    ? *        henv = (input) environment handle
    ? *        hdbc = (input) database connection handle
    ? *                       (or SQL_NULL_HDBC)
    ? *       hstmt = (input) statement handle (or SQL_NULL_HSTMT)
    ? *  szSqlState = (output) SQL State (null-terminated)
    ? * pfNativeErr = (output) Native error code
    ? *  szErrorMsg = (output) Message text of error message
    ? * cbErrMsgMax = (input) max size of szErrorMsg parameter
    ? * pcbErrorMsg = (output) total bytes available for err msg.
    ? *
    ? * Returns SQL_SUCCESS,
    ? *         SQL_NO_DATA_FOUND
    ? *         SQL_ERROR
    ? *         SQL_INVALID_HANDLE
    ? *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLError        PR                  extproc('SQLError')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   hdbc                              like(SQLHDBC) value
     D   hstmt                             like(SQLHSTMT) value
     D   szSqlState                    *   value
     D   pfNativeErr                   *   value
     D   szErrorMsg                    *   value
     D   cbErrMsgMax                       like(SQLSMALLINT) value
     D   pcbErrorMsg                   *   value

    ? *



     D DiagSqlCa       Pr



    ?d*exc180          ds
    ?d*cmd                            1    dim(180)
    ?d*exc             s            180
     d exc1k           s           1000
    ?d*---------------------------------------------------------------*
     d var             s             11    dim(20)
    ?d* la valeur de remplacement
     d val             s             54    dim(20)
    ?d* longueur utile du nom
     d varl            s              2  0 dim(20)
    ?d* longueur utile de la variable
     d vall            s              2  0 dim(20)
    ?d*---------------------------------------------------------------*
     d  sqlopt         s            800    inz('commit(*none) naming(*sys)')
     d                                     varying
    ?d*---------------------------------------------------------------*
    ?d* le nom des variables
     d vars            ds           642
     d  nbvars                 1      2b 0
     d  offstx                 3     22
     d                                     dim(10)
     d  v                      2    642
     d                                     dim(641)
     d offset          ds                  based(POffset)
     d  o                      1      2b 0
     d unevar          ds                  based(PUneVar)
     d  nbelem                 1      2b 0
     d  lenom                  3     12
     d  lavalr                13     62
     d srcatr          ds           100
     d  srctype                      10
     d  srcdate                      13
     d  srclib                       10
     d  srcfile                      10
     d  srcmbr                       10
    ? * detection de creation de fichier
     d sqlstring       s          32767    varying
    ? * up to V5R3 (SQLRPGLE preprocessor again at RPG3 level)
    ?d*mySQL           s           9999
    ? * from V5R4  (SQLRPGLE preprocessor at RPG4 level)
     d mySQL           s          32766
    ?d*mySQL           s          32767   SQL5044
    ?d* - Pour une chaîne CHAR, la longueur maximale est de 32766.
    ?d*mySQL           s          50000   MCH1210
    ?d* zone tmp de conversion var en val
     d wt              s           1024    varying


     d wm              s           1024    varying


     d CloseCLI        pr
     d LogRC           pr
     d rc                            10i 0 const
     d monitor                       10    options(*nopass)
     d valvar          pr
     d sqltxt          pr
     d sqlatr          pr
     d sqlset          pr
     d execop          pr
     d sqlop           pr
     d ecrit           pr
     d ExecSql         pr
     d lcase           pr         32787    varying
     d  FromString                32787    varying const
     d ucase           pr         32787    varying
     d  FromString                32787    varying const
     d LoadParm        pr
     d LoadInit        pr
     d LoadLast        pr
     d LoadQSYS        pr
     d LoadIFS         pr
     d LoadIFS2        pr
     d GetStmt         pr
     d execsql3r       pr
     d  vars                        642
     d  wwsrcl                        6p 2
     d  wwsrcf                        6p 2
     d  wwhold                        4
     d  wwsplf                       10
     d  wwsatr                      100
     d  JobLog                        4
     d  COMMIT                       10
     d  NAMING                       10
     d  DATFMT                       10
     d  DATSEP                       10
     d  TIMFMT                       10
     d  TIMSEP                       10
     d  DFTRDBCOL                    10
     d  DECMPT                       10
     d   Database                    30
     d   userid                      30
     d   password                    30
     d     STACK                     10
     d     STREAM                   500
     d     STARTTAG                  50
     d     STOPTAG                   50
     d    ChgObjAtr                   4
     d  init                         50
     d  last                         50
     d execsql3r       pi
     d  p_vars                      642
     d  wwsrcl                        6p 2
     d  wwsrcf                        6p 2
     d  p_hold                        4
     d  p_splf                       10
     d  p_satr                      100
     d  p_JobLog                      4
     d  p_COMMIT                     10
     d  p_NAMING                     10
     d  p_DATFMT                     10
     d  p_DATSEP                     10
     d  p_TIMFMT                     10
     d  p_TIMSEP                     10
     d  p_DFTRDBCOL                  10
     d  p_DECMPT                     10
     d  p_Database                   30
     d  p_userid                     30
     d  p_password                   30
     d   p_STACK                     10
     d   p_STREAM                   500
     d   p_STARTTAG                  50
     d   p_STOPTAG                   50
     d   p_ChgObjAtr                  4
     d   p_init                      50
     d   p_last                      50
    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST
     D cmdlen          s             15P 5
     d  wwfrom         s              6s 2
     d  wwto           s              6s 2
     d  runsql         s               n
    ? * pile sql : une ligne de texte source
    ? *dqtxtf            ds
    ?d* srcseq         s              6p 2
    ?d* srcdat         s              6p 0
    ?d* srcdta         s            120
     d  SqlStm         s           1024    varying
     d  UserAttr       s             10    inz('*SAME')
     d  Text           s             50    inz('*SAME')
     d  RunMode        s             10
     d  MonMsg         s             15
     d  I              s              5  0
     d  J1             s              5  0
     d  J2             s              5  0
     d  J3             s              5  0
     d  J4             s              5  0
     d  J              s              5  0
     d  PmLng          s             15  5
     d  libfic         s            140
     d  lib            s             10
     d  fic            s            128
     d  wwsub          s             11
     d  x11            s             11
     d  usrdta         s             10
     d  sqlobj         s             30
     d execopt         ds                  qualified
     D   env                               like(SQLHENV)  inz(0)
     D   conn                              like(SQLHDBC)  inz(0)
     D   stmt                              like(SQLHSTMT) inz(0)
     d   semicolon                   10    inz(';')
     d   naming                       4    inz('*sys')
     d   joblog                      10    inz('*no')
     d   commit                      10    inz('*none')
     d   connected                     n   inz(*off)
     d   datfmt                      10    inz('*iso')
     d   datsep                      10    inz('*job')
     d   dftlib                      10    inz('*none')
     d   decsep                      10    inz('*job')
     d   timfmt                      10    inz('*iso')
     d   timsep                      10    inz('*job')
     d   Database                    30    inz('*local')  varying
     d   userid                      30    inz('*none')   varying
     d   password                    30    inz('*none')   varying
    ? * fields for SQLerror
     D   hstmt         s                   like(SQLHSTMT)
     D   szSqlState    s              6A
     D   pfNativeErr   s                   like(SQLINTEGER)
     D   szErrorMsg    s           3132
     D   cbErrMsgMax   s                   like(SQLSMALLINT)
     D   pcbErrorMsg   s                   like(SQLSMALLINT)
     d rc              s             10i 0
    ? * load script into memory to avoid read script interupted by a release connection
    ? * or a commit without hold
     d ScriptLine    e ds                  qualified extname(qtmpsrc)
     d                                     based(pScriptLine)

     d Script          s          65535    based(pScript)
     d ScriptAllocLen  s             10i 0 inz(65535)
     d ScriptNbr       s             10i 0 inz(0)
     d ScriptPos       s             10i 0 inz(0)
     d ScriptLen       s             10i 0 inz(0)
     d ScriptLineLen   s             10i 0 inz(%size(ScriptLine))
    ? * load fromifs
    ? * extracted line of statement : pointer to write in Script
     d scripttext      s          65535    varying based(pScriptText   )
     d ifsdata         s            100
     d ifspos          s             10i 0
     D FileHandle      s             10i 0
     D crlfpos         s             10i 0
     d i1              s             10i 0
     d i2              s             10i 0
    ? * data read from ifs
     d scriptifs       s          65000
     d pScriptifs      s               *   inz(%addr(ScriptIfs))
    ? * window to scan scripifs
     d Ifs             s           1000    based(pIfs)

     d mySFW           s           5000

     d ateof           s               n
     d bytesin         s             10i 0
     d errcpe          ds
     d cpetxt                         3    inz('CPE')
     d cpenum                         4s 0
     d IfsSize         s             10i 0
     d myStat          ds                  likeds(statds)
     d addsemicolon    s               n
     d Mot             s             20
     d QTmpIsOpen      s               n
     d Troncature      s               n
     d JobLog          pr
     d    msgno                       7    const         options(*omit)         n°
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key

    ? * Retrieve Short Name (QDBRTVSN) API
     d qdbrtvsn        pr                  extpgm('QDBRTVSN')
     d Qualname                      20
     d Longname                     128    const
     d LongNameLen                   10i 0 const
     d Library                       10    const
     d Errorcode                    255
     d Qualname        s             20
     d LongNameLen     s             10i 0

     d HldExecute      s               n   inz(*off)
     d HoldExecute     pr


      /FREE
       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , DATFMT = *iso
          , TIMFMT = *iso
          , NAMING = *sql
          , Sqlpath= *libl
          , Rdbcnnmth=*duw ;
       //?commit = *CS 1) ne permet pas create as select with data
       //?  2) oblige a journaliser les tables pour autoriser l'insert
       //?  3) ce qui empeche d'utiliser QTEMP. Pas cool.
       //?a essayer : changer d'isolation level à la volée sous executesql
       //?rq : sous runsql, on peut changer de Commit Mode entre chaque sql
       //
       //?ruw oblige le actgrp a rester sur la derniere connection
       //?ce qui permet de retrouver le sqlpkg sur le drda *local
       //?au prochain lancement de execsql sans obliger RCTACTGRP
       //?pas oublier revenir DRDA *LOCAL en fin de script
       Exec Sql
          Connect Reset ;
       Clear *all Qtmpf;
       LoadParm();
       //?variables internes
       wwfrom = wwsrcl;
       wwto = wwsrcf;
       //?---pile de commandes
       pScript=%Alloc(ScriptAllocLen);
       ScriptLen = 0 ;
       ScriptNbr = 0 ;
       LoadInit();
B01    If p_STACK = '*QSYS';
          LoadQSYS();
X01    Else;
          LoadIFS ();
E01    Endif;
       LoadLast();
       ifspos = 0;
B01    For Ifor = 0 To ScriptNbr ;
          GetStmt();
          //?ne pas traiter les commentaires
B02       If (%Subst(SqlStm:1:1) = '*' And %Subst(SqlStm:1:2)<> '*/' )
X02       Or (%Subst(SqlStm:1:2) = '--'
X..          And %Subst(SqlStm:1:3) <> '-->');
             Iter;
E02       Endif;
          //?
          wm = SqlStm ;
          //?traitement des variables, s'il y en a
          valvar();
          //?execution conditionnelle
          I = %Scan('holdexecute':%Triml(lcase(wm)));
B02       If I=0;
             I = %Scan('-->holdexecute':%Triml(lcase(wm)));
E02       Endif;
B02       If I = 1;
             HoldExecute();
             Iter;
E02       Endif;
          //?monitorer les messages - insensible à HldExecute
          I = %Scan('monmsg':lcase(wm));
B02       If I > *zero;
             Mot = %Trim(%Subst(lcase(wm):I+6));
B03          If Mot='';
                MonMsg = '*escape' ;   //?IE stop monitoring errors
X03          Elseif
                   %Scan('ignorewarning':Mot) <>*zero;
                MonMsg = '*warning' ;   //?for sqlcod > 0
X03          Elseif
                   %Scan('ignore':lcase(wm))<>0;
                MonMsg = '*ignore' ;   //?IE hide any error
X03          Elseif
                   %Scan('warning':lcase(wm))<>0;
                MonMsg = '*warning' ;   //?for sqlcod > 0
X03          Elseif
                   %Scan('escape':lcase(wm))<>0;
                MonMsg = '*escape' ;   //?IE stop monitoring errors
X03          Else;
                MonMsg = Mot ;   //?either CPF1234 or ST12345
E03          Endif;
B03          If runsql = *on;
                JobLog('':%Char(Srcseq) + ' <monmsg ' + MonMsg+ '>'
                   :'':'':'*INFO':'*':0);
E03          Endif;
             Iter;
E02       Endif;
          //?now, code found in the stack is sensitive to HldExecute
B02       If Not HldExecute;
             //?remplacement de ; ?
B03          If execopt.semicolon <> ';';
B04             If %Trim(wm) = ';';
                   wm = execopt.semicolon+
                '                                                             ';
E04             Endif;
E03          Endif;
             I = 0;
             //?fin d'etape
             I = %Scan('runsql':%Triml(lcase(wm)));
B03          If I=0;
                I = %Scan('-->runsql':%Triml(lcase(wm)));
E03          Endif;
B03          If I = 1;
B04             If runsql;
                   RunMode='RUNSQLSTM';
                   ExecSql();
E04             Endif;
                Iter;
E03          Endif;
             I = %Scan('executesql':%Triml(lcase(wm)));
B03          If I=0;
                I = %Scan('-->executesql':%Triml(lcase(wm)));
E03          Endif;
B03          If I = 1;
B04             If runsql;
B05                If execopt.NAMING<>'*sql';
                      execopt.NAMING ='*sql';
                      JobLog('':'<automatic execopt naming=*sql>'
                         :'':'':'*INFO':'*':0);
E05                Endif;
                   RunMode='EXECUTESQL';
                   ExecSql();
E04             Endif;
                Iter;
E03          Endif;
             I = %Scan('executecli':%Triml(lcase(wm)));
B03          If I=0;
                I = %Scan('-->executecli':%Triml(lcase(wm)));
E03          Endif;
B03          If I = 1;
B04             If runsql;
                   RunMode='EXECUTECLI';
                   ExecSql();
E04             Endif;
                Iter;
E03          Endif;
             I = 1;
             //?option SETVAR ?
B03          If %Subst(lcase(wm) : 1 : 6) = 'setvar'
X03          Or %Subst(lcase(wm) : 1 : 9) = '-->setvar';
                sqlset();
                Iter;
E03          Endif;
             //?option EXECOPT?
B03          If %Subst(lcase(wm) : 1 : 7) = 'execopt'
X03          Or %Subst(lcase(wm) : 1 :10) = '-->execopt';
                execop();
                Iter;
E03          Endif;
             //?options runsqlstm (après execopt, test sur sqlopt en conflit)
             I = %Scan('sqlopt':lcase(wm));
B03          If I > *zero;
                sqlop();
                Iter;
E03          Endif;
             //?option USERATTR ?
B03          If %Subst(lcase(wm) : 1 : 17) = 'oncreate-userattr'
X03          Or %Subst(lcase(wm) : 1 : 20) = '-->oncreate-userattr';
                sqlatr();
                Iter;
E03          Endif;
             //?option TEXT ?
B03          If %Subst(lcase(wm) : 1 : 13) = 'oncreate-text'
X03          Or %Subst(lcase(wm) : 1 : 16) = '-->oncreate-text';
                sqltxt();
                Iter;
E03          Endif;
             //?ecrire
B03          If runsql;
                ecrit();
E03          Endif;
E02       Endif;   //?hldexecute
          //?ligne suivante de texte
E01    Endfor;
       JobLog('':'<End Of SQL Stack>':'':'':'*INFO':'*':0);
       CloseCLI();
       Dealloc pScript;
       Exec Sql
          Release All
          ;
       Exec Sql
          Connect Reset
          ;
       *inlr = *on;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
B02       If %Open(Qtmpsrc);
             Close Qtmpsrc;
E02       Endif;
          CloseCLI();
E01    Endsr '*CANCL';
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=        V A L V A R
       //?=
       //?=
       //?= traitement des variables, s'il y en a
       //?=------------------------------------------------------------------------
      /end-free

      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

BPR ?p valvar          b
     d valvar          pi
      /free
       //?begsr valvar;
       //?traitement des variables, s'il y en a
       wt= wm ;
B01    If nbvars > *zero;
B02       For Ever;
             I= %Scan('&' : wm );
B03          If I = 0;
                Leave;
E03          Endif;
B03          For J1 = 1 To nbvars;
                J2 = varl(J1);
                //?une variable. trouver laquelle
B04             If J2 <= 0;
                   Iter;
E04             Endif;
                wwsub = %Subst (wm : I : J2);
B04             If wwsub <> var(J1) ;
                   Iter;
E04             Endif;
                //?variable identifiee. remplacer (ici wm=wt)
                //?exemple
                //?var,x = '&target     '
                //?varl,x = 7
                //?val,x = 'ugi5sidsic                                         '
                //?vall,x = 10
                //?wt = delete from &target/clicomp where clcsoc='&csoc'
                //?                 ^      ^
                //?                 i      i+varl,x
                //?                 <-----> varl,x
                //?action : wt -> wm (etat initial en debut de boucle)
                //?         val,x -> wm,i
                //?         wt,(i+varl,x) -> wm,(i+vall,x)
                //?prepa pour la boucle suivante
                //? j3 = varl(j1) + i;  // longueur à enlever
                //? j4 = vall(j1) + i;  // longueur à ajouter
                wm = %Subst(wm : 1 : I - 1) +
                   %Trimr(val(J1)) +
                   %Subst(wm : I+ varl(J1));
                I = 0;
                Leave;
                //?variable suivante
E03          Endfor;
             //?detection de parametre non transmis
B03          If I > 0 ;
                Spmsid = 'CPD0172' ;
                Spmsda = 'utilisation d''un parametre non transmis : '
                   + wwsub;
                Spfile = 'qtxtsrc' ;
                Spfrtn = 'cvt vars' ;
                Spfrnb = %Char( Srcseq ) ;

                Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                   :'*ESCAPE':'*PGMBDY':1) ;
                ecrit();
                Exsr *pssr;
E03          Endif;
             //?'&' suivant
E02       Endfor;
          //?avec variables
E01    Endif;
       //?endsr;
B01    Begsr *pssr;

B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=        S Q L T X T
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p sqltxt          b
     d sqltxt          pi
      /free
       //? begsr sqltxt;
B01    If runsql = *on;
          J = %Scan('=':lcase(wm));
B02       If J > I;
             Text = %Trim(%Subst(wm :J + 1));
             SqlStm = '<Text='
                + %Trim(Text) + '>';
             JobLog('':%Char(Srcseq)+' ' +%Trim(SqlStm):'':'':'*INFO':'*':0);
E02       Endif;
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            S Q L A T R
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p sqlatr          b
     d sqlatr          pi
      /free
       //?begsr sqlatr;
       J = %Scan('=':lcase(wm));
B01    If J > I;
          UserAttr = %Trim(%Subst(wm :J + 1));
          SqlStm = '<UserAttr='
             + %Trim(UserAttr) + '>';
          JobLog('':%Char(Srcseq)+' '+%Trim(SqlStm):'':'':'*INFO':'*':0);
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
BPR ?p sqlset          b
     d sqlset          pi
      /free
       I = %Scan(' ':lcase(wm) : 6);
B01    If I = *zero;
          JobLog('':
        'Syntax error at '+%Char(Srcseq)+' '+%Trim(SqlStm):'':'':'*INFO':'*':0);
X01    Else;
          J = 0;
          J = %Scan('=':lcase(wm));
B02       If J <=I;
             JobLog('':
        'Syntax error at '+%Char(Srcseq)+' '+%Trim(SqlStm):'':'':'*INFO':'*':0);
X02       Else ;
             x11 = '&' +
                %Trim(%Subst(wm : I+1 : J - I - 1));
             //?ajout ou modif ?
             I = %Lookup(x11 : var );
B03          If I = 0;
                //?ajout
                nbvars +=1;
                I = nbvars;
                var(I) = x11;
                varl(I) = %Checkr(' ':var(I));
E03          Endif;
             //?modifier la valeur
             //?***************** eval      val(i) = %trim(%subst(wm : j + 1))
             val(I) = %Subst(wm : J + 1);
             vall(I) = %Checkr(' ' : val(I));
             SqlStm = '<SetVar ' +
                %Subst(var(I) : 1 : varl(I)) + '='
                + %Subst(val(I) : 1 : vall(I)) + '>';
             JobLog('':%Char(Srcseq)+' '+%Trim(SqlStm):'':'':'*INFO':'*':0);
E02       Endif;
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            E X E C O P
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p execop          b
     d execop          pi
     d keyword         s             20
      /free
       //?enlever execopt, les espaces, // passer en minuscules
       wm = %Trim(%Subst( wm :8));
       I=0;
       I=%Scan('=':wm);
B01    If I = 0;
          Return ;
E01    Endif;
       //?closecli() ;
       keyword = %Trim(lcase(%Subst(wm:1:I-1))) ;
       //?keyword values with preserved case
B01    If keyword = 'database';
          execopt.Database = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt DataBase='+execopt.Database+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'userid';
          execopt.userid = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt UserId='+execopt.userid+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'Password';
          execopt.password = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt password=Polichinelle>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
       //?keyword values lowercased
       wm = lcase(wm) ;
B01    If keyword = 'semicolon';
          execopt.semicolon = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt SemiColon='
             +execopt.semicolon+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'naming';
          execopt.NAMING = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt Naming='+execopt.NAMING+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'commit';
          execopt.Commit = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt Commit='+execopt.Commit+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'datfmt';
          execopt.DATFMT = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt DatFmt='+execopt.DATFMT+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'datsep';
          execopt.DATSEP = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt DatSep='+execopt.DATSEP+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'dftlib';
          execopt.dftlib = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt DftLib='+execopt.dftlib+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'decsep';
          execopt.decsep = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt DecSep='+execopt.decsep+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'timfmt';
          execopt.TIMFMT = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt TimFmt='+execopt.TIMFMT+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'timsep';
          execopt.TIMSEP = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt TimSep='+execopt.TIMSEP+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'joblog';
          execopt.JobLog = %Trim(%Subst(wm:I+1));
          JobLog('':%Char(Srcseq) + ' <ExecOpt JobLog='+execopt.JobLog+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    If keyword = 'sqlopt';
          sqlopt = %Trim(%Subst(wm:I+1)) ;
B02       If sqlopt='*gen';
             sqlopt='commit(' + %Trim(execopt.Commit)+ ') ' ;
             sqlopt += 'naming(' + %Trim(execopt.NAMING)+ ') ' ;
             sqlopt += 'dftrdbcol(' + %Trim(execopt.dftlib)+ ') ' ;
             sqlopt += 'decmpt(' + %Trim(execopt.decsep)+ ') ' ;
             sqlopt += 'datfmt(' + %Trim(execopt.DATFMT)+ ') ' ;
             sqlopt += 'timfmt(' + %Trim(execopt.TIMFMT)+ ') ' ;
B03          Select;
X03             When execopt.DATSEP = '*slash';
                   sqlopt += 'datsep(''/'') ' ;
X03             When execopt.DATSEP = '*period';
                   sqlopt += 'datsep(''.'') ' ;
X03             When execopt.DATSEP = '*comma';
                   sqlopt += 'datsep('','') ' ;
X03             When execopt.DATSEP = '*dash ';
                   sqlopt += 'datsep(''-'') ' ;
X03             Other;
                   sqlopt += 'datsep(' + %Trim(execopt.DATSEP)+ ') ' ;
E03          Endsl;
B03          Select;
X03             When execopt.TIMSEP = '*colon';
                   sqlopt += 'timsep('':'') ' ;
X03             When execopt.TIMSEP = '*period';
                   sqlopt += 'timsep(''.'') ' ;
X03             When execopt.TIMSEP = '*comma';
                   sqlopt += 'timsep('','') ' ;
X03             Other;
                   sqlopt += 'timsep(' + %Trim(execopt.TIMSEP)+ ') ' ;
E03          Endsl;
             //?SAAFLAG(*NOFLAG)
             //?FLAGSTD(*NONE)
             //?SRTSEQ(*JOB)
             //?LANGID(*JOB)
             //?PRTFILE(QSYSPRT)
             //?PROCESS(*RUN)
             //?OUTPUT(*NONE)
             //?TGTRLS(*CURRENT)
E02       Endif;
          JobLog('':%Char(Srcseq) + ' <ExecOpt SqlOpt='+sqlopt+ '>'
             :'':'':'*INFO':'*':0) ;
          Return ;
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            S Q L O P
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p sqlop           b
     d sqlop           pi
      /free
       I+=6;
       sqlopt = %Subst(wm : I);
B01    If sqlopt <> '';
          JobLog('':%Char(Srcseq) + ' ' + %Trim(sqlopt):'':'':'*INFO':'*':0);
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            E C R I T
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p ecrit           b
     d ecrit           pi
    ?d*crlf            c                   const(x'0d25')
      /free
B01    If QTmpIsOpen = *off;
          Open Qtmpsrc;
          QTmpIsOpen = *on;
E01    Endif;
       //?joblog : par qmhsndpm
       //?********* '''':'"'  xlatewm        srcdta
       //?
       //?=---
       //?travail
       Srcdta= wm ;
B01    If Srcdta <> wm;
          Troncature=True;
E01    Endif;
B01    If wm = *blank;
          Return;
E01    Endif;
       Write Qtmpf;
       //?crlf pour marquer les fins de commentaires  par tirettiret non cadrés en pos 1
       //?ça met plus de desordre que ça en resout.
       //?executesql n'aime pas du tout. runsql devrait supporter bien mieux
B01    If p_STACK='*QSYS';
          sqlstring+= %Trim(wm) + ' ' ;
B02       If wm <> '';
             JobLog('':%Char(Srcseq) + ' ' + %Trim(wm) :'':'':'*INFO':'*':0) ;
E02       Endif;
X01    Else;
          sqlstring+= %Trim(wm) + ' ' ;
          JobLog('':%Char(Srcseq) + ' ' + %Trim(wm) :'':'':'*INFO':'*':0) ;
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            E X E C
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p ExecSql         b
     d ExecSql         pi
    ?d*-------------------
     d sql8880         ds                  qualified
     d   er5                         10i 0
     d   sqlleft                    500
     d   sqlright                   500
    ?d*-------------------
      /free
B01    If QTmpIsOpen = *off;
          Return ;
E01    Endif;
       Close Qtmpsrc;
       QTmpIsOpen = *off;

B01    If Not HldExecute And %Len(sqlstring)>0;
          //?status message with SqlString
          //?if %len(sqlstring) > 78;
          //?message('CPF9898':%subst(sqlstring:1:80):'*LIBL':'QCPFMSG':'*STATUS');
          //?else;
          //?message('CPF9898':sqlstring:'*LIBL':'QCPFMSG':'*STATUS');
          //?endif;
          //?une commande système ?

B02       If %Len(sqlstring)>2 And lcase(%Subst(sqlstring:1:3))='cl:';
             RunMode='QCMDEXC';
             //? QCMDEXEC
             JobLog('':%Char(Srcseq) + ' <QCmdExc>'
                :'':'':'*INFO':'*':0) ;
             sqlstring = %Subst(sqlstring:4);
             cmdlen=%Len(sqlstring);
             //?mysql = sqlstring;
             mySQL = %Xlate(
                x'000102030405060708090a0b0c0d0e0f'+
                x'101112131415161718191a1b1c1d1e1f'+
                x'202122232425262728292a2b2c2d2e2f'+
                x'303132333435363738393a3b3c3d3e3f' :
                '                                '+
                '                                ' : sqlstring);
             Callp(E) QCmdExec(mySQL:cmdlen);

B03          If %Error;
B04             Select ;
X04                When MonMsg = '*escape' ;
                      //?dumpcallstack();
                      Needdump=False;
                      Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                         :'*ESCAPE':'*PGMBDY':1) ;
X04                When MonMsg = '*ignore' ;
                      JobLog('' :Spmsda:'':'':'*DIAG':'*':3) ;
                      //?monmsg = soit CPF0000 xxx0000 xxxnn00 xxxnnnn
X04                When MonMsg = 'CPF0000' ;
                      JobLog('' :Spmsda:'':'':'*DIAG':'*':3) ;
X04                When %Subst(MonMsg:4:4) = '0000';
B05                   If %Subst(Spmsid:1:3) = %Subst(MonMsg:1:3);
                         JobLog('' :Spmsda:'':'':'*DIAG':'*':3) ;
X05                   Else;
                         //?dumpcallstack();
                         Needdump=False;
                         Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                            :'*ESCAPE':'*PGMBDY':1) ;
E05                   Endif;
X04                When %Subst(MonMsg:6:2) = '00';
B05                   If %Subst(Spmsid:1:5) = %Subst(MonMsg:1:5);
                         JobLog('' :Spmsda:'':'':'*DIAG':'*':3) ;
X05                   Else;
                         //?dumpcallstack();
                         Needdump=False;
                         Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                            :'*ESCAPE':'*PGMBDY':1) ;
E05                   Endif;
X04                Other ;
B05                   If MonMsg = Spmsid ;
                         JobLog('' :Spmsda:'':'':'*DIAG':'*':3) ;
X05                   Else;
                         //?dumpcallstack();
                         Needdump=False;
                         Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                            :'*ESCAPE':'*PGMBDY':1) ;
E05                   Endif;
E04             Endsl;
E03          Endif;
             sqlstring = '';
             //?non, reste à vider QTMPSRC
             //?Return ;
E02       Endif;





B02       If RunMode='EXECUTECLI';
             //?
             JobLog('':%Char(Srcseq) + ' <ExecuteCli>'
                :'':'':'*INFO':'*':0) ;
             //?if %len(sqlstring) > %len(mysql) ;
             //?die ('sql string too long for this version on SQLRPGLE '
             //?    + '(' + %editc(%len(sqlstring):'Z') + ' > ' +
             //?    %editc(%len(MySql):'Z') + ')');
             //?endif;
             //?mySQL = sqlstring;
             //?
B03          Select;
                //?disconnect without database name ? use CLOSECLI
X03             When lcase(%Trim(sqlstring)) = 'disconnect';
                   CloseCLI();
                   //?connect without database ? uses execopt parameters
                   //?
X03             When lcase(%Trim(sqlstring)) = 'connect';
                   CloseCLI();
                   execopt.connected = *on ;
                   //?   joblog('':%char(srcseq) + ' <SQLAllocEnv>'
                   //?      :'':'':'*INFO':'*':0)  ;
                   LogRC(SqlAllocEnv(execopt.env));
                   //?   joblog('':%char(srcseq) + ' <SQLAllocConnect>'
                   //?      :'':'':'*INFO':'*':0)  ;
                   LogRC(SqlAllocConnect(execopt.env: execopt.conn));
                   //?options
B04                Dow 1=0;
                      //?   joblog('':%char(srcseq) + ' <SQLSetConnectAttributes>'
                      //?      :'':'':'*INFO':'*':0)  ;
                      //?SQL_ATTR_AUTOCOMMIT
B05                   If execopt.Commit='*none';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_AUTOCOMMIT : SQL_TRUE : %Size(SQLINTEGER)));
X05                   Else;
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_AUTOCOMMIT : SQL_FALSE: %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_COMMIT
                      //?ISOLATION LEVEL
                    //?Specifies the isolation level of the transaction. If the ISOLATION LEVEL clau
                      //?is not specified, ISOLATION LEVEL SERIALIZABLE is implicit
                      //?NO COMMIT
                      //?Specifies isolation level NC (COMMIT(*NONE)).
                      //?READ UNCOMMITTED
                      //?Specifies isolation level UR (COMMIT(*CHG)).
                      //?READ COMMITTED
                      //?Specifies isolation level CS (COMMIT(*CS)).
                      //?REPEATABLE READ 66
                      //?Specifies isolation level RS (COMMIT(*ALL)).
                      //?SERIALIZABLE
                      //?Specifies isolation level RR (COMMIT(*RR)).
B05                   If execopt.Commit ='*none';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                    : SQL_ATTR_COMMIT : SQL_TXN_NO_COMMIT : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.Commit ='*chg ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
             : SQL_ATTR_COMMIT : SQL_TXN_READ_UNCOMMITTED : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.Commit ='*cs  ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
               : SQL_ATTR_COMMIT : SQL_TXN_READ_COMMITTED : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.Commit ='*rr';
                         LogRC(SQLSetConnectAttrI( execopt.conn
              : SQL_ATTR_COMMIT : SQL_TXN_REPEATABLE_READ : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.Commit ='*all ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                 : SQL_ATTR_COMMIT : SQL_TXN_SERIALIZABLE : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_DATE_FMT
B05                   If execopt.DATFMT = '*iso ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_ISO : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*usa ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_USA : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*eur ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_EUR : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*jis ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_JIS : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*mdy ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_MDY : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*ymd ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_YMD : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*jul ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_JUL : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATFMT = '*job ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_FMT: SQL_FMT_JOB : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_DATE_SEP
B05                   If execopt.DATSEP = '*slash';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_DATE_SEP: SQL_SEP_SLASH : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATSEP = '*dash';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                        : SQL_ATTR_DATE_SEP: SQL_SEP_DASH : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATSEP = '*period';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                      : SQL_ATTR_DATE_SEP: SQL_SEP_PERIOD : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATSEP = '*comma';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_DATE_SEP: SQL_SEP_COMMA : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATSEP = '*blank';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_DATE_SEP: SQL_SEP_BLANK : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.DATSEP = '*job';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_DATE_SEP: SQL_SEP_JOB : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_DBC_DEFAULT_LIB
B05                   If execopt.dftlib <> '*none' And execopt.NAMING='*sql';
                         LogRC(SQLSetConnectAttrS( execopt.conn
            : SQL_ATTR_DBC_DEFAULT_LIB:execopt.dftlib : %Size(execopt.dftlib)));
E05                   Endif;
                      //?SQL_ATTR_DBC_SYS_NAMING
B05                   If execopt.NAMING = '*sql';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                      : SQL_ATTR_DBC_SYS_NAMING: SQL_FALSE: %Size(SQLINTEGER)));
X05                   Else;
                         LogRC(SQLSetConnectAttrI( execopt.conn
                      : SQL_ATTR_DBC_SYS_NAMING: SQL_TRUE : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_DECIMAL_SEP
B05                   If execopt.decsep = '*period';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                   : SQL_ATTR_DECIMAL_SEP: SQL_SEP_PERIOD : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.decsep = '*comma';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                    : SQL_ATTR_DECIMAL_SEP: SQL_SEP_COMMA : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_EXTENDED_COL_INFO
                      LogRC(SQLSetConnectAttrI( execopt.conn
                   : SQL_ATTR_EXTENDED_COL_INFO: SQL_TRUE : %Size(SQLINTEGER)));
                      //?SQL_ATTR_TIME_FMT
B05                   If execopt.TIMFMT = '*iso ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_FMT: SQL_FMT_ISO : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMFMT = '*usa ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_FMT: SQL_FMT_USA : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMFMT = '*eur ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_FMT: SQL_FMT_EUR : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMFMT = '*jis ';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_FMT: SQL_FMT_JIS : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMFMT = '*hms';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_FMT: SQL_FMT_HMS : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_ATTR_TIME_SEP
B05                   If execopt.TIMSEP = '*colon';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_TIME_SEP: SQL_SEP_COLON : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMSEP = '*period';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                      : SQL_ATTR_TIME_SEP: SQL_SEP_PERIOD : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMSEP = '*comma';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_TIME_SEP: SQL_SEP_COMMA : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMSEP = '*blank';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                       : SQL_ATTR_TIME_SEP: SQL_SEP_BLANK : %Size(SQLINTEGER)));
E05                   Endif;
B05                   If execopt.TIMSEP = '*job';
                         LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_ATTR_TIME_SEP: SQL_SEP_JOB : %Size(SQLINTEGER)));
E05                   Endif;
                      //?SQL_SAVEPOINT_NAME
                      //?later, perhaps
                      //?SQL_2ND_LEVEL_TEXT
                      LogRC(SQLSetConnectAttrI( execopt.conn
                         : SQL_2ND_LEVEL_TEXT : SQL_TRUE : %Size(SQLINTEGER)));
                 JobLog('':%Char(Srcseq) + ' <Connect '+ %Trim(execopt.Database)
                         +' userid='+ %Trim(execopt.userid)
                         +' commit='+ %Trim(execopt.Commit)
                         +', datfmt='+ %Trim(execopt.DATFMT)
                         +', datsep='+ %Trim(execopt.DATSEP)
                         +', dftlib='+ %Trim(execopt.dftlib)
                         +', decsep='+ %Trim(execopt.decsep)
                         +', naming='+ %Trim(execopt.NAMING)
                         +', timfmt='+ %Trim(execopt.TIMFMT)
                         +', timsep='+ %Trim(execopt.TIMSEP)
                         +'>'
                         :'':'':'*INFO':'*':0) ;
E04                Enddo;
B04                If execopt.Database='*local';
                      LogRC( SQLConnect( execopt.conn
                         : '*LOCAL' + X'00'
                         : SQL_NTS
                         : *null
                         : SQL_NTS
                         : *null
                         : SQL_NTS) );
X04                Else;
                      LogRC( SQLConnect( execopt.conn
                         : execopt.Database + X'00'
                         : SQL_NTS
                         : execopt.userid + X'00'
                         : SQL_NTS
                         : execopt.password + X'00'
                         : SQL_NTS) );
E04                Endif;
X03             When sqlstring= ' ';
                   //?rien à faire
X03             Other;
                   //?joblog('':%char(srcseq) + ' <SQLAllocStmt> '
                   //?   :'':'':'*INFO':'*':0)  ;
                   LogRC (SQLAllocStmt( execopt.conn : execopt.stmt ));
                   //?detection of select to nothing
B04                If %Len(sqlstring) >= 6;
B05                   If lcase(%Subst(%Trim(sqlstring):1:6))='select';
B06                      If MonMsg = '*escape' ;
                            //?dumpcallstack();
                            Needdump=False;
                            Message('':%Char(Srcseq) + ' select to nothing'
                               :'':'':'*ESCAPE':'*':0) ;
X06                      Else;
                            JobLog('':%Char(Srcseq) + ' select to nothing'
                               :'':'':'*DIAG':'*':0) ;
E06                      Endif;
E05                   Endif;
E04                Endif;
                   //?joblog('':%char(srcseq) + ' <SQLExecDirect>'
                   //?   :'':'':'*INFO':'*':0)  ;
                   LogRC ( SQLExecDirect( execopt.stmt
                      : sqlstring
                      : SQL_NTS ));
                   //?ajouter une gestion de sql state
                   //?joblog('':%char(srcseq) + ' <SQLFreeStmt>'
                   //?   :'':'':'*INFO':'*':0)  ;
                   LogRC( SQLFreeStmt( execopt.stmt : SQL_DROP ));
E03          Endsl;
X02       Elseif RunMode='EXECUTESQL';
             JobLog('':%Char(Srcseq) + ' <ExecuteSql>'
                :'':'':'*INFO':'*':0) ;
             //?executesql is hard coded to use SQL naming (option at beginning of this program)
B03          If execopt.NAMING <> '*sql';
                JobLog('':%Char(Srcseq) + ' <ExecuteSql is not compatible with '
                 + execopt.NAMING+ ' naming. Naming convention changed to *SQL>'
                   :'':'':'*INFO':'*':0) ;
                execopt.NAMING = '*sql';
E03          Endif;

B03          If %Len(sqlstring) > %Len(mySQL) ;
                Die ('sql string too long for this version on SQLRPGLE '
                   + '(' + %Editc(%Len(sqlstring):'Z') + ' > ' +
                   %Editc(%Len(mySQL):'Z') + ')');
E03          Endif;
             mySQL = sqlstring;
             Exec Sql
                Prepare Somesql From : mySQL
                ;
B03          If Sqlcod<>0;
B04             If Sqlcod = -104;   //?syntax error at &SQLER5
                   sql8880.er5 = Sqler5 ;
B05                If Sqler5 > 500;
                      sql8880.sqlleft = %Subst(mySQL:Sqler5-500:500);
X05                Else;
                      sql8880.sqlleft = %Subst(mySQL:1:Sqler5  );
E05                Endif;
B05                If %Len(mySQL) - Sqler5 > 500 ;
                      sql8880.sqlright = %Subst(mySQL:Sqler5+1:500) ;
X05                Else;
                      sql8880.sqlright = %Subst(mySQL:Sqler5+1) ;
E05                Endif;
                   JobLog('SQL8880' :sql8880:'':'JPLTOOLS');
X04             Else;
                   JobLog('SQL8888' :Sqlca:'':'JPLTOOLS');
E04             Endif;

B04             Select ;
X04                When MonMsg = '*escape' ;
                      //?dumpcallstack();
                      Needdump=False;
                      Escsqler (Sqlcod:Sqlerm);
X04                When MonMsg = '*ignore' ;
B05                   If execopt.JobLog = '*yes';
                         Diagsqler (Sqlcod:Sqlerm);
E05                   Endif;
                      //?monmsg = soit stxx soit stxxxxx
X04                When %Subst(MonMsg:5:3) = '   ';
B05                   If %Subst(MonMsg:3:2) = %Subst(Sqlstate:1:2);
B06                      If execopt.JobLog = '*yes';
                            Diagsqler (Sqlcod:Sqlerm);
E06                      Endif;
X05                   Else;
                         //?dumpcallstack();
                         Needdump=False;
                         Escsqler (Sqlcod:Sqlerm);
E05                   Endif;
X04                Other ;
B05                   If %Subst(MonMsg:3:5) = Sqlstate ;
B06                      If execopt.JobLog = '*yes';
                            Diagsqler (Sqlcod:Sqlerm);
E06                      Endif;
X05                   Else;
                         //?dumpcallstack();
                         Needdump=False;
                         Escsqler (Sqlcod:Sqlerm);
E05                   Endif;
E04             Endsl;
B04             If MonMsg = '*escape' Or
                      (MonMsg = '*warning' And Sqlcod < 0);
                   //?dumpcallstack();
                   Needdump=False;
                   Escsqler (Sqlcod:Sqlerm);
X04             Else;
B05                If execopt.JobLog = '*yes';
                      Diagsqler (Sqlcod:Sqlerm);
E05                Endif;
E04             Endif;
X03          Else;
                Exec Sql
                   Execute Somesql
                   ;
B04             If Sqlcod<>0;
                   JobLog('SQL8888' :Sqlca:'':'JPLTOOLS');
B05                Select ;
X05                   When MonMsg = '*escape' ;
                         //?dumpcallstack();
                         Needdump=False;
                         Escsqler (Sqlcod:Sqlerm);
X05                   When MonMsg = '*ignore' ;
B06                      If execopt.JobLog = '*yes';
                            Diagsqler (Sqlcod:Sqlerm);
E06                      Endif;
X05                   When MonMsg = '*warning' And
                            ('00' <= %Subst(Sqlstate:1:2) And
                            %Subst(Sqlstate:1:2) <= '02') ;
B06                      If execopt.JobLog = '*yes';
                            Diagsqler (Sqlcod:Sqlerm);
E06                      Endif;
                         //?monmsg = soit stxx soit stxxxxx
X05                   When %Subst(MonMsg:5:3) = '   ';
B06                      If %Subst(MonMsg:3:2) = %Subst(Sqlstate:1:2);
B07                         If execopt.JobLog = '*yes';
                               Diagsqler (Sqlcod:Sqlerm);
E07                         Endif;
X06                      Else;
                            //?dumpcallstack();
                            Needdump=False;
                            Escsqler (Sqlcod:Sqlerm);
E06                      Endif;
X05                   Other ;
B06                      If %Subst(MonMsg:3:5) = Sqlstate ;
B07                         If execopt.JobLog = '*yes';
                               Diagsqler (Sqlcod:Sqlerm);
E07                         Endif;
X06                      Else;
                            //?dumpcallstack();
                            Needdump=False;
                            Escsqler (Sqlcod:Sqlerm);
E06                      Endif;
E05                Endsl;
X04             Else;
B05                If execopt.JobLog = '*yes';
                      DiagSqlCa();
E05                Endif;
E04             Endif;
E03          Endif;
             *inlr = *on;
X02       Elseif RunMode='RUNSQLSTM';
             //? RUNSQLSTM
             //?= ovrprtf
             //?pas au point, tous les spoules prennent le usrdta du dernier ovrprtf.
             //?pas compris pourquoi. actgrp ?
B03          If Troncature;
                Message('':'<some statement lines have been trunc at 80>'
                   :'':'':'*INFO':'*':0) ;

E03          Endif;
             I = %Scan('runsql':lcase(wm));
             JobLog('':%Char(Srcseq) + ' <RunSql ' + %Trim(%Subst(wm:I+6))+'>'
                :'':'':'*INFO':'*':0) ;
             I +=6;
             wt = %Subst(wm:I);
             I=%Check(' ':wt);
B03          If I > 0 ;
                usrdta = %Subst(wt:I);
X03          Else;
                usrdta = %Editc(Srcseq:'Z');
E03          Endif;
             %Subst(wm:25:10) = usrdta;
             exc1k = 'ovrprtf qsysprt' +
                ' usrdta(''' + usrdta + ''')' +
                ' OVRSCOPE(*job      )' +
                ' FORMTYPE(' + p_splf + ') ' +
                ' HOLD(' + p_hold + ') ' +
                ' SPLFNAME(' + p_splf + ')';
             //?joblog : par qmhsndpm
             //?********* '''':'"'  xlatewm        srcdta
             //?
             JobLog('':%Trim(exc1k):'':'':'*INFO':'*':0) ;
             Callp QCmdExec(exc1k : 1000);
             //?= initialisation
             exc1k = 'runsqlstm srcfile(qtemp/qtmpsrc) srcmbr(qtmpsrc) '
                + sqlopt + ' errlvl(29)';
             JobLog('':%Trim(exc1k ):'':'':'*INFO':'*':0) ;
             //?= runsqlstm
             //?joblog : par qmhsndpm
             //?********* '''':'"'  xlatewm        srcdta
             //?
             Callp(E) QCmdExec(exc1k :1000);
B03          If %Error;
B04             If MonMsg = '*escape' ;
                   //?dumpcallstack();
                   Needdump=False;
                   Message('CPF9898':Spmsda:'*LIBL':'QCPFMSG'
                      :'*ESCAPE':'*PGMBDY':1) ;
X04             Else;
                   JobLog('':Spmsda:'':'':'*DIAG':'*':3) ;
E04             Endif;
E03          Endif;
             //?= dltovr
             Callp QCmdExec( 'DLTOVR FILE(QSYSPRT) LVL(*job      )':60);
E02       Endif;   //?RUNSQLSTM
          //?si c'est une création d'objet, alors corriger les attributs
          //?
B02       If p_ChgObjAtr = '*YES';
             sqlstring = %Trim(lcase(sqlstring));   //?create    table   t
B03          If %Len(sqlstring) >= 6;
B04             If %Subst(sqlstring : 1 : 6) = 'create';
                   sqlstring = %Trim(%Subst(sqlstring:7));   //?table   t
                   I = %Scan(' ' : sqlstring);
B05                If I > 1;
                      sqlobj = lcase(%Subst(sqlstring : 1 : I - 1));
                      //?                           1. CREATE ALIAS
                      //?                           2. CREATE COLLECTION
                      //?                           3. CREATE INDEX
                      //?                           4. CREATE PROCEDURE
                      //?                           5. CREATE TABLE
                      //?                           6. CREATE VIEW
B06                   If sqlobj = 'index'
X06                   Or sqlobj = 'table'
X06                   Or sqlobj = 'view';
                         //?                  eval      exc1k = 'DLYJOB DLY(1)'
                         //?/free
                         //?          callp     pmqmsg8( 'CPF9898' : '*LIBL' : 'QCPFMSG'
                         //?                    : exc1k
                         //?                    : '*DIAG' : '*EXT' :  0  : ' ');
                         //?/end-free
                         //?
                         //?                 call      'QCMDEXC'                            90
                         //?                 parm                    exc1k
                         //?                 parm      1000          pmlng
                         sqlstring = %Trim(%Subst(sqlstring:I));   //?t
                         //?this tool does not handle extended name syntax
                         //?names with space, ", ', (, ), ., /, \, lowercase are not my cup of tea
                         //?even if they are correct.
                         I = %Scan(' ' : sqlstring);
                         J = %Scan('(' : sqlstring);
B07                      If I > J And J > 0;
                            I = J;
E07                      Endif;
B07                      If I > 1;
                            libfic ='';
                            lib ='';
                            fic ='';
                            //?collection & table
                            libfic = %Subst(sqlstring : 1 : I - 1);
                            //?avec un / ?
B08                         If execopt.NAMING ='*sql';
                               I = %Scan('.' : libfic);
X08                         Else;
                               I = %Scan('/' : libfic);
E08                         Endif;
B08                         If I = 0;
                               lib = '*CURLIB';
                               //?exec sql set : lib = current schema;
                               fic = libfic;
X08                         Else;
                               lib = %Subst(libfic : 1 : I - 1);
                               fic = %Subst(libfic : I + 1 );
E08                         Endif;
                            //?corriger les attributs
                            //?SELECT SYSTEM_TABLE_NAME, SYSTEM_TABLE_SCHEMA FROM qsys2/systables
                            //?WHERE TABLE_SCHEMA ='AMELIBFB' and TABLE_NAME ='PARMAPAYEUR'
                            //?SELECT DBXFIL FROM QADBXREF WHERE DBXLIB ='JPL' and DBXLFI
                            //?='TESTTESTTEST'
                            lib = ucase(lib);
                   //?IBM point service 200506-27 QTEMP files are not declared in SYSCOLS but in thn
                            //?job object. IBM call number 74597
                    //?yes, but if table is created with execute immediate, the answer is SQL7950, 5
                            //?the message data contains the sql names and the system names :
                            //?message SQL7950
                   //?Table &1 was created in &2 for authorization identifier &3. The SQL name for t
                            //?and the system name for the table is &4.
                            //?         Type de                              Long
                            //?Zone     données      Long      Décimales     var
                            //?&1       *CHAR        *VARY                     2
                            //?&2       *CHAR        *VARY                     2
                            //?&3       *CHAR           10
                            //?&4       *CHAR           10
                            //?y a pu ka
B08                         If lib <> 'QTEMP     ';
                               //?useless to change file atributes in qtemp
                               //?   fic = ucase(fic);
                               //?   joblog('':
                               //?      'SELECT DBXFIL FROM QSYS.QABXREF WHERE DBXLIB =' +
                               //?      lib + 'and DBXLFI=' + fic
                               //?      :'':'':'*DIAG':'*EXT':0);
                               //?   EXEC SQL
                               //?      DECLARE K2 CURSOR FOR
                               //?      SELECT DBXFIL FROM QSYS.QADBXREF
                               //?      WHERE DBXLIB =: lib and DBXLFI
                               //?      = : fic
                               //?      ;
                               //?   //?OUVERTURE CURSOR
                               //?   EXEC SQL
                               //?      OPEN K2
                               //?      ;
                               //?   dou true;
                               //?      if sqlcod <> 0;
                               //?         //?****************  eval      monmsg = 'pas net'
                               //?         joblog('':
                               //?          'QADBXREF n''est pas a jour ! CHGOBJATR HS si' +
                               //?            ' nom trop long'
                               //?            :' ':' ':'*DIAG':'*EXT':0);
                               //?      endif;
                               //?   enddo;
                               //?manque le fetch, depuis un paquet d'années. Pas cool.
                               //?   EXEC SQL
                               //?      CLOSE K2
                               //?      ;
                               Reset Ech;


                               qdbrtvsn (
                                  Qualname
                                  : fic
                                  : %Checkr(' ':fic)
                                  : lib
                                  : Ech ) ;
B09                            If Ech.Available = 0;
                                  fic=%Subst(Qualname:01:10);
                                  lib=%Subst(Qualname:11:10);
                                  Reset Ech;
                                  exc1k='ChgObjAtr '
                                     + ' Obj(' + %Trim(lib) + '/'
                                     + %Trim(fic) + ')'
                                     + ' Src(' + %Trim(srcmbr) + '/'
                                     +%Trim(srclib)+'/'+%Trim(srcfile)+')'
                                     + ' SrcDate(' + srcdate + ')'
                                     + ' UsrAtr(''' + %Trim(UserAttr)+''')'
                                     + ' Text(''' + %Trim(Text)+''')';
                                  JobLog('':%Trim(exc1k):'':'':'*INFO':'*':0) ;
B10                               If ChgObjAtr ( %Subst(fic:1:10) + lib
                                        : '*FILE'
                                        : Ech
                                        : srcfile+srclib+Srcmbr   //?key01
                                        : Srcdate   //?key02
                                        : 'EXECSQL'   //?key03
                                        : '='   //?key04
                                        : '='   //?key05
                                        : '='   //?key06
                                        : '='   //?key07
                                        : '='   //?key08
                                        : Userattr   //?key09
                                        : Text   //?key10
                                        : '='   //?key11
                                        : '='   //?key12
                                        : '='   //?key13
                                        : '='   //?key14
                                        : '='   //?key15
                                        : '='   //?key16
                                        : '='   //?key17
                                        ) = False;
B11                                  If MonMsg = '*escape' ;
                                        //?dumpcallstack();
                                        Needdump=False;
                                        Message(Ech.Msgid:Ech.Msgdta
                                           :'*LIBL':'QCPFMSG':'*ESCAPE':'*':3) ;
X11                                  Else;
                                        JobLog(Ech.Msgid:Ech.Msgdta
                                           :'*LIBL':'QCPFMSG':'*DIAG':'*':3) ;
E11                                  Endif;
E10                               Endif;   //?chgobjatr
E09                            Endif;   //?qdbrtvsn
                               //?   exc1k= 'CHGOBJATR '
                               //?      + ' OBJ(' + %trim(lib) + '/'
                               //?      + %trim(fic) + ')'
                               //?      + ' OBJTYPE(*FILE)'
                               //?      + ' KEY01(' + %trim(srcmbr) + '/'
                               //?      +%trim(srclib)+'/'+%trim(srcfile)+')'
                               //?      + ' KEY02(' + srcdate + ')'
                               //?      + ' KEY03(EXECSQL)'
                               //?      + ' KEY09(''' + %trim(userattr)+''')'
                               //?      + ' KEY10(''' + %trim(text)+''')';
                               //?   joblog('':%trim(exc1k):'':'':'*INFO':'*':0)  ;
                               //?   callp(e) qcmdexec (exc1k : 1000);
                               //?   if %error;
                               //?      if   monmsg = '*escape' ;
                               //?         DumpCallStack();
                               //?message(spmsid:spmsda:'*LIBL':'QCPFMSG':'*ESCAPE':'*':3)
                               //?      else;
                               //? joblog(spmsid:spmsda:'*LIBL':'QCPFMSG':'*DIAG':'*':3)  ;
                               //?      endif;
                               //?   endif;
E08                         Endif;
                            Text = '*SAME';
E07                      Endif;
E06                   Endif;
E05                Endif;
E04             Endif;
E03          Endif;
E02       Endif;
E01    Endif;   //?HoldExecute
       //?= clrpfm
       //?qcmdexec( 'clrpfm file(qtemp/qtmpsrc) mbr(qtmpsrc)':60);
       Open Qtmpsrc;
B01    Dow True;
          Read Qtmpsrc;
B02       If %Eof();
             Leave;
E02       Endif;
          Delete Qtmpf;
E01    Enddo;
       Close Qtmpsrc;
       sqlstring = '';
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e

       //?=------------------------------------------------------------------------
       //?=
       //?=  Hold or Release the execution of SQL statement depending on an SQL value
       //?=  this is to provide a control equivalent to an IF, but
       //?=  with the advantages of
       //?=  * no need of endif, just add a reverse condition
       //?=  * no limit to embbedded if
       //?=------------------------------------------------------------------------
BPR ?p HoldExecute     b
     d HoldExecute     pi
     d Value           s              1
      /free

       Value = ' ';
       wm = %Trim(%Subst(%Triml(wm):12)) ;
       JobLog('':%Char(Srcseq) + ' <HoldExecute ' + wm + '>'
          :'':'':'*INFO':'*':0) ;
       mySQL = 'values('+wm+') into ?';
       Exec Sql
          Prepare Somesql From : mySQL
          ;
B01    If Sqlcod<>0;
          JobLog('SQL8888' :Sqlca:'':'JPLTOOLS');
B02       Select ;
X02          When MonMsg = '*escape' ;
                //?dumpcallstack();
                Needdump=False;
                Escsqler (Sqlcod:Sqlerm);
X02          When MonMsg = '*ignore' ;
B03             If execopt.JobLog = '*yes';
                   Diagsqler (Sqlcod:Sqlerm);
E03             Endif;
                //?monmsg = soit stxx soit stxxxxx
X02          When %Subst(MonMsg:5:3) = '   ';
B03             If %Subst(MonMsg:3:2) = %Subst(Sqlstate:1:2);
B04                If execopt.JobLog = '*yes';
                      Diagsqler (Sqlcod:Sqlerm);
E04                Endif;
X03             Else;
                   //?dumpcallstack();
                   Needdump=False;
                   Escsqler (Sqlcod:Sqlerm);
E03             Endif;
X02          Other ;
B03             If %Subst(MonMsg:3:5) = Sqlstate ;
B04                If execopt.JobLog = '*yes';
                      Diagsqler (Sqlcod:Sqlerm);
E04                Endif;
X03             Else;
                   //?dumpcallstack();
                   Needdump=False;
                   Escsqler (Sqlcod:Sqlerm);
E03             Endif;
E02       Endsl;
B02       If MonMsg = '*escape' Or
                (MonMsg = '*warning' And Sqlcod < 0);
             //?dumpcallstack();
             Needdump=False;
             Escsqler (Sqlcod:Sqlerm);
X02       Else;
B03          If execopt.JobLog = '*yes';
                Diagsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;
X01    Else;
          Exec Sql
             Execute Somesql Using : Value
             ;
B02       If Sqlcod<>0;
             JobLog('SQL8888' :Sqlca:'':'JPLTOOLS');
B03          Select ;
X03             When MonMsg = '*escape' ;
                   //?dumpcallstack();
                   Needdump=False;
                   Escsqler (Sqlcod:Sqlerm);
X03             When MonMsg = '*ignore' ;
B04                If execopt.JobLog = '*yes';
                      Diagsqler (Sqlcod:Sqlerm);
E04                Endif;
                   //?monmsg = soit stxx soit stxxxxx
X03             When %Subst(MonMsg:5:3) = '   ';
B04                If %Subst(MonMsg:3:2) = %Subst(Sqlstate:1:2);
B05                   If execopt.JobLog = '*yes';
                         Diagsqler (Sqlcod:Sqlerm);
E05                   Endif;
X04                Else;
                      //?dumpcallstack();
                      Needdump=False;
                      Escsqler (Sqlcod:Sqlerm);
E04                Endif;
X03             Other ;
B04                If %Subst(MonMsg:3:5) = Sqlstate ;
B05                   If execopt.JobLog = '*yes';
                         Diagsqler (Sqlcod:Sqlerm);
E05                   Endif;
X04                Else;
                      //?dumpcallstack();
                      Needdump=False;
                      Escsqler (Sqlcod:Sqlerm);
E04                Endif;
E03          Endsl;
X02       Else;
B03          If execopt.JobLog = '*yes';
                DiagSqlCa();
E03          Endif;
E02       Endif;
E01    Endif;

B01    If Value = '0';
          HldExecute = False;
          JobLog('':' <Execute is released>'
             :'':'':'*INFO':'*':0) ;
          Return;
E01    Endif;

B01    If Value = '1';
          HldExecute = True ;
          JobLog('':' <Execute is held>'
             :'':'':'*INFO':'*':0) ;
          Return;
E01    Endif;

       JobLog('':' <got undefined value. Execute is inchanged>'
          :'':'':'*INFO':'*':0) ;
       Return;

B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /end-free
EPR  p                 e

       //?*=------------------------------------------------------------------------
       //?=
       //?=
       //?=            C L O S E C L I
       //?=
       //?=
       //?*=------------------------------------------------------------------------
BPR ?p CloseCLI        b
     d CloseCLI        pi
      /free
B01    If execopt.connected=*on;
          execopt.connected = *off;
          JobLog('':%Char(Srcseq) + ' <SQLDisconnect> '
             :'':'':'*INFO':'*':0) ;
          LogRC(SQLDisconnect( execopt.conn ));
          //?joblog('':%char(srcseq) + ' <SQLFreeConnect> '
          //?   :'':'':'*INFO':'*':0)  ;
          LogRC(SQLFreeConnect( execopt.conn));
          //?joblog('':%char(srcseq) + ' <SQLFreeEnv> '
          //?   :'':'':'*INFO':'*':0)  ;
          LogRC(SQLFreeEnv( execopt.env));
E01    Endif;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /END-FREE
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            L O G R C
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p LogRC           b
     d LogRC           pi
     d rc                            10i 0 const
     d monitor                       10    options(*nopass)
     d MonRC           s             10
     D   sqlcod        ds
     D   sqlcod3                      3
     D   sqlcod4                      4s 0
     D TheKey          S              4A
     D MsgID           S              8A
      /free
B01    If %Parms > 1;
          MonRC = Monitor;
X01    Else;
          MonRC = MonMsg;
E01    Endif;
B01    If rc <> 0;
          Clear szSqlState ;
          Clear pfNativeErr ;
          Clear szErrorMsg ;
          Clear szErrorMsg ;
          Clear pcbErrorMsg ;
          SQLError(
             execopt.env
             : execopt.conn
             : execopt.stmt
             : %Addr(szSqlState)
             : %Addr(pfNativeErr)
             : %Addr(szErrorMsg)
             : %Size(szErrorMsg)
             : %Addr(pcbErrorMsg)
             ) ;
B02       If pfNativeErr<0;
             Eval sqlcod4= - pfNativeErr ;
X02       Else ;
             Eval sqlcod4= pfNativeErr ;
E02       Endif ;
          sqlcod3 = 'SQL';
          MsgID=sqlcod;
B02       If MonRC = '*escape' ;
             //?dumpcallstack();
             Needdump=False;
             Message('CPF9898':MsgID + %Subst(szErrorMsg:1:pcbErrorMsg)
                :'':'QCPFMSG': '*ESCAPE');
X02       Else;
             JobLog('CPF9898':MsgID +%Subst(szErrorMsg:1:pcbErrorMsg)
                :'':'QCPFMSG': '*DIAG');
E02       Endif;
E01    Endif;
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
      /END-FREE
EPR  p                 e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            L C A S E
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p lcase           b
     d lcase           pi         32787    varying
     d  FromString                32787    varying const
       //?table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
       //?table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
      /FREE
       Return %Xlate(UP:lo:FromString);
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
      /END-FREE
EPR  p lcase           e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=            U C A S E
       //?=
       //?=
       //?=------------------------------------------------------------------------
BPR ?p ucase           b
     d ucase           pi         32787    varying
     d  FromString                32787    varying const
       //?table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
       //?table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
      /FREE
       Return %Xlate(lo:UP:FromString);
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
      /END-FREE
EPR  p ucase           e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=
       //?=
       //?=------------------------------------------------------------------=*
       //?=-----------------------------------------------------------------------
       //?
       //?=-----------------------------------------------------------------------
BPR ?P DiagSqlCA       B
     D DiagSqlCA       PI
      /free
       JobLog('SQL'+%Subst(Sqlerr:21:4)
          :Sqlerm:'*LIBL':'QSQLMSG':'*DIAG':'*':4) ;
      /end-free
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=
       //?=
       //?=------------------------------------------------------------------=*
       //?=-----------------------------------------------------------------------
BPR ?p JobLog          b
     d JobLog          pi
     d    msgno                       7    const         options(*omit)         n°
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
      /FREE
B01    If execopt.JobLog = '*yes';
B02       Select;
X02          When %Parms = 8 ;
           Message(msgno:msgdata:msgflib:msgffile:msgtype:msgcse:msgcsc:msgkey);
X02          When %Parms = 7 ;
                Message(msgno:msgdata:msgflib:msgffile:msgtype:msgcse:msgcsc);
X02          When %Parms = 6 ;
                Message(msgno:msgdata:msgflib:msgffile:msgtype:msgcse);
X02          When %Parms = 5 ;
                Message(msgno:msgdata:msgflib:msgffile:msgtype);
X02          When %Parms = 4 ;
                Message(msgno:msgdata:msgflib:msgffile);
X02          When %Parms = 3 ;
                Message(msgno:msgdata:msgflib);
X02          When %Parms = 2 ;
                Message(msgno:msgdata);
X02          When %Parms = 1 ;
                Message(msgno);
E02       Endsl;
E01    Endif;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();

             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
      /END-FREE
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?p LoadParm        b
     d                 pi
    * /FREE
B01    If p_JobLog <> '*NO' ;
          wm = 'execopt joblog='+p_JobLog ;
          execop();
E01    Endif;
B01    If p_COMMIT <> '*NONE' ;
          wm = 'execopt commit='+p_COMMIT ;
          execop();
E01    Endif;
B01    If p_NAMING <> '*SYS' ;
          wm = 'execopt naming='+p_NAMING ;
          execop();
E01    Endif;
B01    If p_DATFMT <> '*ISO' ;
          wm = 'execopt datfmt='+p_DATFMT ;
          execop();
E01    Endif;
B01    If p_DATSEP <> '*JOB' ;
          wm = 'execopt datsep='+p_DATSEP ;
          execop();
E01    Endif;
B01    If p_TIMFMT <> '*ISO' ;
          wm = 'execopt timfmt='+p_TIMFMT ;
          execop();
E01    Endif;
B01    If p_TIMSEP <> '*JOB' ;
          wm = 'execopt timsep='+p_TIMSEP ;
          execop();
E01    Endif;
B01    If p_DFTRDBCOL<> '*NONE' ;
          wm = 'execopt dftlib='+p_DFTRDBCOL ;
          execop();
E01    Endif;
B01    If p_DECMPT <> '*JOB ' ;
          wm = 'execopt decsep='+p_DECMPT ;
          execop();
E01    Endif;
B01    If p_Database <> '*LOCAL ' ;
          wm = 'execopt database='+p_Database ;
          execop();
E01    Endif;
B01    If p_userid <> '*NONE' ;
          wm = 'execopt userid='+p_userid ;
          execop();
E01    Endif;
B01    If p_password <> '*NONE';
          wm = 'execopt password='+p_password ;
          execop();
E01    Endif;
       wm = 'execopt SQLOPT=*GEN' ;
       execop();
       vars = p_vars;
       srcatr = p_satr;
       //?=---------------------------------------------------------------
       //?indicateur d'etat du fichier en sortie*
       QTmpIsOpen = *off;
       Troncature=False;
       //?=---------------------------------------------------------------
       //?variables EXECSQL
       Clear var ;
       Clear val ;
       MonMsg = '*escape';
       runsql = *off ;
       //?nombre
B01    If nbvars > *zero;
B02       For I = 1 To nbvars;
             POffset = %Addr(vars) + (I * 2);
             PUneVar = %Addr(vars) + o ;
             var(I) = '&' + lenom ;
             val(I) = lavalr ;
             varl(I) = %Checkr(' ' :var(I));
             vall(I) = %Checkr(' ' :val(I));
             SqlStm = '<SetVar ' +
                %Subst(var(I) : 1 : varl(I)) + '='
                + %Subst(val(I) : 1 : vall(I)) + '>';
             JobLog('':%Trim(SqlStm):'':'':'*INFO':'*':0);
E02       Endfor;
E01    Endif;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?p LoadInit        b
     d                 pi
    * /FREE
       //?version *QSYS
       //?add an element to array
       ScriptLen+= ScriptLineLen;
B01    If ScriptAllocLen < ScriptLen ;
          ScriptAllocLen = ScriptLen+1000 ;
          pScript =%Realloc(pScript :ScriptAllocLen );
E01    Endif;
       //?prepare last element to receive next statement
       pScriptLine = pScript + ScriptLen - ScriptLineLen ;
       Clear ScriptLine ;
       ScriptLine. Srcdta = p_init;
       ScriptNbr+=1;
       //?TODO version *IFS
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  P                 E
BPR ?p LoadLast        b
     d                 pi
    * /FREE
       //?version *QSYS
       //?add an element to array
       ScriptLen+= ScriptLineLen;
B01    If ScriptAllocLen < ScriptLen ;
          ScriptAllocLen = ScriptLen+1000 ;
          pScript =%Realloc(pScript :ScriptAllocLen );
E01    Endif;
       //?prepare last element to receive next statement
       pScriptLine = pScript + ScriptLen - ScriptLineLen ;
       ScriptLine.Srcseq = *hival;
       ScriptLine.Srcdat = *hival;
       ScriptLine.Srcdta = p_last;
       ScriptNbr+=1;
       //?TODO version *IFS
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?p LoadQSYS        b
     d                 pi
    * /FREE
       mySFW='SELECT srcseq, srcdat, srcdta FROM qtxtsrc';
       Exec Sql
          Prepare P1 From : mySFW
          ;
B01    If sqlcod <> *zero;
          Message('DIV0001');
          Diagsqler (sqlcod:Sqlerm);
E01    Endif;
       Exec Sql
          Declare K1 Cursor For P1
          ;
       //?tout lire, pour traiter aussi les setvar, ...
       //?   where srcseq between :wwfrom and :wwto
       //?OUVERTURE CURSOR
       Exec Sql
          Open K1 ;
B01    Dow True;
          //?add an element to array
          ScriptLen+= ScriptLineLen;
B02       If ScriptAllocLen < ScriptLen ;
             ScriptAllocLen = ScriptLen+1000 ;
             pScript =%Realloc(pScript :ScriptAllocLen );
E02       Endif;
          //?prepare last element to receive next statement
          pScriptLine = pScript + ScriptLen - ScriptLineLen ;
          Exec Sql
             Fetch K1
             Into : ScriptLine
             ;
B02       If sqlcod <> 0;
             ScriptLen-= ScriptLineLen;
             Leave;
E02       Endif;
          ScriptNbr+=1;
E01    Enddo;
       ScriptNbr-=1;
       Exec Sql
          Close K1
          ;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?pLoadIFS          b
     d                 pi
    * /FREE
       //?p_stack = *ifs
       FileHandle = Open( %Trim(p_STREAM)
          : O_textdata + O_rdonly ) ;
B01    If FileHandle = -1;
          cpenum= Errno();
          JobLog(errcpe:'':'':'QCPFMSG');
E01    Endif;
       rc = Stat (%Trim(p_STREAM)+X'00': myStat );
       IfsSize = myStat.St_size;
       ifspos = 0;
       pScript=%Alloc(ScriptAllocLen);
       ScriptLen = 0 ;
       ScriptNbr = 0 ;
       pScriptText = pScript +ScriptLen;   //?position to write to Script field
       %Len(scripttext)=0;
       pScriptifs=%Addr(scriptifs);
B01    Dow True;
          //?read ifs stream file by shunks of n chars
          //?len(scriptifs)= len(shunk)+len(ifs) = 64000 + 1000
          //?to support %scan at the end of scripifs
          scriptifs='';
          bytesin =Pread (FileHandle : pScriptifs :64000 :ifspos) ;
B02       If bytesin < 64000 ;
             ateof = True;
E02       Endif;
          ifspos +=64000;
          i2=0;
          pIfs = pScriptifs;   //?start position to scan 64k of stream file
B02       Dow True;
B03          If bytesin <= 0;
                Leave;
E03          Endif;
             //?scan the stream & split in text lines
             i2 = %Scan(X'0d':Ifs);
B03          If i2 > bytesin;   //?theorically, not possible
                i2=0;
E03          Endif;
B03          If i2 = 0;
                //?to be continued on next shunk
                scripttext+=%Subst(Ifs:1:bytesin);
                Leave;   //?go to read next block of stream file
E03          Endif;
B03          If i2 > 1;
                scripttext+= %Subst(Ifs : 1: i2 - 1);
                bytesin -= (i2 - 1);
                pIfs += (i2 - 1);
E03          Endif;
             //?got an end of line. *CR or *CRLF ?
             pIfs+=1;
             bytesin-=1;
B03          If %Subst(Ifs:1:1)=X'25';
                pIfs+=1;
                bytesin-=1;
E03          Endif;   //?ready for next scan of x'0d'
             //?complete the line to sql statement
             //?got an empty line, ignore
B03          If %Len(scripttext) = 0;
                Iter;
E03          Endif;

             addsemicolon=False;
B03          If scripttext=X'05';   //?only one tab; = empty
                Iter;
E03          Endif;
             scripttext=%Xlate(X'05':' ':scripttext);
             scripttext=%Trimr(scripttext);
B03          If %Len(scripttext) = 0;
                Iter;
E03          Endif;
B03          If %Subst(scripttext:%Len(scripttext)) = ';' ;
                addsemicolon=True;   //?this script line is ended with a ;
                %Len(scripttext)=%Len(scripttext)-1;   //?remove the ;
                //?; are isolated on a next line
                //?why have I do that ? because execopt semicolon=...
E03          Endif;
B03          If %Len(scripttext) > 0 Or addsemicolon;
B04             If %Len(scripttext) > 0;


B05                If ScriptAllocLen < ScriptLen+%Len(scripttext)+5;
                      ScriptAllocLen = ScriptLen+1000 ;
                      pScript =%Realloc(pScript :ScriptAllocLen );
E05                Endif;
                   ScriptLen+= %Len(scripttext)+2;
                   pScriptText = pScript +ScriptLen;
                   %Len(scripttext)=0;
                   ScriptNbr+=1;
E04             Endif;
B04             If addsemicolon;
                   scripttext = ';';
                   ScriptLen+= 3 ;
                   pScriptText = pScript +ScriptLen;
                   scripttext='';
                   ScriptNbr+=1;
E04             Endif;
E03          Endif;
E02       Enddo;
B02       If ateof;
             rc = Close(FileHandle) ;
             Leave;
E02       Endif;
E01    Enddo;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  P                 E
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?pLoadIFS2         b
     dLoadIFS2         pi
    * /FREE
       //?p_stack = *ifs
       FileHandle = Open( %Trim(p_STREAM)
          : O_textdata + O_rdonly ) ;
B01    If FileHandle = -1;
          cpenum= Errno();
          JobLog(errcpe:'':'':'QCPFMSG');
E01    Endif;
       rc = Stat (%Trim(p_STREAM)+X'00': myStat );
       IfsSize = myStat.St_size;
       ifspos = 0;
       pScript=%Alloc(ScriptAllocLen);
       ScriptLen = 0 ;
       ScriptNbr = 0 ;
       pScriptText = pScript +ScriptLen;
       %Len(scripttext)=0;
B01    Dow True;
          //?read ifs stream file by shunks of n chars
          ifsdata='';
          bytesin =Pread (FileHandle : %Addr(ifsdata ) : 100 :ifspos) ;
B02       If bytesin < 100 ;
             ateof = True;
E02       Endif;
          ifspos +=100;
          i1=1;
          i2=0;
B02       Dow True;
B03          If i1 > 100;
                Leave;
E03          Endif;
             //?scan the stream & split in text lines
             i2 = %Scan(X'0d':ifsdata:i1 );
B03          If i2 = 0;
                //?to be continued
                scripttext+=%Subst(ifsdata:i1);
                Leave;
X03          Else;
                //?got an end of line
B04             If i2 > i1;   //?CRLF not at position 1
                   scripttext+= %Subst(ifsdata:i1: i2 - i1);
E04             Endif;
                //?scripttext =%xlate(x'050D25':'   ':scripttext);
                //?scripttext =%trimr(scripttext);
                addsemicolon=False;
B04             If scripttext=X'05';
                   scripttext='';
X04             Elseif scripttext=X'0D';
                   scripttext='';
X04             Elseif scripttext=X'25';
                   scripttext='';
E04             Endif;
B04             If %Len(scripttext) > 0;
B05                If %Subst(scripttext:1:1) =X'05';
                      %Subst(scripttext:1:1)=' ';
X05                Elseif %Subst(scripttext:1:1) =X'0D';
                      scripttext=%Subst(scripttext:2);
X05                Elseif %Subst(scripttext:1:1) =X'25';
                      scripttext=%Subst(scripttext:2);
E05                Endif;
E04             Endif;
B04             If %Len(scripttext) > 0;
                   scripttext =%Xlate(X'050D25':'   ':scripttext);
                   scripttext =%Trimr(scripttext);
E04             Endif;
B04             If %Len(scripttext) > 0;
B05                If %Subst(scripttext:%Len(scripttext)) = ';' ;
                      addsemicolon=True;   //?this script line is ended with a ;
                      %Len(scripttext)=%Len(scripttext)-1;   //?remove the ;
                      //?; are isolated on a next line
                      //?why have I do that ? because execopt semicolon=...
E05                Endif;
E04             Endif;
B04             If %Len(scripttext) > 0;
B05                If %Subst(scripttext:%Len(scripttext)) = ';' ;
                      addsemicolon=True;   //?this script line is ended with a ;
                      %Len(scripttext)=%Len(scripttext)-1;   //?remove the ;
                      //?; are isolated on a next line
                      //?why have I do that ? because execopt semicolon=...
E05                Endif;
E04             Endif;
B04             If ScriptAllocLen < ScriptLen+%Len(scripttext)+2;
                   pScript =%Realloc(pScript :ScriptLen+%Len(scripttext)+2);
E04             Endif;

B04             If %Len(scripttext) > 0;
                   ScriptLen+= %Len(scripttext)+2;
                   pScriptText = pScript +ScriptLen;
                   %Len(scripttext)=0;
                   ScriptNbr+=1;
E04             Endif;
B04             If addsemicolon;
B05                If ScriptAllocLen < ScriptLen+3;
                      pScript =%Realloc(pScript :ScriptLen+3);
E05                Endif;



                   scripttext = ';';
                   ScriptLen+= 3 ;
                   pScriptText = pScript +ScriptLen;
                   %Len(scripttext)=0;
                   ScriptNbr+=1;
E04             Endif;
                i1 = i2 + 1;
E03          Endif;
E02       Enddo;
B02       If ateof;
             rc = Close(FileHandle) ;
             Leave;
E02       Endif;
E01    Enddo;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
      /END-FREE
EPR  pLoadIFS2         e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
BPR ?p GetStmt         b
     d GetStmt         pi
      /FREE
B01    Dou True;   //?do one time
B02       If p_STACK = '*QSYS' ;
             pScriptLine = pScript + (Ifor * ScriptLineLen);
             Srcseq= ScriptLine.Srcseq ;
             Srcdat= ScriptLine.Srcdat ;
             SqlStm = ScriptLine.Srcdta ;
             //?message('':%char(srcseq)+' ' +%trim(SqlStm));
             //?point de depart
B03          If Srcseq >= wwsrcl;
                runsql = *on;
E03          Endif;
             //?point d'arret
B03          If Srcseq > wwsrcf;
                SqlStm='';
                Ifor=*hival;
                Leave;
E03          Endif;
X02       Else ;
             //?ifs script
             pScriptText = pScript + ifspos;
             ifspos +=%Len(scripttext) + 2;
B03          If p_STARTTAG = '*BEGIN' Or p_STARTTAG = scripttext;
                runsql=*on;
E03          Endif;
B03          If p_STOPTAG <> '*END' And p_STOPTAG = scripttext;
                SqlStm='';
                Ifor=*hival;
                Leave;
E03          Endif;
             Srcseq=Ifor+1;
             SqlStm = scripttext ;   //?subst is not cool
B03          If %Len(SqlStm) < 100;
                %Len(SqlStm) = 100;
E03          Endif;
E02       Endif;
E01    Enddo;
       Return;
       //?=------------------------------------------------------------------------
B01    Begsr *pssr;
B02       If Needdump;
             Dumpcallstack();
             Needdump=False;
E02       Endif;
E01    Endsr;
       //?=------------------------------------------------------------------------
    * /END-FREE
EPR  p GetStmt         e
       //?=------------------------------------------------------------------------
       //?=
       //?=
       //?=
       //?=-----------------------------------------------------------------------
    ? *p                 b
    ? *d                 pi
    ? * /FREE
    ? *  return;
    ? *  // =------------------------------------------------------------------------
    ? *  BEGSR *PSSR;
    ? *     if NeedDump;
    ? *        dumpcallstack();
    ? *        needdump=false;
    ? *     endif;
    ? *  ENDSR;
    ? *  // =------------------------------------------------------------------------
    ? * /END-FREE
    ? *P                 E
