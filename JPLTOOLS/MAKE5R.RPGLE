      /define INFDS
     H DEBUG DATEDIT(*YMD)
     FMAKE5RFM  CF   E             WORKSTN INFSR(*PSSR)
     F                                     INFDS(FIDS)
     F                                     SFILE(SFLB:RAN01B)

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                          500A
     D cmdlen                        15P 5 CONST
     D cmd             S            500A
     D Pos             S              5  0
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION


       //?
       //?=-------------------------------------------------------------=*
       //?DECLARATIONS
       //?=-------------------------------------------------------------=*
       //?DEFINITION DE ZONES
       //?LES CLES
       //?=-------------------------------------------------------------=*
       //?PARAMETRES RECUS
     DMake5R           PR
     D  Confirmer                     4
     D  PileCommande               9999
     DMake5R           PI
     D  Confirmer                     4
     D  PileCommande               9999

     D  pPile          S               *
     D  Pile           DS                  Based(pPile)
     D    PileTete                   25    overlay(Pile)
     D      NbCde                     3  0 overlay(PileTete)
     D    Pile33                   9900    overlay(Pile:26)
     D      UneCde                  550    overlay(Pile33)
     D                                     dim(18)
     D Commande        DS           550
     D   CdeTete                     25
     D     CdeLen                     5S 0 overlay(CdeTete)
     D     CdeMonMsg                 10    overlay(CdeTete:*NEXT)
     D   CdeTexte                   500    overlay(Commande:26)

     D CurCde          S                   like(NbCde)
     D Reafficher      S               N



      /FREE
       pPile = %Addr(PileCommande);


      /END-FREE

       //?================================================================
       //?Programme principal
       //?================================================================
       //?Initialisation générale
     C                   MOVEL     '0000'        W0FLSP
       //?BOUCLE CENTRALE
      /FREE
B01    DOW W0FLSP <> *BLANKS;
B02       select;
X02          when w1flsp =  '00';
                exsr SP000 ;
X02          when w1flsp =  '01';
                exsr SP010 ;
                //?DETAIL SELECTION
X02          when w1flsp =  '02';
                exsr SP020 ;
                //?MAJ
X02          when w1flsp =  '03';
                exsr SP030 ;
                //?ERREUR DANS WWFLAG
X02          other;
                exsr *PSSR;
E02       endsl;

E01    ENDDO;
       *inlr = *on;



       //?----------------------------------------------------------------
       //?Initialisation générale
       //?----------------------------------------------------------------

B00    BEGSR SP000;


       W1FLSP  =     '0200';

E00    ENDSR;
       //?
       //?----------------------------------------------------------------
       //?Traitement du 1er écran
       //?----------------------------------------------------------------
       //?
B00    BEGSR SP010;
E00    ENDSR;
       //?
       //?
       //?----------------------------------------------------------------
       //?Traitement du 2e  écran
       //?----------------------------------------------------------------
       //?
B00    BEGSR SP020;
       //?
       //?----------------------------------------------------------------
       //?Initialisation
       //?----------------------------------------------------------------
      /END-FREE
     C     SP020D        TAG

     C                   MOVEA     *ALL'0'       *IN
     C                   Z-ADD     1             RANP1B            4 0          LIGNE DU CURSEUR
     C                   Z-ADD     15            PAG01B            2 0
     C                   Z-ADD     0             NBL01B            2 0

     c                   callp      PMQCLN
       //?----------------------------------------------------------------
       //?Initialisation du sous-fichier
       //?----------------------------------------------------------------

     C                   Z-ADD     *ZEROS        RAN01B
     C                   MOVEA     '100'         *IN(51)

     c                   WRITE     CTLB

     C                   MOVE      *OFF          *IN51
       //?----------------------------------------------------------------
       //?LECTURE
       //?----------------------------------------------------------------
       //?
       //?
B01  C     1             DO        nbcde         CurCde                         SFLEND

      /FREE
          Commande = UneCde(CurCde);

          //?----------------------------------------------------------------
          //?CHARGER UNE LIGNE
          //?----------------------------------------------------------------

          ZBSELE   =      ' '        ;
          SBmonM = CdeMonMsg ;

B02       if SBMONM <> 'IGNORE';
             SBMONM = 'ESCAPE';
E02       Endif;


          SBCMDE =CdeTexte ;

          sbcmd2 = %subst(cdetexte:66);

          SBCMDH = CdeTexte;
          //?----------------------------------------------------------------
          //?ECRIRE UNE LIGNE
          //?----------------------------------------------------------------
          RAN01B+=1 ;

          WRITE SFLB;
          //?
E01    ENDDO;
       //?
B01    IF RAN01B < 1;
          CLEAR SFLB;

          RAN01B +=1;

          WRITE SFLB;
E01    ENDIF;
       //?

B01
      /END-FREE
     C                   MOVEA     '011'         *IN(51)
     C                   Z-ADD     RANP1B        RAN01B
X01



E01
       //?----------------------------------------------------------------
       //?Affichage
       //?----------------------------------------------------------------
     C     SP020A        TAG
       //?                   BANDEAU TOUCHES DE FONCTION

     c                   WRITE     FMTKB

     C     SP020E        TAG
       //?                   PROGRAM MESSAGE QUEUE
      /FREE
       WRITE PMQCTL;
       //?                   ECRAN ACTIF
       EXFMT CTLB;
       //?----------------------------------------------------------------
       //?NETTOYER LA PMQ
       //?----------------------------------------------------------------
       PMQCLN();



       *IN98 = *OFF;
