      /define INFDS
      /define LOWERCASE
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION
    ? *================================================================
     frtvsqlfm  cf   e             workstn infsr(*pssr)
     f                                     infds(fids)
     f                                     indds(indara)
     d ddl           e ds                  qualified extname(rtvsqlp )
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
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                                 CONST like(TypeCmdStr)
     D cmdlen                        15P 5 CONST
     d cmd             s                   like(TypeCmdStr)

     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                                 const like(TypeCmdStr)
     D cmdlen                        15P 5 CONST
     d objtext         s            500    varying


     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
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
    ? * indicateur de message warning deja envoyé
     d warn0002        s               n

    ? * Generate Data Definition Language (QSQGNDDL) API
     D RetrieveDDL     PR                  EXTPGM('QSQGNDDL')
    ? *Required Parameter Group:
    ? *
     d   Input_template...
     d                              582
     d   Length_of_input_template...
     d                                     like(typebin4)  const
     d   Input_template_format_name...
     d                                8    const
     d   Error_code_I_O...
     d                              255
     D/include jpltools,sqlr0100
    ?D********************
    ?D*
    ?D* ERROR CODE HANDLING FIELDS
    ?D*
    ?D********************
     D ECH             DS                  likeds(errorcodehandler)
    ?D* ECH01                  1      4B 0                                      LONGUEUR DE LA ZONE
    ?D* ECH02                  5      8B 0                                      lng DE LA REPONSE
    ?D* ECH03                  9     15                                         NUMERO DE L'ERREUR
    ?D* ECH03a                 9     11
    ?D* ECH05                 17    255                                         MSGDTA POUR L'ERREUR
     d msgf            s             10
     d qss1mri         ds           750    dtaara
     d   sysversion                   8
    ? * HERE program name & parameters
     d rtvsqlr         pr
     d rtvsqlr         pi

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

          W0flsp= '0100' ;   //?selection

          Sqlr0100.Object_name = *blank ;
          Sqlr0100.Object_library = '*LIBL' ;
          Sqlr0100.Object_type = 'TABLE' ;
          Sqlr0100.Source_file_name = 'RTVSQLP' ;
          Sqlr0100.Source_file_library = 'JPLTOOLS' ;
          Sqlr0100.Source_file_member = 'AAAAAAAAAA' ;
          Sqlr0100.Severity_level = 0 ;
          Sqlr0100.Replace_option = '1' ;
          Sqlr0100.Statement_formatting_option = '0' ;
          Sqlr0100.Date_format = 'ISO' ;
          Sqlr0100.Date_separator = '/' ;
          Sqlr0100.Time_format = 'ISO' ;
          Sqlr0100.Time_separator = ':' ;
          Sqlr0100.Naming_option = 'SQL' ;
          Sqlr0100.Decimal_point = ',' ;
          Sqlr0100.Standards_option = '0' ;
          Sqlr0100.Drop_option = '1' ;
          Sqlr0100.Message_level = 0 ;
          Sqlr0100.Comment_option = '1' ;
          Sqlr0100.Label_option = '1' ;
          Sqlr0100.Header_option = '1' ;
          Sqlr0100.Triger_option = '1' ;
          Sqlr0100.Constraint_option = '1' ;
          Sqlr0100.Sysname_option = '1' ;
          //?v7.1
          Sqlr0100.Privileges_option = '1' ;
          Sqlr0100.Ccsid_option = '1' ;
          Sqlr0100.Createreplace_option = '1' ;



          Pmqcln() ;
          Message('AAA0001');
E01    Endsr ;
       //?---------------------------------------------------------------
       //?selection task
       //?---------------------------------------------------------------
