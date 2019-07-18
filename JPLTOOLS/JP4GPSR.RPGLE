    ?
    ?
    ?
    ?
    ? *=------------------------------------------------------------------------------------------=*
    ? *
    ? *  If you need to change anything in this code, feed back !
    ? *  so, I will take care of the update in next version
    ? *
    ? *=------------------------------------------------------------------------------------------=*
     p ChkObj          b                   export
     d ChkObj          pi              n                                        true=object exists
     d   ObjName                     20    const                                x10 name + x10 lib
     d   ObjType                     10    const
     d   ech                               likeds(errorcodehandler)

      /free
         ech.available=0;

             //?check object exists
         qusrObjD( OBJD0200
             : 8
             : 'OBJD0100'
             : ObjName
             : ObjType
             : Ech
             );
          if ech.available>0;
          return false;
          else;
       return true;
       endif;
       begsr *pssr;
          if NeedDump;
             dumpcallstack();
             needdump=false;
          endif;
       endsr;
      /end-free
     p                 e


     p ChkMbr          b                   export
     d ChkMbr          pi              n
     d   MbrName                     30    const                                file + lib + mbr
     d   ech                               likeds(errorcodehandler)

      /free

         ech.available=0;
             //?check object exists
         qusrmbrD( mbrd0100
             : 8
             : 'MBRD0100'
             : MbrName
             : %subst(MbrName:21:10)
             : '0'  // no override processing
             : Ech
             );
          if ech.available>0;
          return false;
          else;
       return true;
       endif;
       begsr *pssr;
          if NeedDump;
             dumpcallstack();
             needdump=false;
          endif;
       endsr;
      /end-free
     p                 e


     p chgobjatr       b                   export
     d chgobjatr       pi              n
     d   OBJ                         20    const
     d   OBJTYPE                     10    const
     d   ech                               likeds(errorcodehandler)
     d   KEY01                       30    const
     d   KEY02                       13    const
     d   KEY03                       13    const
     d   KEY04                        8    const
     d   KEY05                       13    const
     d   KEY06                        7    const
     d   KEY07                        6    const
     d   KEY08                        5    const
     d   KEY09                       10    const
     d   KEY10                       50    const
     d   KEY11                        5    const
     d   KEY12                        5    const
     d   KEY13                        5    const
     d   KEY14                        4    const
     d   KEY15                        5    const
     d   KEY16                        5    const
     d   KEY17                       10    const
       // COMPTAGE DES CLES UTILISEES */
     d KEYCOUNT        s              2p 0

       //* CHAINE 'CHANGED OBJECT INFORMATION'*/
     d COBJD           s            316
       //* POINTEUR D'ECRITURE DANS &COBJD  */
     d attr            ds            58    based(pAttr  )  qualified
     d  key                          10i 0
     d  len                          10i 0
     d  data                         50
       //* OBJET MODIFIE */


     d RETLIB          s             10




     D QLICOBJD        Pr                  ExtPgm( 'QLICOBJD' )
     d  RtnLibName                   10
     D  ObjName                      20    Const
     D  ObjType                      10    Const
     D  ChangedInfo                 316    Const
     D  Error                     32767a          Options( *VarSize )



      /free
       ech.available=0;
       //* RESERVER 4 OCTETS POUR LE NUMBER OF KEY USED */
          pAttr = %addr(CObjD);
       pAttr+= 4 ;
       //?*VERIFIER L'EXISTENCE DE L'OBJET CIBLÉ *
B01    if ChkObj (obj     : OBJTYPE:ech) = false;
          return false;
E01    endif;
       //?*  KEY TYPE FIEL
       //?*  1 CHAR(30) SOURCE FIL
B01    IF %subst(KEY01:1:1) <>  '=' ;
B02       if CHKmbr ( KEY01 : ech) = false;

             return false;
E02       endif;
          KEYCOUNT+=1;
          Attr.Key = 1;
          Attr.Len = 30;
          Attr.Data = key01;
          pAttr +=38;
E01    endif;
       //?*  2 CHAR(13) SOURCE FILE LAST CHANGED DATE AND TIM
B01    IF KEY02  <>  '=';
          KEYCOUNT +=1;
          Attr.Key=2;
          Attr.Len=13;
          Attr.Data=key02;
          pAttr += 21;
E01    ENDif;
       //?*  3 CHAR(13) COMPILE
B01    IF Key03 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=3;
          Attr.Len=13;
          Attr.Data=KEY03;
          pAttr +=21;
E01    ENDif;
       //?*  4 CHAR(8) OBJECT CONTROL LEVE
B01    IF Key04 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=4;
          Attr.Len=8;
          Attr.Data=KEY04;
          pAttr +=16;
E01    ENDif;
       //?*  5 CHAR(13) LICENSED PROGRA
B01    IF Key05 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=5;
          Attr.Len=13;
          Attr.Data=key05;
          pAttr +=21;
E01    ENDif;
       //?*  6 CHAR(7) PROGRAM TEMPORARY FIX (PTF
B01    IF Key06 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=6;
          Attr.Len=7;
          Attr.Data=key06;
          pAttr +=13;
E01    ENDif;
       //?*  7 CHAR(6) AUTHORIZED PROGRAM ANALYSIS REPORT (APAR
B01    IF Key07 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=7;
          Attr.Len=6;
          Attr.Data=KEY07;
          pAttr +=13;
E01    ENDif;
       //?*  8 CHAR(1) ALLOW CHANGE BY PROGRA
B01    IF Key08 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=8;
          Attr.Len=1;
          Attr.Data=KEY08;
          pAttr +=9;
E01    ENDif;
       //?*  9 CHAR(10) USER-DEFINED ATTRIBUT
B01    IF Key09 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=9;
          Attr.Len=10;
          Attr.Data=KEY09;
          pAttr +=18;
E01    ENDif;
       //?*  10 CHAR(50) TEX
B01    IF Key10 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=10;
          Attr.Len=50;
          Attr.Data=KEY10;
          pAttr +=58;
E01    ENDif;
       //?*  11 CHAR(1) DAYS USED COUN
B01    IF Key11 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=11;
          Attr.Len=1;
          Attr.Data=KEY11;
          pAttr +=9;
E01    ENDif;
       //?*  12 CHAR(4) PRODUCT OPTION LOAD I
B01    IF Key12 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=12;
          Attr.Len=4;
          Attr.Data=KEY12;
          pAttr +=12;
E01    ENDif;
       //?*  13 CHAR(4) PRODUCT OPTION I
B01    IF Key13 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=13;
          Attr.Len=4;
          Attr.Data=KEY13;
          pAttr +=12;
E01    ENDif;
       //?*  14 CHAR(4) COMPONENT I
B01    IF Key14 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=14;
          Attr.Len=4;
          Attr.Data=KEY14;
          pAttr +=4;
E01    ENDif;
       //?*  15 CHAR(1) LAST USED DAT
B01    IF Key15 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=15;
          Attr.Len=1;
          Attr.Data=KEY15;
          pAttr +=9;
E01    ENDif;
       //?*  16 CHAR(1) CHANGED DATE AND TIME STAM
B01    IF Key16 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=16;
          Attr.Len=1;
          Attr.Data=key16;
          pAttr +=9;
E01    ENDif;
       //?*  17 CHAR(10) MEMBER'S DAYS USED COUN
B01    IF Key17 <>  '=';
          KEYCOUNT +=1;
          Attr.Key=17;
          Attr.Len=10;
          Attr.Data=KEY17;
          pAttr +=18;
E01    ENDif;
       //?* KEY COUNT *
       pAttr=%addr(CObjd);
       attr.key=keycount;

       QLICOBJD (
          RETLIB//?1 ¦ RETURNED LIBRARY NAM
          : OBJ//?2 ¦ OBJECT & LIBRARY NAM
          : OBJTYPE//?3 ¦ OBJECT TYP
          : COBJD//?4 ¦ CHANGED OBJECT INFORMATIO
          : ECH//?5 ¦ ERROR COD
          );
B01    if ech.available > 0;

          return false;
E01    endif;
       ech.msgdta=%subst(OBJ:1:10) + RETLIB + OBJTYPE;
       ech.msgid='CPC2103' ;
       return true;
      /end-free
     p                 e






















































































