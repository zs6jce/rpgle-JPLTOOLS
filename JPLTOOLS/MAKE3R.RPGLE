    ? * compilation :
    ? *
    ? *
    ? *
      /define INFDS
    ?
    ?
      *define SQL
    ? *define SQLDESCRIBE
      /define LOWERCASE
    ? *define QUOTE
    ? *define XLXML
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


    ? *================================================================
    ? * sample of program
    ? *================================================================
    ? *necessary adaptation are marked HERE
    ? *HERE replace PF MakeL2by target file to read
     fMakeL2    if   e           k disk    infsr(*pssr)
     f                                     prefix('BCL.')
     f                                     rename(makef  :fbcl)
    ? *HERE replace LF MakeL1 (& makef) with target file to update
     fMakeL1    uf a e           k disk    infsr(*pssr)
     f                                     prefix('MAJ.')
     f                                     rename(makef  :fmaj)
    ? *
    ? *HERE replace DSPF jpl020 with target dspf
     fmake3rfm  cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)                   HERE with sfl ?
     f                                     indds(indara)

     d bcl           e ds                  qualified extname(MakeL2)
     d maj           e ds                  qualified extname(MakeL1)
     d f5            e ds                  extname(make3rfm:ctlb:*input)
     d                                     qualified
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

     d*Process Commands (QCAPCMD) API
     D*http://publib.boulder.ibm.com/iseries/v5r1/ic2924/index.htm?info/apis/qcapcmd.htm
     d*
     d*  Source command string  Input  Char(*)
     d*  Length of source command string  Input  Binary(4)
     d*  Options control block  Input  Char(*)
     d*  Options control block length  Input  Binary(4)
     d*  Options control block format  Input  Char(8)
     d*  Changed command string  Output  Char(*)
     d*  Length available for changed command string  Input  Binary(4)
     d*  Length of changed command string available to return  Output  Binary(4)
     d*  Error Code  I/O  Char(*)
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

     d CPOP0100        ds            20    qualified
     d   Processing                  10i 0
     d   DBCS                         1
     d   Prompter                     1
     d   Syntax                       1
     d   MessageKey                   4
     d   Reserved                     9

     d   OutCmdLen     s             10i 0


     D*MSGID            S              7A   IMPORT('_EXCP_MSGID')
     D*c_system         pr            10i 0 extproc('system')
     D*parm2                            *   options(*string) value
    ? * exemple :
    ? *d rc              s              9b 0
    ? *         rc =  c_system(cmde );
    ? *         if rc <> 0;
    ? *         dsply msgid;
    ? *         endif;

    ? * structures pour chaque message d'erreur ayant des variables
    ? * bin(1) = 3i 0; bin(2) = 5i 0; bin(4) = 10i 0; bin(8) = 20i 0
     d MSG0002         ds           132                                         vars pour erreur
     d  msg000201                          like(typebin4)
      * indicateur de message warning deja envoyé
     d warn0002        s               n

    ? * HERE program name & parameters
     d make3r          pr
     d* paok                          1
     d make3r          pi
     d* paok                          1
     DPareil           PR             1N
     D  Filtre                       10    Const
     D  Data                         10    Const

     d PaType          s                   like(cbtype)

     dMake1r           pr                  extpgm('MAKE1R')
     d  type                               like(cbtype)

     DMake2R           PR                  extpgm('MAKE2R')                     exemple
     D  ExecutionLot                  4    const                                *NO               &E
     D  Fichier                      10    const                                QCLSRC       FICS &F
     D  JobdLib                      10    const                                *NULL             &G
     D  Jobd                         10    const                                *USRPRF           &H
     D  JobdQual                     21    const                                *USRPRF           &J
     D  MemberLib                    10    const                                ECOLIB       LIBS &L
     D  Member                       10    const                                MAKE         MBRE &N
     D  ObjectLib                    10    const                                ECOLIB       LIBO &O
     d  IfsLink                     500    const
     D  CompilationB                  4    const                                *YES              &P
     D  ReplaceObj                    4    const                                *YES         REPL &R
     D  Type                         10    const                                CLP               &S
     D  compiler                     10    const                                CLP               &S
     D  Texte                        50    const                                'Compilation avec &X
     D  Confirmer                     4                                         *YES              &C
     D  PileCommande               9999

     D  Confirmer      s              4
     D  PileCommande   s           9999


      /free
       //?* programme principal
       //?* initialisation générale
       w0flsp =  '0000' ;//initialisation generale
B01    dow w0flsp <> *blanks ;//?boucle centrale
B02       select ;
X02          when w1flsp = '00';
                exsr sp000 ;//?initialisation
X02

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
B01    begsr sp000 ;

B02         CBTYPE ='*';
B02
B02         CBORDR =0;
B02         CBMBRE ='*';
            CBLIB  ='*';
X02
             w0flsp= '0200' ;// sub-file
E02

          pmqcln() ;
          message('AAA0001');
E01    endsr ;
       //?---------------------------------------------------------------
       //?task : subfile
       //?---------------------------------------------------------------
B01    begsr sp020 ;
B02       dow w1flsp = '02';//main loop
B03          select;
X03             when w2flsp = '00';
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
X03             when w2flsp = '10';
                   //?read file & load subfile
                   w2flsp = '20';
                   //?HERE key list to read target file & remember last call to refresh
              //   setll ( CBTYPE
              //         : CBORDR
              //         : CBMBRE
              //         : CBLIB
              //                                 ) MakeL2;
              setll *loval MakeL2;
                   f5.CBTYPE    = CBTYPE   ;

                   f5.CBMBRE    = CBMBRE   ;
                   f5.CBLIB     = CBLIB    ;
                   f5.CBORDR    = CBORDR   ;
X03             when w2flsp = '20';
                   read(e) MakeL2;
B04                if %eof ;
                      w2flsp = '40';
                      iter;
E04                endif;
                   if (pareil(bcl.maTYPE:cbTYPE)
                         or pareil(cbTYPE:bcl.maTYPE)) and


                         (bcl.maORDR=CBORDR or cbordr = 0) and
                         (pareil(bcl.maMBRE:cbMBRE)
                         or pareil(cbMBRE:bcl.maMBRE)) and
                         (pareil(bcl.maLIB :cbLIB )
                         or pareil(cbLIB :bcl.maLIB ));
                   else;
                     iter;
                   endif;
                   w2flsp = '30';
                   //?detection    page is full
                   ranw1b = ran01b ;
B04                if pag01b <= nbl01b ;
                      dspsfl = *on;
                      sflend = *off;
                      nbl01b = 0;
                      ran01b = ranp1b;
                      w2flsp = '50';
                      iter;
E04                endif;
X03             when w2flsp = '30';
                   //?load one line, read next
                   w2flsp = '20';
                   ran01b = ranw1b;
                   nbl01b = nbl01b + 1;
                   //?* load one line
                   zbsele = ' ';
                   //?HERE load one line in the subfile
                      sbTYPE    = bcl.MATYPE       ;

                      sbORDR    = bcl.MAORDR       ;
                      sbMBRE    = bcl.MAMBRE       ;
                      sbLIB     = bcl.MALIB        ;
                      sbACTN    = bcl.MAACTN       ;
                      sbCMDE    = bcl.MACMDE       ;




                   //?* write one line
                   ran01b = ran01b + 1;
                   write sflb ;
X03             when w2flsp = '40';
                   //?last line for subfile
                   w2flsp = '50';
                   //?HERE choose to add one blank line in an empty subfile
B04                if ran01b < 1 ;
                      clear sflb ;
                      ran01b = 1 + ran01b ;
                      write sflb;
E04                endif;
                   ranw1b = ran01b ;
B04                if ran01b >= 1;
                      clrsfl = *off;
                      dspsfl = *on;
                      sflend = *on;
                      ran01b = ranp1b;
X04                else;
                      clrsfl = *off;
                      dspsfl = *off;
                      sflend = *off;
                      message      ('SEL0002') ;
E04                endif;
X03             when w2flsp = '50';
                   //?show
                   w2flsp = '60';
                   //?Fkey tool bar
                   write fmtkb ;
