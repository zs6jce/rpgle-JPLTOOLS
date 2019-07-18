    ? * CRTMSGD   MSGID(AAA0001)
    ? *           MSGF(MESSAGE)
    ? *           MSG('Hello')
    ? *           SECLVL('No more information')
    ? *           CCSID(*JOB)
    ? * CRTMSGD   MSGID(SEL0002)
    ? *           MSGF(MESSAGE)
    ? *           MSG('Selection is empty. Change criteria')
    ? *           CCSID(*JOB)
    ? * CRTRPGMOD MODULE(DSPIFSR) SRCFILE(QPGMSRC) OPTION(*NODEBUGIO *SRCSTMT *SHOWCPY
    ? *           *SECLVL *EXPDDS) DBGVIEW(*ALL)
      *
    ? * CRTPGM PGM(DSPIFSR) BNDDIR(QC2LE) ACTGRP(*CALLER)
    ? *
    ? *
    ? *
      /define INFDS
    ? /define IFS
      /define LOWERCASE





     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


    ? *================================================================
    ? * sample of program
    ? *================================================================










    ? *HERE replace DSPF dspifs with target dspf
     fdspifsfm  cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)                   HERE with sfl ?
     f                                     sfile(sflc:ran01c)                   HERE with sfl ?
     f                                     indds(indara)



     d f5            e ds                  extname(dspifsfm:ctlb:*input)
     d                                     qualified

       //?Prototype for qsort - which should be in a /COPY member
     D C_QSort         Pr                  ExtProc('qsort')
     D   DataToSort                    *   value
     D   Elements                    10U 0 Value
     D   Size                        10U 0 Value
     D   SortFunct                     *   ProcPtr Value




     d SortElement     ds
     d                                     qualified
     d                                     based(pSortElement)
     d   d_name                            like(scname)                         displayed name
     d   s_name                            like(scname)                         sorted name
     d   d_ifs                             like(scifs )
     d   d_type                            like(sctype)
     d   s_type                            like(sctype)
     d
     d
     d SortArray       s          65535    based(pSortArray)
     d SortAryNbr      s             10i 0 inz(0)
     d SortAryPos      s             10i 0 inz(0)
     d SortAryLen      s             10i 0 inz(0)
     d SortEltlen      s             10i 0 inz(%size(SortElement))

       //?Constants used by qsort sequencing routines
     D High            C                   1
     D Low             C                   -1
     D Equal           C                   0

       //?Prototypes for the two seqencing routines used in the program
     D DirByName       Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)






    ? *
    ? * !!! indara ne recouvre PAS *in
     d indara          ds
     d  in0199                01     99
     d  errind                60     99
     d  in10                           n   overlay(indara:10)
     d  rollup                         n   overlay(indara:11)
     d  suppression                    n   overlay(indara:40)
     d  clrsfl                         n   overlay(indara:51)
     d  dspsfl                         n   overlay(indara:52)
     d  sflend                         n   overlay(indara:53)
     d  errsfl                         n   overlay(indara:60)
     d  ertype                         n   overlay(indara:61)                   HERE adapt the *IN
     d  ersele                         n   overlay(indara:61)
     d  ermonm                         n   overlay(indara:62)
     d  limite                         n   overlay(indara:98)
     d ranp1b          s                   like(ran01b)                         HERE with sfl ?
     d ranw1b          s                   like(ran01b)
     d ranw2b          s                   like(ran01b)
     d pag01b          s              2s 0
     d nbl01b          s              2s 0
     d ranp1c          s                   like(ran01b)                         HERE with sfl ?
     d ranw1c          s                   like(ran01b)
     d ranw2c          s                   like(ran01b)
     d pag01c          s              2s 0
     d nbl01c          s              2s 0








      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                         5000A
     D cmdlen                        15P 5 CONST
     D cmd             S           5000A
     D Pos             S              5  0

     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? * exemple :
    ? *d rc              s              9b 0
    ? *         rc =  c_system(cmde );
    ? *         if rc <> 0;
    ? *         dsply msgid;
    ? *         endif;



     d rc              s             10i 0
     d errcpe          ds
     d cpetxt                         3    inz('CPE')
     d cpenum                         4s 0
     D FileHandleA     s             10i 0
     D FileHandleE     s             10i 0
     D ASCIIData       s             20
     D Hexa_Data       ds            40
     d sbHex1                        10
     d sbHex2                        10
     d sbHex3                        10
     d sbHex4                        10
     D iConvData       ds            20
     d iData                          1    dim(20)
     D BytesIn         S             10i 0
     D curPos          S             10i 0
     d AtEof           s               n
     d hexa            pr         30000    varying
     d  txt                       15000    varying const

     d*false           c                   '0'
     d*true            c                   '1'

    ? * pour opendir

     D pathdir         S            500    varying
     D pathdirs        S            500
     D pathfile        S            500    varying
     D pathfiles       S            500
     D pathp           S               *   INZ
     D diropn          S             10I 0
     D diropnp         S               *   INZ
    ? * pour readdir
     Dentry            ds                  BASED(entryp)
     D  reserv1                      16
     D  filenogenid                  10U 0
     D  fileno                       10U 0
     D  reclen                       10U 0
     D  reserv3                      10I 0
     D  reserv4                       8A
     D  ccsid                        10I 0
     D  countryid                     2A
     D  langid                        3A
     D  nlsreserv                     3A
     D  namelen                      10I 0
     D  namedir                     256
     D entryp          S               *
     Dname             s            500    varying
     Dnamefile         s            500    varying
    ? *
    ? * pour stat  - attributs du fichier *stmf
     Dattr             ds                  likeds(statds)
    ? *
     Dnomifs           s            256
     Dstatp            S               *   INZ
     Dpathtot          s            256
     Dpathtotp         s               *   INZ
     Dpathtotlg        s              4  0
     Dperrorp          s               *   INZ
     Dperrordta        s             20    INZ('path() error')

     d myStat          ds                  likeds(statds)
     d myStat64        ds                  likeds(statds64)
     d myStatVFS       ds                  likeds(ds_statvfs)

    ? * HERE program name & parameters
     d dspifsr         pr
    ?d* paok                          1
     d dspifsr         pi
    ?d* paok                          1

      /free
       //?* programme principal
       //?* initialisation générale
       w0flsp =  '0000' ;//initialisation generale
