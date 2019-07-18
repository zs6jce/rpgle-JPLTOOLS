    ? * compilation :
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
    ? *
      /define INFDS
    ? /define rtvjoba
      /define userspace





     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION


    ? *================================================================
    ? * sample of program
    ? *================================================================
    ? *necessary adaptation are marked HERE










     fslppgmfm  cf   e             workstn
     f                                     infds(fids)
     f                                     sfile(sflb:ran01b)                   HERE with sfl ?
     f                                     indds(indara)





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
     d  pinklib                        n   overlay(indara:71)
     d  limite                         n   overlay(indara:98)
     d ranp1b          s                   like(ran01b)                         HERE with sfl ?
     d ranw1b          s                   like(ran01b)
     d ranw2b          s                   like(ran01b)
     d pag01b          s              2s 0
     d*nbl01b          s              2s 0








      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION


     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value

     d rc              s              9b 0
     d cmde            s           1000    varying

       //?*******************************************************************
       //?Retrieve Call Stack (QWVRCSTK) API
       //? Required Parameter Group:
       //?1 Receiver variable Output Char(*)
       //?2 Length of receiver variable Input Binary(4)
       //?3 Format of receiver information Input Char(8)
       //?4 Job identification information Input Char(*)
       //?5 Format of job identification information Input Char(8)
       //?6 Error code I/O Char(*)
     d QWVRCSTK        pr                  extpgm('QWVRCSTK')
     d Receiver                   32767a          options( *varsize )
     d length_recvr                  10i 0 const
     d format_name                    8    const
     d Job_id                        52    const
     d Job_Id_Format                  8    const
     d Error_code                 32767a          options( *varsize )
       //?*******************************************************************
     d JIDF0100        ds                  qualified
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Internal_job                  16
     d Reserved1                      2
     d Thread_ind                    10i 0
     d Thread_id                      8
       //?*******************************************************************
     d CSTK0100        ds         65535    qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Nb_cstk_thread                10i 0
     d Offset_cstke                  10i 0
     d Nb_cstk                       10i 0
     d thread_id                      8
     d status                         1
       //?*******************************************************************
     d CSTKe           ds                  qualified  based(pCstke)
     d cstke_len                     10i 0
     d stat_id_disp                  10i 0
     d stat_id_nb                    10i 0
     d proc_disp                     10i 0
     d proc_len                      10i 0
     d Request_level                 10i 0
     d Program_name                  10
     d Program_lib                   10
     d MI_inst                       10i 0
     d Module_name                   10
     d Module_lib                    10
     d Control_bndry                  1
     d Reserved1                      3
     d Actgrpnb                      10u 0
     d Actgrpname                    10
     d Reserved2                      2
     d Pgm_ASP_name                  10
     d Pgm_ASP_lib                   10
     d Pgm_ASP_nbr                   10i 0
     d Pgm_ASP_lib_nb                10i 0
     d Actgrp_nbr_lng                20u 0
    ?d*Reserved CHAR(*)
    ?d*Statement_identifiers ARRAY(*) of CHAR(10)
    ?d*Procedure_name CHAR(*)
       //?*******************************************************************
       //?Close List (QGYCLST) API
       //?  Required Parameter Group:
       //?1 Request handle Input Char(4)
       //?2 Error code I/O Char(*)
     d QGYCLST         pr                  extpgm('QGYCLST')
     d Request_handle                 4    const
     d Error_code                 32767a          options( *varsize )
       //?*******************************************************************
       //?    Get List Entries (QGYGTLE) API
       //?      Required Parameter Group:
       //?    1 Receiver variable Output Char(*)
       //?    2 Length of receiver variable Input Binary(4)
       //?    3 Request handle Input Char(4)
       //?    4 List information Output Char(80)
       //?    5 Number of records to return Input Binary(4)
       //?    6 Starting record Input Binary(4)
       //?    7 Error code I/O Char(*)
     d QGYGTLE         pr                  extpgm('QGYGTLE')
     d receiver                   32767a          options( *varsize )
     d length_recvr                  10i 0 const
     d Request_handle                 4    const
     d list_info                     80
     d Nber_return                   10i 0 const
     d Start_At                      10i 0 const
     d Error_code                 32767a          options( *varsize )
       //?*******************************************************************
     d gleoli          ds                  likeds(oli)

       //?open list of activation attributes (qwvolact) api
       //?  required parameter group:
       //?1 receiver variable output char(*)
       //?2 length of receiver variable input binary(4)
       //?3 list information output char(80)
       //?4 number of records to return input binary(4)
       //?5 format name input char(8)
       //?6 activation group number input binary(4)
       //?7 qualified job name input char(26)
       //?8 internal job identifier input char(16)
       //?9 error code i/o char(*)
       //?*******************************************************************
     d qwvolact        pr                  extpgm('QWVOLACT')
     d receiver                   32767a          options( *varsize )
     d length_recvr                  10i 0 const
     d list_info                     80
     d records                       10i 0 const
     d format_name                    8    const
     d act_grp_nbr                   10i 0 const
     d job_name                      26    const
     d internal_job                  16    const
     d error_code                 32767a          options( *varsize )
       //?*******************************************************************
     d oli             ds            80    qualified
     d   total_records...
     d                               10i 0
     d   records_returned...
     d                               10i 0
     d   request_handle...
     d                                4
     d   record_length...
     d                               10i 0
     d   information_complete_indicator...
     d                                1
     d   date_and_time_created...
     d                               13
     d   list_status_indicator...
     d                                1
     d   reserved1...
     d                                1
     d   length_of_information_returned...
     d                               10i 0
     d   first_record_in_receiver_variable...
     d                               10i 0
     d   reserved2...
     d                                4
     d   activation_number_long...
     d                               20i 0
       //?*******************************************************************
     d ract0100        ds            80    qualified
     d  activation_group_name...
     d                               10
     d  reserved...
     d                                6
     d  activation_group_number...
     d                               10i 0
     d  reserved2...
     d                               10i 0
     d  activation_number...
     d                               10i 0
     d  static_storage_size...
     d                               10i 0
     d  program_name...
     d                               10
     d  program_library...
     d                               10
     d  program_type...
     d                                1
     d  reserved3...
     d                               11
     d  activation_group_number_long...
     d                               20i 0
     d  activation_number_long...
     d                               20i 0
       //?*******************************************************************
       //?Retrieve Object Description (QUSROBJD) API
       //?1 Receiver variable Output Char(*)
       //?2 Length of receiver variable Input Binary(4)
       //?3 Format name Input Char(8)
       //?4 Object and library name Input Char(20)
       //?5 Object type Input Char(10)
       //?6 Error code I/O Char(*)
     d qusrobjd        pr                  extpgm('QUSROBJD')
     d receiver                   32767a          options( *varsize )
     d length_recvr                  10i 0 const
     d format_name                    8    const
     d obj_name                      20    const
     d obj_type                      10    const
     d error_code                 32767a          options( *varsize )

     d OBJD0200        ds                  qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Object_name                   10
     d Object_lib                    10
     d Object_type                   10
     d Return_lib                    10
     d Obj_ASP_nbr                   10i 0
     d Object_owner                  10
     d Object_domain                 02
     d Creation_dts                  13
     d change_dts                    13
     d obj_attr                      10
     d Text                          50
     d Src_file_name                 10
     d Src_file_lib                  10
     d Src_file_mbr                  10

     d PgmList         s             20    inz('PGMLIST   QTEMP     ')
     d srvList         s             20    inz('SRVLIST   QTEMP     ')
    ? * List Service Program Information (QBNLSPGM) API
     d qbnlspgm        pr                  extpgm('QBNLSPGM')
     d   UserSpace                   20    const
     d   format                       8    const
     d   QualSrvPgm                  20    const
     d   Error_Code                 256          options(*varsize)
    ? * List ILE Program Information (QBNLPGMI) API
     d QBNLPGMI        pr                  extpgm('QBNLPGMI')
     d usrspc                        20    const
     d format                         8    const
     d QualPgm                       20    const
     d Error_code                   255           options( *varsize )
    ? *=----------------------------------------
     d PGML0100        ds                  qualified  based(pPGML0100)
     d   Program_name                10
     d   Program_lib                 10
     d   module_name                 10
     d   module_lib                  10
     d   Source_name                 10
     d   Source_lib                  10
     d   Source_member...
     d                               10
     d   Module_attr                 10
     d   Module_date                 13
     d   Source_date                 13
     d   Sort_name                   10
     d   Sort_lib                    10
     d   Lang_id                     10
     d   Optimization                10i 0
     d   Maximum_opt                 10i 0
     d   Debug_data                  10
     d   Release_on                   6
     d   Release_for                  6
     d   Reserved1                   20
     d   User_modif                   1
     d   Licpgm                      13
     d   PTF_number                   5
     d   APAR_ID                      6
     d   Creation_data...
     d                                1
     d   Module_CCSID                10i 0
     d   Object_control_level...
     d                                8
     d   perf_coll                    1
     d   Prof_data                   10
     d   Reserved2                    1
     d   Nb_proc                     10i 0
     d   Nb_proc_reordered...
     d                               10i 0
     d   Nb_proc_measured...
     d                               10i 0
     d   Teraspace                    1
     d   Storage_model...
     d                                1
     d   Reserved3                   74
     d   Nb_SQL_stmt                 10i 0
     d   Relational_database...
     d                               18
     d   Commitment_control...
     d                               10
     d   Allow_copy_of_data...
     d                               10
     d   Close_SQL_cursors...
     d                               10
     d   Naming_convention...
     d                               10
     d   Date_format                 10
     d   Date_separator...
     d                                1
     d   Time_format                 10
     d   Time_separator...
     d                                1
     d   Delay_PREPARE...
     d                               10
     d   Allow_blocking...
     d                               10
     d   Default_collection_name...
     d                               10
     d   SQL_package_name...
     d                               10
     d   SQL_package_lib...
     d                               10
     d   Dynamic_user_profile...
     d                               10
     d   SQL_sort_name...
     d                               10
     d   SQL_sort_lib                10
     d   SQL_lang_id                 10
     d   Connection_method...
     d                               10
     d   SQL_path_length...
     d                               10i 0
     d   SQL_path                  3483

     d Pgml0200        ds                  qualified based(pPGML0200)
     d   Program_name                10
     d   Program_lib                 10
     d   SrvPgm_name                 10
     d   SrvPgm_lib                  10
     d   SrvPgm_Sign                 16


    ? * List Module Information (QBNLMODI) API
    ? *   non, celle ci c'est pour lister les procedures
    ? * Retrieve Module Information (QBNRMODI) API
     d qbnrmodi        pr                  extpgm('QBNRMODI')
     d   receiver                 30000          options( *varsize )
     d   receiverlen                 10i 0 const
     d   format                       8    const
     d   QualMod                     20    const
     d   Error_Code                 256          options(*varsize)

     d MODI0100        ds                  qualified
     d
     d returned...
     d                               10i 0
     d available...
     d                               10i 0
     d Module_name...
     d                               10
     d Module_lib...
     d                               10
     d Module_attr...
     d                               10
     d Module_date...
     d                               13
     d Source_name...
     d                               10
     d Source_lib...
     d                               10
     d Source_mbr...
     d                               10
     d Source_date...
     d                               13
     d Reserved1...
     d                               10
     d Module_owner...
     d                               10
     d Reserved11...
     d                                2
     d Module_CCSID...
     d                               10i 0
     d Text_description...
     d                               50
     d Creation_data...
     d                                1
     d Sort_sequence_table_name...
     d                               10
     d Sort_sequence_table_library_name...
     d                               10
     d Language_identifier...
     d                               10
     d Reserved2...
     d                                3
     d Optimization_level...
     d                               10i 0
     d Maximum_optimization_level...
     d                               10i 0
     d Debug_data...
     d                                1
     d Module_compressed_status...
     d                                1
     d Reserved3...
     d                                2
     d Minimum_number_of_parameters...
     d                               10i 0
     d Maximum_number_of_parameters...
     d                               10i 0
     d Module_state...
     d                                1
     d Module_domain...
     d                                1
     d Reserved4...
     d                                2
     d Number_of_exported_defined_symbols...
     d                               10i 0
     d Number_of_imported_unresolved_symbols...
     d                               10i 0
     d Release_module_created_on...
     d                                6
     d Release_module_created_for...
     d                                6
     d Earliest_release_module_can_be_restored_to...
     d                                6
     d Enable_performance_collection...
     d                                1
     d Conversion_required...
     d                                1
     d Offset_to_program_entry_procedure_name...
     d                               10i 0
     d Length_of_program_entry_procedure_name...
     d                               10i 0
     d Program_entry_procedure_name_indicator...
     d                                1
     d Profile_data...
     d                               10
     d Intermediate_language_IL_data...
     d                                1
     d Teraspace_storage_enabled...
     d                                1
     d Storage_model...
     d                                1
     d Conversion_detailsEnd_of_change...
     d                                1
     d Reserved5...
     d                                1
     d Offset_to_Licensed_Internal_Code_options...
     d                               10i 0
     d Length_of_Licensed_Internal_Code_options...
     d                               10i 0
     d Reserved6...
     d                               68
     d Number_of_SQL_statements...
     d                               10i 0
     d Relational_database...
     d                               18
     d Commitment_control...
     d                               10
     d Allow_copy_of_data...
     d                               10
     d Close_SQL_cursor...
     d                               10
     d Naming_convention...
     d                               10
     d Date_format...
     d                               10
     d Date_separator...
     d                                1
     d Time_format...
     d                               10
     d Time_separator...
     d                                1
     d Delay_PREPARE...
     d                               10
     d Allow_blocking...
     d                               10
     d Default_collection_name...
     d                               10
     d SQL_package_name...
     d                               10
     d SQL_package_library_name...
     d                               10
     d Dynamic_user_profile...
     d                               10
     d SQL_sort_sequence_table_name...
     d                               10
     d SQL_sort_sequence_table_library_name...
     d                               10
     d SQL_language_identifier...
     d                               10
     d Connection_method...
     d                               10
     d SQL_path_offset...
     d                               10i 0
     d SQL_path_length...
     d                               10i 0
    ?d*Reserved7...
    ?d*Program_entry_procedure_name...
    ?d*SQL_path...
    ?d*Licensed_Internal_Code_options...


     d un_pgm          pr
     d p_lib                         10
     d p_nam                         10

     d un_srvpgm       pr
     d p_lib                         10
     d p_nam                         10

    ? * Retrieve Service Program Information (QBNRSPGM) API
     d QBNRSPGM        pr                  extpgm('QBNRSPGM')
     d   receiver                 30000          options( *varsize )
     d   receiverlen                 10i 0 const
     d   format                       8    const
     d   QualSrv                     20    const
     d   Error_Code                 256          options(*varsize)

     d SPGI0100        ds                  qualified
     D Bytes_returned...
     D                               10i 0
     D Bytes_available...
     D                               10i 0
     D Service_program_name...
     D                               10
     D Service_program_library_name...
     D                               10
     D Service_program_owner...
     D                               10
     D Service_program_attribute...
     D                               10
     D Creation_date_and_time...
     D                               13
     D Export_source_file_name...
     D                               10
     D Export_source_file_library_name...
     D                               10
     D Export_source_file_member_name...
     D                               10
     D Activation_group_attribute...
     D                               30
     D Current_export_signature...
     D                               16
     D User_profile...
     D                                1
     D Observable_information_compressed...
     D                                1
     D Run_time_information_compressed...
     D                                1
     D Service_program_CCSID...
     D                               10i 0
     D Number_of_modules...
     D                               10i 0
     D Number_of_service_programs...
     D                               10i 0
     D Number_of_copyrights...
     D                               10i 0
     D Text_description...
     D                               50
     D Shared_activation_group...
     D                                1
     D Allow_update...
     D                                1
     D Number_of_unresolved_references...
     D                               10i 0
     D Use_adopted_authority...
     D                                1
     D Allow_bound_SRVPGM_library_name_update...
     D                                1
     D Profiling_data...
     D                               10
     D Teraspace_storage_enabled_modules...
     D                                1
     D Storage_model...
     D                                1
     D Uses_argument_optimization...
     D                               10
     D Reserved1...
     D                               70
     D Service_program_state...
     D                                1
     D Service_program_domain...
     D                                1
     D Associated_space_size...
     D                               10i 0
     D Static_storage_size...
     D                               10i 0
     D Service_program_size...
     D                               10i 0
     D Release_service_program_created_on...
     D                                6
     D Earliest_release_service_program_can_run...
     D                                6
     D Release_service_program_created_for...
     D                                6
     D Allow_static_storage_reinitialization...
     D                                1
     D Conversion_required...
     D                                1
     D All_creation_data...
     D                                1
     D Conversion_details...
     D                                1
     D Reserved2...
     D                               90
     D Paging_pool...
     D                                1
     D Paging_amount...
     D                                1











       //?*******************************************************************
     d iCstke          s             10u 0
     d iLAct           s             10u 0
     d length          s              5b 0
     d format_n        s              8    inz('RACT0100')
     d act_grp_n       s              5b 0 inz(-1)
     d qua_job_n       s             26
     d int_job_i       s             16    inz('                ')
     d i               s              5b 0
    ? * subarray for system library list
     d liblmax         s              5u 0
     d liblno          s              5u 0
     d libtype         s              4
     d pgmtype         s             10
    ?d*dormant         s             10
    ?d*curpgm          s             10
    ?d*curpgmlib       s             10

     d slppgmr         pr
     d   p_qua_job                   26
     d   p_jobint                    16
     d   p_api                       10

     d slppgmr         pi
     d   p_qua_job                   26
     d   p_jobint                    16
     d   p_api                       10



      /free
       //?* programme principal
       //?* initialisation générale
       w0flsp = '0000' ;//?initialisation generale