B01    Begsr Sp010 ;
B02       Dow W1flsp = '01';   //?main loop
B03          Select;
X03             When W2flsp = '00';
                   //?initialisation
                   W2flsp = '50';
                   indara = *all'0';
                   //?HERE load the page
                   //?fa        = bcl.             ;
                   Faobjname = Sqlr0100.Object_name ;
                   Faobjlib = Sqlr0100.Object_library ;
                   Faobjtype = Sqlr0100.Object_type ;
                   Fasrcfile = Sqlr0100.Source_file_name ;
                   Fasrclib = Sqlr0100.Source_file_library ;
                   Fasrcmbr = Sqlr0100.Source_file_member ;
                   Fasevlevel = Sqlr0100.Severity_level ;
                   Facrtmbr = Sqlr0100.Replace_option ;
                   Fareplace = Sqlr0100.Replace_option ;
                   Fafmtopt = Sqlr0100.Statement_formatting_option ;
                   Fadatfmt = Sqlr0100.Date_format ;
                   Fadatsep = Sqlr0100.Date_separator ;
                   Fatimfmt = Sqlr0100.Time_format ;
                   Fatimsep = Sqlr0100.Time_separator ;
                   Fanaming = Sqlr0100.Naming_option ;
                   Fadecpoint = Sqlr0100.Decimal_point ;
                   Fastandard = Sqlr0100.Standards_option ;
                   Fadrop = Sqlr0100.Drop_option ;
                   Famsglvl = Sqlr0100.Message_level ;
                   Facomment = Sqlr0100.Comment_option ;
                   Falabel = Sqlr0100.Label_option ;
                   Faheader = Sqlr0100.Header_option ;
                   Fatriger = Sqlr0100.Triger_option ;
                   Faconstr = Sqlr0100.Constraint_option ;
                   Fasysnam = Sqlr0100.Sysname_option ;
                   //?v7.1
                   Faprivil = Sqlr0100.Privileges_option ;
                   Faccsid = Sqlr0100.Ccsid_option ;
                   Facrtrpl = Sqlr0100.Createreplace_option ;

                   warn0002=*off;
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
B04                If *inkc = *on;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=F3
B04                If *inkl = *on;
                      W0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F5=refresh
B04                If *inke = *on ;
                      W2flsp = '00';
                      Iter;
E04                Endif ;
                   //?at work
                   W2flsp = '80';
B04                If %Subst(Fasrcmbr:1:1) = '*';

                      Message ('CPD0078' : 'xxxx' + 'SRCMBR    ' + Fasrcmbr
                         : '' : 'QCPFMSG');

                      W2flsp = '50';
                      Iter;
E04                Endif;
                   Sqlr0100.Object_name = Faobjname ;
                   Sqlr0100.Object_library = Faobjlib ;
                   Sqlr0100.Object_type = Faobjtype ;
                   Sqlr0100.Source_file_name = Fasrcfile ;
                   Sqlr0100.Source_file_library = Fasrclib ;
                   Sqlr0100.Source_file_member = Fasrcmbr ;
                   Sqlr0100.Severity_level = Fasevlevel ;
                   Sqlr0100.Replace_option = Fareplace ;
                   Sqlr0100.Statement_formatting_option = Fafmtopt ;
                   Sqlr0100.Date_format = Fadatfmt ;
                   Sqlr0100.Date_separator = Fadatsep ;
                   Sqlr0100.Time_format = Fatimfmt ;
                   Sqlr0100.Time_separator = Fatimsep ;
                   Sqlr0100.Naming_option = Fanaming ;
                   Sqlr0100.Decimal_point = Fadecpoint ;
                   Sqlr0100.Standards_option = Fastandard ;
                   Sqlr0100.Drop_option = Fadrop ;
                   Sqlr0100.Message_level = Famsglvl ;
                   Sqlr0100.Comment_option = Facomment ;
                   Sqlr0100.Label_option = Falabel ;
                   Sqlr0100.Header_option = Faheader ;
                   Sqlr0100.Triger_option = Fatriger ;
                   Sqlr0100.Constraint_option = Faconstr ;
                   Sqlr0100.Sysname_option = Fasysnam ;
                   //?v7.1
                   Sqlr0100.Privileges_option = Faprivil ;
                   Sqlr0100.Ccsid_option = Faccsid ;
                   Sqlr0100.Createreplace_option = Facrtrpl ;
                // SQL7039 : Standard Option has constraints
B04             // If Sqlr0100.Standards_option <> '0';
                //    Sqlr0100.Naming_option = 'SQL' ;
B05             //    If Sqlr0100.Date_format = 'ISO'
X05             //    Or Sqlr0100.Date_format = 'USA'
X05             //    Or Sqlr0100.Date_format = 'EUR'
X05             //    Or Sqlr0100.Date_format = 'JIS';
X05             //    Else;
                //       Sqlr0100.Date_format = 'ISO' ;
