    ? *  compilation :
    ? *  create the TABLE pf
    ? *  EXECSQL3 LIBRARY(LAMONTRE1)
    ? *           FILE(JPLTOOLS)
    ? *           MEMBER(JPL028P)
    ? *  CRTJRNRCV JRNRCV(LAMONTRE1/JPL)
    ? *  CRTJRN JRN(LAMONTRE1/JPL)
    ? *         JRNRCV(LAMONTRE1/JPL)
    ? *  STRJRNPF FILE(LAMONTRE1/JPL028P)
    ? *           JRN(LAMONTRE1/JPL)
    ? *           IMAGES(*BOTH)
    ? *  compile dspf
    ? *  compile rpg
      /define INFDS
      /define SQL
    ? */define SQLDESCRIBE
      /define LOWERCASE
    ? */define QUOTE
    ? */define XLXML
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include JPLTOOLS,jp4inc
      /undefine FILE_SECTION

    ? */================================================================
    ? */ program sample
    ? */================================================================
    ? */required adaptations are marked : HERE
    ?




    ? */HERE replace all DSPF JPL028fm with target dspf
     fJPL028fm  cf   e             workstn
     f                                     infds(fids)
     f                                     sfile(sflb:cbcsr )
     f                                     indds(indara)
     d f5ds          e ds                  extname(JPL028fm:ctlb       )
     d                                     qualified
    ? */HERE replace all JPL028p with target file
     d loop          e ds                  extname(JPL028p)
     d                                     qualified
     d updt          e ds                  extname(JPL028p)
     d                                     qualified

    ? */ !!! indara is NOT *in
     d indara          ds
     d  in0199                01     99
     d  errind                60     99
     d  F3                             n   overlay(indara:03)
     d  F4                             n   overlay(indara:04)
     d  F5                             n   overlay(indara:05)
     d  F12                            n   overlay(indara:12)
     d  F14                            n   overlay(indara:14)
     d  in10                           n   overlay(indara:10)
     d  rollup                         n   overlay(indara:11)
     d  DeleteReq                      n   overlay(indara:40)
     d  clrsfl                         n   overlay(indara:51)
     d  dspsfl                         n   overlay(indara:52)
     d  sflend                         n   overlay(indara:53)
     d  errsfl                         n   overlay(indara:60)
    ? * HERE adapt the DSPF indicators
    ? * fmta
     d  ertype                         n   overlay(indara:61)
    ? * sflb
     d  erme                           n   overlay(indara:61)
     d  ertoday                        n   overlay(indara:62)
    ? * all ctl
     d  limite                         n   overlay(indara:98)
    ? * display file cursor work fields
     d cbcsrNP         s                   like(cbcsr )                         * row for next page
     d cbcsrw          s                   like(cbcsr )                         * remember cur row
     d cbpage          s              2s 0                                      * sfl page size
     d cbline          s              2s 0                                      * sfl page count
       //?Sql Cursor status
     d KaIsOpen        s               n   inz(*off)
     d kbIsopen        s               n   inz(*off)
     d KcIsOpen        s               n   inz(*off)

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

    ? */ command  as400
     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? */ example :
    ? */d rc              s              9b 0
    ? */         rc =  c_system('dsplibl');
    ? */         if rc <> 0;
    ? */         message(msgid);
    ? */         endif;

    ? */ program parameters
     d sp000           pr
     d sp010           pr
     d sp020           pr
     d sp030           pr
     d sp040           pr
     d JPL028r         pr
     d  paok                          1
     d JPL028r         pi
     d  paok                          1

     d mySFW           s           5000
     d sqlCount        s              9b 0
     d sqlfound        s               n
     d ReadOrUpdate    s             20
     d In1F            s               n
     d returncode      s               n
      /free
       //* SQL Reference : InformationCenter\info\db2\rbafzmst.pdf
       //* 5. Statements
       //* SET OPTION
       EXEC SQL
          Set Option Commit = *CS
          , CloSQLCsr = *ENDMOD
          , DatFmt = *ISO
          , TimFmt = *ISO
          , Naming = *SYS
          ;
       //?prepare transaction isolation level for future database modification
       exec sql
          SET TRANSACTION ISOLATION LEVEL READ COMMITTED
          ;

       //?* main program
       //?* general initialization
       *inlr = *on ;
       w0flsp =  '0000' ;
