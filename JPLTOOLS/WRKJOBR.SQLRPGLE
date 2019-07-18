
    ? */ compilation :
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
      /define INFDS
    ? */define VBEL
    ? */define ECOPRO
    ? */define SQL
    ? */define SQLDESCRIBE
      /define LOWERCASE
    ? */define QUOTE
    ? */define XLXML
    ? /define RTVJOBA
    ? /define USERSPACE
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION

    ? */================================================================
    ? */ modèle de programme
    ? */================================================================
    ? */les adaptations nécessaires sont marquées  : ICI





    ? */HERE replace DSPF wrkjob with target dspf
     fwrkjobfm  cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)
     f                                     indds(indara)
     f************************************ Maxdev(*File)                        force response

     d f5            e ds                  extname(wrkjobfm:ctlb       )
     d                                     prefix(F5_)

    ? */ !!! indara ne recouvre PAS *in
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
     d  erme                           n   overlay(indara:61)
     d  msgwline                       n   overlay(indara:62)
     d  sortind               71     79
     d  byjobname                      n   overlay(indara:71)
     d  byusername                     n   overlay(indara:72)
     d  byjobnbr                       n   overlay(indara:73)
     d  bycuruser                      n   overlay(indara:74)
     d  byip                           n   overlay(indara:75)
     d  bysbs                          n   overlay(indara:76)
     d  bysts                          n   overlay(indara:77)
     d  limite                         n   overlay(indara:98)
     d ranp1b          s                   like(ran01b)
     d ranw1b          s                   like(ran01b)
     d ranw2b          s                   like(ran01b)
     d pag01b          s              2s 0
     d nbl01b          s              2s 0
     d autorefresh     s               n


      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

    ? */ commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     D QCmd            PR                  EXTPGM('QCMD')

     D QCmdLn          PR                  EXTPGM('QUSCMDLN')

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                          400A
     D cmdlen                        15P 5 CONST
     D cmd             S            400A
     D Pos             S              5  0

     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? */ exemple :
     d rc              s              9b 0
     d cmde            s           1000    varying
    ? */         rc =  c_system(cmde );
    ? */         if rc <> 0;
    ? */         dsply msgid;
    ? */         endif;


       //?Prototype for qsort - which should be in a /COPY member
     D C_QSort         Pr                  ExtProc('qsort')
     D   DataToSort                    *   value
     D   Elements                    10U 0 Value
     D   Size                        10U 0 Value
     D   SortFunct                     *   ProcPtr Value

     d SortElement     ds
     d                                     qualified
     d                                     based(pSortElement)
     d   JOBNAME                           like(sbJOBNAME )
     d   USERNAME                          like(sbUSERNAME)
     d   JOBNBR                            like(sbJOBNBR  )
     d   CURUSER                           like(sbCURUSER )
     d   IP                                like(sbIP      )
     d   sts                               like(sbsts     )
     d   SBS                               like(sbSBS     )
     d SortArray       s          65535    based(pSortArray)
     d SortAryNbr      s             10i 0 inz(0)
     d SortAryPos      s             10i 0 inz(0)
     d SortAryLen      s             10i 0 inz(0)
     d SortEltlen      s             10i 0 inz(%size(SortElement))
       //?Constants used by qsort sequencing routines
     D High            C                   1
     D Low             C                   -1
     D Equal           C                   0
       //?Prototypes for the sequencing routines used in the program
     D SortBySbsJob    Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortByjobname   Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortByusername  Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortByjobnbr    Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortBycuruser   Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortByip        Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortBySbs       Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
     D SortBySts       Pr            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)

     d SortBy          s               *   procptr

    ? */ parametres du programme
     d wrkjobr         pr
     d wrkjobr         pi

     d In1F            s               n

     d LAH             ds                  likeds(ListApiHeader) based(pLAH)

     d qjob            ds            26    qualified
     d   name                        10
     d   user                        10    inz('*ALL')
     d   nbr                          6    inz('*ALL')
       //?List Job (QUSLJOB) API
     d qusljob         pr                  extpgm('QUSLJOB')
     d   user_space                  20    const
     d   Format                       8    const
     d   jobname                     26    const
     d   Status                      10    const
       //?Optional Parameter Group 1:
     d   Error_Code                 256    options(*nopass:*varsize)
       //?Optional Parameter Group 2
     d   Job_type                     1    options(*nopass) const
     d   fields_count                10i 0 options(*nopass) const
     d   Key                         10i 0 options(*nopass) const
       //? Optional Parameter Group 3:
     d   handle                      48    options(*nopass) const
     D JOBL0100        ds                  qualified based(pJobL0100)
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_ID                   16
     d Status                        10
     d Job_type                       1
     d Job_subtype                    1
     d Reserved                       2

     d sel             s             20    varying


       //?unused actually : regular expression

    ?**
     D REG_BASIC       C                   CONST(0)
     D REG_EXTENDED    C                   CONST(1)
     D REG_ICASE       C                   CONST(2)
     D REG_NEWLINE     C                   CONST(4)
     D REG_NOSUB       C                   CONST(8)
     D REG_NOTBOL      C                   CONST(256)
     D REG_NOTEOL      C                   CONST(512)
     D REG_NOMATCH     C                   CONST(1)
     D REG_BADPAT      C                   CONST(2)
     D REG_ECOLLATE    C                   CONST(3)
     D REG_ECTYPE      C                   CONST(4)
     D REG_EESCAPE     C                   CONST(5)
     D REG_ESUBREG     C                   CONST(6)
     D REG_EBRACK      C                   CONST(7)
     D REG_EPAREN      C                   CONST(8)
     D REG_EBRACE      C                   CONST(9)
     D REG_BADBR       C                   CONST(10)
     D REG_ERANGE      C                   CONST(11)
     D REG_ESPACE      C                   CONST(12)
     D REG_BADRPT      C                   CONST(13)
     D REG_ECHAR       C                   CONST(14)
     D REG_EBOL        C                   CONST(15)
     D REG_EEOL        C                   CONST(16)
     D REG_ECOMP       C                   CONST(17)
     D REG_EEXEC       C                   CONST(18)
     D REG_SUBEXP_MAX  C                   10
     D regex_t         DS                  qualified
     D                                     align based(prototype_only)
     D   re_nsub                     10I 0
     D   re_comp                       *
     D   re_cflags                   10I 0
     D   re_erroff                   10I 0
     D   re_len                      10I 0
     D   re_ucoll                    10I 0 dim(2)
     D   re_lsub                       *   DIM(REG_SUBEXP_MAX)
     D   re_esub                       *   DIM(REG_SUBEXP_MAX)
     D   re_map                     256A
     D   re_shift                     5I 0
     D   re_dbcs                      5I 0
     D regmatch_t      DS                  qualified
     D                                     align based(prototype_only)
     D   rm_so                       10I 0
     D   rm_ss                        5I 0
     D   rm_eo                       10I 0
     D   rm_es                        5I 0
     D regcomp         PR            10I 0 extproc('regcomp')
     D   preg                              likeds(regex_t)
     D   pattern                       *   value options(*string)
     D   cflags                      10I 0 value
     D regexec         PR            10I 0 extproc('regexec')
     D   preg                              likeds(regex_t) const
     D   string                        *   value options(*string)
     D   nmatch                      10U 0 value
     D   pmatch                            likeds(regmatch_t) dim(100)
     D                                     options(*varsize)
     D   eflags                      10I 0 value
     D regerror        PR            10U 0 extproc('regerror')
     D   errcode                     10I 0 value
     D   preg                              likeds(regex_t) const
     D   errbuf                        *   value
     D   errbuf_size                 10I 0 value
     D regfree         PR                  extproc('regfree')
     D   preg                              likeds(regex_t)
     D reg             ds                  likeds(regex_t)
     D match           ds                  likeds(regmatch_t)
     D buf             s             80A
     D RRN             s              4S 0
    ?D*rc              s             10I 0
     d msg             s            100
     d matchout        s              1















       //?loop pointer : 1 to LAH.count
     d iJob            s             10i 0

     D Usrspc          c                   const( 'WRKJOB    QTEMP     ' )
     d errcode         ds                  likeds(errorcodehandler)

     c/EXEC Sql
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec

      /free
       //?* programme principal
       //?* initialisation générale
       W0flsp = '0000' ;   //?initialisation generale
