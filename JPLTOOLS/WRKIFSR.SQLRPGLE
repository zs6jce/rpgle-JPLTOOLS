      /define INFDS
    ? /define IFS
      /define LOWERCASE
      /define wrkusrinfo
      /define sql



     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


    ? *================================================================
    ? * sample of program
    ? *================================================================


     fwrkifsp   if   e           k disk    infsr(*pssr)
     f                                     prefix(cmd_)
     f                                     rename(wrkifsp:fmaj    )








    ? *HERE replace DSPF dspifs with target dspf
     fwrkifsfm  cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)                   HERE with sfl ?
     f                                     sfile(sflc:ran01c)                   HERE with sfl ?
     f                                     indds(indara)



     d               e ds                  extname(wrkifsfm:ctlb:*input)
     d                                     prefix(f5_)
     d               e ds                  extname(wrkifsfm:ctlc:*input)
     d                                     prefix(f5_)

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
     d  f1                             n   overlay(indara:01)
     d  f2                             n   overlay(indara:02)
     d  f3                             n   overlay(indara:03)
     d  f4                             n   overlay(indara:04)
     d  f5                             n   overlay(indara:05)
     d  f6                             n   overlay(indara:06)
     d  f7                             n   overlay(indara:07)
     d  f8                             n   overlay(indara:08)
     d  f9                             n   overlay(indara:09)
     d  f10                            n   overlay(indara:10)
     d  f11                            n   overlay(indara:11)
     d  f12                            n   overlay(indara:12)
     d  f13                            n   overlay(indara:13)
     d  f14                            n   overlay(indara:14)
     d  f15                            n   overlay(indara:15)
     d  f16                            n   overlay(indara:16)
     d  f17                            n   overlay(indara:17)
     d  f18                            n   overlay(indara:18)
     d  f19                            n   overlay(indara:19)
     d  f20                            n   overlay(indara:20)
     d  f21                            n   overlay(indara:21)
     d  f22                            n   overlay(indara:22)
     d  f23                            n   overlay(indara:23)
     d  f24                            n   overlay(indara:24)
     d  rollup                         n   overlay(indara:25)
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
     D QCmd            PR                  EXTPGM('QCMD')

     D QCmdExc         PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                         5000A   const
     D cmdlen                        15P 5 CONST
     D cmd             S           5000A   varying
     D outcmd          S           5000A
     D Pos             S              5  0
    ? * string scanner
     d s               ds             2    based(pS)
     d  s1                     1      1
     d  s2                     1      2
     d p1              s              5i00
     d p2              s              5i00
     d p3              s              5i00
    ? * substitution values
       //?&L = the IFS link
       //?&D = the file's directory
       //?&N = the file's name (without extention)
       //?&E = the file's extention
     d substvals       ds
     d lpos                           5i00
     d llen                           5i00
     d dpos                           5i00
     d dlen                           5i00
     d n0pos                          5i00
     d n0len                          5i00
     d n1pos                          5i00
     d n1len                          5i00
     d n2pos                          5i00
     d n2len                          5i00
     d n3pos                          5i00
     d n3len                          5i00
     d epos                           5i00
     d elen                           5i00








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

    ?d*false           c                   '0'
    ?d*true            c                   '1'

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

    ?d*Process Commands (QCAPCMD) API
    ?D*http://publib.boulder.ibm.com/iseries/v5r1/ic2924/index.htm?info/apis/qcapcmd.htm
    ?d*
    ?d*  Source command string  Input  Char(*)
    ?d*  Length of source command string  Input  Binary(4)
    ?d*  Options control block  Input  Char(*)
    ?d*  Options control block length  Input  Binary(4)
    ?d*  Options control block format  Input  Char(8)
    ?d*  Changed command string  Output  Char(*)
    ?d*  Length available for changed command string  Input  Binary(4)
    ?d*  Length of changed command string available to return  Output  Binary(4)
    ?d*  Error Code  I/O  Char(*)
     D QCaPcmd         PR                  EXTPGM('QCAPCMD')
     d   Cmd                       5000    const
     d   CmdLen                      10i 0 const
     d   Options                     20    const
     d   OptionsLen                  10i 0 const
     d   OptionsFmt                   8    const
     d   OutCmd                    5000
     d   OutCmdAvail                 10i 0 const
     d   OutCmdLen                   10i 0
     d   ErrorCode                  255

     d wrkifsopt       pr                  extpgm('WRKIFSOPTR')

     d CPOP0100        ds            20    qualified
     d   Processing                  10i 0
     d   DBCS                         1
     d   Prompter                     1
     d   Syntax                       1
     d   MessageKey                   4
     d   Reserved                     9

     d   OutCmdLen     s             10i 0

     DPareil           PR             1N
     D  Filtre                       50    Const varying
     D  Data                        500    Const varying
     d  p_wildcard                    2    const options(*nopass)

     d ech             ds                  likeds(errorcodehandler) inz(*likeds)

     d wildcard        ds
     d  onechar                       1
     d  anychar                       1




    ? * HERE program name & parameters
     d main            pr                  extpgm('MAIN')
    ?d* paok                          1
     d main            pi
    ?d* paok                          1

      /free
       //?* programme principal
       //?* initialisation générale
       W0flsp = '0000' ;   //?initialisation generale