B01    Dow w0flsp <> *blanks ;//?boucle centrale
B02       Select ;
X02          When w1flsp = '00';
                Exsr sp000 ;//?initialisation


X02          When w1flsp = '02';
                Exsr sp020 ;//?detail par sous-fichier


X02          Other;
                spmsda = 'routine cible (w0flsp) inconnue';
                Exsr *pssr ;//?erreur dans wwflag
E02       Endsl;
E01    Enddo;
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?initialisation generale
       //?---------------------------------------------------------------
B01    Begsr sp000 ;

          //? create the user space
          quscrtus (PgmList
             : *blank
             : 1
             : x'00'
             : '*ALL'
             : *blank
             : '*NO'
             : ech
             : '*USER'
             );
B02       If (ech.available>0);
B03          If ech.MSGID<> 'CPF9870';
                message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
                Return;
E03          Endif;
E02       Endif;

          //? with attribute auto-extensible
          quscusat ( lib
             : PgmList
             : attributes
             : ech
             );
B02       If (ech.available>0);
             message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
             Return;
E02       Endif;

          quscrtus (srvList
             : *blank
             : 1
             : x'00'
             : '*ALL'
             : *blank
             : '*NO'
             : ech
             : '*USER'
             );
B02       If (ech.available>0);
B03          If ech.MSGID<> 'CPF9870';
                message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
                Return;
