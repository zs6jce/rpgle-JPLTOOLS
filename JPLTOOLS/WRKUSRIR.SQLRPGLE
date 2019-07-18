
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
    ?
    ?
    ? /define SQL
    ?
      /define LOWERCASE
    ?
    ?
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION

    ? */================================================================
    ? */ modèle de programme
    ? */================================================================
    ? */les adaptations nécessaires sont marquées  : HERE
    ? */HERE replace LF wrkusrip  (& wrkusrif) with target file to update
     fwrkusrip  uf a e           k disk    infsr(*pssr)
     f                                     prefix(maj_)
     f                                     rename(wrkusrip:fmaj    )

    ? */HERE replace DSPF wrkusri with target dspf
     fwrkusrifm cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)
     f                                     indds(indara)
     d bcl           e ds                  extname(wrkusrip)
     d                                     prefix(bcl_)
     d f5ds          e ds                  extname(wrkusrifm:ctlb       )
     d                                     prefix(F5_)

    ? */ !!! indara ne recouvre PAS *in
     d indara          ds
     d  in0199                01     99
     d  errind                60     99
     d  f3                             n   overlay(indara:03)
     d  f5                             n   overlay(indara:05)
     d  f10                            n   overlay(indara:10)
     d  f12                            n   overlay(indara:12)
     d  rollup                         n   overlay(indara:25)
     d  suppression                    n   overlay(indara:40)
     d  clrsfl                         n   overlay(indara:51)
     d  dspsfl                         n   overlay(indara:52)
     d  sflend                         n   overlay(indara:53)
     d  errsfl                         n   overlay(indara:60)
     d  erusrprf                       n   overlay(indara:61)                   HERE adapt the *IN
     d  erkeyword                      n   overlay(indara:61)
     d  ervalue                        n   overlay(indara:62)
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

    ? */ parametres du programme
     d main            pr                  extpgm('MAIN')
     d* paok                          1
     d main            pi
     d* paok                          1

     d mySFW           s           5000
     d sqlCount        s              9b 0
     d In1F            s               n

     D SetColor        Pr             1A
     D   colorValue                   3    CONST OPTIONS(*OMIT:*NOPASS)
     D   colorAttr                    2    CONST OPTIONS(*NOPASS)
     D   fieldPr                      2    CONST OPTIONS(*NOPASS)




     c/EXEC SQL
     C+ Set Option Commit = *NONE
     C+          , CloSQLCsr = *ENDMOD
     C+          , DatFmt = *ISO
     C+          , TimFmt = *ISO
     C+          , Naming = *SYS
     C/End-Exec



      /free
       //?* main program
       //?* initialisation générale
       w0flsp =  '0000' ;//initialisation generale
B01    dow w0flsp <> *blanks ;//?boucle centrale
B02       select ;
X02          when w1flsp = '00';
                exsr sp000 ;//?initialisation
                //?HERE choisir les SP selon les pages écran
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
B01    begsr sp000 ;
          //?HERE choose initial screen
          in1f =true;
       // if %parms() = 0 ;
             w0flsp= '0200' ;// sub-file
       // else;
B02    // if paok = '1';
       //    w0flsp= '0100' ;// selection
X02    // else;
       //    w0flsp= '0200' ;// sub-file
E02    // endif;
E02    // endif;
       // paok = *off ;
          clear f5ds;
          pmqcln() ;
          message('AAA0001');
       // sqlmax = 0088;
E01    endsr ;
       //?---------------------------------------------------------------
       //?traitement de sélection
       //?---------------------------------------------------------------
B01    begsr sp010 ;
B02       dow w1flsp = '01' ;//boucle centrale
B03          select;
X03             when w2flsp = '00';
                   //?initialisation
                   w2flsp = '50';
                   indara = *all'0';
                   //?HERE load the page
                   //?fa        = bcl_             ;
               //  faTYPE  = 'RPG';

