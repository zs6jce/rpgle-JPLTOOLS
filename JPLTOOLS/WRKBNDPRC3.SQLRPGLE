    ? *  compilation :
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
     fwrkbndprcfcf   e             workstn
     f                                     infds(fids)
     f                                     sfile(sflb:cbcsr )
     f                                     indds(indara)
     d f5ds          e ds                  extname(wrkbndprcf:ctlb       )
     d                                     qualified
    ? */HERE replace all wrkbndprcp with target file
     d loop          e ds                  extname(wrkbndprcp)
     d                                     qualified
     d updt          e ds                  extname(wrkbndprcp)
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
     d main            pr                  extpgm('MAIN')
     d
     d main            pi


     d mySFW           s           5000
     d sqlCount        s              9b 0
     d sqlfound        s               n
     d ReadOrUpdate    s             20
     d In1F            s               n
     d returncode      s               n
      /free



       EXEC SQL
          Set Option Commit = *none
          , CloSQLCsr = *ENDMOD
          , DatFmt = *ISO
          , TimFmt = *ISO
          , Naming = *SYS
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
X02

X02          when w1flsp = '02';
                sp020() ;//?detail subfile
X02

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

B02

X02
             w0flsp= '0200' ;//?sub-file
E02
X02

E01
B01

E01
       clear f5ds;//?refresh detector
       pmqcln() ;
       message('AAA0001');//?welcome message
       //?HERE initialize selection criteria
       sqlmax = 0888;//?why not ! it's to fix a value. Any value is correct
E01
E01
E01
E01
E01
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
       //?---------------------------------------------------------------
BPR  p sp020           b
       //?---------------------------------------------------------------
      /free
       //?task : subfile
B01    dow w1flsp = '02' ;//?main loop
B02       select;
X02          when w2flsp = '00';
                //?initialisation
B03

X03
                   w2flsp = '10';//?load screen
E03

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



B03







E03

X02          when w2flsp = '10';
                //?if user has cleared filter fields, reset them to initial value
B03             if sqlmax = 0;
                   sqlmax = 0888;
E03             endif;
B03

E03
B03

E03
B03

E03
                w2flsp = '20';//?read next, load the subfile
                //?sample dynamic sql : the string is compiled by sql at runtime
                //?HERE prepare the SQL question
                mySelect = 'Select * ';
                myFrom = 'from wrkbndprcp  ';
                whereAnd = 'Where ';
                myWhere = '';
                //?apply filters
                cbsrv = lcase(cbsrv);
                cbmod = lcase(cbmod);
                cbproc= lcase(cbproc);
B03             if cbsrv <> '%' and cbsrv <> '';
                   myWhere = myWhere + whereAnd +
                      'lower(obj_name) like ''%' + %trim(cbsrv) + '%''';
                   whereand = ' and ';
E03             endif;
B03             if cbmod <> '%' and cbmod <> '';
                   myWhere = myWhere + whereAnd +
                      'lower(mod_name) like ''%' + %trim(cbmod) + '%''';
                   whereand = ' and ';
E03             endif;
B03             if cbproc <> '%' and cbproc <> '';
                   myWhere = myWhere + whereAnd +
                      'lower(procname) like ''%' + %trim(cbproc) + '%''';
                   whereand = ' and ';
E03             endif;
                //?HERE order, optimize & other sql parameters
                //?end of select : order, group, having, optimize, ...
                mySelectMore =
                     'for read only '
                   + 'optimize for 15 rows';
                //?assemble the count statement
                mySFW = *blank;
                mySFW = 'values(select count(*) from (' +
                   myselect + myfrom + mywhere
                   + ') as mySFW) into ?';
                //?log sql select in joblog
                //?message(*blank : mySFW:'':'':'*INFO':'':0);
                EXEC SQL
                   prepare wrkbndprcp1 from : mysfw
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                exec sql
                   execute wrkbndprcp1 using :sqlCount
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
                f5ds.CBsrv= CBsrv;
                f5ds.CBmod    = CBmod    ;
                f5ds.CBproc   = CBproc   ;



                w0flsp = '0220';
                mySelect = 'Select * ';
                //?assemble the true select statement
                mySFW = *blank;
                mySFW = myselect + myfrom + mywhere + myselectmore ;
                //?log sql select in joblog
                message(*blank : mySFW:'':'':'*INFO':'':0);

B03             if kbisopen;
                   EXEC SQL
                      close wrkbndprcKb
                      ;
                   kbisopen = *off ;
E03             endif ;
                EXEC SQL
                   prepare wrkbndprcp2 from : mysfw
                   ;
B03             if sqlcod <> *zero;
                   message('DIV0001');
                   diagsqler (sqlcod:sqlerm);
                   w2flsp = '50';
                   iter;
E03             endif;
                EXEC SQL
                   declare wrkbndprcKB cursor for wrkbndprcp2
                   ;
                EXEC SQL
                   open wrkbndprcKb
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
                   fetch wrkbndprcKb into : loop
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
                sbsrv= loop.obj_name;
                sbmod   = loop.mod_name   ;
                sbproc= loop.procname;

                //?* write one line
                cbcsr = cbcsr + 1;
                write sflb ;
X02          when w2flsp = '40';
                //?last subfile line
B03             if kbisopen;
                   EXEC SQL
                      close wrkbndprcKb
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



                //?HERE change the field list from CTLB
                //?refresh requested ? (ctlb changed)
B03             if f5ds.CBsrv<> CBsrv or
                      f5ds.cbmod     <> CBmod    or
                      f5ds.cbproc    <> CBproc
                      ;

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
                      declare wrkbndprcKc cursor for
                   select * from wrkbndprcp where obj_name = : sbsrv
                      and mod_name = : sbmod
                      and procname = : sbproc
                                 optimize for 1 rows

                      ;
                   sqlfound = false ;
                   clear updt ;
B04                dou true ;
B05                   if kcisopen ;
                         EXEC SQL
                            close wrkbndprcKc
                            ;
                         kcisopen = false ;
E05                   endif ;
                      EXEC SQL
                         open wrkbndprcKc
                         ;

B05                   if sqlcod <> *zero;
                         message('DIV0001');
                         diagsqler (sqlcod:sqlerm);
                         leave;
E05                   endif;

                      kcisopen = true ;
                      EXEC SQL
                         fetch wrkbndprcKc into : updt
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
                //?the job
                w2flsp = '80';
                //?* show only : end
B03             if zbsele ='5';
                   w0flsp = 'OKOK';
                   iter;
E03             endif;
                //?* DeleteReq
                //?* update data
                //?controls
                errind = *all'0';
X02          when w2flsp = '80';
                //?validation
                //?* screen fields
                //?HERE load the file with screen fields
                //?updt.          = fc            ;
                //?* other fields
                //?* update the file
                //?reaffichage sous fichier
                //?HERE reload the subfile line
                //?sb          = updt.            ;
                w0flsp = 'OKOK';
                leave;
                //?abandon
X02          other ;
B03             if returncode;

E03             endif;
                w0flsp = 'KOKO' ;
                leave;
E02       endsl ;
E01    enddo;
B01    if kcisopen ;
          EXEC SQL
             close wrkbndprcKc
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