B01    dow w0flsp <> *blanks ;//?boucle centrale
B02       select ;
X02          when w1flsp = '00';
                exsr sp000 ;//?initialisation
X02          when w1flsp = '01';
                exsr sp010 ;//?selection
X02          when w1flsp = '02';
                exsr sp020 ;//?detail par sous-fichier
X02          when w1flsp = '03';
                exsr sp030 ;//?mise à jour
X02          other;
                spmsda = 'routine cible (w0flsp) inconnue';
                exsr *pssr ;//?erreur dans wwflag
E02       endsl;
E01    enddo;
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?initialisation generale
       //?---------------------------------------------------------------
B00    begsr sp000 ;
       //?HERE choose initial screen
B02    //?if paok = '1';
       w0flsp= '0100' ;// selection
X02    //?else;
       //?   w0flsp= '0200' ;// sub-file
E02    //?endif;
       //?paok = *off ;
          pmqcln() ;
       faifs = *blank ;
       message('AAA0001');
E00    endsr ;
       //?---------------------------------------------------------------
       //?selection task
       //?---------------------------------------------------------------
B00    begsr sp010 ;
B01    dow w1flsp = '01';//main loop
B02       select;
X02          when w2flsp = '00';
                //?initialisation
                w2flsp = '50';
                indara = *all'0';
                //?HERE load the page
                //?fa        = bcl.             ;

X02          when w2flsp = '50';
                //?show
                w2flsp = '60';
                //?Fkey toolbar
                write fmtka ;
X02          when w2flsp = '60';
                //?show again
                w2flsp = '70';
                write pmqctl;//?program message queue
                exfmt fmta ;//?active screen
                callp pmqcln() ;//?cleanup the program message queue
X02          when w2flsp = '70';
                //?controles
                //?F4=lister le repertoire
B03             if *inkd = *on;
                   w0flsp = '0300';
                   iter;
E03             endif;
                //?F3=quit,   exit, annulation
B03             if *inkc = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F12=F3
B03             if *inkl = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F5=refresh
B03             if *inke = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
                //?at work
                w2flsp = '80';
                //?check           ?
                rc = access(%trim(faifs ): F_OK);
B03             if (rc <> 0);
                   cpenum=errno ;
                   message(errcpe:'':'':'QCPFMSG');
                   w2flsp = '60';

E03             endif;

X02          when w2flsp = '80';
                //?validation
                w0flsp = '0200' ;
                cbfrom = 0;
                //? paok = *on ;
                iter;
X02          other ;
                //?quit
                //?paok = *off ;
                w0flsp = *blank ;