B01    Dow W0flsp <> *blanks ;   //?boucle centrale
B02       Select ;
X02          When W1flsp = '00';
                Exsr Sp000 ;   //?initialisation
X02          When W1flsp = '02';
                Exsr Sp020 ;   //?detail par sous-fichier
X02          Other;
                Spmsda = 'routine cible (w0flsp) inconnue';
                Exsr *pssr ;   //?erreur dans wwflag
E02       Endsl;
E01    Enddo;
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?initialisation generale
       //?---------------------------------------------------------------
B00    Begsr Sp000 ;
       //?HERE choose initial screen
       In1F =True;
       sortind=*all'0';
       bysbs=*on;
       byjobname=*on;
       SortBy = %Paddr(SortBySbsJob);
       Cbjobname ='QZDA*' ;
       Cbusername='*ALL ' ;
       Cbjobnbr ='*ALL ' ;
       Cbcuruser ='*ALL ' ;
       Cbip ='*ALL ' ;
       Cbsbs ='*ALL ' ;
       Cbsts ='*ALL ' ;
       Cbstatus ='*ACTIVE' ;
       W0flsp= '0200' ;
       Clear f5;
       Pmqcln() ;
       Message('AAA0001');
       Sqlmax = 8888;
E00    Endsr ;
       //?---------------------------------------------------------------
       //?task : subfile
       //?---------------------------------------------------------------