X03             when w2flsp = '50';
                   //?show
                   w2flsp = '60';
                   //?Fkey toolbar

X03             when w2flsp = '60';
                   //?show again
                   w2flsp = '70';
                   write pmqctl;//?program message queue
                   exfmt fmta ;//?screen
                   callp pmqcln() ;//?cleanup     pmq
X03             when w2flsp = '70';
                   //?controles
                   //?F3=quitter exit, annulation
B04                if f3         ;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F12=Abandon
B04                if f12        ;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F5=rafraichir
B04                if f5          ;
                      w2flsp = '00';
                      iter;
E04                endif ;
                   //?traitement
                   w2flsp = '80';
                   //?verifier        ?
                // chain fatype fmaj ;
B04             // if not(%found());
                //    ertype = *on;
                //    w2flsp = '60';
                //    message('MSG0001');
E04             // endif ;
X03             when w2flsp = '80';
                   //?validation
                // cbme = fatype;
                // paok = *on ;
                   w0flsp = '0200';
                   iter;
X03             other ;
                   //?abandon
                // paok = *off ;
                   w0flsp = *blank ;
E03          endsl ;
E02       enddo ;
E01    endsr;
       //?---------------------------------------------------------------
       //?task : subfile
       //?---------------------------------------------------------------
B01    begsr sp020 ;
B02       dow w1flsp = '02' ;//boucle centrale
B03          select;
X03             when w2flsp = '00';
                   //?initialisation
                // if in1f;
                // w2flsp = '50';
                // else;
                   w2flsp = '10';
                // endif;
                   indara = *all'0';
                   ranp1b = 1;
                   pag01b = 15;
                   nbl01b = 0;
                   callp pmqcln() ;
                   //?initialisation du sous-fichier
                   ran01b = 0;
                   clrsfl = *on;
                   dspsfl = *off;
                   sflend = *off;
               //  cbcount= *zero;
                   write ctlb;
                   clrsfl = *off;

X03             when w2flsp = '10';
                   //?lecture et chargement du sous-fichier
                   w2flsp = '20';
                   //?HERE prepare the SQL question
                   mySelect = 'Select * ';
                   myFrom = 'from wrkusrip  ';
                   whereAnd = 'Where ';
                   myWhere = '';
                   //?sample for alphabetic criteria
B04                if cbusrprf <>'';
                      myWhere = myWhere + whereAnd +
                         'usrprf like ''%' + %trim(cbusrprf) + '%''';
                      whereand = ' and ';
E04                endif;
B04                if cbkeyword <>'';
                      myWhere = myWhere + whereAnd +
                         'KEYWORD like ''%' + %trim(cbkeyword) + '%''';
                      whereand = ' and ';
E04                endif;
B04                if cbvalue>'';
                      myWhere = myWhere + whereAnd +
                         'upper(value)  like ''%' + %trim(cbvalue) + '%''';
                      whereand = ' and ';
E04                endif;
                   // end of select : order, group, having, optimize, ...
                   //?HERE order, optimize & other sql parameters
                   mySelectMore = ' order by usrprf, keyword, value '
                      + 'for read only optimize for 15 rows';
                   // convert to fixed 5000 char variable (sqlrpg is rpg3 compliant)
                   mySFW = *blank;
                   //?HERE save current values of filter columns

                   f5_CBusrprf   = CBusrprf   ;
                   f5_CBKEYWORD= CBKEYWORD;
                   f5_CBVALUE  = CBVALUE  ;

                   w0flsp = '0220';
                   mySelect = 'Select * ';
                   mySFW = *blank;
                   mySFW = myselect + myfrom + mywhere + myselectmore ;
                   message(*blank : mySFW:'':'':'*INFO':'':0);
B04                if k2isopen;
                      exsr closek2;
E04                endif;

       EXEC SQL
            prepare wrkusrip2 from : mysfw
            ;

B04                if sqlcod <> *zero;
                     diagsqler (sqlcod);
                      w2flsp = '50';
                      iter;