E03          Endif;
E02       Endif;

          //? with attribute auto-extensible
          quscusat ( lib
             : PgmList
             : attributes
             : ech
             );
B02       If (ech.available>0);
             message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
             Return;
E02       Endif;
          showmod='Y';
          w0flsp= '0200' ;//?sub-file
          pmqcln() ;
          message('AAA0001');
E01    Endsr ;
       //?---------------------------------------------------------------
       //?task : subfile
       //?---------------------------------------------------------------
B01    Begsr sp020 ;
B02       Dow w1flsp = '02';//?main loop
B03          Select;
X03             When w2flsp = '00';
                   //?initialisation
                   w2flsp = '10';
                   indara = *all'0';
                   ranp1b = 1;
                   pag01b = 15;
                 //nbl01b = 0;
                   Callp pmqcln() ;
                   //?initialisation    subfile
                   ran01b = 0;
                   clrsfl = *on;
                   dspsfl = *off;
                   sflend = *off;
                   Write ctlb;
                   clrsfl = *off;

                   qualjob=
                      %Trim(%Subst(p_qua_job : 21 : 06))+'/'+
                      %Trim(%Subst(p_qua_job : 11 : 10))+'/'+
                      %Trim(%Subst(p_qua_job : 01 : 10));
                   qua_job_n = p_qua_job;
                   int_job_i = p_jobint;
                   ech.provided =%Size(ech);
                   ech.available=0;