E05             //    Endif;
B05             //    If Sqlr0100.Time_format = 'ISO'
X05             //    Or Sqlr0100.Time_format = 'USA'
X05             //    Or Sqlr0100.Time_format = 'EUR'
X05             //    Or Sqlr0100.Time_format = 'JIS';
X05             //    Else;
                //       Sqlr0100.Time_format = 'ISO' ;
E05             //    Endif;
                //    Sqlr0100.Decimal_point = '.' ;
                //    Sqlr0100.Sysname_option = '0' ;
                //    Sqlr0100.Createreplace_option = '0' ;
E04             // Endif;
                   if sysversion < 'V7R0M000' ;
                   Sqlr0100.Privileges_option = *loval;
                   Sqlr0100.Ccsid_option = *loval;
                   Sqlr0100.Createreplace_option = *loval;
                   endif;
                   Clear ECH;
                   ECH.Provided = %Size(ECH);
                   //?check destination file existence

                   cmd ='CHKOBJ OBJ(' + %Trim(Fasrclib) +
                      '/' + %Trim(Fasrcfile) + ')' +
                      ' OBJTYPE(*FILE)' +
                      ' MBR(*NONE)' +
                      ' AUT(*ALL)' ;
B04                Monitor;
                      QCmdExec ( cmd : %Size(cmd));
X04                On-error;
                      //?the message is already in the message subfile
                      //?message('CPF9898' : spmsda : '' : 'QCPFMSG');
                      W2flsp = '50';
                      Iter;
E04                Endmon ;

                   //?check destination member existence
                   cmd ='CHKOBJ OBJ(' + %Trim(Fasrclib) +
                      '/' + %Trim(Fasrcfile) + ')' +
                      ' OBJTYPE(*FILE)' +
                      ' MBR(' + %Trim(Fasrcmbr) + ')' +
                      ' AUT(*ALL)' ;

                   Callp(E) QCmdExec ( cmd : %Size(cmd));
B04                If %Error;
B05                   If Facrtmbr = '1';
                         objtext = Faobjtype + %Trim(Faobjlib) +
                            '/' + %Trim(Faobjname) ;
B06                      If %Len(objtext) > 50;
                            %Len(objtext) = 50 ;
E06                      Endif;
                         cmd = 'ADDPFM FILE(' + %Trim(Fasrclib) + '/' +
                            %Trim(Fasrcfile) + ') ' +
                            'MBR(' + %Trim(Fasrcmbr) + ') ' +
                            'TEXT(''' + objtext +
                            ''')';
                         Callp(E) QCmdExec ( cmd : %Size(cmd));
B06                      If %Error();
                            W2flsp = '50';
                            Iter;
E06                      Endif;
X05                   Else;
                         //?the message is already in the message subfile
                         //?message('CPF9898' : spmsda : '' : 'QCPFMSG');
                         W2flsp = '50';
                         Iter;
E05                   Endif;
X04                Else ;
                      //?the member already exists
B05                   If Fareplace = '0';
                         //?replace member forbidden
                         //?message ('CPF5812' : fasrcfile + fasrclib + fasrcmbr
                         //? : '' : 'QCPFMSG');
                         //?w2flsp = '50';
                         //?iter;
E05                   Endif;
E04                Endif;
                   RetrieveDDL(Sqlr0100 : %Size(Sqlr0100) : 'SQLR0100' : ECH);
B04                If ECH.Available > 0 ;
B05                   If %Subst(ECH.MSGID:1:3) = 'SQL';
                         msgf = 'QSQLMSG';
X05                   Else;
                         msgf = 'QCPFMSG';
E05                   Endif;
                      Message(ECH.MSGID:ECH.Msgdta : '*LIBL' : msgf );
                      W2flsp = '50';

E04                Endif;
X03             When W2flsp = '80';
                   //?validation




                   cmd = 'STRSEU SRCFILE(' + %Trim(Fasrclib) + '/' +
                      %Trim(Fasrcfile) + ') ' +
                      'SRCMBR(' + %Trim(Fasrcmbr) + ') ' +
                      'OPTION(5)';

                   Callp(E) QCmdExec ( cmd : %Size(cmd));
B04                If %Error();
                      W2flsp = '50';
                      Iter;
E04                Endif;






                   W0flsp = '0100' ;


                   Iter;
X03             Other ;
                   //?quit

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