B01    Dow W0flsp <> *blanks ;   //?boucle centrale
B02       Select ;
X02          When W1flsp = '00';
                Exsr Sp000 ;   //?initialisation
X02          When W1flsp = '01';
                Exsr Sp010 ;   //?selection
X02          When W1flsp = '02';
                Exsr Sp020 ;   //?detail par sous-fichier
X02          When W1flsp = '03';
                Exsr Sp030 ;   //?mise à jour
X02          Other;
                Spmsda = 'routine cible (w0flsp) inconnue';
                Exsr *pssr ;   //?erreur dans wwflag
E02       Endsl;
E01    Enddo;
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?initialisation generale
       //?---------------------------------------------------------------
B01    Begsr Sp000 ;
          //?HERE choose initial screen
          //?if paok = '1';
          W0flsp= '0100' ;   //?selection
          //?else;
          //?   w0flsp= '0200' ;// sub-file
          //?endif;
          //?paok = *off ;
          Pmqcln() ;
          Faifs = *blank ;
          Message('AAA0001');
E01    Endsr ;
       //?---------------------------------------------------------------
       //?initial ifs folder to work with
       //?---------------------------------------------------------------
B01    Begsr Sp010 ;
B02       Dow W1flsp = '01';   //?main loop
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   W2flsp = '50';
                   indara = *all'0';
                   Faifs=Getusrinfo('IFS');
                   Ccwild=Getusrinfo('WILDCARD');
B04                If Ccwild = '';
                      Ccwild = '.*';
E04                Endif;
                   Ccname=Getusrinfo('IFSNAME');
                   Cctype=Getusrinfo('IFSTYPE');
                   //?HERE load the page
                   //?fa        = bcl.             ;

X03             When W2flsp = '50';
                   //?show
                   W2flsp = '60';
                   //?Fkey toolbar
                   Write Fmtka ;
X03             When W2flsp = '60';
                   //?show again
                   W2flsp = '70';
                   Write Pmqctl;   //?program message queue
                   Exfmt Fmta ;   //?active screen
                   Callp Pmqcln() ;   //?cleanup the program message queue
X03             When W2flsp = '70';
                   //?controles





                   //?F3=quit,   exit, annulation
B04                If f3 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=F3
B04                If f12 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F5=refresh
B04                If f5 ;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
                   //?at work
                   W2flsp = '80';
                   //?check           ?
                   rc = Access(%Trim(Faifs ): F_ok);
B04                If (rc <> 0);
                      cpenum=Errno ;
                      Message(errcpe:'':'':'QCPFMSG');
                      W2flsp = '60';

E04                Endif;
                   Setusrinfo('IFS':Faifs);
X03             When W2flsp = '80';
                   //?validation
                   W0flsp = '0300' ;
                   Cbfrom = 0;
                   //? paok = *on ;
                   Iter;
X03             Other ;
                   //?quit
                   //?paok = *off ;
                   W0flsp = *blank ;
E03          Endsl ;
E02       Enddo ;
E01    Endsr;
       //?---------------------------------------------------------------
       //?task : subfile ascii dump of ifs file
       //?---------------------------------------------------------------
B01    Begsr Sp020 ;
          FileHandleE= Open( %Trim(Faifs)
             : O_textdata + O_rdonly ) ;
B02       If FileHandleE= -1;
             cpenum= Errno();
             Message(errcpe:'':'':'QCPFMSG');
E02       Endif;
          rc = Stat (%Trim(Faifs)+X'00': myStat );
          Cbsize = myStat.St_size;
          FileHandleA= Open( %Trim(Faifs)
             : O_rdonly ) ;
B02       If FileHandleA= -1;
             cpenum= Errno();
             Message(errcpe:'':'':'QCPFMSG');
E02       Endif;
          Cbifs = Faifs;
B02       Dow W1flsp = '02';   //?main loop
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   W2flsp = '10';
                   indara = *all'0';
                   ranp1b = 1;
                   pag01b = 15;
                   nbl01b = 0;
                   Callp Pmqcln() ;
                   //?initialisation    subfile
                   Ran01b = 0;
                   clrsfl = *on;
                   dspsfl = *off;
                   sflend = *off;
                   Write Ctlb;
                   clrsfl = *off;
X03             When W2flsp = '10';
                   //?read file & load subfile
                   W2flsp = '20';
                   //?HERE key list to read target file & remember last call to refresh
                   BytesIn = Cbfrom;
                   curPos = Cbfrom;
                   F5_cbfrom= Cbfrom ;
                   AtEof = False;