B00    Begsr Sp020 ;
B01    Dow W1flsp = '02' ;   //?boucle centrale
B02       Select;
X02          When W2flsp = '00';
                //?initialisation
B03             If In1F;
                   W2flsp = '50';
X03             Else;
                   W2flsp = '10';
E03             Endif;
                //?indara = *all'0';
                ranp1b = 1;
                pag01b = 15;
                nbl01b = 0;
                Callp Pmqcln() ;
                //?initialisation du sous-fichier
                Ran01b = 0;
                clrsfl = *on;
                dspsfl = *off;
                sflend = *off;
                Cbcount= *zero;
                Write Ctlb;
                clrsfl = *off;
                //?HERE no selection criteria ? bawl
                //?if CBme = *blank and
                //?   CBtodayf = d'0001-01-01' and
                //?   CBtodayt = d'0001-01-01' and
                //?   CBnowf   = t'00.00.00'   and
                //?   CBnowt   = t'00.00.00'   ;
                //?   message('SEL0002');
                //?   w2flsp = '50';
                //?endif;

X02          When W2flsp = '10';
                //?lecture et chargement du sous-fichier
                W2flsp = '20';
                Clear errcode;
                errcode.Provided =%Size(errcode);
                //?HERE prepare the list of jobs
                //?create a user space
                Quscrtus ( Usrspc   //?get memory for array
                   : *blank
                   : 1
                   : X'00'
                   : '*ALL'
                   : *blank
                   : '*YES'
                   : errcode
                   : '*USER'
                   );
B03             If (errcode.Available>0);
                   Message(errcode.MSGID:errcode.Msgdta:'':'QCPFMSG' );
                   W2flsp = '50';
                   Iter;
E03             Endif;
                //?with attribute auto-extensible
                Quscusat ( Lib
                   : Usrspc
                   : Attributes
                   : errcode
                   );
B03             If (errcode.Available>0);
                   Message(errcode.MSGID:errcode.Msgdta:'':'QCPFMSG' );
                   W2flsp = '50';
                   Iter;
E03             Endif;
                //?get list of jobs : check filter fields from controller
                //?first 3 fields are runned by API : add missing * at end
B03             If Cbjobname='' Or Cbjobname='*ALL' Or
                      Cbjobname='*';
                   Cbjobname='*ALL';
X03             Else;
B04                If %Subst(Cbjobname:%Checkr(' ':Cbjobname):1) <> '*';
                      Cbjobname=%Trim(Cbjobname)+'*';
E04                Endif;
E03             Endif;
B03             If Cbusername='' Or Cbusername='*ALL' Or
                      Cbusername='*';
                   Cbusername='*ALL';
X03             Else;
B04                If %Subst(Cbusername:%Checkr(' ':Cbusername):1) <> '*';
                      Cbusername=%Trim(Cbusername)+'*';
E04                Endif;
E03             Endif;
B03             If Cbjobnbr ='' Or Cbjobnbr= '*ALL' Or
                      %Len(%Trim(Cbjobnbr)) <> 6 Or
                      Cbjobnbr ='*';
                   Cbjobnbr= '*ALL';
X03             Else;
E03             Endif;
                //?next fields are locally runned as masks, remove * at end
B03             If Cbcuruser = '' Or Cbcuruser = '*' Or Cbcuruser = '*ALL';
                   Cbcuruser = '*ALL';
X03             Else;
B04                If %Subst(Cbcuruser :%Checkr(' ':Cbcuruser ):1) = '*';
                      %Subst(Cbcuruser :%Checkr(' ':Cbcuruser ):1) = ' ';
E04                Endif;
E03             Endif;
B03             If Cbip = '' Or Cbip='*' Or Cbip = '*ALL';
                   Cbip = '*ALL';
