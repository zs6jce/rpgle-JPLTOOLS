    ? *  this sample shows how to code in RPG the inside-code of a
    ? *  sql function that returns a table.
    ? *
    ? *  based on data from qiws/qcustcdt.
    ? *  Take care of having QIWS in your sql path
    ? *
    ? *  an inside-function code must NEVER end abnormaly (sample : endsr '*CANCL' in *PSSR)
    ? *  because this puts SQL in situation to wait a answer that never occurs.
    ? *  An unattended error must be converted in SQLSTATE <> '00000'
    ? *  have a look at sqlstate documentation to choose your own place
    ? *
    ? *  how to do ?
    ? *  main code : controled by a main MONITOR block
    ? *  I/O code : use the extendee (E) to capture the errors
    ? *
    ? *
    ? *  Create Function jpltools1/udtffunc3 ()
    ? *  RETURNS TABLE (
    ? *    CUSNUM NUMERIC(6, 0)
    ? *  , LSTNAM CHAR(8)
    ? *  , INIT CHAR(3)
    ? *  , STREET CHAR(13)
    ? *  , CITY CHAR(6)
    ? *  , STATE CHAR(2)
    ? *  , ZIPCOD NUMERIC(5, 0)
    ? *  , CDTLMT NUMERIC(4, 0)
    ? *  , CHGCOD NUMERIC(1, 0)
    ? *  , BALDUE NUMERIC(6, 2)
    ? *  , CDTDUE NUMERIC(6, 2)
    ? *  )
    ? *  LANGUAGE RPGLE
    ? *  PARAMETER STYLE DB2SQL
    ? *  Not DETERMINISTIC
    ? *  NO SQL
    ? *  CALLED ON NULL INPUT
    ? *  NO DBINFO
    ? *  NO EXTERNAL ACTION
    ? *  NOT FENCED
    ? *  NO FINAL CALL
    ? *  DISALLOW PARALLEL
    ? *  SCRATCHPAD
    ? *  EXTERNAL NAME jpltools1/udtfr3
    ? *  CARDINALITY 10
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
    ? *
    ? * compilation :
    ? *
    ? *
    ? *
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
    ? *================================================================
    ? * sample of program for sql procedure returns a resultset
    ? *================================================================
    ? * the file to read
     fqcustcdt  if   e           k disk    infsr(*pssr)
     f                                     prefix(load_ )
     f                                     rename(cusrec   :fload)
     f                                     usropn
     f                                     infds(fids)
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








     D PSDS           SDS
    ?d*                     Program name (same as subfield location *PROGRAM)
     d SPNAME                        10A                                         Program name (sam
    ?d*                     Status code (same as subfield location *STATUS).
     d SPSTAT                         5A                                         Status code (same
    ?d*                     Previous status code.
     d SPPSTA                         5A                                         Previous status c
    ?d*                     RPG/400 source statement sequence number.
     d SPLINB                         8A                                         RPG/400 source st
    ?d*                     Name of the RPG/400 routine in which the exceptio
     d SPRTN                          8A                                         Name of the RPG/4
    ?d*                     Number of parameters passed to this program (same
     d SPPARM                         5P 0                                       Number of paramet
    ?d*                     Exception type (CPF for a OS/400 system exception
     d SPMSID                         7A                                         Exception type (C
    ?d*                     MI/ODT (machine instruction / object definition t
     d SPMINB                         4A                                         MI/ODT (machine i
    ?d*                     Work area for messages.  This area is only meant
     d SPFIL1                        30A                                         Work area for mes
    ?d*                     Name of library in which the program is located.
     d SPPGLB                        10A                                         Name of library i
    ?d*                     Retrieved exception data. CPF messages are placed
     d SPMSDA                        80A                                         Retrieved excepti
    ?d*                     Identification of the exception that caused RPG90
     d SPMSIP                         4A                                         Identification of
    ?d*                     Unused.
     d SPFIL2                        24A                                         Unused.
    ?d*                     First 2 digits of a 4-digit year. The same as the
     d SPSIEC                         2A                                         First 2 digits of
    ?d*                     Name of file on which the last file operation occ
     d SPFILE                         8A                                         Name of file on w
    ?d*                     Status information on the last file used.  This i
     d SPFSTA                        35A                                         Status informatio
    ?d*                     Job name.
     d SPJBNM                        10A                                         Job name.
    ?d*                     User name from the user profile.
     d SPJBUS                        10A                                         User name from th
    ?d*                     Job number.
     d SPJBNB                         6S 0                                       Job number.
    ?d*                     Date (in UDATE format) the program started runnin
     d SPUDAT                         6S 0                                       Date (in UDATE fo
    ?d*                     Date of program running (the system date in UDATE
     d SPSYDT                         6S 0                                       Date of program r
    ?d*                     Time of program running in the format hhmmss.
     d SPSYTM                         6S 0                                       Time of program r
    ?d*                     Date (in UDATE format) the program was compiled.
     d SPCPLD                         6A                                         Date (in UDATE fo
    ?d*                     Time (in the format hhmmss) the program was compi
     d SPCPLT                         6A                                         Time (in the form
    ?d*                     Level of the compiler.
     d SPCPLL                         4A                                         Level of the comp
    ?d*                     Source file name.
     d SPSRCF                        10A                                         Source file name.
    ?d*                     Source library name.
     d SPSRCL                        10A                                         Source library na
    ?d*                     Source file member name.
     d SPSRCM                        10A                                         Source file membe
    ?d*                     Unused.
     d SPFIL3                        96A                                         Unused.
     d udtfr3          pr
    ? * list of table columns
     d  p_CUSNUM                           like(load_CUSNUM)
     d  p_LSTNAM                           like(load_LSTNAM)
     d  p_INIT                             like(load_INIT  )
     d  p_STREET                           like(load_STREET)
     d  p_CITY                             like(load_CITY  )
     d  p_STATE                            like(load_STATE )
     d  p_ZIPCOD                           like(load_ZIPCOD)
     d  p_CDTLMT                           like(load_CDTLMT)
     d  p_CHGCOD                           like(load_CHGCOD)
     d  p_BALDUE                           like(load_BALDUE)
     d  p_CDTDUE                           like(load_CDTDUE)
    ? * list of null indicators
     d  p_iCUSNUM                     5i 0
     d  p_iLSTNAM                     5i 0
     d  p_iINIT                       5i 0
     d  p_iSTREET                     5i 0
     d  p_iCITY                       5i 0
     d  p_iSTATE                      5i 0
     d  p_iZIPCOD                     5i 0
     d  p_iCDTLMT                     5i 0
     d  p_iCHGCOD                     5i 0
     d  p_iBALDUE                     5i 0
     d  p_iCDTDUE                     5i 0
    ? * sql style parameters
     d  p_sqlstate                    5
     d  p_function                  517    varying
     d  p_specific                  128    varying
     d  p_sqlmsg                     70    varying
     d  p_scratchpad                100    varying
     d  p_calltype                   10i 0
     d udtfr3          pi
    ? * list of table columns
     d  p_CUSNUM                           like(load_CUSNUM)
     d  p_LSTNAM                           like(load_LSTNAM)
     d  p_INIT                             like(load_INIT  )
     d  p_STREET                           like(load_STREET)
     d  p_CITY                             like(load_CITY  )
     d  p_STATE                            like(load_STATE )
     d  p_ZIPCOD                           like(load_ZIPCOD)
     d  p_CDTLMT                           like(load_CDTLMT)
     d  p_CHGCOD                           like(load_CHGCOD)
     d  p_BALDUE                           like(load_BALDUE)
     d  p_CDTDUE                           like(load_CDTDUE)
    ? * list of null indicators
     d  p_iCUSNUM                     5i 0
     d  p_iLSTNAM                     5i 0
     d  p_iINIT                       5i 0
     d  p_iSTREET                     5i 0
     d  p_iCITY                       5i 0
     d  p_iSTATE                      5i 0
     d  p_iZIPCOD                     5i 0
     d  p_iCDTLMT                     5i 0
     d  p_iCHGCOD                     5i 0
     d  p_iBALDUE                     5i 0
     d  p_iCDTDUE                     5i 0
    ? * sql style parameters
     d  p_sqlstate                    5
     d  p_function                  517    varying
     d  p_specific                  128    varying
     d  p_sqlmsg                     70    varying
     d  p_scratchpad                100    varying
     d  p_calltype                   10i 0

     d  scratchDS      ds           100    based(PscratchDS)
     d  SPlen                         5u 0
     d  SPstatus                      5
     d

     d count           s             10u 0 inz(0)
      /free
       //?* main program
B01    monitor;
          //?initial state
          PscratchDS=%addr(p_ScratchPad);
          p_sqlstate = '00000';
          p_sqlmsg='';
          p_iCUSNUM = -1;
          p_iLSTNAM = -1;
          p_iINIT = -1;
          p_iSTREET = -1;
          p_iCITY = -1;
          p_iSTATE = -1;
          p_iZIPCOD = -1;
          p_iCDTLMT = -1;
          p_iCHGCOD = -1;
          p_iBALDUE = -1;
          p_iCDTDUE = -1;

B02       select;
X02          when p_calltype = -2;
                exsr firstcall;
X02          when p_calltype = -1;
                exsr opencall;
X02          when p_calltype = 0;
                exsr fetchcall;
X02          when p_calltype = 1;
                exsr closecall;
X02          when p_calltype = 2;
                exsr finalcall;
X02          other;
                p_sqlstate = 'JP001';
                p_sqlmsg='unattended call type received';
E02       endsl;
          on-error;
          p_sqlstate = 'JP002';
          p_sqlmsg = spmsid + spmsda ;
          dump ;
E01    endmon;
       return;
       *inrt = *on ;


B01    begsr *pssr ;
          //?avoid going to *pssr, it's an infinite loop.
          dump ;
          p_sqlstate = 'JP003';
          p_sqlmsg = spmsid + spmsda ;
E01    endsr ;

B01    begsr firstcall;
          SPstatus = 'FIRST';
E01    endsr;

B01    begsr opencall;
          SPstatus = 'OPEN ';
          open(e) qcustcdt ;
B02       if %error;
             p_sqlstate = 'JP004';
             p_sqlmsg = spmsid + spmsda ;
             SPstatus = p_sqlstate;
E02       endif;
E01    endsr;

B01    begsr fetchcall;
          SPstatus = 'FETCH';
          read(e) fload;
B02       if %eof();
             p_sqlstate='02000';
             leavesr;
E02       endif;
B02       if %error;
             p_sqlstate = 'JP005';
             p_sqlmsg = spmsid + spmsda ;
             SPstatus = p_sqlstate;
             leavesr;
E02       endif;

          p_CUSNUM = load_CUSNUM ;
          p_LSTNAM = load_LSTNAM ;
          p_INIT = load_INIT ;
          p_STREET = load_STREET ;
          p_CITY = load_CITY ;
          p_STATE = load_STATE ;
          p_ZIPCOD = load_ZIPCOD ;
          p_CDTLMT = load_CDTLMT ;
          p_CHGCOD = load_CHGCOD ;
          p_BALDUE = load_BALDUE ;
          p_CDTDUE = load_CDTDUE ;

          p_iCUSNUM = -0;
          p_iLSTNAM = -0;
          p_iINIT = -0;
          p_iSTREET = -0;
          p_iCITY = -0;
          p_iSTATE = -0;
          p_iZIPCOD = -0;
          p_iCDTLMT = -0;
          p_iCHGCOD = -0;
          p_iBALDUE = -0;
          p_iCDTDUE = -0;



E01    endsr;

B01    begsr closecall;
          SPstatus = 'CLOSE';
          close(e) qcustcdt;
B02       if %error;
             p_sqlstate = 'JP006';
             p_sqlmsg = spmsid + spmsda ;
             SPstatus = p_sqlstate;
             leavesr;
E02       endif;
E01    endsr;

B01    begsr finalcall;
          SPstatus = 'FINAL';
E01    endsr;