B04                If p_api = 'QWVRCSTK';
                      //?get current call stack
                      //?issue with intjob ? don't succes to read call stack of an other job
                      //?useless call : all but current program are sleeping !
                      Clear JIDF0100;
                      JIDF0100.Job_name = %Subst(p_qua_job : 01 : 10);
                      JIDF0100.User_name = %Subst(p_qua_job : 11 : 10);
                      JIDF0100.Job_number = %Subst(p_qua_job : 21 : 06);
                      JIDF0100.Internal_job = p_jobint ;
                      JIDF0100.Reserved1=*loval;
                      JIDF0100.Thread_id=*loval;
                      JIDF0100.Thread_ind =1;
                      QWVRCSTK (
                         CSTK0100
                         : %Len(CSTK0100)
                         : 'CSTK0100'
                         : JIDF0100
                         : 'JIDF0100'
                         : ech ) ;
B05                   If ech.available > 0;
                      message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
E05                   Endif;
                      pCstke = %Addr(CSTK0100)+ CSTK0100.Offset_cstke;
                      iCstke=1;
                      //? for icstke = 1 to cstk0100.Nb_cstk ;
                      //?    message('':'CSTK:'+%editc(icstke:'Z') + ' '
                      //?curpgmlib = cstke.Program_lib ;
                      //?curpgm = cstke.Program_name ;
                      //?    pcstke+=cstke.cstke_len;
                      //? endfor;
                      //?get current library lists -> syslibl of current job