X03             Else;
B04                If %Subst(Cbip :%Checkr(' ':Cbip ):1) = '*';
                      %Subst(Cbip :%Checkr(' ':Cbip ):1) = ' ';
E04                Endif;
E03             Endif;
B03             If Cbsbs = '' Or Cbsbs='*' Or Cbsbs = '*ALL';
                   Cbsbs = '*ALL';
X03             Else;
B04                If %Subst(Cbsbs :%Checkr(' ':Cbsbs ):1) = '*';
                      %Subst(Cbsbs :%Checkr(' ':Cbsbs ):1) = ' ';
E04                Endif;
E03             Endif;
B03             If Cbsts = '' Or Cbsts='*' Or Cbsts = '*ALL';
                   Cbsts = '*ALL';
X03             Else;
B04                If %Subst(Cbsts :%Checkr(' ':Cbsts ):1) = '*';
                      %Subst(Cbsts :%Checkr(' ':Cbsts ):1) = ' ';
E04                Endif;
E03             Endif;
B03             If Cbstatus = '' Or Cbstatus='*';   //?protected by a value list
                   Cbstatus = '*ALL';
E03             Endif;
                //?get list of jobs
                qjob.name=Cbjobname;
                qjob.user=Cbusername;
                qjob.nbr =Cbjobnbr ;
                qusljob(Usrspc
                   : 'JOBL0100'
                   : qjob
                   : Cbstatus :errcode );
B03             If (errcode.Available>0);
                   Message(errcode.MSGID:errcode.Msgdta:'':'QCPFMSG');
                   W2flsp = '50';
                   Iter;
E03             Endif;
                //?use LAH as a mask to format & read the user space
                Qusptrus(Usrspc : pLAH);
                //?depassement de capacite de sous-fichier
                Cbcount = LAH.Count;
B03             If Cbcount > 9999;
                   Message('SQL0002');
                   W2flsp = '50';
                   Iter;
E03             Endif;
                //?depassement de capacite utilisateur
B03             If Cbcount > Sqlmax;
                   W0flsp = '0400';
                   Exsr Sp040;
B04                If Fdyes = 'NO';
                      W0flsp = '0240';
                      Iter;
E04                Endif;
E03             Endif;
                //?load in sort space, sort list
                //?cleanup previous usage of sortArray
B03             If pSortArray <> *null;
                   Dealloc pSortArray;
E03             Endif;
                pSortArray=%Alloc(1);
                SortAryLen = 0 ;
                SortAryNbr = 0 ;
B03             For iJob= 0 To LAH.Count - 1;
                   //?filter the jobs
                   //?CBSTATUS done
                   //?CBJOBNAME done
                   //?CBUSERNAME done
                   //?CBJOBNBR done
                   //?get data to load element
                   pJobL0100 = pLAH + LAH.Data_offset + iJob * LAH.Entry_size ;
                   Rtvjoba(Jobi0200
                      :%Size(Jobi0200)
                      :'JOBI0200'
                      :'*INT'
                      :JOBL0100.Internal_ID
                      :errcode);
B04                If (errcode.Available>0);
                      Message(errcode.MSGID:errcode.Msgdta:'':'QCPFMSG');
                      W2flsp = '50';
                      Iter;
E04                Endif;
                   Rtvjoba(Jobi0600
                      :%Size(Jobi0600)
                      :'JOBI0600'
                      :'*INT'
                      :JOBL0100.Internal_ID
                      :errcode);
B04                If (errcode.Available>0);
                      Message(errcode.MSGID:errcode.Msgdta:'':'QCPFMSG');
                      W2flsp = '50';
                      Iter;
E04                Endif;
                   //?continue filter
                   //?CBCURUSER
B04                If Cbcuruser<> '*ALL';
                      sel = %Trim(Cbcuruser);
B05                   If %Subst(Jobi0600.Current_user:1:%Len(sel))<>sel;
                         Iter;
E05                   Endif;
E04                Endif;
                   //?CBIP
B04                If Cbip <> '*ALL';
                      sel = %Trim(Cbip );
B05                   If %Subst(Jobi0600.Client_ip :1:%Len(sel))<>sel;
                         Iter;
E05                   Endif;
E04                Endif;
                   //?CBSBS
B04                If Cbsbs <> '*ALL';
                      sel = %Trim(Cbsbs );
B05                   If %Subst(Jobi0600.Sbs_name :1:%Len(sel))<>sel;
                         Iter;
E05                   Endif;
E04                Endif;
                   //?CBSTS
