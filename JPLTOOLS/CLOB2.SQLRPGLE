    ? * compilation :
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
     h copyright('Author is jean-Paul Lamontre')
     f*lobtable if   e             disk
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
     D TRUE            s               n   inz(*on)
     D FALSE           s               n   inz(*off)
     D  ech            DS                  qualified                            // ErrorCodeHandler
     D  provided               1      4B 0 INZ(%size(ech             ))         LONGUEUR DE LA ZON
     D  available              5      8B 0                                      lng DE LA REPONSE
     D  msgid                  9     15                                         NUMERO DE L'ERREUR
     D  msgdta                17    255                                         MSGDTA POUR L'ERRE

     d message         pr
     d    msgno                       7    const         options(*omit)         n[
     d    msgdata                  6000    const varying options(*nopass)       variables
     d    msgflib                    10    const         options(*nopass)       *LIBL
     d    msgffile                   10    const         options(*nopass)       MESSAGE
     d    msgtype                    10    const         options(*nopass)       *DIAG
     d    msgcse                     10    const         options(*nopass)       call stack entry
     d    msgcsc                      4B 0 const         options(*nopass)       call stack counter
     d    msgkey                      4                  options(*nopass)       message key
     d PmqPgm          s             10
     d MessageFile     c                   'QCPFMSG'
     D die             Pr
     D    msg                       256A   const

     DMSGID            S              7A   IMPORT('_EXCP_MSGID')

     D EscSqlEr        Pr
     D   sqlcod                       9b 0 const
     D   sqlerm                      70    const options(*nopass)

    ?

    ?

    ?

    ?







     d  CLOBdata       s                   SQLTYPE(CLOB_LOCATOR)
     d  id             s             10i 0
     d*dstable       e ds                  extname(clobtable)
BPR

    ?

    ?

    ?





     D CLOBFile        S                   SQLTYPE(CLOB_FILE)

     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
     d cmde            s           2000    varying
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
     d   Error_code...
     d                              256

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

     d memmove         pr                  extproc('memmove')
     d   dest                          *   value
     d   src                           *   value
     d   size                         9b 0 value

     d pUSP            s               *
     d RAMdata         s          65535    based(pRAMdata )
     d RAMrec          s            100    based(pRAMrec)
     d    string       s            100    varying
     d usrspc          s             20
     d space           s           2000    inz(*blank)
     d i               s             10u 0
     d  IfsName        s            256A    varying
     d  Length         s             10s 0

     d fspclib         s             10A
     d fspcname        s             10A









      /free
       *inrt= *on;
B01    monitor;
          Exec SQL Set Option Commit=*cs  , naming=*sql;
          exec sql SET TRANSACTION ISOLATION LEVEL READ COMMITTED ;
          exsr getClob;
          return;
X01       on-error;
            exsr *pssr;

E01    endmon;
       *inlr = *on ;
       return;
       //?*=----------------------------------------------------------------
B01    begsr GetClob ;
          message('CPF9898':'Load data from UDF':'':'':'*DIAG  ');
          exec sql commit;
X02          if  sqlcode <> 0                ;
                escsqler (sqlcode: sqlerm);
                endif;
          exec sql declare c1 cursor for
             select  1
                  , jplsql.clob1_udf() from qsys2.qsqptabl
             ;
          exec sql open c1;
X02          if  sqlcode <> 0                ;
                escsqler (sqlcode: sqlerm);
                endif;
          exec sql fetch c1 into : ID
                               , : CLOBdata  ;
X02          if  sqlcode <> 0                ;
                escsqler (sqlcode: sqlerm);
                endif;

          // prepare a user space to copy the data via a clobfile
          //?build the user space
          Fspclib ='QTEMP';
          Fspcname = 'U' + %subst(%char(%timestamp():*iso0) : 9);
          usrspc = fspcname+fspclib;
          //?create a user space
             quscrtus ( usrspc : *BLANK : 1 : x'00' : '*ALL' : *BLANK : '*YES'
                : ECH : '*USER' );
B02       if (ech.available>0);
             message(ech.msgid:ech.msgdta:'':'QCPFMSG':'*ESCAPE');
E02       endif;

          //?with attribute auto-extensible
          quscusat ( Lib : Usrspc : Attributes : ECH );
B02       if (ECH.available>0);
             message(ECH.msgid:ECH.msgdta:'':'QCPFMSG':'*ESCAPE');
E02       endif;
          message('CPF9898':'Load the User Space':'':'':'*DIAG  ');

          ifsname = '/qsys.lib/' + %trim(fspclib)+'.lib/'
          + %trim(fspcname) + '.usrspc';
          CLOBfile_fo = SQFovr;
          CLOBfile_name = ifsName ;
          CLOBfile_nl = %Len( ifsName) ;
          //?copy the userspace to the clob
          Exec Sql Set :ClobFile=:Clobdata ;

B02       Select ;
X02          When      SQLSTT<>'00000'       ;
                escsqler (sqlcod : sqlerm);
E02       EndSl ;

          qusptrus(usrspc : pRAMdata);


E01       dump;


E01    endsr;
       //?---------------------------------------------------------------
       //?begsr        ;
       //?endsr;
       //?---------------------------------------------------------------
       //?*----------------------------------------------------------------
       //?* *inzsr, sr pmqsnd, sp *pssr , ...
       //?*----------------------------------------------------------------
B01    begsr *pssr ;
          dump ;
          exec sql rollback;
E01    endsr '*CANCL';
      /end-free
    ?
    ?
EPR



BPR  p message         b
     d message         pi
     d  p_msgno                       7    const         options(*omit)         n[
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
     D  ECH02                  5      8B 0                                      lng DE LA REPONSE
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
          callp     die('ERR S/QMHSNDPM, look at ECH03')   ;
E01    ENDIF ;
B01    if %parms >= 8 ;
          eval p_msgkey = w_msgkey ;
E01    endif ;
B01    begsr *pssr ;
          dump ;
E01    endsr ;
      /end-free
EPR  p message         e

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
       //?=----------------------------------------------------------------------
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
          message(msgid:sqlerm:'*LIBL':'QSQLMSG':'*ESCAPE':'*':4)  ;
X01    else;
          message(msgid:'':'*LIBL':'QSQLMSG':'*ESCAPE':'*':4)       ;
E01    endif;
      /end-free
EPR  P                 E