E04                Endif;
                   ech.available=0;
                   rtvjoba ( jobi0700
                      : %Size( jobi0700 )
                      : 'JOBI0700'
                      : qua_job_n
                      : int_job_i
                      : ech
                      );
B04                If ech.available > 0;
                      message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
                      Leave;
E04                Endif;
                   liblmax = jobi0700.nb_syslibl
                      + jobi0700.nb_product ;
                   //?get activation group activity list (= list of pgm in use for the job)
B04                If p_api = 'QWVOLACT';
                      oli.total_records = 0;
                      oli.records_returned = 0;
                      oli.record_length = 0;
                      oli.length_of_information_returned = 0;
                      oli.length_of_information_returned = 0;

                      ech.available=0;
                      qwvolact ( ract0100
                         : 0
                         : oli
                         : 0
                         : format_n
                         : act_grp_n
                         : qua_job_n
                         : int_job_i
                         : ech
                         );
B05                   If ech.available > 0;
                      message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
                         w2flsp = '40';
E05                   Endif;

                      //?iLact = 1 ;
                      iLAct = oli.total_records ;
E04                Endif;
X03             When w2flsp = '10';
                   //?read file & load subfile
                   //?HERE key list to read target file & remember last call to refresh
                   w2flsp = '20';
X03             When w2flsp = '20';
                   //?trouver la prochaine ligne à afficher
                   w2flsp = '30';