X03             When W2flsp = '20';
B04                If AtEof;
                      W2flsp = '40';
                      Iter;
E04                Endif;
                   W2flsp = '30';
                   iConvData = *allx'00';
                   ASCIIData = *allx'00';
                   BytesIn =Pread (FileHandleE: %Addr(iConvData) : 20 :curPos) ;
                   BytesIn =Pread (FileHandleA: %Addr(ASCIIData) : 20 :curPos) ;

B04                If BytesIn < 20;
                      AtEof = True;
E04                Endif;
                   //?detection    page is full
                   ranw1b = Ran01b ;
B04                If pag01b <= nbl01b ;
                      dspsfl = *on;
                      sflend = *off;
                      nbl01b = 0;
                      Ran01b = ranp1b;
                      W2flsp = '50';
                      Iter;
E04                Endif;
X03             When W2flsp = '30';
                   //?load one line, read next
                   W2flsp = '20';
                   Ran01b = ranw1b;
                   nbl01b = nbl01b + 1;
                   //?* load one line
                   //?  zbsele = ' ';
                   //?HERE load one line in the subfile
                   //?sb        = bcl.             ;

                   Hexa_Data = hexa(ASCIIData);
B04                For Ifor = 1 To 20;
B05                   If iData(Ifor) < X'40';
                         iData(Ifor) = '.';
E05                   Endif;
E04                Endfor;
B04                If BytesIn < 0;   //?y a des cas à -1
                      BytesIn = 0;
E04                Endif;
B04                If BytesIn < 20;
                      %Subst(Hexa_Data : BytesIn * 2 +1) = *all'_';
                      %Subst(iConvData : BytesIn +1) = *blank ;
E04                Endif;
                   Sbebcd = iConvData;
                   Sbofst = curPos;
                   curPos +=BytesIn;
                   //?* write one line
                   Ran01b = Ran01b + 1;
                   Write Sflb ;
X03             When W2flsp = '40';
                   //?last line for subfile
                   W2flsp = '50';
                   //?HERE choose to add one blank line in an empty subfile
B04                If Ran01b < 1 ;
                      Clear Sflb ;
                      Ran01b = 1 + Ran01b ;
                      Write Sflb;
E04                Endif;
                   ranw1b = Ran01b ;
B04                If Ran01b >= 1;
                      clrsfl = *off;
                      dspsfl = *on;
                      sflend = *on;
                      Ran01b = ranp1b;
X04                Else;
                      clrsfl = *off;
                      dspsfl = *off;
                      sflend = *off;
                      Message ('SEL0002') ;
E04                Endif;
X03             When W2flsp = '50';
                   //?show
                   W2flsp = '60';
                   //?Fkey tool bar
                   Write Fmtkb ;
X03             When W2flsp = '60';
                   //?show again
                   W2flsp = '70';
                   Write Pmqctl;   //?program message queue
                   Exfmt Ctlb ;   //?
                   Callp Pmqcln() ;   //?
                   //?controles
                   //?* rollup
                   limite = *off;
B04                If rollup = *on ;
B05                   If sflend = *off;
                         ranp1b = 1 +ranw1b ;
                         W2flsp = '30';
                         Iter ;
X05                   Else;
                         W2flsp = '50';
                         Iter ;
E05                   Endif;
E04                Endif;
                   //?F3=quit, exit, annulation
B04                If f3 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=F3
B04                If f12 ;
                      Leavesr;
E04                Endif;
                   //?F5=refresh
B04                If f5 ;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
X03             When W2flsp = '70';
                   //?work the subfile controler
                   W2flsp = '80';
B04                If ranw1b < 1 ;
                      Message ('SEL0002');
                      W2flsp = '80';
                      Iter;
E04                Endif;
                   ranw2b = ranw1b;
B04                Dow 1=1;   //?for ever loop
                      suppression = *off;
                      Readc(E) Sflb;
B05                   If %Eof;
                         Leave;
E05                   Endif;
                      //?something to do ?
E04                Enddo ;
X03             When W2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)
B04                If F5_cbfrom <> Cbfrom;

                      W2flsp='00';
                      Iter;
E04                Endif;

                   //?validation  HERE choose the exit
                   //?     w0flsp = *blank ;// exit program
                   W2flsp = '50';   //?show again
                   Iter;
X03             Other ;
                   //?exit
                   //?paok   = *off   ;
                   W0flsp = *blank ;
E03          Endsl ;
E02       Enddo ;
          rc = Close(FileHandleE) ;
          rc = Close(FileHandleA) ;
E01    Endsr;
       //?---------------------------------------------------------------
       //?task : subfile list of the directory
       //?---------------------------------------------------------------
B01    Begsr Sp030 ;
B02       Dow W1flsp = '03';   //?main loop
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   W2flsp = '10';
                   indara = *all'0';
                   ranp1c = 1;
                   pag01c = 16;
                   nbl01c = 0;
                   Callp Pmqcln() ;
                   //?initialisation    subfile
                   Ran01c = 0;
                   clrsfl = *on;
                   dspsfl = *off;
                   sflend = *off;
                   Write Ctlc;
                   clrsfl = *off;