E04                endif;

       EXEC SQL
            declare wrkusriK2 cursor for wrkusrip2
       ;


       EXEC SQL
            open    wrkusrik2
       ;

B04                if sqlcod <> *zero;
                     diagsqler (sqlcod);
                      w2flsp = '50';
                      iter;
E04                endif;


                   k2isopen = *on;
X03             when w2flsp = '20';
                   w2flsp = '30';

       EXEC SQL
            fetch wrkusrik2 into : bcl
       ;

B04                if sqlcod = 100;
                      w2flsp = '40';
                      iter;
E04                endif;


B04                if sqlcod <> *zero;
                     diagsqler (sqlcod);
                      w2flsp = '50';
                      iter;
E04                endif;


                   //?detection de page pleine
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
                   //?chargement d'une ligne, puis lecture suivante
                   w2flsp = '20';
                   ran01b = ranw1b;
                   nbl01b = nbl01b + 1;
                   //?* charger une ligne
                   zbsele = ' ';
                   //?HERE charger une ligne de sous-fichier
                   //?sb        = bcl_             ;

                   sbusrprf   =bcl_usrprf    ;
                   sbKEYWORD=bcl_KEYWORD ;
                   sbVALUE  =bcl_VALUE   ;

                   //?* ecrire une ligne
                   ran01b = ran01b + 1;
                   write sflb ;
X03             when w2flsp = '40';
                   //?dernière ligne du sous-fichier
                   exsr closek2;
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
                      message('SEL0002');
E04                endif;
X03             when w2flsp = '50';
                   //?affichage
                   w2flsp = '60';
                   //?bandeau touches de fonction
                   write fmtkb ;
X03             when w2flsp = '60';
                   //?réaffichage
                   w2flsp = '70';
                   write pmqctl;//?program message queue
                   //?*=----------------------------------------------
                   //?* end of page loading
                   //?* wait for page return from user
                   //?*=----------------------------------------------
                   exfmt ctlb ;//?ecran actif
                   callp pmqcln() ;//?nettoyer la pmq
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
                   //?F3=quitter exit, annulation
B04                if f3         ;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F12=Abandon
B04                if f12        ;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?F5=rafraichir

B04                if f5          ;
                      in1f = false;
                      w2flsp = '00';
                      iter;
E04                endif ;
X03             when w2flsp = '70';
                   //?traitement du controleur de sous-fichier
                   w2flsp = '80';
                   //?traitement du sous-fichier
B04                if ranw1b < 1 ;
                      message('SEL0002');
                      w2flsp = '80';
                      iter;
E04                endif;
                   ranw2b = ranw1b;
B04                for ever;//?boucle infinie
                      suppression = *off;
                      readc(e) sflb;
B05                   if %eof;
                         leave;
E05                   endif;
                      //?quelque chose a faire ?
B05                   if zbsele <> *blank;
                         //?traiter
                         w0flsp= '0300' ;
                         exsr sp030 ;
                         //?HERE verifier le code retour de traitement
                         w0flsp= '0270' ;
B06                      if f3    = *on;
                            w0flsp=*blank ;
                            leave;
E06                      endif;
B06                      if f12   = *on;
                            w0flsp= '0260' ;
                            leave;
E06                      endif;
                         zbsele = ' ';
                         //?autres champs : par sp030
                         update sflb ;
E05                   endif ;
E04                endfor ;
X03             when w2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)
B04                   if f5_cbusrprf     <> cbusrprf
X..                   or f5_cbKEYWORD  <>   cbKEYWORD
X..                   or f5_cbVALUE    <>   cbVALUE
                      ;
                      w2flsp='00';
                      iter;
E04                endif;
                   //?validation   HERE choisir la sortie
                   //? w0flsp = *blank ;
                   w2flsp = '50';
                   iter;
                   //?abandon
X03             other ;
                   //?paok   = *off   ;
                   w0flsp = *blank ;