E02       endsl ;
E01    enddo ;
E00    endsr;
       //?---------------------------------------------------------------
       //?task : subfile ascii dump of ifs file
       //?---------------------------------------------------------------
B00    begsr sp020 ;
       FileHandleE= open( %trim(faIFS)
          : O_TEXTDATA + O_RDONLY ) ;
B01    if filehandleE= -1;
          cpenum= errno();
          message(errcpe:'':'':'QCPFMSG');
E01    endif;
       rc = stat (%trim(FaIfs)+x'00': myStat );
       cbsize = mystat.st_size;
       FileHandleA= open( %trim(faIFS)
          : O_RDONLY ) ;
B01    if filehandleA= -1;
          cpenum= errno();
          message(errcpe:'':'':'QCPFMSG');
E01    endif;
       cbifs = faifs;
B01    dow w1flsp = '02';//main loop
B02       select;
X02          when w2flsp = '00';
                //?initialisation
                w2flsp = '10';
                indara = *all'0';
                ranp1b = 1;
                pag01b = 15;
                nbl01b = 0;
                callp pmqcln() ;
                //?initialisation    subfile
                ran01b = 0;
                clrsfl = *on;
                dspsfl = *off;
                sflend = *off;
                write ctlb;
                clrsfl = *off;
X02          when w2flsp = '10';
                //?read file & load subfile
                w2flsp = '20';
                //?HERE key list to read target file & remember last call to refresh
                Bytesin = cbfrom;
                CurPos = cbfrom;
                f5.cbfrom= cbfrom ;
                ateof = false;

X02          when w2flsp = '20';
B03             if ateof;
                   w2flsp = '40';
                   iter;
E03             endif;
                w2flsp = '30';
                iConvData = *allx'00';
                AsciiData = *allx'00';
                BytesIn =pread (FileHandleE: %addr(iConvData) : 20 :curpos) ;
                BytesIn =pread (FileHandleA: %addr(AsciiData) : 20 :curpos) ;

B03             if bytesin < 20;
                   ateof = true;
E03             endif;
                //?detection    page is full
                ranw1b = ran01b ;
B03             if pag01b <= nbl01b ;
                   dspsfl = *on;
                   sflend = *off;
                   nbl01b = 0;
                   ran01b = ranp1b;
                   w2flsp = '50';
                   iter;
E03             endif;
X02          when w2flsp = '30';
                //?load one line, read next
                w2flsp = '20';
                ran01b = ranw1b;
                nbl01b = nbl01b + 1;
                //?* load one line
                //?  zbsele = ' ';
                //?HERE load one line in the subfile
                //?sb        = bcl.             ;

                hexa_data = hexa(asciidata);
B03             for iFor = 1 to 20;
B04                if idata(ifor) < x'40';
                      idata(ifor) = '.';
E04                endif;
E03             endfor;
                if bytesin < 0; // y a des cas à -1
                bytesin = 0;
                endif;
B03             if bytesin < 20;
                   %subst(hexa_data : bytesin  * 2 +1) = *all'_';
                   %subst(iConvData : bytesin +1) = *blank ;
E03             endif;
                sbebcd = iconvdata;
                sbofst = curpos;
                curpos +=bytesin;
                //?* write one line
                ran01b = ran01b + 1;
                write sflb ;
X02          when w2flsp = '40';
                //?last line for subfile
                w2flsp = '50';
                //?HERE choose to add one blank line in an empty subfile
B03             if ran01b < 1 ;
                   clear sflb ;
                   ran01b = 1 + ran01b ;
                   write sflb;
E03             endif;
                ranw1b = ran01b ;
B03             if ran01b >= 1;
                   clrsfl = *off;
                   dspsfl = *on;
                   sflend = *on;
                   ran01b = ranp1b;
X03             else;
                   clrsfl = *off;
                   dspsfl = *off;
                   sflend = *off;
                   message      ('SEL0002') ;
E03             endif;
X02          when w2flsp = '50';
                //?show
                w2flsp = '60';
                //?Fkey tool bar
                write fmtkb ;
X02          when w2flsp = '60';
                //?show again
                w2flsp = '70';
                write pmqctl;//?program message queue
                exfmt ctlb ;//?
                callp pmqcln() ;//?
                //?controles
                //?* rollup
                limite = *off;
B03             if rollup = *on ;
B04                if sflend = *off;
                      ranp1b = 1 +ranw1b ;
                      w2flsp = '30';
                      iter ;
X04                else;
                      w2flsp = '50';
                      iter ;
