    ? **********************************************************
    ? * RETROUVE LES OPTIONS POUR UN MEMBRE A COMPILER
    ? *
    ? * PRINCIPE : RECHERCHER DANS LE FICHIER DES OPTIONS TOUTES LES LIGNES QUI
    ? * CONCERNENT LE SOURCE A COMPILER. CHAQUE LIGNE MANQUANTE A UNE VALEUR PAR
    ? * DEFAUT
    ? * CLE DE RECHERCHE :
    ? *    Compiler + ORDR + MBRE + LIB
    ? *    Compiler + ORDR        + LIB
    ? *    Compiler + ORDR + MBRE
    ? *    Compiler + ORDR
    ? * LA LIGNE Compiler EST SENSÉE INDIQUER LA COMMANDE DE COMPILATION
    ? * LA LIGNE T+LIB  EST SENSÉE REDIRIGER LA SORTIE (PF: ECOFICB, DSPF : &O)
    ? * LA LIGNE T+MEMBRE EST SENSÉE PRÉPARER L'ENVIRONNEMENT DE COMPILATION
    ? *    (CRTDUPOBJ SUR LES FICHIERS DE TRAVAIL POUR UN RPG,
    ? *     TAILLE DE PAGE POUR UN PRTF, ...)
    ? * LA LIGNE Compiler + MEMBRE + LIB TRAITE LES CAS PARTICULIERS
    ? * &1 = OPTION DE LA LIGNE Compiler
    ? * &1 = OPTION DE LA LIGNE Compiler + LIB
    ? * &1 = OPTION DE LA LIGNE Compiler + MBRE
    ? *
    ? *EXEMPLE :
    ? * Compiler MEMBRE BIB
    ? * PF 500      ECOPROT    &1 FILE(ECOFICT/&N)
    ? * PF 500      ECOPRO     &1 FILE(ECOFICB/&N)
    ? * PF 500                 CRTPF SRCFILE(&L/&F) REPLACE(&R)
    ? * PF 600      ECOPRO     CRTDUPOBJ &N ECOFICB *FILE ECOFICS
    ? *
    ? *POUR
    ? * PRENDRE EN COMPTE LES OPTIONS DU NIVEAU INFÉRIEUR
    ? *   LAISSER À BLANK
    ? * AJOUTER DES COMPLÉMENTS
    ? *   RÉCUPÉRER LES INFOS DU NIVEAU PRÉCÉDENT PAR &1 OU &2 OU &3
    ? * EFFACER LES OPTION PRECEDENTES SANS RIEN AJOUTER
    ? *
    ? * RESULTAT :
    ? * &S   &N      &F      &L       &O     &R
    ? * PF   STCR40P QDDSSRC ECOPROT
    ? * >> CRTPF SRCFILE(&L/&F) REPLACE(&R) FILE(ECOFICT/&N)
    ? * PF   STCR40P QDDSSRC ECOPRO
    ? * >> CRTPF SRCFILE(&L/&F) REPLACE(&R) FILE(ECOFICB/&N)
    ? *    ;CRTDUPOBJ &N ECOFICB *FILE ECOFICT
    ? *
    ? * procédé retenu :
    ? * lire en sequence tous les enregistrements de MAKEP pour la clé Compiler
    ? *   A rupture fin sur N° d'ordre, une commande est prête
    ? *   ====================================================
    ? * traiter uniquement les enregistrements qui correspondent à la clé
    ? * exemple
    ? * parametres :
    ? * PF                  MonFichier  ECOPRO
    ? * fichier MAKEP :
    ? * PF             10               ECOPRO      DLTF            traité
    ? * PF             10               ECOPROT     DLTF             ignoré    Commande
    ? * PF             20               ECOPRO      DLTFS           traité     Commande
    ? * PF            500                           COMPIL          traité
    ? * PF            500               ECOPRO      COMPIL          traité
    ? * PF            500               ECOPROT     COMPIL           ignoré    Commande
    ? * PF            600               ECOPRO      COMPILXS01      traité     Commande
    ? * PF            610               ECOPRO      COMPILXS02      traité     Commande
    ? * PF            900               ECOPRO      GRTAUT          traité     Commande
    ? * PF            910               ECOPRO      GRTAUT          traité     Commande
    ? * résultat
    ? *  10 dltf file(ecoficb/&N)
    ? *  20 dltf file(ecofics/&N)
    ? * 500 CRTPF SRCFILE(&L/&F) FILE(ecoficb/&N)
    ? * 600 chgenv xs
    ? * 610 CRTDUPOBJ &N ECOFICB *FILE ECOFICS
    ? * 900 GRTOBJAUT OBJ(ecoficb/&O) OBJTYPE(*FILE) USER(VOLVUSER) AUT(*ALL)
    ? * 910 GRTOBJAUT OBJ(ecofics/&O) OBJTYPE(*FILE) USER(VOLVUSER) AUT(*ALL)
    ? **********************************************************



     H   DEBUG
     H   DATEDIT(*YMD)


     FMAKEl2    IF   E           K DISK
    ? * VAR(&E) TYPE(*CHAR) LEN(4) /* EXECUTION PAR LOT (*YES *NO)
    ? * VAR(&F) TYPE(*CHAR) LEN(10)/* NOM DE FICHIER
    ? * VAR(&G) TYPE(*CHAR) LEN(10)/* BIB JOBD (ECRAN F18)
    ? * VAR(&H) TYPE(*CHAR) LEN(10)/* NOM JOBD (ECRAN F18)
    ? * VAR(&J) TYPE(*CHAR) LEN(21)/* JOBD (BIB/NOM) (ECRAN F18)
    ? * VAR(&L) TYPE(*CHAR) LEN(10)/* BIB ELEMENT
    ? * VAR(&N) TYPE(*CHAR) LEN(10)/* NOM ELEMENT
    ? * VAR(&O) TYPE(*CHAR) LEN(10)/* BIB OBJET (ECRAN F18)
    ? * VAR(&P) TYPE(*CHAR) LEN(4) /* COMPILATION PAR LOT (*YES *NO) (ECRAN F18)
    ? * VAR(&R) TYPE(*CHAR) LEN(4) /* REMPLACEMENT OBJET (*YES *NO) (ECRAN F18)
    ? * VAR(&S) TYPE(*CHAR) LEN(10)/* TYPE D'ELEMENT (SANS *)
    ? * VAR(&X) TYPE(*CHAR) LEN(50)/* TEXTE ELEMENT
    ? * VAR(&C) TYPE(*CHAR) LEN(4) /* CONFIRMER LA PILE DE COMMANDE
    ? * VAR(&Cmds) TYPE(*CHAR) LEN(9999) /* pile de commandes
     DMake5R           PR                  EXTPGM('MAKE5R')
     D  Confirmer                     4
     D  PileCommande               9999
     DPareil           PR             1N
     D  Enreg                        10    Const
     D  Param                        10    Const
     DMake2R           PR                                                       exemple
     D  ExecutionLot                  4                                         *NO               &E
     D  Fichier                      10                                         QCLSRC       FICS &F
     D  JobdLib                      10                                         *NULL             &G
     D  Jobd                         10                                         *USRPRF           &H
     D  JobdQual                     21                                         *USRPRF           &J
     D  MemberLib                    10                                         ECOLIB       LIBS &L
     D  Member                       10                                         MAKE         MBRE &N
     D  ObjectLib                    10                                         ECOLIB       LIBO &O
     d  IfsLink                     500
     D  CompilationB                  4                                         *YES              &P
     D  ReplaceObj                    4                                         *YES         REPL &R
     D  SType                        10                                         CLP               &S
     D  compiler                     10                                         CLP
     D  Texte                        50                                         'Compilation avec &X
     D  Confirmer                     4                                         *YES              &C
     D  PileCommande               9999
     DMake2R           PI
     D  ExecutionLot                  4
     D  Fichier                      10
     D  JobdLib                      10
     D  Jobd                         10
     D  JobdQual                     21
     D  MemberLib                    10
     D  Member                       10
     D  ObjectLib                    10
     d  IfsLink                     500
     D  CompilationB                  4
     D  ReplaceObj                    4
     D  SType                        10
     D  compiler                     10
     D  Texte                        50
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

     D Pos             S              5  0                                      RC de %scan
    ?
    ?

     D KCompiler       S                   like(MaType)
     D KOrdre          S                   like(MaOrdr)
     D dsply52         S             52

    ?
    ?
    ?
    ?

     d lcase           pr         32787    varying
     d  FromString                32787    varying const


     D regex_t         DS                  align
     D  re_nsub                      10I 0
     D  re_comp                        *
     D  re_cflags                    10I 0
     D  re_erroff                    10I 0
     D  re_len                       10I 0
     D  re_ucoll                     10I 0 dim(2)
     D  re_lsub                        *   DIM(9)
     D  re_esub                        *   DIM(9)
     D  re_map                      256A
     D  re_shift                      5I 0
     D  re_dbcs                       5I 0

     D regmatch_t      DS                  occurs(2) align
     D  rm_so                        10I 0
     D  rm_ss                         5I 0
     D  rm_eo                        10I 0

     D  rm_es                         5I 0

     D regcomp         PR            10I 0 extproc('regcomp')
     D   preg                          *   value
     D   pattern                       *   value
     D   cflags                      10I 0 value

     D regexec         PR            10I 0 extproc('regexec')
     D   preg                          *   value
     D   string                        *   value
     D   nmatch                      10U 0 value
     d   pmatch                        *   value
     D   eflags                      10I 0 value

     D regerror        PR            10U 0 extproc('regerror')
     D   errcode                     10I 0 value
     D   preg                          *   value
     D   errbuf                        *   value
     D   errbuf_size                 10I 0 value

     D regfree         PR                  extproc('regfree')
     D   preg                          *   value

     D EscapeMsg       PR
     D   peMsgTxt                   256A   Const
    ?

     d CompilerIsFound...
     d                 s               n
     d False           s               n   inz(*off)
     d True            s               n   inz(*on)







     C                   Eval      pPile = %Addr(PileCommande)
     C                   Eval      Pile = *BLANK
     C                   Eval      NbCde = 0

     C     kMAKE1        KLIST
     C                   KFLD                    Kordre
     C     kMAKE2        KLIST
     C                   KFLD                    Kordre
     C                   KFLD                    KCompiler

     C                   Eval      KCompiler = compiler
     c                   eval      Compilerisfound=false

     C     *loval        Setll     makel2
    ? *première boucle : traiter toutes les lignes
B01  C                   Do        *HiVal
     C                   read      makel2                                 30
B02  C                   if        *IN30 = *ON
     C                   Leave
E02  C                   Endif


    ? * le Compiler est géré, et on a le numéro d'ordre

     C                   Eval      KOrdre = Maordr
     C                   Eval      Commande  = *Blank
     C                   Eval      CdeMonMsg = *blank

     C     kMake1        Setll     makel2
    ? * deuxième boucle
    ? * traiter toutes les lignes du n° d'ordre
     C                   DO        *HIVAL

     C     kMake1        reade     makel2                                 30

     C                   if        *in30=*on
      *                  fin de no d'ordre=fin de commande
     C                   Leave
     C                   Endif



      * vérifier que la ligne est ciblée

B02  c                   if        not pareil(matype:Compiler)
     c                   iter
E02  c                   endif
     c                   eval      CompilerIsFound = true

B02  C                   If            pareil(MaMbre : Member)
     C                             and pareil(MaLib  : MemberLib)
    ? * traiter
X02  C                   Else
     C                   Iter
E02  C                   Endif
    ? * fin de pile provoquee
B02  C                   if        lcase(macmde)='thatsall'
     c                   eval      CdeTexte = *BLANK
     c                   eval      kordre=*hival
     C                   Leave
E02  C                   Endif
    ? * récupérer le début de la commande
     C                   Eval      Pos = %Scan('&1' : maCmde)
B02  C                   if        Pos > 0
     C                   Eval      MaCmde     = %Replace(%Trim(CdeTexte) :
     C                                                   MaCmde : Pos : 2)
E02  C                   EndIf
     C                   Eval      CdeTexte = MaCmde
B02  c                   if        MaMonm <> *blank
     C                   Eval      CdeMonMsg = MaMonm
E02  c                   EndIf
    ? * fin de la boucle à rupture sur N° d'ordre
E01  C                   Enddo
    ? * La ligne de commande est disponible, remplacer les paramètres par leur valeur

    ? * si le traitement a généré une commande ...
B01  C                   If        CdeTexte <> *BLANK

    ?C****************   Eval      CdeMonMsg = MaMonm

    ? *&E ExecutionLot
    ? *&F Fichier
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&F' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(Fichier)    :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&G JobdLib
    ? *&H Jobd
    ? *&J JobdQual
    ? *&L MemberLib
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&L' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(MemberLib)  :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&N Member
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&N' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(Member)     :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&O ObjectLib
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&O' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(ObjectLib)  :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&I IfsLink
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&I' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(IfsLink  )  :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&P CompilationB
    ? *&R ReplaceObj
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&R' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(ReplaceObj) :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&S Type
     C                   Eval      Pos = 1
B02  C                   Do        *HiVal
     C                   Eval      Pos = %Scan('&S' : CdeTexte)
B03  C                   if        Pos > 0
     C                   Eval      CdeTexte   = %Replace(%Trim(SType      ) :
     C                                                   CdeTexte   : Pos : 2)
X03  C                   Else
     C                   leave
E03  C                   EndIf
E02  C                   EndDo
    ? *&X Texte
    ? *&C Confirmer
    ? * doubler les quotes (execution par QCMDEXC)
    ?C*                  Eval      Pos = 1
    ?C*                  Do        *HiVal
    ?C*                  Eval      Pos = %Scan('''' : CdeTexte : Pos)
    ?C*                  if        Pos > 0
    ?C*                  Eval      CdeTexte   = %Replace(''''''     :
    ?C*                                                  CdeTexte   : Pos : 1)
    ?C*                  Eval      Pos = Pos + 2
    ?C*                  Else
    ?C*                  leave
    ?C*                  EndIf
    ?c*                  Enddo
B02  c                   if        CdeMonMsg = *blank
     C                   Eval      CdeMonMsg = 'ESCAPE'
E02  c                   endif
    ? * la commande est prête, empiler
     C                   Eval      NbCde = NbCde + 1
     C                   Eval      CdeLen = %Len(%Trim(CdeTexte))
     C                   Eval      UneCde(NbCde) = Commande
      * la commande est <>''
     c                   endif
    ? * fin de la boucle à rupture sur MAORDR, repositionner le read suivant
     C     kMake1        Setgt     makel2
    ?C*                  if        not(%Found(makel2))
    ?C*    kType         dsply
    ?C*    kOrdre        dsply
    ?C****************** EndIf
     c* ligne suivante
E00  C                   EndDo
     c                   if        CompilerIsFound = false
    ?C                   eval      Compiler='UNKNOWN'
     c                   goto      fin
     c                   endif
    ? * confirmation de pile de commandes
B01  c                   if        confirmer='*YES'
     c                   Callp     Make5r(confirmer : PileCommande)
E01  c                   endif
    ? *
     C     FIN           TAG
     C                   SETON                                        LR
    ? *=--------------------------------------------------------------------=*
BPR ?P Pareil          B
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

    ? *c****test********** return    *off
    ? *c                   eval      string = data + x'00'
    ? *c
    ? *c                   eval      pattern = filtre
    ? *c                   eval      pos=1
    ? *c                   do        *hival
    ? *c                   eval      pos=%scan('*' : pattern :pos )
    ? *c                   if        pos = 0
    ? *c                   leave
    ? *c                   endif
    ? *c                   eval      pattern = %replace('.*':pattern:pos:1)
    ? *c                   eval      pos+=2
    ? *c                   enddo
    ? *c                   eval      pattern = %trim(pattern) + ' *$' + x'00'
    ? *
    ? *c* Initialize pointers
    ? *c     1             occur     regmatch_t
    ? *c                   eval      preg = %addr(regex_t)
    ? *c                   eval      pmatch = %addr(regmatch_t)
    ? *
    ? *C* Compile RE
    ? *c                   eval      rc=regcomp(preg:%addr(pattern):0)
    ? *c                   if        rc <> 0
    ? *c                   callp     regerror(rc: preg: %addr(buf): 256)
    ? *c                   callp     regerror(rc: preg: %addr(buf): 256)
    ? *c                   callp     EscapeMsg('regcomp() failed with: ' +
    ? *c                               %str(%addr(buf)))
    ? *c                   endif
    ? *
    ? *C* Execute RE
    ? *c                   eval      rc = regexec(preg: %addr(string):
    ? *c                                0     : pmatch: 0)
    ? *c                   callp     regfree(preg)
    ? *c                   if        rc <> 0
    ? *c                   return    *off
    ? *c                   else
    ? *c                   return    *on
    ? *c                   endif




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

EPR  P                 E

BPR ?p lcase           b
     d lcase           pi         32787    varying
     d  FromString                32787    varying const
    ? * table des minuscules
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
    ? * table des majuscules
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   return    %xlate(up:lo:fromString)
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
EPR  p lcase           e



BPR ?P EscapeMsg       B
     D EscapeMsg       PI
     D   peMsgTxt                   256A   Const

     D SndPgmMsg       PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                    1A

     D dsEC            DS
     D  dsECBytesP             1      4I 0 inz(256)
     D  dsECBytesA             5      8I 0 inz(0)
     D  dsECMsgID              9     15
     D  dsECReserv            16     16
     D  dsECMsgDta            17    256

     D wkMsgLen        S             10I 0
     D wkTheKey        S              4A

     c     ' '           checkr    peMsgTxt      wkMsgLen
B01  c                   if        wkMsgLen<1
     c                   return
E01  c                   endif

     c                   callp     SndPgmMsg('CPF9898': 'QCPFMSG   *LIBL':
     c                               peMsgTxt: wkMsgLen: '*ESCAPE':
     c                               '*PGMBDY': 1: wkTheKey: dsEC)

     c                   return
EPR  P                 E