B04                If Faifs = *blank;
                      Faifs='/';
E04                Endif;
                   pathdir = %Trim(Faifs);
B04                If %Len(pathdir)>1;
B05                   If %Subst(pathdir:%Len(pathdir):1)='/';
                         %Len(pathdir)=%Len(pathdir)-1;
E05                   Endif;
E04                Endif;
                   Ccifs = pathdir ;
                   rc = %Len(pathdir)+1;
                   %Str(%Addr(pathdirs):rc)=pathdir;
                   rc = Access(pathdirs : F_ok);
B04                If (rc <> 0);
                      Message(Errnomsg(Errno):'':'':'QCPFMSG');
                      W0flsp='0100';
E04                Endif;
                   F5_ccwild = Ccwild;
                   F5_ccname = Ccname;
                   F5_cctype = Cctype;
X03             When W2flsp = '10';
                   //?read file & load subfile
                   W2flsp = '20';
                   //?HERE key list to read target file & remember last call to refresh

                   rc = Stat (pathdirs: myStat );
                   rc = Stat64 (pathdirs: myStat64 );
                   rc = Statvfs(pathdirs: myStatVFS );

                   diropnp = Opendir(pathdirs );
                   //?cleanup previous usage of sortArray
B04                If pSortArray <> *null;
                      Dealloc pSortArray;
E04                Endif;
                   pSortArray=%Alloc(1);
                   SortAryLen = 0 ;
                   SortAryNbr = 0 ;

B04                For Ever;
                      //?read each dir entry
                      entryp= Readdir(diropnp) ;
B05                   If entryp = *null ;
                         Leave;
E05                   Endif ;
                      //?prepare data to update element
                      name=%Subst(namedir:1:namelen);
                      //?* on traite le . et le ..
B05                   If (%Subst(namedir:1:2) = '..');
                         rc = %Len(pathdir);
B06                      For Ifor = rc Downto 1 By 1;
B07                         If %Subst(pathdir:Ifor:1) = '/';
                               pathfile= %Subst(pathdir:1:Ifor - 1);
                               Leave;
E07                         Endif;
E06                      Endfor;
B06                      If pathfile='';
                            pathfile = '/';
E06                      Endif;
                         attr.St_objtype = '*dir' ;
X05                   Elseif (%Subst(namedir:1:1) = '.');
                         pathfile = pathdir;
                         attr.St_objtype = '*dir' ;
X05                   Else;
B06                      If pathdir='/';
                            pathfile= pathdir + name ;
X06                      Else;
                            pathfile= pathdir +'/'+ name ;
E06                      Endif;
                         rc=%Len(pathfile)+1;
                         %Str(%Addr(pathfiles):rc) = pathfile;
                         //?* appel de l'API stat pour recuperation du type : *stmf ou directory
                         rc = Stat(pathfiles: attr ) ;
B06                      If rc = -1 ;
                            Message(Errnomsg(Errno):'':'':'QCPFMSG');
E06                      Endif;
E05                   Endif;
                      //?aply filters
                      wildcard = Ccwild;
B05                   If onechar = ' ' Or anychar = ' ';
                         Ccwild = '.*';
                         wildcard = Ccwild;
E05                   Endif;
                      Setusrinfo('WILDCARD':Ccwild);
                      Setusrinfo('IFSNAME':Ccname);
                      Setusrinfo('IFSTYPE':Cctype);
B05                   If Ccname <> '';
B06                      If Not Pareil(anychar+%Trim(Lcase(Ccname))+anychar
                               :%Trim(Lcase(name)):wildcard);
                            Iter;
E06                      Endif;
E05                   Endif;
B05                   If Cctype <> '';
B06                      If Not Pareil(anychar+%Trim(Lcase(Cctype))+anychar
                               :%Trim(Lcase(attr.St_objtype)):wildcard);
                            Iter;
E06                      Endif;
E05                   Endif;

                      //? add   element to sort array
                      SortAryLen+= SortEltlen;
                      SortAryNbr+=1;
                      pSortArray=%Realloc(pSortArray:SortAryLen);
                      //?prepare last element for update
                      pSortElement = pSortArray + SortAryLen - SortEltlen ;
                      //?update the element
                      SortElement.d_name = name ;
                      SortElement.s_name = Lcase(name) ;
                      SortElement.d_ifs = pathfile;
                      SortElement.d_type = attr.St_objtype ;
                      SortElement.s_type = Lcase(attr.St_objtype) ;
B05                   If SortElement.s_type = '*ddir' Or
                            SortElement.s_type = '*lib' Or
                            SortElement.s_type = '*flr';
                         SortElement.s_type = '*dir' ;
