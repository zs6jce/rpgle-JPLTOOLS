    ? * compilation :


      * traiter les convertions de bits avec %BITAND(f:x'80')...





    ? *
      /define INFDS
    ? *define VBEL
    ? *define ECOPRO
    ? *define SQL
    ? *define SQLDESCRIBE
    ? *define LOWERCASE
    ? *define QUOTE
    ? *define XLXML
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
     Frtvfdpr   O    E             PRINTER
     F                                     OFLIND(*IN90)
     F                                     INFDS(FIDS)
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d main            pr                  extpgm('MAIN')
     d filename                      20


     d main            pi
     d filename                      20






     d structure       pr
     d name                         100    varying const

     d fld             pr
     d name                         100    varying const
     d value                        100    varying const
     d equal_p                        1    varying const options(*nopass)


     d hexa            pr           100    varying
     d  char                         50    varying value

     d dspacs          pr
     d dspalias        pr
     d dspaliasns      pr
     d dspbodyces      pr
     d dspbodycs       pr
     d dspcase         pr
     d dspchecke       pr
     d dspchecki       pr
     d dspcheckp       pr
     d dspchkcst       pr
     d dspcolhdg       pr
     d dspconste       pr
     d dspconstraint   pr
     d dspcplx         pr
     d dspdefault      pr
     d dspdepobj       pr
     d dspdf           pr
     d dspdic          pr
     d dspdicfdi       pr
     d dspdicFI        pr
     d dspdrve         pr
     d dspdrvft        pr
     d dspdrvh         pr
     d dspdtalnk       pr
     d dspdtalnkcom    pr
     d dspedit         pr
     d dspedtwrd       pr
     d dspfh           pr
     d dspfield        pr
     d dspfkia         pr
     d dspflda         pr
     d dspfldop        pr
     d dspfldtxt       pr
     d dspformat       pr
     d dspfsa          pr
     d dspfunc         pr
     d dspidcol        pr
     d dspjdup         pr
     d dspjfld         pr
     d dspjoal         pr
     d dspjs           pr
     d dspkeyn         pr
     d dspkih          pr
     d dspksa          pr
     d dsplogl         pr
     d dsplong         pr
     d dspmqtde        pr
     d dspmqtdh        pr
     d dspNarray       pr
     d dspope          pr
     d dspparms        pr
     d dspphhka        pr
     d dspphka         pr
     d dsppka          pr
     d dspphys         pr
     d dspprka         pr
     d dspptar         pr
     d dsppth          pr
     d dsprca          pr
     d dsprefinf       pr
     d dspriafk        pr
     d dsprtb          pr
     d dspsosa         pr
     d dspsop          pr
     d dspsps          pr
     d dspsqla         pr
     d dspstmt         pr
     d dsptdeh         pr
     d dsptdns         pr
     d dsptih          pr
     d dsptrg          pr
     d dsptrns         pr
     d dspType         pr
     d dspupdateces    pr
     d dspupdatecs     pr
     d dspwhences      pr
     d dspwhencs       pr
     d dspxl           pr


     d i               s             10i 0
     d ifsa            s             10i 0
     d iSosa           s             10i 0
     d iKsa            s             10i 0
     d iPka            s             10i 0
     d ICHKE           s             10i 0
     d ICHKP           s             10i 0
     d IFLD            s             10i 0
     d IFOP            s             10i 0

    ? * format list
     d fmtlist         ds                  qualified
     d lib                           10    dim(20)
     d file                          10    dim(20)
     d fmt                           10    dim(20)
     d iFmt            s             10i 0





















    ? *=-----------------------------------------------------------------------------------------=*
     d QDBRTVFD        pr                  extpgm('QDBRTVFD')
     d Receiver                   65535    options(*varsize)
     d receiver_len                  10i 0 const
     d actual_file                   20
     d Format                         8    const
     d search_file                   20    const
     d format_name                   10    const
     d Override                       1    const
     d System_Input                  10    const
     d Format_type                   10    const
     d Error_Code                          like(ErrorCodeHandler)
    ? *=-----------------------------------------------------------------------------------------=*
     d receiver        s          50000    based(preceiver)
     d len             s             10i 0
     d actual_file     s             20
     d FormatAPI       s              8
     d search_file     s             20
     d format_name     s             10
     d Override        s              1
     d System_Input    s             10
     d Format_type     s             10
     d Error_Code      ds                  likeds(ErrorCodeHandler)

    ? *=-----------------------------------------------------------------------------------------=*
    ? * File Definition Header (Qdb_Qdbfh)
    ? *
    ? * Qdb_Qdbfh is the first structure and is located at offset zero of the returned data.
    ? *
    ? * Description
    ?d*                ds                  based( p             ) qualified
     d fh              ds           400    based(pfh  ) qualified
    ? * Length of the data returned in bytes.
     D yret                          10i 0                                        0
    ? * Number of bytes provided for the file definition data.
     D yavl                          10i 0                                        4
    ? * Attributes bytes.
     D      flg                       2                                           8
    ? * Reserved.
    ? * Type of file. If on, the file is a logical database file. If off, a physical database f
    ? * Reserved.
    ? * File type (FILETYPE). If on, the file is a source file (*SRC). If off, a data file (*DA
    ? * Reserved.
    ? * Access path. If on, the file has a keyed sequence access path. If off, an arrival seque
    ? * Reserved.
    ? * Record format level check (LVLCHK). If on, the record format level identifiers are chec
    ? * Select/omit. If on, the file is a select/omit logical file.
    ? * Reserved.
    ? * Double-byte character set (DBCS) or Graphic data. If on, the file's record format(s) co
    ? * Double-byte character set (DBCS) or Graphic literals. If on, the file's record format(s
    ? * Reserved.
     D Reserved_7                     4                                           10
    ? * Number of data members. 0 indicates an externally described physical file or a program
     D lbnum                         05i 0                                        14
    ? * Keyed sequence access path description. If this file has an arrival sequence access pat
    ?D*kdat                          13
    ? * Number of key fields for the file. 1 through 120.
     D knum                          05i 0                                        16
    ? * Maximum key length for the file. 1 through 2000.
     D kmxl                          05i 0                                        18
    ? * Keyed sequence access path attributes.
     D kflg                           1                                           20
    ? * Reserved
    ? * Alternate collating sequence (ALTSEQ). If on, an alternate collating sequence table is
    ? * Reserved.
    ? * Force keyed access path (FRCACCPTH). If on, the access path and changed records are for
    ? * Floating point key indicator. If on, the access path for the file contains floating poi
    ? * Access path maintenance (MAINT).
     D kfdm                           1                                           21
    ? *
    ? * I
    ? * Immediate maintenance (*IMMED)
    ? * D
    ? * Delayed maintenance (*DLY)
    ? * R
    ? * Rebuild maintenance (*REBLD)
    ? *
    ? * Reserved.
     D Reserved_10                    8                                           22
    ? * Public authority (AUT).
     D aut                           10                                           30
    ? *
    ? * *CHANGE
    ? * Public change authority
    ? * *ALL
    ? * Public all authority
    ? * *USE
    ? * Public use authority
    ? * *EXCLUDE
    ? * Public exclude authority
    ? * authorization-list-name
    ? * The name of the authorization list whose authority is used for the file. This is the or
    ? *
    ? * Preferred storage unit (UNIT).
     D upl                            1                                           40
    ? *
    ? * X'00'
    ? * The storage space and its members can be allocated on the available auxiliary storage u
    ? * X'01' through X'FF'
    ? * The unit identifier of an auxiliary storage unit on the system.
    ? *
    ? * Maximum members (MAXMBRS).
     D mxm                           05i 0                                        41
    ? *
    ? * 0
    ? * No maximum is specified; 32,767 is used (*NOMAX).
    ? * 1 through 32,767
    ? * The maximum number of members the file can have.
    ? *
    ? * Maximum file wait time (WAITFILE).
     D wtfi                          05i 0                                        43
    ? *
    ? * -1
    ? * The default wait time specified in the class description is used (*CLS).
    ? * 0
    ? * The program does not wait for the file; an immediate allocation is required (*IMMED).
    ? * 1 through 32,767
    ? * The number of seconds a program waits for the file.
    ? *
    ? * Records to force a write (FRCRATIO).
     D frt                           05i 0                                        45
    ? *
    ? * 0
    ? * There is force write ratio.
    ? * 1 through 32,767
    ? * The number of inserted, updated, or deleted records that are explicitly forced to stora
    ? *
    ? * Number of members, 0 through 32,767.
     D mnum                          05i 0                                        47
    ? * Reserved.
     D Reserved_11                    9                                           49
    ? * Maximum record wait time (WAITRCD).
     D brwt                          05i 0                                        58
    ? *
    ? * -2
    ? * The default wait time allowed by the system is used (*NOMAX).
    ? * -1
    ? * The program does not wait for the record, an immediate allocation is required (*IMMED).
    ? * 1 through 32,767
    ? * The number of seconds a program waits for the record.
    ? *
    ? * Additional attribute flags.
     D Qaaf                           1                                           60
    ? * Reserved
    ? * Program described file indicator. If on, the file is program described.
    ? * Total number of record formats, 1 through 32.
     D fmtnum                        05i 0                                        61
    ? * Additional attribute flags
     D fl2                            2                                           63
    ? * Access path journaled.
    ? * Reserved.
    ? * File capability/operation flags.
    ? * Allow read operation. If on, records are not allowed to be read from the file.
    ? * Allow write operation. If on, records are not allowed to be written to the file.
    ? * Allow update operation (ALWUPD). If on, records are not allowed to be updated in the fi
    ? * Allow delete operation (ALWDLT). If on, records are not allowed to be deleted from the
    ? * Reserved.
    ? * Null values cause duplicates indicator (UNIQUE). Only valid if Qdbfpact is equal to 'KU
    ? * First supported version release modification level. New database support is used in the
     D vrm                           05i 0                                        65
    ? *
    ? * X'0000'
    ? * Pre-Version 2 Release 1 Modification 0 file.
    ? * X'1500'
    ? * Version 2 Release 1 Modification 0 V2R1M0 file.
    ? * X'1501'
    ? * Version 2 Release 1 Modification 1 V2R1M1 file.
    ? * X'1600'
    ? * Version 2 Release 2 Modification 0 V2R2M0 file.
    ? * X'1700'
    ? * Version 2 Release 3 Modification 0 V2R3M0 file.
    ? * X'1F00'
    ? * Version 3 Release 1 Modification 0 V3R1M0 file.
    ? * X'2000'
    ? * Version 3 Release 2 Modification 0 V3R2M0 file.
    ? * X'2400'
    ? * Version 3 Release 6 Modification 0 V3R6M0 file.
    ? * X'2500'
    ? * Version 3 Release 7 Modification 0 V3R7M0 file.
    ? * X'2900'
    ? * Version 4 Release 1 Modification 0 V4R1M0 file.
    ? * X'2A00'
    ? * Version 4 Release 2 Modification 0 V4R2M0 file.
    ? * X'2B00'
    ? * Version 4 Release 3 Modification 0 V4R3M0 file.
    ? * X'2C00'
    ? * Version 4 Release 4 Modification 0 V4R4M0 file.
    ? *
    ? * Additional attribute flags.
     D Qaaf2                          2                                           67
    ? * Multiple coded character set identifier indicator (CCSID). If on, the file has more tha
    ? * Reserved.
    ? * Allow null value key indicator (ALWNULL). If on, null value keys are allowed.
    ? * Allow null value data (ALWNULL). If on, the file record format(s) allow null value fiel
    ? * Variable length data (VARLEN). If on, the file record format(s) contain variable length
    ? * Date/time/timestamp data. If on, the file record format(s) contain date, time, or times
    ? * Graphic data. If on, the file record formats contain graphic fields.
    ? * Primary key (*PRIKEY). If on, the access path for the file is a primary key.
    ? * Unique constraint (*UNQCST). If on, the access path for the file is a unique constraint
    ? * Reserved.
    ? * Access path size (ACCPTHSIZ). If on (*MAX1TB), all access paths associated with this fi
    ? * Distributed file. If on, the file is a distributed file.
    ? * Reserved.
    ? * Reserved.
    ? * Reserved.
    ? * File level identifier. The date of the file in internal standard format (ISF), CYYMMDDH
     D crt                           13                                           69
    ? * File text description.
    ?D*tx                            52
    ? * Reserved.
     D Reserved_18                    2                                           82
    ? * Text description (TEXT)
     D txt                           50                                           84
    ? * Reserved.
     D Reserved_19                   13                                           134
    ? * Source file fields. Must be hexadecimal zeros if there is no source file information.
    ?D*src                           30
    ? * Source file name.
     D srcf                          10                                           147
    ? * Source file member name.
     D srcm                          10                                           157
    ? * Source file library name.
     D srcl                          10                                           167
    ? * Access path recovery (RECOVER).
     D krcv                           1                                           177
    ? *
    ? * A
    ? * The file access path is built after the IPL is completed (*AFTIPL).
    ? * N
    ? * The file access path is built when the file is next opened (*NO).
    ? * S
    ? * The file access path is built during the IPL (*IPL).
    ? *
    ? * Reserved.
     D Reserved_20                   23                                           178
    ? * Coded character set identifier (CCSID) for text description.
     D tcid                          05i 0                                        201
    ? *
    ? * 0
    ? * There is no file text description.
    ? * 1 through 65,535
    ? * The file text description CCSID.
    ? *
    ? * Auxiliary storage pool (ASP).
     D asp                            2                                           203
    ? *
    ? * X'0000'
    ? * The file is located on the system auxiliary storage pool.
    ? * X'0002' through X'0010'
    ? * On which user auxiliary storage pool the file resides.
    ? *
    ? * Complex objects flags.
     D nbit                           1                                           205
    ? * If on, the file record format has a user-defined type field.
    ? * If on, the file record format has a large object field.
    ? * If on, the file record format has a datalink field. A datalink is a field data type tha
    ? * If on, the file uses a user-defined function.
    ? * If on, the file has a datalink field with FILE LINK CONTROL.
    ? * If on, the file is a logical file without any large object fields, but the based-on phy
    ? * If on, the file is a logical file without any datalink fields, but the based-on physica
    ? * Reserved.
    ? * Maximum number of fields, 1 through 8000. Indicates the number of fields in the file's
     D mxfnum                        05i 0                                        206
    ? * Reserved.
     D Reserved_22                   76                                           208
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the IDDU/SQL Data Dictionary are
     D odic                          10i 0                                        284
    ? * Reserved.
     D Reserved_23                   14                                           288
    ? * File generic key length, 0 through 2000. The length of the key before the first *NONE k
     D figl                          05i 0                                        302
    ? * Maximum record length, 1 through 32,766. The length of the record in the file's record
     D mxrl                          05i 0                                        304
    ? * Reserved.
     D Reserved_24                    8                                           306
    ? * File generic key field count, 0 through 120. The count of the number of key fields befo
     D gkct                          05i 0                                        314
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the file scope array, Qdbfb.
     D os                            10i 0                                        316
    ? * Reserved.
     D Reserved_25                    8                                           320
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the alternative collating sequen
     D ocs                           10i 0                                        328
    ? * Reserved.
     D Reserved_26                    4                                           332
    ? * Access path type.
     D pact                           2                                           336
    ? *
    ? * AR
    ? * Arrival sequence access path.
    ? * KC
    ? * Keyed sequence access path with duplicate keys allowed. Duplicate keys are accessed in
    ? * KF
    ? * Keyed sequence access path with duplicate keys allowed. Duplicate keys are accessed in
    ? * KL
    ? * Keyed sequence access path with duplicate keys allowed. Duplicate keys are accessed in
    ? * KN
    ? * Keyed sequence access path with duplicate keys allowed. No order is guaranteed when acc
    ? * KU
    ? * Keyed sequence access path with no duplicate keys allowed (UNIQUE).
    ? * EV
    ? * Encoded vector with a 1-, 2-, or 4-byte vector.
    ? *
    ? * File version, release, and modification level. VxRyMz, where x is the version, y the re
     D rls                            6                                           338
    ? * Reserved.
     D Reserved_27                   20                                           344
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the physical file specific attri
     D Qdbpfof                       10i 0                                        364
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the logical file specific attrib
     D Qdblfof                       10i 0                                        368
    ? * Sort sequence table.
    ?D*ssfp                           6
    ? * Flags.
     D nlsb                           1                                           372
    ? * Sort sequence table (SRTSEQ) indicators.
    ? *
    ? * B'000'
    ? * No sort sequence table for the file; however, an alternate collating sequence table was
    ? * B'010'
    ? * No sort sequence table is used for the file, and the hexadecimal value of the character
    ? * B'100'
    ? * A sort sequence table was specified for the file.
    ? *
    ? * Reserved.
    ? * Language identifier (LANGID).
     D lang                           3                                           373
    ? * Country or region identifier (CNTRYID).
     D cnty                           2                                           376
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the journal section, Qdb_Qdbfjoa
     D jorn                          10i 0                                        378
    ? * Initial number of distinct values an encoded vector access path was allowed at creation
     D evid                          10i 0                                        382
    ? * Reserved.
     D Reserved_28                   14                                           386
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Physical File Specific Attributes (Qdb_Qdbfphys)
    ? *
    ? * You can locate the Qdb_Qdbfphys section with the offset Qdbpfof, in the FDT header sect
    ? *
    ? * Description
     d phys            ds            48    based(pphys) qualified
    ? * Allocate/contiguous storage (ALLOCATE and CONTIG)
     D palc                           2                                           0
    ? *
    ? * DN
    ? * New members added to the file allow the system to determine storage space that is alloc
    ? * IC
    ? * New members added to file use the initial number of records to determine storage space
    ? * IN
    ? * New members added to file use the initial number of records to determine storage space
    ? *
    ? * Maximum percentage of deleted records allowed (DLTPCT).
     D cmps                           1                                           2
    ? *
    ? * X'00'
    ? * The number of deleted records is not checked when the member is closed (*NONE).
    ? * X'01' through X'64'
    ? * The largest percentage of deleted records the member should have.
    ? *
    ? * For partitioned tables, offset from the start of the FDT header, Qdb_Qdbfh, to the Part
     D off_sqpt                      10i 0                                        3
    ? * Reserved.
     D Reserved_29                    4                                           7
    ? * Initial number of records (SIZE).
     D prnum                         10i 0                                        11
    ? *
    ? * 0
    ? * The number of records that can be inserted into each member is not limited by the user.
    ? * 1 through 2,147,483,646
    ? * The number of records that can be inserted before an automatic extension occurs.
    ? *
    ? * Increment number of records (SIZE).
     D pri                           05i 0                                        15
    ? *
    ? * 0 through 32,767
    ? * The maximum number of records that can inserted into the member after an automatic exte
    ? *
    ? * Maximum number of increments (SIZE).
     D prinum                        05i 0                                        17
    ? *
    ? * 0 through 32,767
    ? * The maximum number of increments that can be automatically added to the member.
    ? *
    ? * Offset from the start of FDT header, Qdb_Qdbfh (Qdb_Qdbfh), to the Record ID Codes for
     D orid                          10i 0                                        19
    ? * Flags.
     D Qflags                         1                                           23
    ? * Reuse deleted records (RESUEDLT). If on, deleted member record space is reused by the s
    ? * Reserved.
    ? * SQL table indicator. If on, the file is a SQL table.
    ? * SQL materialized query table indicator. If on, the file is a SQL materialized query tab
    ? * Partitioned table indicator. If on, the file is a partitioned table.
    ? * Reserved.
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the trigger description area, Qd
     D otrg                          10i 0                                        24
    ? * Number of triggers.
     D trgn                          05i 0                                        28
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the constraint definition area,
     D ofcs                          10i 0                                        30
    ? * Number of constraints for the file.
     D cstn                          10i 0                                        34
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the datalinks area, Qdb_Qdbfdtal
     D odl                           10i 0                                        38
    ? * For SQL materialized query tables, offset from the start of the FDT header, Qdb_Qdbfh,
     D ovw_mqt                       10i 0                                        42
    ? * Reserved.
     D Reserved_32                    2                                           46
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Trigger Description Area (Qdb_Qdbftrg)
    ? *
    ? * You can locate the Qdb_Qdbftrg section with the offset Qdbfotrg in the Physical File Sp
    ? *
    ? * Description
     d trg             ds            24    based(ptrg ) qualified
    ? * Trigger time.
     D trgt                           1                                           0
    ? *
    ? * 1
    ? * Run the trigger after the change operation.
    ? * 2
    ? * Run the trigger before the operation.
    ? *
    ? * Trigger event.
     D trge                           1                                           1
    ? *
    ? * 1
    ? * An insert operation.
    ? * 2
    ? * A delete operation.
    ? * 3
    ? * An update operation.
    ? * 4
    ? * A read operation.
    ? *
    ? * Trigger program name.
     D tpgm                          10                                           2
    ? * Trigger program library name.
     D tplb                          10                                           12
    ? * Trigger update condition.
     D tupd                           1                                           22
    ? *
    ? * 1
    ? * Always call the trigger program when updating the file.
    ? * 2
    ? * Call the trigger program only when the updated values are changed.
    ? *
    ? * This field is ignored for insert and delete operations.
    ? * Trigger flags.
     D trgf                           1                                           23
    ? * Allow repeated change indicator. If on, repeated changes are allowed.
    ? * Trigger threadsafe indicator.
    ? *
    ? * B'00'
    ? * Not known.
    ? * B'10'
    ? * Not threadsafe.
    ? * B'11'
    ? * Threadsafe.
    ? *
    ? * Multithreaded job action indicator.
    ? *
    ? * B'01'
    ? * Run, send diagnostic.
    ? * B'10'
    ? * Do not run, send escape.
    ? * B'11'
    ? * Run, do not send message.
    ? *
    ? * QMLTTHDACN system value use. If on, the system value was used to determine Qdbftmta.
    ? * Whether more trigger information is available if format FILD0400 is requested.
    ? *
    ? * B'0'
    ? * No more trigger information is available.
    ? * B'1'
    ? * More trigger information is available.
    ? *
    ? * Reserved.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Constraint Definition Header (Qdb_Qdbf_Constraint)
    ? *
    ? * You can locate the Qdb_Qdbf_Constraint section with the offset Qdbfofcs located in the
    ? *
    ? * Description
     d constraint      ds           322    based(pconstraint) qualified
    ? * Offset from Qdbf_Constraint to the next section for this constraint.
     D  csto                         10i 0                                        0
    ? * Constraint entry header length in bytes.
     D  hlen                         10i 0                                        4
    ? * Constraint type (TYPE)
     D  type                          1                                           8
    ? *
    ? * F
    ? * Referential constraint
    ? * P
    ? * Primary unique constraint
    ? * U
    ? * Unique constraint.
    ? * C
    ? * Check constraint.
    ? *
    ? * Check pending attribute.
     D  chkpd                         1                                           9
    ? *
    ? * N
    ? * The constraint is not in check pending.
    ? * Y
    ? * The constraint is in check pending.
    ? *
    ? * Constraint state.
     D  state                         1                                           10
    ? *
    ? * D
    ? * The constraint is defined.
    ? * E
    ? * The constraint is established.
    ? *
    ? * Constraint enablement.
     D  abled                         1                                           11
    ? *
    ? * D
    ? * The constraint is disabled.
    ? * E
    ? * The constraint is enabled.
    ? *
    ? * Constraint date. The date is in the internal standard format (ISF), CYYMMDDHHMMSS.
     D  add_ts                       13                                           12
    ? * Constraint library name.
     D  cst_lin                      10                                           25
    ? * Constraint name (delimited) length
     D  cst_lp2                      10i 0                                        35
    ? * Reserved.
     D Reserved_54                   25                                           39
    ? * Constraint name (CST).
     D  cst_name                    258                                           64
    ? *
    ? *
    ? * Constraint Definition Entries
    ? *
    ? * The number of constraint definition entries depends on the type of constraint.
    ? *
    ? * A referential constraint, type F, has three structures in this sequence:
    ? *
    ? *
    ? *
    ? * 1. Qdbf_Keyn for parent file
    ? * 2. Qdbf_Keyn for dependent file
    ? * 3. Qdbf_Riafk_Afkd
    ? * A unique constraint, type U, has one Qdbf_Keyn structure.
    ? * A primary unique constraint, type P, has one Qdbf_Keyn structure.
    ? * A check constraint, type C, has one Qdbf_Chk_Cst structure.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Constraint Keys (Qdb_Qdbf_Keyn)
    ? *
    ? * The Qdb_Qdbf_Keyn section is located with the offset Qdbf_Hlen in the constraint defini
    ? *
    ? * Description
     d keyn            ds            64    based(pkeyn) qualified
    ? * Constraint key structure length. The length, in bytes, of this constraint key structure
     D  kslen                        10i 0                                        0
    ? * Number of keys, 1 through 120. The number of key fields for the constraint key.
     D  nokys                        10i 0                                        4
    ? * Constraint key length.
     D  klen                         10i 0                                        8
    ? * Reserved.
     D Revcst_7                      52                                           12
    ? * Key name array.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Key Name Array (Qdb_Qdbf_Narray)
    ? *
    ? * This array follows the constraint keys structure, Qdbf_Keyn. The number of constraint k
    ? *
    ? * Description
     d Narray          ds            32    based(pnarray) qualified
    ? * Key name (PRNKEY KEY)
     D  kname                        10                                           0
    ? * Reserved.
     D Revcst_6                      22                                           10
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Referential Constraint Definition (Qdb_Qdbf_Riafk_Afkd)
    ? *
    ? * You can locate this section with the offset Qdbf_kslen in the constraint keys structure
    ? *
    ? * Description
     d riafk           ds           128    based(priafk)  qualified
    ? * Parent file (PRNFILE).

    ? * Parent file name.
     D        pkfn                   10                                           0
    ? * Parent file library name.
     D        pkln                   10                                           10
    ? * Reserved.
     D Revcst_3                      44                                           20
    ? * Delete rule (DLTRULE).
     D        fkcdr                   1                                           64
    ? *
    ? * C
    ? * *CASCADE
    ? * D
    ? * *SETDFT
    ? * L
    ? * *SETNULL
    ? * N
    ? * *NOACTION (default value)
    ? * R
    ? * *RESTRICT
    ? *
    ? * Reserved
     D Revcst_4                       1                                           65
    ? * Update rule (UPDRULE)
     D        fkcur                   1                                           66
    ? *
    ? * N
    ? * *NOACTION (default value)
    ? * R
    ? * *RESTRICT
    ? *
    ? * Reserved.
     D Revcst_5                      61                                           67
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Check Constraint (Qdb_Qdbf_Chk_Cst)
    ? *
    ? * This section is located with the offset Qdbf_Hlen in the constraint definition header,
    ? *
    ? * Description
     d chkcst          ds          2032    based( pchkcst       ) qualified
    ? * Check constraint structure length. The length, in bytes, of the check constraint struct
     D  chkcst_len                   10i 0                                        0
    ? * Check constraint expression length. The length of the check constraint expression Qdbf_
     D  chkexpr_len                  10i 0                                        4
    ? * Reserved.
     D Revcst_8                      24                                           8
    ? * Check constraint expression. (len = 2000, cf QADBFCST)
     D  chkexpr                    2000                                            32
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Datalink Header (Qdb_Qdbfdtalnk)
    ? *
    ? * The Qdb_Qdbfdtalnk section is the header for the datalink columns that have linked serv
    ? *
    ? * Description
     d dtalnk          ds            32    based( pdtalnk       ) qualified
    ? * Number of datalink columns with links to servers.
     D dlcoln                        10i 0                                        0
    ? * Offset from the start of Qdb_Qdbfdtalnk to the first datalink column entry, (Qdb_Qdbfdl
     D dlocole                       10i 0                                        4
    ? * Link pending attribute. Link pending is a state that indicates to the user the file has
     D dllnkp                         1                                           8
    ? *
    ? * N
    ? * The file is not in link pending.
    ? * Y
    ? * The file is in link pending.
    ? *
    ? * Reserved.
     D Revdl_1                       23                                           9
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Datalink Column Entry (Qdb_Qdbfdlcole)
    ? *
    ? * The Qdb_Qdbfdlcole section repeats for the number of columns (Qdbfdlcoln) defined in st
    ? *
    ? * Description
     d dtalnkcom       ds                  based( pDtaLnkCom    ) qualified
    ? * Length of this datalink column entry. Use this length to get to the next datalink colum
     D dlcelen                       10i 0                                        0
    ? * Number of servers linked for this column.
     D dlsevn                        10i 0                                        4
    ? * Column name.
     D dlcolnm                       10                                           8
    ? * Reserved.
     D Revdl_2                       14                                           18
    ? * Array of server names linked to the datalink column. The number of array entries is def
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Record ID Codes (Qdb_Qdbfdrtb)
    ? *
    ? * The Qdb_Qdbfdrtb section describes the record ID codes for program described physical f
    ? *
    ? * Description
     d rtb             ds            16    based( prtb          ) qualified
    ? * Record ID code header.
     D
    ? * Number of record ID code array entries, 0 through 70.
     D drnum                         05i 0                                        0
    ? * Size of this record ID code table in bytes, 0 through 256.
     D drtl                          10i 0                                        2
    ? * Reserved.
     D Reserved_33                   10                                           6
    ? * Record ID code array entry.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Record ID Codes Array (Qdb_Qdbfdrae)
    ? *
    ? * This array follows the record ID codes structure, (Qdb_Qdbfdrtb). The number of record
    ? *
    ? * Description
     d rca             ds            32    based( prca          ) qualified
    ? * Reserved.
     D Reserved_34                    4                                           0
    ? * External name.
     D drnm                          10                                           4
    ? * Relative field position, 1 through 8000. The relative position of the field in the reco
     D drrp                          05i 0                                        14
    ? * Comparison operator.
     D drco                           2                                           16
    ? *
    ? * EQ
    ? * Compare equal.
    ? * NE
    ? * Compare not equal.
    ? * ZN
    ? * Compare zone.
    ? * NZ
    ? * Compare not zone.
    ? * DG
    ? * Compare digit.
    ? * ND
    ? * Compare not digit.
    ? *
    ? * Length of test value. Test value length must be 1.
     D drln                          05i 0                                        18
    ? * Test value.
     D drtv                           1                                           20
    ? * AND/OR/last operator.
     D drao                           1                                           21
    ? *
    ? * 0
    ? * Last operator entry.
    ? * 1
    ? * AND with next array entry.
    ? * 2
    ? * OR with next array entry.
    ? *
    ? * Reserved.
     D Reserved_35                   10                                           22
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Logical File Specific Attributes (Qdb_Qdbflogl)
    ? *
    ? * You can locate the Qdb_Qdbflogl section with the offset Qdbflfof located in the FDT hea
    ? *
    ? * Description
     d logl            ds            50    based( plogl         ) qualified
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the join specifications, Qdbfj.
     D oj                            10i 0                                        0
    ? * Total number of select/omit statements for all record formats, 1 through 32,767.
     D scsn                          05i 0                                        4
    ? * Record format selector program (FMTSLR)
     D lxp                           10                                           6
    ? *
    ? * X'00'
    ? * No record format selector program (*NONE).
    ? *
    ? * Record format selector program library (FMTSLR)
     D lxl                           10                                           16
    ? *
    ? * X'00'
    ? * No record format selector program (*NONE).
    ? *
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the SQL area, Qdb_Qdbfv.
     D ovw                           10i 0                                        26
    ? * Logical file attributes
     D Qlfa                           1                                           30
    ? * Reserved.
    ? * Join logical file indicator (JFILE). If on, the file is a join logical file.
    ? * Dynamic selection indicator (DYNSLT). If on, the selection and omission tests specified
    ? * SQL view indicator. If on, the file is an SQL view.
    ? * SQL index indicator. If on, the file is an SQL index.
    ? * Reserved.
    ? * Join file type.
     D jtyp                           1                                           31
    ? *
    ? * I
    ? * An inner join. Default entries are not supplied if a join value does not exist.
    ? * P
    ? * A partial outer join. Default values are supplied if a join value does not exist.
    ? *
    ? * Coded character set identifier (CCSID) for select/omit constants.
     D srcd                          05i 0                                        32
    ? *
    ? * 0
    ? * There are no select/omit constants for the file.
    ? * 1 through 65,535
    ? * The CCSID.
    ? *
    ? * With check option.
     D wchk                           1                                           34
    ? *
    ? * C
    ? * The with-check option was specified with cascade.
    ? * L
    ? * The with-check option was specified with local.
    ? * N
    ? * No with-check option was specified.
    ? *
    ? * The value N is set for all logical files. The values C and L only apply to SQL views.
    ? * Reserved.
     D Reserved_38                   13                                           35
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Join Specifications (Qdb_Qdbfj)
    ? *
    ? * The join specifications, Qdb_Qdbfj, are a linked list. There is an entry in the linked
    ? *
    ? * You can locate this section with the offset Qdbfoj located in the FDT header section, Q
    ? *
    ? * Description
     d js              ds            48    based( pjs           ) qualified
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the join specifications, Qdbfj,
     D jnho                          10i 0                                        0
    ? * Reserved.
     D Reserved_40                    4                                           4
    ? * Number of join field specifications (JFLD), 1 through 32,767.
     D jknum                         05i 0                                        8
    ? * Number of join duplicate sequence specifications (JDUPSEQ), 1 through 32,767.
     D jdnum                         05i 0                                        10
    ? * Join from-file number (JOIN), 1 through 255. This number indicates which based on physi
     D jffnum                        05i 0                                        12
    ? * Join to-file number (JOIN), 2 through 256. This number indicates which based on physica
     D jtfnum                        05i 0                                        14
    ? * Reserved.
     D Reserved_41                   24                                           16
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the join specification array, Qd
     D jsao                          10i 0                                        40
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the join duplicate sequence arra
     D jdao                          10i 0                                        44
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Join Specification Array (Qdb_Qdbfjfld)
    ? *
    ? * You can locate the Qdb_Qdbfjfld section with the offset Qdbfjsao located in the join he
    ? *
    ? * Description
     d jfld            ds            48    based( pjfld         ) qualified
    ? * Join from-field-name (JFLD)
     D jfnm                          10                                           0
    ? * Join from-field reference number.
     D jfnum                         05i 0                                        10
    ? *
    ? * 0
    ? * Join from-field is a field in the join logical file's record format.
    ? * 1 through
    ? * 255
    ? *
    ? * The number of the base on physical from-file corresponding with its position in the JFI
    ? *
    ? * Reserved.
     D Reserved_42                    2                                           12
    ? * Join operation. This is always set to 'EQ'.
     D jop                            2                                           14
    ? * Join to-field name (JFLD).
     D jtnm                          10                                           16
    ? * Join to-field reference number.
     D jtnum                         05i 0                                        26
    ? *
    ? * 0
    ? * The join to-field is a field in the logical file's record format.
    ? * 2 through
    ? * 256
    ? *
    ? * The number of the based on physical to-file corresponding with its position in the JFIL
    ? *
    ? * Reserved.
     D Reserved_43                   20                                           28
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Join Duplicate Sequence Specification Array (Qdb_Qdbfjdup)
    ? *
    ? * You can locate the Qdb_Qdbfjdup section with the offset Qdbfjdao in the join section, Q
    ? *
    ? * Description
     d jdup            ds            32    based( pjdup         ) qualified
    ? * Join specification field name (JDUPSEQ).
     D jdnm                          10                                           0
    ? * Join sequence field name reference number.
     D jdjnum                        05i 0                                        10
    ? *
    ? * 0
    ? * The join sequencing field name is a file in the join logical file's record format.
    ? * 2 through
    ? * 256
    ? *
    ? * The number of the based on physical to-file corresponding with its position in the JFIL
    ? *
    ? * Join sequencing field name attributes.
     D Qjsfna                         1                                           12
    ? * Ascending/descending sequence indicator. If on, indicates a descending field (*DESCEND)
    ? * Reserved.
    ? * Reserved.
     D Reserved_45                   19                                           13
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * SQL Area (Qdb_Qdbfv)
    ? *
    ? * The SQL area, Qdb_Qdbfv, contains the SQL select statement. For logical files, you can
    ? *
    ? *
    ? * Description
     d sqla            ds         10060    based( psqla         ) qualified
    ? * SQL area header.
     D
    ? * Reserved.
     D Reserved_39                   16                                           0
    ? * Starting offset of the SELECT statement within the CREATE TABLE statement.
     D vs_start                      10i 0                                        16
    ? * Ending offset of the SELECT statement within the CREATE TABLE statement.
     D vs_end                        10i 0                                        20
    ? * Coded Character Set Identifier, CCSID, for the Select Statement. Views created prior to
     D vs_ccsid                      05i 0                                        24
    ? * For SQL materialized query tables, offset from the start of the FDT header, Qdb_Qdbfh,
     D mqtd_o                        10i 0                                        26
    ? * The isolation level in effect for the SQL materialized query table:
     D mqt_cmt                        2                                           30
    ? *
    ? * NC
    ? * *NONE no isolation
    ? * UR
    ? * *CHG uncommitted read.
    ? * CS
    ? * *CS cursor stability
    ? * CL
    ? * *CS with keep locks
    ? * RS
    ? * *ALL read stability
    ? * RR
    ? * *RR repeatable read
    ? *
    ? * Flags.
     D vflgs                          1                                           32
    ? * SQL materialized query table initial data. If on, data is inserted into the table immed
    ? * SQL materialized query table maintenance. If on, table is user-maintained.
    ? * SQL materialized query table refresh. If off, table is refresh-deferred.
    ? * SQL materialized query table optimization. If on, table is disabled for optimization. I
    ? * Reserved.
    ? * Reserved.
     D Reserved_89                   23                                           33
    ? * SQL select statement structure
    ? * Select statement length.
     D vssl                          10i 0                                        56
    ? * SQL select statement.     cf QADBXREF
     D vsst                       10000                                            60
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * SQL Materialized Query Table Dependency Header (Qdb_Qdbfmqtd_Head)
    ? *
    ? * The Qdb_Qdbfmqtd_Head section is located with the offset Qdbfmqtd_o in the SQL area, Qd
    ? *
    ? * Description                  64
     d mqtdh           ds                  based( pmqtdh        ) qualified
    ? * Total length, in bytes, of the dependency area. This includes both the dependency heade
     D mqtd_len_sum                  10i 0                                        0
    ? * Number of file entries in the dependency array.
     D mqtd___deps                   10i 0                                        4
    ? * Reserved.
     D Reserved_16                   56                                           8
    ? * Dependency array, Qdb_Qdbfmqtd, for this SQL materialized query table.
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * SQL Materialized Query Table Dependency Entry (Qdb_Qdbfmqtd)
    ? *
    ? * The Qdb_Qdbfmqtd section repeats in the dependency array for the number of depended-on
    ? *
    ? * Description
     d mqtde           ds            96    based( pmqtde        ) qualified
    ? * Reserved.
     D Reserved_117                  16                                           0
    ? * Length, in bytes, of this dependency entry. Use this length to get to the next dependen
     D mqtd_len                      10i 0                                        16
    ? * Name of the file that the materialized query table is dependent on. The file is specifi
     D mqtd_file                     10                                           20
    ? * Name of the library that the depended-on file resides in.
     D mqtd_lib                      10                                           30
    ? * Reserved.
     D Reserved_116                  56                                           40
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Partitioned Table Header (Qdb_Qdbfsqpt_Head)
    ? *
    ? * The Qdb_Qdbfsqpt_Head section is located with the offset Qdbfoff_sqpt. This structure e
    ? *
    ? * Description
     d pth             ds           352    based( pPth          ) qualified
    ? * Total length, in bytes, of the header area. This includes all the partition areas and p
     D      Len_Sum                  10i 0                                        0
    ? * Reserved.
     D Sql_Reserved4                  4                                           4
    ? * Partitioning is range or hash.
     D      Ran_Hh                    1                                           8
    ? *
    ? * R
    ? * Range Partitioning
    ? * H
    ? * Hash Partitioning
    ? *
    ? * Field has long field name.
     D      Lfld                      1                                           9
    ? *
    ? * Y
    ? * Field has a long name.
    ? * N
    ? * Field does not have a long name.
    ? *
    ? * Reserved.
     D   Reserved230                230                                           10
    ? * Number of file partitions.
     D sqpt_Num_Parts                10i 0                                        240
    ? * The offset to the first partition. This is from the start of the Partitioned Table Head
     D   Part_Offset                 10i 0                                        244
    ? * The offset to the hash key area. This offset is only set if hash partitioning is being
     D      Hk_Offset                10i 0                                        248
    ? * Reserved.
     D Reserved_100                 100                                           252
    ? * Partitioned area, Qdb_Qdbfsqpt_Part, for this partitioned table and partition hash key
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? * Partitioned Area (Qdb_Qdbfsqpt_Part)
    ? *
    ? * The Qdb_Qdbfsqpt_Part section is located with the offset Qdbfsqpt_Part_Offset. This str
    ? *
    ? * Description
     d ptar            ds           240    based( pPtar         ) qualified
    ? * Total length, in bytes, of this partition area. This includes all other partition key a
     D           Len                 10i 0                                        0
    ? * Partition data space number.
     D           DSN                 10i 0                                        4
    ? * Partition number.
     D           Num                 10i 0                                        8
    ? * The length of the partition name.
     D      Pname_Len                10i 0                                        12
    ? * The partition name.
     D      Pname                   128                                           16
    ? * Reserved.
     D  Reserved80                   80                                           144
    ? * The number of partition range keys.
     D Num_Keys                      10i 0                                        224
    ? * The offset to the first partition range key area for this partition. If hash partitioni
     D Range_Offset                  10i 0                                        228
    ? * Reserved.
     D Reserved_8                     8                                           232
    ? * Partition range key area Qdb_Qdbfsqpt_Range, for this partitioned table. This entry rep
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? * Partition Range Key Area (Qdb_Qdbfsqpt_Range)
    ? *
    ? * The Qdb_Qdbfsqpt_Range section is located with the offset Qdbfsqpt_Ran_Offset. This str
    ? *
    ? * Description
     d prka            ds            80    based( pprka         ) qualified
    ? * Total length, in bytes, of this partition range key area.
     D      Range_Len                10i 0                                        0
    ? * Reserved.
     D Reserved12                    12                                           4
    ? * Partition range key name.
     D sqpt_Range_Key                10                                           16
    ? * Reserved.
     D Range_Reserved                05i 0                                        26
    ? * Partition range key start value minimum.
     D sqpt_Rmin                      1                                           28
    ? *
    ? * Y
    ? * Yes
    ? * N
    ? * No
    ? *
    ? * Partition range key end value maximum.
     D      Rmax                      1                                           29
    ? *
    ? * Y
    ? * Yes
    ? * N
    ? * No
    ? *
    ? * Partition range key start value inclusive.
     D      Rsin                      1                                           30
    ? *
    ? * Y
    ? * Yes
    ? * N
    ? * No
    ? *
    ? * Partition range key end value inclusive.
     D      Rein                      1                                           31
    ? *
    ? * Y
    ? * Yes
    ? * N
    ? * No
    ? *
    ? * Reserved.
     D reserved15                    15                                           32
    ? * Partition range key value can include nulls.
     D Rnull                          1                                           47
    ? *
    ? * Y
    ? * Yes
    ? * N
    ? * No
    ? *
    ? * Length in bytes of the starting partition range key value string.
     D      Rslen                    10i 0                                        48
    ? * Length in bytes of the ending partition range key value string.
     D sqpt_Relen                    10i 0                                        52
    ? * The offset to the starting partition range key value string. This is from the start of
     D Rstart_Offset                 10i 0                                        56
    ? * The offset to the ending partition range key value string. This is from the start of Qd
     D Rend_Offset                   10i 0                                        60
    ? * Reserved.
     D Reserved14                    14                                           64
    ? * Coded character set identifier (CCSID) for the start and end strings.
     D sqpt_Rccsid                   05i 0                                        78
    ? * Start value string and end value string for this partition range key.
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? * Partition Header Hash Key Area (Qdb_Qdbfsqpt_Head_Hash)
    ? *
    ? * The Qdb_Qdbfsqpt_Head_Hash is the header area for the hash keys. It is located with the
    ? *
    ? * Description
     d phhka           ds                  based( pphhka        ) qualified
    ? * Length, in bytes, of the partition header hash key area.This includes the total length
     D Head_Hash_Len                 10i 0                                        0
    ? * Total number of hash keys.
     D Head_Num_Keys                 10i 0                                        4
    ? * Reserved.
     D Reserved_56                   56                                           8
    ? * Key name array.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? *
    ? * Partition Hash Key Area (Qdb_Qdbfsqpt_Hash)
    ? *
    ? * The Qdb_Qdbfsqpt_Hash section repeats for the number of partition hash keys,Qdbfsqpt_He
    ? *
    ? * Description
     d phka            ds                  based( pphka         ) qualified
    ? * Partition hash key name.
     D      Hash_Key                 10                                           0
    ? * Reserved.
     D Reserved_22                   22                                           10
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Alternative Collating Sequence Table (Qdb_Qdbfacs)
    ? *
    ? * You can locate this section with the offset Qdbfocs in the FDT header section, Qdb_Qdbf
    ? *
    ? * Description
     d acs             ds           304    based( pacs          ) qualified
    ? * Alternative collating sequence table or single-byte sort sequence (ALTSEQ/STRSEQ) table
     D acst                         256                                           0
    ? * Coded character set identifier (CCSID) for the single-byte table.
     D ccsd                          05i 0                                        256
    ? * Sort sequence table.
    ?D*srts                          20
    ? * Sort sequence table name.
     D tbln                          10                                           258
    ? * Sort sequence table library name.
     D tbll                          10                                           268
    ? * Sort sequence table attributes.
     D srtf                           1                                           278
    ? * Sort sequence table weight indicator for the single-byte table. If on, indicates the so
    ? * Sort sequence table substitution character indicator for the single-byte table. If on,
    ? * Sort sequence table weight indicator for the UCS-2 table. If on, indicates the sort seq
    ? * Reserved.
    ? * Length of the UCS-2 sort sequence table, Qdbf_UCS2_Srtseq, in bytes.
     D  UCS2_len                     10i 0                                        279
    ? *
    ? *
    ? *
    ? * Coded character set identifier (CCSID) for the UCS-2 table.
     D  UCS2_ccsid                   05i 0                                        283
    ? * Reserved.
     D Reserved_101                  19                                           285
    ? * UCS-2 sort sequence table. The table exists if the length, Qdbf_UCS2_Srtseq_Len, is gre
    ?D* UCS2                           *                                           304
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? *
    ? *
    ? *
    ? * IDDU/SQL Data Dictionary Area (Qdb_Qdbfdic)
    ? *
    ? * You can locate the Qdb_Qdbfdic section with offset Qdbfodic in the FDT header section,
    ? *
    ? * Description
     d dic             ds          2128    based( pdic          ) qualified
    ? * Data dictionary link status.
     D dilk                           1                                           0
    ? *
    ? * L
    ? * The file is linked to the a data dictionary.
    ? * U
    ? * The file is not linked to the a data dictionary.
    ? *
    ? * Data dictionary library name.
     D inm                           10                                           1
    ? * Data dictionary file definition name.
     D ifd                           10                                           11
    ? * Data dictionary internal file definition identifier. This field maps to ZONED(11,0).
     D diid                          11                                           21
    ? * Reserved.
     D Reserved_46                    4                                           32
    ? * Data dictionary file definition comment length.
     D dicl                          10i 0                                        36
    ? * Data dictionary file definition comment CCSID.
     D dicc                          05i 0                                        40
    ? *
    ? * 0
    ? * There is no comment for the file.
    ? * 1 through 65,535
    ? * The CCSID of the comment.
    ? *
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the SQL long/alias file names ar
     D olng                          10i 0                                        42
    ? * Number of long/alias file names for the file.
     D lnnum                         05i 0                                        46
    ? * Reserved.
     D Reserved_47                   16                                           48
    ? * Data dictionary file definition comment text.
     D dict                        2000                                            64
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * SQL Long/Alias File Name Area (Qdb_Qdbflngn)
    ? *
    ? * The SQL long/alias file name area contains the files alternate names that can be used t
     d alias           ds           144    based( palias        ) qualified
    ? * Description
    ? * Long/alias file name entry length in bytes. The length of this entry. This is also the
     D lnel                          05i 0                                        0
    ? * Long/alias file name flags.
     D lnfl                           1                                           2
    ? * Long/alias file name input delimited indicator. If on, indicates the long/alias file na
    ? * Reserved
    ? * Long/alias file name (non-delimited) length.
     D lnlg                          05i 0                                        3
    ? * Reserved.
     D Reserved_112                  11                                           5
    ? * Long/alias file name (non-delimited).
     D lnam                         128                                            16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * File Scope Array (Qdb_Qdbfb)
    ? *
    ? * A file scope array, Qdb_Qdbfb, is present for all database files. The number of data me
    ? *
    ? * Externally described physical files have one entry that names the physical file record
    ? *
    ? * Program described physical files have one entry for each data dictionary record format.
    ? *
    ? * Non-join logical files have one entry for each based on physical file. The entry names
    ? *
    ? * Join logical files have one entry for each based on physical file. The entry names the
    ? *
    ? * SQL view logical files have one entry for each based on physical file. The entry names
    ? *
    ? * You can locate this section with the offset Qdbfos in the FDT header section, Qdb_Qdbfh
    ? *
    ? * Description
     d fsa             ds           160    based( pfsa          ) qualified
    ? * Reserved.
     D Reserved_48                   48                                           0
    ? * Based on physical file name.
     D bf                            10                                           48
    ? * Based on physical file library name.
     D bfl                           10                                           58
    ? * Record format name.
     D t                             10                                           68
    ? * Reserved.
     D Reserved_49                   37                                           78
    ? * Record format generic key field count, 0 through 120. If this file has an arrival seque
     D bgky                          05i 0                                        115
    ? * Reserved.
     D Reserved_50                    2                                           117
    ? * Record format maximum key length, 1 through 2000. If this file has an arrival sequence
     D blky                          05i 0                                        119
    ? * Reserved.
     D Reserved_51                    2                                           121
    ? * Record format generic key length, 1 through 2000. If this file has an arrival sequence
     D fogl                          05i 0                                        123
    ? * Reserved.
     D Reserved_52                    3                                           125
    ? * Number of select/omit statements, 1 through 32,767.
     D soon                          05i 0                                        128
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the select/omit specification ar
     D soof                          10i 0                                        130
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the key specification array, Qdb
     D ksof                          10i 0                                        134
    ? * Record format full key field count, 0 through 120. If this file has an arrival sequence
     D kyct                          05i 0                                        138
    ? * Generic key field count for all record formats with this record format name, 0 through
     D genf                          05i 0                                        140
    ? * Offset from the start of the FDT header, Qdb_Qdbfh to the distributed file definition s
     D odis                          10i 0                                        142
    ? * Reserved.
     D Reserved_53                   14                                           146
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Select/Omit Specification Array (Qdb_Qdbfss)
    ? *
    ? * The select/omit specification array ( Qdb_Qdbfss) entries describe the record format fi
    ? *
    ? * Non-join logical files can have one select/omit specification array for each file scope
    ? *
    ? * Join logical files can have only one select/omit specification array. The first scope a
    ? *
    ? * You can locate this section with the offset Qdbfsoof in the scope array entry section.
    ? *
    ? * Description
     d sosa            ds            32    based( psosa         ) qualified
    ? * Reserved.
     D Reserved_54                    2                                           0
    ? * Select/omit statement rule.
     D ssso                           1                                           2
    ? *
    ? * A
    ? * A select/omit ANDed statement.
    ? * O
    ? * A select/omit omit statement.
    ? * S
    ? * A select/omit select statement.
    ? *
    ? * Select/omit statement comparison (ALL COMP VALUES)
     D ssop                           2                                           3
    ? *
    ? * AL
    ? * Statement comparison for all (ALL).
    ? * EQ
    ? * Statement comparison for equal to (COMP EQ).
    ? * GE
    ? * Statement comparison for greater than or equal to (COMP GE).
    ? * GT
    ? * Statement comparison for greater than (COMP GT).
    ? * LE
    ? * Statement comparison for less or equal to (COMP LE).
    ? * LT
    ? * Statement comparison for less than (COMP LT).
    ? * NE
    ? * Statement comparison for not equal to (COMP NE).
    ? * NG
    ? * Statement comparison for not greater than (COMP NG).
    ? * NL
    ? * Statement comparison for not less than (COMP NL).
    ? * VA
    ? * Statement comparison for values (VALUES).
    ? *
    ? * Select/omit statement field name.
     D ssfn                          10                                           5
    ? * Number of select/omit statement parameters, 1 through 32,767.
     D sspnum                        05i 0                                        15
    ? * Select/omit statement attribute flags.
     D Qsosaf                         1                                           17
    ? * Reserved.
    ? * Select/omit statement external or internal name indicator. If on, indicates the stateme
    ? * Select/omit statement join reference number (JREF), 1 through 256. If this is not a joi
     D ssfj                          05i 0                                        18
    ? * Reserved.
     D Reserved_56                    8                                           20
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the select/omit parameters, Qdb_
     D soso                          10i 0                                        28
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Select/Omit Parameters (Qdb_Qdbfsp)
    ? *
    ? * The Qdb_Qdbfsp section is a linked list of parameter descriptions. It describes the par
    ? *
    ? * You can locate this section with the offset Qdbfsoso in the select/omit array section,
    ? *
    ? * Description
     d sop             ds                  based( psop          ) qualified
    ? * Offset from the start of the FDT header, Qdb_Qdbfh, to the next select/omit parameter f
     D spno                          10i 0                                        0
    ? * Select/omit parameter length, 1 through 32,767.
     D spln                          05i 0                                        4
    ? * Select/omit parameter attribute indicator.
     D spin                           1                                           6
    ? *
    ? * X'00'
    ? * The parameter is a compare value.
    ? * X'01'
    ? * The parameter is a internal record format field.
    ? * X'02'
    ? * The parameter is an external record format field.
    ? *
    ? * Select/omit attribute flags.
     D Qasopaf                        1                                           7
    ? * Double-byte character set (DBCS) and/or graphic data indicator. If on, indicates the no
    ? * Hexadecimal data indicator. If on, indicates the non-field compare value is hexadecimal
    ? * Null value indicator. If on, indicates the non-field compare value is the null value.
    ? * Reserved.
    ? * Select/omit parameter join reference number (JREF), 1 through 256. This field is not ap
     D sppj                          05i 0                                        8
    ? * Reserved.
     D Reserved_58                   10                                           10
    ? * Select/omit parameter compare value or the record format field name. This is the compar
     D spvl                         128                                            20
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Key Specification Array (Qdb_Qdbfk)
    ? *
    ? * The key specification array (Qdb_Qdbfk) entries describe the record format fields used
    ? *
    ? * Non-join logical files can have one key specification array for each file scope array e
    ? *
    ? * Join logical files can have only one key specification array. The first scope array ent
    ? *
    ? * You can locate this section with the offset (Qdbfksof) in the scope array entry section
    ? *
    ? * Description
     d ksa             ds            32    based( pksa          ) qualified
    ? * Key statement field name. X'40's indicate the key statement is a *NONE key field.
     D kfld                          10                                           0
    ? * Reserved.
     D Reserved_59                    3                                           10
    ? * Key statement sequencing attribute flags.
     D ksq                            1                                           13
    ? * Ascending/descending sequence indicator. If on, indicates the descending sequence (*DES
    ? * Numeric key field sequencing indicators.
    ? *
    ? * B'00'
    ? * The numeric key field sequences as a string of unsigned binary data (UNSIGNED).
    ? * B'01'
    ? * The numeric key field ignores the sign of the field and sequences as absolute value dat
    ? * B'10'
    ? * The numeric key field considers the sign of the field and sequences as signed value dat
    ? *
    ? * Reserved.
    ? * Alternate collating sequence indicator (ALTSEQ). If on, indicates the alternate collati
    ? * Force zone sequencing indicator. If on, indicates the zone portion of the key field is
    ? * Force digit sequencing indicator. If on, indicates the digit portion of the key field i
    ? * Key statement external or internal name indicator. If on, indicates the field name is t
    ? * Reserved.
     D Reserved_61                   18                                           14
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Distributed File Definition Section and Partition Key Array (Qdb_Qdbf_dis_pkeyarr)
    ? *
    ? * The distributed file definition section and partition key array (Qdb_Qdbf_dis_pkeyarr)
    ? *
    ? * You can locate this section with the offset Qdbfodis in the scope array entry section,
    ? *
    ? * Description
     d df              ds            96    based( pdf           ) qualified
    ? * Distributed file node group name.
     D       ndgpn                   10                                           0
    ? * Distributed file node group library name.
     D       ndgpl                   10                                           10
    ? * Number of partition key fields for this scope entry.
     D       nkyn                    10i 0                                        20
    ? * Reserved.
     D Reserved_121                  40                                           24
    ? * Distributed file partition key array.
    ? * Partition key field name.
     D      kname                    10                                           64
    ? * Reserved.
     D Reserved_122                  22                                           74
    ? *=-----------------------------------------------------------------------------------------=*
    ? * Partition key field name.
     d pka             ds            32    based( ppka          ) qualified
     D      kname                    10                                           64
    ? * Reserved.
     D Reserved_122                  22                                           74
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Journal Information (Qdb_Qdbfjoal)
    ? *
    ? * The section Qdb_Qdbfjoal contains the journal information for the physical file. You ca
    ? *
    ? * Description
     d joal            ds            64    based( pjoal         ) qualified
    ? * Journal name.
     D ojrn                          10                                           0
    ? * Journal library name.
     D olib                          10                                           10
    ? * Journaling options.
     D ojpt                           1                                           20
    ? * Reserved.
    ? * Before image indicator. If on, indicates the before images are being journaled.
    ? * After image indicator. If on, indicates the after images are being journaled.
    ? * Reserved.
    ? * Omit journal entries indicator. If on, indicates the open and close entries are being o
    ? * Reserved.
    ? * Journaling options.
     D jact                           1                                           21
    ? *
    ? * 0
    ? * The file is not being journaled.
    ? * 1
    ? * The file is being journaled.
    ? *
    ? * Last journaling date stamp. This is the date that corresponds to the most recent time t
     D ljrn                          13                                           22
    ? * Reserved.
     D Reserved_105                  29                                           35
    ? *
    ? *
    ? * FILD0200 Format (Qdb_Qddfmt Structure)
    ? *
    ? * FILD0200 provides the format used by the records of the specified file. This structure
    ? *
    ? * The descriptions and offsets are available in the include source supplied on the system
    ? *
    ? * FILD0200 Format
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? *
    ? *
    ? *
    ? * Format Definition Header (Qdb_Qddfmt)
    ? *
    ? * The Qdb_Qddfmt section is always located at the beginning of the returned data area.
    ? *
    ? * Description
     d format          ds           256    based( pformat       ) qualified
    ? * Bytes returned. The total length, in bytes, of the data returned.
     D    byrtn                      10i 0                                        0
    ? * Bytes available. The total length, in bytes, of the format.
     D    byava                      10i 0                                        4
    ? * Reserved.
     D Reserved_62                   24                                           8
    ? * Record format DBCS flags.
     D    fmtf                        1                                           32
    ? * Double byte character set and/or graphic data. If on, indicates the format contains DBC
    ? * Double byte character set and/or graphic literals. If on, indicates the format contains
    ? * Double byte character set record format text description. If on, indicates the text des
    ? * Mapping error possible. If on, indicates the format contains fields that may return map
    ? * Derived fields (logical files only). If on, indicates the format contains fields derive
    ? * Neither or input-only files (logical files only). If on, indicates the format contains
    ? * Default values (physical files only). If on, indicates the format contains fields with
    ? * Concatenated fields (logical files only). If on, indicates the format contains fields t
    ? * Offset from the start of the Qdb_Qddfmt header to the translate table specifications, Q
     D     xlto                      10i 0                                        33
    ? * Offset from the start of the Qdb_Qddfmt header to the case selection specifications, Qd
     D     rcao                      10i 0                                        37
    ? * Offset from the start of the Qdb_Qddfmt header to the IDDU/SQL dictionary format inform
     D     dico                      10i 0                                        41
    ? * Common coded character set identifier. Before using this field, see if Qddfrsid is zero
     D     rcid                      05i 0                                        45
    ? * Source file coded character set identifier. The CCSID for the character portion of the
     D     srcd                      05i 0                                        47
    ? * Format text coded character set identifier. The CCSID for the information about the tex
     D     rtcd                      05i 0                                        49
    ? * Long comment coded character set identifier. The CCSID for the information about the fo
     D     rlcd                      05i 0                                        51
    ? * Reserved.
     D Reserved_64                    7                                           53
    ? * Format flags.
     D     tflgs                      1                                           60
    ? * Reserved.
    ? * If on, the format contains UCS-2 fields.
    ? * If on, the format contains datalink fields.
    ? * If on, the format contains user-defined type fields.
    ? * If on, the format contains large object fields.
    ? * If on, the format contains a UTF-8 or UTF-16 field.
    ? * Reserved.
    ? * Flags
     D    flgs                        1                                           61
    ? * Reserved.
    ? * Variable length fields. If on, indicates the format contains variable length fields (VA
    ? * Graphic fields. If on, indicates the format contains graphic data fields.
    ? * Date, time, or timestamp fields. If on, indicates the format contains data, time, or ti
    ? * Null capable fields. If on, indicates the format contains null capable fields.
    ? * Common coded character set identifier flag. If on, indicates all character fields use t
    ? * Explicit coded character set identifier flag. If on, indicates a CCSID was specified fo
    ? * Reserved.
    ? * Reserved.
     D Reserved_67                    4                                           62
    ? * Record length. The sum of the lengths of all format fields excluding neither fields.
     D     rlen                      10i 0                                        66
    ? * Record format name.
     D     name                      10                                           70
    ? * Level identifier. The modification level identifier of the format, used to verity the f
     D     seq                       13                                           80
    ? * Text description (TEXT)
     D     text                      50                                           93
    ? * Number of fields. The number of fields in the format. There is one field header for eac
     D     fldnum                    05i 0                                        143
    ? * Offset from the start of the Format header to the identity information, Qddfidcl
     D  Identity_Off                 10i 0                                        145
     d  reserved_68                 107                                           149
    ? * Start of field definition array (Qdb_Qddffld).
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Field Header (Qdb_Qddffld)
    ? *
    ? * This section is located immediately after the Qdb_Qddfmt header. The number of entries
    ? *
    ? * Description
     d field           ds           252    based( pfield        ) qualified
    ? * Length of field header structure. The length of each occurrence of the field header str
     D     defl                      10i 0                                        0
    ? * Internal field name. The name of the physical format field. If this is a logical format
     D     fldi                      30                                           4
    ? * External field name. If this is a logical format, the logical format field name. If thi
     D     flde                      30                                           34
    ? * Data type.
     D     ftyp                       2                                           64
    ? *
    ? * X'0000'
    ? * BINARY
    ? * X'0001'
    ? * FLOAT
    ? * X'0002'
    ? * ZONED DECIMAL
    ? * X'0003'
    ? * PACKED DECIMAL
    ? * X'0004'
    ? * CHARACTER
    ? * X'8004'
    ? * VAR CHARACTER
    ? * X'0005'
    ? * GRAPHIC
    ? * X'8005'
    ? * VAR GRAPHIC
    ? * X'0006'
    ? * DBCS-CAPABLE
    ? * X'8006'
    ? * VAR DBCS-CAPABLE
    ? * X'000B'
    ? * DATE
    ? * X'000C'
    ? * TIME
    ? * X'000D'
    ? * TIMESTAMP
    ? * X'4004'
    ? * BLOB/CLOB
    ? * X'4005'
    ? * DBCLOB
    ? * X'4006'
    ? * CLOB-OPEN
    ? * X'8044'
    ? * DATALINK-CHAR
    ? * X'8046'
    ? * DATALINK-OPEN
    ? * X'FFFF'
    ? * NULL
    ? *
    ? * Usage
     D      iob                       1                                           66
    ? *
    ? * X'01'
    ? * The field can be used for input only.
    ? * X'02'
    ? * Output only.
    ? * X'03'
    ? * Both input and output.
    ? * X'04'
    ? * Neither input nor output.
    ? * X'FF'
    ? * The usage is unknown.
    ? *
    ? * Output buffer offset. The offset of this field from the start of the output buffer.
     D      obo                      10i 0                                        67
    ? * Input buffer offset. The offset of this field from the start of the input buffer.
     D      ibo                      10i 0                                        71
    ? * Length. The length of the field. For character fields: the number of characters. For fl
     D     fldb                      05i 0                                        75
    ? * Number of digits. The number of digits in the field. For numeric fields: the number of
     D     fldd                      05i 0                                        77
    ? * Decimal positions. The number of position to the right of the decimal point.
     D     fldp                      05i 0                                        79
    ? * Keyboard shift (RESHIFT) The keyboard shift attribute of the field.
     D      kbs                       1                                           81
    ? *
    ? * X
    ? * Alphabetic only.
    ? * A
    ? * Alphameric shift.
    ? * N
    ? * Numeric shift.
    ? * S
    ? * Signed numeric.
    ? * Y
    ? * Numeric only.
    ? * D
    ? * Digits only.
    ? * M
    ? * Numeric only character.
    ? * W
    ? * Katakana.
    ? * H
    ? * Hexadecimal.
    ? * I
    ? * Inhibit keyboard entry.
    ? * J
    ? * DBCS only.
    ? * E
    ? * DBCS either.
    ? * O
    ? * DBCS open.
    ? * B
    ? * Binary character.
    ? *
    ? * X'00'
    ? * No shift expected.
    ? *
    ? * Field status byte 1
     D     fldst                      1                                           82
    ? * Double-byte character set (DBCS) alternate type field. If on, indicates the alternate t
    ? * Double-byte character set (DBCS) field text description. If on, indicates the text desc
    ? * Double-byte character set (DBCS) column headings. If on, indicates the column headings
    ? * Double-byte character set (DBCS) validity checking literals. If on, indicates the compa
    ? * Rounding. Rounding method for the field. If on, indicates round insignificant decimal d
    ? * Character identifier flag. If on, indicates a character identifier was specified.
    ? * Reserved.
    ? * Join reference (JREF) (logical files only). For fields whose names are specified in mor
     D     jref                      05i 0                                        83
    ? * Field status byte 2.
     D     fldst2                     1                                           85
    ? * Allow null value (ALWNULL). If on, indicates the null value is allowed for this field.
    ? * Column default value. If on, indicates the column does not have a default value.
    ? * If on, indicates the column is a variable length field.
    ? * Reserved.
    ? * Flags.
     D    flgs2                       1                                           86
    ? * Correlated field. If on, indicates this is a correlated field.
    ? * File relative record number. If on, indicates this is a relative record number field.
    ? * Reserved.
    ? * Mapping errors possible. If on, indicates the field may return data mapping errors.
    ? * Variable field index. Index into the list of all variable field values for the query.
     D     varx                      05i 0                                        87
    ? * Reserved.
     D Reserved_72                    2                                           89
    ? * Allocated length. The number of bytes allocated for the field in the fixed portion of t
     D     lalc                      05i 0                                        91
    ? *
    ? * Or:
    ? *
    ? * Date/time/timestamp length. The number of bytes the based on field occupies.
    ? * Date format (DATFMT) or time format (TIMFMT), depending on the use of the field. This f
     D     dttf                       1                                           93
    ? *
    ? * X'FE'
    ? * The format associated with the job.
    ? * X'FF'
    ? * The format associated with the QDT.
    ? * X'01'
    ? * The *USA format.
    ? * X'03'
    ? * The *ISO format.
    ? * X'05'
    ? * The *EUR format.
    ? * X'07'
    ? * The *JIS format (date only).
    ? * X'09'
    ? * The SAA timestamp.
    ? * X'17'
    ? * The *MDY format (date only).
    ? * X'18'
    ? * The *DMY format (date only).
    ? * X'19'
    ? * The *YMD format (date only).
    ? * X'1A'
    ? * The *JUL format (date only).
    ? * X'1B'
    ? * The *HMS format (time only).
    ? * X'25'
    ? * The *CMDY format (pseudo date).
    ? * X'26'
    ? * The *CDMY format (pseudo date).
    ? * X'27'
    ? * The *CYMD format (pseudo date).
    ? * X'28'
    ? * The *MDYY format (pseudo date).
    ? * X'29'
    ? * The *DMYY format (pseudo date).
    ? * X'2A'
    ? * The *YYMD format (pseudo date).
    ? * X'2B'
    ? * The *YM format (pseudo date).
    ? * X'2C'
    ? * The *MY format (pseudo date).
    ? * X'2D'
    ? * The *YYM format (pseudo date).
    ? * X'2E'
    ? * The *MYY format (pseudo date).
    ? * X'30'
    ? * The *LONGJUL format (pseudo date).
    ? *
    ? * Date separator (DATSEP) or Time separator (TIMSEP) This field is not valid unless Qddff
     D     dtts                       1                                           94
    ? *
    ? * X'00'
    ? * The separator associated with the job.
    ? * X'EE'
    ? * The implied separator is used.
    ? * '/'
    ? * The slash is used.
    ? * '-'
    ? * The dash is used.
    ? * '.'
    ? * The period is used.
    ? * ' '
    ? * The blank is used.
    ? * ':'
    ? * The colon is used.
    ? *
    ? * Common coded character set identifier (CCSID).
     D     csid                      05i 0                                        95
    ? *
    ? * 0
    ? * The CCSID associated with the job is used.
    ? * 65535
    ? * No data translation is done.
    ? * nnnnn
    ? * The CCSID.
    ? *
    ? * Text description common coded character set identifier.
     D     tsid                      05i 0                                        97
    ? *
    ? * 0
    ? * The CCSID associated with the job is used.
    ? * 65535
    ? * No data translation is done.
    ? * nnnnn
    ? * The CCSID.
    ? *
    ? * Column heading common coded character set identifier.
     D     hsid                      05i 0                                        99
    ? *
    ? * 0
    ? * The CCSID associated with the job is used.
    ? * 65535
    ? * No data translation is done.
    ? * nnnnn
    ? * The CCSID.
    ? *
    ? * Long comment common coded character set identifier.
     D     lsid                      05i 0                                        101
    ? *
    ? * 0
    ? * The CCSID associated with the job is used.
    ? * 65535
    ? * No data translation is done.
    ? * nnnnn
    ? * The CCSID.
    ? *
    ? * Labeled duration. The type of labeled duration this field defines.
     D     ldur                       1                                           103
    ? *
    ? * X'00'
    ? * The field not a labeled duration.
    ? * X'0D'
    ? * Year/years.
    ? * X'0E'
    ? * Month/months.
    ? * X'0F'
    ? * Day/days.
    ? * X'10'
    ? * Hour/hours.
    ? * X'11'
    ? * Minute/minutes.
    ? * X'12'
    ? * Second/seconds.
    ? * X'13'
    ? * Microsecond/microseconds.
    ? *
    ? * Flags. These flags indicate the user-specified value for the field at the time the form
     D     flgs                       1                                           104
    ? * If on, indicates DATFMT was defaulted.
    ? * If on, indicates DATFMT(*JOB) was specified.
    ? * If on, indicates DATSEP was defaulted.
    ? * If on, indicates DATSEP(*JOB) was specified.
    ? * If on, indicates TIMFMT was defaulted.
    ? * If on, indicates TIMSEP was defaulted.
    ? * If on, indicates TIMSEP(*JOB) was specified.
    ? * SAA format was specified.
    ? * Edit word common coded character set identifier.
     D     wsid                      05i 0                                        105
    ? *
    ? * 0
    ? * The CCSID associated with the job is used.
    ? * 65535
    ? * No data translation is done.
    ? * nnnnn
    ? * The CCSID.
    ? *
    ? * Reserved.
     D Reserved_61                    1                                           107
    ? * Reserved.
     D Reserved_62                    1                                           108
    ? * Reserved.
     D Reserved_63                    2                                           109
    ? * Flags.
     D    flagco                      1                                           111
    ? * Reserved.
    ? * If on, indicates the column is a UCS-2 field.
    ? * If on, indicates the column is a user-defined type field.
    ? * If on, indicates the column is an identity column.
    ? * If on, indicates the column is a row ID column.
    ? * If on, indicates the field is a UTF-8 or UTF-16 field.
    ? * Reserved.
     D Reserved_74                   68                                           112
    ? * Offset from the start of the field header to the field information if the field was a u
     D     cplx                      10i 0                                        180
    ? * Maximum length of the large object field.
     D     bmaxl                     10i 0                                        184
    ? * Pad length of the large object field.
     D     bpadl                     05i 0                                        188
    ? * Offset from the start of the field header to the IDDU/SQL dictionary field information,
     D     dicd                      10i 0                                        190
    ? * Offset from the start of the field header to the default value description, Qddfdft.
     D     dftd                      10i 0                                        194
    ? * Offset from the start of the field header to the derived field description (or to the c
     D     derd                      10i 0                                        198
    ? * Reserved.
     D Reserved_75                    6                                           202
    ? * Offset from the start of the field header to the field text description, Qddfftxt.
     D     txtd                      10i 0                                        208
    ? * Reserved.
     D Reserved_102                   2                                           212
    ? * Offset from the start of the field header to the field reference information, Qddfrefi.
     D     refd                      10i 0                                        214
    ? * Length of the edit code/edit word for the field.
     D     edtl                      05i 0                                        218
    ? * Offset from the start of the field header to the edit code/edit word information, Qddfe
     D     edtd                      10i 0                                        220
    ? * Reserved.
     D Reserved_76                   05i 0                                        224
    ? * Offset from the start of the field header to the column heading information, Qddfcolh.
     D     chd                       10i 0                                        226
    ? * Length of validity checking data present for the field.
     D     vckl                      05i 0                                        230
    ? * Offset from the start of the field header to the validity checking data, Qddfvchk.
     D     vckd                      10i 0                                        232
    ? * Offset from the start of the field header to the alias name entry.
     D     xals                      10i 0                                        236
    ? * Offset from the start of the field header to the field prompted numeric editing informa
     D     fpnd                      10i 0                                        240
    ? * Reserved.
     D Reserved_77                    8                                           244
    ? * Start of the variable portion of the field description.
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Reference Information (Qdb_Qddfrefi)
    ? *
    ? * You can locate the Qdb_Qddfrefi section with the offset Qddfrefd in the field header se
    ? *
    ? * Description
     d refinf          ds            80    based( prefinf       ) qualified
    ? * Modification flags.
     D     rcde                       1                                           0
    ? * Modifications. If on, indicates the field has been modified.
    ? * Name modification. If on, indicates the name of the field has been modified.
    ? * Data type modification. If on, indicates the data type of the field has been modified.
    ? * Field length modification. If on, indicates the length of the field has been modified.
    ? * Precision modification. If on, indicates the precision of the field has been modified.
    ? * Edit information modification. If on, indicates the edit information of the field has b
    ? * Validity checking information modification. If on, indicates the validity checking info
    ? * Other modification. If on, indicates other information of the field has been modified.
    ? * Reference file name.
     D     rfil                      10                                           1
    ? * Reference file library.
     D     rlib                      10                                           11
    ? * Referenced record format.
     D     rfmt                      10                                           21
    ? * Referenced field.
     D     rfld                      30                                           31
    ? * Reserved.
     D Reserved_78                   19                                           61
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Field Prompted Numeric Editing Information (Qdb_Qddfdfne)
    ? *
    ? * You can locate the Qdb_Qddfdfne section with the offset Qddffpnd in the field header se
    ? *
    ? * Description
     d edit            ds            64    based( pedit         ) qualified
    ? * Reserved.
     D Reserved_80                    2                                           0
    ? * Date separator (DATSEP) or Time separator (TIMSEP).
     D      dts                       1                                           2
    ? *
    ? * X'00'
    ? * This is not a date or time field.
    ? * 1
    ? * The period (.).
    ? * 2
    ? * The slash (/).
    ? * 3
    ? * The colon (:).
    ? * 4
    ? * The dash (-).
    ? * 5
    ? * The comma (,).
    ? *
    ? * Decimal point character. This field is not valid unless Qddfddts contains X'00'.
     D      dpc                       1                                           3
    ? *
    ? * 1
    ? * The period (.).
    ? * 2
    ? * The comma (,).
    ? * 3
    ? * The colon (:).
    ? * 4
    ? * The dollar ($).
    ? * 5
    ? * No decimal point is used.
    ? *
    ? * Thousands separator character. This field is not valid unless Qddfddts contains X'00'.
     D      tsc                       1                                           4
    ? *
    ? * 1
    ? * The period (.).
    ? * 2
    ? * The comma (,).
    ? * 3
    ? * The apostrophe (').
    ? * 4
    ? * The blank ( ).
    ? * 5
    ? * No thousands separator is used.
    ? *
    ? * Negative sign information.
    ?D* nsi                          13
    ? * Display negative sign. This field is not valid unless Qddfddts contains X'00'.
     D      nsc                       1                                           5
    ? *
    ? * 1
    ? * The negative sign is displayed for negative values.
    ? * 2
    ? * The negative is not displayed for negative values.
    ? *
    ? * Left negative sign value. This field is not valid unless Qddfddts contains X'00'.
     D      nsl                       6                                           6
    ? * Right negative sign value. This field is not valid unless Qddfddts contains X'00'.
     D      nsr                       6                                           12
    ? * Currency symbol information.
    ?D* csi                          13
    ? * Display currency symbol. This field is not valid unless Qddfddts contains X'00'.
     D      csv                       1                                           18
    ? *
    ? * 1
    ? * The currency symbol is displayed.
    ? * 2
    ? * The currency symbol is not displayed.
    ? *
    ? * Left currency symbol value. This field is not valid unless Qddfddts contains X'00'.
     D      csl                       6                                           19
    ? * Right currency symbol value. This field is not valid unless Qddfddts contains X'00'.
     D      csr                       6                                           25
    ? * Print zero value. This field is not valid unless Qddfddts contains X'00'.
     D      pzv                       1                                           31
    ? *
    ? * 1
    ? * A zero value is displayed.
    ? * 2
    ? * A zero value is not displayed.
    ? *
    ? * Replace leading zeros. This field is not valid unless Qddfddts contains X'00'.
     D      rlz                       1                                           32
    ? *
    ? * 1
    ? * Leading zeros are replaced.
    ? * 2
    ? * Leading zeros are not replaced.
    ? *
    ? * Leading zero replacement value. This field is not valid unless Qddfddts contains X'00'.
     D      rlv                       1                                           33
    ? *
    ? * 1
    ? * Blanks ( ).
    ? * 2
    ? * Asterisks (*).
    ? * 3
    ? * Blanks ( ) and the left currency symbol is shifted right.
    ? *
    ? * Single leading zero. This field is not valid unless Qddfddts contains X'00'.
     D      lzo                       1                                           34
    ? *
    ? * 1
    ? * A zero is displayed to the left of the decimal point when there are no significant digi
    ? * 2
    ? * A zero is not displayed to the left of the decimal point.
    ? *
    ? * Reserved.
     D Reserved_81                   29                                           35
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Edit Code/Edit Word Information (Qdb_Qddfedcw)
    ? *
    ? * You can locate the Qdb_Qddfedcw section with the offset Qddfedtd in the field header se
    ? *
    ? * Description
     d edtwrd          ds            96    based( pedtwrd       ) qualified
    ? * Edit code information.
    ?D*    ecdi                       2
    ? * Edit code (EDTCDE). Edit code for the field when it is referred to during display or pr
     D     ecde                       1                                           0
    ? * Floating currency symbol.
     D     ecdx                       1                                           1
    ? *
    ? * *
    ? * Asterisk protection: asterisks are displayed to the left of significant digits.
    ? *
    ? * A currency symbol indicates the symbol displayed to the left the significant digits.
    ? * Reserved
     D Reserved_79                   14                                           2
    ? * Edit word (EDTWRD). The form in which the field values are displayed.
     D Qddfewd                       80                                            16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Validity Checking Information (Qdb_Qddfvchk)
    ? *
    ? * You can locate the Qdb_Qddfvchk section with the offset Qddfvckd in the field header se
    ? *
    ? * Description
     d checki          ds            16    based( pchecki       ) qualified
    ? * Number of validity check entries.
     D     vcnume                    05i 0                                        0
    ? * Reserved.
     D Reserved_82                   14                                           2
    ? * Validity checking entry array.
    ?D*Qddfvcen                        *                                           16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Validity Checking Entry (Qdb_Qddfvcst)
    ? *
    ? * The first validity checking entry starts at Qddfvcen in the validity checking informati
    ? *
    ? * Description
     d checke          ds            16    based( pchecke       ) qualified
    ? * DDSI keyword identifier.
     D     vccd                       1                                           0
    ? *
    ? * X'63'
    ? * CHKMSGID
    ? * X'64'
    ? * CHECK(ME)
    ? * X'66'
    ? * CHECK(FE)
    ? * X'67'
    ? * CHECK(MF)
    ? * X'71'
    ? * RANGE
    ? * X'72'
    ? * VALUES
    ? * X'73'
    ? * COMP(GT)
    ? * X'74'
    ? * COMP(GE)
    ? * X'75'
    ? * COMP(EQ)
    ? * X'76'
    ? * COMP(NE)
    ? * X'77'
    ? * COMP(LE)
    ? * X'78'
    ? * COMP(LT)
    ? * X'79'
    ? * COMP(NL)
    ? * X'7A'
    ? * COMP(NG)
    ? * X'A0'
    ? * CHECK(M10)
    ? * X'A1'
    ? * CHECK(M11)
    ? * X'A2'
    ? * CHECK(VN)
    ? * X'A3'
    ? * CHECK(AB)
    ? * X'A5'
    ? * CHECK(VNE)
    ? * X'A6'
    ? * CHECK(M10F)
    ? * X'A7'
    ? * CHECK(M11F)
    ? *
    ? * Number of parameters.
     D     vcnump                    05i 0                                        1
    ? * Length of this validity checking entry.
     D     vcel                      05i 0                                        3
    ? * Reserved.
     D Reserved_83                   11                                           5
    ? * Validity checking parameter array.

    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Validity Checking Parameter (Qdb_Qddfvcpr)
    ? *
    ? * The first validity checking parameter starts at Qddfvcpm in the validity checking entry
    ? *
    ? * Description
     d checkp          ds            16    based( pcheckp       ) qualified
    ? * Length of validity checking parameter Qddfvcpv.
     D     vcpl                      05i 0                                        0
    ? * Reserved.
     D Reserved_84                   14                                           2
    ? * Validity checking parameter value.
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Complex Object Field Type Information (Qdb_Qddfcpli)
    ? *
    ? * You can locate the Qdb_Qddfcpli section with the offset Qddfcplx in the field header se
    ? *
    ? * Description
     d cplx            ds           160    based( pcplx         ) qualified
    ? * Length of the user-defined type name.
     D     lenu                      10i 0                                        0
    ? * User-defined type name.
     D     nudt                     128                                           4
    ? * User-defined type library name.
     D     ludt                      10                                           132
    ? * Link control.
     D      link                      1                                           142
    ? *
    ? * N
    ? * No link control.
    ? * F
    ? * File link control.
    ? *
    ? * Link integrity. Linked files are under control of the database if the field is a datali
     D      inte                      1                                           143
    ? *
    ? * A
    ? * All under control.
    ? * S
    ? * Selective control. This value is not supported yet.
    ? *
    ? * Read permission. The file system controls authority to read a file if the field is a da
     D      rper                      2                                           144
    ? *
    ? * FS
    ? * File system.
    ? * DB
    ? * Database.
    ? *
    ? * Write permission. The file system controls authority to write to a file if the field is
     D      wper                      2                                           146
    ? *
    ? * FS
    ? * File system.
    ? * BL
    ? * Blocked.
    ? *
    ? * Recovery. The database manager will recover the file if the field is a datalink.
     D      reco                      1                                           148
    ? *
    ? * Y
    ? * Yes. This value is not supported yet.
    ? * N
    ? * No.
    ? *
    ? * On unlink. The database manager will either restore the file owner on an unlink, or del
     D      unlk                      1                                           149
    ? *
    ? * R
    ? * Restore the owner.
    ? * D
    ? * Delete the file.
    ? *
    ? * Reserved.
     D Reserved_150                  10                                           150
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Field Text (Qdb_Qddfftxt)
    ? *
    ? * You can locate the Qdb_Qddfftxt section with the offset Qddftxtd in the field header se
    ? *
    ? * Description
     d fldtxt          ds            50    based( pfldtxt       ) qualified
    ? * Text (TEXT). Text description of the field.
     D      txt                      50                                           0
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Alias Name Structure (Qdb_Qddfalis)
    ? *
    ? * You can locate this section with the offset Qddfxals located in the field header sectio
    ? *
    ? * Description
     d aliasns         ds           274    based( paliasns      ) qualified
    ? * Length of alternative name Qddfalsn.
     D     alsl                      05i 0                                        0
    ? * Reserved.
     D Reserved_85                   14                                           2
    ? * Alternative name (ALIAS).
     D     alsn                     258                                           16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Default Value Description Information (Qdb_Qddfdft)
    ? *
    ? * You can locate the Qdb_Qddfdft section with the offset Qddfdftd in the field header sec
    ? *
    ? * Description
     d default         ds                  based( pdefault      ) qualified
    ? * Length of default information.
     D     dftl                      05i 0                                        0
    ? * Default attributes.
     D     dfta                       1                                           2
    ? * DBCS or graphic default. If on, indicates the default is a DBCS or graphic literal.
    ? * Hex default. If on, indicates the default is a hexadecimal literal.
    ? * Null default. If on, indicates the default is null.
    ? * Reserved.
    ? * DATE, TIME, or TIMESTAMP default. On indicates the default is CURRENT_DATE, CURRENT_TIM
    ? * Reserved.
    ? * DFT or DFTVAL keyword. If on, indicates the DFTVAL keyword was specified.
    ? * Reserved.
     D Reserved_87                   13                                           3
    ? * Default (DFT) or (DFTVAL). A value of USER indicates that the default value for this fi
    ?D*ddfdftv                        *                                           16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Identity Column Information (Qdb_Qddfidcl)
    ? *
    ? * You can locate the Qdb_Qddfidcl section with the offset Qddf_Identity_Off in the field
    ? *
    ? * Description
     d idcol           ds           132    based( pidcol        ) qualified
    ? * Length of IDENTITY information.
     D         Len                   05i 0                                        0
    ? * Original START WITH value.
     d Orig_Start                    31p 0                                        2
    ? * Current START WITH value.
     d Curr_Start                    31p 0                                        18
    ? * INCREMENT BY value.
     D Increment_By                  10i 0                                        34
    ? * MINIMUM value.
     d minimum                       31p 0                                        38
    ? * MAXIMUM value.
     d maximum                       31p 0                                        54
    ? * CYCLE indicator.
     D      Id_Cycle                  1                                           70
    ? * 1 = Cycling will occur.
    ? * 0 = Cycling will not occur.
    ? * ORDER mode indicator.
     D Order                          1                                           71
    ? * 1 = Values are generated in order of request.
    ? * 0 = Values do not need to be generated in order of request.
    ? * Identity GENERATE indicator.
     D Generate                       1                                           72
    ? * 1 = GENERATE BY DEFAULT. 0 = GENERATE ALWAYS.
    ? *
    ? * CACHE value.
     d curr_cache                    10u 0                                        73
    ? * Rowid GENERATE indicator.
     D Rowid_Generate                 1                                           77
    ? * 1 = GENERATE BY DEFAULT. 0 = GENERATE ALWAYS.
    ? *
    ? * Reserved.
     D Reserved1                     53
    ? *
    ? *
    ? * Derived Field Description Information
    ? *
    ? * The derived field structure is a stack of operators and operands in postfix notation. P
    ? *
    ? * A + B
    ? * would be:
    ? * A B +
    ? *
    ? * Numeric operands and character operands cannot be mixed in one derived field descriptio
    ? *
    ? * Substringing DBCS fields is allowed, although the data is treated as character data, th
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Derived Field Header (Qdb_Qddfderv)
    ? *
    ? * You can locate this section, Qdb_Qddfderv, with the offset Qddfderd in the field header
    ? *
    ? * Description
     d drvh            ds            16    based( pdrvh         ) qualified
    ? * Length of derived field information Qddfderv.
     D     dvtl                      10i 0                                        0
    ? * Number of derived field entries. 0 indicates it is a concatentated field.
     D     dvnume                    05i 0                                        4
    ? * Offset from the start of this header to the derived field text (or to the concatenated
     D     dvot                      10i 0                                        6
    ? * Reserved.
     D r                              6                                           10
    ? * Derived field entry.
    ?D*Qddfdven                        *                                           16
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Derived Field Entry (Qdb_Qddfdvst)
    ? *
    ? * Description
     d drve            ds            16    based( pdrve         ) qualified
    ? * Length of derived field entry, Qddfdvst.
     D     dvln                      10i 0                                        0
    ? * Derived field entry type.
     D     dtyp                      05i 0                                        4
    ? *
    ? * 0
    ? * A field operand.
    ? * 1
    ? * A constant operand.
    ? * 2
    ? * An operator.
    ? *
    ? * The union of the Field operand (Qdddvof), Constant operand (Qddffvoc), and Operator ent
    ?D*Qddfdv                          *                                           6
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Field Operand Entry (Qdb_Qddfdvof)
    ? *
    ? * Description
     d fldop           ds            58    based( pfldop        ) qualified
    ? * Field name.
     D     dvon                      30                                           0
    ? * Join reference (JREF). Relative file number of the physical file containing the externa
     D     dvjr                      05i 0                                        30
    ? *
    ? * 0
    ? * The fields previously defined in this format are searched for the field name.
    ? *
    ? * If the field is not found, the based on file formats are searched. If the field name is
    ? *
    ? * n
    ? * The file containing the field name.
    ? *
    ? * Starting position. The starting position in the field of the substring (SST) specified.
     D     dv01                      05i 0                                        32
    ? * Ending position. The ending position in the field of the substring (SST) specified.
     D     dvo2                      05i 0                                        34
    ? * Qdt from which this correlated field originates (only applicable for SQL subqueries.
     D     qdtnum                    05i 0                                        36
    ? * Reserved.
     D r                             20                                           38
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Constant Operand Entry (Qdb_Qddfdvoc)
    ? *
    ? * Description
     d conste          ds            43    based( pconste       ) qualified
    ? * Constant operand header.
    ? * Length of constant Qddfdvov.
     D     dvol                      10i 0                                        0
    ? * Constant attributes.
     D  ca                            1                                           4
    ? * DBCS constant. If on, indicates the constant is a DBCS-open literal.
    ? * Reserved.
    ? * Character constant type. If on, indicates the constant is an unquoted character string
    ? * Assume character constant. If on, indicates the system assumes this is a character cons
    ? * DBCS-only literal. If on, indicates the constant is a DBCS-only literal.
    ? *
    ? * This attribute is not valid if the DBCS constant attribute, Qddfdvci, is off.
    ? * Special register. If on, indicates this constant is a special register defined by Qddfd
    ? * Null indicator. If on, indicates the constant is a null literal.
    ? * Reserved.
    ? * Special register constant. Defined by special register constants, can only be specified
     D     dvrc                       1                                           5
    ? * Date constant format (DATFMT) or Time constant format (TIMFMT)
     D     dvft                       1                                           6
    ? *
    ? * X'FE'
    ? * Format associated with the job is used.
    ? * X'FF'
    ? * Format associated with QDT is used.
    ? * X'01'
    ? * The *USA format.
    ? * X'03'
    ? * The *ISO format.
    ? * X'05'
    ? * The *EUR format.
    ? * X'07'
    ? * The *JIS format.
    ? * X'09'
    ? * The SAA timestamp format.
    ? * X'17'
    ? * The *MDY date format.
    ? * X'18'
    ? * The *DMY date format.
    ? * X'19'
    ? * The *YMD date format.
    ? * X'1A'
    ? * The *JUL date format.
    ? * X'1B'
    ? * The *HMS time format.
    ? *
    ? * Date constant separator (DATSEP) or Time constant separator (TIMSEP)
     D     dvsp                       1                                           7
    ? *
    ? * X'00'
    ? * Default separator associated with job is used.
    ? * X'EE'
    ? * The implied separator is used.
    ? * '/'
    ? * The slash.
    ? * '-'
    ? * The dash.
    ? * '.'
    ? * The period.
    ? * ','
    ? * The comma.
    ? * ' '
    ? * The blank.
    ? * ':'
    ? * The colon.
    ? *
    ? * Reserved.
     D Reserved_92                    2                                           8
    ? * Constant coded character set identifier (CCSID).
     D     dvcd                      05i 0                                        10
     D Reserved_93                    1                                           12
    ? * Constant flags.
     D     cflg                       1                                           13
    ? * Reserved.
    ? * Graphics literal. If on, indicates this is a graphics literal.
    ? * Reserved.
    ? * Reserved.
     D Reserved_95                   29                                           14
    ? * Derived constant. The external form of the constant.
    ?D*Qddfdvov                        *                                           43
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Operator Entry (Qdb_Qddfdvo)
    ? *
    ? * Description
     d ope             ds            26    based( pope          ) qualified
    ? * Derived operator.
     D     dvop                       1                                           0
    ? *
    ? * Operators requiring three operands:
    ? *
    ? * X'27'
    ? * Substring
    ? *
    ? * Operators requiring two operands:
    ? *
    ? * X'01'
    ? * Concatenation
    ? * X'04'
    ? * Addition
    ? * X'05'
    ? * Subtraction
    ? * X'06'
    ? * Multiplication
    ? * X'07'
    ? * Division
    ? * X'08'
    ? * Minimum
    ? * X'09'
    ? * Maximum
    ? * X'1A'
    ? * X to the Y power
    ? * X'1B'
    ? * Binary OR
    ? * X'1C'
    ? * Binary XOR
    ? * X'1D'
    ? * Binary AND
    ? * X'24'
    ? * Strip leading
    ? * X'25'
    ? * Strip tailing
    ? * X'26'
    ? * Strip both
    ? * X'35'
    ? * Compute
    ? * X'41'
    ? * String position
    ? * X'80'
    ? * Remainder
    ? *
    ? * Operators requiring one operand:
    ? *
    ? * X'02'
    ? * Map
    ? * X'03'
    ? * Direct map
    ? * X'0A'
    ? * Absolute value
    ? * X'0B'
    ? * Translate
    ? * X'0C'
    ? * Natural logarithm
    ? * X'0D'
    ? * Exponential
    ? * X'0E'
    ? * Sine
    ? * X'0F'
    ? * Cosine
    ? * X'10'
    ? * Tangent
    ? * X'11'
    ? * Cotangent
    ? * X'12'
    ? * Arc sine
    ? * X'13'
    ? * Arc cosine
    ? * X'14'
    ? * Arc tangent
    ? * X'15'
    ? * Hyperbolic sine
    ? * X'16'
    ? * Hyperbolic cosine
    ? * X'17'
    ? * Hyperbolic tangent
    ? * X'18'
    ? * Hyperbolic arctangent
    ? * X'19'
    ? * Square root
    ? * X'1E'
    ? * Binary NOT
    ? * X'1F'
    ? * Negation
    ? * X'23'
    ? * Length
    ? * X'29'
    ? * Year
    ? * X'2A'
    ? * Month
    ? * X'2B'
    ? * Day
    ? * X'2C'
    ? * Days.
    ? * X'2D'
    ? * Hour
    ? * X'2E'
    ? * Minute
    ? * X'2F'
    ? * Second
    ? * X'30'
    ? * Microsecond
    ? * X'31'
    ? * Date
    ? * X'32'
    ? * Time
    ? * X'34'
    ? * Hex
    ? *
    ? * Operators requiring one operand continued:
    ? *
    ? * X'36'
    ? * Test translate CCSID
    ? * X'37'
    ? * Translate monocase
    ? * X'3C'
    ? * Node number
    ? * X'3D'
    ? * Cast
    ? * X'47'
    ? * Partition
    ? * X'48'
    ? * Node name
    ? * X'83'
    ? * Log (base 10)
    ? * X'84'
    ? * Anti log (base 10)
    ? * X'85'
    ? * Digits
    ? * X'86'
    ? * Char
    ? * X'8F'
    ? * Graphic representation of character
    ? * X'90'
    ? * Character representation of graphic
    ? *
    ? * Label duration operators:
    ? *
    ? * X'87'
    ? * Year
    ? * X'88'
    ? * Month
    ? * X'89'
    ? * Day
    ? * X'8A'
    ? * Hour
    ? * X'8B'
    ? * Minute
    ? * X'8C'
    ? * Second
    ? * X'8D'
    ? * Microsecond
    ? *
    ? * Operators requiring one to many operands:
    ? *
    ? * X'3A'
    ? * Hash function
    ? *
    ? * Operators requiring two to many operands:
    ? *
    ? * X'28'
    ? * Null values
    ? * X'3E'
    ? * Case Expression
    ? *
    ? * Operators requiring one or two operands:
    ? *
    ? * X'33'
    ? * Timestamp
    ? *
    ? * Group by operators: All require one operand except count that requires one or two.
    ? *
    ? * X'A1'
    ? * Count
    ? * X'A3'
    ? * Sum
    ? * X'A4'
    ? * Minimum
    ? * X'A5'
    ? * Maximum
    ? * X'B0'
    ? * Average
    ? * X'B1'
    ? * Standard deviation
    ? * X'B2'
    ? * Variance
    ? *
    ? * Translate table index or case selection specification index. This field is valid only i
     D       xnum                     2                                           1
    ? * Operator date format index.
    ?D*      dtfmt                    1                                           1
    ? * Operator date separator index.
    ?D*      dtsep                    1                                           1
    ? * Operator date format (DATFMT) or Operator time format (TIMFMT).
     D       fm                       1                                           3
    ? *
    ? * X'FE'
    ? * Format associated with the job is used.
    ? * X'FF'
    ? * Format associated with QDT is used.
    ? * X'01'
    ? * The *USA format.
    ? * X'03'
    ? * The *ISO format.
    ? * X'05'
    ? * The *EUR format.
    ? * X'07'
    ? * The *JIS format.
    ? * X'09'
    ? * The SAA timestamp format.
    ? * X'17'
    ? * The *MDY date format.
    ? * X'18'
    ? * The *DMY date format.
    ? * X'19'
    ? * The *YMD date format.
    ? * X'1A'
    ? * The *JUL date format.
    ? * X'1B'
    ? * The *HMS time format.
    ? *
    ? * Operator date separator (DATSEP) or Operator time separator (TIMSEP)
     D       sa                       1                                           4
    ? *
    ? * X'00'
    ? * Default separator associated with job is used.
    ? * X'EE'
    ? * The implied separator is used.
    ? * '/'
    ? * The slash.
    ? * '-'
    ? * The dash.
    ? * '.'
    ? * The period.
    ? * ','
    ? * The comma.
    ? * ' '
    ? * The blank.
    ? * ':'
    ? * The colon.
    ? *
    ? * Number of operands.
     D       no                      05i 0                                        5
    ? * Operator attributes.
     D  oa                            1                                           7
    ? * Reserved.
    ? * Operator date format and separator source. If on, indicates Qddfdvdtfmt and Qddfdvdtsep
    ? * Reserved.
    ? * Group operators. If on, do not include duplicate field values in group by operation. If
    ? * Reserved.
    ? * Number of characters option. If on, the result of the operator is based on the number o
    ? * Reserved.
    ? * Reserved.
     D Reserved_98                    2                                           8
    ? * The character to use for the decimal point. Only applicable if Qddfdvop is a CAST(X'3D'
     D decptchar                      1                                           10
    ? * Offset from the beginning of this derived field entry (Qdb_Qddfdvst) to the Function Na
     d func_def                      10i 0                                        11
    ? * Reserved.
     D Reserved_101                  11                                           15
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Derived Field Text Information (Qdb_Qddfdvtx)
    ? *
    ? * You can locate the Qdb_Qddfdvtx section with the offset Qddfdvot in the Derived Field H
    ? *
    ? * Description
     d drvft           ds           100    based( pdrvft        ) qualified
    ? * Length of derived field text information or concatenated field text information.
     D     dvlt                      05i 0                                        0
    ? * Derived field text description or concatenated field text description.
     D Qddfdtxt                      98                                            2
    ? *
    ? *
    ? * Column Heading Information (Qdb_Qddfcolh)
    ? *
    ? * You can locate the Qdb_Qddfcolh section with the offset Qddfchd in the field header sec
    ? *
    ? * Description
     d colhdg          ds            60    based( pcolhdg       ) qualified
    ? * Column heading £1. The first column heading specified on the COLHDG DDS keyword without
     D     ch1                       20                                           0
    ? * Column heading £2. The second column heading specified on the COLHDG DDS keyword withou
     D     ch2                       20                                           20
    ? * Column heading £3. The third column heading specified on the COLHDG DDS keyword without
     D      h3                       20                                           40
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * IDDU/SQL Dictionary Format Information (Qdb_Qddfdic)
    ? *
    ? * You can locate the Qdb_Qddfdic section with the offset Qddfdico in the field header sec
    ? *
    ? * Description
     d dicFI           ds                  based( pdicfi        ) qualified
    ? * Reserved.
     D Reserved_100                  32                                           0
    ? * Format definition long comment information.
    ? * Length of format definition long comment information, Qddfdicm.
     D       lt                      05i 0                                        32
    ? * Format definition long comment.
    ?D*      tx                        *                                           34
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * IDDU/SQL Dictionary Field Information (Qdb_Qddfdicf)
    ? *
    ? * You can locate the Qdb_Qddfdicf section with the offset Qddfdicd located in the field h
    ? *
    ? * Description
     d dicfdi          ds                  based( pdicfdi       ) qualified
    ? * Reserved.
     D x                             16                                           0
    ? * Field definition long comment.
    ? * Length of field definition long comment Qddfdfco.
     D*     cl                       05i 0                                        16
    ? * Field definition comment text.
    ?D      ct                     2000    varying                                18
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Translate Table Specification (Qdb_Qddfxl)
    ? *
    ? * You can locate the Qdb_Qddfxl section with the offset Qddfxlto in the field header sect
    ? *
    ? * Description
     d xl              ds           290    based( pxl           ) qualified
    ? * Number of elements in the translate table array.
     D       num                     05i 0                                        0
    ? * Translate table array.
    ? * Translate table name.
     D       nm                      10                                           2
    ? * Translate table library name.
     D       ln                      10                                           12
    ? * Translate table constant coded character set identifier.
     D      cid                      05i 0                                        22
    ? * Reserved.
     D Reserved_99                   10                                           24
    ? * Translate table.
     D      tbl                     256                                           34
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Case Selection Specification (Qdb_Qddfcsl)
    ? *
    ? * You can locate the Qdb_Qddfcsl section with the offset Qddfrcao in the field header sec
    ? *
    ? * Description
     d case            ds            16    based( pcase         ) qualified
    ? * Number of elements in the case selection specification array.
     D       num                     05i 0                                        0
    ? * Length of this plus the length of all the selection specifications.
     D      ln                       10i 0                                        2
    ? * Reserved.
     D Reserved                      10                                           6
    ? * Offset to the selection specification. Offset is from the start of Qdb_qdffcsl.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Function Name Specification (Qdb_Qddfunc_def)
    ? *
    ? * You can locate the Qdb_Qddfunc_def section with the offset Qddfdo_func_def in the deriv
    ? *
    ? * This section can only be specified when used in conjunction with the QQQQRY API.
    ? *
    ? * This section can be used to reference a function by name rather than opcode qddfdvop. I
    ? *
    ? * See the DB2 UDB for iSeries SQL Reference book for more information on user-defined fun
    ? *
    ? * Description
     d func            ds           160    based( pfunc         ) qualified
    ? * Reserved.
     D Reserved                      20                                           0
    ? * Library where function can be found. Special values follow.
     D libname                       10                                           20
    ? *
    ? * ' '
    ? * Blank. Use the path (library list) to find the function.
    ? * 'QSYS2'
    ? * Use the built-in operator provided by the database.
    ? *
    ? * Length of function name in Qddfunc_funcname.
     d name_len                       5i 0                                        30
    ? * Name of function to resolve.
     D  funcname                    128                                           32
    ? * Built-in functions provided by the database in library QSYS2:
    ? *
    ? * '+'
    ? * Addition. Two operands
    ? * '-'
    ? * Subtraction. Two operands
    ? * '*'
    ? * Multiplication. Two operands
    ? * '/'
    ? * Division. Two operands
    ? * 'ABS'
    ? * Absolute value. One operand
    ? * 'ACOS'
    ? * Arc cosine. One operand
    ? * 'ANTILOG'
    ? * Antilog. One operand
    ? * 'ASIN'
    ? * Arc sine. One operand
    ? * 'ATAN'
    ? * Arc tangent. One operand
    ? * 'ATANH'
    ? * Hyperbolic arc tangent. One operand
    ? * 'AVG'
    ? * Average. One operand
    ? * 'CHAR'
    ? * Character. One to two operands
    ? * 'COALESCE'
    ? * First non-null value. Two to N operands
    ? * 'CONCAT'
    ? * Concatenation. Two operands
    ? * 'COS'
    ? * Cosine. One operand
    ? * 'COSH'
    ? * Hyperbolic cosine. One operand
    ? * 'COT'
    ? * Co-tangent. One operand
    ? * 'COUNT'
    ? * Count. One operand
    ? * 'CURDATE'
    ? * Current date. Zero operand
    ? * 'CURTIME'
    ? * Current time. Zero operand
    ? * 'DATE'
    ? * Date. One operand
    ? * 'DAY'
    ? * Day. One operand
    ? * 'DAYOFMONTH'
    ? * Day of month. One operand
    ? * 'DAYOFWEEK'
    ? * Day of week. One operand
    ? * 'DAYOFYEAR'
    ? * Day of year. One operand
    ? *
    ? * Built-in functions (continued)
    ? *
    ? * 'DAYS'
    ? * Days. One operand
    ? * 'DECIMAL'
    ? * Decimal of operand. One operand
    ? * 'DEGREES'
    ? * Degrees. One operand
    ? * 'DIGITS'
    ? * Character form of number. One operand
    ? * 'DOUBLE'
    ? * Double precision. One operand
    ? * 'EXP'
    ? * Natural log to the power. One operand
    ? * 'FLOAT'
    ? * Floating point. One operand
    ? * 'FLOOR'
    ? * Integer. One operand
    ? * 'HASH'
    ? * Hash value. One to N operands
    ? * 'HEX'
    ? * Hex value. One operand
    ? * 'HOUR'
    ? * Hour. One operand
    ? * 'IFNULL'
    ? * First non-null value. Two operands
    ? * 'INT'
    ? * Integer. One operand
    ? * 'LAND'
    ? * Logical AND. Two operands
    ? * 'LCASE'
    ? * Lower case. One operand
    ? * 'LEFT'
    ? * Left N characters. Two operands
    ? * 'LENGTH'
    ? * Length. One operand
    ? * 'LN'
    ? * Natural log. One operand
    ? * 'LNOT'
    ? * Logical NOT. One operand
    ? * 'LOCATE'
    ? * Search string in source string. Two to three operands
    ? * 'LOG'
    ? * Base 10 log. One operand
    ? * 'LOR'
    ? * Logical OR. Two operands
    ? * 'LOWER'
    ? * Lower case. One operand
    ? * 'LTRIM'
    ? * Remove leading blanks. One operand
    ? *
    ? * Built-in functions (continued)
    ? *
    ? * 'MAX'
    ? * Max. One operand
    ? * 'MAX'
    ? * Max. Two to N operands
    ? * 'MICROSECOND'
    ? * Microsecond. One operand
    ? * 'MIN'
    ? * Min. One operand
    ? * 'MIN'
    ? * Min. Two to N operands
    ? * 'MINUTE'
    ? * Minute. One operand
    ? * 'MOD'
    ? * Modulo. Two operands
    ? * 'MONTH'
    ? * Month. One operand
    ? * 'NOW'
    ? * Current timestamp. Zero operands
    ? * 'POSSTR'
    ? * Search string in source string. Two operands
    ? * 'POWER'
    ? * Raise to power of. Two operands
    ? * 'QUARTER'
    ? * Quarter. One operand
    ? * 'REAL'
    ? * Single precision float. One operand
    ? * 'RTRIM'
    ? * Trim trailing blanks. One operand
    ? * 'SECOND'
    ? * Second. One operand
    ? * 'SIN'
    ? * Sine. One operand
    ? * 'SINH'
    ? * Hyperbolic sine. One operand
    ? * 'SMALLINT'
    ? * Small integer. One operand
    ? * 'SQRT'
    ? * Square root. One operand
    ? * 'STDDEV'
    ? * Standard deviation. One operand
    ? * 'SUBSTR'
    ? * Substr. Two to three operands
    ? * 'SUM'
    ? * Sum. One operand
    ? *
    ? * Built-in functions (continued)
    ? *
    ? * 'TAN'
    ? * Tangent. One operand
    ? * 'TANH'
    ? * Hyperbolic tangent. One operand
    ? * 'TIME'
    ? * Time. One operand
    ? * 'TIMESTAMP'
    ? * Timestamp. One to two operands
    ? * 'TRANSLATE'
    ? * Translate. One to four operands
    ? * 'UCASE'
    ? * Uppercase. One operand
    ? * 'UPPER'
    ? * Uppercase. One operand
    ? * 'VALUE'
    ? * First non-null value. Two to N operands
    ? * 'VARCHAR'
    ? * Varchar. One to three operands
    ? * 'VARGRAPHIC'
    ? * Vargraph. One to three operands
    ? * 'VARIANCE'
    ? * Variance. One operand
    ? * 'WEEK'
    ? * Week. One operand
    ? * 'XOR'
    ? * Logical exclusive OR. Two operands
    ? * 'YEAR'
    ? * Year. One operand
    ? * 'ZONED'
    ? * Zoned. One to four operands
    ? *
    ? *
    ? *
    ? * FILD0300 Format (Key Field Information)
    ? *
    ? * FILD0300 provides detailed information for key fields of each record format of the spec
    ? *
    ? * FILD0300 Format
    ? *
    ? *
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? *
    ? * Key Information Header (Qdb_Qdbwh)
    ? *
    ? * The Qdb_Qdbwh section is always located at the beginning of the returned data area.
    ? *
    ? * Description
     d kih             ds            24    based( pkih          ) qualified
    ? * Bytes returned. The total length, in bytes, of the data returned.
     D Byte_Ret                      10i 0                                        0
    ? * Bytes available. The total length, in bytes, of the key information.
     D Byte_Avail                    10i 0                                        4
    ? * Maximum key length. The maximum length, in bytes, of any of the keys.
     D Max_Key_Len                   05i 0                                        8
    ? * File generic key field count.
     D Key_Count                     05i 0                                        10
    ? * Reserved.
     D Reserved                      10                                           12
    ? * Number of formats for the file.
     D Fmt_Counts                    05i 0                                        22
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Record Format Key Information Array (Qdb_Qdbwhrec)
    ? *
    ? * The Qdb_Qdbwhrec section is located immediately after the Qdb_Qdbwh header. This is a l
    ? *
    ? * Description
     d fkia            ds            32    based( pfkia         ) qualified
    ? * Record format name. The name of this particular record format for the file.
     D Rec_Name                      10                                           0
    ? * Reserved.
     D Reserved1                      2                                           10
    ? * Number of record format key fields.
     D Num_Of_Keys                   05i 0                                        12
    ? * Reserved.
     D Reserved2                     14                                           14
    ? * Offset to the key field description array for this record format.
     D Key_Info_Off                  10i 0                                        28
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Key Field Description Array (Qdb_Qdbwhkey)
    ? *
    ? * You can locate the Qdb_Qdbwhkey section with the offset Key_Info_Offset in the Qdb_Qdbw
    ? *
    ? * Description
     d flda            ds            64
    ? * Internal key field name. If this is a logical format, this name is the name of the fiel
     D Int_Field_Name                10                                           0
    ? * External key field name. If this is a physical format, this is the name of the field in
     D Ext_Field_Name                10                                           10
    ? * The data type of this key field.
     D Data_Type                     05i 0                                        20
    ? * The length of this key field.
     D Field_Len                     05i 0                                        22
    ? * The number of digits in this key field. For numeric fields, this is the number of digit
     D Num_Of_Digs                   05i 0                                        24
    ? * The number of decimal positions for this key field.
     D Dec_Pos                       05i 0                                        26
    ? * Key field attributes flags.
     D flag1                          1                                           28
    ? * Descending/ascending sequence indicator.
    ? * Numeric key field sequencing indicator.
    ? * Reserved.
    ? * Alternative collating sequence indicator.
    ? * Force zone sequence indicator.
    ? * Force digit sequence indicator.
    ? * Key statement external or internal name indicator.
    ? * Length of the alternative name. If the length of the alternative name is greater than 3
     D Alt_Name_Len                  05i 0                                        29
    ? * Alternative name (Alias). If the length of the alternative name is greater than 30, thi
     D Alt_Name                      30                                           31
    ? * Reserved.
     D Reserved1                      1                                           61
    ? * Additional key field attribute flags.
     D flag2                          1                                           62
    ? * Allow null value (ALNULL) indicator.
    ? * The alternative name indicator. If the key field has an alternative name, this field wi
    ? * Reserved.
    ? * Reserved.
     D Reserved2                      1                                           63
    ? *
    ? *
    ? *
    ? * FILD0400 Format (Qdb_qdbftrg_head structure)
    ? *
    ? * FILD0400 provides detailed information about triggers defined for a file. FILD0400 Form
    ? *
    ? * Descriptions of the fields in this structure follow FILD0400 Format. The include source
    ? *
    ? * FILD0400 Format
    ? *
    ? *
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? *
    ? * Trigger Information Header (Qdb_qdbftrg_head)
    ? *
    ? * This is the first structure and is located at offset zero of the returned data.
    ? *
    ? * Description
     d tih             ds           704    based( ptih          ) qualified
    ? * Length of the data returned in bytes.
     D Bytes_Returned                10U 0                                        0
    ? * Number of bytes available for the trigger information data.
     D Bytes_Avail                   10U 0                                        4
    ? * Reserved.
     D Reserved1                     52                                           8
    ? * Number of trigger definitions.
     D Num_Trgs                      10U 0                                        60
    ? * Reserved.
     D Reserved2                      8                                           64
    ? * Offset to first trigger definition entry.
     D Off_Ent_Num1                  10U 0                                        72
    ? * Offset to the beginning of the insert group.
     D Off_Ins_Grp                   10U 0                                        76
    ? * Offset to the beginning of the update group.
     D Off_Upd_Grp                   10U 0                                        80
    ? * Offset to the beginning of the delete group.
     D Off_Del_Grp                   10U 0                                        84
    ? * Offset to the beginning of the read group.
     D Off_Read_Grp                  10U 0                                        88
    ? * Reserved.
     D Reserved36                    28                                           92
    ? * Number of SQL triggers.
     D Num_Sql_Trgs                  10U 0                                        120
    ? * Number of native triggers.
     D Num_Ntv_Trgs                  10U 0                                        124
    ? * Number of INSERT/BEFORE triggers.
     D Num_Insb_Trg                  10U 0                                        128
    ? * Number of INSERT/AFTER triggers.
     D Num_Insa_Trg                  10U 0                                        132
    ? * Number of DELETE/BEFORE triggers.
     D Num_Delb_Trg                  10U 0                                        136
    ? * Number of DELETE/AFTER triggers.
     D Num_Dela_Trg                  10U 0                                        140
    ? * Number of UPDATE/BEFORE triggers.
     D Num_Updb_Trg                  10U 0                                        144
    ? * Number of UPDATE/AFTER triggers.
     D Num_Upda_Trg                  10U 0                                        148
    ? * Number of READ/AFTER triggers.
     D Num_Reada_Trg                 10U 0                                        152
    ? * Reserved.
     D Reserved3                    548                                           156
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Trigger Definition Entry Header (Qdb_Qdbftrg_Def_Head)
    ? *
    ? * The number of entries is defined by variable Qdb_Qdbftrg_Num_Trgs in the trigger header
    ? *
    ? * Description
     d tdeh            ds           464    based( ptdeh         ) qualified
    ? * Reserved.
     D Reserved4                     20                                           0
    ? * Length of the entire trigger definition. This includes all structures. This length adde
     D Def_Len                       10U 0                                        20
    ? * Length of the trigger definition header Qdb_Qdbftrg_Def_Head.
     D Head_Len                      10U 0                                        24
    ? * Reserved.
     D Reserved5                     52                                           28
    ? * Trigger program name.
     D Def_Pgm                       10                                           80
    ? * Trigger program library.
     D Def_Lib                       10                                           90
    ? * Reserved.
     D Reserved6                      4                                           100
    ? * Trigger ordinal number.
     D Def_Ord_Num                   10U 0                                        104
    ? * Trigger state.
     D Def_State                      1                                           108
    ? *
    ? * 'E'
    ? * Trigger is enabled.
    ? * 'D'
    ? * Trigger is disabled.
    ? *
    ? * Trigger is operative.
     D Def_Operative                  1                                           109
    ? *
    ? * 'O'
    ? * Trigger is operative.
    ? * 'I'
    ? * Trigger is inoperative.
    ? *
    ? * Trigger type.
     D Def_Type                       1                                           110
    ? *
    ? * 'N'
    ? * Native/System (added using ADDPFTRG).
    ? * 'S'
    ? * SQL (added using CREATE TRIGGER).
    ? *
    ? * Trigger mode. Used only when the trigger type QDBFTRG_DEF_TYPE is set to an SQL trigger
     D Def_Mode                       1                                           111
    ? *
    ? * '00'X
    ? * Not applicable.
    ? * '01'X
    ? * DB2 SQL.
    ? * '02'X
    ? * DB2 Row.
    ? *
    ? * Trigger orientation.
     D Def_Orient                     1                                           112
    ? *
    ? * 'R'
    ? * Row trigger
    ? * 'C'
    ? * Column trigger
    ? *
    ? * Trigger time.
     D Def_Time                       1                                           113
    ? *
    ? * '1'
    ? * After
    ? * '2'
    ? * Before
    ? *
    ? * Trigger event.
     D Def_Event                      1                                           114
    ? *
    ? * '1'
    ? * Insert
    ? * '2'
    ? * Delete
    ? * '3'
    ? * Update
    ? * '4'
    ? * Read
    ? *
    ? * Reserved.
     D Reserved7                     45                                           115
    ? * Offset to the trigger name structure Qdb_Qdbftrg_Name_Area.
     D Off_Trg_Name                  10U 0                                        160
    ? * Reserved.
     D Reserved8                     10U 0                                        164
    ? * Offset to the SQL path structure Qdb_Qdbftrg_Path_Area.
     D Off_Sql_Path                  10U 0                                        168
    ? * Offset to the update columns structure Qdb_Qdbftrg_Updc_Area.
     D Off_Upd_Cols                  10U 0                                        172
    ? * Offset to the structure containing the list of columns referenced in the WHEN condition
     D Off_When_Cols                 10U 0                                        176
    ? * Offset to the structure containing the list of columns referenced in the trigger body Q
     D Off_Body_Cols                 10U 0                                        180
    ? * Offset to the structure containing the list of dependent objects referenced in the trig
     D Off_Dep_Objs                  10U 0                                        184
    ? * Offset to the structure containing the transition tables, Qdb_Qdbftrg_Trns_Area.
     D Off_Transition                10U 0                                        188
    ? * Offset to the structure containing the CREATE TRIGGER statement rQdb_Qdbftrg_Stmt_Area.
     D Off_Trg_Stmt                  10U 0                                        192
    ? * Offset to the structure containing the trigger long comment Qdb_Qdbftrg_Long_Area.
     D Off_Trg_Long                  10U 0                                        196
    ? * Reserved.
     D Reserved9                     64                                           200
    ? * Trigger update condition. For system triggers only (Qdb_Qdbftrg_Def_Type = 'N'). This f
     D     Updcond                    1                                           264
    ? *
    ? * '1'
    ? * Always calls the trigger when updating the file.
    ? * '2'
    ? * Only calls the trigger when the updated values are changed.
    ? *
    ? * Allow repeated change.
     D Allow_Repchg                   1                                           265
    ? *
    ? * X'00'
    ? * *NO (Repeated change not allowed)
    ? * X'01'
    ? * *YES (Repeated change allowed)
    ? *
    ? * Threadsafe indicator.
     D     Threadsafe                 1                                           266
    ? *
    ? * X'00'
    ? * *UNKNOWN (Threadsafe status is not known)
    ? * X'01'
    ? * *NO (Not threadsafe)
    ? * X'10'
    ? * *YES (Threadsafe)
    ? *
    ? * Multithreaded job action indicator
     D     Multijob                   1                                           267
    ? *
    ? * X'00'
    ? * *SYSVAL (default)
    ? * X'01'
    ? * *MSG (Run, diagnostic)
    ? * X'10'
    ? * *NORUN (Escape)
    ? * X'11'
    ? * *RUN (Run, no message)
    ? *
    ? * Old correlation variable indicator. Only applies to SQL triggers.
     D     Old_Tvar                   1                                           268
    ? *
    ? * X'00'
    ? * No
    ? * X'01'
    ? * Yes
    ? *
    ? * New correlation variable indicator. Only applies to SQL triggers.
     D     New_Tvar                   1                                           269
    ? *
    ? * X'00'
    ? * No
    ? * X'01'
    ? * Yes
    ? *
    ? * Old transition table indicator.
     D     Old_Ttable                 1                                           270
    ? *
    ? * X'00'
    ? * No
    ? * X'01'
    ? * Yes
    ? *
    ? * New transition table indicator
     D     New_Ttable                 1                                           271
    ? *
    ? * X'00'
    ? * No
    ? * X'01'
    ? * Yes
    ? *
    ? * Self-referencing indicator. Indicates whether or not the user explicitly specified this
     D     Self_Ref                   1                                           272
    ? *
    ? * X'00'
    ? * Not self-referencing.
    ? * X'01'
    ? * Self-referencing.
    ? *
    ? * Trigger creation timestamp. The format is CYYMMDDHHMMSS.
     D     Crt_Ts                    13                                           273
    ? * User profile that created the trigger.
     D     Crt_User                  10                                           286
    ? * User profile that owns the trigger program. For SQL triggers only.
     D     Pgm_Owner                 10                                           296
    ? * CCSID of the CREATE TRIGGER statement.
     d  Trg_Ccsid                    10u 0                                        306
    ? * Reserved.
     D Reserved34                     1                                           310
    ? * The trigger contains a SET statement that modifies the new correlation variable. (Indic
     D     Mod_Tvar                   1                                           311
    ? *
    ? * X'00'
    ? * No.
    ? * X'01'
    ? * Yes.
    ? *
    ? * Reserved.
     D Reserved10                   152                                           312
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Trigger Definition Name Structure (Qdb_Qdbftrg_Name_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Name_Area section with the offset Qdb_Qdbftrg_Def_Off_Tr
    ? *
    ? * Description
     d tdns            ds           362    based( ptdns         ) qualified
    ? * Reserved.
     D Reserved11                    20                                           0
    ? * Total length of the trigger name area Qdb_Qdbftrg_Name_Area.
     D Area_Tot_Len                  10U 0                                        20
    ? * Length of the trigger library name.
     D      Lib_Len                  10U 0                                        24
    ? * Length of the trigger program name.
     D      Len                      10U 0                                        28
    ? * System-generated trigger name indicator.
     D      Sysgen                    1                                           32
    ? *
    ? * X'00'
    ? * The user specified the trigger name.
    ? * X'01'
    ? * Originally, the user generated the name, but a name collision occurred and the system g
    ? * X'02'
    ? * The system generated the trigger name.
    ? *
    ? * Delimited name indicator. If the trigger name is delimited, it will contain double quot
     D      Delim                     1                                           33
    ? *
    ? * X'00'
    ? * The trigger name is not delimited.
    ? * X'01'
    ? * The trigger name is delimited.
    ? *
    ? * Delimited library name indicator. If the trigger library name is delimited, it will con
     D Lib_Delim                      1                                           34
    ? *
    ? * X'00'
    ? * The trigger library name is not delimited.
    ? * X'01'
    ? * The trigger library name is delimited.
    ? *
    ? * Trigger naming convention.
     D      Type                      1                                           35
    ? *
    ? * X'00'
    ? * System naming.
    ? * X'01'
    ? * SQL naming.
    ? *
    ? * Reserved.
     D Reserved12                    58                                           36
    ? * Qualified trigger name. The trigger name and library name are in two parts. Part 1 is t
     D      Qual                    268                                           94
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * SQL Path Structure (Qdb_Qdbftrg_Path_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Path_Area section with the offset Qdb_Qdbftrg_Def_Off_Sq
    ? *
    ? * Description
     d sps             ds                  based( psps          ) qualified
    ? * Reserved.
     D Reserved13                    20                                           0
    ? * Total length of the SQL path area Qdb_Qdbftrg_Path_Area.
     D Path_Tot_Len                  10U 0                                        20
    ? * Length of the SQL path structure Qdb_Qdbftrg_Path.
     D Path_Len                      10U 0                                        24
    ? * Reserved.
     D Reserved14                    36                                           28
    ? * SQL path. See DB2 UDB for iSeries SQL Reference CURRENT PATH special register for infor
    ?D*Path                            *                                           64
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * UPDATE Columns Structure (Qdb_Qdbftrg_Updc_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Updc_Area section with the offset Qdb_Qdbftrg_Def_Off_Up
    ? *
    ? * Description
     d updatecs        ds            80    based( pupdatecs     ) qualified
    ? * Reserved.
     D Reserved15                    20                                           0
    ? * Total length of the update columns area Qdb_Qdbftrg_Updc_Area.
     D      Tot_Len                  10U 0                                        20
    ? * Number of columns in the list Qdb_Qdbftrg_Updc_List_Struc.
     D      Num_Cols                 10U 0                                        24
    ? * Reserved.
     D Reserved16                    52                                           28
    ? * Update column list structure.
     D
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * UPDATE Columns Entry Structure (Qdb_Qdbftrg_Updc_List_Ent)
    ? *
    ? * The Qdb_Qdbftrg_Updc_List_Ent section maps an entry in the structure Qdb_Qdbftrg_Updc_L
    ? *
    ? * Description
     d updateces       ds           176    based( pupdateces    ) qualified
    ? * Update column list entry length. Addressability to this entry plus Qdb_Qdbftrg_Updc_Le_
     D        Len                    10U 0                                        0
    ? * Short name of the column.
     D Short_Name                    10                                           4
    ? * Short name is delimited indicator.
     D Short_Del                      1                                           14
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Long name is delimited indicator.
     D Long_Del                       1                                           15
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Short name and long name are the same indicator.
     D Long_Same                      1                                           16
    ? *
    ? * X'00'
    ? * Names are different.
    ? * X'01'
    ? * Names are the same.
    ? *
    ? * Length of the long name Qdb_Qdbftrg_Updc_Le_Long_Name.
     D Long_Len                      10U 0                                        17
    ? * Reserved.
     D Reserved17                    27                                           21
    ? * Long name of the column.
     D Long_Name                    128                                            48
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * WHEN Columns Structure (Qdb_Qdbftrg_When_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_When_Area section with the offset Qdb_Qdbftrg_Def_Off_Wh
    ? *
    ? * Description
     d whencs          ds            80    based( pwhencs       ) qualified
    ? * Reserved.
     D Reserved18                    20                                           0
    ? * Total length of the WHEN columns area Qdb_Qdbftrg_When_Area.
     D When_Tot_Len                  10U 0                                        20
    ? * Number of columns in the list Qdb_Qdbftrg_When_List_Struc.
     D When_Num_Cols                 10U 0                                        24
    ? * Whether columns in the WHEN list belong to this file.
     D When_Self_Ref                  1                                           28
    ? *
    ? * X'00'
    ? * All columns belong to the ON table.
    ? * X'01'
    ? * Some of the columns belong to the ON table.
    ? * X'02'
    ? * None of the columns belong to the ON table.
    ? *
    ? * Reserved.
     D Reserved19                    51                                           29
    ? * WHEN column array.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * WHEN Columns Entry Structure (Qdb_Qdbftrg_When_Array)
    ? *
    ? * This Qdb_Qdbftrg_When_Array section maps an entry in the structure Qdb_Qdbftrg_When_Arr
    ? *
    ? * Description
     d whences         ds            64    based( pwhences      ) qualified
    ? * WHEN column name offset into the WHEN portion of the CREATE TRIGGER statement Qdb_Qdbft
     D      Col_Off                  10U 0                                        0
    ? * Length of the column name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_Trg .
     D      Col_Len                  10U 0                                        4
    ? * Offset to the column's file name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_T
     D      File_Off                 10U 0                                        8
    ? * Length of the column's file name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_T
     D      File_Len                 10U 0                                        12
    ? * Offset to the column's library name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Cr
     D      Lib_Off                  10U 0                                        16
    ? * Length of the column's library name in the trigger string Qdb_Qdbftrg_Stmt_Crt_Trg .
     D      Lib_Len                  10U 0                                        20
    ? * Whether the column name is the first in the list of entries.
     D    first_Entry                 1                                           24
    ? *
    ? * X'00'
    ? * Column is not the first in the list.
    ? * X'01'
    ? * Column name is the first in the list.
    ? *
    ? * Whether the column name is in this file.
     D      This_File                 1                                           25
    ? *
    ? * X'00'
    ? * Column is not in this file.
    ? * X'01'
    ? * Column name is in this file.
    ? *
    ? * Whether the column name is a short or long name.
     D      Col_Long                  1                                           26
    ? *
    ? * X'00'
    ? * Column name is short name.
    ? * X'01'
    ? * Column name is long name.
    ? *
    ? * Whether the column name is a delimited name.
     D      Col_Del                   1                                           27
    ? *
    ? * X'00'
    ? * Column name is is not delimited.
    ? * X'01'
    ? * Column name is delimited.
    ? *
    ? * Whether the column's file name is a short or long name.
     D      File_Long                 1                                           28
    ? *
    ? * X'00'
    ? * File name is short name.
    ? * X'01'
    ? * File name is long name.
    ? *
    ? * Whether the column's file name is a delimited name.
     D      File_Del                  1                                           29
    ? *
    ? * X'00'
    ? * File name is not delimited.
    ? * X'01'
    ? * File name is delimited.
    ? *
    ? * Whether the column's library name is a short or long name.
     D      Lib_Long                  1                                           30
    ? *
    ? * X'00'
    ? * Library name is short name.
    ? * X'01'
    ? * Library name is long name.
    ? *
    ? * Whether the column's library name is a delimited name.
     D      Lib_Del                   1                                           31
    ? *
    ? * X'00'
    ? * Columns name is not delimited.
    ? * X'01'
    ? * Column name is delimited.
    ? *
    ? * Reserved.
     D Reserved20                    32                                           32
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * BODY Columns Structure (Qdb_Qdbftrg_Body_Area)
    ? *
    ? * You can locate this Qdb_Qdbftrg_Body_Area section with the offset Qdb_Qdbftrg_Def_Off_B
    ? *
    ? * Description
     d bodycs          ds            80    based( pbodycs       ) qualified
    ? * Reserved.
     D Reserved21                    20                                           0
    ? * Total length of the BODY columns area Qdb_Qdbftrg_Body_Area.
     D      Tot_Len                  10U 0                                        20
    ? * Number of columns in the list Qdb_Qdbftrg_Body_List_Struc.
     D      Num_Cols                 10U 0                                        24
    ? * Whether columns in the body list belong to this file.
     D      Self_Ref                  1                                           28
    ? *
    ? * X'00'
    ? * All self-referencing.
    ? * X'01'
    ? * Some self-referencing.
    ? * X'10'
    ? * Not self-referencing.
    ? *
    ? * Reserved.
     D Reserved22                    51                                           29
    ? * Array used to access the list of BODY referenced columns.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * BODY Columns Entry Structure (Qdb_Qdbftrg_Body_Array)
    ? *
    ? * The Qdb_Qdbftrg_Body_Array section maps an entry in the structure Qdb_Qdbftrg_Body_Arra
    ? *
    ? * Description
     d bodyces         ds            64    based( pbodyces      ) qualified
    ? * BODY column name offset into the BODY portion of the CREATE TRIGGER statement Qdb_Qdbft
     D      Col_Off                  10U 0                                        0
    ? * Length of the column name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_Trg .
     D      Col_Len                  10U 0                                        4
    ? * Offset to the column's file name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_T
     D      File_Off                 10U 0                                        8
    ? * Length of the column's file name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Crt_T
     D      File_Len                 10U 0                                        12
    ? * Offset to the column's library name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Cr
     D      Lib_Off                  10U 0                                        16
    ? * Length of the column's library name in the CREATE TRIGGER statement Qdb_Qdbftrg_Stmt_Cr
     D      Lib_Len                  10U 0                                        20
    ? * Whether the column name is the first in the list of entries.
     D    first_Entry                 1                                           24
    ? *
    ? * X'00'
    ? * Column is not first in the list.
    ? * X'01'
    ? * Column name is first in the list.
    ? *
    ? * Whether the column name is in this file.
     D      This_File                 1                                           25
    ? *
    ? * X'00'
    ? * Column is not in this file.
    ? * X'01'
    ? * Column name is in this file.
    ? *
    ? * Whether the column name is a short or long name.
     D      Col_Long                  1                                           26
    ? *
    ? * X'00'
    ? * Column name is short name.
    ? * X'01'
    ? * Column name is long name.
    ? *
    ? * Whether the column name is a delimited name.
     D      Col_Del                   1                                           27
    ? *
    ? * X'00'
    ? * Column name is is not delimited.
    ? * X'01'
    ? * Column name is delimited.
    ? *
    ? * Whether the column's file name is a short or long name.
     D      File_Long                 1                                           28
    ? *
    ? * X'00'
    ? * File name is short name.
    ? * X'01'
    ? * File name is long name.
    ? *
    ? * Whether the column's file name is a delimited name.
     D      File_Del                  1                                           29
    ? *
    ? * X'00'
    ? * File name is not delimited.
    ? * X'01'
    ? * File name is delimited.
    ? *
    ? * Whether the column's library name is a short or long name.
     D      Lib_Long                  1                                           30
    ? *
    ? * X'00'
    ? * Library name is short name.
    ? * X'01'
    ? * Library name is long name.
    ? *
    ? * Whether the column's library name is a delimited name.
     D      Lib_Del                   1                                           31
    ? *
    ? * X'00'
    ? * Columns name is not delimited.
    ? * X'01'
    ? * Column name is delimited.
    ? *
    ? * Reserved.
     D Reserved23                    32                                           32
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Dependent Objects Structure (Qdb_Qdbftrg_Depo_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Depo_Area section with the offset Qdb_Qdbftrg_Def_Off_De
    ? *
    ? * Description
     d depobj          ds            80    based( pdepobj       ) qualified
    ? * Reserved.
     D Reserved24                    20                                           0
    ? * Total length of the dependent objects area Qdb_Qdbftrg_Depo_Area.
     D      Tot_Len                  10U 0                                        20
    ? * Number of dependent object offsets in Qdb_Qdbftrg_Depo_Array. These are offsets into th
     D      Num_Off                  10U 0                                        24
    ? * Whether this file is referenced at least once somewhere in the WHEN or BODY. This is a
     D      Self_Ref                  1                                           28
    ? *
    ? * X'00'
    ? * Not self-referencing.
    ? * X'01'
    ? * Is self-referencing.
    ? *
    ? * Reserved.
     D Reserved25                    51                                           29
    ? * Update column list structure.
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Dependent Objects Entry Structure (Qdb_Qdbftrg_Depo_Array)
    ? *
    ? * The Qdb_Qdbftrg_Depo_Array section maps an entry in the structure Qdb_Qdbftrg_Depo_Arra
    ? *
    ? * Description
     d DepObjES        ds            64    based( pdepobjes     ) qualified
    ? * Type of dependent object.
     D       Type                     2                                           0
    ? *
    ? * 'TB'
    ? * Table
    ? * 'PF'
    ? * Physical File
    ? * 'VW'
    ? * View
    ? * 'LF'
    ? * Logical File
    ? * 'IX'
    ? * Index
    ? * 'UF'
    ? * User Defined Function
    ? * 'UT'
    ? * User Defined Type
    ? * 'PR'
    ? * Procedure
    ? * 'AL'
    ? * Alias
    ? *
    ? * Offset to the dependent object relative to the beginning of the CREATE TRIGGER string Q
     D       Off                     10U 0                                        2
    ? * Length of the dependent object in the CREATE TRIGGER string Qdb_Qdbftrg_Stmt_Crt_Trg .
     D       Len                     10U 0                                        6
    ? * Offset to the qualifying library name of the dependent object. Offset relative from the
     D       Lib_Off                 10U 0                                        10
    ? * Length of the qualifying library name of the dependent object. A length of 0 indicates
     D       Lib_Len                 10U 0                                        14
    ? * Whether the object name is the first in the list of entries. Criteria is based on objec
     Dfirst_Entry                     1                                           18
    ? *
    ? * X'00'
    ? * Object is 2nd or greater occurance in the list.
    ? * X'01'
    ? * Object is the first in the list.
    ? *
    ? * Whether the object is this file.
     D This_File                      1                                           19
    ? *
    ? * X'00'
    ? * Object is not this file.
    ? * X'01'
    ? * Object name is this file.
    ? *
    ? * Whether the object name is is a short or long name.
     D       Obj_Long                 1                                           20
    ? *
    ? * X'00'
    ? * Object name is short name.
    ? * X'01'
    ? * Object name is long name.
    ? *
    ? * Whether the object name is a delimited name.
     D       Obj_Del                  1                                           21
    ? *
    ? * X'00'
    ? * Object name is is not delimited.
    ? * X'01'
    ? * Object name is delimited.
    ? *
    ? * Whether the library's name is a short or long name.
     D       Lib_Long                 1                                           22
    ? *
    ? * X'00'
    ? * Library name is short name.
    ? * X'01'
    ? * Library name is long name.
    ? *
    ? * Whether the library's name is a delimited name.
     D       Lib_Del                  1                                           23
    ? *
    ? * X'00'
    ? * Library name is not delimited.
    ? * X'01'
    ? * Library name is delimited.
    ? *
    ? * Reserved.
     D  Reserved26                   40                                           24
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Transition Area Structure (Qdb_Qdbftrg_Trns_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Trns_Area section with the offset Qdb_Qdbftrg_Def_Off_Tr
    ? *
    ? * Description
     d trns            ds                  based( ptrns         ) qualified
    ? * Reserved.
     D Reserved27                    20                                           0
    ? * Total length of the transition area Qdb_Qdbftrg_Trns_Area.
     D      Tot_Len                  10U 0                                        20
    ? * Old correlation variable name length.
     D Oldvar_Len                    10U 0                                        24
    ? * New correlation variable name length.
     D Newvar_Len                    10U 0                                        28
    ? * Old transition table name length.
     D Oldtbl_Len                    10U 0                                        32
    ? * New transition table name length.
     D Newtbl_Len                    10U 0                                        36
    ? * Old correlation variable name offset.
     D Oldvar_Off                    10U 0                                        40
    ? * New correlation variable name offset.
     D Newvar_Off                    10U 0                                        44
    ? * Old transition table name offset.
     D Oldtbl_Off                    10U 0                                        48
    ? * New transition table name offset.
     D Newtbl_Off                    10U 0                                        52
    ? * Whether the old correlation variable name is delimited.
     D Oldvar_Del                     1                                           56
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Whether the new correlation variable name is delimited.
     D Newvar_Del                     1                                           57
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Whether the old table name is delimited.
     D Oldtbl_Del                     1                                           58
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Whether the new table name is delmited.
     D Newtbl_Del                     1                                           59
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Length of the transition names Qdb_Qdbftrg_Trns_Names.
     D      Names_Len                10U 0                                        60
    ? * Reserved.
     D Reserved28                    48                                           64
    ? * Old/new transition variable/table names.
    ?D*Trns_Names                      *                                           112
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Trigger Statement Area (Qdb_Qdbftrg_Stmt_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Stmt_Area section with the offset Qdb_Qdbftrg_Def_Off_Tr
    ? *
    ? * Description
     d stmt            ds           112    based( pstmt         ) qualified
    ? * Reserved.
     D Reserved29                    20                                           0
    ? * Total length of the statement area.
     D Tot_Len                       10U 0                                        20
    ? * Offset to the user-specified file table name in the CREATE TRIGGER statement Qdb_Qdbftr
     D Onfile_Off                    10U 0                                        24
    ? * Length of the qualified library file name of the ON file/TABLE name, including the peri
     D Onfile_Len                    10U 0                                        28
    ? * Whether the ON table/file name is delimited.
     D Onfile_Del                     1                                           32
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Whether the ON library name is delimited.
     D      Onlib_Del                 1                                           33
    ? *
    ? * X'00'
    ? * Name is not delimited.
    ? * X'01'
    ? * Name is delimited.
    ? *
    ? * Whether the ON table/file name is a long name.
     D Onfile_Long                    1                                           34
    ? *
    ? * X'00'
    ? * Name is not a long name.
    ? * X'01'
    ? * Name is a long name.
    ? *
    ? * Reserved.
     D Reserved30                     1                                           35
    ? * Length of the SQL CREATE TRIGGER string in variable Qdb_Qdbftrg_Stmt_Crt_Trg .
     D Crt_Trg_Len                   10U 0                                        36
    ? * Length of the WHEN clause for the SQL CREATE TRIGGER string in variable Qdb_Qdbftrg_Crt
     D When_Len                      10U 0                                        40
    ? * Offset to the WHEN clause of the SQL CREATE TRIGGER string in variable Qdb_Qdbftrg_Stmt
     D      When_Off                 10U 0                                        44
    ? * Length of the BODY portion of the SQL CREATE TRIGGER string in variable Qdb_Qdbftrg_Stm
     D      Body_Len                 10U 0                                        48
    ? * Offset to the BODY portion of the SQL CREATE TRIGGER string in variable Qdb_Qdbftrg_Stm
     D      Body_Off                 10U 0                                        52
    ? * Reserved.
     D Reserved31                    56                                           56
    ? * SQL CREATE TRIGGER string.
    ?D*Stmt_Crt_Trg                    *                                           112
    ? *=-----------------------------------------------------------------------------------------=*
    ? *
    ? * Trigger Long Comment Area (Qdb_Qdbftrg_Long_Area)
    ? *
    ? * You can locate the Qdb_Qdbftrg_Long_Area section with the offset Qdb_Qdbftrg_Def_Off_Tr
    ? *
    ? * Description
     d long            ds            64    based( plong         ) qualified
    ? * Reserved.
     D Reserved32                    20                                           0
    ? * Total length of the long comment area Qdb_Qdbftrg_Long_Area.
     D      Tot_Len                  10U 0                                        20
    ? * Length of the trigger long comment that is located in variable Qdb_Qdbftrg_Long_Comment
     D      Len                      10U 0                                        24
    ? * CCSID of the long comment in Qdb_Qdbftrg_Long_Comment.
     D  Long_Ccsid                    5U 0                                        28
    ? * Reserved.
     D Reserved33                    34                                           30
    ? * Trigger long comment.
    ?D*Long_Comment                1000                                            64
    ? *
    ? *=-----------------------------------------------------------------------------------------=*

      /free
       //?* programme principal
       //?* initialisation g{n{rale
       len = 50000 ;
       pReceiver = %alloc(len ) ;
       pfh = pReceiver ;
       clear error_code;
       error_code.provided=%size(error_code);


       FormatAPI     =  'FILD0100' ;
       search_file = filename ;
       format_name   =  '*FIRST'   ;
       Override      =  '0'        ;
       System_Input  =  '*LCL'     ;
       Format_type   =  '*EXT'     ;
       //?reclaim all data form a file
       QDBRTVFD ( receiver
          : len
          : actual_file
          : FormatAPI
          : search_file
          : format_name
          : Override
          : System_Input
          : Format_type
          : Error_Code );

B01    if error_code.available > 0;
          message(error_code.msgid:error_code.msgdta
             :'':'QCPFMSG':'*ESCAPE':'': 3);
E01    endif;

       // dump(a);

       write header;
       dspparms();
       dspfh();
       //?284 to the IDDU/SQL Data Dictionary area
B01    if fh.odic <> 0;
          pdic = pfh + fh.odic;
          dspdic();
          //?to the SQL long/alias file names area
B02       if dic.olng <> 0;
             palias = pfh + dic.olng;
             dspalias();
E02       endif;
E01    endif;
       //?316 to the file scope array
B01    if fh.os <> 0;//?repeat
B02       for ifsa = 0 to fh.lbnum-1;
             pfsa = pfh + fh.os + ifsa*%size(fsa);
             dspfsa();
             //?add a format to the format list
             iFmt+=1;
             fmtlist.fmt(ifmt)= fsa.t;
B03          // if fsa.bf = *loval;
                fmtlist.lib(ifmt) = %subst(actual_file:11:10);
                fmtlist.file(ifmt)=%subst(actual_file:01:10);
X03          // else;
             //    fmtlist.lib(ifmt) = fsa.bfl;
             //    fmtlist.file(ifmt)=fsa.bf;
E03          // endif;
             //?to the select/omit specification array
B03          if fsa.soof <> 0;//?repeat
B04             for iSosa = 0 to fsa.soon - 1;
                   psosa = pfh + fsa.soof + iSosa*%size(sosa);
                   dspsosa ();
                   //?to the select/omit parameters
B05                if sosa.soso <> 0;//?repeat
                      psop = psosa + 28;//?à 1st sop : in sosa
B06                   dow sop.spno <> 0;
                         psop = pfh + sop.spno;
                         dspsop ();
E06                   enddo;
E05                endif;
E04             endfor;
E03          endif;
             //?to the key specification array
B03          if fsa.ksof <> 0 ;//?repeat
B04             for iKsa = 0 to fsa.bgky - 1;
                   pksa = pfh + fsa.ksof + iKsa*%size(ksa);
                   dspksa();
E04             endfor;
E03          endif;
             //?to the distributed file definition
B03          if fsa.odis <> 0;
                pdf = pfh + fsa.odis;
                dspdf();
B04             if df.nkyn <> 0;
B05                for iPka = 0 to df.nkyn - 1;
                      ppka = pdf + 64 + iPka*32;
                      dsppka();
E05                endfor;
E04             endif;
E03          endif;
E02       endfor;
E01    endif;
       //?328 to the alternative collating sequence table section
B01    if fh.ocs <> 0;
          pacs = pfh + fh.ocs;
          dspacs();
E01    endif;
       //?364 to the physical file specific attributes section
B01    if fh.qdbpfof <> 0;
          pPhys = pfh + fh.qdbpfof;
          dspphys();
          //? 3 to the Partitioned Table area
B02       if phys.off_sqpt <> 0;
             ppth = pfh + phys.off_sqpt;
             dsppth();
B03          if pth.Part_Offset <> 0;//?repeat
                pptar=ppth + pth.Part_Offset;
                dspptar();
B04             if ptar.range_offset <> 0;//?repeat
                   pprka = pptar + ptar.range_offset;
                   dspprka();
E04             endif;
E03          endif;
B03          if pth.hk_offset <> 0;
                pphhka = ppth + pth.hk_offset;
                dspphhka();
B04             if phhka.Head_Num_Keys <> 0;//?repeat
                   pphka = pphhka + 64;
                   dspphka();
E04             endif;
E03          endif;
E02       endif;
          //?19 to the Record ID Codes
B02       if phys.orid <> 0;
             prtb = pfh + phys.orid ;
             dsprtb();
B03          for i = 0 to rtb.drnum - 1;
                prca = prtb + 16 + i*32;
                dsprca();
E03          endfor;
E02       endif;
          //?24 to the trigger description area
B02       if phys.otrg <> 0;
             ptrg = pfh + phys.otrg;
             dsptrg();
E02       endif;
          //?30 to the constraint definition area
B02       if phys.ofcs <> 0;
             pconstraint= pfh + phys.ofcs;
             dspconstraint();
             //?to the next section
B03          if constraint.csto <> 0;
                pconstraint += constraint.csto;//?repeat
                dspconstraint();
                //?loop on Constraint Keys (Qdb_Qdbf_Keyn), Key Name Array (Qdb_Qdbf_Narray)
                //?Referential Constraint Definition (Qdb_Qdbf_Riafk_Afkd)
E03          endif;
E02       endif;
          //?38 to the datalinks area
B02       if phys.odl <> 0;
             pdtalnk = pfh + phys.odl;
             dspdtalnk();
B03          if dtalnk.dlocole <> 0;
                pdtalnkcom = pdtalnk + dtalnk.dlocole;
                dspdtalnkcom();
E03          endif;
E02       endif;
          //?42 to the SQL area
B02       if phys.ovw_mqt <> 0;
             psqla = pfh + phys.ovw_mqt;
             dspsqla();
B03          if sqla.mqtd_o <> 0;
                pmqtdh = pfh + sqla.mqtd_o;
                dspmqtdh();
                pmqtde = pmqtdh + 64;
B04             for i = 0 to mqtdh.mqtd___deps - 1;
                   dspmqtde();
                   pmqtde +=mqtde.mqtd_len;
E04             endfor;
E03          endif;
E02       endif;
E01    endif;

       //?368 to the logical file specific attributes section
B01    if fh.qdblfof <> 0;
          pLogL = pfh + fh.qdblfof;
          dsplogl();
          //?0  to the join specifications
B02       if logl.oj <> 0;
             pjs = plogl;//?start js à is at 0 of logl, and at 0 of js.
B03          dow (js.jnho <> 0);
                pjs = pfh + js.jnho;
                dspjs();
                //?40 to the join specification array
B04             if js.jknum > 0;
B05                for i = 0 to js.jknum - 0;
                      pjfld = pfh + js.jsao;
                      dspjfld();
E05                endfor;
E04             endif;
                //?44 to the join duplicate sequence array
B04             if js.jdnum > 0;
B05                for i = 0 to js.jdnum - 0;
                      pjdup = pfh + js.jdao;
                      dspjdup();
E05                endfor;
E04             endif;
E03          enddo;
E02       endif;
          //?26 to the SQL area
B02       if logl.ovw <> 0;
             psqla = pfh + logl.ovw ;
             dspsqla();
B03          if sqla.mqtd_o <> 0;
                pmqtdh = pfh + sqla.mqtd_o;
                dspmqtdh();
                pmqtde = pmqtdh + 64;
B04             for i = 0 to mqtdh.mqtd___deps - 1;
                   dspmqtde();
                   pmqtde +=mqtde.mqtd_len;
E04             endfor;
E03          endif;
E02       endif;
E01    endif;
       //?378 to the journal section
B01    if fh.jorn <> 0;
          pjoal = pfh + fh.jorn;
          dspjoal();
E01    endif;

       structure('list of file formats');
B01    for i = 1 to ifmt;
          fld('Format name':
             %trim(fmtlist.lib(i))+'/' + %trim(fmtlist.file(i)) + '('
             + %trim(fmtlist.fmt(i)) + ')' );
E01    endfor;



       pformat = pReceiver ;
       clear error_code;
       error_code.provided=%size(error_code);

       FormatAPI    =   'FILD0200'   ;
       Override     =   '0'     ;
       System_Input =   '*LCL'   ;
       Format_type  =   '*EXT'    ;


B01    for i = 1 to ifmt;
          search_file = fmtlist.file(i) + fmtlist.lib(i) ;
          format_name = fmtlist.fmt(i) ;
          //?reclaim each format description
          QDBRTVFD ( receiver
             : len
             : actual_file
             : FormatAPI
             : search_file
             : format_name
             : Override
             : System_Input
             : Format_type
             : Error_Code );

B02       if error_code.available > 0;
             message(error_code.msgid:error_code.msgdta
                :'':'QCPFMSG':'*ESCAPE':'': 3);
E02       endif;

       // dump(a);


          dspparms();
          dspformat();
          //?33 to the translate table specifications
B02       if format.xlto <> 0;
             pxl = pformat + format.xlto;
             dspxl();
E02       endif;
          //?37 to the case selection specifications
B02       if format.rcao <> 0;
             pcase = pformat + format.rcao;
             dspcase();
E02       endif;
          //?41 to the IDDU/SQL dictionary format information
B02       if format.dico <> 0;
             pdicfi= pformat + format.dico;
             dspdicfi();
E02       endif;
          //?145 to the identity information
B02       if format.Identity_Off <> 0;
             pidcol= pformat + format.Identity_Off ;
             dspidcol();
E02       endif;
          //?256 fields
          pfield = pformat+256 ;
B02       for iFld = 0 to format.fldnum-1;
             dspfield();
             //?180 to the complex field information
B03          if field.cplx <> 0;
                pcplx=pfield+field.cplx;
                dspcplx();
E03          endif;
             //?190 to the IDDU/SQL dictionary field information
B03          if field.dicd <> 0;
                pdicfdi = pfield + field.dicd ;
                dspdicfdi ();
E03          endif;
             //?194 to the default value description
B03          if field.dftd <> 0;
                pdefault = pfield + field.dftd ;
                dspdefault ();
E03          endif;
             //?198 to the derived field description
B03          if field.derd <> 0;
                pdrvh = pfield + field.derd ;
                dspdrvh ();
                //?  6 to the derived field text
B04             if drvh.dvot <> 0;
                   pdrvft = pdrvh + drvh.dvot ;
                   dspdrvft ();
E04             endif;
                //?4 Number of derived field entries
B04          // for iFop = 0 to drvh.dvnume-1;
             //    pfldop = pdrvh + 16 + iFop * drvh.dvtl ;
             //    dspfldop();
E04          // endfor;
E03          endif;
             //?208 to the field text description
B03          if field.txtd <> 0;
                pfldtxt = pfield + field.txtd ;
                dspfldtxt ();
E03          endif;
             //?214 to the field reference information
B03          if field.refd <> 0;
                prefinf = pfield + field.refd ;
                dsprefinf ();
E03          endif;
             //?220 to the edit code/edit word information
B03          if field.edtd <> 0;
                pedtwrd = pfield + field.edtd ;
                dspedtwrd ();
E03          endif;
             //?226 to the column heading information
B03          if field.chd <> 0;
                pcolhdg = pfield + field.chd ;
                dspcolhdg ();
E03          endif;
             //?232 to the validity checking data
B03          if field.vckd <> 0;
                pchecki = pfield + field.vckd ;
                dspchecki ();
                pchecke = pchecki + 16;
B04             for iChke = 0 to checki.vcnume-1;
                   dspchecke();
                   pcheckp = pchecke+16;
B05                for iChkp = 0 to checke.vcnump-1;
                      dspcheckp();
                      pcheckp+=checkp.vcpl;
E05                endfor;
                   pchecke+=checke.vcel;
E04             endfor;
E03          endif;
             //?236 to the alias name entry
B03          if field.xals <> 0;
                paliasns = pfield + field.xals ;
                dspaliasns ();
E03          endif;
             //?240 to the field prompted numeric editing information
B03          if field.fpnd <> 0;
                pedit = pfield + field.fpnd ;
                dspedit ();
E03          endif;
             pfield+=field.defl;
E02       endfor;
E01    endfor;

















       dealloc pReceiver;
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?begsr        ;



       //?endsr;
       //?---------------------------------------------------------------
      /end-free
    ? *----------------------------------------------------------------
    ? * *inzsr, sr pmqsnd, sp *pssr , ...
    ? *----------------------------------------------------------------
EPR   /free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc


      /end-free
    ? *=-----------------------------------------------------------------------------------------=*
BPR  p structure       b
     d structure       pi
     d name                         100    varying const
      /free
       info = *all'-'  ;
       write line;
       info = name;
       write line;
       info = *all'-'  ;
       write line;
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR  p fld             b
     d fld             pi
     d name                         100    varying const
     d value                        100    varying const
     d equal_p                        1    varying const options(*nopass)
     d hashexa         s               n   static
     d i               s             10i 0 static
     d printvalue      s            100    varying static
     d equal           s              1
      /free
       if %parms >= 3 ;
       equal = equal_p;
       else;
       equal = '=';
       endif;
       hashexa = false;
B01    for i = 1 to %len(value);
B02       if %subst(value : i : 1 ) < ' ';
             hashexa = true;
             leave;
E02       endif;
E01    endfor;
B01    if hashexa;
B02       if %len(value) > 50;
             printvalue = hexa(%subst(value: 1 : 50));
X02       else;
             printvalue = hexa(value);
E02       endif;
X01    else;
          printvalue = value;
E01    endif;
B01    if %len(name) + %len(printvalue) < 130;
          info = name + equal + printvalue;
          write line;
X01    else;
          info = name;
          write line;
          info = '                             '+ equal + printvalue;
          write line;
E01    endif;
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR  p hexa            b
     d hexa            pi           100    varying
     d  char                         50    varying value
     d value           s            100    varying
     D len1            s             10i 0
    ? * returns char representation of any hexadecimal string
     D Chr2Hex         Pr                  ExtProc('cvthc')
     D  Tgt                            *   value
     D  Src                            *   value
     D  TgtLen                       10i 0 Value
      /free

       len1= %len(char)*2 ;
       %len(value)=len1;
       chr2hex (%addr(Value)+2 :%addr(char)+2 : len1) ;
       return  'X'''+value +'''';
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR  p dspparms        b
     d dspparms        pi
      /free
       structure('API parameters');
       fld('Qualified returned file name'         :actual_file );
       fld('Format name'                          :FormatAPI               );
       fld('Qualified file name'                  :search_file             );
       fld('Record format name'                   :format_name             );
       fld('Override processing'                  :Override                );
       fld('System'                               :System_Input            );
       fld('Format type'                          :Format_type             );
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR  p dspfh           b
     d dspfh           pi
      /free
       structure('File Definition Header (Qdb_Qdbfh)');
       fld('Length of the data returned in bytes':
          %char(fh.yret));
       fld('number of bytes provided for the file definition data':
          %char(fh.yavl));
       fld('Attributes bytes'
          :hexa( fh.flg ));
       fld('Number of data members.'
          :%char( fh.lbnum));
       fld('Number of key fields for the file'
          :%char( fh.knum));
       fld('Maximum key length for the file'
          :%char(fh.kmxl));
       fld('Keyed sequence access path attributes'
          :hexa( fh.kflg ));
       fld('Access path maintenance (MAINT)'
          : fh.kfdm );
       fld('Public authority (AUT)'
          :fh.aut );
       fld('Preferred storage unit (UNIT)'
          :hexa( fh.upl ));
       fld('Maximum members (MAXMBRS)'
          :%char( fh.mxm ));
       fld('Maximum file wait time (WAITFILE)'
          :%char( fh.wtfi ));
       fld('Records to force a write (FRCRATIO)'
          :%char( fh.frt ));
       fld('Number of members'
          :%char( fh.mnum ));
       fld('Maximum record wait time (WAITRCD)'
          :%char( fh.brwt ));
       fld('Additional attribute flags'
          : hexa( fh.Qaaf ));
       fld('Total number of record formats'
          :%char(fh.fmtnum ));
       fld('Additional attribute flags'
          : hexa(fh.fl2));
       fld('supported version'
          :%char( fh.vrm ));
       fld('Additional attribute flags'
          : hexa( fh.Qaaf2 ));
       fld('File level identifier'
          : fh.crt );
       fld('Text description (TEXT)'
          : fh.txt ) ;
       fld('Source file name'
          : fh.srcf );
       fld('Source file member name'
          : fh.srcm );
       fld('Source file library name'
          : fh.srcl );
       fld('Access path recovery (RECOVER)'
          : fh.krcv );
       fld('CCSID for text description'
          :%char( fh.tcid ));
       fld('Auxiliary storage pool (ASP)'
          : hexa(fh.asp));
       fld('Complex objects flags'
          :hexa( fh.nbit ));
       fld('Maximum number of fields'
          :%char( fh.mxfnum ));
       fld('Offset to the IDDU/SQL Data Dictionary'
          : %char( fh.odic ));
       fld('File generic key length'
          :%char( fh.figl));
       fld('Maximum record length'
          :%Char( fh.mxrl ));
       fld('File generic key field count'
          :%char(fh.gkct));
       fld('Offset to the file scope array, Qdbfb'
          :%char( fh.os ));
       fld('Offset to the alternative collating sequence'
          :%char( fh.ocs ));
       fld('Access path type'
          : fh.pact );
       fld('File version'
          : fh.rls );
       fld('Offset to the physical file specific attributes'
          :%char( fh.Qdbpfof ));
       fld('Offset to the logical file specific attributes'
          :%char( fh.Qdblfof ));
       fld('Flags'
          :hexa(fh.nlsb));
       fld('Language identifier (LANGID)'
          : fh.lang );
       fld('Country or region identifier (CNTRYID)'
          : fh.cnty );
       fld('Offset to the journal section'
          :%char( fh.jorn ));
       fld('Initial distinct values for encoded vector'
          :%char( fh.evid ));
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*





BPR  p dspphys         b
     d dspphys         pi
      /free
       structure('Physical File Specific Attributes (Qdb_Qdbfphys)');
       fld('Allocate/contiguous storage (ALLOCATE and CONTIG)'
          :phys.palc);
       fld('Maximum percentage of deleted records allowed (DLTPCT).'
          :phys.cmps);
       fld('offset to the Partitioned Table area'
          :%char(phys.off_sqpt));
       fld('Initial number of records (SIZE).'
          :%char(phys.prnum));
       fld('Increment number of records (SIZE).'
          :%char(phys.pri));
       fld('Maximum number of increments (SIZE).'
          :%char(phys.prinum));
       fld('Offset to the Record ID Codes'
          :%char(phys.orid));
       fld('Flags.'
          : hexa(phys.Qflags));
       fld('Offset to the trigger description area'
          :%char(phys.otrg));
       fld('Number of triggers.'
          :%char(phys.trgn));
       fld('Offset to the constraint definition area'
          :%char(phys.ofcs));
       fld('Number of constraints for the file.'
          :%char(phys.cstn));
       fld('Offset to the datalinks area'
          :%char(phys.odl));
       fld('offset to the SQL area'
          :%char(phys.ovw_mqt));
B00    begsr *pssr;
       dump;
E00    endsr;
      /end-free
EPR  p                 e
BPR  p  dsptrg         b
     d  dsptrg         pi
      /free
       structure('Trigger Description Area (Qdb_Qdbftrg)');
       fld('Trigger time.'
          :trg.trgt);
       fld('Trigger event.'
          :trg.trge);
       fld('Trigger program name.'
          :trg.tpgm);
       fld('Trigger program library name.'
          :trg.tplb);
       fld('Trigger update condition.'
          :trg.tupd);
       fld('Trigger flags.'
          : hexa(trg.trgf));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspconstraint   b
     d dspconstraint   pi
      /free
       structure('Constraint Definition Header (Qdb_Qdbf_Constraint)');
       fld('Offset to the next section for this constraint.'
          :%char(constraint.csto));
       fld('Constraint entry header length in bytes.'
          :%char(constraint.hlen));
       fld('Constraint type (TYPE)'
          :constraint.type);
       fld('Check pending attribute.'
          :constraint.chkpd);
       fld('Constraint state.'
          :constraint.state);
       fld('Constraint enablement.'
          :constraint.abled);
       fld('Constraint date'
          :constraint.add_ts);
       fld('Constraint library name.'
          :constraint.cst_lin);
       fld('Constraint name (delimited) length'
          :%char(constraint.cst_lp2));
       fld('Constraint name (CST).'
          :constraint.cst_name);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspkeyn         b
     d dspkeyn         pi
      /free
       structure('Constraint Keys (Qdb_Qdbf_Keyn)');
       fld('Constraint key structure length'
          :%char(keyn.kslen));
       fld('Number of keys'
          :%char(keyn.nokys));
       fld('Constraint key length.'
          :%char(keyn.klen));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspNarray       b
     d dspNarray       pi
      /free
       structure('Key Name Array (Qdb_Qdbf_Narray)');
       fld('Key name (PRNKEY KEY)'
          :Narray.kname);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspriafk        b
     d dspriafk        pi
      /free
       structure('Referential Constraint Definition (Qdb_Qdbf_Riafk_Afkd)');
       fld('Parent file name.'
          :riafk.pkfn);
       fld('Parent file library name.'
          :riafk.pkln);
       fld('Reserved.'
          :riafk.Revcst_3);
       fld('Delete rule (DLTRULE).'
          :riafk.fkcdr);
       fld('Update rule (UPDRULE)'
          :riafk.fkcur);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspchkcst       b
     d dspchkcst       pi
      /free
       structure('Check Constraint (Qdb_Qdbf_Chk_Cst)');
       fld('Check constraint structure length'
          :%char(chkcst.chkcst_len));
       fld('Check constraint expression length'
          :%char(chkcst.chkexpr_len));
       fld('Check constraint expression'
          :chkcst.chkexpr);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdtalnk       b
     d dspdtalnk       pi
      /free
       structure('Datalink Header (Qdb_Qdbfdtalnk)');
       fld('Number of datalink columns with links to servers.'
          :%char(dtalnk.dlcoln));
       fld('Offset to the first datalink column entry, (Qdb_Qdbfdl'
          :%char(dtalnk.dlocole));
       fld('Link pending attribute'
          :dtalnk.dllnkp);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdtalnkcom    b
     d dspdtalnkcom    pi
      /free
       structure('Datalink Column Entry (Qdb_Qdbfdlcole)');
       fld('Length of this datalink column entry'
          :%char(dtalnkcom.dlcelen));
       fld('Number of servers linked for this column.'
          :%char(dtalnkcom.dlsevn));
       fld('Column name.'
          :dtalnkcom.dlcolnm);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsprtb          b
     d dsprtb          pi
      /free
       structure('Record ID Codes (Qdb_Qdbfdrtb)');


       fld('Number of record ID code array entries'
          :%char(rtb.drnum));
       fld('Size of this record ID code table in bytes'
          :%char(rtb.drtl));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsprca          b
     d dsprca          pi
      /free
       structure('Record ID Codes Array (Qdb_Qdbfdrae)');
       fld('External name.'
          :rca.drnm);
       fld('Relative field position'
          :%char(rca.drrp));
       fld('Comparison operator.'
          :rca.drco);
       fld('Length of test value'
          :%char(rca.drln));
       fld('Test value.'
          :rca.drtv);
       fld('AND/OR/last operator.'
          :rca.drao);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsplogl         b
     d dsplogl         pi
      /free
       structure('Logical File Specific Attributes (Qdb_Qdbflogl)');
       fld('Offset to the join specifications'
          :%char(logl.oj));
       fld('number of select/omit'
          :%char(logl.scsn));
       fld('Record format selector program (FMTSLR)'
          :logl.lxp);
       fld('Record format selector program library (FMTSLR)'
          :logl.lxl);
       fld('Offset to the SQL area'
          :%char(logl.ovw));
       fld('Logical file attributes flags'
          : hexa(logl.Qlfa));
       fld('Join file type.'
          :logl.jtyp);
       fld('CCSID for select/omit constants.'
          :%char(logl.srcd));
       fld('With check option.'
          :logl.wchk);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspjs           b
     d dspjs           pi
      /free
       structure('Join Specifications (Qdb_Qdbfj)');
       fld('Offset to the join specifications'
          :%char(js.jnho));
       fld('Number of JFLD'
          :%char(js.jknum));
       fld('Number of JDUPSEQ'
          :%char(js.jdnum));
       fld('Join from-file number (JOIN)'
          :%char(js.jffnum));
       fld('Join to-file number (JOIN)'
          :%char(js.jtfnum));
       fld('Offset to the join specification array'
          :%char(js.jsao));
       fld('Offset to the join duplicate sequence array'
          :%char(js.jdao));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspjfld         b
     d dspjfld         pi
      /free
       structure('Join Specification Array (Qdb_Qdbfjfld)');
       fld('Join from-field-name (JFLD)'
          :jfld.jfnm);
       fld('Join from-field reference number.'
          :%char(jfld.jfnum));
       fld('Join operation'
          :jfld.jop);
       fld('Join to-field name (JFLD).'
          :jfld.jtnm);
       fld('Join to-field reference number.'
          :%char(jfld.jtnum));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspjdup         b
     d dspjdup         pi
      /free
       structure('Join Duplicate Sequence Specification Array (Qdb_Qdbfjdup)');
       fld('Join specification field name (JDUPSEQ).'
          :jdup.jdnm);
       fld('Join sequence field name reference number.'
          :%char(jdup.jdjnum));
       fld('Join sequencing field name flags'
          : hexa(jdup.Qjsfna));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspsqla         b
     d dspsqla         pi
     d i               s             10i 0
     d i2              s             10i 0
      /free
       structure('SQL Area (Qdb_Qdbfv)');


       fld('Starting offset of the SELECT '
          :%char(sqla.vs_start));
       fld('Ending offset of the SELECT '
          :%char(sqla.vs_end));
       fld('CCSID for the Select Statement'
          :%char(sqla.vs_ccsid));
       fld('offset to the SQL materialized query table dependency area'
          :%char(sqla.mqtd_o));
       fld('isolation level for the SQL materialized query table'
          :sqla.mqt_cmt);
       fld('Flags.'
          : hexa(sqla.vflgs));
       fld('Select statement length.'
          :%char(sqla.vssl));
       fld('SQL select statement.'
          :' ');
          for i = 1 to sqla.vssl by   100;
          i2 = sqla.vssl - i;
          if i2 > 100;
          i2 = 100;
          endif;
       fld('':%subst(sqla.vsst: i: i2 ):'');
         endfor;
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspmqtdh        b
     d dspmqtdh        pi
      /free
       structure('SQL Materialized Query Table Dependency Header');
       fld('length of the dependency area'
          :%char(mqtdh.mqtd_len_sum));
       fld('Number of file entries'
          :%char(mqtdh.mqtd___deps));

B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspmqtde        b
     d dspmqtde        pi
      /free
       structure('SQL Materialized Query Table Dependency Entry (Qdb_Qdbfmqtd)'
          );
       fld('Length of this dependency entry'
          :%char(mqtde.mqtd_len));
       fld('file the materialized query table is dependent on'
          :mqtde.mqtd_file);
       fld('library the depended-on file resides in'
          :mqtde.mqtd_lib);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsppth          b
     d dsppth          pi
      /free
       structure('Partitioned Table Header (Qdb_Qdbfsqpt_Head)');
       fld('length of the header area'
          :%char(pth.Len_Sum));
       fld('Partitioning is range or hash.'
          :pth.Ran_Hh);
       fld('Field has long field name.'
          :pth.Lfld);
       fld('Number of file partitions.'
          :%char(pth.sqpt_Num_Parts));
       fld('The offset to the first partition'
          :%char(pth.Part_Offset));
       fld('The offset to the hash key area'
          :%char(pth.Hk_Offset));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspptar         b
     d dspptar         pi
      /free
       structure('Partitioned Area (Qdb_Qdbfsqpt_Part)');
       fld('length of this partition area'
          :%char(ptar.Len));
       fld('Partition data space number.'
          :%char(ptar.DSN));
       fld('Partition number.'
          :%char(ptar.Num));
       fld('The length of the partition name.'
          :%char(ptar.Pname_Len));
       fld('The partition name.'
          :ptar.Pname);
       fld('The number of partition range keys.'
          :%char(ptar.Num_Keys));
       fld('offset to the first partition range key area'
          :%char(ptar.Range_Offset));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e









BPR  p dspprka         b
     d dspprka         pi
      /free
       structure('Partition Range Key Area (Qdb_Qdbfsqpt_Range)');
       fld('length of this partition range key area.'
          :%char(prka.Range_Len));
       fld('Partition range key name.'
          :prka.sqpt_Range_Key);
       fld('Partition range key start value minimum.'
          :prka.sqpt_Rmin);
       fld('Partition range key end value maximum.'
          :prka.Rmax);
       fld('Partition range key start value inclusive.'
          :prka.Rsin);
       fld('Partition range key end value inclusive.'
          :prka.Rein);
       fld('Partition range key value can include nulls.'
          :prka.Rnull);
       fld('Length of the starting partition range key value string.'
          :%char(prka.Rslen));
       fld('Length of the ending partition range key value string.'
          :%char(prka.sqpt_Relen));
       fld('offset to the starting partition range key value string'
          :%char(prka.Rstart_Offset));
       fld('offset to the ending partition range key value string'
          :%char(prka.Rend_Offset));
       fld('CCSID for the start and end strings.'
          :%char(prka.sqpt_Rccsid));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspphhka        b
     d dspphhka        pi
      /free
       structure('Partition Header Hash Key Area (Qdb_Qdbfsqpt_Head_Hash)');
       fld('Length of the partition header hash key area'
          :%char(phhka.Head_Hash_Len));
       fld('Total number of hash keys.'
          :%char(phhka.Head_Num_Keys));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspphka         b
     d dspphka         pi
      /free
       structure('Partition Hash Key Area (Qdb_Qdbfsqpt_Hash)');
       fld('Partition hash key name.'
          :phka.Hash_Key);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspacs          b
     d dspacs          pi
      /free
       structure('Alternative Collating Sequence Table (Qdb_Qdbfacs)');
       fld('ALTSEQ/STRSEQ table'
          :acs.acst);
       fld('CCSID for the single-byte table.'
          :%char(acs.ccsd));
       fld('Sort sequence table name.'
          :acs.tbln);
       fld('Sort sequence table library name.'
          :acs.tbll);
       fld('Sort sequence table flags'
          : hexa(acs.srtf));
       fld('Length UCS-2 sort sequence table'
          :%char(acs.UCS2_len));
       fld('CCSID for the UCS-2 table.'
          :%char(acs.UCS2_ccsid));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdic          b
     d dspdic          pi
      /free
       structure('IDDU/SQL Data Dictionary Area (Qdb_Qdbfdic)');
       fld('Data dictionary link status.'
          :dic.dilk);
       fld('Data dictionary library name.'
          :dic.inm);
       fld('Data dictionary file definition name.'
          :dic.ifd);
       fld('Data dictionary internal file definition identifier'
          :dic.diid);
       fld('Data dictionary file definition comment length.'
          :%char(dic.dicl));
       fld('Data dictionary file definition comment CCSID.'
          :%char(dic.dicc));
       fld('Offset to the SQL long/alias file names'
          :%char(dic.olng));
       fld('Number of long/alias file names for the file.'
          :%char(dic.lnnum));
       if dic.dicl < 100;
       fld('Data dictionary file definition comment text.'
          :%subst(dic.dict:1:dic.dicl));
       else;
       fld('Data dictionary file definition comment text.'
          :%subst(dic.dict:1:090     ));
       endif;
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspalias        b
     d dspalias        pi
      /free
       structure('SQL Long/Alias File Name Area (Qdb_Qdbflngn)');
       fld('Long/alias file name entry length'
          :%char(alias.lnel));
       fld('Long/alias file name flags.'
          : hexa(alias.lnfl));
       fld('Long/alias file name (non-delimited) length.'
          :%char(alias.lnlg));
       fld('Long/alias file name (non-delimited).'
          :alias.lnam);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfsa          b
     d dspfsa          pi
      /free

       structure('File Scope Array (Qdb_Qdbfb)');

       fld('Based on physical file name.'
          :fsa.bf);
       fld('Based on physical file library name.'
          :fsa.bfl);
       fld('Record format name.'
          :fsa.t);
       fld('Record format generic key field count'
          :%char(fsa.bgky));
       fld('Record format maximum key length'
          :%char(fsa.blky));
       fld('Record format generic key length'
          :%char(fsa.fogl));
       fld('Number of select/omit statements'
          :%char(fsa.soon));
       fld('Offset to the select/omit specification'
          :%char(fsa.soof));
       fld('Offset to the key specification'
          :%char(fsa.ksof));
       fld('Record format full key field count'
          :%char(fsa.kyct));
       fld('Generic key field count for all record formats'
          :%char(fsa.genf));
       fld('Offset to the distributed file definition'
          :%char(fsa.odis));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspsosa         b
     d dspsosa         pi
      /free
       structure('Select/Omit Specification Array (Qdb_Qdbfss)');
       fld('Select/omit statement rule.'
          :sosa.ssso);
       fld('Select/omit statement comparison'
          :sosa.ssop);
       fld('Select/omit statement field name.'
          :sosa.ssfn);
       fld('Number of select/omit statement parameters'
          :%char(sosa.sspnum));
       fld('Select/omit statement attribute flags.'
          : hexa(sosa.Qsosaf));
       fld('Select/omit JREF'
          :%char(sosa.ssfj));
       fld('Offset to the select/omit parameters'
          :%char(sosa.soso));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspsop          b
     d dspsop          pi
      /free
       structure('Select/Omit Parameters (Qdb_Qdbfsp)');
       fld('Offset to the next select/omit parameter'
          :%char(sop.spno));
       fld('Select/omit parameter length'
          :%char(sop.spln));
       fld('Select/omit parameter flags'
          : hexa(sop.spin));
       fld('Select/omit attribute flags.'
          : hexa(sop.Qasopaf));
       fld('Select/omit parameter JREF number'
          :%char(sop.sppj));
       fld('Select/omit parameter compare value or the record format field name'
          : %subst(sop.spvl:1:sop.spln-20));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspksa          b
     d dspksa          pi
      /free
       structure('Key Specification Array (Qdb_Qdbfk)');
       fld('Key statement field name'
          :ksa.kfld);
       fld('Key statement sequencing attribute flags.'
          : hexa(ksa.ksq));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdf           b
     d dspdf           pi
      /free
       structure('Distributed File Definition & Partition Key Array');
       fld('Distributed file node group name.'
          :df.ndgpn);
       fld('Distributed file node group library name.'
          :df.ndgpl);
       fld('Number of partition key fields for this scope entry.'
          :%char(df.nkyn));


B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsppka          b
     d dsppka          pi
      /free
       structure('Partition key field name');
       fld('Partition key field name.'
          :pka.kname);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspjoal         b
     d dspjoal         pi
      /free
       structure('Journal Information (Qdb_Qdbfjoal)');
       fld('Journal name.'
          :joal.ojrn);
       fld('Journal library name.'
          :joal.olib);
       fld('Journaling options flags.'
          : hexa(joal.ojpt));
       fld('Journaling options.'
          :joal.jact);
       fld('Last journaling date stamp'
          :joal.ljrn);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspformat       b
     d dspformat       pi
      /free
       structure('Format Definition Header (Qdb_Qddfmt)');
       fld('Bytes returned'
          :%char(format.byrtn));
       fld('Bytes available'
          :%char(format.byava));
       fld('Record format DBCS flags.'
          : hexa(format.fmtf));
       fld('Offset to the translate table specifications'
          :%char(format.xlto));
       fld('Offset to the case selection specifications'
          :%char(format.rcao));
       fld('Offset to the IDDU/SQL dictionary format'
          :%char(format.dico));
       fld('Common CCSID'
          :%char(format.rcid));
       fld('Source file CCSID'
          :%char(format.srcd));
       fld('Format text CCSID'
          :%char(format.rtcd));
       fld('Long comment CSID'
          :%char(format.rlcd));
       fld('Format flags.'
          : hexa(format.tflgs));
       fld('Flags'
          : hexa(format.flgs));
       fld('Record length'
          :%char(format.rlen));
       fld('Record format name.'
          :format.name);
       fld('Level identifier'
          :format.seq);
       fld('Text description (TEXT)'
          :format.text);
       fld('Number of fields'
          :%char(format.fldnum));
       fld('Offset to the identity information'
          :%char(format.Identity_Off));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfield        b
     d dspfield        pi
      /free
       structure('Field Header (Qdb_Qddffld)');
       fld('Length of field header structure'
          :%char(field.defl));
       fld('Internal field name'
          :field.fldi);
       fld('External field name'
          :field.flde);
B01    select ;


X01       when field.ftyp =   X'0000' ;
             fld('Data type.':hexa(field.ftyp)+'=   BINARY'  );
X01       when field.ftyp =   X'0001' ;
             fld('Data type.':hexa(field.ftyp)+'=   FLOAT');
X01       when field.ftyp =   X'0002' ;
             fld('Data type.':hexa(field.ftyp)+'=   ZONED DECIMAL' );
X01       when field.ftyp =   X'0003' ;
             fld('Data type.':hexa(field.ftyp)+'=   PACKED DECIMAL');
X01       when field.ftyp =   X'0004'  ;
             fld('Data type.':hexa(field.ftyp)+'=   CHARACTER'  );
X01       when field.ftyp =   X'8004' ;
             fld('Data type.':hexa(field.ftyp)+'=   VAR CHARACTER' );
X01       when field.ftyp =   X'0005'   ;
             fld('Data type.':hexa(field.ftyp)+'=   GRAPHIC' );
X01       when field.ftyp =   X'8005'  ;
             fld('Data type.':hexa(field.ftyp)+'=   VAR GRAPHIC');
X01       when field.ftyp =   X'0006';
             fld('Data type.':hexa(field.ftyp)+'=   DBCS-CAPABLE'  );
X01       when field.ftyp =   X'8006';
             fld('Data type.':hexa(field.ftyp)+'=   VAR DBCS-CAPABLE' );
X01       when field.ftyp =   X'000B';
             fld('Data type.':hexa(field.ftyp)+'=   DATE' );
X01       when field.ftyp =   X'000C' ;
             fld('Data type.':hexa(field.ftyp)+'=   TIME' );
X01       when field.ftyp =   X'000D'  ;
             fld('Data type.':hexa(field.ftyp)+'=   TIMESTAMP'  );
X01       when field.ftyp =   X'4004'   ;
             fld('Data type.':hexa(field.ftyp)+'=   BLOB/CLOB'  );
X01       when field.ftyp =   X'4005'    ;
             fld('Data type.':hexa(field.ftyp)+'=   DBCLOB'  );
X01       when field.ftyp =   X'4006'     ;
             fld('Data type.':hexa(field.ftyp)+'=   CLOB-OPEN'  );
X01       when field.ftyp =   X'8044'      ;
             fld('Data type.':hexa(field.ftyp)+'=   DATALINK-CHAR' );
X01       when field.ftyp =   X'8046'       ;
             fld('Data type.':hexa(field.ftyp)+'=   DATALINK-OPEN' );
X01       when field.ftyp =   X'FFFF';
             fld('Data type.':hexa(field.ftyp)+'=   NULL' );
E01    endsl;
B01    select;
X01       when field.iob = X'01'    ;
       fld('Usage.':hexa(field.iob)+'=  The field can be used for input only.');
X01       when field.iob = X'02'    ;
             fld('Usage.':hexa(field.iob)+'=  Output only.   ');
X01       when field.iob = X'03'    ;
             fld('Usage.':hexa(field.iob)+'=  Both input and output.  ');
X01       when field.iob = X'04'    ;
             fld('Usage.':hexa(field.iob)+'=  Neither input nor output.  ');
X01       when field.iob = X'FF'    ;
             fld('Usage.':hexa(field.iob)+'=  The usage is unknown.   ');
E01    endsl;
       fld('Output buffer offset'
          :%char(field.obo));
       fld('Input buffer offset'
          :%char(field.ibo));
       fld('Length'
          :%char(field.fldb));
       fld('Number of digits'
          :%char(field.fldd));
       fld('Decimal positions'
          :%char(field.fldp));
       fld('Keyboard shift '
          :field.kbs);
       fld('Field status flag 1'
          : hexa(field.fldst));
       fld('Join reference (JREF)'
          :%char(field.jref));
       fld('Field status flag 2.'
          : hexa(field.fldst2));
       fld('Flags.'
          : hexa(field.flgs2));
       fld('Variable field index'
          :%char(field.varx));
       fld('Allocated length'
          :%char(field.lalc));
       fld('Date or time format'
          :field.dttf);
       fld('Date Time separator'
          :field.dtts);
       fld('Common CCSID'
          :%char(field.csid));
       fld('Text description CCSID'
          :%char(field.tsid));
       fld('Column heading CCSID'
          :%char(field.hsid));
       fld('Long comment CCSID'
          :%char(field.lsid));
       fld('Labeled duration'
          :field.ldur);
       fld('Date or Time Flags. '
          : hexa(field.flgs));
       fld('Edit word CCSID'
          :%char(field.wsid));
       fld('Flags.'
          : hexa(field.flagco));
       fld('Offset to the field information'
          :%char(field.cplx));
       fld('Maximum length of the large object field.'
          :%char(field.bmaxl));
       fld('Pad length of the large object field.'
          :%char(field.bpadl));
       fld('Offset to the IDDU/SQL dictionary field information'
          :%char(field.dicd));
       fld('Offset to the default value description'
          :%char(field.dftd));
       fld('Offset to the derived field description'
          :%char(field.derd));
       fld('Offset to the field text description'
          :%char(field.txtd));
       fld('Offset to the field reference information'
          :%char(field.refd));
       fld('Length of the edit code/edit word for the field.'
          :%char(field.edtl));
       fld('Offset to the edit code/edit word information'
          :%char(field.edtd));
       fld('Offset to the column heading information'
          :%char(field.chd));
       fld('Length of validity checking data '
          :%char(field.vckl));
       fld('Offset to the validity checking data'
          :%char(field.vckd));
       fld('Offset to the alias name entry'
          :%char(field.xals));
       fld('Offset to the field prompted numeric editing'
          :%char(field.fpnd));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsprefinf       b
     d dsprefinf       pi
      /free
       structure('Reference Information (Qdb_Qddfrefi)');
       fld('Modification flags.'
          : hexa(refinf.rcde));
       fld('Reference file name.'
          :refinf.rfil);
       fld('Reference file library.'
          :refinf.rlib);
       fld('Referenced record format.'
          :refinf.rfmt);
       fld('Referenced field.'
          :refinf.rfld);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspedit         b
     d dspedit         pi
      /free
       structure('Field Prompted Numeric Editing Information (Qdb_Qddfdfne)');
       fld('Date Time separator'
          :edit.dts);
       fld('Decimal point character'
          :edit.dpc);
       fld('Thousands separator character'
          :edit.tsc);
       fld('Display negative sign'
          :edit.nsc);
       fld('Left negative sign value'
          :edit.nsl);
       fld('Right negative sign value'
          :edit.nsr);
       fld('Display currency symbol'
          :edit.csv);
       fld('Left currency symbol value'
          :edit.csl);
       fld('Right currency symbol value'
          :edit.csr);
       fld('Print zero value'
          :edit.pzv);
       fld('Replace leading zeros'
          :edit.rlz);
       fld('Leading zero replacement value'
          :edit.rlv);
       fld('Single leading zero'
          :edit.lzo);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspedtwrd       b
     d dspedtwrd       pi
      /free
       structure('Edit Code/Edit Word Information (Qdb_Qddfedcw)');
       fld('Edit code (EDTCDE)'
          :edtwrd.ecde);
       fld('Floating currency symbol.'
          :edtwrd.ecdx);
       fld('Edit word (EDTWRD)'
          :edtwrd.Qddfewd);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspchecki       b
     d dspchecki       pi
      /free
       structure('Validity Checking Information (Qdb_Qddfvchk)');
       fld('Number of validity check entries.'
          :%char(checki.vcnume));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspchecke       b
     d dspchecke       pi
      /free
       structure('Validity Checking Entry (Qdb_Qddfvcst)');
       fld('DDSI keyword identifier.'
          :checke.vccd);
       fld('Number of parameters.'
          :%char(checke.vcnump));
       fld('Length of this validity checking entry.'
          :%char(checke.vcel));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspcheckp       b
     d dspcheckp       pi
      /free
       structure('Validity Checking Parameter (Qdb_Qddfvcpr)');
       fld('Length of validity checking parameter Qddfvcpv.'
          :%char(checkp.vcpl));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspcplx         b
     d dspcplx         pi
      /free
       structure('Complex Object Field Type Information (Qdb_Qddfcpli)');
       fld('Length of the user-defined type name.'
          :%char(cplx.lenu));
       fld('User-defined type name.'
          :cplx.nudt);
       fld('User-defined type library name.'
          :cplx.ludt);
       fld('Link control.'
          :cplx.link);
       fld('Link integrity'
          :cplx.inte);
       fld('Read permission'
          :cplx.rper);
       fld('Write permission'
          :cplx.wper);
       fld('Recovery'
          :cplx.reco);
       fld('On unlink'
          :cplx.unlk);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfldtxt       b
     d dspfldtxt       pi
      /free
       structure('Field Text (Qdb_Qddfftxt)');
       fld('Text (TEXT). Text description of the field.'
          :fldtxt.txt);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspaliasns      b
     d dspaliasns      pi
      /free
       structure('Alias Name Structure (Qdb_Qddfalis)');
       fld('Length of alternative name Qddfalsn.'
          :%char(aliasns.alsl));
       fld('Alternative name (ALIAS).'
          :aliasns.alsn);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdefault      b
     d dspdefault      pi
      /free
       structure('Default Value Description Information (Qdb_Qddfdft)');
       fld('Length of default information.'
          :%char(default.dftl));
       fld('Default attributes flag.'
          : hexa(default.dfta));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspidcol        b
     d dspidcol        pi
      /free
       structure('Identity Column Information (Qdb_Qddfidcl)');
       fld('Length of IDENTITY information.'
          :%char(idcol.Len));
       fld('Original START WITH value.'
          :%char(idcol.Orig_Start));
       fld('Current START WITH value.'
          :%char(idcol.Curr_Start));
       fld('INCREMENT BY value.'
          :%char(idcol.Increment_By));
       fld('MINIMUM value.'
          :%char(idcol.minimum));
       fld('MAXIMUM value.'
          :%char(idcol.maximum));
       fld('CYCLE indicator.'
          :idcol.Id_Cycle);
       fld('ORDER mode indicator.'
          :idcol.order);
       fld('Identity GENERATE indicator.'
          :idcol.Generate);
       fld('CACHE value.'
          :%char(idcol.curr_cache));
       fld('Rowid GENERATE indicator.'
          :idcol.Rowid_Generate);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdrvh         b
     d dspdrvh         pi
     d i               s              5u00
      /free
       structure('Derived Field Header (Qdb_Qddfderv)');
       fld('Length of derived field information Qddfderv.'
          :%char(drvh.dvtl));
       fld('Number of derived field entries. '
          :%char(drvh.dvnume));
       fld('Offset to the derived field text'
          :%char(drvh.dvot));
          for i = 1 to drvh.dvnume ;
          if i = 1;
       pdrve = pdrvh+16            ;
       else;
       pdrve+=drve.dvln ;
                      endif;
       dspdrve();
       endfor;
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdrve         b
     d dspdrve         pi
      /free
       structure('Derived Field Entry (Qdb_Qddfdvst)');
       fld('Length of derived field entry'
          :%char(drve.dvln));
       fld('Derived field entry type.'
          :%char(drve.dtyp));

       select;
       when    drve.dtyp = 0;
       pfldop= pdrve+ 6  ;
       dspfldop();
       when    drve.dtyp = 1;
       pconste= pdrve+ 6  ;
       dspconste();
       when    drve.dtyp = 2;
       pope  = pdrve+ 6  ;
       dspope();
       endsl;


B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfldop        b
     d dspfldop        pi
      /free
       structure('Field Operand Entry (Qdb_Qddfdvof)');
       fld('Field name.'
          :fldop.dvon);
       fld('Join reference (JREF)'
          :%char(fldop.dvjr));
       fld('Starting position'
          :%char(fldop.dv01));
       fld('Ending position'
          :%char(fldop.dvo2));
       fld('Qdt from which this correlated field originates'
          :%char(fldop.qdtnum));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspconste       b
     d dspconste       pi
      /free
       structure('Constant Operand Entry (Qdb_Qddfdvoc)');
       fld('Length of constant Qddfdvov.'
          :%char(conste.dvol));
       fld('Constant attributes flag.'
          : hexa(conste.ca));
       fld('Special register constant.'
          :conste.dvrc);
       fld('Date  or Time constant format'
          :conste.dvft);
       fld('Date or Time constant separator'
          :conste.dvsp);
       fld('CCSID'
          :%char(conste.dvcd));
       fld('Constant flags.'
          : hexa(conste.cflg));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspope          b
     d dspope          pi
      /free
       structure('Operator Entry (Qdb_Qddfdvo)');
       fld('Derived operator.'
          :ope.dvop);
       fld('Translate table index'
          :ope.xnum);
       fld('Operator date or time format'
          :ope.fm);
       fld('Operator date or time separator'
          :ope.sa);
       fld('Number of operands.'
          :%char(ope.no));
       fld('Operator attributes flag.'
          : hexa(ope.oa));
       fld('decimal point character'
          :ope.decptchar);
       fld('Offset to the Function Name Specification section'
          :%char(ope.func_def) );

       if        ope.func_def  > 0;
         pfunc = pope+ope.func_def;
         dspfunc();
       endif;

B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR


B00

E00

EPR
BPR  p dspdrvft        b
     d dspdrvft        pi
      /free
       structure('Derived Field Text Information (Qdb_Qddfdvtx)');
       fld('Length of derived field text '
          :%char(drvft.dvlt));
       fld('Derived field text description'
          :%subst(drvft.Qddfdtxt:1:drvft.dvlt-2)         );
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspcolhdg       b
     d dspcolhdg       pi
      /free
       structure('Column Heading Information (Qdb_Qddfcolh)');
       fld('Column heading £1. '
          :colhdg.ch1);
       fld('Column heading £2. '
          :colhdg.ch2);
       fld('Column heading £3. '
          :colhdg.h3);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdicFI        b
     d dspdicFI        pi
      /free
       structure('IDDU/SQL Dictionary Format Information (Qdb_Qddfdic)');
       fld('Length of format definition long comment information'
          :%char(dicFI.lt));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdicfdi       b
     d dspdicfdi       pi
      /free
       structure('IDDU/SQL Dictionary Field Information (Qdb_Qddfdicf)');
          fld('Length of field definition long comment Qddfdfco.'
            :%char(%len(dicfdi.ct)));
       if %len(dicfdi.ct)< 100;
       fld('field definition long comment.'
          :dicfdi.ct);
       else;
       fld('field definition long comment.'
          :%subst(dicfdi.ct:1:100));
       endif;
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspxl           b
     d dspxl           pi
      /free
       structure('Translate Table Specification (Qdb_Qddfxl)');
       fld('Number of elements in the translate table array.'
          :%char(xl.num));
       fld('Translate table name.'
          :xl.nm);
       fld('Translate table library name.'
          :xl.ln);
       fld('Translate table constant CCSID'
          :%char(xl.cid));
       fld('Translate table.'
          :xl.tbl);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspcase         b
     d dspcase         pi
      /free
       structure('Case Selection Specification (Qdb_Qddfcsl)');
       fld('Number of elements'
          :%char(case.num));
       fld('Length of all the selection specifications.'
          :%char(case.ln));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfunc         b
     d dspfunc         pi
      /free
       structure('Function Name Specification (Qdb_Qddfunc_def)');
       fld('Library where function can be found. '
          :func.libname);
       fld('Length of function name in Qddfunc_funcname.'
          :%char(func.name_len));
       fld('Name of function to resolve.'
          :func.funcname);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspkih          b
     d dspkih          pi
      /free
       structure('Key Information Header (Qdb_Qdbwh)');
       fld('Bytes returned'
          :%char(kih.Byte_Ret));
       fld('Bytes available'
          :%char(kih.Byte_Avail));
       fld('Maximum key length'
          :%char(kih.Max_Key_Len));
       fld('File generic key field count.'
          :%char(kih.Key_Count));
       fld('Number of formats for the file.'
          :%char(kih.Fmt_Counts));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspfkia         b
     d dspfkia         pi
      /free
       structure('Record Format Key Information Array (Qdb_Qdbwhrec)');
       fld('Record format name'
          :fkia.Rec_Name);
       fld('Number of record format key fields.'
          :%char(fkia.Num_Of_Keys));
       fld('Offset to the key field description'
          :%char(fkia.Key_Info_Off));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspflda         b
     d dspflda         pi
      /free
       structure('Key Field Description Array (Qdb_Qdbwhkey)');
       fld('Internal key field name'
          :flda.Int_Field_Name);
       fld('External key field name'
          :flda.Ext_Field_Name);
       fld('The data type'
          :%char(flda.Data_Type));
       fld('The length'
          :%char(flda.Field_Len));
       fld('The number of digits'
          :%char(flda.Num_Of_Digs));
       fld('The number of decimal positions'
          :%char(flda.Dec_Pos));
       fld('Key field attributes flags.'
          : hexa(flda.flag1));
       fld('Length of the alternative name'
          :%char(flda.Alt_Name_Len));
       fld('Alternative name (Alias)'
          :flda.Alt_Name);
       fld('Additional key field attribute flags.'
          : hexa(flda.flag2));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsptih          b
     d dsptih          pi
      /free
       structure('Trigger Information Header (Qdb_qdbftrg_head)');
       fld('bytes returned'
          :%char(tih.Bytes_Returned));
       fld('bytes available '
          :%char(tih.Bytes_Avail));
       fld('Number of trigger definitions.'
          :%char(tih.Num_Trgs));
       fld('Offset to first trigger definition entry.'
          :%char(tih.Off_Ent_Num1));
       fld('Offset to the beginning of the insert group.'
          :%char(tih.Off_Ins_Grp));
       fld('Offset to the beginning of the update group.'
          :%char(tih.Off_Upd_Grp));
       fld('Offset to the beginning of the delete group.'
          :%char(tih.Off_Del_Grp));
       fld('Offset to the beginning of the read group.'
          :%char(tih.Off_Read_Grp));
       fld('Number of SQL triggers.'
          :%char(tih.Num_Sql_Trgs));
       fld('Number of native triggers.'
          :%char(tih.Num_Ntv_Trgs));
       fld('Number of INSERT/BEFORE triggers.'
          :%char(tih.Num_Insb_Trg));
       fld('Number of INSERT/AFTER triggers.'
          :%char(tih.Num_Insa_Trg));
       fld('Number of DELETE/BEFORE triggers.'
          :%char(tih.Num_Delb_Trg));
       fld('Number of DELETE/AFTER triggers.'
          :%char(tih.Num_Dela_Trg));
       fld('Number of UPDATE/BEFORE triggers.'
          :%char(tih.Num_Updb_Trg));
       fld('Number of UPDATE/AFTER triggers.'
          :%char(tih.Num_Upda_Trg));
       fld('Number of READ/AFTER triggers.'
          :%char(tih.Num_Reada_Trg));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsptdeh         b
     d dsptdeh         pi
      /free
       structure('Trigger Definition Entry Header (Qdb_Qdbftrg_Def_Head) ');
       fld('Length of the trigger definition'
          :%char(tdeh.Def_Len));
       fld('Length of the trigger header'
          :%char(tdeh.Head_Len));
       fld('Trigger program name.'
          :tdeh.Def_Pgm);
       fld('Trigger program library.'
          :tdeh.Def_Lib);
       fld('Trigger ordinal number.'
          :%char(tdeh.Def_Ord_Num));
       fld('Trigger state.'
          :tdeh.Def_State);
       fld('Trigger is operative.'
          :tdeh.Def_Operative);
       fld('Trigger type.'
          :tdeh.Def_Type);
       fld('Trigger mode'
          :tdeh.Def_Mode);
       fld('Trigger orientation.'
          :tdeh.Def_Orient);
       fld('Trigger time.'
          :tdeh.Def_Time);
       fld('Trigger event.'
          :tdeh.Def_Event);
       fld('Offset to the trigger name '
          :%char(tdeh.Off_Trg_Name));
       fld('Offset to the SQL path '
          :%char(tdeh.Off_Sql_Path));
       fld('Offset to the update columns'
          :%char(tdeh.Off_Upd_Cols));
       fld('Offset to the list of columns referenced in the WHEN condition'
          :%char(tdeh.Off_When_Cols));
       fld('Offset to the list of columns referenced in the trigger'
          :%char(tdeh.Off_Body_Cols));
       fld('Offset to the list of dependent objects referenced'
          :%char(tdeh.Off_Dep_Objs));
       fld('Offset to the transition tables'
          :%char(tdeh.Off_Transition));
       fld('Offset to the CREATE TRIGGER statement'
          :%char(tdeh.Off_Trg_Stmt));
       fld('Offset to the trigger long comment'
          :%char(tdeh.Off_Trg_Long));
       fld('Trigger update condition. '
          :tdeh.Updcond);
       fld('Allow repeated change.'
          :tdeh.Allow_Repchg);
       fld('Threadsafe indicator.'
          :tdeh.Threadsafe);
       fld('Multithreaded job action indicator'
          :tdeh.Multijob);
       fld('Old correlation variable indicator'
          :tdeh.Old_Tvar);
       fld('New correlation variable indicator'
          :tdeh.New_Tvar);
       fld('Old transition table indicator.'
          :tdeh.Old_Ttable);
       fld('New transition table indicator'
          :tdeh.New_Ttable);
       fld('Self-referencing indicator. '
          :tdeh.Self_Ref);
       fld('Trigger creation timestamp. '
          :tdeh.Crt_Ts);
       fld('User profile that created the trigger.'
          :tdeh.Crt_User);
       fld('User profile that owns the trigger program. '
          :tdeh.Pgm_Owner);
       fld('CCSID of the CREATE TRIGGER statement.'
          :%char(tdeh.Trg_Ccsid));
       fld('SET statement modifies the new correlation variable'
          :tdeh.Mod_Tvar);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsptdns         b
     d dsptdns         pi
      /free
       structure('Trigger Definition Name Structure (Qdb_Qdbftrg_Name_Area)');
       fld('length of the trigger name area'
          :%char(tdns.Area_Tot_Len));
       fld('Length of the trigger library name.'
          :%char(tdns.Lib_Len));
       fld('Length of the trigger program name.'
          :%char(tdns.Len));
       fld('System-generated trigger name indicator.'
          :tdns.Sysgen);
       fld('Delimited name indicator. '
          :tdns.Delim);
       fld('Delimited library name indicator'
          :tdns.Lib_Delim);
       fld('Trigger naming convention.'
          :tdns.Type);
       fld('Qualified trigger name'
          :tdns.Qual);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspsps          b
     d dspsps          pi
      /free
       structure('SQL Path Structure (Qdb_Qdbftrg_Path_Area)');
       fld('Length of the SQL path area'
          :%char(sps.Path_Tot_Len));
       fld('Length of the SQL path structure'
          :%char(sps.Path_Len));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspupdatecs     b
     d dspupdatecs     pi
      /free
       structure('UPDATE Columns Structure (Qdb_Qdbftrg_Updc_Area)');
       fld('length of the update columns area'
          :%char(updatecs.Tot_Len));
       fld('Number of columns in the list'
          :%char(updatecs.Num_Cols));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspupdateces    b
     d dspupdateces    pi
      /free
       structure('UPDATE Columns Entry Structure (Qdb_Qdbftrg_Updc_List_Ent)');
       fld('Update column list entry length. '
          :%char(updateces.Len));
       fld('Short name of the column.'
          :updateces.Short_Name);
       fld('Short name is delimited indicator.'
          :updateces.Short_Del);
       fld('Long name is delimited indicator.'
          :updateces.Long_Del);
       fld('Short name and long name are the same indicator.'
          :updateces.Long_Same);
       fld('Length of the long name'
          :%char(updateces.Long_Len));
       fld('Long name of the column.'
          :updateces.Long_Name);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspwhencs       b
     d dspwhencs       pi
      /free
       structure('WHEN Columns Structure (Qdb_Qdbftrg_When_Area)');
       fld('Total length of the WHEN columns area'
          :%char(whencs.When_Tot_Len));
       fld('Number of columns in the list'
          :%char(whencs.When_Num_Cols));
       fld('Whether columns in the WHEN list belong to this file.'
          :whencs.When_Self_Ref);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspwhences      b
     d dspwhences      pi
      /free
       structure('WHEN Columns Entry Structure (Qdb_Qdbftrg_When_Array)');
       fld('WHEN column name offset'
          :%char(whences.Col_Off));
       fld('Length of the column name'
          :%char(whences.Col_Len));
       fld('Offset to the column''s file name'
          :%char(whences.File_Off));
       fld('Length of the column''s file name'
          :%char(whences.File_Len));
       fld('Offset to the column''s library name'
          :%char(whences.Lib_Off));
       fld('Length of the column''s library name'
          :%char(whences.Lib_Len));
       fld('Whether the column name is the first in the list of entries.'
          :whences.first_Entry);
       fld('Whether the column name is in this file.'
          :whences.This_File);
       fld('Whether the column name is a short or long name.'
          :whences.Col_Long);
       fld('Whether the column name is a delimited name.'
          :whences.Col_Del);
       fld('Whether the column''s file name is a short or long name.'
          :whences.File_Long);
       fld('Whether the column''s file name is a delimited name.'
          :whences.File_Del);
       fld('Whether the column''s library name is a short or long name.'
          :whences.Lib_Long);
       fld('Whether the column''s library name is a delimited name.'
          :whences.Lib_Del);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspbodycs       b
     d dspbodycs       pi
      /free
       structure('BODY Columns Structure (Qdb_Qdbftrg_Body_Area)');
       fld('length of the BODY columns area'
          :%char(bodycs.Tot_Len));
       fld('Number of columns in the list'
          :%char(bodycs.Num_Cols));
       fld('Whether columns in the body list belong to this file.'
          :bodycs.Self_Ref);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspbodyces      b
     d dspbodyces      pi
      /free
       structure('BODY Columns Entry Structure (Qdb_Qdbftrg_Body_Array)');
       fld('BODY column name offset '
          :%char(bodyces.Col_Off));
       fld('Length of the column name'
          :%char(bodyces.Col_Len));
       fld('Offset to the column''s file name'
          :%char(bodyces.File_Off));
       fld('Length of the column''s file name'
          :%char(bodyces.File_Len));
       fld('Offset to the column''s library name'
          :%char(bodyces.Lib_Off));
       fld('Length of the column''s library name'
          :%char(bodyces.Lib_Len));
       fld('Whether the column name is the first in the list of entries.'
          :bodyces.first_Entry);
       fld('Whether the column name is in this file.'
          :bodyces.This_File);
       fld('Whether the column name is a short or long name.'
          :bodyces.Col_Long);
       fld('Whether the column name is a delimited name.'
          :bodyces.Col_Del);
       fld('Whether the column''s file name is a short or long name.'
          :bodyces.File_Long);
       fld('Whether the column''s file name is a delimited name.'
          :bodyces.File_Del);
       fld('Whether the column''s library name is a short or long name.'
          :bodyces.Lib_Long);
       fld('Whether the column''s library name is a delimited name.'
          :bodyces.Lib_Del);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspdepobj       b
     d dspdepobj       pi
      /free
       structure('Dependent Objects Structure (Qdb_Qdbftrg_Depo_Area)');
       fld('length of the dependent objects area'
          :%char(depobj.Tot_Len));
       fld('Number of dependent object offsets'
          :%char(depobj.Num_Off));
       fld('Whether this file is referenced'
          :depobj.Self_Ref);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspType         b
     d dspType         pi
      /free
       structure('Dependent Objects Entry Structure (Qdb_Qdbftrg_Depo_Array)');
       fld('Type of dependent object.'
          :DepObjES.type);
       fld('Offset to the dependent object'
          :%char(DepObjES.Off));
       fld('Length of the dependent object'
          :%char(DepObjES.Len));
       fld('Offset to the qualifying library name'
          :%char(DepObjES.Lib_Off));
       fld('Length of the qualifying library name'
          :%char(DepObjES.Lib_Len));
       fld('Whether the object name is the first in the list of entries'
          :DepObjES.first_Entry);
       fld('Whether the object is this file.'
          :DepObjES.This_File);
       fld('Whether the object name is is a short or long name.'
          :DepObjES.Obj_Long);
       fld('Whether the object name is a delimited name.'
          :DepObjES.Obj_Del);
       fld('Whether the library''s name is a short or long name.'
          :DepObjES.Lib_Long);
       fld('Whether the library''s name is a delimited name.'
          :DepObjES.Lib_Del);
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsptrns         b
     d dsptrns         pi
      /free
       structure('Transition Area Structure (Qdb_Qdbftrg_Trns_Area)');
       fld('length of the transition area'
          :%char(trns.Tot_Len));
       fld('Old correlation variable name length.'
          :%char(trns.Oldvar_Len));
       fld('New correlation variable name length.'
          :%char(trns.Newvar_Len));
       fld('Old transition table name length.'
          :%char(trns.Oldtbl_Len));
       fld('New transition table name length.'
          :%char(trns.Newtbl_Len));
       fld('Old correlation variable name offset.'
          :%char(trns.Oldvar_Off));
       fld('New correlation variable name offset.'
          :%char(trns.Newvar_Off));
       fld('Old transition table name offset.'
          :%char(trns.Oldtbl_Off));
       fld('New transition table name offset.'
          :%char(trns.Newtbl_Off));
       fld('Whether the old correlation variable name is delimited.'
          :trns.Oldvar_Del);
       fld('Whether the new correlation variable name is delimited.'
          :trns.Newvar_Del);
       fld('Whether the old table name is delimited.'
          :trns.Oldtbl_Del);
       fld('Whether the new table name is delmited.'
          :trns.Newtbl_Del);
       fld('Length of the transition names'
          :%char(trns.Names_Len));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dspstmt         b
     d dspstmt         pi
      /free
       structure('Trigger Statement Area (Qdb_Qdbftrg_Stmt_Area)');
       fld('length of the statement area.'
          :%char(stmt.Tot_Len));
       fld('Offset to the user-specified file table name '
          :%char(stmt.Onfile_Off));
       fld('Length of the qualified library file name'
          :%char(stmt.Onfile_Len));
       fld('Whether the ON table/file name is delimited.'
          :stmt.Onfile_Del);
       fld('Whether the ON library name is delimited.'
          :stmt.Onlib_Del);
       fld('Whether the ON table/file name is a long name.'
          :stmt.Onfile_Long);
       fld('Length of the SQL CREATE TRIGGER '
          :%char(stmt.Crt_Trg_Len));
       fld('Length of the WHEN clause'
          :%char(stmt.When_Len));
       fld('Offset to the WHEN clause'
          :%char(stmt.When_Off));
       fld('Length of the BODY portion'
          :%char(stmt.Body_Len));
       fld('Offset to the BODY portion'
          :%char(stmt.Body_Off));
B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
BPR  p dsplong         b
     d dsplong         pi
      /free
       structure('Trigger Long Comment Area (Qdb_Qdbftrg_Long_Area)');
       fld('length of the long comment area'
          :%char(long.Tot_Len));
       fld('Length of the trigger long comment'
          :%char(long.Len));
       fld('CCSID of the long comment'
          :%char(long.Long_Ccsid));

B00    begsr *pssr;
       dump;
E00    endsr;
       /end-free
EPR  p                 e
