
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


    ? /define SQL

      /define LOWERCASE


     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION

    ? */================================================================
    ? */ modèle de programme
    ? */================================================================
    ? */les adaptations nécessaires sont marquées  : HERE
    ? */HERE replace LF wrkifsp  (& wrkifsf) with target file to update
     fwrkifsp   uf a e           k disk    infsr(*pssr)
     f                                     prefix(maj_)
     f                                     rename(wrkifsp:fmaj    )

    ? */HERE replace DSPF wrkifs with target dspf
     fwrkifsoptfcf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)
     f                                     indds(indara)
     d bcl           e ds                  extname(wrkifsp)
     d                                     prefix(bcl_)
     d f5ds          e ds                  extname(wrkifsoptf:ctlb       )
     d                                     prefix(F5_)

    ? */ !!! indara ne recouvre PAS *in
     d indara          ds
     d  in0199                01     99
     d  errind                60     99
     d  f3                             n   overlay(indara:03)
     d  f4                             n   overlay(indara:04)
     d  f5                             n   overlay(indara:05)
     d  f10                            n   overlay(indara:10)
     d  f12                            n   overlay(indara:12)
     d  rollup                         n   overlay(indara:25)
     d  suppression                    n   overlay(indara:40)
     d  clrsfl                         n   overlay(indara:51)
     d  dspsfl                         n   overlay(indara:52)
     d  sflend                         n   overlay(indara:53)
     d  errsfl                         n   overlay(indara:60)

     d  erkeyword                      n   overlay(indara:62)
     d  ercmd                          n   overlay(indara:63)
     d  limite                         n   overlay(indara:98)
     d ranp1b          s                   like(ran01b)
     d ranw1b          s                   like(ran01b)
     d ranw2b          s                   like(ran01b)
     d pag01b          s              2s 0
     d nbl01b          s              2s 0
       //?cursor status
     d K2IsOpen        s               n   inz(*off)

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d CPOP0100        ds            20    qualified
     d   Processing                  10i 0
     d   DBCS                         1
     d   Prompter                     1
     d   Syntax                       1
     d   MessageKey                   4
     d   Reserved                     9

     d   OutCmdLen     s             10i 0

    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   const options(*varsize)
     D cmdlen                        15P 5 CONST

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                         5000A   const options(*varsize)
     D cmdlen                        15P 5 CONST
     D cmd             S           5000A
     D Pos             S              5  0

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
     d   Cmd                       5000    const options(*varsize)
     d   CmdLen                      10i 0 const
     d   Options                     20    const
     d   OptionsLen                  10i 0 const
     d   OptionsFmt                   8    const
     d   OutCmd                    5000          options(*varsize)
     d   OutCmdAvail                 10i 0 const
     d   OutCmdLen                   10i 0
     d   ErrorCode                  255
    ? */ parametres du programme
     d main            pr                  extpgm('MAIN')
    ?d* paok                          1
     d main            pi
    ?d* paok                          1

     d mySFW           s           5000
     d sqlCount        s              9b 0
     d In1F            s               n





     c/EXEC Sql
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec



      /free
       //?* main program
       //?* initialisation générale
       W0flsp = '0000' ;   //?initialisation generale
B01    Dow W0flsp <> *blanks ;   //?boucle centrale
B02       Select ;
X02          When W1flsp = '00';
                Exsr Sp000 ;   //?initialisation
                //?HERE choisir les SP selon les pages écran


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
          In1F =True;
          //?if %parms() = 0 ;
          W0flsp= '0200' ;   //?sub-file
          //?else;
          //?if paok = '1';
          //?   w0flsp= '0100' ;// selection
          //?else;
          //?   w0flsp= '0200' ;// sub-file
          //?endif;
          //?endif;
          //?paok = *off ;
          Clear f5ds;
          Pmqcln() ;
          Message('AAA0001');
          //?sqlmax = 0088;
E01    Endsr ;
       //?---------------------------------------------------------------
       //?task : subfile
       //?---------------------------------------------------------------