B01    if %parms() = 0 ;
          returncode=false;//?no return code
       else;
          returncode=true ;
       endif;
B01    dow w0flsp <> *blanks ;//?boucle centrale
B02       select ;
X02          when w1flsp = '00';
                sp000() ;//?initialisation
                //?HERE choose the SP depending screen pages
X02          when w1flsp = '01';
                sp010() ;//?select
X02          when w1flsp = '02';
                sp020() ;//?detail subfile
X02          when w1flsp = '03';
                sp030() ;//?update
X02          other;
                spmsda = 'target routine (w0flsp) unknown';
                exsr *pssr ;//?error in wwflag
E02       endsl;
E01    enddo;

       //?---------------------------------------------------------------
       //?begsr        ;



       //?endsr;
       //?---------------------------------------------------------------
      /end-free

    ? *//----------------------------------------------------------------
    ? *// *inzsr, sr pmqsnd, sp *pssr , ...
    ? *//----------------------------------------------------------------
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
       //?---------------------------------------------------------------
BPR  p sp000           b
       //?---------------------------------------------------------------
       //?general init
B01   /free
       //?HERE choose initial screen
       if returncode=true ;//?no return code
B02       if paok = '1';
             w0flsp= '0100' ;//?selection
X02       else;
             w0flsp= '0200' ;//?sub-file
E02       endif;
X02    else;
          w0flsp= '0200' ;//?sub-file
E01    endif;
B01    if returncode;
          paok = *off ;
E01    endif;
       clear f5ds;//?refresh detector
       pmqcln() ;
       message('AAA0001');//?welcome message
       //?HERE initialize selection criteria
       sqlmax = 0088;//?why not ! it's to fix a value. Any value is correct
E01    cbme='%';
E01    CBTODAYf=dmin ;
E01       CBNOWf= tmin ;
E01    CBTODAYT=dmax ;
E01       CBNOWT=tmax ;
E01
       //?--------------------
B01    begsr *pssr;
B02       if NeedDump;
             dumpcallstack();
             dump ;
             needdump=false;
E02       endif;
E01    endsr;
      /end-free
EPR  p                 e
       //?---------------------------------------------------------------
BPR  p sp010           b
       //?---------------------------------------------------------------
      /free
       //?traitement de sélection
       kaisopen = false;
B01    dow w1flsp = '01' ;//?boucle central
B02       select;
X02          when w2flsp = '00';
                //?init
                w2flsp = '50';
                indara = *all'0';
                //?HERE load the page
                //?fa        = loop.             ;
                faME = spjbus;
X02          when w2flsp = '50';
                //?show
                w2flsp = '60';
                //?Fkey toolbar
                write fmtka ;
X02          when w2flsp = '60';
                //?show again
                w2flsp = '70';
                write pmqctl;//?program message queue
                exfmt fmta ;//?screen
                callp pmqcln() ;//?cleanup     pmq
X02          when w2flsp = '70';
                //?controls
                //?F3=quit, exit, leave
B03             if f3 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F12=Abandon, cancel
B03             if f12 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F5=rafraichir, refresh
B03             if f5 = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
                //?traitement, the run
                w2flsp = '80';
                //?checks
                //?sample of static sql. request : file must exist before compilation
                //?sql package for this program contains precompiled path
                //?its not a one row result set, but we need only one row

                //?nota : You can use sql names (alias) or system names
                EXEC SQL
                   declare JPL028Ka cursor for
                   select * from JPL028p where user_name = : faME
                   fetch first 1 rows only
                   for read only optimize for 1 rows with nc
                   ;
                sqlfound = false ;
                clear updt ;
B03             dou true;
B04                if KAisopen ;
                      EXEC SQL
                         close JPL028ka
                         ;
                      KAisopen = false ;
E04                endif ;
                   EXEC SQL
                      open JPL028ka
                      ;

B04                if sqlcod <> *zero;
                      message('DIV0001');
                      diagsqler (sqlcod:sqlerm);
                      w2flsp = '50';
                      iter ;