B04                If Cbsts <> '*ALL';
B05                   If Cbsts = 'W';
B06                      If Jobi0200.Actjob_status = 'MSGW' Or
                               Jobi0200.Actjob_status = 'LCKW' ;
X06                      Else;
                            Iter;
E06                      Endif;
X05                   Else;
                         sel = %Trim(Cbsts );
B06                      If %Subst(Jobi0200.Actjob_status:1:%Len(sel))<>sel;
                            Iter;
E06                      Endif;
E05                   Endif;
E04                Endif;
                   //?add an element to sort array
                   SortAryLen+= SortEltlen;
                   SortAryNbr+=1;
                   pSortArray=%Realloc(pSortArray:SortAryLen);
                   //?prepare last element for update
                   pSortElement = pSortArray + SortAryLen - SortEltlen ;
                   //?update the element
                   SortElement.JOBNAME= Jobi0600.Job_name ;
                   SortElement.USERNAME= Jobi0600.User_name ;
                   SortElement.JOBNBR = Jobi0600.Job_number ;
                   SortElement.CURUSER = Jobi0600.Current_user ;
                   SortElement.IP = Jobi0600.Client_ip ;
                   SortElement.sts = Jobi0200.Actjob_status;
B04                If Jobi0200.Actjob_status='MSGW';
B05                   If Jobi0200.Message_reply='1';
                         SortElement.sts = 'MSGWing';
X05                   Else;
                         SortElement.sts = 'MSGWer';
E05                   Endif;
E04                Endif;
B04                If Jobi0600.Job_status='*ACTIVE';
                      SortElement.SBS = Jobi0600.Sbs_name ;
X04                Else;
                      SortElement.SBS = Jobi0600.Job_status;
E04                Endif;
E03             Endfor;
                //?list is completely readen. Sort it
                //?for iFor = 0 to sortarynbr - 1;
                //?   psortelement = psortarray + (iFor * SortEltLen);
                //?   message ( '':SortElement.sctype + sortelement.scname);
                //?endfor;
                //?message ( '':'---------- Quick Sort -----------'    );
                C_QSort(pSortArray:SortAryNbr:SortEltlen:SortBy);
                //?for iFor = 0 to sortarynbr - 1;
                //?   psortelement = psortarray + (iFor * SortEltLen);
                //?   message ( '':SortElement.sctype + sortelement.scname);
                //?endfor;
                SortAryPos = 1;
                //?save filter
                F5_cbjobname = Cbjobname ;
                F5_cbusername= Cbusername;
                F5_cbjobnbr = Cbjobnbr ;
                F5_cbcuruser = Cbcuruser ;
                F5_cbip = Cbip ;
                F5_cbsbs = Cbsbs ;
                F5_cbsts = Cbsts ;
                F5_cbstatus = Cbstatus ;
                W0flsp = '0220';
                //?set pointer to first job
                iJob=0;
X02          When W2flsp = '20';
                W2flsp = '30';
                //?get one job
B03             If SortAryPos > SortAryNbr;
                   W2flsp = '40';
                   Iter;
E03             Endif;
                //?detection de page pleine
                ranw1b = Ran01b ;
B03             If pag01b <= nbl01b ;
                   dspsfl = *on;
                   sflend = *off;
                   nbl01b = 0;
                   Ran01b = ranp1b;
                   W2flsp = '50';
                   Iter;
E03             Endif;
X02          When W2flsp = '30';
                //?chargement d'une ligne, puis lecture suivante
                W2flsp = '20';
                Ran01b = ranw1b;
                nbl01b = nbl01b + 1;
                //?* charger une ligne
                pSortElement = pSortArray + ( SortAryPos - 1 ) * SortEltlen ;
                Zbsele=0;
                Sbjobname = SortElement.JOBNAME ;
                Sbusername = SortElement.USERNAME ;
                Sbjobnbr = SortElement.JOBNBR ;
                Sbcuruser = SortElement.CURUSER ;
                Sbip = SortElement.IP ;
                Sbsts = SortElement.sts ;
                Sbsbs = SortElement.SBS ;
B03             If Sbsts='MSGWing' Or
                      Sbsts='LCKW';
                   msgwline=*on ;
X03             Else;
                   msgwline=*off;
E03             Endif;

                //?* ecrire une ligne
                SortAryPos+=1;
                Ran01b = Ran01b + 1;
                Write Sflb ;
