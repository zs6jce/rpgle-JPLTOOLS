      * JP4INC is the handler for the code insertedinto the application by COPY of the
      * source code.
      * very efficient to tune and debug (no side effect on other programs)
      * Stabilized code is now pushed to my general purpose service program : JP4GPS
      *   that's my 2010's january 1st resolution for the JPLTOOLS.


    ? * how to use this include :
    ? * this include is externaly controled by /DEFINE compiler directive
    ? * /define INFDS      call for appending standard information data structure
    ? * /define pmqmsg     to get the deprecated pmqmsg* proc, replaced by the message prod
    ? * /define SQL        appends basic fields for SQLRPGLE programs
    ? * /define SQLDESCRIBE appends more fields when SQL uses DESCRIBE statement
    ? * /define LOWERCASE  appends the lowercase procedure (returns a case-lowered european string)
    ? * /define QUOTE      appends the quote procedure (returns a quoted string)
    ? * /define XLXML      appends dozens of procedures for making excel files
    ? * /define XLXML3     appends dozens of procedures for making excel files coded UTF8
    ? * /define XLXML4     XLXML3 + procedures to rework cell styles
    ? * /define IFS        appends many procedures for handling IFS files (auto-add ERRNO)
    ? * /define ERRNO      appends some procedures for handling C-program ERRNO field
    ? * this include auto-appends standard *PSSR for main procedure when /define PSSR is not present
    ? * If you want for a personal main *PSSR, add /define PSSR
    ? * this include auto-appends standard *INZSR for main procedure when /define INZSR not present
    ? * If you want for a personal main *INZSR, add /define INZSR
    ? * /define XMLDOM     appends procedures for handling XML files in DOM trees
    ? *                    auto-add IFS
    ? * /define CSYSTEM    appends prototype for the C system call (see sample in comments)
    ? * /define RTVJOBA    appends prototype for API QUSRJOBI
    ? * /define PDF        appends prototype for making PDF Files
    ? * /define BMP        appends prototype for making BMP Files
    ? * /define BIG        appends prototype for making sap BDC files Batch Input Generic tool
    ? * /define USERSPACE  appends prototype for managing user spaces
    ? * /define ICONV      appends prototype for managing char convertion
      * /define GPS        appends prototype from the service program JP4GPS
      * /define WRKUSRINFO appends prototype for get & set user default
      * /define ZLIB       appends prototype for ZLIB V1.2.7
      * /define FFD        appends core engine for File and Field description
      /if defined(XLXML4)
      /define XLXML3
      /endif
      /if defined(XLXML3)
      /define XLXML
      /define ICONV
      /endif
      /if defined(XLXML)
      /define IFS
      /define INFDS
      /endif
      /if defined(PDF)
      /define IFS
      /define CMATH
      /define ICONV
      /endif
      /if defined(BMP)
      /define IFS
      /define CMATH
      /endif
      /if defined(XMLDOM)
      /define IFS
      /define RTVJOBA
      /endif
      /if defined(IFS)
      /define ERRNO
      /endif
      /if defined(SqlDescribe)
      /define SQL
      /endif
      /if defined(GPS)
      /define ECH
      /endif
      /if defined(ICONV)
      /define PRODUCTINFO
      /define RTVJOBA
      /define ERRNO
      /endif
      /if defined(RTVJOBA)
      /define ECH
      /endif
      /if defined(DATA_SECTION)                                                 data section
     D RtvDbgAttr      PR                  ExtProc('QteRetrieveDebugAttribute')
     D  DbgAttr                      10a   Const
     D  RtnAttr                      10a
     d   Error_Code                 256    options(*varsize)
     d debugmode       ds                  qualified
     D DbgAttr                       10a
     D RtnAttr                       10a
     d debugging       s               n
      /if defined(INFDS)                                                        infds
     D FIDS            DS           528
    ? *
    ? * common data structure
    ? *
    ? * Descriptif du format . . . :  the File Information Data Structure
    ?d*                    File name (same as subfield location *FILE).
     d SFFILE                         8A
    ?d*                    Open indication (1 = open).
     d SFOPEN                         1A
    ?d*                    End of file (1 = end of file)
     d SFEOF                          1A
    ?d*                    Status code (same as subfield location *STATUS).
     d SFSTAT                         9P 0
    ?d*                    Operation code (same as subfield location *OPCODE)
     d SFOPCO                         6A
    ?d*                    Name of the RPG/400 routine in which the exception
     d SFRTN                          8A
    ?d*                    RPG/400 source statement sequence number.
     d SFLINB                         8A
    ?d*                    For a program described file the record identifyin
     d SFRCRD                         8A
    ?d*                    Machine or system message number.
     d SFMSID                         7A
    ?d*                    MI/ODT (machine instruction/object definition temp
     d SFMINB                         4A
    ?d*                    Unused.me (same as subfield location *FILE).
     d SFFIL1                        10A
    ?d*                    Screen size (same as subfield location *SIZE).
     d SFSIZE                         7P 0
    ?d*                    The national language input capability of the devi
     d SFINP                          3P 0
    ?d*                    The national language output capability of the dev
     d SFOUTT                         3P 0
    ?d*                    The preferred national language mode of the device
     d SFMODE                         3P 0
    ?d*                    Name of the RPG/400 routine in which the exception
     d SFFIL9                         4A
    ?d*                    Open data path (ODP) type: DS   Device file DB   D
     d SFODPB                         2A
    ?d*                    Name of the file. For a nonspooled file, this is t
     d SFFLNM                        10A
    ?d*                    Name of the library containing the file.  For a sp
     d SFFLLB                        10A
    ?d*                    Name of the spooled file.  This entry is set onlyp
     d SFSPLF                        10A
    ?d*                    Name of the library where the spooled file is loca
     d SFSPLL                        10A
    ?d*                    Spooled file number (supplied only for spooled out
     d SFSPLN                         4B 0
    ?d*                    Record length (number of bytes transferred at a ti
     d SFRCDL                         4B 0
    ?d*                    Reserved.
     d SFFIL2                         2A
    ?d*                    Member name: -   If ODP type is DB, this entry is
     d SFFLMB                        10A
    ?d*                    Not used.
     d SFFIL3                         4A
    ?d*                    Not used.
     d SFFIL4                         4A
    ?d*                    File type (supplied only if the ODP type is DS or
     d SFFLTP                         4B 0
    ?d*                    Reserved.
     d SFFIL5                         3A
    ?d*                    Number of rows on a display screen or number of li
     d SFROWS                         4B 0
    ?d*                    Number of columns on a display screen ornumber of
     d SFCOLS                         4B 0
    ?d*                    Number of records in the member at open time.  Thi
     d SFRCNB                         9B 0
    ?d*                    Access type (supplied only if ODP type is DB): KU
     d SFACTP                         2A
    ?d*                    Duplicate key indication.  This entry is set only
     d SFDUPK                         1A
    ?d*                    Source file indication. This entry contains Y if t
     d SFSRCF                         1A
    ?d*                    User file control block (UFCB) parameters.  This e
     d SFFCBP                        10A
    ?d*                    User file control block (UFCB) overrides.  This en
     d SFFCBO                        10A
    ?d*                    Offset to volume label fields of open feedback are
     d SFOFST                         4B 0
    ?d*                    Maximum number of records that can be sent or rece
     d SFBLCK                         4B 0
    ?d*                    Overflow line number(supplied only for a printer f
     d SFSPLO                         4B 0
    ?d*                    Blocked record I/O record increment.This is the nu
     d SFBLRC                         4B 0
    ?d*                    Unused.
     d SFFIL6                         5A
    ?d*                    Name of the requester program device.
     d SFRQPD                        10A
    ?d*                    File open count.  If the file is opened nonshareab
     d SFFCBC                         2B 0
    ?d*                    Reserved.
     d SFFIL7                         2A
    ?d*                    Number of based-on physical members opened.  For l
     d SFOPPF                         4B 0
    ?d*                    Miscellaneous flags.  See the Data Management Guid
     d SFMIS1                         1A
    ?d*                    Open Identifier.  Value is unique for a full open
     d SFOPID                         2A
    ?d*                    Maximum Record Length.  This value includes the da
     d SFMXRL                         4B 0
    ?d*                    the Input/Output Feedback Information
     d SFFILA                        23A
    ?d*                    Offset to file-dependent feedback information.  Se
     d SFIOFI                         4B 0
    ?d*                    Write operation count.  This entry is updated only
     d SFWRIC                         9B 0
    ?d*                    Read operation count.  This entry is updated only
     d SFREAC                         9B 0
    ?d*                    Write/Read operation count.  This entry is updated
     d SFWRRC                         9B 0
    ?d*                    Other I/O operation count.  Number of successful o
     d SFOIOC                         9B 0
    ?d*                    Unused.
     d SFFIL8                         1A
    ?d*                    Current operation.  This entry represents the last
     d SFCUOP                         1A
    ?d*                    Name of the record format just processed, which is
     d SFRFMT                        10A
    ?d*                    Device class. In the Data Management Guide, see th
     d SFDVCL                         2A
    ?d*                    Program device name.  This entry is the name of th
     d SFPDNM                        10A
    ?d*                    Length of the record processed by the last I/O ope
     d SFLNRC                         9B 0
    ? *
    ? * device-specific data
    ? *
    ? *ilename++IPEASFRlen+LKlen+AIDevice+.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *                            PRINTER
    ?D*ame+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ?D*PRTFBK DS
     D CUR_LINE              367    368I 0                                      * Current line num
     D CUR_PAGE              369    372I 0                                      * Current page cnt
    ? * If the first bit of PRT_FLAGS is on, the spooled file has been
    ? * deleted. Use TESTB X'80' or TESTB '0' to test this bit.
     D PRT_FLAGS             373    373
     D PRT_MAJOR             401    402                                         * Major ret code
     D PRT_MINOR             403    404                                         * Minor ret code
    ? *ilename++IPEASFRlen+LKlen+AIDevice+.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *                            DISK
    ? *ame+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *DBFBK DS
     D FDBK_SIZE             367    370I 0                                      * Size of DB fdbk
     D JOIN_BITS             371    374I 0                                      * JFILE bits
     D LOCK_RCDS             377    378I 0                                      * Nbr locked rcds
     D POS_BITS              385    385                                         * File pos bits
     D DLT_BITS              384    384                                         * Rcd deleted bits
     D NUM_KEYS              387    388I 0                                      * Num keys (bin)
     D KEY_LEN               393    394I 0                                      * Key length
     D MBR_NUM               395    396I 0                                      * Member number
     D DB_RRN                397    400I 0                                      * Relative-rcd-num
     D KEY                   401    528                                         * Key value (max
     D                                                                          * size 2000)
    ?d*                    relative rank number (FILE)
     d  sfrrn                397    400b 0
    ? *ilename++IPEASFRlen+LKlen+AIDevice+.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *                            WORKSTN INFDS(ICFFBK)
    ? *ame+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ?D*ICFFBK DS
     D ICF_AID               369    369                                         * AID byte
     D ICF_LEN               372    375I 0                                      * Actual data len
     D ICF_MAJOR             401    402                                         * Major ret code
     D ICF_MINOR             403    404                                         * Minor ret code
     D SNA_SENSE             405    412                                         * SNA sense rc
     D SAFE_IND              413    413                                         * Safe indicator
     D RQSWRT                415    415                                         * Request write
     D RMT_FMT               416    425                                         * Remote rcd fmt
     D ICF_MODE              430    437                                         * Mode name
    ? *ilename++IPEASFRlen+LKlen+AIDevice+.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *                            WORKSTN INFDS(DSPFBK)
    ? *ame+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments++++++++++
    ? *DSPFBK DS
     D DSP_FLAG1             367    368                                         * Display flags
     D DSP_AID               369    369                                         * AID byte
     D CURSOR                370    371                                         * Cursor location
     D DATA_LEN              372    375I 0                                      * Actual data len
     D SF_RRN                376    377I 0                                      * Subfile rrn
     D MIN_RRN               378    379I 0                                      * Subfile min rrn
     D NUM_RCDS              380    381I 0                                      * Subfile num rcds
     D ACT_CURS              382    383                                         * Active window
    ?D* cursor location
     D DSP_MAJOR             401    402                                         * Major ret code
     D DSP_MINOR             403    404                                         * Minor ret code

     D PSDS           SDS           429
    ?d* *PROC       001 010 Program name (same as subfield location *PROGRAM)
     d SPNAME                        10A
    ?d* *STATUS     011 015 Status code (same as subfield location *STATUS).
     d SPSTAT                         5A
    ?d*             016     Previous status code.
     d SPPSTA                         5A
    ?d*             021     RPG/400 source statement sequence number.
     d SPLINB                         8A
    ?d* *ROUTINE    029     Name of the RPG/400 routine in which the exceptio
     d SPRTN                          8A
    ?d* *PARMS      037     Number of parameters passed to this program (same
     d SPPARM                         5P 0
    ?d*             040     Exception type (CPF for a OS/400 system exception
     d SPMSID                         7A
    ?d*             047     MI/ODT (machine instruction / object definition t
     d SPMINB                         4A
    ?d*             051     Work area for messages.  This area is only meant
     d SPFIL1                        30A
    ?d*             081     Name of library in which the program is located.
     d SPPGLB                        10A
    ?d*             091     Retrieved exception data. CPF messages are placed
     d SPMSDA                        80A
    ?d*             171     Identification of the exception that caused RPG90
     d SPMSIP                         4A
    ?d*             175     Name of file on which the last file operation error occurred
     d SPlfop                        10A
      *             185     unused
     d SPFIL2                         6A
      *             191     Date (*DATE format) the job entered the system.
     d SPdate                         8A
    ?d*             199     First 2 digits of a 4-digit year. The same as the
     d SPSIEC                         2A
    ?d*             201     Name of file on which the last file operation occ
     d SPFILE                         8A
    ?d*             209 243 Status information on the last file used.
     d SPFSTA                        35A
    ?d*             244     Job name.
     d SPJBNM                        10A
    ?d*             254     User name from the user profile.
     d SPJBUS                        10A
    ?d*             264     Job number.
     d SPJBNB                         6S 0
     d SPJBNBx                        6    overlay(spjbnb)
    ?d*             270     Date (in UDATE format) the program started runnin
     d SPUDAT                         6S 0
    ?d*             276     Date of program running (the system date in UDATE
     d SPSYDT                         6S 0
    ?d*             282     Time of program running in the format hhmmss.
     d SPSYTM                         6S 0
    ?d*             288     Date (in UDATE format) the program was compiled.
     d SPCPLD                         6A
    ?d*             294     Time (in the format hhmmss) the program was compi
     d SPCPLT                         6A
    ?d*             300     Level of the compiler.
     d SPCPLL                         4A
    ?d*             304     Source file name.
     d SPSRCF                        10A
    ?d*             314     Source library name.
     d SPSRCL                        10A
    ?d*             324     Source file member name.
     d SPSRCM                        10A
    ?d*             334     Program containing procedure.
     d SPPGPR                        10A
      *             344     Module containing procedure
     d spmopr                        10
      *             354     Source Id matching psds:21-28
     d spstm1                         5i 0
      *             356     Source Id matching psds:228-235
     d spstm2                         5i 0
      *             358     Current user profile name.
     d spcusr                        10
      *             368     External error code
     d spexcd                        10i 0
      *             372     XML elements set by operation
     d spxmle                        20i 0
      *             380     Unused.
     d spfil3                        50
      *
    ?D* spfsta         Status information on the last file used.
      * these fields overlay spfsta defined upper. details : rpg reference, search for
      * Program Status Data Structure
     d  spfstu               209    213
     d  spfope               214    219
     d  spfrtn               220    227
     d  spfstm               228    230
     d  spfrcd               231    243
     d  spfrnb               236    243

    ? * Programme driver
     D                 DS
     D  W0FLSP                 1      4
     D  W1FLSP                 1      2
     D  W2FLSP                 3      4
     D  W1FLSPn                1      2s 0
     D  W2FLSPn                3      4s 0
      /endif                                                                    infds
    ? * index par defaut pour boucle for infinie (=do *hival) ou une fois (=do 1)
     d  iFor           s             10u 0
     d  Ever           s             10u 0
     D TRUE            s               n   inz(*on)
     D FALSE           s               n   inz(*off)
     D NeedDump        s               n   inz(*on)
     d jp4             ds                  qualified
     d  GotOSVersion                   n   inz(*off)
     d  OSversion                     6                                         prdr.Release_level
     d  GotJobi04                      n   inz(*off)
     d  JobCCSID                      5i 0
    ? * valeurs 'systeme'
    ? * date et heure de lancement du programme
     d  znow           s               z   inz(*sys)
     d  dnow           s               d   inz(*sys)
     d  tnow           s               t   inz(*sys)
    ? * valeurs limites
     d  zmin           s               z   inz(*loval)
     d  dmin           s               d   inz(*loval)
     d  tmin           s               t   inz(*loval)
     d  u5min          s              5u 0 inz(*loval)
     d  b5min          s              5b 0 inz(*loval)
     d  zmax           s               z   inz(*hival)
     d  dmax           s               d   inz(*hival)
     d  tmax           s               t   inz(*hival)
     d  u5max          s              5u 0 inz(*hival)
     d  b5max          s              5b 0 inz(*hival)
    ? * RNF3431 : max value depending field size
    ? * Pour une zone de type entier (type I) :
    ? *   - s'il s'agit d'une zone à 3 chiffres, la valeur initiale
    ? *     doit être comprise entre -128 et 127.
    ? *   - s'il s'agit d'une zone à 5 chiffres, la valeur initiale
    ? *     doit être comprise entre -32768 et 32767 ;
    ? *   - s'il s'agit d'une zone à 10 chiffres, la valeur
    ? *     initiale doit être comprise entre -2147483648 et
    ? *     2147483647.
    ? *   - s'il s'agit d'une zone à 20 chiffres, la valeur
    ? *     initiale doit être comprise entre -9223372036854775808
    ? *     et 9223372036854775807.
    ? *  Pour une zone non signée (type U),
    ? *    - s'il s'agit d'une zone à 3 chiffres, la valeur initiale
    ? *      doit être comprise entre 0 et 255.
    ? *    - s'il s'agit d'une zone à 5 chiffres, la valeur initiale
    ? *      doit être comprise entre 0 et 65535 ;
    ? *    - s'il s'agit d'une zone à 10 chiffres, la valeur
    ? *      initiale doit être comprise entre 0 et 4294967295.
    ? *    - s'il s'agit d'une zone à 20 chiffres, la valeur
    ? *      initiale doit être comprise entre 0 et 1844674407370955
    ? *      1615.
    ? *   Pour une zone à virgule flottante (type F)
    ? *    - s'il s'agit d'une zone à 4 octets, la valeur initiale
    ? *      doit être 0 ; comprise entre +1.1754943E-38 et
    ? *      +3.4028235E+38 ; ou entre -1.1754943E-38 et
    ? *      -3.4028235E+38.
    ? *    - s'il s'agit d'une zone à 8 octets, la valeur initiale
    ? *      doit être 0 ; comprise entre +2.224073858507201E-308 et
    ? *      +1.797693134862315E+308 ; ou entre -2.224073858507201E-
    ? *      308 et -1.797693134862315E+308.
    ? * http://www.itpro.fr/index1.asp?Idarticle=1643&Num=2&rub=1   iSeries e-news N°114
    ? * StdDtaType -- Standard data type definitions used in D-specs
      /If Not Defined( STD_DTA_TYPE )                                           standard types
      /Define STD_DTA_TYPE
    ? * Declare the "dummy" basing pointer.
     D StdDtaTypePtr   S               *
    ? * Declare standard data types.
    ? * -- The Based keyword is used to avoid storage allocation.
    ? * -- Listed alphabetically.
     D Size_T          S             10i 0 Based( StdDtaTypePtr )
     D TypeBin2        S              4B 0 Based( StdDtaTypePtr )
     D TypeBin4        S              9B 0 Based( StdDtaTypePtr )
     D TypeChr         S              1A   Based( StdDtaTypePtr )
     D TypeCmdStr      S           2000A   Based( StdDtaTypePtr )
     D TypeCmdStrLen   S             15P 5 Based( StdDtaTypePtr )
     D TypeCallRtnCde  S              1A   Based( StdDtaTypePtr )
     D TypeIdx         S              7P 0 Based( StdDtaTypePtr )
    ? * Use zoned decimal to match RPG program status data structure
     D TypeJobNbr      S              6S 0 Based( StdDtaTypePtr )
     D TypeLgl         S              1A   Based( StdDtaTypePtr )
     D TypeMsgId       S              7A   Based( StdDtaTypePtr )
     D TypePtr         S               *   Based( StdDtaTypePtr )
     D TypeSysName     S             10A   Based( StdDtaTypePtr )
     D TypeSysQlfName  S             21A   Based( StdDtaTypePtr )
     D TypeTimestamp   S               Z   Based( StdDtaTypePtr )
     D TypeTxt         S             50A   Based( StdDtaTypePtr )
    ? * exemple d'utilisation
    ? * d MyField      s                   like(typebin2)
    ? * Error Code Handler
     d  ErrorCodeHandler...
     D                 DS                  qualified
     D  provided               1      4B 0 INZ(%size(errorcodehandler))         LONGUEUR DE LA ZONE
     D  available              5      8B 0 inz(0)                               lng DE LA REPONSE
     D  msgid                  9     15                                         NUMERO DE L'ERREUR
     D  msgdta                17    255                                         MSGDTA POUR L'ERREUR
      /endif                                                                    standard types
      /If Not Defined(  msgf        )                                           standard types
      /Define msgf
     d MessageFile     c                   'JPLTOOLS  '
      /endif                                                                    standard types
     D FICMAP          DS            25
     D  WLIBEN                 1     10    inz('jpltools')
     D  WENV                  11     12    inz('jp')
    ? * protocoles d'appel des procédures
    ? * effacer la pile de messages du sous-fichier de messages
     d pmqcln          pr
      /if defined(pmqmsg)
    ? * ajouter un message, 1 paramètre : n° de message
     d pmqmsg          pr
     d    msgno                       7    const
    ? *                     2 paramètres : n° de message et texte de message
     d pmqmsg2         pr
     d    msgno                       7    const
     d    msgdata                  6000    const varying
    ? *                     4 paramètres : message, data et fichier
     d pmqmsg4         pr
     d    msgno                       7    const                                n°
     d    msgdata                  6000    const varying                        variables
     d    msgflib                    10    const                                *LIBL
     d    msgffile                   10    const                                MESSAGE
    ? *                     9 paramètres : toutes les informations
     d pmqmsg8         pr
     d    msgno                       7    const                                n°
     d    msgflib                    10    const                                *LIBL
     d    msgffile                   10    const                                MESSAGE
     d    msgdata                  6000    const varying                        variables
     d    msgtype                    10    const                                *DIAG
     d    msgcse                     10    const                                call stack entry
     d    msgcsc                      4B 0 const                                call stack counter
     d    msgkey                      4                                         message key
      /endif
     d message         pr
     d    msgno                       7    const         options(*omit)         n°
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
     d PmqPgm          s             10
      *Resend Escape Message (QMHRSNEM) API
      *  Required Parameter Group:
      *1  Message key  Input  Char(4)
      *2  Error code  I/O  Char(*)
      *  Optional Parameter Group:
      *3  To call stack entry  Input  CHAR(*)
      *4  To call stack entry length  Input  Binary(4)
      *5  Format of to call stack entry parameter  Input  Char(8)
      *6  From call stack entry address  Input  CHAR(16) or Pointer
      *7  From call stack counter  Input  Binary(4)
     D QMHRSNEM        PR                  ExtPgm('QMHRSNEM')
     D   MsgKey                       4A   const
     D   ErrorCode                  256A   options(*varsize)

     d DumpCallStack   pr
      /if defined(getmessage)                                                    lowercase

     d GetMessage      pr           200    varying
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE

      * prototype de Retrieve Message (QMHRTVM) API
      * Required Parameter Group:
      *  1 Message information Output Char(*)
      *  2 Length of message information Input Binary(4)
      *  3 Format name Input Char(8)
      *  4 Message identifier Input Char(7)
      *  5 Qualified message file name Input Char(20)
      *  6 Replacement data Input Char(*)
      *  7 Length of replacement data Input Binary(4)
      *  8 Replace substitution values Input Char(10)
      *  9 Return format control characters Input Char(10)
      *  10 Error code I/O Char(*)
      * Optional Parameter Group:
      *  11 Retrieve Option Input Char(10)
      *  12 CCSID to convert to Input Binary(4)
      *  13 CCSID of replacement data Input Binary(4)
     d qmhrtvm         pr                  extpgm('QMHRTVM')
     d    Receiver                32767a          options( *varsize )
     d    len_recvr                  10i 0 const
     d    format_name                 8    const                                RTVM0100-0400
     d    msgno                       7      const
     d    msgf                       20      const
     d    msgdata                  6000      const
     d    msgdatalen                  9b 0   const
     d    usedata                    10      const                              *YES *NO
     d    controlchar                10      const                              *YES=asis *NO=format
     d    errorhandle               255
     d    option                     10    const options(*nopass)
     d    ToCCSID                    10i 0 const options(*nopass)
     d    dataCCSID                  10i 0 const options(*nopass)
     d RTVM0100        ds                  qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d message_len                   10i 0
     d message_len_available...
     d                               10i 0
     d help_len                      10i 0
     d help_len_available...
     d                               10i 0
     d Message                     5000
     d* message text = message, sur messzge_len caracteres
     d* help text = message, à partir de message_len caracteres

      /endif
      /if defined(LOWERCASE)                                                    lowercase
     d lcase           pr         32787    varying
     d  FromString                32787    varying const
     d ucase           pr         32787    varying
     d  FromString                32787    varying const
      /endif                                                                    lowercase
      /if defined(QUOTE)                                                        quote
     D Quote           PR         32767    varying
     D InString                   32767    varying const
     d TrimIt                          n   options(*nopass) const
      /endif                                                                    quote
     D die             Pr
     D    msg                       256A   const
      /endif
      /if defined(PROCEDURE_SECTION)                                            classic end of main
      /if not defined(PSSR)                                                     pssr
      /free
B00    begsr *pssr ;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr '*CANCL';
      /end-free
      /define PSSR
      /endif                                                                    pssr
      /if not defined(INZSR)                                                    inzsr
B00  C     *INZSR        BEGSR
E00  C                   ENDSR
      /define INZSR
      /endif                                                                    inzsr

BPR  p pmqcln          b
     d pmqcln          pi
    ? * prototype de QMHRMVMPM
    ? *                                    Required Parameter Group:
    ? *                                    1 Call stack entry Input Char(*) or Pointer
    ? *                                    2 Call stack counter Input Binary(4)
    ? *                                    3 Message key Input Char(4)
    ? *                                    4 Messages to remove Input Char(10)
    ? *                                    5 Error code I/O Char(*)
    ? *                                    Optional Parameter Group 1:
    ? *                                    6 Length of call stack entry Input Binary(4)
    ? *                                    7 Call stack entry qualification Input Char(20)
    ? *                                    8 Remove unhandled exceptions Input Char(10)
    ? *                                    Optional Parameter Group 2:
    ? *                                    9 Call stack entry data type Input Char(10)
    ? *                                    Threadsafe: Yes
     d qmhrmvpm        pr                  extpgm('QMHRMVPM')
     D  callstackentr                10      const
     D  callstackcoun                 9B 0   const
     D  messagekey                    4      const
     D  messagetoremo                10      const
     d    errorhandle               255
    ?D* ERROR CODE HANDLING FIELDS
     D ECH             DS
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZONE
     D  ECH02                  5      8B 0 inz(0)                               lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERREUR
     D  ECH5A                 17    117
    ? * effacer la pile de messages du sous-fichier de messages
    ? * initialisation sous-fichier de messages
     c                   eval      pmqpgm = '*'
    ? * Clear messages from program message queue
    ? *stack count : on est 1 niveau en dessous de la procedure qui fait le write du pmqctl
     C                   MOVEL     *BLANK        ECH03
     C
     C                   CALLp      QMHRMVPM    ('*'
     c                                          :1
     c                                          :' '
     c                                          :'*ALL'
     c                                          :ECH)
B01  C                   IF        ECH03  <>      *BLANK
     C                   dump
     C                   callp     die('ERR S/QMHRMVPM, look at ech03')
E01  C                   ENDIF
EPR  p pmqcln          e
      /if defined(pmqmsg)
    ? * ajouter un message, 1 paramètre : n° de message
BPR  p pmqmsg          b
     d pmqmsg          pi
     d    msgno                       7    const
     d  w_msgkey       s              4    inz(*blank)
    ? *stack count : on est 1 niveau en dessous de la procedure qui fait le write du pmqctl
    ? *donc la procedure qui fait le QMHSNDPM est 2 niveaux en dessous du write du pmqctl
     c                   callp     pmqmsg8(msgno : '*LIBL' : MessageFile :
     c                                     *blank  : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)
EPR  p pmqmsg          e
    ? *                     2 paramètres : n° de message et texte de message
BPR  p pmqmsg2         b
     d pmqmsg2         pi
     d    msgno                       7    const
     d    msgdata                  6000    const varying
     d  w_msgkey       s              4    inz(*blank)
     c                   callp     pmqmsg8(msgno : '*LIBL' : MessageFile :
     c                                     msgdata : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)
EPR  p pmqmsg2         e
    ? *                     4 paramètres : n° de message, texte de message et fichier
BPR  p pmqmsg4         b
     d pmqmsg4         pi
     d    msgno                       7    const
     d    msgdata                  6000    const varying
     d    msglib                     10    const
     d    msgfile                    10    const
     d  w_msgkey       s              4    inz(*blank)
     c                   callp     pmqmsg8(msgno : msglib  : msgfile   :
     c                                     msgdata : '*DIAG' : '*' :  2  :
     c                                     w_msgkey)
EPR  p pmqmsg4         e
    ? *                     8 paramètres : toutes les informations
BPR  p pmqmsg8         b
     d pmqmsg8         pi
     d  p_msgno                       7    const                                n°
     d  p_msgflib                    10    const                                *LIBL
     d  p_msgffile                   10    const                                MESSAGE
     d  p_msgdata                  6000    const varying                        variables
     d  p_msgtype                    10    const                                *DIAG
     d  p_msgcse                     10    const                                call stack entry
     d  p_msgcsc                      4B 0 const                                call stack counter
     d  p_msgkey                      4                                         message key
     D                 DS
     d    msgno                       7
     d    msgflib                    10
     d    msgffile                   10
     d    msgdata                  6000
     d    msgtype                    10
     d    msgcse                     10
     d    msgcsc                      4B 0
     d    msgkey                      4
    ? * prototype de QMHSNDMPM
    ? *  Required Parameters Group:
    ? *   1 Message identifier Input Char(7)
    ? *   2 Qualified message file name Input Char(20)
    ? *   3 Message data or immediate text Input Char(*)
    ? *   4 Length of message data or immediate text Input Binary(4
    ? *   5 Message type Input Char(10)
    ? *   6 Call stack entry Input Char(*) or Pointer
    ? *   7 Call stack counter Input Binary(4)
    ? *   8 Message key Output Char(4)
    ? *   9 Error code I/O Char(*)
    ? *  Optional Parameter Group 1:
    ? *   10 Length of call stack entry Input Binary(4)
    ? *   11 Call stack entry qualification Input Char(20)
    ? *   12 Display program messages screen wait time Input Binary
    ? *  Optional Parameter Group 2:
    ? *   13 Call stack entry data type Input Char(10)
    ? *   14 Coded character set identifier Input Binary(4)
    ? *  Threadsafe: Yes
     d qmhsndpm        pr                  extpgm('QMHSNDPM')
     d    msgno                       7      const
     d    msgf                       20      const
     d    msgdata                  6000      const
     d    msgdatalen                  9b 0   const
     d    msgtype                    10      const
     d    stackentry                 10      const
     d    stackcount                  9b 0   const
     d    msgkey                      4      const
     d    errorhandle               255
    ?D* ERROR CODE HANDLING FIELDS
     D ECH             DS
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZONE
     D  ECH02                  5      8B 0                                      lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERREUR
     D  ECH5A                 17    117
    ? *================================================================
     C
     c                   eval        msgno    = p_msgno
     c                   eval        msgflib  = p_msgflib
     c                   eval        msgffile = p_msgffile
     c                   eval        msgdata  = p_msgdata
     c                   eval        msgtype  = p_msgtype
     c                   eval        msgcse   = p_msgcse
     c                   eval        msgcsc   = p_msgcsc
     c                   eval        msgkey   = p_msgkey
    ? *================================================================
    ? * Send message to program's message queue
    ? *================================================================
    ? * If no message file specified, use default
B01  C                   IF        msgffile = *BLANK
     C                   eval      msgffile = 'QCPFMSG'
E01  C                   END
B01  C                   IF        msgflib  = *BLANK
     C                   eval      msgflib  = '*LIBL'
E01  C                   END
B01  C                   IF        msgtype  = *BLANK
     C                   eval      msgtype  = '*DIAG'
E01  C                   END
B01  C                   IF        msgcse   = *BLANK
     C                   eval      msgcse   = '*'
E01  C                   END
     C                   CALLp      QMHSNDPM   ( msgno
     C                                         : msgffile + msgflib
     C                                         : msgdata
     c                                         : %len(msgdata)
     C                                         : msgtype
     C                                         : msgcse
     C                                         : msgcsc
     C                                         : msgkey
     C                                         : ECH   )
B01  C                   IF        ech03 <> *BLANK
     C                   dump
     C                   callp     die('ERR S/QMHSNDPM, look at ECH03')
E01  C                   ENDIF
     c                   eval      p_msgkey   =   msgkey
B00  c     *pssr         begsr
     c                   dump
E00  c                   endsr
EPR  p pmqmsg8         e
      /endif
BPR  p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE
     d  p_msgtype                    10    const         options(*nopass)       *DIAG
     d  p_msgcse                     10    const         options(*nopass)       call stack entry
     d  p_msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d  p_msgkey                      4                  options(*nopass)       message key
    ? * prototype de QMHSNDMPM
    ? *  Required Parameters Group:
    ? *   1 Message identifier Input Char(7)
    ? *   2 Qualified message file name Input Char(20)
    ? *   3 Message data or immediate text Input Char(*)
    ? *   4 Length of message data or immediate text Input Binary(4
    ? *   5 Message type Input Char(10)
    ? *   6 Call stack entry Input Char(*) or Pointer
    ? *   7 Call stack counter Input Binary(4)
    ? *   8 Message key Output Char(4)
    ? *   9 Error code I/O Char(*)
    ? *  Optional Parameter Group 1:
    ? *   10 Length of call stack entry Input Binary(4)
    ? *   11 Call stack entry qualification Input Char(20)
    ? *   12 Display program messages screen wait time Input Binary
    ? *  Optional Parameter Group 2:
    ? *   13 Call stack entry data type Input Char(10)
    ? *   14 Coded character set identifier Input Binary(4)
    ? *  Threadsafe: Yes
     d qmhsndpm        pr                  extpgm('QMHSNDPM')
     d    msgno                       7      const
     d    msgf                       20      const
     d    msgdata                  6000      const
     d    msgdatalen                  9b 0   const
     d    msgtype                    10      const
     d    stackentry                 10      const
     d    stackcount                  9b 0   const
     d    msgkey                      4      const
     d    errorhandle               255
    ?D* ERROR CODE HANDLING FIELDS
     D ECH             DS           255
     D  ECH01                  1      4B 0 INZ(255)                             LONGUEUR DE LA ZON
     D  ECH02                  5      8B 0 inz(0)                               lng DE LA REPONSE
     D  ECH03                  9     15                                         NUMERO DE L'ERREUR
     D  ECH05                 17    255                                         MSGDTA POUR L'ERRE
     D  ECH5A                 17    117
     d  w_msgno        s              7
     d  w_msgflib      s             10    inz('*LIBL')
     d  w_msgffile     s             10    inz(MessageFile)
     d  w_msgdata      s           6000    varying inz('')
     d  w_msgtype      s             10    inz('*DIAG')
     d  w_msgcse       s             10    inz('*')
     d  w_msgcsc       s              4B 0 inz(1)
     d  w_msgkey       s              4    inz(*blank)
      /free
B01    if %parms >= 7 ;
          eval w_msgcsc = p_msgcsc ;
E01    endif ;
B01    if %parms >= 6 ;
          eval w_msgcse = p_msgcse ;
E01    endif ;
B01    if %parms >= 5 ;
          eval w_msgtype = p_msgtype ;
E01    endif ;
B01    if %parms >= 4 ;
          eval w_msgffile = p_msgffile ;
E01    endif ;
B01    if %parms >= 3 ;
          eval w_msgflib = p_msgflib ;
E01    endif ;
B01    if %parms >= 2 ;
          eval w_msgdata = p_msgdata ;
E01    endif ;
B01    if %addr(p_msgno) <> *null ;
          eval w_msgno = p_msgno ;
E01    endif ;
B01    if w_msgflib = '' ;
          w_msgflib = '*LIBL';
E01    endif;
B01    if    w_msgffile = '' ;
          w_msgffile =MessageFile ;
E01    endif;
B01    if    w_msgtype  = '' ;
          w_msgtype = '*DIAG'       ;
E01    endif;
B01    if    w_msgcse   = '' ;
          w_msgcse  = '*'            ;
E01    endif;
B01    if w_msgcsc = 0 ;
          w_msgcsc = 2 ;
E01    endif;

       if w_msgno = '' and w_msgdata = '';
          w_msgno = 'CPF9898';
          w_msgdata='empty message';
          w_msgffile='QCPFMSG';
          w_msgflib='*LIBL';
       endif;

       CALLp QMHSNDPM ( w_msgno
          : w_msgffile + w_msgflib
          : w_msgdata
          : %len(w_msgdata)
          : w_msgtype
          : w_msgcse
          : w_msgcsc
          : w_msgkey
          : ECH ) ;
B01    IF ech03 <> *BLANK ;
          dump ;
          // die('ERR S/QMHSNDPM, look at ECH03')   ;
          CALLp QMHSNDPM ( ech03
             : 'QCPFMSG   *LIBL     '
             : ech05
             : %len(ech05    )
             : '*ESCAPE'
             : '*'
             : 1
             : w_msgkey
             : ECH ) ;
E01    ENDIF ;
B01    if %parms >= 8 ;
          eval p_msgkey = w_msgkey ;
E01    endif ;
B00    begsr *pssr ;
          dump ;
E00    endsr ;
      /end-free
EPR  p message         e
    ? *                     8 paramètres : toutes les informations

      /if defined(getmessage)                                                    lowercase
     p GetMessage      b
     d                 pi           200    varying
     d  p_msgno                       7    const         options(*omit)         n°
     d  p_msgdata                  6000    const varying options(*nopass)       variables
     d  p_msgflib                    10    const         options(*nopass)       *LIBL
     d  p_msgffile                   10    const         options(*nopass)       MESSAGE

     d*msgqlib         s             10
     d*msgqnam         s             10
     d  w_msgno        s              7
     d  w_msgflib      s             10    inz('')
     d  w_msgffile     s             10    inz('')
     d  w_msgdata      s           6000    varying inz('')
     d errorcode       ds                  likeds(errorcodehandler)
     d                                     inz(*likeds)
      /free

       If %Parms >= 4 ;
          Eval w_msgffile = p_msgffile ;
       Endif ;
       If %Parms >= 3 ;
          Eval w_msgflib = p_msgflib ;
       Endif ;
       If %Parms >= 2 ;
          Eval w_msgdata = p_msgdata ;
       Endif ;
       If %Addr(p_msgno) <> *null ;
          Eval w_msgno = p_msgno ;
       Endif ;

       If w_msgffile='';
          If %Subst(w_msgno :1:3)='CPF' Or
                %Subst(w_msgno :1:3)='CPE';
             w_msgffile= 'QCPFMSG';
             If w_msgflib = '' ;
                w_msgflib = '*LIBL';
             Endif;
          Endif;
       Endif;


       qmhrtvm(
          rtvm0100
          : %Len(rtvm0100)
          : 'RTVM0100'
          : w_msgno
          : w_msgffile + w_msgflib
          : w_msgdata
          : %Len(w_msgdata)
          : '*YES'
          : '*YES'
          : errorcode);
       If errorcode.available > 0;
          Return w_msgno +'('+%Trim(w_msgflib)+'/'+%Trim(w_msgffile)+')';
       Endif;
       Return %Subst(rtvm0100.message:1:rtvm0100.message_len);

       Begsr *pssr ;
             dumpcallstack();
             dump(a);
       Endsr ;
      /end-free
     p                 e
      /endif

      *=--------------------------------------------------------------------------=*
     p DumpCallStack   b
     d DumpCallStack   pi
      * Error Code Handler
     D ECH             DS                  likeds(errorcodehandler)
     d                                     inz(*likeds)
       //?Retrieve Call Stack (QWVRCSTK) API
       //? Required Parameter Group:
       //?1 Receiver variable Output Char(*)
       //?2 Length of receiver variable Input Binary(4)
       //?3 Format of receiver information Input Char(8)
       //?4 Job identification information Input Char(*)
       //?5 Format of job identification information Input Char(8)
       //?6 Error code I/O Char(*)
     d QWVRCSTK        pr                  extpgm('QWVRCSTK')
     d Receiver                   32767a          options( *varsize )
     d length_recvr                  10i 0 const
     d format_name                    8    const
     d Job_id                        52    const
     d Job_Id_Format                  8    const
     d Error_code                 32767a          options( *varsize )
     d JIDF0100        ds                  qualified
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_job                  16
     d Reserved1                      2
     d Thread_ind                    10i 0
     d Thread_id                      8
     d CSTK0100        ds         65535    qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Nb_cstk_thread                10i 0
     d Offset_cstke                  10i 0
     d Nb_cstk                       10i 0
     d thread_id                      8
     d status                         1
     d CSTKe           ds                  qualified  based(pCstke)
     d cstke_len                     10i 0
     d stat_id_disp                  10i 0
     d stat_id_nb                    10i 0
     d proc_disp                     10i 0
     d proc_len                      10i 0
     d Request_level                 10i 0
     d Program_name                  10
     d Program_lib                   10
     d MI_inst                       10i 0
     d Module_name                   10
     d Module_lib                    10
     d Control_bndry                  1
     d Reserved1                      3
     d Actgrpnb                      10u 0
     d Actgrpname                    10
     d Reserved2                      2
     d Pgm_ASP_name                  10
     d Pgm_ASP_lib                   10
     d Pgm_ASP_nbr                   10i 0
     d Pgm_ASP_lib_nb                10i 0
     d Actgrp_nbr_lng                20u 0
     d Statement       ds          1000    qualified based(pStatement)
     d identifier                    10    dim(100)
     d Procedure       ds          1000    qualified based(pProcedure)
     d name                        1000
     d cstkmsg         ds                  qualified
     d rank                           4
     d x1                             1
     d actgrp                        11
     d lib                           11
     d pgm                           11
     d instr                         11
     d proc                         100
     d x20             s             20
     d iCstke          s             10u 0
     d TRC0001         ds                  qualified
     d stack                        150    dim(9)
     d iStack          s              5u 0
      /free
       *inlr = *on ;
       ech.provided =%size(ech);
       ech.available=0;
       //?get current call stack
       clear jidf0100;
       jidf0100.Job_name      = '*';
       jidf0100.User_name     = '';
       jidf0100.Job_number    = '';
       jidf0100.Internal_job  = '';
       jidf0100.Reserved1=*loval;
       jidf0100.Thread_id=*loval;
       jidf0100.Thread_ind =1;
       QWVRCSTK (
          cstk0100
          : %len(cstk0100)
          : 'CSTK0100'
          : JIDF0100
          : 'JIDF0100'
          : Ech ) ;
B01    if ech.available > 0;
          message(ech.msgid:ech.msgdta:'':'QCPFMSG');
E01    endif;
       Clear TRC0001;
       TRC0001.stack(1)=
          'rank Actgroup   Library    Program    Instruct   procedure' ;
       iStack=2;
       pcstke = %addr(cstk0100)+ cstk0100.Offset_cstke;
       // don't show current proc
          pcstke+=cstke.cstke_len;
B01    for icstke = 1 to cstk0100.Nb_cstk - 1;
          clear cstkmsg;
          pStatement = pcstke + cstke.stat_id_disp;
          pProcedure = pcstke + cstke.proc_disp;
          evalr x20 = %editc(icstke:'Z') ;
          evalr cstkmsg.rank = x20;
          cstkmsg.lib = cstke.Program_lib ;
          cstkmsg.pgm = cstke.Program_name ;
B02       if cstke.stat_id_nb <> 0;
             cstkmsg.instr = statement.identifier(1);
X02       else;
             cstkmsg.instr='';
E02       endif;
          cstkmsg.actgrp = cstke.Actgrpname ;
B02       if cstke.proc_disp <> 0;
             cstkmsg.proc = %subst(procedure : 1 : cstke.proc_len );
X02       else;
             cstkmsg.proc = '';
E02       endif;
          TRC0001.stack(iStack)=%TrimR(cstkmsg);
          if iStack >= %Elem(TRC0001.stack);
             Leave;
          Endif;
          iStack += 1;
          pcstke+=cstke.cstke_len;
E01    endfor;
       // message dans la joblog
       message('TRC0001':TRC0001);
       return;
B00    begsr *pssr ;
       dump ;
E00    endsr ;
      /end-free
     p DumpCallStack   e
      *=--------------------------------------------------------------------------=*
      *=--------------------------------------------------------------------------=*
      /if defined(LOWERCASE)                                                    lowercase
BPR  p lcase           b
     d lcase           pi         32787    varying
     d  FromString                32787    varying const
    ? * table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
    ? * table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   return    %xlate(up:lo:fromString)
B00  C     *PSSR         BEGSR
      /free
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
      /end-free
E00  C                   ENDSR
EPR  p lcase           e
BPR  p ucase           b
     d ucase           pi         32787    varying
     d  FromString                32787    varying const
    ? * table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
    ? * table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   return    %xlate(lo:up:fromString)
B00  C     *PSSR         BEGSR
      /free
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
      /end-free
E00  C                   ENDSR
EPR  p ucase           e
      /endif                                                                    lowercase
      /if defined(QUOTE)                                                        quote
BPR  PQuote            B
     D Quote           PI         32767    varying
     D InString                   32767    varying const
     d p_TrimIt                        n   options(*nopass) const
     D OutString       S          32767    varying
     D Pos             S              4  0
     d TrimIt          s               n
      /free
         if %parms() >=2;
            trimit = p_trimit;
         else;
            trimit = true;
         endif;
      /end-free
B01  c                   if        %len(instring) > 0
     c                   if        trimit
     C                   eval      outstring = %trim(instring)
     c                   else
     C                   eval      outstring = instring
     c                   endif
     c                   eval      pos = 1
B02  c                   do        *hival
B03  c                   if        pos > %len(outstring)
     c                   leave
E03  c                   endif
     c                   eval      pos = %scan('''' : outstring : pos)
B03  c                   if        pos = 0
     c                   leave
E03  c                   endif
     c                   eval      outstring = %replace('''''' :
     c                                                  outstring :
     c                                                  pos :
     c                                                  1)
     c                   eval      pos = pos + 2
E02  c                   enddo
E01  c                   endif
     c                   eval      outstring = '''' + outstring + ''''
     c                   return    outstring
B00  C     *PSSR         BEGSR
      /free
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
      /end-free
E00  C                   ENDSR
EPR  PQuote            E
      /endif                                                                    quote
BPR  P die             B
     D die             PI
     D    msg                       256A   const
     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                  256A
     D dsEC            DS
     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
     D  dsECBytesA             5      8I 0 inz(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256
     D MsgLen          S             10I 0
     D TheKey          S              4A
     c     ' '           checkr    msg           MsgLen
B01  c                   if        MsgLen<1
    ?c*                  return    *off
E01  c                   endif
     c                   callp     QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL':
     c                               Msg: MsgLen: '*ESCAPE':
     c                               '*': 1: TheKey: dsEC)
    ?c*                  return    *off
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  P                 E
      /endif                                                                    procedure
      /if defined(CSYSTEM)
      /if defined(DATA_SECTION)
     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? * usage sample
    ? * d cmde            s           2000    varying
    ? *  /free
    ? *    cmde='RMVLNK OBJLNK(''' + ifsfile  + ''')';
    ? *    rc =  c_system(cmde );
    ? *    if rc <> 0;
    ? *    message(msgid:'':'':'QCPFMSG');
    ? *    return rc;
    ? *    endif;
      /endif
      /endif
      /if defined(RTVJOBA)
      /if defined(DATA_SECTION)
     D   RtvJobA       PR                    EXTPGM('QUSRJOBI')                 Rtv job information.
     D PR_RtnJobI                  5000A     OPTIONS(*VARSIZE)                  Return information.
     D PR_LenRtnObjD                 10I 0   CONST                              Information length.
     D PR_RtnFmt                      8A     CONST                              Information format.
     D PR_QJob                       26A     CONST                              Qualified job.
     D PR_IJob                       16A     CONST                              Internal job.
     D PR_APIErr                             LIKE(ech   ) OPTIONS(*NOPASS)      Error structure.
     d JOBI0200        DS                  qualified
     d returned                      10i 0
     d available                     10i 0
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_id                   16
     d Job_status                    10
     d Job_type                       1
     d Job_subtype                    1
     d Sbsname                       10
     d Run_pty                       10i 0
     d pool                          10i 0
     d used_cpu                      10i 0
     d io_request                    10i 0
     d transactions                  10i 0
     d Response_time                 10i 0
     d Function_type                  1
     d Function_name                 10
     d Actjob_status                  4
     d DB_lckw                       10i 0
     d int_lckw                      10i 0
     d noDB_lckw                     10i 0
     d db_lckw_time                  10i 0
     d int_lckw_time                 10i 0
     d nodb_lckw_time                10i 0
     d Reserved                       1
     d Current_pool                  10i 0
     d Thread_count                  10i 0
     d total_cpu                     20u 0
     d total_io                      20u 0
     d total_db                      20u 0
     d Page_faults                   20u 0
     d endjob_status                  4
     d Mem_pool                      10
     d Message_reply                  1
     d JOBI0400        DS                  qualified
     D  Numberofbytesreturned...
     D                                                          LIKE(TYPEBIN4)
     D  Numberofbytesavailable...
     D                                                          LIKE(TYPEBIN4)
     D  Jobname...
     D                               10
     D  Username...
     D                               10
     D  Jobnumber...
     D                                6
     D  Internaljobidentifier...
     D                               16
     D  Jobstatus...
     D                               10
     D  Jobtype...
     D                                1
     D  Jobsubtype...
     D                                1
     D  Dateandtimejobenteredsystem...
     D                               13
     D  Dateandtimejobbecameactive...
     D                               13
     D  Jobaccountingcode...
     D                               15
     D  Jobdescriptionname...
     D                               10
     D  Jobdescriptionlibraryname...
     D                               10
     D  UnitofworkID...
     D                               24
     D  Modename...
     D                                8
     D  Inquirymessagereply...
     D                               10
     D  LoggingofCLprograms...
     D                               10
     D  Breakmessagehandling...
     D                               10
     D  Statusmessagehandling...
     D                               10
     D  Devicerecoveryaction...
     D                               13
     D  DDMconversationhandling...
     D                               10
     D  Dateseparator...
     D                                1
     D  Dateformat...
     D                                4
     D  Printtext...
     D                               30
     D  Submittersjobname...
     D                               10
     D  Submittersusername...
     D                               10
     D  Submittersjobnumber...
     D                                6
     D  Submittersmessagequeuename...
     D                               10
     D  Submittersmessagequeuelibraryname...
     D                               10
     D  Timeseparator...
     D                                1
     D  CodedcharactersetID...
     D                                     LIKE(TYPEBIN4)
     D  Dateandtimejobisscheduledtorun...
     D                                8
     D  Printkeyformat...
     D                               10
     D  Sortsequencetablename...
     D                               10
     D  Sortsequencelibrary...
     D                               10
     D  LanguageID...
     D                                3
     D  CountryorregionID...
     D                                2
     D  Completionstatus...
     D                                1
     D  Signedonjob...
     D                                1
     D  Jobswitches...
     D                                8
     D  Jobmessagequeuefullaction...
     D                               10
     D  Reserved1...
     D                                1
     D  Jobmessagequeuemaximumsize...
     D                                     LIKE(TYPEBIN4)
     D  Defaultcodedcharactersetidentifier...
     D                                     LIKE(TYPEBIN4)
     D  Routingdata...
     D                               80
     D  Decimalformat...
     D                                1
     D  Characteridentifiercontrol...
     D                               10
     D  Servertype...
     D                               30
     D  Allowmultiplethreads...
     D                                1
     D  Joblogpending...
     D                                1
     D  Reserved2...
     D                                1
     D  Jobendreason...
     D                                        LIKE(TYPEBIN4)
     D  Jobtypeenhanced...
     D                                        LIKE(TYPEBIN4)
     D  Dateandtimejobended...
     D                               13
     D  Reserved3...
     D                                1
     D  Spooledfileaction...
     D                               10
     D  OffsettoASPgroupinformation...
     D                                     LIKE(TYPEBIN4)
     D  NumberofentriesinASPgroupinformation...
     D                                     LIKE(TYPEBIN4)
     D  LengthofoneASPgroupinformationentry...
     D                                     LIKE(TYPEBIN4)
     d JOBI0600        DS                  qualified
     d returned                      10i 0
     d available                     10i 0
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_ID                   16
     d Job_status                    10
     d Job_type                       1
     d Job_subtype                    1
     d Job_switches                   8
     d End_status                     1
     d SBS_name                      10
     d SBS_lib                       10
     d Current_user                  10
     d DBCS_capable                   1
     d Exit_key                       1
     d Cancel_key                     1
     d Product_code                  10i 0
     d User_code                     10i 0
     d Program_code                  10i 0
     d Special_env                   10
     d Device_name                   10
     d grpprf                        10
     d grpprf_array                  10    dim(15)
     d Job_user_id                   10
     d Job_user_ind                   1
     d Client_IP                     15
     d Reserved1                      2
     d time_zone_off                 10i 0
     d time_zone_len                 10i 0
     d JOBI0700        DS                  qualified
     d returned                      10i 0
     d available                     10i 0
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_ID                   16
     d Job_status                    10
     d Job_type                       1
     d Job_subtype                    1
     d Reserved1                      2
     d Nb_SYSLIBL                    10i 0
     d Nb_product                    10i 0
     d Nb_Curlib                     10i 0
     d Nb_USRLIBL                    10i 0
     d library_list                  11    dim(300)





    ? * sample
    ? *        RtvJobA  ( JOBI0400
    ? *                        : %Size( JOBI0400 )
    ? *                        : 'JOBI0400'
    ? *                        : '*'
    ? *                        : *Blank
    ? *                        : ECH
    ? *                        );



      /endif
      /endif
      /if defined(ECH)
      /if defined(DATA_SECTION)

    ? * Error Code Handler
     D ECH             DS                  likeds(errorcodehandler)
     d                                     inz(*likeds)
      /endif
      /endif
      /if defined(CMATH)
      /if defined(DATA_SECTION)
      * float absolute
     Dc_fAbs           pr             8f   extproc('fabs')
     D  double                        8f                    value
     Dc_log            pr             8f   extproc('log')
     D  double                        8f                    value
     Dc_cos            pr             8f   extproc('cos')
     D  radian                        8f                    value
     Dc_sin            pr             8f   extproc('sin')
     D  radian                        8f                    value
     Dc_tan            pr             8f   extproc('tan')
     D  radian                        8f                    value
     dc_pi             s              8f   inz(3,141592653589793238462643383279)
     D Radian          pr             8f
     d  degre                         8f   const
     D degree          pr             8f
     d  radian                        8f   const
     Dc_atan           pr             8f   extproc('atan')
     D  any                           8f                    value
     Dc_atan2          pr             8f   extproc('atan2')
     D  any                           8f                    value
     D  any                           8f                    value
     D Min             pr             8f
     d  value1                        8f   const
     d  value2                        8f   const
     d  value3                        8f   const options(*nopass)
     d  value4                        8f   const options(*nopass)
     d  value5                        8f   const options(*nopass)
     d  value6                        8f   const options(*nopass)
     d  value7                        8f   const options(*nopass)
     d  value8                        8f   const options(*nopass)
     d  value9                        8f   const options(*nopass)
     d  value10                       8f   const options(*nopass)
     Dc_ceil           pr             8f   extproc('ceil')
     D  ceil                          8f                    value
     Dc_floor          pr             8f   extproc('floor')
     D  floor                         8f                    value
     Dc_pow            pr             8f   extproc('pow')
     D  pow                           8f                    value
     Dc_log10          pr             8f   extproc('log10')
     D  log10                         8f                    value
      /endif
      /if defined(PROCEDURE_SECTION)
     p Radian          b
     D Radian          pi             8f
     d  degre                         8f   const
      /free
       return c_pi * degre / 180 ;
       begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
       endsr;
      /end-free
     p Radian          e
     p Degree          b
     D degree          pi             8f
     d  radian                        8f   const
      /free
       return radian * 180 / c_pi ;
       begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
       endsr;
      /end-free
     p                 e
     p Min             b
     D Min             pi             8f
     d  value1                        8f   const
     d  value2                        8f   const
     d  value3                        8f   const options(*nopass)
     d  value4                        8f   const options(*nopass)
     d  value5                        8f   const options(*nopass)
     d  value6                        8f   const options(*nopass)
     d  value7                        8f   const options(*nopass)
     d  value8                        8f   const options(*nopass)
     d  value9                        8f   const options(*nopass)
     d  value10                       8f   const options(*nopass)
     d  rtn            s              8f
      /free
       rtn  = value1;
       if rtn > value2;
          rtn = value2;
       endif;
       if %parms() >=3 and rtn > value3;
                           rtn = value3;
       endif;
       if %parms() >=4 and rtn > value4;
                           rtn = value4;
       endif;
       if %parms() >=5 and rtn > value5;
                           rtn = value5;
       endif;
       if %parms() >=6 and rtn > value6;
                           rtn = value6;
       endif;
       if %parms() >=7 and rtn > value7;
                           rtn = value7;
       endif;
       if %parms() >=8 and rtn > value8;
                           rtn = value8;
       endif;
       if %parms() >=9 and rtn > value9;
                           rtn = value9;
       endif;
       if %parms() >=10 and rtn > value10;
                           rtn = value10;
       endif;
       return rtn;
       begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
       endsr;
      /end-free
     p Min             e
      /endif
      /endif
      /if defined(BIG)
      /if defined(FILE_SECTION)
     fbigt25p   o    e             disk    prefix(t25_)
      /endif
      /if defined(DATA_SECTION)
     d Dynpro          pr
     d   program                           like(t25_program)  const
     d   dynpro                            like(t25_dynpro)   const

     d Field           pr
     d   fname                             like(t25_fname  )  const
     d   fvale                             like(t25_fvale )   const

     d trans           pr
     d   fname                             like(t25_fname  )  const

     d BdcOpen         pr
     d   fname                             like(t25_fname  )  const

     d BdcClose        pr
      /endif
      /if defined(PROCEDURE_SECTION)
    ? *=---------------------------------------------------------------=*
BPR  p Dynpro          b
     d Dynpro          pi
     d   program                           like(t25_program)  const
     d   dynpro                            like(t25_dynpro)   const
      /free
       clear bigt25f;
       t25_program = program;
       t25_dynpro = dynpro ;
       t25_dynbegin= 'D';
       write bigt25f;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p Field           b
     d Field           pi
     d   fname                             like(t25_fname  )  const
     d   fvale                             like(t25_fvale )   const
      /free
       clear bigt25f;
       t25_dynbegin= 'F';
       t25_fname = fname ;
       t25_fvale = fvale ;
       write bigt25f;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p trans           b
     d trans           pi
     d   fname                             like(t25_fname  )  const
      /free
       clear bigt25f;
       t25_dynbegin= 'T'    ;
       t25_fname = fname ;
       write bigt25f;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p BdcOpen         b
     d                 pi
     d   fname                             like(t25_fname  )  const
      /free
       clear bigt25f;
       t25_dynbegin= 'O'    ;
       t25_fname = fname ;
       write bigt25f;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p BdcClose        b
     d                 pi
      /free
       clear bigt25f;
       t25_dynbegin= 'C'    ;
       write bigt25f;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
         // dump ;
          needdump=false;
       endif;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=---------------------------------------------------------------=*
      /endif
      /endif
      /if defined(USERSPACE )
      /if defined(DATA_SECTION)
       //?********************************************************************/
       //?*  Prototype for QUSCRTUS API                                      */
       //?********************************************************************/
       //?void QUSCRTUS (void *,           /* Qualified User Space Name
       //?               char *,           /* Extended Attribute
       //?               int,              /* Initial Size
       //?               char *,           /* Initial Value
       //?               char *,           /* Public Authority
       //?               void *,           /* Text Description
       //?               ...);             /* Optional Parameter Group 1:
       //?                                      Replace
       //?                                      Error Code
       //?                                    Optional Parameter Group 2:
       //?                                      Domain
       //?                                    Optional Parameter Group 3:
       //?                                      Transfer size request
       //?                                      Optimum alignment
     d quscrtus        pr                  extpgm('QUSCRTUS')
     d   Qualified_User_Space_Name...
     d                               20    const
     d   Extended_Attribute...
     d                               10    const
     d   Initial_Size...
     d                                9b 0 const
     d   Initial_Value...
     d                                1    const
     d   Public_Authority...
     d                               10    const
     d   Text_Description...
     d                               50    const
     d   Replace...
     d                               10    const options(*nopass)
     d   Error_Code...
     d                              256          options(*nopass:*varsize)
     d   Domain...
     d                               10    const options(*nopass)
     d   Transfer_size_request...
     d                                9b 0 const options(*nopass)
     d   Optimum_alignment...
     d                                1    const options(*nopass)
       //?#include 'QUSPTRUS.H'                /* QUSPTRUS CLEINC            */
       //?********************************************************************/
       //?*  Prototype for QUSPTRUS API                                      */
       //?********************************************************************/
       //?void QUSPTRUS (void *,        /* Qualified User Space Name
       //?               void *,        /* Pointer to User Space
       //?               ...);          /* Optional Parameter:
       //?                                   Error code
     d qusptrus        pr                  extpgm('QUSPTRUS')
     d   Qualified_User_Space_Name...
     d                               20    const
     d   Pointer_to_User_Space...
     d                                 *
     d   Error_code...
     d                              256    options(*nopass:*varsize)
       //?#include 'QUSDLTUS.H'                /* QUSDLTUS CLEINC            */
       //?********************************************************************/
       //?*  Prototype for QUSDLTUS API                                      */
       //?********************************************************************/
       //? void QUSDLTUS (void *,           /* Qualified User Space Name       */
       //?                void *);          /* Error Code.                     */
     d qusdltus        pr                  extpgm('QUSDLTUS')
     d   Qualified_User_Space_Name...
     d                               20
     d   Error_code                 256    options(*varsize)

     D quscusat...
     D                 pr                  extpgm( 'QUSCUSAT' )
     D  Lib                          10a
     D  Usrspc                       20a   const
     D  Attributes                65535a   const options( *varsize )
     D  ErrorDS                   65535a         options( *varsize )

     D Extendibility   c                   const( 3 )
     D  NoAutoExtend   c                   const( '0' )
     D  AutoExtend     c                   const( '1' )
     D Lib             s             10a
     D Attributes      ds                  qualified
     D  Keys                         10i 0 inz( 1 )
     D  Key                          10i 0 inz( Extendibility )
     D  Len                          10i 0 inz( %size( AutoExtend ) )
     D  Value                         1a   inz( AutoExtend )
     D                                3a
     d ListApiHeader   ds         65535    qualified based(pTemplate)
     d User_area                     64
     d generic_h_Size                10i 0
     d Header_Release                 4
     d Format_name                    8
     d API_used                      10
     d Create_Datim                  13
     d Completion                     1
     d Used_Space                    10i 0
     d Input_Offset                  10i 0
     d Input_Size                    10i 0
     d Header_Offset                 10i 0
     d Header_Size                   10i 0
     d Data_Offset                   10i 0
     d Data_Size                     10i 0
     d Count                         10i 0
     d Entry_Size                    10i 0
     d Entry_CCSID                   10i 0
     d Country_Id                     2
     d Language_ID                    3
     d Subsetted                      1
     d Reserved1                     42
     d API_EP_name                  256
     d Reserved2                    128
      /endif
      /if defined(PROCEDURE_SECTION)
      /endif
      /endif


      /if defined(ICONV)
      /if defined(DATA_SECTION)
    ? *==================================================================
    ? * Type definitions for Code Conversion APIs
    ? *==================================================================
     D  iconv_t        ds                  based(pDummy)
     d                                     qualified
     D   rc                          10i 0
     D   cd                          10i 0 dim(12)
     D iconvtoCode     ds                  qualified
     D         ccsid                 10i 0 inz(500)
     D         convA                 10i 0
     D         subA                  10i 0
     D         shftA                 10i 0
     D         lnOpt                 10i 0
     D         erOpt                 10i 0
     D         res                   12a   inz(*ALLx'00')
     D iconvfromCode   ds                  qualified
     D          ccsid                10i 0 inz(0)
     D          convA                10i 0 inz(0)
     D          subA                 10i 0 inz(0)
     D          shftA                10i 0 inz(1)
     D          lnOpt                10i 0 inz(0)
     D          erOpt                10i 0 inz(0)
     D          res                  12a   inz(*ALLx'00')
    ? *==================================================================
    ? * Prototype for iconv_open()--Code Conversion Allocation API
    ? *==================================================================
     D iconv_open      pr                  extproc('QtqIconvOpen') like(iconv_t)
     D  pToCode                        *   value
     D  pFromCode                      *   value
    ? *==================================================================
    ? * Prototype for iconv()--Code Conversion API
    ? *==================================================================
     D iconv           pr            10i 0 extproc('iconv')
     D   cd                                value  like(iconv_t)
     D   pInBuf                        *   const
     D   inBytesLft                  10i 0
     D   pOutBuf                       *   const
     D   outBytesLft                 10i 0
    ? *==================================================================
    ? * Prototype for iconv_close()--Code Conversion Deallocation API
    ? *==================================================================
     D iconv_close     pr            10i 0 extproc('iconv_close')
     D   cd                                value  like(iconv_t)
    ? *==================================================================
     D* hard-coded, ccsid 500, Portable character set
     d*i5/OS Information Center > Programmation > i5/OS globalization > Globalization reference
     d*information > Character sets
      * PORTABLECHAR:C = '$´^~#@[\]{|}!00500      '
     dPortableCharInz  ds                  qualified
     d   Dollar                       1    inz(x'5B')
     d   AccentAcute                  1    inz(x'BE')
     d   Caret                        1    inz(x'5F')
     d   Tilde                        1    inz(x'A1')
     d   NumberSign                   1    inz(x'7B')
     d   AtSign                       1    inz(x'7C')
     d   LeftBracket                  1    inz(x'4A')
     d   BackSlash                    1    inz(x'E0')
     d   RightBracket                 1    inz(x'5A')
     d   LeftBrace                    1    inz(x'C0')
     d   LogicalOr                    1    inz(x'BB')
     d   RightBrace                   1    inz(x'D0')
     d   ExclamationPoint...
     d                                1    inz(x'4F')
     d   CCSID                        5s 0 inz(500)
     d   OSversion                         like(prdr0100.Release_level)
     d PortableChar    ds                  qualified
     d   Dollar                       1    inz('_')
     d   AccentAcute                  1    inz('_')
     d   Caret                        1    inz('_')
     d   Tilde                        1    inz('_')
     d   NumberSign                   1    inz('_')
     d   AtSign                       1    inz('_')
     d   LeftBracket                  1    inz('_')
     d   BackSlash                    1    inz('_')
     d   RightBracket                 1    inz('_')
     d   LeftBrace                    1    inz('_')
     d   LogicalOr                    1    inz('_')
     d   RightBrace                   1    inz('_')
     d   ExclamationPoint...
     d                                1
     d   CCSID                        5s 0 inz(640)
     d   OSversion                         like(prdr0100.Release_level)

     d convccsid       pr          1000    varying                              OutString
     d                               10i 0 const                                InCcsid
     d                               10i 0 const                                OutCcsid
     d                             1000    const varying                        InString



      /endif
      /if defined(PROCEDURE_SECTION)
     P convccsid       b                   export
     d                 pi          1000    varying
     d  InCcsid                      10i 0 const
     d OutCcsid                      10i 0 const
     d  InString_p                 1000    const varying
     d  InString       s           1000    static varying
     d OutString       s           1000    static varying
     d inLen           s             10i 0 static
     d OutLen          s             10i 0 inz(1000)
     D hIconv          ds                  likeds(iconv_t) inz
     d errcode         ds                  likeds(ErrorCodeHandler)
     d                                     inz(*likeds)
     d rc              s             10i 0
     d ToCCSID         s             10i 0
      /free
       ToCCSID = OutCCSID;
       if ToCCSID = 0;
       // system info
          if not jp4.GotOsVersion;
          reset ErrorCodeHandler;
          APIlen    = %size(PRDR0100) ;
          APIformat = 'PRDR0100'      ;
          osinfo='*OPSYS *CUR  0000*CODE     ' ;
          rtvprdinf(PRDR0100
           : APIlen
           : APIformat
           : osinfo
           : ErrorCodeHandler );
             if (ErrorCodeHandler.available>0);
                message(ErrorCodeHandler.msgid:ErrorCodeHandler.msgdta
                   :'':'QCPFMSG':'*ESCAPE');
             endif;
             jp4.gotosversion = true;
             jp4.OSVersion=prdr0100.Release_level;
          endif;

          if jp4.OSVersion < 'V6R1M0';
          // get job info - iconv ne traite pas le ccsid 65535
             if not jp4.GotJobi04 ;
             reset ErrorCodeHandler;
                 RtvJobA ( JOBI0400
                    : %Size( JOBI0400 )
                    : 'JOBI0400'
                    : '*'
                    : *Blank
                    : ECH
                    );
                if (ErrorCodeHandler.available>0);
                   message(ErrorCodeHandler.msgid:ErrorCodeHandler.msgdta
                      :'':'QCPFMSG':'*ESCAPE');
                endif;
                jp4.GotJobi04  =true;
                endif;
                if jobi0400.CodedcharactersetID        =65535;
                   jp4.jobccsid=jobi0400.Defaultcodedcharactersetidentifier;
                else;
                   jp4.jobccsid=jobi0400.CodedcharactersetID        ;
                endif;
             ToCCSID = jp4.jobccsid;
          else;
          // v6r1 handles ccsid 65535
          endif;
       endif;

        iconvfromCode.ccsid =  InCcsid  ;
        iconvtoCode.ccsid =    ToCCSID    ;
        hIconv = iconv_open(%addr(iconvtoCode) :
                            %addr(iconvfromCode) ) ;
        if hiconv.rc <> 0;
          if errno() <> 0;
             message(errnomsg(errno()):'':'*LIBL':'QCPFMSG':'*DIAG');
             return '';
          endif;
        endif;
       if jp4.OSVersion < 'V6R1M0';
       // iconv does not return the job ccsid
       else;
       if toccsid = 0;
       jp4.jobccsid=HICONV.CD(2);
       endif;
       endif;
        InString = InString_P;
        InLen = %len(InString)  ;
        OutString = '';
        %len(OutString)=OutLen;
        rc = iconv(   hIconv :
            %addr(InString   )+2 :
            Inlen :
            %addr(OutString  )+2 :
            Outlen );
         if rc< 0;
            if c_errno <> 0;
               message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
               return '';
            endif;
         endif;
         // outlen = premiere position non utilisée dans outstring
         %len(OutString)=%size(OutString)-OutLen-2;
         iconv_close(   hiconv);
       return OutString ;
       begsr *pssr;
       monitor;
          dumpcallstack();
          // debug mode ?
          clear errcode;
          errcode.provided =%size(errcode);
          debugmode.dbgattr='*DEBUGJOB';
          debugging=true;
          RtvDbgAttr ( debugmode.DbgAttr :
             debugmode.RtnAttr :
             errcode );
          if (errcode.available>0);
             if errcode.msgid   ='CPF9541';
                debugging=false;
             else;
                message(errcode.msgid :errcode.msgdta  :'':'QCPFMSG':'*DIAG');
             endif;
          endif;
          if debugging ;
             dump;
          endif;
          on-error;
          endmon;
       endsr;
      /end-free
     P                 e
      /endif
      /endif
      /if defined(ERRNO)
      /include jpltools,jp4ern1
      /endif
      /if defined(SQL)
      /include jpltools,jp4sql1
      /endif
      /if defined(XLXML)                                                        xlxml
      /include jpltools,jp4xlx4
      /endif                                                                    xlxml
      /if defined(IFS)
      /include jpltools,jp4ifs1
      /endif
      /if defined(XMLDOM)                                                       xml
      /include jpltools,jp4xml1
      /endif                                                                    xml
      /if defined(PDF)
      /if defined(DATA_SECTION)
      /include jpltools,jp4pdfsp
      /endif
      /endif
      /if defined(BMP)
      /include jpltools,jp4bmp2
      /endif
      /if defined(PRODUCTINFO)
      /if defined(DATA_SECTION)
      * retrieve product info
     D RtvPrdInf       PR                  ExtPgm('QSZRTVPR')
     d  RESULT                      128
     d  RSTLEN                       10i 0       const
     d  FORMAT                        8          const
     d  OSINFO                       27          const
     d   Error_Code                 256          options(*varsize)

     d APIlen          s             10i 0
     d APIformat       s              8
     d  OSINFO         s             27

     d PRDR0100        ds           128    qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Reserved1                     10i 0
     d Product_ID                     7
     d Release_level                  6
     d Product_option                 4
     d Load_ID                        4
     d Load_type                     10
     d Sym_state                     10
     d Load_error_ind                10
     d Load_state                     2
     d Supported_flag                 1
     d Registr_type                   2
     d Registr_value                 14
     d Reserved2                      2
     d more_info                     10i 0
     d Prim_language                  4
     d Min_release                    6
     d Min_VRM                        6
     d Mixed_Releases                 1
     d Level                          3
      /endif
      /if defined(PROCEDURE_SECTION)
      /endif
      /endif
      /if defined(GPS)
      /if defined(DATA_SECTION)
      /include jpltools,jp4gpsp
      /endif
      /endif

      /if defined(WRKUSRINFO)
      /if defined(DATA_SECTION)
     d GetUsrInfo      pr           100    varying
     d                                     extproc('WRKUSRI.GETUSRINFO')
     d  keyword                      10    const
     d  usrprf                       10    const options(*nopass)
     d SetUsrInfo      pr                  extproc('WRKUSRI.SETUSRINFO')
     d  keyword                      10    const
     d  value                       100    const varying
     d  usrprf                       10    const options(*nopass)

      /endif
      /endif

      /if defined(ZLIB      )
      /if defined(DATA_SECTION)
      /include jpltools,jp4zlib
      /endif
      /if defined(PROCEDURE_SECTION)
      /endif
      /endif

      /if defined(FFD)
      /include jpltools,jp4ffd1
      /endif

      /if defined(NEWSERVICE)
      /if defined(DATA_SECTION)
      /endif
      /if defined(PROCEDURE_SECTION)
      /endif
      /endif