E04                endif;
E03             endif;
                //?F3=quit, exit, annulation
B03             if *inkc = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F12=F3
B03             if *inkl = *on;
                   w0flsp = '0100';
                   iter;
E03             endif;
                //?F5=refresh
B03             if *inke = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
X02          when w2flsp = '70';
                //?work the subfile controler
                w2flsp = '80';
B03             if ranw1b < 1 ;
                   message      ('SEL0002');
                   w2flsp = '80';
                   iter;
E03             endif;
                ranw2b = ranw1b;
B03             dow 1=1;//?for ever loop
                   suppression = *off;
                   readc(e) sflb;
B04                if %eof;
                      leave;
E04                endif;
                   //?something to do ?
E03             enddo ;
X02          when w2flsp = '80';
                //?HERE change the field list from CTLB
                //?refresh requested ? (ctlb changed)
B03             if f5.CBfrom <> CBfrom;
X..
X..
                   w2flsp='00';
                   iter;
E03             endif;

                //?validation  HERE choose the exit
                //?     w0flsp = *blank ;// exit program
                w2flsp = '50';              // show again
                   iter;
X02          other ;
                //?exit
                //?paok   = *off   ;
                w0flsp = *blank ;
E02       endsl ;
E01    enddo ;
       Rc = close(FileHandleE) ;
       Rc = close(FileHandleA) ;
E00    endsr;
       //?---------------------------------------------------------------
       //?task : subfile list of the directory
       //?---------------------------------------------------------------
B00    begsr sp030 ;
B01    dow w1flsp = '03';//main loop
B02       select;
X02          when w2flsp = '00';
                //?initialisation
                w2flsp = '10';
                indara = *all'0';
                ranp1c = 1;
                pag01c = 15;
                nbl01c = 0;
                callp pmqcln() ;
                //?initialisation    subfile
                ran01c = 0;
                clrsfl = *on;
                dspsfl = *off;
                sflend = *off;
                write ctlc;
                clrsfl = *off;
B03             if faifs = *blank;
                   faifs='/';
E03             endif;
                pathdir = %trim(faifs);
B03             if %len(pathdir)>1;
B04                if %subst(pathdir:%len(pathdir):1)='/';
                      %len(pathdir)=%len(pathdir)-1;
E04                endif;
E03             endif;
                ccifs = pathdir ;
                rc = %len(pathdir)+1;
                %str(%addr(pathdirs):rc)=pathdir;
                rc = access(pathdirs : F_OK);
B03             if (rc <> 0);
                   message(errnomsg(errno):'':'':'QCPFMSG');
                   w0flsp='0100';
E03             endif;
X02          when w2flsp = '10';
                //?read file & load subfile
                w2flsp = '20';
                //?HERE key list to read target file & remember last call to refresh

                rc = stat (pathdirs: myStat );
                rc = stat64 (pathdirs: myStat64 );
                rc = statvfs(pathdirs: myStatVFS );

                diropnp = opendir(pathdirs );
                //?cleanup previous usage of sortArray
B03             if pSortArray <> *null;
                   dealloc pSortArray;
E03             endif;
                pSortArray=%alloc(1);
                sortarylen = 0 ;
                sortaryNbr = 0 ;

B03             for ever;
                   //?read each dir entry
                   entryp= readdir(diropnp) ;
B04                if entryp = *null ;
                      leave;
E04                endif ;
                   //?add an element to sort array
                   sortarylen+= sorteltlen;
                   sortAryNbr+=1;
                   pSortArray=%realloc(pSortArray:SortAryLen);
                   //?prepare last element for update
                   pSortElement = pSortArray + SortaryLen - sorteltlen ;
                   //?prepare data to update element
                   name=%subst(namedir:1:namelen);
                   //?* on traite le . et le ..
B04                if (%subst(namedir:1:2) =  '..');
                      rc = %len(pathdir);
B05                   for iFor = rc downto 1 by 1;
B06                      if %subst(pathdir:iFor:1) = '/';
                            pathfile= %subst(pathdir:1:iFor - 1);
                            leave;
E06                      endif;
E05                   endfor;
B05                   if pathfile='';
                         pathfile = '/';
E05                   endif;
                      attr.st_objtype = '*dir'     ;
X04                elseif (%subst(namedir:1:1) =  '.');
                      pathfile = pathdir;
                      attr.st_objtype = '*dir'     ;
X04                else;
B05                   if pathdir='/';
                         pathfile= pathdir + name ;
X05                   else;
                         pathfile=      pathdir +'/'+ name ;