X02          When W2flsp = '40';
                //?dernière ligne du sous-fichier
                W2flsp = '50';
                //?HERE choose to add one blank line in an empty subfile
                //?    if ran01b < 1 ;
                //?       clear sflb ;
                //?       ran01b = 1 + ran01b ;
                //?       write sflb;
                //?    endif;
                ranw1b = Ran01b ;
B03             If Ran01b >= 1;
                   clrsfl = *off;
                   dspsfl = *on;
                   sflend = *on;
                   Ran01b = ranp1b;
X03             Else;
                   clrsfl = *off;
                   dspsfl = *off;
                   sflend = *off;
                   Message('SEL0002');
E03             Endif;
X02          When W2flsp = '50';
                //?affichage
                W2flsp = '60';
                //?bandeau touches de fonction
                Write Fmtkb ;
X02          When W2flsp = '60';
                //?réaffichage
                W2flsp = '70';
                Write Pmqctl;   //?program message queue
                //?*=----------------------------------------------
                //?* end of page loading
                //?* wait for page return from user
                //?*=----------------------------------------------
                //?write(e) ctlb ;//?write the format
                //?if %error();
                //?message('':'erreur sur write':'*ESCAPE');
                //?endif;
                //?autorefresh=false;
                //?read(e) wrkjobfm;//?read the file : this azctivate the maxdev parameter,
                //?if %error();
                //?if %status() = 01331;
                //?autorefresh=true ;
                //?else;
                //?message('':'erreur sur read ':'*ESCAPE');
                //?endif;
                //?endif;
                Exfmt Ctlb;
                //?              and maxdev(*file) activate the waitrcd(nn) compil option
                Callp Pmqcln() ;   //?nettoyer la pmq
                //?controles
                //?* rollup
                limite = *off;
B03             If rollup = *on ;
B04                If sflend = *off;
                      ranp1b = 1 +ranw1b ;
                      W2flsp = '30';
                      Iter ;
X04                Else;
                      W2flsp = '50';
                      Iter ;
E04                Endif;
E03             Endif;
                //?F3=quitter exit, annulation
B03             If *inkc = *on;
                   W0flsp = *blank;
                   Iter;
E03             Endif;
                //?F12=Abandon
B03             If *inkl = *on;
                   W0flsp = *blank;
                   Iter;
E03             Endif;
                //?F10=call qcmd
B03             If *inkj = *on;
                   QCmd();
                   Iter;
E03             Endif;
                //?F21=call quscmdln
B03             If *inkv = *on;
                   QCmdLn();
                   Iter;
E03             Endif;
                //?F5=rafraichir
B03             If In1F = True Or autorefresh Or
                      *inke = *on ;
                   In1F = False;
                   W2flsp = '00';
                   Iter;
E03             Endif ;
                //?F16=sortby cursor choice
B03             If *inkq= True And Rtncsrfmt='SFLB';
B04                Select;
X04                   When Rtncsrfld='SBJOBNAME ';
                         SortBy =%Paddr(SortByjobname );
                         sortind=*all'0';
                         byjobname =*on;
X04                   When Rtncsrfld='SBUSERNAME';
                         SortBy =%Paddr(SortByusername);
                         sortind=*all'0';
                         byusername=*on;
X04                   When Rtncsrfld='SBJOBNBR  ';
                         SortBy =%Paddr(SortByjobnbr );
                         sortind=*all'0';
                         byjobnbr =*on;
X04                   When Rtncsrfld='SBCURUSER ';
                         SortBy =%Paddr(SortBycuruser );
                         sortind=*all'0';
                         bycuruser =*on;
X04                   When Rtncsrfld='SBIP      ';
                         SortBy =%Paddr(SortByip );
                         sortind=*all'0';
                         byip =*on;
X04                   When Rtncsrfld='SBSBS     ';
                         SortBy =%Paddr(SortBySbs );
                         sortind=*all'0';
                         bysbs =*on;
X04                   When Rtncsrfld='SBSTS     ';
                         SortBy =%Paddr(SortBySts );
                         sortind=*all'0';
                         bysts =*on;
E04                Endsl;
                   W2flsp = '00';
                   Iter;
E03             Endif ;
X02          When W2flsp = '70';
                //?traitement du controleur de sous-fichier
                W2flsp = '80';
                //?traitement du sous-fichier
B03             If ranw1b < 1 ;
                   Message('SEL0002');
                   W2flsp = '80';
                   Iter;
E03             Endif;
                ranw2b = ranw1b;
B03             For Ever;   //?boucle infinie
                   suppression = *off;
                   Readc(E) Sflb;