E03          endsl ;
E02       enddo ;
E01    endsr;
       //?---------------------------------------------------------------
       //?traitement de mise à jour
       //?---------------------------------------------------------------
B01    begsr sp030 ;
          //?never erase anything in bcl_, it already contains next record to display
B02       dow w1flsp = '03' ;//boucle centrale
B03          select;
X03             when w2flsp = '00';
                   //?initialisation
                   w2flsp = '50';
                   errind =  *all'0'   ;
                   callp pmqcln();
                   clear *all fmaj ;
                   //?*quelque chose a lire ?
B04                if zbsele <> '1';
                      chain(e) (sbusrprf : sbkeyword) fmaj ;
B05                   if not %found();
                         zbsele ='5';
                         message('DIV0001');
E05                   endif;
E04                endif;
                   errind = *all'0';
                   //?HERE charger l'écran de mise à jour avec les infos fichier
                   //?fc          = maj_          ;
                   fcusrprf    = maj_usrprf      ;
                   fcKEYWORD = maj_KEYWORD   ;
                   fcVALUE   = maj_VALUE     ;






B04                if zbsele='4';
                      suppression = *on;
X04                else;
                      suppression = *off;
E04                endif;
X03             when w2flsp = '50';
                   //?affichage
                   w2flsp = '60';
X03             when w2flsp = '60';
                   //?réaffichage
                   w2flsp = '70';
                   write pmqctl;//?program message queue
                   //?ecran actif
B04                if zbsele ='4'
X..                   or zbsele ='5';
                      write fmtc;
                      exfmt fmtp;
X04                else;
                      write fmtp;
                      exfmt fmtc;
E04                endif;
                   callp pmqcln() ;//?nettoyer la pmq
X03             when w2flsp = '70';
                   w2flsp = '80';
                   //?controles
                   //?exit, annulation
B04                if f3    = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
B04                if f12   = *on;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?rafraichir
B04                if f5    = *on ;
                      w2flsp = '00';
                      iter;
E04                endif ;
                   //?aide sur la commande ?
B04             // if *inkd = *on;//?f4
B05             //    if RtnCsrFld = 'FCSYSCMD';// commande
                //       Cmd =   '? ' + FCSYSCMD;
                //       //?remplacer le & par un £ parce que QCMDCHK est chiant
B06             //       For Pos = 1;
                //          Eval Pos = %Scan('&' : Cmd     );
B07             //          if Pos > 0;
                //             Cmd = %Replace('£' : Cmd : Pos : 1);
X07             //          Else;
                //             leave;
E07             //          EndIf;
E06             //       Endfor;
                //       //?appeler le prompteur de commande
                //       Callp(E) QCmdChk(cmd: %Len(Cmd) );
B06             //       If %Error;
                //          w2flsp = '60';
                //          iter;
E06             //       endif;
                //       //?remplacer le £ par un & parce que QCMDCHK est chiant
B06             //       For Pos = 1;
                //          Pos = %Scan('£' : Cmd     );
B07             //          if Pos > 0;
                //             Cmd = %Replace('&' : Cmd : Pos : 1);
X07             //          Else;
                //             leave;
E07             //          EndIf;
E06             //       EndFor;
                //       //?réafficher
                //       FCsyscmd = cmd;
                //       w2flsp = '60';
                //       iter;
E05             //    EndIf;//?commande
E04             // EndIf;//?f4
                   //?traitement
                   w2flsp = '80';
                   //?* visu : fin
B04                if zbsele ='5';
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?* suppression
B04                if zbsele = '4';
                      delete(e) fmaj ;
B05                   if not %found();
                         w2flsp = '50';
                         iter;
E05                   endif;
                      clear *all fmaj;
                      w0flsp = *blank;
                      iter;
E04                endif;
                   //?* mise a jour
                   //?controles
                   errind = *all'0';

                   //?check something ?