X03             when w2flsp = '60';
                   //?show again
                   w2flsp = '70';
                   write pmqctl;//?program message queue
                   exfmt ctlb ;//?
                   callp pmqcln() ;//?
                   //?controles
                   //?* rollup
                   limite = *off;
B04                if rollup = *on ;
B05                   if sflend = *off;
                         ranp1b = 1 +ranw1b ;
                         w2flsp = '30';
                         iter ;
X05                   else;
                         w2flsp = '50';
                         iter ;
E05                   endif;
E04                endif;
                   //?F3=quit, exit, annulation
B04                if *inkc = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F12=F3
B04                if *inkl = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F5=refresh
B04                if *inke = *on ;
                      w2flsp = '00';
                      iter;
E04                endif ;
                   // F14 = test command

         IF *INKN = *ON;
        //    verifier si le type est géré
                patype = cbtype;
                                 // MAKE1R   (patype);
        // if patype = 'UNKNOWN';
        //     message('MAK0002');
        //         w2flsp = '60';
        //                       iter;
        // endif;
           //    verifier si bibliothèque et source fournis
           if cblib = *blank;
                   w2flsp = '60';
                   message('MAK0003');
                  iter  ;
           endif;
           if cbmbre= *blank;
                   w2flsp = '60';
                   message('MAK0004');
                  iter  ;
           endif;
           //    afficher la pile générée
           confirmer='*YES';
           pilecommande = *blank;
           MAKE2R ('*NO'                                                      //ExecutionLot
               :'qpgmsrc'                                                     //Fichier
               :'*NULL'                                                       //JobdLib
               :'*USRPRF'                                                     //Jobd
               :'*USRPRF'                                                     //JobdQual
               : CBLIB                                                        //MemberLib
               : CBMBRE                                                       //Member
               : CBLIB                                                        //ObjectLib
               : ''                                                           //IfsLink
               :'*YES'                                                        //CompilationB
               :'*YES'                                                        //ReplaceObj
               : CBTYPE                                                       //Type
               : CBTYPE                                                       //Type
               :'Compilation'                                                 //Texte
               :confirmer                                                     //Confirmer
               :pilecommande);
         endif;

X03             when w2flsp = '70';
                   //?work the subfile controler
                   w2flsp = '80';
B04                if ranw1b < 1 ;
                      message      ('SEL0002');
                      w2flsp = '60';
                      iter;
E04                endif;
                   ranw2b = ranw1b;
B04                dow 1=1;//?for ever loop
                      suppression = *off;
                      readc(e) sflb;
B05                   if %eof;
                         leave;
E05                   endif;
                      //?something to do ?
B05                   if zbsele <> *blank;
                         //?work
                         w0flsp= '0300' ;
                         exsr sp030 ;
                         //?HERE check the return code of work task then choose next task
                         w0flsp= '0270' ;
B06                      if *inkc = *on;
                            w0flsp= *blank ;
                            leave;
E06                      endif;
B06                      if *inkl = *on;
                            w0flsp= '0260' ;
                            leave;
E06                      endif;
                         zbsele = ' ';
                         //?other fields : in sp030
                         update sflb ;
E05                   endif ;
E04                enddo ;
X03             when w2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)
B04                if f5.CBTYPE     <> CBTYPE
B04
B04                or f5.CBORDR     <> CBORDR
B04                or f5.CBMBRE     <> CBMBRE
B04                or f5.CBLIB      <> CBLIB
X..
X..                                        ;
                      w2flsp='00';
                      iter;
E04                endif;

                   //?validation  HERE choose the exit
                   //?     w0flsp = *blank ;// exit program
                   w2flsp = '50';              // show again
                   iter;
X03             other ;
                   //?exit
                   //?paok   = *off   ;
                   w0flsp = *blank ;
E03          endsl ;
E02       enddo ;
E01    endsr;
       //?---------------------------------------------------------------
       //?task : update
       //?---------------------------------------------------------------
B01    begsr sp030 ;
          //?never erase anything in bcl.*, it already contains next record to display
B02       dow w1flsp = '03';//main loop
B03          select;
X03             when w2flsp = '00';
                   //?initialisation
                   w2flsp = '50';
                   errind =  *all'0'   ;
                   callp pmqcln();
                   clear *all fmaj;
                   //?*quelque chose a lire ?