B04                If %Eof;
                      Leave;
E04                Endif;
                   //?quelque chose a faire ?
B04                If Zbsele <> *zero ;
                      //?traiter
                      cmde='Wrkjob ' + Sbjobnbr + '/'
                         + %Trim(Sbusername) + '/' + Sbjobname
                         + ' OPTION(';
B05                   Select;
X05                      When Zbsele = 1;
                            cmde+='*STSA)';
X05                      When Zbsele = 2;
                            cmde+='*DFNA)';
X05                      When Zbsele = 3;
                            cmde+='*RUNA)';
X05                      When Zbsele = 4;
                            cmde+='*SPLA)';
X05                      When Zbsele = 5;
                            cmde+='*SELECT)';
X05                      When Zbsele = 7;
                            cmde='wrkactjob job('+Sbjobname+')';
X05                      When Zbsele =10;
                            cmde+='*JOBLOG)';
X05                      When Zbsele =11;
                            cmde+='*PGMSTK)';
X05                      When Zbsele =12;
                            cmde+='*JOBLCK)';
X05                      When Zbsele =13;
                            cmde+='*LIBL)';
X05                      When Zbsele =14;
                            cmde+='*OPNF)';
X05                      When Zbsele =15;
                            cmde+='*FILOVR)';
X05                      When Zbsele =16;
                            cmde+='*CMTCTL)';
X05                      When Zbsele =17;
                            cmde+='*CMNSTS)';
X05                      When Zbsele =18;
                            cmde+='*ACTGRP)';
X05                      When Zbsele =19;
                            cmde+='*MUTEX)';
X05                      When Zbsele =20;
                            cmde+='*THREAD)';
X05                      When Zbsele =21;
                            cmde+='*MLBA)';
X05                      When Zbsele =50;
                            cmde='slppgm ' + Sbjobnbr + '/'
                               + %Trim(Sbusername) + '/' + Sbjobname
                               ;
X05                      When Zbsele =51;
                            cmde='strsrvjob ' + Sbjobnbr + '/'
                               + %Trim(Sbusername) + '/' + Sbjobname
                               ;
                            Message('':cmde);
                            rc = c_system(cmde );
B06                         If rc <> 0;
                               Message (MSGID:'':'':'QCPFMSG');
                               W2flsp = '60';
                               Iter;
E06                         Endif;
                            cmde='? strdbg UPDPROD(*YES) ';
                            Message('':cmde);
                            rc = c_system(cmde );
                            //?if rc <> 0;
                            //?   message (msgid:'':'':'QCPFMSG');
                            //?   w2flsp = '60';
                            //?   iter;
                            //?endif;
B06                         For Ever ;
                               cmde='Wrkjob ' + Sbjobnbr + '/'
                                  + %Trim(Sbusername) + '/' + Sbjobname
                                  + ' OPTION('
                                  +'*SELECT)';
                               rc = c_system(cmde );
B07                            If rc <> 0;
                                  Message (MSGID:'':'':'QCPFMSG');
                                  W2flsp = '60';
                                  Iter;
E07                            Endif;
                               // confirm exit
                               Exsr Sp050;
B07                            If Feyes = 'NO';
                                  Iter;
X07                            Else;
                                  Leave;
E07                            Endif;
E06                         Endfor;
                            cmde='enddbg';
                            rc = c_system(cmde );
B06                         If rc <> 0;
                               Message (MSGID:'':'':'QCPFMSG');
                               //?w2flsp = '60';
                               //?iter;
E06                         Endif;
                            cmde='endsrvjob ';
X05                      When Zbsele =52;
                            cmde='endsrvjob ';
X05                      Other;
                            cmde+='*SELECT)';
E05                   Endsl;
                      Message('':cmde);
                      rc = c_system(cmde );
B05                   If rc <> 0;
                         Message (MSGID:'':'':'QCPFMSG');
                         W2flsp = '60';
                         Iter;
E05                   Endif;
                      Zbsele = 0 ;
                      //?autres champs : par sp030
                      Update Sflb ;
E04                Endif ;
E03             Endfor ;
X02          When W2flsp = '80';
                //?HERE change the field list from CTLB
                //?refresh requested ? (ctlb changed)
                //?f5_          <>            or
B03             If F5_cbjobname <> Cbjobname Or
                      F5_cbusername<> Cbusername Or
                      F5_cbjobnbr <> Cbjobnbr Or
                      F5_cbcuruser <> Cbcuruser Or
                      F5_cbip <> Cbip Or
                      F5_cbsbs <> Cbsbs Or
                      F5_cbsts <> Cbsts Or
                      F5_cbstatus <> Cbstatus
                      ;
                   W2flsp='00';
                   Iter;