B04             // if
                //    er   = *on;
                //    w2flsp = '60';
                //    pmqmsg           ('MSG0001');
E04             // endif ;

X03             when w2flsp = '80';
                   //?validation
                   //?* screen fields
                   //?HERE load the file with screen fields     n
                   //?maj.          = fc            ;
                   maj_usrprf   = fcusrprf   ;
                   maj_KEYWORD= fcKEYWORD;
                   maj_VALUE  = fcVALUE  ;

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
                      message('MAJ0001') ;
                      w2flsp = '60';
                      iter;
E04                endif;
                   //?reaffichage sous fichier
                   //?HERE recharger la ligne de sous-fichier à jour
                   //?sb          = maj_            ;



                   sbusrprf   = maj_usrprf   ;
                   sbKEYWORD= maj_KEYWORD;
                   sbVALUE  = maj_VALUE  ;

                   w0flsp = '    ';
                   leave;
                   //?abandon
X03             other ;
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


B01                      begsr   closek2;
    ?   // SQL0504
    ?   // Dans un programme, la déclaration d'un curseur doit précéder toutes
    ?   // les instructions qui font référence à ce curseur.
B02                      if        k2isopen   ;
       EXEC SQL
            close wrkusrik2
       ;
                                   k2isopen = *off   ;
E02                      endif                        ;
E01                      endsr                         ;
    ?  //----------------------------------------------------------------
    ?  // *inzsr, sr pmqsnd, sp *pssr , ...
    ?  //----------------------------------------------------------------
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
BPR  P SetColor        B                   export
     D SetColor        PI             1A
     D   colorValue                   3    CONST OPTIONS(*OMIT:*NOPASS)
     D   colorAttr                    2    CONST OPTIONS(*NOPASS)
     D   fieldPr                      2    CONST OPTIONS(*NOPASS)

     D Up              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     D Lo              C                   'abcdefghijklmnopqrstuvwxyz'
    ? *---
    ? * Define constants
    ? *---
     D Blue            C                   Const(X'3A')
     D Green           C                   Const(X'20')
     D Pink            C                   Const(X'38')
     D Red             C                   Const(X'28')
     D Turquoise       C                   Const(X'30')
     D White           C                   Const(X'22')
     D Yellow          C                   Const(X'32')

     D Blink           C                   CONST(X'2A')
     D NonDisplay      C                   CONST(X'27')
     D Protect         C                   Const(X'80')
     D Reverse         C                   Const(X'01')
     D Underline       C                   Const(X'04')

     D   color         S              3A
     D   attr          S              2A
     D   pr            S              2A
     D   attribute     S              1A

      /free
B01    IF %parms < 1 or %addr(colorvalue) = *null ;
          color = 'GRN'                                            ;
X01    ELSE ;
          color = %xlate(lo: up: colorValue) ;
E01    ENDIF ;
B01    IF %parms < 2 ;
          attr  = '  '                                             ;
X01    ELSE ;
          attr = %xlate(lo: up: ColorAttr) ;
E01    ENDIF ;
B01    IF %parms > 2 ;
          pr = 'PR'                                                ;
X01    ELSE ;
          pr = *blank ;
E01    ENDIF ;

B01    SELECT ;
X01       WHEN Color = 'BLU'                                     ;
             attribute = Blue ;
X01       WHEN Color = 'PNK'                                     ;
             attribute = Pink ;
X01       WHEN Color = 'RED'                                     ;
             attribute = Red ;
X01       WHEN Color = 'TRQ'                                     ;
             attribute = Turquoise ;
X01       WHEN Color = 'WHT'                                     ;
             attribute = White ;
X01       WHEN Color = 'YLW'                                     ;
             attribute = Yellow ;
X01       OTHER ;
             attribute = Green ;
E01    ENDSL ;

B01    IF attr = 'UL' or attr = 'UR'                              ;
          attribute = %bitOr(attribute:Underline) ;