E05                   Endif;
E04                Endfor;
                   //?directory is completely readen. Sort it
                   //?for iFor = 0 to sortarynbr - 1;
                   //?   psortelement = psortarray + (iFor * SortEltLen);
                   //?   message ( '':SortElement.sctype + sortelement.scname);
                   //?endfor;
                   //?message ( '':'---------- Quick Sort -----------'    );
                   C_QSort(pSortArray:SortAryNbr:SortEltlen:%Paddr(DirByName));
                   //?for iFor = 0 to sortarynbr - 1;
                   //?   psortelement = psortarray + (iFor * SortEltLen);
                   //?   message ( '':SortElement.sctype + sortelement.scname);
                   //?endfor;
                   SortAryPos = 1;
                   W2flsp = '20';
X03             When W2flsp = '20';
B04                If SortAryPos > SortAryNbr;
                      W2flsp = '40';
                      Iter;
E04                Endif;
                   W2flsp = '30';
                   //?detection    page is full
                   ranw1c = Ran01c ;
B04                If pag01c <= nbl01c ;
                      dspsfl = *on;
                      sflend = *off;
                      nbl01c = 0;
                      Ran01c = ranp1c;
                      W2flsp = '50';
                      Iter;
E04                Endif;
X03             When W2flsp = '30';
                   //?load one line, read next
                   W2flsp = '20';
                   Ran01c = ranw1c;
                   nbl01c = nbl01c + 1;
                   //?* load one line
                   //?  zbsele = ' ';
                   //?HERE load one line in the subfile
                   //?sb        = bcl.             ;
                   pSortElement = pSortArray + ( SortAryPos - 1 ) * SortEltlen ;
                   Scname = SortElement.d_name;
                   Scifs = SortElement.d_ifs;
                   Sctype = SortElement.d_type;
                   Scsele='';
                   SortAryPos+=1;
                   //?* write one line
                   Ran01c = Ran01c + 1;
                   Write Sflc ;
X03             When W2flsp = '40';
                   //?last line for subfile
                   W2flsp = '50';
                   //?HERE choose to add one blank line in an empty subfile
B04                If Ran01c < 1 ;
                      Clear Sflc ;
                      name = '..';
                      pathfile = '';
                      rc = %Len(pathdir);
B05                   For Ifor = rc Downto 1 By 1;
B06                      If %Subst(pathdir:Ifor:1) = '/';
                            pathfile= %Subst(pathdir:1:Ifor - 1);
                            Leave;
E06                      Endif;
E05                   Endfor;
B05                   If pathfile='';
                         pathfile = '/';
E05                   Endif;
                      attr.St_objtype = '*dir' ;
                      Scname = name ;
                      Scifs = pathfile;
                      Sctype = attr.St_objtype ;
                      Scsele='';
                      Ran01c = 1 + Ran01c ;
                      Write Sflc;
E04                Endif;
                   ranw1c = Ran01c ;
B04                If Ran01c >= 1;
                      clrsfl = *off;
                      dspsfl = *on;
                      sflend = *on;
                      Ran01c = ranp1c;
X04                Else;
                      clrsfl = *off;
                      dspsfl = *off;
                      sflend = *off;
                      Message ('SEL0002') ;
E04                Endif;
X03             When W2flsp = '50';
                   //?show
                   W2flsp = '60';
                   //?Fkey tool bar
                   Write Fmtkc ;
X03             When W2flsp = '60';
                   //?show again
                   W2flsp = '70';
                   Write Pmqctl;   //?program message queue
                   Exfmt Ctlc ;   //?
                   // read plante si page suivante
                // read  Fmtkc ;
                   Callp Pmqcln() ;   //?
                   //?controles
                   //?* rollup
                   limite = *off;
B04                If rollup = *on ;
B05                   If sflend = *off;
                         ranp1c = 1 +ranw1c ;
                         W2flsp = '30';
                         Iter ;
X05                   Else;
                         W2flsp = '50';
                         Iter ;
E05                   Endif;
E04                Endif;
                   //?F3=quit, exit, annulation
B04                If f3 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=F3
B04                If f12 ;
                      W0flsp = '0100';
                      Iter;
E04                Endif;
                   //?F16=options et commandes
B04                If f16 ;
                      wrkifsopt();
                      Iter;
E04                Endif;
                   //?F5=refresh
B04                If f5 ;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
                   //?F10=joblog
B04                If f10;
                      qcmd();
                      W2flsp = '60';
                      Iter;
E04                Endif ;
X03             When W2flsp = '70';
                   //?work the subfile controler
                   W2flsp = '80';
B04                If ranw1c < 1 ;
                      Message ('SEL0002');
                      W2flsp = '80';
                      Iter;
E04                Endif;
                   ranw2c = ranw1c;
B04                Dow 1=1;   //?for ever loop
                      suppression = *off;
                      Readc(E) Sflc;
B05                   If %Eof;
                         Leave;
E05                   Endif;
B05                   Dou 1 = 1 ;   //?one shot








                         //?something to do ?
                         Scsele = %Trim(Scsele);