B01    Begsr Sp020 ;
B02       Dow W1flsp = '02' ;   //?boucle centrale
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   //?if in1f;
                   //?w2flsp = '50';
                   //?else;
                   W2flsp = '10';
                   //?endif;
                   indara = *all'0';
                   ranp1b = 1;
                   pag01b = 15;
                   nbl01b = 0;
                   Callp Pmqcln() ;
                   //?initialisation du sous-fichier
                   Ran01b = 0;
                   clrsfl = *on;
                   dspsfl = *off;
                   sflend = *off;
                   //? cbcount= *zero;
                   Write Ctlb;
                   clrsfl = *off;

X03             When W2flsp = '10';
                   //?lecture et chargement du sous-fichier
                   W2flsp = '20';
                   //?HERE prepare the SQL question
                   Myselect = 'Select * ';
                   Myfrom = 'from wrkifsp  ';
                   Whereand = 'Where ';
                   Mywhere = '';
                   //?sample for alphabetic criteria





B04                If Cbkeyword <>'';
                      Mywhere = Mywhere + Whereand +
                         'KEYWORD like ''%' + %Trim(Cbkeyword) + '%''';
                      Whereand = ' and ';
E04                Endif;
B04                If Cbcmd >'';
                      Mywhere = Mywhere + Whereand +
                         'upper(cmd  )  like ''%' + %Trim(Cbcmd ) + '%''';
                      Whereand = ' and ';
E04                Endif;
                   //?end of select : order, group, having, optimize, ...
                   //?HERE order, optimize & other sql parameters
                   Myselectmore = ' order by         keyword, cmd   '
                      + 'for read only optimize for 15 rows';
                   //?convert to fixed 5000 char variable (sqlrpg is rpg3 compliant)
                   mySFW = *blank;
                   //?HERE save current values of filter columns


                   F5_cbkeyword= Cbkeyword;
                   F5_cbcmd = Cbcmd ;

                   W0flsp = '0220';
                   Myselect = 'Select * ';
                   mySFW = *blank;
                   mySFW = Myselect + Myfrom + Mywhere + Myselectmore ;
                   Message(*blank : mySFW:'':'':'*INFO':'':0);
B04                If K2IsOpen;
                      Exsr Closek2;
E04                Endif;

                   Exec Sql
                      Prepare Wrkifsp2 From : mySFW
                      ;

B04                If Sqlcod <> *zero;
                      Diagsqler (Sqlcod);
                      W2flsp = '50';
                      Iter;
E04                Endif;

                   Exec Sql
                      Declare Wrkifsk2 Cursor For Wrkifsp2
                      ;


                   Exec Sql
                      Open Wrkifsk2
                      ;

B04                If Sqlcod <> *zero;
                      Diagsqler (Sqlcod);
                      W2flsp = '50';
                      Iter;
E04                Endif;


                   K2IsOpen = *on;
X03             When W2flsp = '20';
                   W2flsp = '30';

                   Exec Sql
                      Fetch Wrkifsk2 Into : bcl
                      ;

B04                If Sqlcod = 100;
                      W2flsp = '40';
                      Iter;
E04                Endif;


B04                If Sqlcod <> *zero;
                      Diagsqler (Sqlcod);
                      W2flsp = '50';
                      Iter;
E04                Endif;


                   //?detection de page pleine
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
                   //?chargement d'une ligne, puis lecture suivante
                   W2flsp = '20';
                   Ran01b = ranw1b;
                   nbl01b = nbl01b + 1;
                   //?* charger une ligne
                   Zbsele = ' ';
                   //?HERE charger une ligne de sous-fichier
                   //?sb        = bcl_             ;


                   Sbkeyword=Bcl_keyword ;
                   Sbcmd =Bcl_cmd ;

                   //?* ecrire une ligne
                   Ran01b = Ran01b + 1;
                   Write Sflb ;
X03             When W2flsp = '40';
                   //?dernière ligne du sous-fichier
                   Exsr Closek2;
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
                      Message('SEL0002');
E04                Endif;
X03             When W2flsp = '50';
                   //?affichage
                   W2flsp = '60';
                   //?bandeau touches de fonction
                   Write Fmtkb ;
X03             When W2flsp = '60';
                   //?réaffichage
                   W2flsp = '70';
                   Write Pmqctl;   //?program message queue
                   //?*=----------------------------------------------
                   //?* end of page loading
                   //?* wait for page return from user
                   //?*=----------------------------------------------
                   Exfmt Ctlb ;   //?ecran actif
                   Callp Pmqcln() ;   //?nettoyer la pmq
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
                   //?F3=quitter exit, annulation
B04                If f3 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=Abandon
B04                If f12 ;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F5=rafraichir

B04                If f5 ;
                      In1F = False;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
X03             When W2flsp = '70';
                   //?traitement du controleur de sous-fichier
                   W2flsp = '80';
                   //?traitement du sous-fichier
B04                If ranw1b < 1 ;
                      Message('SEL0002');
                      W2flsp = '80';
                      Iter;
E04                Endif;
                   ranw2b = ranw1b;
B04                For Ever;   //?boucle infinie
                      suppression = *off;
                      Readc(E) Sflb;
B05                   If %Eof;
                         Leave;
E05                   Endif;
                      //?réafficher si au moins une modif
                      //?quelque chose a faire ?
B05                   If Zbsele <> *blank;
                         //?traiter
                         W0flsp= '0300' ;
                         Exsr Sp030 ;
                         //?HERE verifier le code retour de traitement
                         W0flsp= '0260' ;
B06                      If f3 = *on;
                            W0flsp=*blank ;
                            Leave;
E06                      Endif;
B06                      If f12 = *on;
                            W0flsp= '0260' ;
                            Leave;
E06                      Endif;
                         Zbsele = ' ';
                         //?autres champs : par sp030
                         Update Sflb ;
E05                   Endif ;
E04                Endfor ;
X03             When W2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)

B04                If F5_cbkeyword <> Cbkeyword
X04                Or F5_cbcmd <> Cbcmd
                         ;
                      W2flsp='00';
                      Iter;
E04                Endif;
                   //?validation   HERE choisir la sortie
                   W0flsp = *blank ;
                   //?w2flsp = '50';
                   Iter;
                   //?abandon
X03             Other ;
                   //?paok   = *off   ;
                   W0flsp = *blank ;
E03          Endsl ;
E02       Enddo ;
E01    Endsr;
       //?---------------------------------------------------------------
       //?traitement de mise à jour
       //?---------------------------------------------------------------
B01    Begsr Sp030 ;
          //?never erase anything in bcl_, it already contains next record to display
B02       Dow W1flsp = '03' ;   //?boucle centrale
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   W2flsp = '50';
                   errind = *all'0' ;
                   Callp Pmqcln();
                   Clear *all Fmaj ;
                   //?*quelque chose a lire ?
B04                If Zbsele <> '1';
                      Chain(E) ( Sbkeyword) Fmaj ;
B05                   If Not %Found();
                         Zbsele ='5';
                         Message('DIV0001');
E05                   Endif;
E04                Endif;
                   errind = *all'0';
                   //?HERE charger l'écran de mise à jour avec les infos fichier
                   //?fc          = maj_          ;

                   Fckeyword = Maj_keyword ;
                   Fccmd = Maj_cmd ;






B04                If Zbsele='4';
                      suppression = *on;
X04                Else;
                      suppression = *off;
E04                Endif;
X03             When W2flsp = '50';
                   //?affichage
                   W2flsp = '60';
X03             When W2flsp = '60';
                   //?réaffichage
                   W2flsp = '70';
                   Write Pmqctl;   //?program message queue
                   //?ecran actif
B04                If Zbsele ='4'
X04                Or Zbsele ='5';
                      Write Fmtc;
                      Exfmt Fmtp;
X04                Else;
                      Write Fmtp;
                      Exfmt Fmtc;
E04                Endif;
                   Callp Pmqcln() ;   //?nettoyer la pmq
X03             When W2flsp = '70';
                   W2flsp = '80';
                   //?controles
                   //?exit, annulation
B04                If f3 = *on;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
B04                If f12 = *on;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?rafraichir
B04                If f5 = *on ;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
                   //?aide sur la commande ?
B04                If f4 ;
                      //?help for sys cmd via qcapcmd
                      Clear CPOP0100;
                      CPOP0100.Processing=4;   //?same as under SEU
                      CPOP0100.Processing=8;   //?same as with PDM user def cmd
                      CPOP0100.DBCS='0';   //?ignore DBCS
                      CPOP0100.Prompter='1';   //?always prompt
                      CPOP0100.Syntax='0';   //?AS400 syntax
                      CPOP0100.MessageKey=*loval;
                      CPOP0100.Reserved=*loval;
                      Reset Errorcodehandler;

                      OutCmdLen = %Size( Fccmd ) ;
                      QCaPcmd( Fccmd
                         : %Size( Fccmd )
                         : CPOP0100
                         : %Size(CPOP0100)
                         : 'CPOP0100'
                         : Fccmd
                         : %Size( Fccmd )
                         : OutCmdLen
                         : Errorcodehandler);
B05                   If Errorcodehandler.Available = 0;
                         //? Cmd  = %subst(cmd:1:outcmdlen);
E05                   Endif ;
                      W2flsp = '60';
                      Iter;
E04                Endif;   //?f4
                   //?traitement
                   W2flsp = '80';
                   //?* visu : fin
B04                If Zbsele ='5';
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?* suppression
B04                If Zbsele = '4';
                      Delete(E) Fmaj ;
B05                   If Not %Found();
                         W2flsp = '50';
                         Iter;
E05                   Endif;
                      Clear *all Fmaj;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?* mise a jour
                   //?controles
                   errind = *all'0';

                   //?check something ?
                   //?if
                   //?   er   = *on;
                   //?   w2flsp = '60';
                   //?   pmqmsg           ('MSG0001');
                   //?endif ;
                   //?CallP(E) QCmdChk(fccmd:%Size(fccmd));
                   //?if %Error();   //?abandon F3 ou F12 sur commande promptée
                   //?   message('':   spmsda);
                   //?   ercmd =true;
                   //? endif;
                   //?end of validation
B04                If errind <> *all'0';
                      errsfl = True;
                      W2flsp='60';
E04                Endif;
X03             When W2flsp = '80';
                   //?validation
                   //?* screen fields
                   //?HERE load the file with screen fields     n
                   //?maj.          = fc            ;

                   Maj_keyword= Fckeyword;
                   Maj_cmd = Fccmd ;

                   //?* other fields
                   //?* update the file
B04                If Zbsele = '1'
X04                Or Zbsele = '3';
                      Write(E) Fmaj ;
E04                Endif;
B04                If Zbsele = '2';
                      Update(E) Fmaj ;
E04                Endif;
B04                If %Eof;
                      Message('MAJ0001') ;
                      W2flsp = '60';
                      Iter;
E04                Endif;
                   //?reaffichage sous fichier
                   //?HERE recharger la ligne de sous-fichier à jour
                   //?sb          = maj_            ;




                   Sbkeyword= Maj_keyword;
                   Sbcmd = Maj_cmd ;

                   W0flsp = '    ';
                   Leave;
                   //?abandon
X03             Other ;
                   //?paok   = *off   ;
                   W0flsp = *blank ;
                   Leave;
E03          Endsl ;
E02       Enddo;
E01    Endsr;
       //?---------------------------------------------------------------
       //?begsr        ;



       //?endsr;
       //?---------------------------------------------------------------


B01    Begsr Closek2;
          //?SQL0504
          //?Dans un programme, la déclaration d'un curseur doit précéder toutes
          //?les instructions qui font référence à ce curseur.
B02       If K2IsOpen ;
             Exec Sql
                Close Wrkifsk2
                ;
             K2IsOpen = *off ;
E02       Endif ;
E01    Endsr ;
       //?----------------------------------------------------------------
       //?*inzsr, sr pmqsnd, sp *pssr , ...
       //?----------------------------------------------------------------
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