E04                endif;

                   KAisopen = true ;
                   EXEC SQL
                      fetch JPL028Ka into : updt
                      ;

B04                if sqlcod <> *zero;
                      //?diagsqler (sqlcod);
                      w2flsp = '50';
                      iter ;
E04                endif;
                   sqlfound = true;
E03             enddo;

B03             if not(sqlfound) ;

                   ertype = *on;
                   w2flsp = '60';


                   message('MSG0001');
E03             endif ;
X02          when w2flsp = '80';
                //?validation
                cbme = faME ;
B03             if returncode;
                   paok = *on ;
E03             endif;
                w0flsp = '0200';
                iter;
X02          other ;
                //?abandon, cancel
B03             if returncode;
                   paok = *off ;
E03             endif;
                w0flsp = *blank ;
E02       endsl ;
E01    enddo ;

B01    if KAisopen ;
          EXEC SQL
             close JPL028Ka
             ;
          KAisopen = false ;
E01    endif ;

       //?--------------------
B01    begsr *pssr;
B02       if NeedDump;
             dumpcallstack();
             dump ;
             needdump=false;
E02       endif;
E01    endsr;
      /end-free
EPR  p                 e
       //?---------------------------------------------------------------
BPR  p sp020           b
       //?---------------------------------------------------------------
      /free
       //?task : subfile
B01    dow w1flsp = '02' ;//?main loop
B02       select;
X02          when w2flsp = '00';
                //?initialisation
B03             if in1f;
                   w2flsp = '50';//?first time, empty screen for filter criteria
X03             else;
                   w2flsp = '10';//?load screen
E03             endif;

                indara = *all'0';
                cbcsrNP= 1;
                cbpage = 15;
                cbline = 0;
                callp pmqcln() ;
                //?initialize subfile
                cbcsr = 0;
                clrsfl = *on;
                dspsfl = *off;
                sflend = *off;
                cbcount= *zero;
                write ctlb;
                clrsfl = *off;
                //?HERE no selection criteria ? bawl - no, protected by IN1F
                //?this is to prevent an auto load of a too big file.
                //?if target file is too big, uncomment one w2flsp loading
B03             //? if CBme = *blank and
                //?       CBtodayf = dmin          and
                //?       CBtodayt = dmax          and
                //?       CBnowf   = tmin          and
                //?       CBnowt   = tmax          ;
                //?    message('SEL0002');
                //?w2flsp = '50'; // empty subfile
                //?w2flsp = '40'; // with at least one blank line
E03             //? endif;

X02          when w2flsp = '10';
                //?if user has cleared filter fields, reset them to initial value
B03             if sqlmax = 0;
                   sqlmax = 0088;
E03             endif;
B03             if cbme='';
                   cbme='%';
E03             endif;
B03             if CBTODAYT = dmin;
                   CBTODAYT=dmax ;
E03             endif;
B03             if CBNOWT = tmin;
                   CBNOWT=tmax ;
E03             endif;
                w2flsp = '20';//?read next, load the subfile
                //?sample dynamic sql : the string is compiled by sql at runtime
                //?HERE prepare the SQL question
                mySelect = 'Select * ';
                myFrom = 'from JPL028p  ';
                whereAnd = 'Where ';
                myWhere = '';
                //?sample for alphabetic criteria
B03             if cbme <> '%';
                   myWhere = myWhere + whereAnd +
                      'me     like ''' + %trim(cbme) + '%''';
                   whereand = ' and ';
E03             endif;
                //?sample for numeric criteria
                //?next time perhaps
                //?sample for date criteria