B06                      If Scsele='5';
B07                         If Sctype = '*STMF';
                               Faifs = Scifs;
                               W0flsp = '0200';
                               Exsr Sp020;
                               W0flsp = '0350';
                               Scsele='';

                               Iter;
X07                         Else;
                               //?TODO find full list of IFS types
                               //?display sub-dir
                               Faifs = Scifs;
                               Setusrinfo('IFS':Faifs);
                               W2flsp = '00';
                               Iter;
E07                         Endif;
E06                      Endif;
                         Chain (Scsele) Wrkifsp ;
B06                      If Not %Found();
                            ersele=True;
                            Message ('':'unknown option');
                            Leave;
E06                      Endif;
                         //?analyser le full file name
                         cmd = %Trim(Scifs );
                         //?replace parameters withcurrent value
                         //?&L = the IFS link
                         //?&D = the file's directory
                         //?&N = the file's name (without extention)
                         //?&N1= the last directory of the path
                         //?&E = the file's extention
                         pS = %Addr(cmd)+2+%Len(cmd)-1;
                         Clear substvals;
                         //?search back cmd for first not-space : end of &L
                         p1 = %Len(cmd) ;
B06                      For p1 Downto 1;
B07                         If s1 <> ' ';
                               Leave;
E07                         Endif;
                            pS -=1 ;
E06                      Endfor;
                         lpos = 1;
                         llen = p1;
                         p2 = p1;
                         p3 = p1;   //?end of &N if no extention
                         //?search back for . or /. If ., there is an extention
B06                      For p2 Downto 1;
B07                         If s1 = '.';
                               epos = p2+1;
                               elen = p1-p2;
                               p3 = p2 - 1;
                               p1 = p3 ;
                               pS -=1;
                               Leave;
E07                         Endif;
B07                         If s1 = '/';
                               epos = 0;
                               elen = 0;
                               Leave;
E07                         Endif;
                            pS -=1;
E06                      Endfor;

                         //?search back for      /.
                         pS = %Addr(cmd)+2 + p3 - 1;
B06                      For p3 Downto 1;
B07                         If s1 = '/';
                               n0pos = p3+1;
                               n0len = p1-p3;
                               pS -=1;
                               Leave;
E07                         Endif;
                            pS -=1;
E06                      Endfor;
                         dpos = 1;
                         dlen = p3 - 1;

                         //?search back again for /: locate &N1=the name just before &N.
                         p3-=1;
                         p1= p3;
B06                      For p3 Downto 1;
B07                         If s1 = '/';
                               n1pos = p3+1;
                               n1len = p1-p3;
                               pS -=1;
                               Leave;
E07                         Endif;
                            pS -=1;
E06                      Endfor;
                         p3-=1;
                         p1= p3;
B06                      For p3 Downto 1;
B07                         If s1 = '/';
                               n2pos = p3+1;
                               n2len = p1-p3;
                               pS -=1;
                               Leave;
E07                         Endif;
                            pS -=1;
E06                      Endfor;
                         p3-=1;
                         p1= p3;
B06                      For p3 Downto 1;
B07                         If s1 = '/';
                               n3pos = p3+1;
                               n3len = p1-p3;
                               pS -=1;
                               Leave;
E07                         Endif;
                            pS -=1;
E06                      Endfor;


                         //?replace parms
                         cmd = Cmd_cmd;
B06                      If llen> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&L':cmd:p1);
B08                            If p1 > 0;
                               cmd = %Replace(%Subst(Scifs:lpos:llen):cmd:p1:2);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If dlen> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&D':cmd:p1);
B08                            If p1 > 0;
                               cmd = %Replace(%Subst(Scifs:dpos:dlen):cmd:p1:2);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If n3len> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&N3':cmd:p1);
B08                            If p1 > 0;
                             cmd = %Replace(%Subst(Scifs:n3pos:n3len):cmd:p1:3);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If n2len> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&N2':cmd:p1);
B08                            If p1 > 0;
                             cmd = %Replace(%Subst(Scifs:n2pos:n2len):cmd:p1:3);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If n1len> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&N1':cmd:p1);
B08                            If p1 > 0;
                             cmd = %Replace(%Subst(Scifs:n1pos:n1len):cmd:p1:3);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If n0len> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&N':cmd:p1);
B08                            If p1 > 0;
                             cmd = %Replace(%Subst(Scifs:n0pos:n0len):cmd:p1:2);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If elen> 0;
                            p1 = 1;
B07                         For Ever;
                               p1 = %Scan('&E':cmd:p1);
B08                            If p1 > 0;
                               cmd = %Replace(%Subst(Scifs:epos:elen):cmd:p1:2);
                                  p1+=1;   //?anti-looping
X08                            Else;
                                  Leave;
E08                            Endif;
E07                         Endfor;
E06                      Endif;
B06                      If f4 And %Subst(cmd:1:1)<>'?';
                            cmd = '?'+cmd;