B04                if zbsele <> '1';
                      chain(e) ( SBordr
                               : SBtype

                               : SBMBRE
                               : SBLIB          ) fmaj ;
B05                   if not %found(MakeL1 );
                         zbsele ='5';
                         message('DIV0001');
E05                   endif;
E04                endif;
                   errind = *all'0';
                   //?HERE load update screen with file fields
                   //?fc          = maj.          ;
                      FCTYPE      = maj.MATYPE    ;

                      FCORDR      = maj.MAORDR    ;
                      FCMBRE      = maj.MAMBRE    ;
                      FCLIB       = maj.MALIB     ;
                      FCACTN      = maj.MAACTN    ;
                      FCCMDE      = maj.MACMDE    ;
                      FCMONM      = maj.MAMONM    ;
B04                if zbsele='4';
                      suppression = *on;
X04                else;
                      suppression = *off;
E04                endif;
X03             when w2flsp = '50';
                   //?show
                   w2flsp = '60';
X03             when w2flsp = '60';
                   //?show again
                   w2flsp = '70';
                   write pmqctl;//?program message queue
                   //?active screen
B04                if zbsele ='4'
X..                   or zbsele ='5';
                      write fmtc;
                      exfmt fmtp;
X04                else;
                      write fmtp;
                      exfmt fmtc;
E04                endif;
                   callp pmqcln() ;
X03             when w2flsp = '70';
                   //?controles
                   //?exit, annulation
B04                if *inkc = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
B04                if *inkl = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?refresh
B04                if *inke = *on ;
                      w2flsp = '00';
                      iter;
E04                endif ;
                   //?help on sys command ?
B04                   if *inkd = *on;//?f4
B05                      if RtnCsrFld = 'FCCMDE';// commande
                         //
                         // Cmd =   '? ' + FCCMDE;
                         // //?remplacer le & par un £ parce que QCMDCHK est chiant
B06                      // For Pos = 1;
                         //    Eval Pos = %Scan('&' : Cmd     );
B07                      //    if Pos > 0;
                         //       Cmd = %Replace(x'7B' : Cmd : Pos : 1);
X07                      //    Else;
                         //       leave;
E07                      //    EndIf;
E06                      // Endfor;
                         // //?appeler le prompteur de commande
                         // Callp(E) QCmdChk(cmd: %Len(Cmd) );
B06                      // If %Error;
                         //    w2flsp = '60';
                         //    iter;
E06                      // endif;
                         // //?remplacer le £ par un & parce que QCMDCHK est chiant
B06                      // For Pos = 1;
                         //    Pos = %Scan(x'7B' : Cmd     );
B07                      //    if Pos > 0;
                         //       Cmd = %Replace('&' : Cmd : Pos : 1);
X07                      //    Else;
                         //       leave;
E07                      //    EndIf;
E06                      // EndFor;
                         // //?réafficher
                         // FCCmde = cmd;
                            // help for sys cmd via qcapcmd
                            clear CPOP0100;
                            CPOP0100.processing=4;//same as under SEU
                            CPOP0100.processing=8;//same as with PDM user def cmd
                            CPOP0100.DBCS='0';//ignore DBCS
                            CPOP0100.Prompter='1';//always prompt
                            CPOP0100.Syntax='0';//AS400 syntax
                            CPOP0100.MessageKey=*loval;
                            CPOP0100.Reserved=*loval;
                            reset errorCodeHandler;
                    cmd =   FCCmde      ;
              outcmdlen =        %size(  Cmd )   ;
                            qcapcmd(  Cmd
                               : %size(  Cmd )
                               : CPOP0100
                               : %size(CPOP0100)
                               : 'CPOP0100'
                               :   Cmd
                               : %size(  Cmd )
                               : outcmdlen
                               : ErrorCodeHandler);
                               if errorcodehandler.available = 0;
                            FCCmde = %subst(cmd:1:outcmdlen);
                            endif ;
                            w2flsp = '60';
                            iter;
E05                      EndIf;//?commande
E04                   EndIf;//?f4
                   // work
                   w2flsp = '80';
                   //?* show only : end