E01    ENDIF ;
B01    IF attr = 'RI' or attr = 'UR'                              ;
          attribute = %bitOr(attribute:Reverse) ;
E01    ENDIF ;
B01    IF attr = 'BL'                                             ;
          attribute = Blink ;
E01    ENDIF ;
B01    IF attr = 'ND'                                             ;
          attribute = NonDisplay ;
E01    ENDIF ;

B01    IF pr = 'PR'                                               ;
          attribute = %bitOr(attribute:Protect) ;
E01    ENDIF ;

       RETURN attribute ;
B01    BEGSR *pssr;
          DUMP ;
E01    ENDSR ;
      /end-free
      *
      *
      *                           pink
      *                          blue
      *                         yellow
      *                        turquoise
      *                       red     ND BL
      *                      white   UL CS
      *                     green   RI HI
      *  20 0 0 1 0 0 0 0 0 x               20 Green
      *  21 0 0 1 0 0 0 0 1 x       x       21 Green, reverse image
      *  22 0 0 1 0 0 0 1 0  x              22 White
      *  23 0 0 1 0 0 0 1 1  x      x       23 White, reverse image
      *  24 0 0 1 0 0 1 0 0 x        x      24 Green, underscore
      *  25 0 0 1 0 0 1 0 1 x       x x     25 Green, underscore, reverse image
      *  26 0 0 1 0 0 1 1 0  x       x      26 White, underscore
      *  27 0 0 1 0 0 1 1 1          x      27 Nondisplay
      *  28 0 0 1 0 1 0 0 0   x             28 Red
      *  29 0 0 1 0 1 0 0 1   x     x       29 Red, reverse image
      *  2a 0 0 1 0 1 0 1 0   x        x    2A Red, high intensity
      *  2b 0 0 1 0 1 0 1 1   x     x   x   2B Red, high intensity, reverse image
      *  2c 0 0 1 0 1 1 0 0   x      x      2C Red, underscore
      *  2d 0 0 1 0 1 1 0 1   x     x x     2D Red, underscore, reverse image
      *  2e 0 0 1 0 1 1 1 0   x      x    x 2E Red, underscore, blink
      *  2f 0 0 1 0 1 1 1 1          x      2F Nondisplay
      *  30 0 0 1 1 0 0 0 0    x        x   30 Turquoise, column separator
      *  31 0 0 1 1 0 0 0 1    x    x    x  31 Turquoise, column separator, reverse image
      *  32 0 0 1 1 0 0 1 0     x       x   32 Yellow, column separator
      *  33 0 0 1 1 0 0 1 1  x      x    x  33 White, reverse image, column separator
      *  34 0 0 1 1 0 1 0 0    x     x   x  34 Turquoise, underscore, column separator
      *  35 0 0 1 1 0 1 0 1    x    x x   x 35 Turquoise, underscore, reverse image, column
      *  36 0 0 1 1 0 1 1 0     x    x   x  36 Yellow, underscore, column separator
      *  37 0 0 1 1 0 1 1 1          x      37 Nondisplay
      *  38 0 0 1 1 1 0 0 0       x         38 Pink
      *  39 0 0 1 1 1 0 0 1       x x       39 Pink, reverse image
      *  3a 0 0 1 1 1 0 1 0      x          3A Blue
      *  3b 0 0 1 1 1 0 1 1      x  x       3B Blue, reverse image
      *  3c 0 0 1 1 1 1 0 0       x  x      3C Pink, underscore
      *  3d 0 0 1 1 1 1 0 1       x x x     3D Pink, underscore, reverse image
      *  3e 0 0 1 1 1 1 1 0      x   x      3E Blue, underscore
      *  3f 0 0 1 1 1 1 1 1          x      3F Nondisplay
      *     1=protected
      *         1=first color bit
      *           1=third color bit
      *             1=second color bit
      *               1=underline
      *                 1=intensify color -> change color name
      *                   1=reverse
      *
EPR  P SetColor        E