B04                If p_api = 'QWVOLACT';
                      //?if iLact > oli.total_records ;
B05                   If iLAct < 1;
                         w2flsp = '40';
                         Iter;
E05                   Endif;
                      ech.available=0;
                      QGYGTLE (
                         ract0100
                         : %Len(ract0100)
                         : oli.Request_handle
                         : gleoli
                         : 1
                         : iLAct
                         : ech );
B05                   If ech.available > 0;
B06                      If %Subst(ech.MSGID:1:3)='GUI';
                            message(ech.MSGID:ech.msgdta:'':'QGUIMSG');
X06                      Else;
                            message(ech.MSGID:ech.msgdta:'':'QCPFMSG');
E06                      Endif;
                         w2flsp = '40';
E05                   Endif;

                      //?is current pgm lib in syslibl ?
                      //?restrict the syslibl to libs Q*, but QRPLOBL
                      libtype='*USR';
B05                   If %Subst(ract0100.program_library: 1 : 1) <> 'Q' Or
                            ract0100.program_library ='QQPL' Or
                            ract0100.program_library ='QRPLOBJ';
X05                   Else;
                         liblno = %Lookup(ract0100.program_library
                            :jobi0700.library_list
                            :1:liblmax);
B06                      If liblno > 0 ;
                            libtype='*SYS';
E06                      Endif;
E05                   Endif;

B05                   If ract0100.program_library ='QQPL' Or
                            ract0100.program_library ='QRPLOBJ';
                         pinklib = *on ;
X05                   Else;
                         pinklib = *off;
E05                   Endif;
B05                   Select;
X05                      When ract0100.program_type = '0';
                            pgmtype= '*PGM      ';
X05                      When ract0100.program_type = '1';
                            pgmtype= '*SRVPGM   ';
X05                      Other;
                            pgmtype= 'other ?   ';
E05                   Endsl;
                      iLAct-=1;
                      w2flsp = '20';
                      //?show in the joblog
B05                   If libtype = '*USR';
B06                      If ract0100.program_library = sppglb And
                               ract0100.Program_name = spname;
                            Iter;
X06                      Else;
                            w2flsp = '30';
E06                      Endif;
E05                   Endif;
X04                Else;
B05                   If iCstke >= CSTK0100.Nb_cstk ;
                         w2flsp = '40';
                         Iter;
E05                   Endif;

                      //?is current pgm in the call stack ?
                      //? dormant = 'Sleeping';
                      //?    if ract0100.program_library = cstke.Program_lib and
                      //?          ract0100.program_name = cstke.Program_name ;
                      //?       dormant=''  ;
                      //?       leave;
                      //?    endif;
                      //?    pcstke+=cstke.cstke_len;
                      //? endfor;
                      //?pgm type
E04                Endif;



                   iCstke+=1;


                   //?boucle imbriquée d'affichage pgm et module
                   //?//?detection    page is full
                   ranw1b = ran01b ;
                   //?If pag01b <= nbl01b ;
                   //?   dspsfl = *on;
                   //?   sflend = *off;
                   //?   nbl01b = 0;
                   //?   ran01b = ranp1b;
                   //?   w2flsp = '50';
                   //?   Iter;
                   //?Endif;
X03             When w2flsp = '30';
                   //?load one line, read next
                   w2flsp = '20';
                   ran01b = ranw1b;
                 //nbl01b = nbl01b + 1;
                   //?* load one line




                   //?HERE load one line in the subfile
                   //?sb        = bcl.             ;



                   zbsele = ' ';

B04                If p_api = 'QWVRCSTK';
                      ordr = CSTKe.Request_level ;
                      actgrp= CSTKe.Actgrpname ;
                      pgmnam = CSTKe.Program_name ;
                      pgmlib = CSTKe.Program_lib ;
                      pgmtyp = '*PGM' ;


                      pCstke+= CSTKe.cstke_len;


X04                Else;


                      actgrp = ract0100.activation_group_name ;
                      pgmlib = ract0100.program_library ;
                      pgmnam = ract0100.Program_name ;
                      pgmtyp = pgmtype ;
                      ordr = iLAct -1 ;