B04                if zbsele ='5';
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?* delete
B04                if zbsele = '4';
                      delete(e) fmaj ;
B05                   if not %found(MakeL1);
                         w2flsp = '50';
                         iter;
E05                   endif;
                      clear *all fmaj;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?* update
                   //?controles
                   errind = *all'0';
                   //?check something ?
B04                if not(FCMONM = 'IGNORE' or FCMONM = 'ESCAPE'
                         or FCMONM = *BLANK  );
                      ermonm = *on;
                      w2flsp = '60';
                      message ('MAK0001');
E04                endif ;
X03             when w2flsp = '80';
                   //?validation
                   //?* screen fields
                   //?HERE load the file with screen fields
                   //?maj.          = fc            ;
                      maj.MATYPE    =   FCTYPE      ;

                      maj.MAORDR    =   FCORDR      ;
                      maj.MAMBRE    =   FCMBRE      ;
                      maj.MALIB     =   FCLIB       ;
                      maj.MAACTN    =   FCACTN      ;
                      maj.MACMDE    =   FCCMDE      ;
                      maj.MAMONM    =   FCMONM      ;
                   //?* other fields
                   //?* update the file
B04                if zbsele = '1'
X..                   or zbsele = '3';
                      write(e) fmaj ;
E04                endif;
B04                if zbsele = '2';
                      update(e) fmaj ;
E04                endif;
B04                if %eof;
                      message      ('MAJ0001') ;

                      w2flsp = '60';
                      iter;
E04                endif;
                   //?reload subfile
                   //?HERE reload the subfile line before subfile update
                   //?sb          = maj.            ;
                        SBTYPE    = maj.MATYPE      ;

                        SBORDR    = maj.MAORDR      ;
                        SBMBRE    = maj.MAMBRE      ;
                        SBLIB     = maj.MALIB       ;
                        SBACTN    = maj.MAACTN      ;
                        SBCMDE    = maj.MACMDE      ;
                        ZBSELE    =     ' '         ;





                   w0flsp = '    ';
                   leave;
X03             other ;
                   //?exit
                   //?paok   = *off   ;
                   w0flsp = *blank ;
                   leave;
E03          endsl ;
E02       enddo;
E01    endsr;
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
    ?  //=--------------------------------------------------------------------=*
      /end-free
     P Pareil          B
     D Pareil          PI             1N
     D  filtre                       10    Const
     D  data                         10    Const
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

    ? * boucle de controle
B01  c                   do        1
    ? * ligne valide en permanence
B02  c                   if        filtre= '*'    or
     c                             filtre= data
     c                   return    *ON
     c                   leave
E02  c                   endif
    ? * ligne generique type xx* : loger la partie gauche
     c                   eval      Pos = %Scan('*' : filtre  )
B02  c                   if        Pos = 0
     c                   eval      pos = 11
E02  c                   endif
    ? * ligne generique. attn, xx*xx.x
    ? * partie gauche differente ? rejeter
B02  c                   for       ifor=1 to pos - 1
B03  c                   if        %subst(filtre: ifor : 1) =
     c                             %subst(data  : ifor : 1)
     c                             or %subst(filtre: ifor : 1) = '.'
X03  c                   else
     c                   return    *OFF
     c                   leave
E03  c                   endif
E02  c                   endfor
     c
    ?c* quelque chose après le * ? non ? alors c'est ok
B02  c                   if        pos > 10
     c                   return    *ON
     c                   leave
E02  c                   endif
B02  c                   if        %subst(filtre : pos + 1) = *blank
     c                   return    *ON
     c                   leave
E02  c                   endif
    ?c* verifier la suite
    ? * verifier à partir de chaque position suivante puisqu'on ne sait pas
    ? * vraiment où se termine le * du filtre
B02  c                   for       iFor= pos to 10
B03  c                   if        pareil(%subst(filtre : pos + 1)
     c                                   :%subst(data   :ifor))
     c                   return    *ON
     c                   leave
E03  c                   endif
E02  c                   endfor
E01  c                   enddo
     c                   return    *OFF

B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR

     P                 E