E06                      Endif;
                         //?use systematically qcapcmd to get the cmd and log it before running it
                         //?help for sys cmd via qcapcmd
                         Clear CPOP0100;

                         CPOP0100.Processing=8;   //?same as with PDM user def cmd
                         CPOP0100.DBCS='0';   //?ignore DBCS
                         CPOP0100.Prompter='2';   //?prompt if required
                         CPOP0100.Syntax='0';   //?AS400 syntax
                         CPOP0100.MessageKey=*loval;
                         CPOP0100.Reserved=*loval;
                         Reset ech ;

                         OutCmdLen = %Size( cmd ) ;
                         QCaPcmd( cmd
                            : %Len ( cmd )
                            : CPOP0100
                            : %Size(CPOP0100)
                            : 'CPOP0100'
                            : outcmd
                            : %Size( outcmd )
                            : OutCmdLen
                            : ech );
B06                      If ech.Available = 0;
                            cmd = %Subst(outcmd:1:OutCmdLen) ;
X06                      Else;
                            //?if error CPF0008, then there is some selective prompt in the command
                            //?run again with always prompt
B07                         If ech.MSGID = 'CPF0008' ;
                               CPOP0100.Prompter='1';   //?prompt always
                               Reset ech;

                               OutCmdLen = %Size( cmd ) ;
                               QCaPcmd( cmd
                                  : %Len ( cmd )
                                  : CPOP0100
                                  : %Size(CPOP0100)
                                  : 'CPOP0100'
                                  : outcmd
                                  : %Size( outcmd )
                                  : OutCmdLen
                                  : ech);
B08                            If ech.Available = 0;
                                  cmd = %Subst(outcmd:1:OutCmdLen) ;
X08                            Else;
                                  Message(ech.MSGID:ech.Msgdta);
E08                            Endif ;
E07                         Endif ;
E06                      Endif ;

B06                      If %Subst(cmd:1:1)='?';
                            cmd = %Subst(cmd:2);
E06                      Endif;
                         //?si la commande est mal formée (parm obligatoire absent), CPF0006
                         Message('':cmd:'':'':'':'*':0);
                         //?Callp(E) QCmdChk(cmd :%len(cmd ));
                         //?If %Error();   //?abandon F3 ou F12 sur commande promptée
                         //?   Message('':Spmsid+'-'+Spmsda);
                         //?   ersele=True;



                         //?distinguer PSDS.MSGID = 'CPF0006'='Errors occurred in command.
                         //?de PSDS.MSGID = 'CPF6801'='Command prompting ended when user pressed F1
                         //?   If Spmsid = 'CPF6801' ;
                         //?effacer option sinon un appui sur entree relance la commande
                         //?alors qu'on vient juste de faire F12 pour abandonner

                         //?      Scsele='';
                         //?   Endif;
                         //?   Leavesr;
                         //?Endif;



                         Callp(E) QCmdExc( cmd:%Len( cmd));
B06                      If %Error();
                            Message('':Spmsid+'-'+Spmsda);
                            ersele=True;
                            Leave;
E06                      Endif;
                         Scsele='';
E05                   Enddo ;
B05                   If errind <> *all'0';
                         errsfl = True;
                         W2flsp='60';
E05                   Endif;
                      Update Sflc;
E04                Enddo;
                   // run controler
                   if fccmd <> '';
                   cmd = fccmd;
                         Callp(E) QCmdExc( cmd:%Len( cmd));
B06                      If %Error();
                            Message('':Spmsid+'-'+Spmsda);
                            ersele=True;
                         W2flsp='60';
                            Leave;
E06                      Endif;
                         fccmd = '';
                   endif;
X03             When W2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)
                   //?validation  HERE choose the exit
                   //?     w0flsp = *blank ;// exit program

B04                If F5_ccname <> Ccname
X04                Or F5_cctype <> Cctype;
                      W2flsp = '00';
                      Iter;
E04                Endif;

                   W2flsp = '50';   //?show again
                   Iter;
X03             Other ;
                   //?exit
                   //?paok   = *off   ;
                   W0flsp = *blank ;
E03          Endsl ;
E02       Enddo ;


E01    Endsr;
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
BPR ?P hexa            b
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
B01    For i = 1 To %Len(txt);
          h12 = 0;
          c = %Subst(txt:i:1);
          h12=H12/ 16;
          h2 =h2 / 16;
          w12 = x12;
          x12 = %Bitand(x12:X'0F0F');
B02       Select;
X02          When h1 = 0;
                hex +='0';
X02          When h1 = 1;
                hex +='1';
X02          When h1 = 2;
                hex +='2';
X02          When h1 = 3;
                hex +='3';
X02          When h1 = 4;
                hex +='4';
X02          When h1 = 5;
                hex +='5';
X02          When h1 = 6;
                hex +='6';
X02          When h1 = 7;
                hex +='7';