E05                   endif;
                      rc=%len(pathfile)+1;
                      %str(%addr(pathfiles):rc) = pathfile;
                      //?* appel de l'API stat pour recuperation du type : *stmf ou directory
                      rc = stat(pathfiles: attr ) ;
B05                   if rc = -1 ;
                         message(errnomsg(errno):'':'':'QCPFMSG');
E05                   endif;
E04                endif;
                   //?update the element
                   sortelement.d_name = name ;
                   sortelement.s_name = lcase(name) ;
                   sortelement.d_ifs = pathfile;
                   sortelement.d_type = attr.st_objtype ;
                   sortelement.s_type = lcase(attr.st_objtype) ;
B04                if sortelement.s_type = '*ddir' or
                         sortelement.s_type = '*lib' or
                         sortelement.s_type = '*flr';
                      sortelement.s_type = '*dir' ;
E04                endif;
E03             endfor;
                //?directory is completely readen. Sort it
B03             //?for iFor = 0 to sortarynbr - 1;
                //?   psortelement = psortarray + (iFor * SortEltLen);
                //?   message ( '':SortElement.sctype + sortelement.scname);
E03             //?endfor;
                //?message ( '':'---------- Quick Sort -----------'    );
                C_QSort(PSortArray:SortAryNbr:SortEltLen:%Paddr(DirByName));
B03             //?for iFor = 0 to sortarynbr - 1;
                //?   psortelement = psortarray + (iFor * SortEltLen);
                //?   message ( '':SortElement.sctype + sortelement.scname);
E03             //?endfor;
                SortAryPos = 1;
X02             w2flsp = '20';
X02          when w2flsp = '20';
B03             if sortARyPos > SortAryNbr;
                   w2flsp = '40';
                   iter;
E03             endif;
                w2flsp = '30';
                //?detection    page is full
                ranw1c = ran01c ;
B03             if pag01c <= nbl01c ;
                   dspsfl = *on;
                   sflend = *off;
                   nbl01c = 0;
                   ran01c = ranp1c;
                   w2flsp = '50';
                   iter;
E03             endif;
X02          when w2flsp = '30';
                //?load one line, read next
                w2flsp = '20';
                ran01c = ranw1c;
                nbl01c = nbl01c + 1;
                //?* load one line
                //?  zbsele = ' ';
                //?HERE load one line in the subfile
                //?sb        = bcl.             ;
                pSortElement = pSortArray + ( SortaryPos - 1 ) * sortEltLen ;
                scname = sortElement.d_name;
                scifs = sortelement.d_ifs;
                sctype = sortelement.d_type;
                scsele='';
                sortarypos+=1;
                //?* write one line
                ran01c = ran01c + 1;
                write sflc ;
X02          when w2flsp = '40';
                //?last line for subfile
                w2flsp = '50';
                //?HERE choose to add one blank line in an empty subfile
B03             if ran01c < 1 ;
                   clear sflc ;
                   name = '..';
                   pathfile = '';
                   rc = %len(pathdir);
B04                for iFor = rc downto 1 by 1;
B05                   if %subst(pathdir:iFor:1) = '/';
                         pathfile= %subst(pathdir:1:iFor - 1);
                         leave;
E05                   endif;
E04                endfor;
B04                if pathfile='';
                      pathfile = '/';
E04                endif;
                   attr.st_objtype = '*dir'     ;
                   scname = name ;
                   scifs = pathfile;
                   sctype = attr.st_objtype ;
                   scsele='';
                   ran01c = 1 + ran01c ;
                   write sflc;
E03             endif;
                ranw1c = ran01c ;
B03             if ran01c >= 1;
                   clrsfl = *off;
                   dspsfl = *on;
                   sflend = *on;
                   ran01c = ranp1c;
X03             else;
                   clrsfl = *off;
                   dspsfl = *off;
                   sflend = *off;
                   message      ('SEL0002') ;
E03             endif;
X02          when w2flsp = '50';
                //?show
                w2flsp = '60';
                //?Fkey tool bar
                write fmtkc ;
X02          when w2flsp = '60';
                //?show again
                w2flsp = '70';
                write pmqctl;//?program message queue
                exfmt ctlc ;//?
                callp pmqcln() ;//?
                //?controles
                //?* rollup
                limite = *off;
B03             if rollup = *on ;
B04                if sflend = *off;
                      ranp1c = 1 +ranw1c ;
                      w2flsp = '30';
                      iter ;
X04                else;
                      w2flsp = '50';
                      iter ;