E04                Endif;
                   ech.available=0;
                   qusrobjd (
                      OBJD0200
                      : %Len(OBJD0200)
                      : 'OBJD0200'
                      : pgmnam + pgmlib
                      : pgmtyp
                      : ech );
B04                If ech.available>0;
                      Clear OBJD0200;
E04                Endif;
                   Text = OBJD0200.obj_attr + OBJD0200.Text;


                   //?* write one line
                   ran01b = ran01b + 1;
                   Write sflb ;
                   //?TODO lire la liste des modules du programme
                   w2flsp = '32';
X03             When w2flsp = '32';
                   //?liste des modules du programme
                   w2flsp = '20';
                   if showmod='N';
                   iter;
                   endif;
B04                Select;
X04                   When pgmtype= '*SRVPGM   ';
                         un_srvpgm(pgmlib:pgmnam);
X04                   When pgmtype= '*PGM   ';
                         un_pgm(pgmlib:pgmnam);
X04                   Other;
                         Iter;
E04                Endsl;
                   //?ordr = 0                   ;
                   //?actgrp=  ''                   ;
                   //?pgmnam = ''                 ;
                   //?pgmlib = ''                ;
                   //?pgmtyp = '*MODULE' ;
                   //?* write one line
                   //? ran01b = ran01b + 1;
                   //? Write sflb ;
X03             When w2flsp = '40';
                   //?last line for subfile
                   w2flsp = '50';
                   //?close the api
B04                If p_api = 'QWVOLACT';
                      ech.available=0;
                      QGYCLST( oli.Request_handle
                         : ech );
B05                   If ech.available > 0;
B06                      If %Subst(ech.MSGID:1:3)='GUI';
                            message(ech.MSGID:ech.msgdta:'':'QGUIMSG');
X06                      Else;
                            message(ech.MSGID:ech.msgdta:'':'QCPFMSG');
E06                      Endif;
E05                   Endif;
E04                Endif;
                   ranw1b = ran01b ;
B04                If ran01b >= 1;
                      clrsfl = *off;
                      dspsfl = *on;
                      sflend = *on;
                      ran01b = ranp1b;
X04                Else;
                      clrsfl = *off;
                      dspsfl = *off;
                      sflend = *off;
                      message ('SEL0002') ;
E04                Endif;
X03             When w2flsp = '50';
                   //?show
                   w2flsp = '60';
                   //?Fkey tool bar
                   Write fmtkb ;
X03             When w2flsp = '60';
                   //?show again
                   w2flsp = '70';
                   Write pmqctl;//?program message queue
                   Exfmt ctlb ;//?
                   Callp pmqcln() ;//?
                   //?controles
                   //?* rollup
                   limite = *off;
B04                If rollup = *on ;
B05                   If sflend = *off;
                         ranp1b = 1 +ranw1b ;
                         w2flsp = '30';
                         Iter ;
X05                   Else;
                         w2flsp = '50';
                         ran01b = ranw1b;
                         Iter ;
E05                   Endif;
E04                Endif;
                   //?F3=quit, exit, annulation
B04                If *inkc = *on;
                      w0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F12=F3
B04                If *inkl = *on;
                      w0flsp = *blank;
                      Iter;
E04                Endif;
                   //?F5=refresh
B04                If *inke = *on ;
                      w2flsp = '00';
                      Iter;
E04                Endif ;
X03             When w2flsp = '70';
                   //?work the subfile controler

                   w2flsp = '80';
B04                If ranw1b < 1 ;
                      message ('SEL0002');
                      w2flsp = '60';
                      Iter;
E04                Endif;
                   ranw2b = ranw1b;
B04                Dow 1=1;//?for ever loop
                      suppression = *off;
                      Readc(e) sflb;
B05                   If %Eof;
                         Leave;
E05                   Endif;
                      //?something to do ?
B05                   If zbsele <> *blank;
                         //?work
                         cmde='';
B06                      If zbsele = '2';
                            cmde='Wrkobj ' + %Trim(pgmlib) + '/' +
                               pgmnam + ' ' + pgmtyp;
E06                      Endif;
B06                      If zbsele = '5';
                            cmde='dspobjd ' + %Trim(pgmlib) + '/' +
                               pgmnam + ' ' + pgmtyp;
E06                      Endif;
B06                      If zbsele = '6';
B07                         Select;
X07                            When pgmtype= '*SRVPGM   ';
                                  cmde='dspsrvpgm  ' + %Trim(pgmlib) + '/' +
                                     pgmnam ;
X07                            When pgmtype= '*PGM   ';
                                  cmde='dsppgm  ' + %Trim(pgmlib) + '/' +
                                     pgmnam ;
