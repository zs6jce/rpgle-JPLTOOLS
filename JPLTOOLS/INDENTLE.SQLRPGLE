       //?comentaire
    ? * 2011-03-31
    ? * add INDDIC file, the dictionnary of RPG variables names
    ? * if field element of parameter CaseConv = *DICTIONARY, and file INDDIC exists,
    ? *   then this file is used to get the casing of variables.
    ? * This list of names is then completed by internal variable names
    ? * so the INDDIC file is an extention of the fields declared in the source code

    ? * 2010-01-30
    ? * never use casing when there is a continuation line in the code for a string
    ? * you may trigger a wrong upper/lower casing into a string
    ? * when strings are completely defined in one line of RPG, there is no issue.

    ? * 2010-01-22
    ? * add parms to uppercase or lowercase the code.
    ? * INDENTLE don't take care of continuation line. because it's very rare
    ? * but you can forbid it to do the job :
    ? * add this comment // no case update
    ? * just before the rpg-line that contains continuation text
    ? * action is valid up to the semicolon (;)


    ? * 2009-03-19
    ? * when code and string and comment
    ? * count quotes from left to right, if // is after an even number of quote, ok

    ? * 2009-03-18
    ? * when code and string and comment
    ? * search for comment by scanning Right to Left for either ' or //

    ? * 2009-03-10 fix bug when line has comment and code and a string

    ? * 2007-10-17 separate free sql from free rpg : avoid confusing SELECT, AND, ...
    ? *            option to no-indent sql with this syntax :
    ? *            exec sql // no sql indent
    ? *

    ? * compilation :
    ? * CRTSRCPF FILE(QTEMP/INDENTW) RCDLEN(112) TEXT('IndentLE temp src file')
    ? *
    ? * CRTRPGMOD MODULE(INDENTLE) SRCFILE(QPGMSRC)
    ? * OPTION(*NODEBUGIO *SRCSTMT *SECLVL) DBGVIEW(*SOURCE)
    ? *
    ? * CRTPGM PGM(INDENTLE) ACTGRP(*CALLER)
    ? *
    ? * Author is jean-paul Lamontre 2004
    ? * This file is part of my toolkit
    ? * this tool is a free software; you can redistribute it and/or
    ? * modify it as much as you need
    ? * This tool is distributed in the hope that it will be useful,
    ? * but WITHOUT ANY WARRANTY :
    ? *
    ? * THIS SOFTWARE IS PROVIDED ''AS IS'' AND ANY EXPRESSED OR IMPLIED
    ? * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    ? * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    ? * DISCLAIMED.  IN NO EVENT SHALL THE PROVIDER OR
    ? * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    ? * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    ? * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
    ? * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ? * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    ? * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
    ? * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
    ? * SUCH DAMAGE.

    ? **********************************************************************
    ? *
    ? * indentation of loops in RPG code
    ? *
     H COPYRIGHT('+
     H author is jean-paul Lamontre +
     H This module is part of my toolkit and is free software; you +
     H can redistribute it and/or modify it as much as you need')
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')

    ? **********************************************************************
    ? * take care of table loaded at compil time         (** at 1-2)
    ? * add    x'22' (=white) at 5 if 7=*
    ? * add at 1    'B' for  begin of loop   (if, do, select, ...)
    ? *             'X' for invert loop        (else, when, ...)
    ? *             'E' for end of loop
    ? * add at 2-3 the loop deepness
    ? * indente the free rpg lines
    ? * never investigate code line with string (at least one ')
    ? * add x'22' after // free-style comment
    ? * compress useless blanks in free-style
    ? **********************************************************************
     Findentw   uf   e           k disk    rename(indentw:indentp1)

     D PSDS           SDS           429
    ?d*                                    Program name (same as subfield location *PROGRAM)
     d SPNAME                        10A

    ? * table sample
     d ATable          s             70    dim(2) ctdata perrcd(1)
     d OpCode          s             20    dim(249) ctdata perrcd(1) ascend
     d OpCodePretty    s             20    dim(249) ALT(OpCode)


    ? * imbrication level
     d w_Xlevel        ds             2
     d w_Level                        2s 0 inz(*zero)
    ? * number of space to insert for indenting one level
     d IndentSize      s              2s 0 inz(3)
    ? * previous level, for ending indentation in free rpg
     d w_PrevLevel     s              2  0
    ? * data structure of the rpg card
     d SrcDta          ds           100
     d   w_Blank               1      5
     d   w_Z1                  1      1
     d   w_Table               1      2
     d   w_23                  2      3
     d   w_45                  4      5
     d   w_White               5      5
     d   w_Letter              6      6
     d   w_Star                7      7
     d   w_Procedure          24     24
     d   w_OpCode             26     35
     d   w_extended2          36     80
     d   DbgDta                1    100
    ? * 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
    ? * .....DName+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments
    ? * .....DName++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Comments++++
     d DCard           ds           100    based(pDCard) qualified
     d  d                      6      6
     d  star                   7      7
     d  LongName               7     80
     d  name                   7     21
     d  keywords              44     80











     d l_rpg           s            100                                         lower case rpg code
     d w_rpg           s            200                                         indentation working
     d space           s            100    inz(*blank)                          an empty string
     d pos             s              3i 0                                      position
     d beg             s              3i 0
     d len             s              3i 0
     d inWhen          s              3i 0 inz(*zero)                           indent when more
     d isBegOfCode     s               n                                        begin with an opcode
     d isEndOfCode     s               n                                        line ended by ;
     d isFirstWhen     s               n
     d startCode       s              5i 0
     d LenCode         s              5i 0
     d startComment    s              5i 0
     d LenComment      s              5i 0
     d LenIndent       s              5i 0
     d iFor            s              5i 0
     d rpgfree         s               n                                        in a free block
     d HasComment      s               n                                        comment after code
     d HasCode         s               n                                        free rpg inside
     d HasString       s               n                                        with at least one '
     d CommentSpacer   s              3    varying
     d l_opcode        ds            10                                         the operation code
     d w_o2                    1      2
     d w_o3                    1      3
     d w_o4                    1      4
     d w_o5                    1      5
     d w_o6                    1      6
     d w_o7                    1      7
     d w_o8                    1      8
     d w_o9                    1      9
     d w_o10                   1     10

    ? *

     d lcase           pr         32787    varying
     d  FromString                32787    varying const
     d ucase           pr         32787    varying
     d  FromString                32787    varying const
     d compress        pr           200    varying
     d  FromString                  200    varying const
     d  pos                           5i 0 const
     d  len                           5i 0 const
     d  PosCom                        5i 0
     d  HasComment                     n
     d  HasCode                        n
     d  HasString                      n
     d CamelCase       pr           200    varying
     d  FromString                  200    varying const
     d SplitCodeComment...
     d                 pr
     d  l_rpg                       100
     d  w_rpg                       200
     d  startCode                     5i 0
     d  LenCode                       5i 0
     d  startComment                  5i 0
     d  LenComment                    5i 0
     d HasComment                      n
     d HasCode                         n
     d HasString                       n
     d
     d
     d execsql         s               n   inz(*off)
     d sqlindent       s               n   inz(*on )
     d true            s               n   inz(*on )
     d false           s               n   inz(*off)
     d ever            s             10u 0
     d endpos          s              1

     d indentle        pr
     d  erase5                        1
     d  caseconv                           likeds(caseconv_t)
     d  pgmname                      10

     d indentle        pi
     d  erase5                        1
     d  caseconv                           likeds(caseconv_t)
     d  pgmname                      10

     d caseconv_t      ds                  based(template) qualified
     d  len                           2
     d  opcode                       11
     d  field                        11
     d  other                        11
     d CaseConvIng     s               n   inz(*off)
    ? * dynamic string to load the list of field names, CamelCased
     d DNames          s          65535    based ( pDNames )
     d DNamesLen       s             10i 0
     d DNamesPos       s             10i 0
    ? * a cursor for this list
     d DName           s            128    varying based(pDName)
     d v100            s            100    varying
     d Camelcase2      s               n
     d PosCom          s              5i 0
     d mysql           s           1000
     d FrameComment    s             20




    ?c*0N01Factor1+++++++Opcode&ExtFactor2+++++++Result++++++++Len++D+HiLoEq....Comments++++++++++++
    ?c*. 1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7 ...+... 8 ...+... 9 ...+... 0
    ? *
      /free
       *inlr=*on;

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl ;

       //?Sorta OpCode;
       CaseConvIng= (caseconv.OpCode <> '*NONE' Or
          caseconv.field <> '*NONE' Or
          caseconv.Other <> '*NONE');
       pDCard=%Addr(SrcDta);
       DNamesLen=65536 ;
       DNamesPos=0;
       pDNames = %Alloc(DNamesLen);

       //?use extended field vocabulary ?
B01    If caseconv.field = '*DICTIONARY';
          Exec Sql Declare C1 Cursor For
             Select Min(Zone) From Inddicp
             Where Pgmnam = : pgmname
             Group By Upper(Zone);
          Exec Sql Open C1;
B02       If Sqlcod = 0;
             //?alors on traite
B03          For ever;
                Exec Sql Fetch C1 Into : v100;
B04             If Sqlcod <> 0;
                   Leave;
E04             Endif;
                //?ajouter la zone au vocabulaire du programme
                //?auto expend list of Definition
B04             If DNamesPos + 128 > DNamesLen;
                   DNamesLen += 65536;
                   pDNames=%Realloc(pDNames:DNamesLen);
E04             Endif;
                pDName = pDNames + DNamesPos;
                DName = v100;   //?defined name, camelcase
                DNamesPos+=%Len(DName)+2;   //?varying
                pDName = pDNames + DNamesPos;
                DName = lcase(v100);   //?defined name, search key
                DNamesPos+=%Len(DName)+2;   //?varying

E03          Endfor;
             Exec Sql Close C1;
E02       Endif;
E01    Endif;
       isEndOfCode=*on;
       isBegOfCode=*on;
B01    For ever;
          Read Indentw;
B02       If %Eof();
             Leave;
E02       Endif;
B02       If w_Table = '**';
             //?table loaded at compil time, end of work
             Leave;
E02       Endif;
B02       If erase5='1' and w_z1 <> 'f'; // preserver fd fdx fc fcx de frame.valvar
             w_Blank = '';
E02       Endif;
          w_PrevLevel= w_Level;
B02       If w_PrevLevel < 0;
             w_PrevLevel = 0;
E02       Endif;
          //?for debugging : show input data
          Srcseq=Srcseq;
          Srcdat=Srcdat;
          DbgDta=DbgDta;
          l_rpg = lcase(SrcDta );
B02       Select ;
X02          When w_Star = '*';
                //?comment ? white
                rpgfree = *off ;
                w_Blank = *blanks ;
                w_White = X'22' ;
                Update Indentp1;
                w_White = *blanks ;
X02          When lcase(w_Letter) = 'd';


                //? D card

                //?auto expend list of Definition
B03             If DNamesPos + 128 > DNamesLen;
                   DNamesLen += 65536;
                   pDNames=%Realloc(pDNames:DNamesLen);
E03             Endif;
                //?position the cursor where to write into the list
                v100 = %Trimr(DCard.LongName);
B03             If v100 <> '';
B04                If %Len(v100) >=3 And
                         %Subst(v100:%Len(v100)-2:3)='...';
                      //?it's a long name.
                      v100 = %Trim(%Subst(v100:1:%Len(v100)-3));
                      pDName = pDNames + DNamesPos;
                      DName = v100;   //?defined name, camelcase
                      DNamesPos+=%Len(DName)+2;   //?varying
                      pDName = pDNames + DNamesPos;
                      DName = lcase(v100);   //?defined name, search key
                      DNamesPos+=%Len(DName)+2;   //?varying
X04                Else;   //?short name and keyword
B05                   If DCard.name <> '';
                         //?it's a short name
                         pDName = pDNames + DNamesPos;
                         DName = %Trim(DCard.name);
                         DNamesPos+=%Len(DName)+2;   //?varying
                         pDName = pDNames + DNamesPos;
                         DName = lcase(%Trim(DCard.name));
                         DNamesPos+=%Len(DName)+2;   //?varying
E05                   Endif;
                      //?and the pointers declared in a "based" keyword
B05                   Dou true;   //?one time;
                         v100=lcase(DCard.keywords);
                         pos=%Scan('based':v100);
B06                      If pos = 0;
                            Leave;
E06                      Endif;
                         pos=%Scan('(':v100:pos+5);
B06                      If pos = 0;
                            Leave;
E06                      Endif;
                         beg=%Check(' ':v100:pos+1);
B06                      If beg = 0;
                            Leave;
E06                      Endif;
                         pos=%Scan(')':v100:beg );
B06                      If pos = 0;
                            Leave;
E06                      Endif;
                         len = %Len(%Trimr(%Subst(v100:beg:pos-beg)));
                         pDName = pDNames + DNamesPos;
                         DName = %Subst(DCard.keywords:beg:len);
                         DNamesPos+=%Len(DName)+2;   //?varying
                         pDName = pDNames + DNamesPos;
                         DName = lcase(%Subst(DCard.keywords:beg:len));
                         DNamesPos+=%Len(DName)+2;   //?varying
E05                   Enddo;
E04                Endif;
E03             Endif;
                Update Indentp1;   //?erase5 !



X02          When lcase(w_Letter) = 'c' And w_Star = '+';
                //? SQL card, nothing to do
                rpgfree = *off ;
                w_Blank = *blanks ;
                Update Indentp1;
X02          When lcase(w_Letter) = 'c';


                //? C card


                rpgfree = *off ;
                l_opcode = lcase(w_OpCode) ;
B03             Select ;
                   //?begin C card
X03                When w_o6 = 'begsr ';
                      //? sub-routine
                      w_Level = 0 ; // zero to get compiler numbering equal to indentle numbering
                      w_Z1 = 'B' ;
                      w_23 = w_Xlevel;
X03                When w_o2 ='do'
                         //? loop   do, if, select
X03                Or w_o2 ='if'
X03                Or w_o3 ='for'
X03                Or w_o7 ='monitor'
X03                Or w_o6 ='select' ;
                      w_Level = w_Level + 1 ;
                      w_Z1 = 'B' ;
                      w_23 = w_Xlevel ;
X03                When w_o3 = 'and'
                         //? continuation condition
X03                Or w_o2 = 'or';
                      w_Z1 = 'X' ;
                      w_23 = '..' ;
X03                When w_o5 = 'else'
X03                Or w_o8 = 'on-error'
X03                Or w_o7 = 'elseif'
X03                Or w_o5 = 'other'
X03                Or w_o4 = 'when' ;
                      //?else, when, other
                      w_Z1 = 'X' ;
                      w_23 = w_Xlevel;
X03                When w_o3 = 'cas';
                      //?cas
X03                When w_o3 = 'end' ;
                      //?end
                      w_Z1 = 'E';
                      w_23= w_Xlevel;
                      w_Level = w_Level - 1 ;
B04                   If w_Level < 0 ;
                         w_Level = *zeros ;
E04                   Endif ;
                      //?indentation negative : immediatly
                      w_PrevLevel = w_Level ;
X03                When %Subst(SrcDta: 7 : 5) = '/free' ;
                      //?start free
                      rpgfree = *on ;
                      w_Z1 = *blanks ;
                      w_23 = *blanks ;
X03                When %Trim(%Subst(l_rpg:7)) = '/end-free';
                      //?end free
                      rpgfree = *off ;
                      w_Z1 = *blanks ;
                      w_23 = *blanks ;
X03                Other ;
                      //?simple C card
                      w_Z1 = *blanks ;
                      w_23 = *blanks ;
E03             Endsl ;
                //?mise en camelcase de la ligne
                //?selon le format, cibler
      /end-free
    ? *. 1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7 ...+... 8 ...+... 9 ...+... 0
    ?c*0N01Factor1+++++++Opcode&ExtFactor2+++++++Result++++++++Len++D+HiLoEq....Comments+++++++++++
    ?c*0N01Factor1+++++++EVAL      Extended-factor2+++++++++++++++++++++++++++++Comments+++++++++++
      /free
                //?le facteur 1
                SrcDta=compress(SrcDta:12:14:
                   PosCom:HasComment:HasCode:HasString);
                //?le opcode
                SrcDta=compress(SrcDta:26:10:
                   PosCom:HasComment:HasCode:HasString);



                //?ces OpCode sont des OpCode avec extended factor 2
                //?  callp dow elseif eval evalr eval-corr for if on-error return sorta
                //?  when xml-into xml-sax
                //?continuation : si le dernier caractère d'une ligne
                //?   en format extended est un moins (-)
               //?  alors la ligne continue sur la ligne suivante. Dans ce cas, ne pas faire la mise
                //?  en camelcase du factor 2, c'est trop tordu de
                //?     distinguer les strings des variables.
                //?  stopper le CamelCase2 jusqu'au prochain OpCode <> '';
B03             If w_o10 = 'callp     '
X03             Or w_o10 = '          '
X03             Or w_o10 = 'dow       '
X03             Or w_o10 = 'elseif    '
X03             Or w_o10 = 'eval      '
X03             Or w_o10 = 'evalr     '
X03             Or w_o10 = 'eval-corr '
X03             Or w_o10 = 'for       '
X03             Or w_o10 = 'if        '
X03             Or w_o10 = 'on-error  '
X03             Or w_o10 = 'return    '
X03             Or w_o10 = 'sorta     '
X03             Or w_o10 = 'when      '
X03             Or w_o10 = 'xml-into  '
X03             Or w_o10 = 'xml-sax   ';
                   Camelcase2 = true;
                   v100 = %Trim(w_extended2);
B04                If %Len(v100) > 1;
B05                   If %Subst(v100:%Len(v100):1)='-';
                         Camelcase2=false;
E05                   Endif;
E04                Endif;
B04                If Camelcase2;
                      //?le facteur 2 etendu
                      SrcDta=compress(SrcDta:36:45:
                         PosCom:HasComment:HasCode:HasString);
E04                Endif;
X03             Else;
                   //?le facteur 2 court
                   SrcDta=compress(SrcDta:36:14:
                      PosCom:HasComment:HasCode:HasString);
                   //?le facteur resultat
                   SrcDta=compress(SrcDta:50:14:
                      PosCom:HasComment:HasCode:HasString);
E03             Endif;
                Update Indentp1 ;
                //? end of a C card
X02          When lcase(w_Letter) = ' ' ;


                //?rpg Free (physicaly it is not a C card      )
                rpgfree = *on ;

                //?cas du commentaire en 80-100, sans double slash devant
B03             If %Subst(SrcDta :7:73)='';
B04                If %Subst(SrcDta :80)<>'';
                      %Subst(SrcDta : 8:2)='//';
E04                Endif;
E03             Endif;

                if %subst(srcdta:81:6)='// f/*';
                   framecomment = %subst(srcdta:81:20);
                   %subst(srcdta:81:20)='';
                else;
                framecomment = '';
                endif;







                //?w_rpg = code rpg to preserve (with upper case)
                w_rpg = %Trim(%Subst(SrcDta : 6));
                //?l_rpg = code rpg in lowercase (cols 6 to 100)
                l_rpg = lcase(w_rpg);
B03             Dou true;   //?permit using leave instead of goto
B04                If %Subst(l_rpg : 1 : 5) = '/free' ;
                      //?begin free
                      rpgfree = *on ;
                      isEndOfCode=*on;
                      isBegOfCode=*on;
                      Leave ;   //?don't touch compiler directive
E04                Endif ;
B04                If %Subst(l_rpg:1:7) = '/end-free';   //?end mode rpgfree
                      rpgfree = *off ;
                      Leave ;
E04                Endif ;
B04                If %Subst(l_rpg : 1 : 1) = '/'
X..                   And %Subst(l_rpg : 2 : 1) <>' '
X..                   And %Subst(l_rpg : 2 : 1) <>'/' ;
                      //?compilation directive (/copy, ... but not //)
                      Leave ;
E04                Endif ;
B04                If rpgfree ;
                      //?free running
                      //?w_z1 = '.' ;
                      //?w_23 = w_xlevel;
                      //?comment
                      //?working with comment : add the white attribute if possible
                      //?l_rpg = code rpg in lowercase (cols 6 to 100)
                      l_rpg = lcase(w_rpg);
                      SplitCodeComment(
                         l_rpg : w_rpg
                         :startCode
                         :LenCode
                         :startComment
                         :LenComment
                         :HasComment
                         :HasCode
                         :HasString
                         );
B05                   If HasComment;
                         //?comment : add x'22' after    //
B06                      If %Subst(l_rpg :startComment: 3) = '//' + X'22';
                            //?already done, just indent
X06                      Else ;
                            //?insert the white attribute
B07                         If %Subst(l_rpg :startComment: 3) = '// ' ;
                               //? space available, uses it
                               w_rpg = %Subst(w_rpg:1:startComment+1)
                                  + X'22' + %Subst(w_rpg :startComment+3) ;
X07                         Else ;
                               //?insert space between // and comment text
                               w_rpg = %Subst(w_rpg:1:startComment+1)
                                  + X'22' + %Subst(w_rpg : startComment+2);
                               LenComment+=1;
E07                         Endif;
E06                      Endif;
                         pos = %Scan('no case update' : l_rpg ) ;
B06                      If pos > 0 ;
                            CaseConvIng =false;
E06                      Endif ;
E05                   Endif ;   //?has comment
                      //?has code ? if yes, calculate new indentation level
B05                   If HasCode;
                         //?rpg code : calculate indentation
                         //?find the first space
                         //?opcode = the first word
                         pos = %Scan(' ' : l_rpg ) ;
                         l_opcode = %Subst(l_rpg : 1 : pos) ;
                         //?opcode : without ;
                         pos = %Scan(';' : l_opcode) ;
B06                      If pos > 0 ;
                            l_opcode = %Replace(' ' : l_opcode :pos : 1) ;
E06                      Endif ;
B06                      If l_opcode = 'exec';
                            isEndOfCode=*off;
                            isBegOfCode=*on;
                            execsql=true;
                            sqlindent=true;
                            pos = %Scan('no sql indent' : l_rpg ) ;
B07                         If pos > 0 ;
                               sqlindent=false;
E07                         Endif ;
E06                      Endif;
B06                      If execsql=false;
B07                         Select ;
X07                            When w_o6 = 'begsr ' ;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
                                  //?sub routine
                                  w_Level = 0 ; // zero to get compiler numbering equal to indentle numbering
                                  w_Z1 = 'B' ;
                                  w_23 = w_Xlevel;
X07                            When w_o3 ='do '
X07                            Or w_o4 ='dou '
X07                            Or w_o4 ='dow '
X07                            Or w_o3 ='if '
X07                            Or w_o7 ='monitor'
X07                            Or w_o4 ='for ';
                                  //?loop   do, if, for
                                  w_Level = w_Level + 1 ;
                                  w_Z1 = 'B' ;
                                  w_23 = w_Xlevel;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
B08                               If 1=2   //?test elseif
X08                               Or 1=2;   //?test or
                                     w_Star =w_Star;
X08                               Elseif 2=3;   //?test elseif
                                     w_Star =w_Star;
X08                               Else ;   //?test else
                                     w_Star =w_Star;
E08                               Endif;
X07                            When w_o7 ='select ' ;
                                  //?loop   select
                                  w_Level = w_Level + 1 ;
                                  w_Z1 = 'B' ;
                                  w_23 = w_Xlevel;
                                  isFirstWhen = *on;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
X07                            When w_o4 = 'and ' ;
                                  //?continuation condition
                                  w_Z1 = 'X' ;
                                  w_23 = '..' ;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
X07                            When w_o5 = 'else '
X07                            Or w_o3 = 'or '
X07                            Or w_o7 ='elseif '
X07                            Or w_o8 = 'on-error';
                                  //?else
                                  w_Z1 = 'X' ;
                                  w_23 = w_Xlevel;
                                  w_PrevLevel = w_Level-1;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
X07                            When w_o5 = 'when '
X07                            Or w_o6 = 'other ';
                                  //?when, other
B08                               If isFirstWhen;
                                     inWhen = inWhen + 1 ;
                                     isFirstWhen=*off;
E08                               Endif;
                                  w_PrevLevel = w_Level-1;
                                  w_Z1 = 'X' ;
                                  w_23 = w_Xlevel;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
X07                            When w_o5 = 'enddo'
X07                            Or w_o6 = 'endfor'
X07                            Or w_o5 = 'endif'
X07                            Or w_o6 = 'endmon'
X07                            Or w_o5 = 'endsr'
X07                            Or w_o5 = 'endsl';
                                  //?end
                                  endpos = endpos;   //?debug de indentle
B08                               If w_o5 = 'endsl' ;
                                     inWhen = inWhen - 1 ;
E08                               Endif ;
                                  w_Z1 = 'E' ;
                                  w_23 = w_Xlevel;
                                  w_Level = w_Level - 1 ;
B08                               If w_Level < 0 ;
                                     w_Level = *zeros ;
E08                               Endif ;
                                  //?indentation negative : immediatly
                                  w_PrevLevel = w_Level ;
                                  isEndOfCode=*off;
                                  isBegOfCode=*on;
E07                         Endsl ;
E06                      Endif ;
E05                   Endif ;
                      //?indent rpg
                      //?indent spacing before code
                      LenIndent = (w_PrevLevel + inWhen ) * IndentSize;
B05                   If LenIndent < 0;
                         LenIndent = 0;
E05                   Endif;
                      //?RPG comment must stay between 8 and 100 (ie 1 to 93 + indent code)
                      //?RPG code must stay between 8 and 80 (ie 1 to 73 + indent code)
                      //?if has code, determine if the RPG line is ended (with a ;)
B05                   If HasCode;
B06                      If %Subst(w_rpg:startCode+LenCode-1:1)=';';
                            //?line terminated by a ;
                            isEndOfCode=*on;
                            execsql=false;
                            sqlindent=true;
                            CaseConvIng= (caseconv.OpCode <> '*NONE'
X06                      Or caseconv.field <> '*NONE'
X06                      Or caseconv.Other <> '*NONE');
X06                      Else ;
                            //?line not terminated by a ;
                            //?if hasString;
                            //?   isEndOfCode=*on ;
                            //?else ;
                            isEndOfCode=*off;
                            //?endif;
E06                      Endif;
E05                   Endif;
                      //?correct indent space if splitted line
B05                   If isBegOfCode;
                         isBegOfCode=*off;   //?first part of splitted : prepare for next
X05                   Else;
                         LenIndent+=IndentSize;   //?next part of the line
E05                   Endif;
B05                   If isEndOfCode;   //?last part ot the splitted line
                         isBegOfCode=*on;   //?prepare for next line
E05                   Endif;
                      //?indent + code + comment can live in the line
                      //?first: install Indent + code
B05                   If LenIndent + LenCode < 73;
                         //?don't change anything
X05                   Else;
                         //?reduce LenIndent to give space to code
                         LenIndent = 73 - LenCode;
E05                   Endif;
                      //?second: install indent + code + comment
                      //?2010-12-29 add 3 spaces between code and comment
B05                   If HasCode;
                         LenComment+=3;
                         CommentSpacer='   ';
X05                   Else;
                         CommentSpacer='';
E05                   Endif;
B05                   If LenIndent + LenCode + LenComment < 93;
                         //?don't change anything
X05                   Else;
                         //?reduce LenIndent to give space to code
                         LenIndent = 93 - LenComment - LenCode;
E05                   Endif;
B05                   If LenIndent < 0;
                         LenIndent=0;
                         LenComment-=%Len(CommentSpacer);
                         CommentSpacer='';
E05                   Endif;
      /end-free
    ?c*0N01Factor1+++++++Opcode&ExtFactor2+++++++Result++++++++Len++D+HiLoEq....Comments++++++++++++
    ?c*. 1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7 ...+... 8 ...+... 9 ...+... 0
      /free
B05                   If sqlindent;
B06                      If HasCode And HasComment ;
                            w_rpg = %Subst(space:1:LenIndent) +
                               %Subst(w_rpg:startCode:LenCode) + CommentSpacer +
                               %Subst(w_rpg:startComment:LenComment);
X06                      Else;
B07                         If HasCode ;
                               w_rpg = %Subst(space:1:LenIndent) +
                                  %Subst(w_rpg:startCode:LenCode);
E07                         Endif;
B07                         If HasComment ;
                               w_rpg = %Subst(space:1:LenIndent) +
                                  %Subst(w_rpg:startComment:LenComment);
E07                         Endif;
E06                      Endif;
E05                   Endif;
                      //?enddo ;
E04                Endif ;   //? inside free block

B04                If sqlindent;
                      SrcDta = w_Z1 + w_23 + '    '+w_rpg ;
                      // s'il y avait un commentaire de Frame
                      if framecomment <> '';
                         // et qu'il reste encore de la place pour ce commentaire
                         if %subst(srcdta:81:20)='';
                            // le remettre
                            %subst(srcdta:81:20)=framecomment;
                         endif;
                      endif;
                      Update Indentp1 ;
E04                Endif;
E03             Enddo;   //? Free
X02          When lcase(w_Letter) = 'p';
                //?level 0 : begin/end of procedure
B03             Select;
X03                When lcase(w_Procedure) = 'b';
                      w_Level = 0 ;
                      w_Z1 = 'B' ;
                      w_23 = 'PR' ;
                      w_45 = ' '+X'3b' ;
                      Update Indentp1 ;
X03                When lcase(w_Procedure) = 'e';
                      w_Z1 = 'E' ;
                      w_23 = 'PR' ;
                      w_45 = ' ' ;
                      Update Indentp1 ;
E03             Endsl;
X02          Other;
                w_Blank = *blanks ;
                Update Indentp1;
E02       Endsl ;   //? type de traitement
E01    Endfor;
      /end-free
    ?/*=------------------------------------------------------------------------
B00  C     *pssr         Begsr
     C                   Dump
E00  C                   Endsr
    ?C*=------------------------------------------------------------------------
    ? *=------------------------------------------------------------------------
     p SplitCodeComment...
BPR ?p                 b
     d SplitCodeComment...
     d                 pi
     d  l_rpg                       100                                         lowercased
     d  w_rpg                       200                                         true code to write
     d  startCode                     5i 0
     d  LenCode                       5i 0
     d  startComment                  5i 0
     d  LenComment                    5i 0
     d HasComment                      n
     d HasCode                         n
     d HasString                       n
     d i               s              5i 0
     d PosQuote        s              5i 0
     d PosCom          s              5i 0
     d OpenString      s               n
      /free
B01    Dou true ;   //?one time

          //?depending on CaseConv parameter and CaseConving indicator
          //?detect source code out of string
          //?apply casing rule







          //?find code string distinct from comment string
          //?l_rpg and w_rpg are trimmed
          //?l_rpg is also lowercased
          startCode=0;
          LenCode=0;
          startComment=0;
          LenComment=0;
          LenIndent=0;
          HasComment =*off;
          HasCode =*off;
          HasString =*off;
          //?RPG comment must stay between 8 and 100 (ie 1 to 93 + indent code)
          //?RPG code must stay between 8 and 80 (ie 1 to 73 + indent code)
          //?investigate carrefully an rpg line with at least one '
B02       If l_rpg = *blank;
             Leave;
E02       Endif;
          w_rpg=compress(w_rpg:1:100
             : PosCom
             : HasComment
             : HasCode
             : HasString
             ) ;
          //?l_rpg = code rpg in lowercase (cols 6 to 100)
          l_rpg = lcase(w_rpg);

B02       If HasComment And Not HasCode;
             //?line has comment and no code
             startComment=1;
             LenComment=%Len(%Trim(w_rpg));
             Leave;
E02       Endif;
B02       If HasCode And Not HasComment;
             startCode=1;
             LenCode=%Len(%Trim(w_rpg));
             Leave;
E02       Endif;

          //?line has code, a litteral and perhaps comment
          //?the two / can be into a litteral string
          //?if the rpg line does not contains a quote before the //
          //?   then the // is surely a start of comment

          //?if poscom < posquote ;
          //?has code, has a comment, has a quote into the comment
          startCode=1;
          //?   w_rpg=compress(w_rpg:1:poscom-1);
          LenCode=%Len(%Trimr(%Subst(w_rpg:1:PosCom - 1)));
          startComment=PosCom;
          LenComment=%Len(%Trimr(%Subst(w_rpg:startComment)));
          Leave;
          //?endif;

E01    Enddo;
       Return;

B01    Begsr *pssr ;
          Dump ;
E01    Endsr ;

      /end-free
EPR  p                 e
    ? *=------------------------------------------------------------------------
BPR ?p lcase           b
     d lcase           pi         32787    varying
     d  FromString                32787    varying const
    ? * table lowercase
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
    ? * table uppercase
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   Return    %Xlate(UP:lo:FromString)
    ?c*=------------------------------------------------------------------------
B00  C     *pssr         Begsr
     C                   Dump
E00  C                   Endsr
    ?C*=------------------------------------------------------------------------
EPR  p lcase           e
    ? *=------------------------------------------------------------------------
    ? *=------------------------------------------------------------------------
BPR ?p ucase           b
     d ucase           pi         32787    varying
     d  FromString                32787    varying const
    ? * table lowercase
     d lo              c                   const('abcdefghijklmnopqrst-
     d                                     uvwxyzéèçàùäâëêïîöôü-
     d                                     û')
    ? * table uppercase
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZÉÈÇÀÙÄÂËÊÏÎÖÔÜ-
     D                                     Û')
     c                   Return    %Xlate(lo:UP:FromString)
    ?c*=------------------------------------------------------------------------
B00  C     *pssr         Begsr
     C                   Dump
E00  C                   Endsr
    ?C*=------------------------------------------------------------------------
EPR  p ucase           e
    ? *=------------------------------------------------------------------------
    ? * compress spaces
    ? *=------------------------------------------------------------------------
BPR ?p compress        b
     d compress        pi           200    varying
     d  FromString                  200    varying const
     d  p_pos                         5i 0 const
     d  p_len                         5i 0 const
     d  PosCom                        5i 0
     d  HasComment                     n
     d  HasCode                        n
     d  HasString                      n

     d  work           s            200    varying

     d  cpr            s               n
     d  InString       s               n
     d  StartString    s               n
     d  EndString      s               n
     d  InSqlName      s               n
     d  InComment      s               n
     d  iFor           s              5i 0
     d  i              s              5i 0
     d  CaseCnvPos     s              5i 0
     d  CaseCnvLen     s              5i 0
     d  OneChar        s              1
     d  TwoChar        s              2
     d  A              s              1
     d  B              s              1
      /free

       //?y a un bug à l'appel de compress? dans un cas à déterminer,
       //?p_pos est très négatif (comme -10300) ?

B01    If p_pos < 0;
          iFor = p_pos;   //?mettre un debug ici
          Dump;
E01    Endif;
       cpr=*off;   //?                     compressing indicator
       InString=*off;   //?                between quotes indicator
       InSqlName = *off;
       StartString = *off;
       InComment=*off;   //?               into comment indicator
       PosCom =0 ;
       HasComment= false;
       HasCode = false;
       HasString = false;
       CaseCnvPos = p_pos;

       //?recuperer le debut de la ligne, hors scope dela compression
B01    If p_pos > 1;
          work =%Subst(FromString:1:p_pos-1);
E01    Endif;
B01    For iFor=p_pos To p_pos + p_len - 1;
          OneChar=%Subst(FromString:iFor:1);
B02       If (OneChar = '''' Or OneChar = '"') And Not InComment;
B03          If OneChar = '''';
                //?on rentre ou on sort d'un string
                InString = Not InString;
B04             If InString;
                   StartString = true;
X04             Else;
                   EndString = true;
E04             Endif;
E03          Endif;
B03          If OneChar = '"' And InString;
                //?fause alerte, touche à rien ! on est déjà dans un string
X03          Else;
                //?on rentre ou on sort d'un sql name qui n'est pas dans un string
                InSqlName = Not InSqlName;

B04             If InSqlName;
                   StartString = true;
X04             Else;
                   EndString = true;
E04             Endif;
E03          Endif;

             HasString = true ;
B03          If StartString ;
                StartString = false;
                //?start of a string : apply casing rules to code before this litteral
                CaseCnvLen = %Len(work) - CaseCnvPos +1;
B04             If CaseCnvLen > 1 And CaseConvIng;
                   %Subst(work:CaseCnvPos:CaseCnvLen) =
                      CamelCase(%Subst(work:CaseCnvPos:CaseCnvLen));   //?call casing
E04             Endif;
E03          Endif;
B03          If EndString;
                EndString = false;
                //?end of string, start of convertible code
                CaseCnvPos = %Len(work)+1;
E03          Endif;
E02       Endif;
          TwoChar=%Subst(FromString:iFor:2);
B02       If TwoChar='//' And Not InString And Not InComment;
             PosCom =%Len(work)+1;
             HasComment= true ;
             InComment=true;
             //?found start of comment, nothing more to inspect
             //?hep! need to copy the comment to WORK
             //?leave;
E02       Endif;
B02       If InComment;
             work+=OneChar;
             cpr=*off;
             Iter;
E02       Endif;
B02       If InString;
             work+=OneChar;
             cpr=*off;
             HasCode = true ;
             Iter;
E02       Endif;
B02       If OneChar = ' ';
B03          If cpr;
                //?do nothing
                Iter;
X03          Else;
                work+=OneChar;
                cpr=*on;
                Iter;
E03          Endif;
E02       Endif;
          //?out of string & out of comment & out of compression
          work+=OneChar;
          cpr=*off;
          HasCode = true ;
E01    Endfor;
B01    If CaseConvIng And HasCode;
          //?end of code : apply casing rules to code before this litteral
B02       If HasComment= true ;
             CaseCnvLen= PosCom - CaseCnvPos + 1;
X02       Else;
             CaseCnvLen = %Len(work) - CaseCnvPos +1;
E02       Endif;
B02       If CaseCnvLen > 1 And CaseConvIng;
             %Subst(work:CaseCnvPos:CaseCnvLen) =
                CamelCase(%Subst(work:CaseCnvPos:CaseCnvLen));   //?call casing
E02       Endif;
E01    Endif;
       %Len(work) = %Len(FromString);
       //?recuperer le reste de la ligne, la partie hors scope de la compression
       %Subst(work:p_pos+p_len)=%Subst(FromString:p_pos+p_len);
       Return work;
       //?code to debug this procedure, in fact never reached at execution time
B01    Monitor;
          //?no case update
          twochar = '  DeTeCtEd unchanged  -
             Not Detected String -
             DetEctEd ';
          Exec Sql Values (Select 1 As "column Name" From Qsqptabl) Into : i ;
B02       If A = 'a' And B = 'b' And A = 'A' And B = 'B';
             mysql = 'Select  1 "Column Name" from qsQPTabl';
E02       Endif;
X01    On-error;
          //?TwoChar  =  '  '      ;    // for testing this proc
          TwoChar = '  ' ;   //?   for testing this proc
E01    Endmon;
      /end-free
     c                   Eval      cpr = cpr
      /free
      /end-free
    ?c*=------------------------------------------------------------------------
B00  C     *pssr         Begsr
     C                   Dump
E00  C                   Endsr
    ?C*=------------------------------------------------------------------------
EPR  p                 e
    ? *=------------------------------------------------------------------------
    ? * case a fragment of code
    ? *=------------------------------------------------------------------------
BPR ?p CamelCase       b
     d CamelCase       pi           200    varying
     d  FromString                  200    varying const
     d rtn             s            200    varying
     d pos             s             10i 0
     d len             s              5i 0
     d beg             s              5i 0
     d end             s              5i 0
     d word            s             80    varying
     d defn            s             80    varying
      /free
       //?work in lower case
       rtn=FromString ;
       l_rpg = lcase(FromString);
       pos=%Scan('on-error':l_rpg);
B01    If pos > 0;
          l_rpg=%Replace('on_error':l_rpg:pos:8);
E01    Endif;
       pos=%Scan('eval-corr':l_rpg);
B01    If pos > 0;
          l_rpg=%Replace('eval_corr':l_rpg:pos:9);
E01    Endif;
       pos=%Scan('xml-into':l_rpg);
B01    If pos > 0;
          l_rpg=%Replace('xml_into':l_rpg:pos:8);
E01    Endif;
       //?remove all separators
       l_rpg=%Xlate('(-)=+.;<>:':'          ':l_rpg);
B01    If l_rpg='';
          Return rtn;
E01    Endif;
       //?scan the string for words
       beg = %Check(' ':l_rpg);
B01    For ever;
B02       If beg = 0 Or beg > %Len(FromString);
             Leave;
E02       Endif;
          pos=%Scan(' ':l_rpg:beg);
          len=pos-beg ;
          word=%Subst(l_rpg:beg:len);

          //?is it an Operation code ?
          pos =%Lookup ( word : OpCode );
B02       If pos = 0;   //?pas un OpCode
             //?If word = 'on'; // pas sur
             //?   If %Len(FromString) >= beg+7;
             //?      If lcase(%Subst(FromString:beg:8))='on-error'; // ben si
             //?         len=8;
             //?         pos=1;
             //?      Endif;
             //?   Endif;
             //?Endif;
E02       Endif;
B02       If pos > 0;

B03          Select;
X03             When caseconv.OpCode = '*LOWER';
                   %Subst(rtn :beg:len) =
                      lcase(%Subst(rtn :beg:len));
X03             When caseconv.OpCode = '*UPPER';
                   %Subst(rtn:beg:len) =
                      ucase(%Subst(rtn:beg:len));
X03             When caseconv.OpCode = '*CAMELCASE';
B04                If %Subst(rtn:beg:1)='%';
                      %Subst(rtn:beg:len) =
                         ucase(%Subst(rtn:beg:2))+
                         lcase(%Subst(rtn:beg+2:len-2));
X04                Else;
                      %Subst(rtn:beg:len) =
                         ucase(%Subst(rtn:beg:1))+
                         lcase(%Subst(rtn:beg+1:len-1));
E04                Endif;
X03             When caseconv.OpCode = '*DICTIONARY';
                   %Subst(rtn:beg:len) =
                      (%Subst(OpCodePretty(pos):1 :len));
E03          Endsl;
             beg = %Check(' ':l_rpg:beg+len );
             Iter;
E02       Endif;

          //?is it a defined field ?
          pDName = pDNames;
          pos = 0;
B02       For ever;
B03          If pos >=DNamesPos;
                pos = 0;
                Leave;
E03          Endif;
             pDName = pDNames + pos;
             //?first value is the camelcased name, pick & skip
             defn = DName;
             pos+=%Len(DName)+2;
             pDName = pDNames + pos;
             pos+=%Len(DName)+2;
             //?second value is the search name
B03          If word = DName;
                Leave;
E03          Endif;
E02       Endfor;   //?for DNames
B02       If pos > 0;
B03          Select;
X03             When caseconv.field = '*LOWER';
                   %Subst(rtn:beg:len) =
                      lcase(%Subst(rtn:beg:len));
X03             When caseconv.field = '*UPPER';
                   %Subst(rtn:beg:len) =
                      ucase(%Subst(rtn:beg:len));
X03             When caseconv.field = '*CAMELCASE';
                   %Subst(rtn:beg:len) =
                      ucase(%Subst(rtn:beg:1))+
                      lcase(%Subst(rtn:beg+1:len-1));
X03             When caseconv.field = '*DEFN';
                   %Subst(rtn:beg:len) = defn;
X03             When caseconv.field = '*DICTIONARY';
                   %Subst(rtn:beg:len) =
                      (%Subst(defn:1 :len));
E03          Endsl;

             beg = %Check(' ':l_rpg:beg+len );
             Iter;
E02       Endif ;


          //?it's an other word

B02       Select;
X02          When caseconv.Other = '*LOWER';
                %Subst(rtn:beg:len) =
                   lcase(%Subst(rtn:beg:len));

X02          When caseconv.Other = '*UPPER';
                %Subst(rtn:beg:len) =
                   ucase(%Subst(rtn:beg:len));
X02          When caseconv.Other = '*CAMELCASE';
B03             If len = 1;
                   %Subst(rtn:beg:1 ) =
                      ucase(%Subst(rtn:beg:1));
X03             Else;
                   %Subst(rtn:beg:len) =
                      ucase(%Subst(rtn:beg:1))+
                      lcase(%Subst(rtn:beg+1:len-1));
E03             Endif;
X02          When caseconv.Other = '*DICTIONARY';
                //?reserved for future use
E02       Endsl;
          beg = %Check(' ':l_rpg:beg+len );
          Iter;

E01    Endfor;




       Return rtn;

B01    Begsr *pssr;
          Dump ;
E01    Endsr ;
      /end-free
EPR  p CamelCase       e
    ?C*=------------------------------------------------------------------------
** atable
sample of table : shows that indentation program
preserves compilation-time-table
**
*all                *All
*blank              *Blank
*hival              *HiVal
*in                 *in
*loval              *LoVal
%abs                %Abs
%addr               %Addr
%alloc              %Alloc
%bitand             %BitAnd
%bitnot             %BitNot
%bitor              %BitOr
%bitxor             %BitXor
%char               %Char
%check              %Check
%checkr             %CheckR
%date               %Date
%days               %Days
%dec                %Dec
%dech               %DecH
%decpos             %DecPos
%diff               %Diff
%div                %Div
%editc              %EditC
%editflt            %EditFlt
%editw              %EditW
%elem               %Elem
%eof                %Eof
%equal              %Equal
%error              %Error
%fields             %Fields
%float              %Float
%found              %Found
%graph              %Graph
%handler            %Handler
%hours              %Hours
%int                %Int
%inth               %Inth
%kds                %Kds
%len                %Len
%lookup             %Lookup
%lookupge           %LookupGe
%lookupgt           %LookupGt
%lookuple           %LookupLe
%lookuplt           %LookupLt
%minutes            %Minutes
%months             %Months
%mseconds           %Mseconds
%nullind            %Nullind
%occur              %Occur
%open               %Open
%paddr              %Paddr
%paddr              %Paddr
%parms              %Parms
%realloc            %realloc
%rem                %Rem
%replace            %Replace
%scan               %Scan
%seconds            %Seconds
%shtdn              %Shtdn
%size               %Size
%sqrt               %Sqrt
%status             %Status
%str                %Str
%subarr             %Subarr
%subdt              %Subdt
%subst              %Subst
%this               %This
%time               %Time
%timestamp          %Timestamp
%tlookup            %Tlookup
%tlookupge          %TlookupGe
%tlookupgt          %TlookupGt
%tlookuple          %TlookupLe
%tlookuplt          %TlookupLt
%trim               %Trim
%triml              %TrimL
%trimr              %TrimR
%ucs2               %Ucs2
%uns                %Uns
%unsh               %UnsH
%xfoot              %Xfoot
%xlate              %Xlate
%xml                %Xml
%years              %Years
acq                 Acq
add                 Add
adddur              AddDur
alloc               Alloc
and                 And
andeq               AndEq
andge               AndGe
andgt               AndGt
andle               AndLe
andlt               AndLt
andne               AndNe
begsr               BegSr
bitoff              BitOff
biton               BitOn
cabeq               CabEq
cabge               CabGe
cabgt               CabGt
cable               CabLe
cablt               CabLt
cabne               CabNe
call                Call
callb               CallB
callp               CallP
caseq               CasEq
casge               CasGe
casgt               CasGt
casle               CasLe
caslt               CasLt
casne               CasNe
cat                 Cat
chain               Chain
check               Check
checkr              CheckR
clear               Clear
clear               Clear
close               Close
commit              Commit
comp                Comp
dealloc             Dealloc
define              Define
delete              Delete
div                 Div
do                  Do
dou                 Dou
doueq               DouEq
douge               DouGe
dougt               DouGt
doule               DouLe
doult               DouLt
doune               DouNe
dow                 Dow
doweq               DowEq
dowge               DowGe
dowgt               DowGt
dowle               DowLe
dowlt               DowLt
downe               DowNe
dsply               Dsply
dump                Dump
else                Else
elseif              ElseIf
end                 End
endcs               EndCs
enddo               EndDo
endfor              EndFor
endif               Endif
endmon              EndMon
endsl               EndSl
endsr               EndSr
eval                Eval
eval_corr           Eval-Corr
evalr               EvalR
except              Except
exfmt               ExFmt
exsr                ExSr
extrct              Extrct
feod                Feod
for                 For
force               Force
goto                Goto
if                  if
ifeq                ifEq
ifge                ifGe
ifgt                ifGt
ifle                ifLe
iflt                ifLt
ifne                ifNe
in                  In
iter                Iter
kfld                Kfld
klist               Klist
leave               Leave
leavesr             LeaveSr
lookup              Lookup
mhhzo               Mhhzo
mhlzo               Mhlzo
mlhzo               Mlhzo
mllzo               Mllzo
monitor             Monitor
move                Move
movea               MoveA
movel               MoveL
mult                Mult
mvr                 Mvr
next                Next
not                 Not
occur               Occur
on_error            On-Error
open                Open
or                  Or
oreq                OrEq
orge                OrGe
orgt                OrGt
orle                OrLe
orlt                OrLt
orne                OrNe
other               Other
out                 Out
parm                Parm
plist               Plist
post                Post
read                Read
readc               ReadC
reade               ReadE
readp               ReadP
readpe              ReadPe
realloc             Realloc
rel                 Rel
reset               Reset
reset               Reset
return              Return
rolbk               Rolbk
scan                Scan
select              Select
setgt               SetGT
setll               SetLL
setoff              SetOff
seton               SetOn
shtdn               Shtdn
sorta               SortA
sqrt                Sqrt
sub                 Sub
subdur              SubDur
subst               Subst
tag                 Tag
test                Test
testb               TestB
testn               TestN
testz               TestZ
time                Time
unlock              Unlock
update              Update
when                When
wheneq              WhenEq
whenge              WhenGe
whengt              WhenGt
whenle              WhenLe
whenlt              WhenLt
whenne              WhenNe
write               Write
xfoot               Xfoot
xlate               Xlate
xml_into            Xml-Into
xml_sax             Xml-Sax
zzzzzzzzzz          zzzzzzzzzz