E04                endif;
E03             endif;
                //?F3=quit, exit, annulation
B03             if *inkc = *on;
                   w0flsp = *blank;
                   iter;
E03             endif;
                //?F12=F3
B03             if *inkl = *on;
                   w0flsp = '0100';
                   iter;
E03             endif;
                //?F5=refresh
B03             if *inke = *on ;
                   w2flsp = '00';
                   iter;
E03             endif ;
X02          when w2flsp = '70';
                //?work the subfile controler
                w2flsp = '80';
B03             if ranw1c < 1 ;
                   message      ('SEL0002');
                   w2flsp = '80';
                   iter;
E03             endif;
                ranw2c = ranw1c;
B03             dow 1=1;//?for ever loop
                   suppression = *off;
                   readc(e) sflc;
B04                if %eof;
                      leave;
E04                endif;
                   //?something to do ?
                   faifs = scifs;
B04                if sctype = '*STMF';
                      w0flsp = '0100';
X04                elseif sctype ='*MBR';
                      w0flsp = '0100';
X04                else;
                      w2flsp = '00';
E04                endif;
E03             enddo ;
X02          when w2flsp = '80';
                //?HERE change the field list from CTLB
                //?refresh requested ? (ctlb changed)
                //?validation  HERE choose the exit
                //?     w0flsp = *blank ;// exit program
                w2flsp = '50';              // show again
                   iter;
X02          other ;
                //?exit
                //?paok   = *off   ;
                w0flsp = *blank ;
E02       endsl ;
E01    enddo ;


E00    endsr;
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
BPR  P hexa            b
     d hexa            pi         30000    varying
     d  txt                       15000    varying const
     d  i              s              5u 0
     d  hex            s          30000    varying
     d  h              ds             2
     d  h1                     1      1i 0
     d  h2                     2      2i 0
     d  c                      1      1
     d  h12                    1      2i 0
     d  x12                    1      2
     d  w12            s              2
      /free
B01    for i = 1 to %len(txt);
          h12 = 0;
          c = %subst(txt:i:1);
          h12=h12/ 16;
          h2 =h2 / 16;
          w12 = x12;
          x12 = %bitand(x12:x'0F0F');
B02       select;
X02          when h1 = 0;
                hex +='0';
X02          when h1 = 1;
                hex +='1';
X02          when h1 = 2;
                hex +='2';
X02          when h1 = 3;
                hex +='3';
X02          when h1 = 4;
                hex +='4';
X02          when h1 = 5;
                hex +='5';
X02          when h1 = 6;
                hex +='6';
X02          when h1 = 7;
                hex +='7';
X02          when h1 = 8;
                hex +='8';
X02          when h1 = 9;
                hex +='9';
X02          when h1 =10;
                hex +='A';
X02          when h1 =11;
                hex +='B';
X02          when h1 =12;
                hex +='C';
X02          when h1 =13;
                hex +='D';
X02          when h1 =14;
                hex +='E';
X02          when h1 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
B02       select;
X02          when h2 = 0;
                hex +='0';
X02          when h2 = 1;
                hex +='1';
X02          when h2 = 2;
                hex +='2';
X02          when h2 = 3;
                hex +='3';
X02          when h2 = 4;
                hex +='4';
X02          when h2 = 5;
                hex +='5';
X02          when h2 = 6;
                hex +='6';
X02          when h2 = 7;
                hex +='7';
X02          when h2 = 8;
                hex +='8';
X02          when h2 = 9;
                hex +='9';
X02          when h2 =10;
                hex +='A';
X02          when h2 =11;
                hex +='B';
X02          when h2 =12;
                hex +='C';
X02          when h2 =13;
                hex +='D';
X02          when h2 =14;
                hex +='E';
X02          when h2 =15;
                hex +='F';
X02          other;
                hex+='?';
E02       endsl;
E01    endfor;
       return hex;
      /end-free
    ?C*=------------------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  P                 e
BPR  P DirByName       b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    SELECT;
          //?level 1 sort : by type
X01       WHEN Element1.s_type > Element2.s_type;
             RETURN High;
X01       WHEN Element1.s_type < Element2.s_type;
             RETURN Low ;
             //?next level : by name
X01       WHEN Element1.s_name > Element2.s_name;
             RETURN High;
X01       WHEN Element1.s_name < Element2.s_name;
             RETURN Low ;
X01       OTHER;
             RETURN Equal;
E01    ENDSL;

B00    BEGSR *PSSR ;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  P                 e