B03             if cbtodayf <> dmin        ;//?today from
                   myWhere = myWhere + whereAnd +
                      'today >=''' +%char(cbtodayf) +'''';
                   whereand = ' and ';
E03             endif;
B03             if cbtodayt <> dmax        ;//?today to
                   myWhere = myWhere + whereAnd +
                      'today <=''' +%char(cbtodayt) +'''';
                   whereand = ' and ';
E03             endif;
                //?sample for time criteria
B03             if cbnowf <> tmin ;
                      myWhere = myWhere + whereAnd +
                      'now >=''' +%char(cbnowf  ) +'''' ;
                   whereand = ' and ';
E03             endif;
B03             if cbnowt <> tmax ;
                      myWhere = myWhere + whereAnd +
                      'now <= '''+%char(cbnowt  ) +'''' ;
                   whereand = ' and ';
E03             endif;
                //?HERE order, optimize & other sql parameters
                //?end of select : order, group, having, optimize, ...
                mySelectMore = ' order by me, today, now '
                   + 'for read only '
                   + 'optimize for 15 rows';
                //?assemble the count statement
                mySFW = *blank;
                mySFW = 'values(select count(*) from (' +
                   myselect + myfrom + mywhere
                   + ') as mySFW) into ?';
                //?log sql select in joblog
                //?message(*blank : mySFW:'':'':'*INFO':'':0);
                EXEC SQL
                   prepare JPL028p1 from : mysfw
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                exec sql
                   execute jpl028p1 using :sqlCount
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                //?subfile overflow
                cbcount = sqlcount;
B03             if sqlcount > 9999;
                   message('SQL0002');
                   w2flsp = '50';
                   iter;
E03             endif;
                //?user limit overflow
B03             if sqlcount > sqlmax;
                   w0flsp = '0400';
                   sp040();
B04                if fdyes = 'NO';
                      w0flsp = '0240';
                      iter;
E04                endif;
E03             endif;
                cbcount = sqlcount;
                //?accepted

                //?remember selection criteria -> refresh request auto detection
                f5ds.CBME = CBME ;
                f5ds.CBTODAYf = CBTODAYf ;
                f5ds.CBTODAYt = CBTODAYt ;
                f5ds.CBNOWf = CBNOWf ;
                f5ds.CBNOWt = CBNOWt;

                w0flsp = '0220';
                mySelect = 'Select * ';
                //?assemble the true select statement
                mySFW = *blank;
                mySFW = myselect + myfrom + mywhere + myselectmore ;
                //?log sql select in joblog
                message(*blank : mySFW:'':'':'*INFO':'':0);

B03             if kbisopen;
                   EXEC SQL
                      close jpl028kb
                      ;
                   kbisopen = *off ;
E03             endif ;
                EXEC SQL
                   prepare JPL028p2 from : mysfw
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                EXEC SQL
                   declare JPL028KB cursor for JPL028p2
                   ;
                EXEC SQL
                   open jpl028kb
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                kbisopen = *on;
X02          when w2flsp = '20';//?read next, handle dyn subfile : page is full
                w2flsp = '30';//?load one line in the subfile
                clear loop;
                EXEC SQL
                   fetch jpl028kb into : loop
                   ;
B03             if sqlcod = 100;
                   w2flsp = '40';//?end of selection: release cursor, ...
                   iter;
E03             endif;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                //?full page detection
                cbcsrw = cbcsr ;
B03             if cbpage <= cbline ;
                   dspsfl = *on;
                   sflend = *off;
                   cbline = 0;
                   cbcsr = cbcsrNP;
                   w2flsp = '50';//?show page
                   iter;
E03             endif;
X02          when w2flsp = '30';
                //?load one line, then read next
                w2flsp = '20';//?read next
                cbcsr = cbcsrw;
                cbline = cbline + 1;
                //?load one line
                zbsele = ' ';
                //?HERE load one subfile line
                //?sb        = loop.             ;
                sbme = loop.me ;
                sbtoday = loop.today ;
                sbnow = loop.now ;
                sbtimstm = loop.timstm ;
                //?* write one line
                cbcsr = cbcsr + 1;
                write sflb ;
X02          when w2flsp = '40';
                //?last subfile line
B03             if kbisopen;
                   EXEC SQL
                      close jpl028kb
                      ;
                   kbisopen = *off ;
E03             endif ;
                w2flsp = '50';//?show
                //?HERE choose to add one blank line in an empty subfile
B03             if cbcsr < 1 ;
                   clear sflb ;
                   cbcsr = 1 + cbcsr ;
                   write sflb;
E03             endif;
                cbcsrw = cbcsr ;
B03             if cbcsr >= 1;
                   clrsfl = *off;
                   dspsfl = *on;
                   sflend = *on;
                   cbcsr = cbcsrNP;
X03             else;
                   clrsfl = *off;
                   dspsfl = *off;
                   sflend = *off;
                   message('SEL0002');
E03             endif;
X02          when w2flsp = '50';
                //?show not-main-formats IE footer, ...
                w2flsp = '60';
                //?function key format
                write fmtkb ;
X02          when w2flsp = '60';//?show main format
                //?show again
                w2flsp = '70';//?check
                write pmqctl;//?show messages from program message queue
                //?*=----------------------------------------------
                //?* end of page loading
                //?* wait for page return from user
                //?*=----------------------------------------------
                exfmt ctlb ;//?active creen
                callp pmqcln() ;//?cleanup pmq
                //?controles
                //?* rollup
                limite = *off;
B03             if rollup = *on ;
B04                if sflend = *off;
                      cbcsrNP = 1 +cbcsrw ;
                      w2flsp = '30';//?load next line to subfil
                      iter ;
X04                else;
                      w2flsp = '50';//?show same screen
                      iter ;
E04                endif;
E03             endif;
                //?F3=quitter exit, annulation cancel
B03             if f3 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F12=cancel
B03             if f12 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F5=refresh
B03             if f5 = *on or IN1F = true ;
                   in1f = false;
                   w2flsp = '00';
                   iter;
E03             endif ;
X02          when w2flsp = '70';
                //?run controler
                w2flsp = '80';//?validate data
                //?run subfile
B03             if cbcsrw < 1 ;
                   message('SEL0002');
                   w2flsp = '80';
                   iter;
E03             endif;

B03             for ever;//?infinite loop
                   DeleteReq = *off;
                   readc(e) sflb;
B04                if %eof;
                      leave;
E04                endif;
                   //?something to do ?
B04                if zbsele <> *blank;
                      //?run
                      w0flsp= '0300' ;
                      sp030() ;
                      //?HERE check return code from SP
B05                   if W0FLSP ='OKOK';
                         w0flsp= '0270' ;//?commitable, continue with next line
X05                   else;
                         w0flsp= '0290' ;//?need rollback, exit loop on subfile
                         iter;
E05                   endif;
                      zbsele = ' ';
                      //?other fields : in sp030
                      update sflb ;
E04                endif ;
E03             endfor ;
X02          when w2flsp = '80';//?commit
                EXEC SQL
                   COMMIT
                   ;
                //?HERE change the field list from CTLB
                //?refresh requested ? (ctlb changed)
B03             if f5ds.CBME <> CBME or
                      f5ds.CBTODAYf<> CBTODAYf or
                      f5ds.CBTODAYt<> CBTODAYt or
                      f5ds.CBNOWf<> CBNOWf or
                      f5ds.CBNOWt<> CBNOWt;
                   w2flsp='00';
                   iter;
E03             endif;
                //?validation   HERE choose the exit
                //? w0flsp = *blank ;   // exit from program
                w2flsp = '50';//?show same page
                iter;
                //?cancel
X02          when w2flsp = '90';//?rollback
                w2flsp = '50';//?show same page
                EXEC SQL
                   ROLLBACK
                   ;
B03             if f3 = *on;
                   w0flsp=*blank ;//?exit
                   leave;
E03             endif;
B03             if f12 = *on;
                   w0flsp= '0250' ;//?back one page
                   leave;
E03             endif;
X02          other ;
B03             if returncode;
                   paok = *off ;
E03             endif;
                w0flsp = *blank ;//?exit
E02       endsl ;
E01    enddo ;
       //?--------------------
B01    begsr *pssr;
B02       if NeedDump;
             dumpcallstack();
             dump ;
             needdump=false;
E02       endif;
E01    endsr;
      /end-free
EPR  p                 e
       //?---------------------------------------------------------------
BPR  p sp030           b
       //?---------------------------------------------------------------
      /free
       //?update task
       //?never erase anything in loop., it already contains next record to display
       kcisopen = false;
B01    dow w1flsp = '03' ;//?boucle central
B02       select;
X02          when w2flsp = '00';
                //?initialisation
                w2flsp = '50';
                errind =  *all'0'   ;
                callp pmqcln();
                clear updt ;
                //?something to read ?
B03             if zbsele <> '1';
                   EXEC SQL
                      declare JPL028Kc cursor for
                   select * from JPL028p where me = : sbme and today = : sbtoday
                      and now = : sbnow
                      for update optimize for 1 rows
                      with cs
                      ;
                   sqlfound = false ;
                   clear updt ;
B04                dou true ;
B05                   if kcisopen ;
                         EXEC SQL
                            close JPL028Kc
                            ;
                         kcisopen = false ;
E05                   endif ;
                      EXEC SQL
                         open JPL028kc
                         ;

B05                   if sqlcod <> *zero;
                         message('DIV0001');
                         diagsqler (sqlcod:sqlerm);
                         leave;
E05                   endif;

                      kcisopen = true ;
                      EXEC SQL
                         fetch JPL028Kc into : updt
                         ;

B05                   if sqlcod <> *zero;
                         message('DIV0001');
                         diagsqler (sqlcod:sqlerm);
                         w0flsp = '0270';//?set a return code for sp020
                         iter ;
E05                   endif;
                      sqlfound = true;
E04                enddo;
B04                if not sqlfound;
                      zbsele ='5';
E04                endif;
E03             endif;
                errind = *all'0';
                //?HERE load update screen with table data
                //?fc          = updt.          ;
                fcme = updt.ME ;
                fctoday = updt.TODAY ;
                fcnow = updt.NOW ;
                fctimzon = updt.TIMSTM ;
                fcdec7 = updt.DEC7 ;
                fczoned7 = updt.ZONED7 ;
                fcfloat8 = updt.FLOAT8 ;
                fcint8 = updt.INT8 ;
                fcfixucs2 = updt.fixucs2 ;
B03             if zbsele='4';
                   DeleteReq = *on;//?screen indicator
X03             else;
                   DeleteReq = *off;
E03             endif;
X02          when w2flsp = '50';
                //?affichage
                w2flsp = '60';
X02          when w2flsp = '60';
                //?réaffichage
                w2flsp = '70';
                write pmqctl;//?program message queue
                //?active screen
B03             if zbsele ='4'
X..                or zbsele ='5';
                   write fmtc;
                   exfmt fmtp;//?protection format
X03             else;
                   write fmtp;
                   exfmt fmtc;//?data format
E03             endif;
                callp pmqcln() ;//?nettoyer la pmq
X02          when w2flsp = '70';
                w2flsp = '80';
                //?controles
                //?exit, annulation
B03             if f3 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
B03             if f12 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?refresh
B03             if f5 = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
                //?help request ?
B03             if f4    = *on;//?f4
B04                if RtnCsrFld = 'FCME';
                      //?do something
                      //?refresh screen
                      //?fcme     = ;
E04                EndIf;//?command
                   w2flsp = '60';
                   iter;
E03             EndIf;//?f4
                //?the job
                w2flsp = '80';
                //?* show only : end
B03             if zbsele ='5';
                   w0flsp = 'OKOK';
                   iter;
E03             endif;
                //?* DeleteReq
B03             if zbsele = '4';

                   EXEC SQL
                      DELETE FROM JPL028P WHERE CURRENT OF JPL028KC
                      ;
                   clear updt ;

B04                if sqlcod <> *zero;
                      sqlfound = false ;
                      message('DIV0001');
                      diagsqler (sqlcod:sqlerm);
                      w2flsp = '50';
                      iter;
X04                else;
                      sqlfound = true ;
E04                endif;
                   clear updt;
                   clear sflb;
                   W0FLSP ='OKOK';
                   iter;
E03             endif;
                //?* update data
                //?controls
                errind = *all'0';
                //?check something ?
B03             if lcase(fcme) = 'wrong'                               ;
                   erme = *on;
                   w2flsp = '60';
                   message          ('MSG0001');
E03             endif ;
B03             if fctoday < d'2000-01-01'                             ;
                   ertoday= *on;
                   w2flsp = '60';
                   message          ('MSG0001');
E03             endif ;
X02          when w2flsp = '80';
                //?validation
                //?* screen fields
                //?HERE load the file with screen fields
                //?updt.          = fc            ;
                updt.ME = fcme ;
                updt.TODAY = fctoday ;
                updt.NOW = fcnow ;
                updt.TIMSTM = fctimzon ;
                updt.DEC7 = fcdec7 ;
                updt.ZONED7 = fczoned7 ;
                updt.FLOAT8 = fcfloat8 ;
                updt.INT8 = fcint8 ;
                updt.fixucs2 = fcfixucs2 ;
                //?* other fields
                //?* update the file
B03             if zbsele = '1'
X..                or zbsele = '3';

                   EXEC SQL
                      INSERT INTO JPL028P VALUES(
                      : updt.ME
                      , : updt.TODAY
                      , : updt.NOW
                      , : updt.TIMSTM
                      , : updt.DEC7
                      , : updt.ZONED7
                      , : updt.FLOAT8
                      , : updt.INT8
                      , : updt.FixUcs2
                      )
                      ;

E03             endif;
B03             if zbsele = '2';
                   EXEC SQL
                      UPDATE JPL028P SET
                      ME = : updt.ME
                      , TODAY = : updt.TODAY
                      , NOW = : updt.NOW
                      , TIMSTM = : updt.TIMSTM
                      , DEC7 = : updt.DEC7
                      , ZONED7 = : updt.ZONED7
                      , FLOAT8 = : updt.FLOAT8
                      , INT8 = : updt.INT8
                      , FIXUCS2= : updt.fixucs2
                      WHERE CURRENT OF JPL028kc
                      ;
E03             endif;
B03             if sqlcod <> *zero;
                   sqlfound = false ;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   //?message('SQL8888' :sqlca:'':'JPLTOOLS');
                   w2flsp = '60';
                   iter;
X03             else;
                   sqlfound = true ;
E03             endif;
                //?reaffichage sous fichier
                //?HERE reload the subfile line
                //?sb          = updt.            ;
                sbme = updt.ME ;
                sbtoday = updt.TODAY ;
                sbnow = updt.NOW ;
                sbtimstm = updt.timstm ;
                w0flsp = 'OKOK';
                leave;
                //?abandon
X02          other ;
B03             if returncode;
                   paok = *off ;
E03             endif;
                w0flsp = 'KOKO' ;
                leave;
E02       endsl ;
E01    enddo;
B01    if kcisopen ;
          EXEC SQL
             close JPL028Kc
             ;
E01    endif ;
       //?--------------------
B01    begsr *pssr;
B02       if NeedDump;
             dumpcallstack();
             dump ;
             needdump=false;
E02       endif;
E01    endsr;
      /end-free
EPR  p                 e
       //?---------------------------------------------------------------
BPR  p sp040           b
       //?---------------------------------------------------------------
      /free
       //?run the user overflow limit
B01    dow w1flsp = '04' ;//?main loo
B02       select;
X02          when w2flsp = '00';
                //?initialisation
                fmtdx = 10;
                fmtdy = 7;
                w2flsp = '50';
                errind =  *all'0'   ;
                callp pmqcln();
                fdselect = mySelect;
                fdfrom = myFrom;
                fdwhere = myWhere;
                fdcount = sqlcount ;
                fdyes       = 'YES';
X02          when w2flsp = '50';
                //?show
                w2flsp = '60';
X02          when w2flsp = '60';
                //?show again
                w2flsp = '70';
                write pmqctl;//?program message queue
                exfmt fmtd;
                callp pmqcln() ;//?nettoyer la pmq
X02          when w2flsp = '70';
                //?control
                //?exit, annulation
B03             if f3 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
B03             if f12 = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?refresh
B03             if f5 = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
                //?run
                w2flsp = '80';
                //?update
                //?controls
                //?validation
X02          when w2flsp = '80';
                w0flsp = '    ';
                leave;
                //?cancel
X02          other ;
B03             if returncode;
                   paok = *off ;
E03             endif;
                w0flsp = *blank ;
                leave;
E02       endsl ;
E01    enddo ;
E01
       //?--------------------
B01    begsr *pssr;
B02       if NeedDump;
             dumpcallstack();
             dump ;
             needdump=false;
E02       endif;
E01    endsr;
      /end-free
EPR  p                 e
       //?---------------------------------------------------------------