B01
B02


E02

E01
       //?----------------------------------------------------------------
       //?Exit, ANNULATION
       //?----------------------------------------------------------------
      /END-FREE
     C     *INKC         CABEQ     *ON           SP02KC
     C     *INKL         CABEQ     *ON           SP02KL
       //?----------------------------------------------------------------
       //?Rollup  F11
       //?----------------------------------------------------------------
     C     *IN11         CABEQ     *ON           SP020E
       //?----------------------------------------------------------------
       //?RAFRAICHIR
       //?----------------------------------------------------------------
     C     *INKE         CABEQ     *ON           SP020D
       //?----------------------------------------------------------------
       //?TRAITEMENT SOUS-FICHIER
       //?----------------------------------------------------------------
       //?
       //?----------------------------------------------------------------
       //?TRAITEMENT CONTROLEUR
       //?----------------------------------------------------------------
       //?
B01



E01
       //?----------------------------------------------------------------
       //?TRAITEMENT
       //?----------------------------------------------------------------


      /FREE
       reafficher = *off;
      /END-FREE
B01  C                   DO        *HIVAL
      /FREE
          READC SFLB;
B02       if %EOF;
             leave;
E02       endif;
          //?QUELQUE CHOSE A FAIRE ?

          reafficher = *on;
B02       IF ZBSELE <> *BLANK;
             //?TRAITER
             EXSR SP030;
      /END-FREE
     C   KC              LEAVE
     C   KL              LEAVE
             //?REAFFICHAGE SOUS FICHIER






     C                   MOVEL     ' '           ZBSELE
      /FREE
             UPDATE SFLB;
E02    ENDIF;                                                             //ZBSELE <>''
E01    ENDDO;//?READC
      /END-FREE
     C   KC              GOTO      SP02KC
B01  C   KL              DO
      /FREE
          *IN60 = *ON;
          UPDATE SFLB;
      /END-FREE
     C                   GOTO      SP020A
      /FREE
E01    ENDDO;
B01    if reafficher;
      /END-FREE
     C                   GOTO      SP020A
      /FREE
E01    endif;
       //?----------------------------------------------------------------
       W0FLSP =*BLANK;
      /END-FREE

     C                   GOTO      SP020F
       //?----------------------------------------------------------------
       //?ABANDON
       //?----------------------------------------------------------------
     C     SP02KL        TAG
       //?                   MOVEL'0100'    W0FLSP
       //?                   GOTO SP020F
     C     SP02KC        TAG
     C                   MOVEL     *BLANK        W0FLSP
     C                   MOVEL     'F3F3'        Confirmer
E00  C     SP020F        ENDSR
       //?----------------------------------------------------------------
       //?
       //?----------------------------------------------------------------
       //?Traitement du 3e  écran
       //?----------------------------------------------------------------
       //?
      /FREE
B00    BEGSR SP030;
       //?
       //?----------------------------------------------------------------
       //?Initialisation
       //?----------------------------------------------------------------
      /END-FREE
    ?C     SP030D        TAG
      /FREE
       PMQCLN();






       //?QUELQUE CHOSE A LIRE ?
B03






E03
      /END-FREE
     C                   MOVEA     *ALL'0'       *IN(60)





     C                   MOVEL     SBCMDH        FCCMDE
     C                   MOVEL     SBMONM        FCMONM






B01
       //?----------------------------------------------------------------
       //?Affichage
       //?----------------------------------------------------------------
     C     SP030A        TAG
      /FREE

       //?                   BANDEAU TOUCHES DE FONCTION
      /END-FREE
     C     SP030E        TAG
       //?                   PROGRAM MESSAGE QUEUE
      /FREE
       WRITE PMQCTL;
       //?                   ECRAN ACTIF
B01
B..
       WRITE FMTC;
       EXFMT FMTP;
X01


E01
       //?----------------------------------------------------------------
       //?NETTOYER LA PMQ
       //?----------------------------------------------------------------
       PMQCLN();
       //?----------------------------------------------------------------
       //?Exit, ANNULATION
       //?----------------------------------------------------------------
      /END-FREE
     C     *INKC         CABEQ     *ON           SP0303
     C     *INKL         CABEQ     *ON           SP0312
       //?----------------------------------------------------------------
       //?RAFFRAICHIR
       //?----------------------------------------------------------------
      /FREE
B01    IF *INKE = *ON;
      /END-FREE
     C                   GOTO      SP030D
      /FREE
E01    ENDIF;
       //?----------------------------------------------------------------
       //?TRAITEMENT
       //?----------------------------------------------------------------
       //?VISU : FIN
B01
      /END-FREE
     C                   GOTO      SP030F

       //?----------------------------------------------------------------
       //?ABANDON
       //?----------------------------------------------------------------
     C     SP0312        TAG
     C     SP0303        TAG
E00  C     SP030F        ENDSR
       //?----------------------------------------------------------------
       //?
       //?----------------------------------------------------------------
       //?
       //?         ------    BEGSR
       //?
       //?                   ENDSR
       //?----------------------------------------------------------------
       //?*INZSR, SR PMQSND, SP *PSSR , ...
       //?----------------------------------------------------------------
EPR   /free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc


