

      * fichier de messages pour les spoules : qsys2924/QRPG2MSG QRPG3MSG ... ?
      * le spoule de base de crtrpgle est qsys/qsysprt. Pas de format à détourner vers un PF







      /define INFDS
      /define lowercase
      /define SQL
     H COPYRIGHT('author is jean-paul Lamontre ')
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')


     fqspldta   if   f  382        disk    infsr(*pssr)
     fIndDicp   o    e             disk
     f

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d texte           s            378    varying
     d startedVar      s               n
     d startedVoc      s               n
     d startedCode     s               n
     d WaitDef         s               n
     d pos             s              5i 0
     d len             s              5i 0
     d recno           s              5i 0
     d q               ds                  qualified
     d zone                          40    dim(10) varying



     d qualif          pr           120    varying
     d   zone                        40    varying const

     d D               ds           100    qualified based(pD)
    ? * .......DName+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++
    ? * 123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-
     d  f1                     1      7
     d  d                      8      8
     d  star                   9      9
     d  name                   9     23
     d              longname...
     d                         9     82
     d  e                     24     24
     d  t                     25     25
     d  ds                    26     27
     d  from                  28     34
     d  to                    35     41
     d  i                     42     42
     d  dc                    43     44
     d  f2                    45     45
     d  keyword               46     82
     d  comment               83    100
     d C               ds           100    qualified based(pC)
    ? * .......CL0N01Factor1+++++++Opcode&ExtFactor2+++++++Result++++++++Len++D+HiLoEq....Comments
      * .......CL0N01Factor1+++++++Opcode&ExtExtended-factor2+++++++++++++++++++++++++++++Comments++
    ? * 123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-
     d  f1                     1      7
     d  c                      8      8
     d  factor1               14     27
     d  opcode                28     37
     d  factor2               38     51
     d  result                52     65
     d  free                   9     82
     d  comment               83    100
     d TheName         s             40    varying

     d i               s              5i 0

     d IndDicr         pr
     d   programme                   10

     d IndDicr         pi
     d   programme                   10



     iqspldta   aa
     i                                  1  382  splfdta
     i                                  1    3  skip
     i                                  4    4  spaceline
     i                                  5  382  data
      /free
       EXEC SQL
          Set Option Commit = *NONE
          , CloSQLCsr = *ENDACTGRP
          , DatFmt = *ISO
          , TimFmt = *ISO
          , Naming = *SYS
          , SqlPath= *LIBL
          , RDBCNNMTH=*DUW ;
       exec sql
          delete from IndDicp where pgmnam = : programme;
B01    if sqlcod<>0;
          diagsqler (sqlcod:sqlerm);
E01    endif;
       pD = %addr(data) ;
       pC = %addr(data) ;
       startedVar = false; // partie XREF
       startedVoc = false; // cartes D et P
       startedcode= false; // cartes C et free
       recno = 0;
       pgmnam = programme;
B01    for ever;
          read qspldta;
B02       if %eof;
             leave;
E02       endif;
          recno+=1;
          // *...+....1....+....2....+....3
          //       Global Field References:
B02       if  %subst(data :01:30)='      Global Field References:';
             startedVar = true;
             startedVoc =false;
             startedcode=false;
             proc = 'globales';
             iter;
E02       endif;
          // *...+....1....+....2....+....3....+....4....+....5....+
          //                           S o u r c e   L i s t i n g
          //?                      123456789012345678901234567
          //                       S o u r c e   L i s t i n g
B02       if  %subst(data :27:27)='S o u r c e   L i s t i n g' ;
             startedVoc = true;
             proc = 'voc-global';
             iter;
E02       endif;

          // *...+....1....+....2....+....3....+....4....+....5....+..
          //        * * * * *   E N D   O F   S O U R C E   * * * * *
          //?                      123456789012345678901234567
          //                       E N D   O F   S O U R C E
B02       if  %subst(data :27:25)='E N D   O F   S O U R C E' ;
             startedcode=false;
             iter;
E02       endif;


B02       if lcase(d.name)='/free';
             startedVoc =false;
             startedcode=true ;
             iter;
E02       endif;
B02       if lcase(d.name)='/end-free';
             startedVoc =true ;
             startedcode=true ;
             iter;
E02       endif;
B02       if lcase(d.d)='c';
             startedVoc =false;
             startedcode=true ;
E02       endif;
B02       if d.star    ='/'; // compilation instruction
             iter;
E02       endif;

          // *...+....1....+....2....+....3....+....4....+....5...
          //  5722WDS V5R4M0  060210 RN        IBM ILE RPG
          // Line   <---------------------- Source Specifications
          // Number ....1....+....2....+....3....+....4....+....5.
B02       if %subst(data :1:8)=' 5722WDS'
B02       or %subst(data :1:8)='Line   <'
B02       or %subst(data :1:8)='Number .';
             iter;
E02       endif;

B02       // if not startedVar
X..       if     not startedVoc
X..          and not startedcode;
             iter;
E02       endif;

          //?DName+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++
          //?DName++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //?..1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7 ...+... 8
B02       if startedVoc;
B03          if d.d = 'D' or d.d='d'
X..             or d.d = 'P' or d.d='p';
B04             if d.name <> *blank and d.star<>'*';
                   //?longname ? last 3 chars='...'
                   len=%len(%trimr(d.longname));
B05                if %subst(d.longname:len-2:3)='...';//?trouvé un longname
                      thename=%trim(d.longname);
                      %len(thename)-=3;
X05                else;
                      thename=d.name;
E05                endif;
                   TheName=%trim(Thename);
                   def ='';
B05                if d.d = 'D' or d.d='d';
                      zone = thename;
E05                endif;
B05                if d.d = 'P' or d.d='p';
                      proc='voc-'+thename;
E05                endif;
                   if zone <> '';
                   write IndDicf;
                   endif;
                   zone='';
                   def='';
                   waitdef=false;
                   iter;
E04             endif ;
E03          endif ;
             iter;
E02       endif;
          // end voc

          if startedcode;
             // chercher les BEGSR
             if c.c  = 'C' or c.c = 'c';
                // fix
                if lcase(c.opcode) = 'begsr';
                      zone = %trim(c.factor1);
                   write IndDicf;
                   zone='';
                   def='';
                   waitdef=false;
                   iter;
                endif;
             else;
                // free
                // cadrer à gauche, trouver le premier mot
                c.free = %trim(c.free);
                  i =%scan(' ':c.free);
                  if i > 0;
                     thename = lcase(%subst(c.free:1:i-1));
                     if thename = 'begsr';
                        thename = %trim(%subst(c.free:i));
                        // enlever le ;
                        %len(thename)-=1;
                           zone = thename;
                        write IndDicf;
                        zone='';
                        def='';
                        waitdef=false;
                        iter;
                     endif;
                  endif;
             endif;
             iter;
          endif;

          // var ?
          // *...+....1....+....2....+....3....+....4
          //          Field             Attributes
          //          123456789012345678901234567890
B02       if  %subst(data :10:30)='Field             Attributes  ';
             iter;
E02       endif;
B02       if data =*blank;
             iter;
E02       endif;
B02       if %subst(data :1:8)='*RNF7031';
             iter;
E02       endif;
          texte = %trimr(data);
B02       if %len(texte) < 29;
             iter;
E02       endif;
          // *...+....1....+....2....+....3....+....4....+....5
          //       Field References for subprocedure DIAGSQLER
          //      ?123456789-123456789-123456789-123456789-123456789-
B02       if  %subst(data :07:33)='Field References for subprocedure';
             proc = %subst(texte:41);
             iter;
E02       endif;
          //?123456789-123456789-123456789-123456789-123456789-
          //?         Zone              Attributs
          //?         *PSSR             BEGSR
          // *...+....1....+....2....+....3....+....4
          //          *PSSR             BEGSR
B02       if %subst(data :28:5)='BEGSR';
          // aucun interet, il est en majuscule ici
             iter;
E02       endif;
          //?         123456789-123456789-123456789-123456789-123456789-
          // *...+....1....+....2....+....3....+....4
          //          No references in the source.
B02       if %subst(data :10:27)='No references in the source';
             iter;
E02       endif;
          //?123456789-123456789-123456789-123456789-123456789-
          //?* * * * *   F I N   D E S   R E F E R E N C E S   C R O I S E E S  * * * * *
          // *...+....1....+....2....+....3....+....4....+....5....+....6....+....7....+
          //        * * * * *   E N D   O F   C R O S S   R E F E R E N C E   * * * * *
          //?                   123456789-123456789-123456789-123456789-123456789-