X02          When h1 = 8;
                hex +='8';
X02          When h1 = 9;
                hex +='9';
X02          When h1 =10;
                hex +='A';
X02          When h1 =11;
                hex +='B';
X02          When h1 =12;
                hex +='C';
X02          When h1 =13;
                hex +='D';
X02          When h1 =14;
                hex +='E';
X02          When h1 =15;
                hex +='F';
X02          Other;
                hex+='?';
E02       Endsl;
B02       Select;
X02          When h2 = 0;
                hex +='0';
X02          When h2 = 1;
                hex +='1';
X02          When h2 = 2;
                hex +='2';
X02          When h2 = 3;
                hex +='3';
X02          When h2 = 4;
                hex +='4';
X02          When h2 = 5;
                hex +='5';
X02          When h2 = 6;
                hex +='6';
X02          When h2 = 7;
                hex +='7';
X02          When h2 = 8;
                hex +='8';
X02          When h2 = 9;
                hex +='9';
X02          When h2 =10;
                hex +='A';
X02          When h2 =11;
                hex +='B';
X02          When h2 =12;
                hex +='C';
X02          When h2 =13;
                hex +='D';
X02          When h2 =14;
                hex +='E';
X02          When h2 =15;
                hex +='F';
X02          Other;
                hex+='?';
E02       Endsl;
E01    Endfor;
       Return hex;
      /end-free
    ?C*=------------------------------------------------------------------------
B00  C     *pssr         Begsr
     C                   Dump
E00  C                   Endsr
    ?C*=------------------------------------------------------------------------
EPR  P                 e
BPR ?P DirByName       b
     D                 PI            10I 0
     D   Element1                          Likeds(SortElement)
     D   Element2                          Likeds(SortElement)
      /FREE
B01    Select;
          //?level 1 sort : by type
X01       When Element1.s_type > Element2.s_type;
             Return High;
X01       When Element1.s_type < Element2.s_type;
             Return Low ;
             //?next level : by name
X01       When Element1.s_name > Element2.s_name;
             Return High;
X01       When Element1.s_name < Element2.s_name;
             Return Low ;
X01       Other;
             Return Equal;
E01    Endsl;

B01    Begsr *pssr ;
          Dump ;
E01    Endsr ;
      /end-free
EPR  P                 e
BPR ?P Pareil          B
     D Pareil          PI             1N
     D  filtre                       50    Const varying
     D  data                        500    Const varying
     d  p_wildcard                    2    const options(*nopass)
    ?d*=-----------------
     d wildcard        ds
     d  onechar                       1
     d  anychar                       1
     D Pos             S              2  0
     D iFor            S              2  0
     D preg            S               *
     D pmatch          S               *
     D string          S             11A
     D len             S             10I 0
     D rc              S             10I 0
     D nmatch          S             10U 0 INZ(2)
     D Msg             S             50A
     D Buf             S            256A
     D pattern         S             50A

      /free
B01    If %Parms() > 2;
          wildcard = p_wildcard;
X01    Else;
          wildcard = '.*' ;
E01    Endif;
    ?  // * boucle de controle

B01    Dou 1=1;
          //?* ligne valide en permanence
B02       If Filtre= anychar Or
                Filtre= Data;
             Return *on ;
             Leave ;
E02       Endif ;
          //?* ligne generique type xx* : loger la partie gauche
          Pos = %Scan(anychar : Filtre ) ;
B02       If Pos = 0 ;
             Pos = %Len(Filtre)+1 ;
E02       Endif ;
          //?* ligne generique. attn, xx*xx.x
          //?* partie gauche differente ? rejeter
B02       For iFor=1 To Pos - 1 ;
          if ifor > %len(data);
          return *off;
          leave;
          endif;
B03          If %Subst(Filtre: iFor : 1) =
                   %Subst(Data : iFor : 1)
X03          Or %Subst(Filtre: iFor : 1) = onechar ;
X03          Else ;
                Return *off ;
                Leave ;
E03          Endif ;
E02       Endfor ;

          //?* quelque chose après le * ? non ? alors c'est ok
B02       If Pos >= %Len(Filtre) ;
             Return *on ;
             Leave ;
E02       Endif ;
          //?*                  If        %Subst(Filtre : Pos + 1) = *blank
          //?*                  Return    *on
          //?*                  Leave
          //?*                  Endif
          //?*verifier la suite
          //?*verifier à partir de chaque position suivante puisqu'on ne sait pas
          //?*vraiment où se termine le * du filtre
B02       For iFor= Pos To %Len(Data) ;
B03          If Pareil(%Subst(Filtre : Pos + 1)
                   :%Subst(Data :iFor):wildcard) ;
                Return *on ;
                Leave ;
E03          Endif ;
E02       Endfor ;
E01    Enddo ;
       Return *off ;

B01    Begsr *pssr ;
          Dump ;
E01    Endsr ;

      /end-free
EPR  P                 E