X07                            When pgmtype= '*MODULE';
                                  cmde='dspmod  ' + %Trim(pgmlib) + '/' +
                                     pgmnam ;
E07                         Endsl;
E06                      Endif;
B06                      If zbsele = 'R';
B07                         If p_qua_job='*';
                               cmde='rclactgrp ' + actgrp ;
                               w2flsp = '00';
E07                         Endif;
E06                      Endif;
B06                      If cmde <>'';
                            rc = c_system(cmde );
B07                         If rc <> 0;
                               message (MSGID:'':'*LIBL':'QCPFMSG');
E07                         Endif;
E06                      Endif;

                         zbsele = ' ';
                         //?other fields : in sp030
                         Update sflb ;
E05                   Endif ;
E04                Enddo ;

X03             When w2flsp = '80';
                   //?HERE change the field list from CTLB
                   //?refresh requested ? (ctlb changed)







                   //?validation  HERE choose the exit
                   //?     w0flsp = *blank ;// exit program
                   w2flsp = '50';//?show again
                   Iter;
X03             Other ;
                   //?exit
                   //?paok   = *off   ;
                   w0flsp = *blank ;
E03          Endsl ;
E02       Enddo ;
E01    Endsr;
       //?---------------------------------------------------------------
       //?begsr        ;



       //?endsr;
       //?---------------------------------------------------------------
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
BPR ?p un_pgm          b
     d                 pi
     d p_lib                         10
     d p_nam                         10
    ? *-------------------------------
     d QualPgm         s             20
     d lah             ds                  likeds(ListApiHeader) based(pLAH)





      /free
        if p_lib = *loval;
           return;
        endif;
       QualPgm = p_nam + p_lib ;
       //? get program info - list of all modules
       QBNLPGMI (PgmList
          : 'PGML0100'
          : QualPgm
          : ech
          );
B01    If ech.available > 0;
B02       If ech.MSGID = 'CPF5CF5';
             //?pas un programme ILE.
X02       Else;
             message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG');
             return;
E02       Endif;
E01    Endif;
       //? for each module
       qusptrus(PgmList : pLAH);
B01    For i = 0 to lah.count - 1;
          pPGML0100 = pLAH + lah.data_offset + i * lah.entry_size ;

          //?//  retrieve module info
          //?ben non, ce qu'on veut, c'est les infos qui sont dans le PGM
          //?ech.available=0;
          //?qbnrmodi(MODI0100
          //?   : %Size(MODI0100)
          //?   : 'MODI0100'
          //?   : PGML0100.Module_name + PGML0100.MODULE_LIB
          //?   : ech
          //?   );
          //?If ech.available > 0;
          //?            ordr = 0                   ;
          //?            actgrp=  ech.msgid                ;
          //?            pgmnam = pgml0100.Module_name   ;
          //?            pgmlib = pgml0100.Module_lib     ;
          //?            pgmtyp = '*MODULE' ;
          //?            text   = ech.msgdta               ;
          //? else;
          ordr = 0 ;
          actgrp= PGML0100.Close_SQL_cursors ;
          pgmnam = PGML0100.Module_name ;
          pgmlib = PGML0100.Module_lib ;
          pgmtyp = '*MODULE' ;
          Text = PGML0100.Module_attr ;
          //?endif;
          //?* write one line
          ran01b = ran01b + 1;
          Write sflb ;

E01    Endfor;


      /end-free
EPR  p                 e
BPR ?p un_srvpgm       b
     d                 pi
     d p_lib                         10
     d p_nam                         10
    ? *-------------------------------
     d QualPgm         s             20
     d lah             ds                  likeds(ListApiHeader) based(pLAH)





      /free
        if p_lib = *loval;
           return;
        endif;
       QualPgm = p_nam + p_lib ;
       //? get program info - list of all modules
       qbnlspgm (PgmList
          : 'SPGL0100'
          : QualPgm
          : ech
          );
B01    If ech.available > 0;
B02       If ech.MSGID = 'CPF5CF5';
             //?pas un programme ILE.
X02       Else;
             message(ech.MSGID:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE');
E02       Endif;
E01    Endif;
       //? for each module
       qusptrus(PgmList : pLAH);
B01    For i = 0 to lah.count - 1;
          pPGML0100 = pLAH + lah.data_offset + i * lah.entry_size ;

          ordr = 0 ;
          actgrp= PGML0100.Close_SQL_cursors ;
          pgmnam = PGML0100.Module_name ;
          pgmlib = PGML0100.Module_lib ;
          pgmtyp = '*MODULE' ;
          Text = PGML0100.Module_attr ;
          //?* write one line
          ran01b = ran01b + 1;
          Write sflb ;

E01    Endfor;
      /end-free
EPR  p                 e