E03             Endif;
                //?validation   ICI choisir la sortie
                //? w0flsp = *blank ;
                W2flsp = '50';
                Iter;
                //?abandon
X02          Other ;
                //?paok   = *off   ;
                W0flsp = *blank ;
E02       Endsl ;
E01    Enddo ;
E00    Endsr;
       //?---------------------------------------------------------------
       //?traitement de la page de dépassement de capacité
       //?---------------------------------------------------------------
B00    Begsr Sp040 ;
B01    Dow W1flsp = '04' ;   //?boucle centrale
B02       Select;
X02          When W2flsp = '00';
                //?initialisation
                Fmtdx = 10;
                Fmtdy = 7;
                W2flsp = '50';
                errind = *all'0' ;
                Callp Pmqcln();
                Fdselect = Cbjobname;
                Fdfrom = '' ;
                Fdwhere = '' ;
                Fdcount = LAH.Count;
                Fdyes = 'YES';
X02          When W2flsp = '50';
                //?affichage
                W2flsp = '60';
X02          When W2flsp = '60';
                //?réaffichage
                W2flsp = '70';
                Write Pmqctl;   //?program message queue
                Exfmt Fmtd;
                Callp Pmqcln() ;   //?nettoyer la pmq
X02          When W2flsp = '70';
                //?controles
                //?exit, annulation
B03             If *inkc = *on;
                   W0flsp = *blank;
                   Iter;
E03             Endif;
B03             If *inkl = *on;
                   W0flsp = *blank;
                   Iter;
E03             Endif;
                //?raffraichir
B03             If *inke = *on ;
                   W2flsp = '00';
                   Iter;
E03             Endif ;
                //?traitement
                W2flsp = '80';
                //?* mise a jour
                //?controles
                //?validation
X02          When W2flsp = '80';
                W0flsp = '    ';
                Leave;
                //?abandon
X02          Other ;
                //?paok   = *off   ;
                W0flsp = *blank ;
                Leave;
E02       Endsl ;
E01    Enddo ;
E00    Endsr;
       //?---------------------------------------------------------------
       //?confirmation de sortie
       //?---------------------------------------------------------------
B00    Begsr Sp050 ;
       //?initialisation
       Fmtex = 10;
       Fmtey = 7;
       Feyes = 'YES';
       Write Pmqctl;   //?program message queue
       Exfmt Fmte;
       //?controles
       //?exit, annulation
B01    If *inkc = *on
X01    Or *inkl = *on;
          Feyes='NO' ;
E01    Endif;
E00    Endsr;
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
BPR ?P SortBySbsJob    b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?level 1 sort : by sbs
X01       When Element1.SBS > Element2.SBS ;
             Return High;
X01       When Element1.SBS < Element2.SBS ;
             Return Low ;
             //?next level : by name
X01       When Element1.JOBNAME> Element2.JOBNAME;
             Return High;
X01       When Element1.JOBNAME< Element2.JOBNAME;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortByjobname   b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?by name
X01       When Element1.JOBNAME> Element2.JOBNAME;
             Return High;
X01       When Element1.JOBNAME< Element2.JOBNAME;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortByusername  b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?sort by username
X01       When Element1.USERNAME> Element2.USERNAME;
             Return High;
X01       When Element1.USERNAME< Element2.USERNAME;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortByjobnbr    b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?        sort : by jobnbr
X01       When Element1.JOBNBR > Element2.JOBNBR;
             Return High;
X01       When Element1.JOBNBR < Element2.JOBNBR;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortByCurUser   b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?        sort : by CurUser
X01       When Element1.CURUSER> Element2.CURUSER;
             Return High;
X01       When Element1.CURUSER< Element2.CURUSER;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortByIP        b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?        sort : by IP
X01       When Element1.IP > Element2.IP ;
             Return High;
X01       When Element1.IP < Element2.IP ;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortBySbs       b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?        sort : by sbs
X01       When Element1.SBS > Element2.SBS ;
             Return High;
X01       When Element1.SBS < Element2.SBS ;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
BPR ?P SortBySts       b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?        sort : by sts
X01       When Element1.sts > Element2.sts ;
             Return High;
X01       When Element1.sts < Element2.sts ;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B00    Begsr *pssr ;
       Dump ;
E00    Endsr ;
      /end-free
EPR  P                 e