B02       if %subst(data :20:43)='E N D   O F   C R O S S   R E F E R E N C E';
             leave;
E02       endif;
          // *...+....1....+....2....+....3....+.
          //            PROGRAMLASTFILELIBRARY...
          //?.          PROGRAMLASTFILELIBRARY...
          pos=%len(texte)-2;
B02       if %subst(texte:pos:3)='...';
             waitdef=true;
             zone=%subst(texte:10:pos-10);
             iter;
E02       endif;

B02       if %subst(texte:10:18)<>*blank ;
             zone = %trimr(%subst(texte:10:18));
          // zone=qualif(zone);
             zone = %trim(zone);
             def = %subst(texte:28);
          // write IndDicf;   c'est en majuscules ca !
             zone='';
             def='';
             waitdef=false;
             iter;
E02       endif;


B02       if %subst(texte:10:18)=*blank and not waitdef;
             iter;
E02       endif;
          //?.                          A(10)
B02       if %subst(texte:10:18)=*blank and waitdef;
             waitdef=false;
             def = %subst(texte:28);
          // zone=qualif(zone);
             zone = %trim(zone);
          // write IndDicf;   majuscules !
             zone='';
             def='';
E02       endif;


E01    endfor;

       exec sql
          delete from IndDicp where pgmnam = : programme
          and def='PROTOTYPE'
          ;
B01    if sqlcod<>0;
          diagsqler (sqlcod:sqlerm);
E01    endif;
       *inlr = *on;
       return;
      /end-free


      /define PROCEDURE_SECTION
      /include jpltools,JP4inc













BPR ?p qualif          b
     d qualif          pi           120    varying
     d   zone                        40    varying const
     d qzone           s            120    varying
      /free
       qzone = zone;
B01    select ;
X01       when %len(zone) > 10
X..          and  %subst(zone:1:10)=*blank;//?niveau 6
             q.zone(6) = %trim(zone);
             qzone=q.zone(1)+'.'+
                q.zone(2)+'.'+
                q.zone(3)+'.'+
                q.zone(4)+'.'+
                q.zone(5)+'.'+
                q.zone(6);
X01       when %len(zone) > 8
X..          and  %subst(zone:1: 8)=*blank;//?niveau 5
             q.zone(6) = '';
             q.zone(5) = %trim(zone);
             qzone=q.zone(1)+'.'+
                q.zone(2)+'.'+
                q.zone(3)+'.'+
                q.zone(4)+'.'+
                q.zone(5);
X01       when %len(zone) > 6
X..          and  %subst(zone:1: 6)=*blank;//?niveau 4
             q.zone(6) = '';
             q.zone(5) = '';
             q.zone(4) = %trim(zone);
             qzone=q.zone(1)+'.'+
                q.zone(2)+'.'+
                q.zone(3)+'.'+
                q.zone(4);
X01       when %len(zone) > 4
X..          and  %subst(zone:1: 4)=*blank;//?niveau 3
             q.zone(6) = '';
             q.zone(5) = '';
             q.zone(4) = '';
             q.zone(3) = %trim(zone);
             qzone=q.zone(1)+'.'+
                q.zone(2)+'.'+
                q.zone(3);
X01       when %len(zone) > 2
X..          and  %subst(zone:1: 2)=*blank;//?niveau 2
             q.zone(6) = '';
             q.zone(5) = '';
             q.zone(4) = '';
             q.zone(3) = '';
             q.zone(2) = %trim(zone);
             qzone=q.zone(1)+'.'+
                q.zone(2);
X01       when %len(zone) > 1
X..          and  %subst(zone:1: 1)<>*blank;//?niveau 1
             q.zone(6) = '';
             q.zone(5) = '';
             q.zone(4) = '';
             q.zone(3) = '';
             q.zone(2) = '';
             q.zone(1) = %trim(zone);
             qzone=q.zone(1);

E01    endsl;

       return qzone;




      /end-free
    ?c*=------------------------------------------------------------------------
B00  C     *PSSR         BEGSR
     C                   DUMP
E00  C                   ENDSR
    ?C*=------------------------------------------------------------------------
EPR  p                 e


