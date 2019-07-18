


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE

     fT_MODI0100o    e             disk    usropn extfile(f_MODI0100)
     f                                     rename(t_MODI0100:MODI0100f)
     f                                     prefix('MI1.')
     fT_MODL0100o    e             disk    usropn extfile(f_MODL0100)
     f                                     rename(t_MODL0100:MODL0100f)
     f                                     prefix('ML1.')
     fT_MODL0200o    e             disk    usropn extfile(f_MODL0200)
     f                                     rename(t_MODL0200:MODL0200f)
     f                                     prefix('ML2.')
     fT_MODL0300o    e             disk    usropn extfile(f_MODL0300)
     f                                     rename(t_MODL0300:MODL0300f)
     f                                     prefix('ML3.')
     fT_MODL0400o    e             disk    usropn extfile(f_MODL0400)
     f                                     rename(t_MODL0400:MODL0400f)
     f                                     prefix('ML4.')
     fT_MODL0500o    e             disk    usropn extfile(f_MODL0500)
     f                                     rename(t_MODL0500:MODL0500f)
     f                                     prefix('ML5.')
     fT_vewl0100o    e             disk    usropn extfile(f_vewl0100)
     f                                     rename(t_vewl0100:vewl0100f)
     f                                     prefix('VW1.')
     fT_PGMI0100o    e             disk    usropn extfile(f_PGMI0100)
     f                                     rename(t_PGMI0100:PGMI0100f)
     f                                     prefix('PI1.')
     fT_SPGI0100o    e             disk    usropn extfile(f_SPGI0100)
     f                                     rename(t_SPGI0100:SPGI0100f)
     f                                     prefix('SI1.')
     fT_PGML0100o    e             disk    usropn extfile(f_PGML0100)
     f                                     rename(t_PGML0100:PGML0100f)
     f                                     prefix('PL1.')
     fT_PGML0200o    e             disk    usropn extfile(f_PGML0200)
     f                                     rename(t_PGML0200:PGML0200f)
     f                                     prefix('PL2.')
     fT_PGML0300o    e             disk    usropn extfile(f_PGML0300)
     f                                     rename(t_PGML0300:PGML0300f)
     f                                     prefix('PL3.')
     fT_PGML0400o    e             disk    usropn extfile(f_PGML0400)
     f                                     rename(t_PGML0400:PGML0400f)
     f                                     prefix('PL4.')
     fT_PGML0500o    e             disk    usropn extfile(f_PGML0500)
     f                                     rename(t_PGML0500:PGML0500f)
     f                                     prefix('PL5.')
     fT_SPGL0600o    e             disk    usropn extfile(f_SPGL0600)
     f                                     rename(t_SPGL0600:SPGL0600f)
     f                                     prefix('SL6.')
     fT_SPGL0700o    e             disk    usropn extfile(f_SPGL0700)
     f                                     rename(t_SPGL0700:SPGL0700f)
     f                                     prefix('SL7.')
     fT_SPGL0800o    e             disk    usropn extfile(f_SPGL0800)
     f                                     rename(t_SPGL0800:SPGL0800f)
     f                                     prefix('SL8.')

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

     d f_MODI0100      s             21
     d f_MODL0100      s             21
     d f_MODL0200      s             21
     d f_MODL0300      s             21
     d f_MODL0400      s             21
     d f_MODL0500      s             21
     d f_PGMI0100      s             21
     d f_vewl0100      s             21
     d f_SPGI0100      s             21
     d f_PGML0100      s             21
     d f_PGML0200      s             21
     d f_PGML0300      s             21
     d f_PGML0400      s             21
     d f_PGML0500      s             21
     d f_SPGL0600      s             21
     d f_SPGL0700      s             21
     d f_SPGL0800      s             21
     d MI1           e ds                  extname(t_MODI0100:*output) qualified
     d ML1           e ds                  extname(t_MODL0100:*output) qualified
     d ML2           e ds                  extname(t_MODL0200:*output) qualified
     d ML3           e ds                  extname(t_MODL0300:*output) qualified
     d ML4           e ds                  extname(t_MODL0400:*output) qualified
     d ML5           e ds                  extname(t_MODL0500:*output) qualified
     d PI1           e ds                  extname(t_PGMI0100:*output) qualified
     d vw1           e ds                  extname(t_vewl0100:*output) qualified
     d SI1           e ds                  extname(t_SPGI0100:*output) qualified
     d PL1           e ds                  extname(t_PGML0100:*output) qualified
     d PL2           e ds                  extname(t_PGML0200:*output) qualified
     d PL3           e ds                  extname(t_PGML0300:*output) qualified
     d PL4           e ds                  extname(t_PGML0400:*output) qualified
     d PL5           e ds                  extname(t_PGML0500:*output) qualified
     d SL6           e ds                  extname(t_SPGL0600:*output) qualified
     d SL7           e ds                  extname(t_SPGL0700:*output) qualified
     d SL8           e ds                  extname(t_SPGL0800:*output) qualified



     d ech             ds                  likeds(eRRORCODEHANDLER) inz(*likeds)








    ? * List Module Information (QBNLMODI) API
     d QBNLMODI        pr                  extpgm('QBNLMODI')
     d usrspc                        20    const
     d format                         8    const
     d QualPgm                       20    const
     d Error_code                   255           options( *varsize )

     d MODL0100        ds          5000    qualified based(pMODL0100)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   symbol_type                  1
     d   Reserved                     3
     d   symbol_off                  10i 0
     d   symbol_len                  10i 0
     d   ARGOPT                      10
    ?d*  Reserved CHAR(*)
    ?d*  Exported defined symbol name CHAR(*)

     d MODL0200        ds          5000    qualified based(pMODL0200)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   symbol_type                  1
     d   Reserved                     3
     d   symbol_off                  10i 0
     d   symbol_len                  10i 0
     d   argopt                      10
    ?d*  Reserved CHAR(*)
    ?d*  Imported (unresolved) symbol name CHAR(*)

     d MODL0300        ds          5000    qualified based(pMODL0300)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   type                         1
     d   Reserved                     3
     d   procedure_off...
     d                               10i 0
     d   procedure_len...
     d                               10i 0
     d   argopt                      10
    ?d*  Reserved CHAR(*)
    ?d*  Procedure name CHAR(*)

     d MODL0400        ds          5000    qualified based(pMODL0400)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   object_type                 10
     d   Object_lib                  10
     d   name_off                    10i 0
     d   name_len                    10i 0
    ?d*  Reserved CHAR(*)
    ?d*  Object name CHAR(*)

     d MODL0500        ds          5000    qualified based(pMODL0500)
     d   entry_size                  10i 0
     d   Module                      10
     d   Module_lib                  10
     d   copyright_off...
     d                               10i 0
     d   copyright_len...
     d                               10i 0
    ?d*  Reserved CHAR(*)
    ?d*  Copyright CHAR(*)

    ? * Retrieve Module Information (QBNRMODI) API
     d qbnrmodi        pr                  extpgm('QBNRMODI')
     d   receiver                 30000          options( *varsize )
     d   receiverlen                 10i 0 const
     d   format                       8    const
     d   QualMod                     20    const
     d   Error_Code                 256          options(*varsize)

     d MODI0100        ds          5000    qualified
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
     d Conversion_details...
     d                                1
     d Allow_RTVCLSRC...
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

     d  PGML0300       ds                  qualified based(pPGML0300)
     d  Program                      10
     d  Program_lib                  10
     d  export_size                  10i 0
     d  export_ccsid                 10i 0
     d  export_length                10i 0
     d  export_name                 256
     d
     d  PGML0400       ds                  qualified based(pPGML0400)
     d  Program                      10
     d  Program_lib                  10
     d  import_ccsid                 10i 0
     d  import_length                10i 0
     d  import_name                 256
     d
     d  PGML0500       ds                  qualified based(pPGML0500)
     d  Program                      10
     d  Program_lib                  10

     d  Copyright_len                10i 0
     d  Copyright                   256
     d
     d  SPGL0600       ds                  qualified based(pSPGL0600)
     d  Service_program...
     d                               10
     d  Service_program_library...
     d                               10
     d  Procedure_export_CCSID...
     d                               10i 0
     d  Procedure_export_name_length...
     d                               10i 0
     d  Procedure_export_name...
     d                              256
     d  Uses_argument_optimization...
     d                               10
     d
     d  SPGL0700       ds                  qualified based(pSPGL0700)
     d  Service_program_name...
     d                               10
     d  Service_program_library...
     d                               10
     d  Data_item_CCSID...
     d                               10i 0
     d  Data_item_name_length...
     d                               10i 0
     d  Data_item_name...
     d                              256
     d  SPGL0800       ds                  qualified based(pSPGL0800)
     d  Service_program_name...
     d                               10
     d  Service_program_library...
     d                               10
     d  Signature...
     d                               16

    ? * List Service Program Information (QBNLSPGM) API
     d qbnlspgm        pr                  extpgm('QBNLSPGM')
     d   UserSpace                   20    const
     d   format                       8    const
     d   QualSrvPgm                  20    const
     d   Error_Code                 256          options(*varsize)

    ? * returns char representation of any hexadecimal string
     D Chr2Hex         Pr                  ExtProc('cvthc')
     D  Tgt                         100    options(*varsize)
     D  Src                         100    options(*varsize)
     D  TgtLen                       10i 0 Value







      * Retrieve Module Views (QteRetrieveModuleViews) API
     d QteRetrieveModuleViews...
     d                 pr                  extproc('QteRetrieveModuleViews')
     d  Receiver                    100    options(*varsize)
     d  ReceiverLen                  10i 0 const
     d  Format                        8    const
     d  QualProgram                  20    const
     d  type                         10    const
     d  Module                       10    const
     d  RtnLib                       10
     d  Errorcode                   256    options(*varsize)

     d vewl0100        ds          1000    qualified
     d   returned                    10i 0
     d   available                   10i 0
     d   count                       10i 0
     d   views                        1

     d vewl0100e       ds                  qualified based(pvewl0100e)
     d   Module                      10
     d   Viewtype                    10
     d   CompilerID                  20
     d   Main                        10
     d   Viewtimes                   13
     d   description                 50
     d   Reserved1                    3
     d   Viewnumber                  10i 0
     d   viewcount                   10i 0


    ? * Retrieve Program Information (QCLRPGMI) API
     d QCLRPGMI        pr                  extpgm('QCLRPGMI')
     d   receiver                 30000          options( *varsize )
     d   receiverlen                 10i 0 const
     d   format                       8    const
     d   QualPgm                     20    const
     d   Error_Code                 256          options(*varsize)

     d PGMI0100        ds                  qualified
     d Bytes_returned...
     d                               10i 0
     d Bytes_available...
     d                               10i 0
     d Program_name...
     d                               10
     d Program_library_name...
     d                               10
     d Program_owner...
     d                               10
     d Program_attribute...
     d                               10
     d Creation_date_and_time...
     d                               13
     d Source_file_name...
     d                               10
     d Source_file_library_name...
     d                               10
     d Source_file_member_name...
     d                               10
     d Source_file_updated_date_and_time...
     d                               13
     d Observable_information...
     d                                1
     d User_profile_option...
     d                                1
     d Use_adopted_authority...
     d                                1
     d Log_commands...
     d                                1
     d Allow_RTVCLSRC...
     d                                1
     d Fix_decimal_data...
     d                                1
     d Text_description...
     d                               50
     d Type_of_program...
     d                                1
     d Teraspace_storage_enabled_program...
     d                                1
     d Reserved1...
     d                               58
     d Minimum_number_of_parameters...
     d                               10i 0
     d Maximum_number_of_parameters...
     d                               10i 0
     d Program_size...
     d                               10i 0
     d Associated_space_size...
     d                               10i 0
     d Static_storage_size...
     d                               10i 0
     d Automatic_storage_size...
     d                               10i 0
     d Number_of_MI_instructions...
     d                               10i 0
     d Number_of_MI_ODT_entries...
     d                               10i 0
     d Program_state...
     d                                1
     d Compiler_identification...
     d                               14
     d Earliest_release_program_can_run...
     d                                6
     d Sort_sequence_table_name...
     d                               10
     d Sort_sequence_table_library_name...
     d                               10
     d Language_identifier...
     d                               10
     d Program_domain...
     d                                1
     d Conversion_required...
     d                                1
     d Conversion_details...
     d                                1
     d Reserved2...
     d                               19
     d Optimization...
     d                                1
     d Paging_pool...
     d                                1
     d Update_program_automatic_storage_area_...
     d                                1
     d Clear_program_automatic_storage_area_...
     d                                1
     d Paging_amount...
     d                                1
     d Reserved3...
     d                               18
     d Program_entry_procedure_module...
     d                               10
     d Program_entry_procedure_module_library...
     d                               10
     d Activation_group_attribute...
     d                               30
     d Observable_information_compressed...
     d                                1
     d Run_time_information_compressed...
     d                                1
     d Release_program_created_on...
     d                                6
     d Shared_activation_group...
     d                                1
     d Allow_update...
     d                                1
     d Program_CCSID...
     d                               10i 0
     d Number_of_modules...
     d                               10i 0
     d Number_of_service_programs...
     d                               10i 0
     d Number_of_copyrights...
     d                               10i 0
     d Number_of_unresolved_references...
     d                               10i 0
     d Release_program_created_for...
     d                                6
     d Allow_static_storage_reinitialization...
     d                                1
     d All_creation_data...
     d                                1
     d Allow_bound_SRVPGM_library_name_update...
     d                                1
     d Profiling_data...
     d                               10
     d Teraspace_storage_enabled_modules...
     d                                1
     d Storage_model...
     d                                1
     d Uses_argument_optimization...
     d                               10
     d Reserved4...
     d                               77
     d
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

     d ObjList         s             20    inz('OBJLIST   QTEMP     ')
     d PgmList         s             20    inz('PGMLIST   QTEMP     ')
     d srvList         s             20    inz('SRVLIST   QTEMP     ')
     d MySQL           s           5000
     d xdat            ds                  qualified
     d cc                      1      2s 0
     d c                       2      2s 0
     d dat                     1     14s 0
     d x13                     2     14

     d Cmd             s           5000    varying
     d execute         pr
     d  cmd                        5000    varying const

     d Do_Objlist      pr
     d   type                        10    const

     d un_Module       pr
     d   mod                         10    const
     d   lib                         10    const
     d un_Pgm          pr
     d   pgm                         10    const
     d   lib                         10    const
     d un_SrvPgm       pr
     d   srv                         10    const
     d   lib                         10    const

     d  SPGIobj        s             20

     d rtvpgmr         pr
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_MODI0100                    20
     d p_MODL0100                    20
     d p_MODL0200                    20
     d p_MODL0300                    20
     d p_MODL0400                    20
     d p_MODL0500                    20
     d p_PGMI0100                    20
     d p_vewl0100                    20
     d p_SPGI0100                    20
     d p_PGML0100                    20
     d p_PGML0200                    20
     d p_PGML0300                    20
     d p_PGML0400                    20
     d p_PGML0500                    20
     d p_SPGL0600                    20
     d p_SPGL0700                    20
     d p_SPGL0800                    20

     d rtvpgmr         pi
     d p_OBJ                         20
     d p_TYPE                        10
     d p_mbropt                      10
     d p_MODI0100                    20
     d p_MODL0100                    20
     d p_MODL0200                    20
     d p_MODL0300                    20
     d p_MODL0400                    20
     d p_MODL0500                    20
     d p_PGMI0100                    20
     d p_vewl0100                    20
     d p_SPGI0100                    20
     d p_PGML0100                    20
     d p_PGML0200                    20
     d p_PGML0300                    20
     d p_PGML0400                    20
     d p_PGML0500                    20
     d p_SPGL0600                    20
     d p_SPGL0700                    20
     d p_SPGL0800                    20

    ?**-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )

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

    ? *List Objects (QUSLOBJ) API
     d quslobj         pr                  extpgm('QUSLOBJ')
     d   usp                         20    const
     d   Format                       8    const
     d   qualobjname                 20    const
     d   objtype                     10    const
     d   Error_Code                1000    const options(*nopass:*varsize)
     d   Authority                 1000    const options(*nopass:*varsize)
     d   Selection                 1000    const options(*nopass:*varsize)
     d   ASP                       1000    const options(*nopass:*varsize)

     d OBJL0100        ds                  qualified based(pOBJL0100)
     d   name                        10
     d   lib                         10
     d   type                        10

     D QCmdExc         PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST

     d cleanup_outfile...
     d                 pr
     d   qualfile                    20    const
     d   modele                      10    const
     d   mbropt                      10    const
     d   text                        50    const

     d x10             s             10










     c/free

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl
          ;
       f_MODI0100 = %Trim(%Subst(p_MODI0100:11:10))
          +'/'+%Subst(p_MODI0100:01:10);
       f_MODL0100 = %Trim(%Subst(p_MODL0100:11:10))
          +'/'+%Subst(p_MODL0100:01:10);
       f_MODL0200 = %Trim(%Subst(p_MODL0200:11:10))
          +'/'+%Subst(p_MODL0200:01:10);
       f_MODL0300 = %Trim(%Subst(p_MODL0300:11:10))
          +'/'+%Subst(p_MODL0300:01:10);
       f_MODL0400 = %Trim(%Subst(p_MODL0400:11:10))
          +'/'+%Subst(p_MODL0400:01:10);
       f_MODL0500 = %Trim(%Subst(p_MODL0500:11:10))
          +'/'+%Subst(p_MODL0500:01:10);
       f_PGMI0100 = %Trim(%Subst(p_PGMI0100:11:10))
          +'/'+%Subst(p_PGMI0100:01:10);
       f_vewl0100 = %Trim(%Subst(p_vewl0100:11:10))
          +'/'+%Subst(p_vewl0100:01:10);
       f_SPGI0100 = %Trim(%Subst(p_SPGI0100:11:10))
          +'/'+%Subst(p_SPGI0100:01:10);
       f_PGML0100 = %Trim(%Subst(p_PGML0100:11:10))
          +'/'+%Subst(p_PGML0100:01:10);
       f_PGML0200 = %Trim(%Subst(p_PGML0200:11:10))
          +'/'+%Subst(p_PGML0200:01:10);
       f_PGML0300 = %Trim(%Subst(p_PGML0300:11:10))
          +'/'+%Subst(p_PGML0300:01:10);
       f_PGML0400 = %Trim(%Subst(p_PGML0400:11:10))
          +'/'+%Subst(p_PGML0400:01:10);
       f_PGML0500 = %Trim(%Subst(p_PGML0500:11:10))
          +'/'+%Subst(p_PGML0500:01:10);
       f_SPGL0600 = %Trim(%Subst(p_SPGL0600:11:10))
          +'/'+%Subst(p_SPGL0600:01:10);
       f_SPGL0700 = %Trim(%Subst(p_SPGL0700:11:10))
          +'/'+%Subst(p_SPGL0700:01:10);
       f_SPGL0800 = %Trim(%Subst(p_SPGL0800:11:10))
          +'/'+%Subst(p_SPGL0800:01:10);

       cleanup_outfile(p_MODI0100: 'T_MODI0100':p_mbropt
          :'Module Information Outfile                 ');
       cleanup_outfile(p_MODL0100: 'T_MODL0100':p_mbropt
          :'MODs: Exported Symbols                     ');
       cleanup_outfile(p_MODL0200: 'T_MODL0200':p_mbropt
          :'MODs: unresolved Symbols                   ');
       cleanup_outfile(p_MODL0300: 'T_MODL0300':p_mbropt
          :'MODs: procedures                           ');
       cleanup_outfile(p_MODL0400: 'T_MODL0400':p_mbropt
          :'MODs: referenced objects                   ');
       cleanup_outfile(p_MODL0500: 'T_MODL0500':p_mbropt
          :'MODs: the copyrights                       ');
       cleanup_outfile(p_PGMI0100: 'T_PGMI0100':p_mbropt
          :'Program Information Outfile                ');
       cleanup_outfile(p_vewl0100: 'T_vewl0100':p_mbropt
          :'Debug Views Outfile                        ');
       cleanup_outfile(p_SPGI0100: 'T_SPGI0100':p_mbropt
          :'Service Pgm Info Outfile                   ');
       cleanup_outfile(p_PGML0100: 'T_PGML0100':p_mbropt
          :'SRV & PGM: the modules                     ');
       cleanup_outfile(p_PGML0200: 'T_PGML0200':p_mbropt
          :'SRV & PGM: the service pgms                ');
       cleanup_outfile(p_PGML0300: 'T_PGML0300':p_mbropt
          :'SRV & PGM: items exported                  ');
       cleanup_outfile(p_PGML0400: 'T_PGML0400':p_mbropt
          :'SRV & PGM: item imports                    ');
       cleanup_outfile(p_PGML0500: 'T_PGML0500':p_mbropt
          :'SRV & PGM: the copyrights                  ');
       cleanup_outfile(p_SPGL0600: 'T_SPGL0600':p_mbropt
          :'SRVPGM: procedure export info              ');
       cleanup_outfile(p_SPGL0700: 'T_SPGL0700':p_mbropt
          :'SRVPGM: Data Export info                   ');
       cleanup_outfile(p_SPGL0800: 'T_SPGL0800':p_mbropt
          :'SRVPGM: Signature info                     ');

       //? create the user space
       Quscrtus (ObjList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib : ObjList : Attributes : ech );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Quscrtus (PgmList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib : PgmList : Attributes : ech );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Quscrtus (srvList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //? with attribute auto-extensible
       Quscusat ( lib : srvList : Attributes : ech );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Open(E) T_modi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_modl0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_modl0200;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_modl0300;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_modl0400;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_modl0500;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgmi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_vewl0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_spgi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgml0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgml0200;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgml0300;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgml0400;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_pgml0500;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_spgl0600;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_spgl0700;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Open(E) T_spgl0800;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

B01    If p_TYPE = '*MODULE' Or p_TYPE = '*ALL';
          Do_Objlist('*MODULE');
E01    Endif;
B01    If p_TYPE = '*PGM   ' Or p_TYPE = '*ALL';
          Do_Objlist('*PGM   ');
E01    Endif;
B01    If p_TYPE = '*SRVPGM' Or p_TYPE = '*ALL';
          Do_Objlist('*SRVPGM');
E01    Endif;

       Close(E) T_modi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_modl0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_modl0200;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_modl0300;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_modl0400;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_modl0500;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgmi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_vewl0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_spgi0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgml0100;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgml0200;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgml0300;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgml0400;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_pgml0500;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_spgl0600;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_spgl0700;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Close(E) T_spgl0800;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       Qusdltus (ObjList:ech);
       Qusdltus (PgmList:ech);
       Qusdltus (srvList:ech);
       Return;
    ? /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

     p cleanup_outfile...
BPR ?p                 b
     d                 pi
     d   qualfile                    20    const
     d   modele                      10    const
     d   mbropt                      10    const
     d   text                        50    const
      /free

       //?check object exists
       RtvObjD( OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : qualfile
          : '*FILE'
          : ech
          );
B01    If ech.available>0;
B02       If ech.Msgid <> 'CPF9812';
            Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
X02       Else;
             //?file is unknown, create it
             //?CRTDUPOBJ OBJ(T_MODI0100) FROMLIB(pgm_LIB) OBJTYPE(*FILE) TOLIB(TOLIB)
             Cmd = 'CRTDUPOBJ OBJ('+ modele + ') FROMLIB('
                + Sppglb + ') OBJTYPE(*FILE) TOLIB('
                + %Trim(%Subst(qualfile :11:10)) + ') NEWOBJ('
                + %Trim(%Subst(qualfile :01:10)) + ')';
             QCmdExc ( Cmd : %Len(Cmd));
E02       Endif;
X01    Else;
          //?mode append ?
          if mbropt = '*REPLACE';
          MySQL = 'delete from  '
             + %trim(%Subst(qualfile :11:10)) + '/'
             + %trim(%Subst(qualfile :01:10)) ;
          Exec Sql execute Immediate : MySQL;
B02       If Sqlcode <> 0 And Sqlcode <> 100;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          endif;
E01    Endif;
       // LABEL ON TABLE QJRN_UTILS/MODL0300 IS 'MODs: procedures'
          MySQL = 'label on table '
             + %trim(%Subst(qualfile :11:10)) + '/'
             + %trim(%Subst(qualfile :01:10))
             + ' is ''' + text + '''';
          Exec Sql execute Immediate : MySQL;
B02       If Sqlcode <> 0 And Sqlcode <> 100;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e




BPR ?p do_objlist      b
    ? *=-----------------------------------------------------------------------
     d do_objlist      pi
     d   type                        10    const
    ?d*=---------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d i               s              5i 0
      /free
       ech .available=0;
       quslobj
          (ObjList
          :'OBJL0100'
          :p_OBJ   //?parametre pgm
          : type   //?parametre proc
          :ech
          );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;


       //? for each object
       Qusptrus(ObjList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pOBJL0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
B02       If OBJL0100.type = '*MODULE';
             un_Module (OBJL0100.name:OBJL0100.lib );
X02       Elseif OBJL0100.type = '*PGM';
             un_Pgm (OBJL0100.name:OBJL0100.lib );
X02       Elseif OBJL0100.type = '*SRVPGM';
             un_SrvPgm (OBJL0100.name:OBJL0100.lib );
E02       Endif;
E01    Endfor;
B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e


BPR ?p un_pgm          b
     d                 pi
     d   pgm                         10    const
     d   lib                         10    const

     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d lah2            ds                  likeds(ListApiHeader) based(pLAH2)
     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       //? Retrieve Program Information
       ech.available=0;
       QCLRPGMI
          ( PGMI0100
          : %Len(PGMI0100)
          : 'PGMI0100'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       //?export API data to DS
       PI1.pgm = PGMI0100.Program_name ;
       PI1.Pgmlib = PGMI0100.Program_library_name ;
       PI1.Owner = PGMI0100.Program_owner ;
       PI1.Pgmattr = PGMI0100.Program_attribute ;
       PI1.Pgmdate = PGMI0100.Creation_date_and_time ;
       PI1.Srcfile = PGMI0100.Source_file_name ;
       PI1.Srclib = PGMI0100.Source_file_library_name ;
       PI1.Srcmbr = PGMI0100.Source_file_member_name ;
       PI1.Srcdate = PGMI0100.Source_file_updated_date_and_time ;
       PI1.Observable = PGMI0100.Observable_information ;
       PI1.Usrprf = PGMI0100.User_profile_option ;
       PI1.Adopt = PGMI0100.Use_adopted_authority ;
       PI1.Logcmd = PGMI0100.Log_commands ;
       PI1.Allowrtv = PGMI0100.Allow_RTVCLSRC ;
       PI1.Fixdecimal = PGMI0100.Fix_decimal_data ;
       PI1.Text = PGMI0100.Text_description ;
       PI1.type = PGMI0100.Type_of_program ;
       PI1.Terasapace = PGMI0100.Teraspace_storage_enabled_program ;
       PI1.Minparm = PGMI0100.Minimum_number_of_parameters ;
       PI1.Maxparm = PGMI0100.Maximum_number_of_parameters ;
       PI1.Pgmsize = PGMI0100.Program_size ;
       PI1.Assocsize = PGMI0100.Associated_space_size ;
       PI1.Staticsize = PGMI0100.Static_storage_size ;
       PI1.Automazise = PGMI0100.Automatic_storage_size ;
       PI1.Mi_inst = PGMI0100.Number_of_MI_instructions ;
       PI1.Mi_odt = PGMI0100.Number_of_MI_ODT_entries ;
       PI1.State = PGMI0100.Program_state ;
       PI1.Compil_id = PGMI0100.Compiler_identification ;
       PI1.Fromrls = PGMI0100.Earliest_release_program_can_run ;
       PI1.Srtseq = PGMI0100.Sort_sequence_table_name ;
       PI1.Srtseqlib = PGMI0100.Sort_sequence_table_library_name ;
       PI1.Langid = PGMI0100.Language_identifier ;
       PI1.Domain = PGMI0100.Program_domain ;
       PI1.Objcvn = PGMI0100.Conversion_required ;
       PI1.Cvndtl = PGMI0100.Conversion_details ;
       PI1.Optimize = PGMI0100.Optimization ;
       PI1.Pagingpool = PGMI0100.Paging_pool ;
       PI1.Upd_pasa = PGMI0100.Update_program_automatic_storage_area_ ;
       PI1.Clr_pasa = PGMI0100.Clear_program_automatic_storage_area_ ;
       PI1.Pagingamnt = PGMI0100.Paging_amount ;
       PI1.Pepmod = PGMI0100.Program_entry_procedure_module ;
       PI1.Pepmodlib = PGMI0100.Program_entry_procedure_module_library ;
       PI1.Actgrp = PGMI0100.Activation_group_attribute ;
       PI1.Observcpr = PGMI0100.Observable_information_compressed ;
       PI1.Runtimecpr = PGMI0100.Run_time_information_compressed ;
       PI1.Rlscrt = PGMI0100.Release_program_created_on ;
       PI1.Shractgrp = PGMI0100.Shared_activation_group ;
       PI1.Alwupd = PGMI0100.Allow_update ;
       PI1.Ccsid = PGMI0100.Program_CCSID ;
       PI1.Nbmod = PGMI0100.Number_of_modules ;
       PI1.Nbsrvpgm = PGMI0100.Number_of_service_programs ;
       PI1.Nbcpyrght = PGMI0100.Number_of_copyrights ;
       PI1.Nburef = PGMI0100.Number_of_unresolved_references ;
       PI1.Rlsfor = PGMI0100.Release_program_created_for ;
       PI1.Alwstaticr = PGMI0100.Allow_static_storage_reinitialization ;
       PI1.Allcrtdta = PGMI0100.All_creation_data ;
       PI1.Alwsrvupd = PGMI0100.Allow_bound_SRVPGM_library_name_update ;
       PI1.Profiledta = PGMI0100.Profiling_data ;
       PI1.Teraspace = PGMI0100.Teraspace_storage_enabled_modules ;
       PI1.Stgmodel = PGMI0100.Storage_model ;
       PI1.Useopti = PGMI0100.Uses_argument_optimization ;
       Write Pgmi0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;

       // get the list of debug views
       //? Retrieve Module Views
       ech.available=0;
       QteRetrieveModuleViews
          ( vewl0100
          : %Len(vewl0100)
          : 'VEWL0100'
          : pgm+lib
          : '*PGM'
          : '*ALL'
          : x10
          : ech
          );
B01    If ech.available > 0;
          if      ech.msgid  = 'CPF9584' // OPM not debuggable
          or      ech.msgid  = 'CPF9599' // CLASS not debuggable
          or      ech.msgid  = 'CPF955F';// not in debug mode
          vewl0100.count = 0;
          else;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
          endif;
E01    Endif;

       //?export API data to DS
       if           vewl0100.count > 0;
       for i = 0 to vewl0100.count - 1 ;
          pvewl0100e = %addr(vewl0100.views) + i * %size(vewl0100e);

       vw1.PGM        = PI1.pgm    ;
       vw1.PGMLIB     = PI1.Pgmlib ;
       vw1.PGMATTR    = PI1.Pgmattr;
       vw1.MOD        = vewl0100e.module      ;
       vw1.view_type  = vewl0100e.viewtype;
                        CHR2HEX
                       (vw1.COMPILER
                       :vewl0100e.CompilerID:20);
        select;
        when %subst(vw1.COMPILER : 1 : 8) =  '00050000'        ;
                    vw1.COMPILER =                'ILE C'       ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00050001'          ;
                    vw1.COMPILER =                'CSET C++'     ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00060000'          ;
                    vw1.COMPILER =                'ILE CL  '     ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00060001'          ;
                    vw1.COMPILER =                'OPM CL   '    ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00070000'          ;
                    vw1.COMPILER =                'OPM COBOL '   ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00070001'          ;
                    vw1.COMPILER =                'ILE COBOL  '  ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00170001'          ;
                    vw1.COMPILER =                'OPM RPG     ' ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00170002'          ;
                    vw1.COMPILER =                'ILE RPG      ';
        when %subst(vw1.COMPILER : 1 : 8) =  '001D0000'          ;
                    vw1.COMPILER =                'JAVA         ';
                    endsl;
       vw1.MAIN       = vewl0100e.Main          ;
       vw1.VIEW_STMP  = vewl0100e.Viewtimes      ;
       vw1.DESC       = vewl0100e.description     ;
       vw1.VIEW_ID    = vewl0100e.Viewnumber       ;
       Write vewl0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;




       endfor;
       endif;
          // if not an OPM, search for more information
          if PGMI0100.Type_of_program <> 'B';
             return;
          endif;

       //?The PGML0100 format includes information on all the modules that are bound into the
       //?programs specified. The modules will be listed in the user space in the order the modules
       //?are bound into the program. You must have a program authority of *USE to use this format.
       ech.available=0;
       //? get program info - list of all modules
       QBNLPGMI (PgmList
          : 'PGML0100'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? for each module
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0100 = pLAH + lah.Data_offset + i * lah.entry_size ;

          PL1.type = '*PGM' ;
          PL1.pgm = PGML0100.Program_name ;
          PL1.Pgmlib = PGML0100.Program_lib ;
          PL1.mod = PGML0100.Module_name ;
          PL1.Modlib = PGML0100.Module_lib ;
          PL1.Srcfile = PGML0100.Source_name ;
          PL1.Srclib = PGML0100.Source_lib ;
          PL1.Srcmbr = PGML0100.Source_member ;
          PL1.Modattr = PGML0100.Module_attr ;
          PL1.Moddate = PGML0100.Module_date ;
          PL1.Srcdate = PGML0100.Source_date ;
          PL1.Sort_name = PGML0100.Sort_name ;
          PL1.Sort_lib = PGML0100.Sort_lib ;
          PL1.Lang_id = PGML0100.Lang_id ;
          PL1.Optimize = PGML0100.Optimization ;
          PL1.Maxopt = PGML0100.Maximum_opt ;
          PL1.Debug_data = PGML0100.Debug_data ;
          PL1.Rlscrt = PGML0100.Release_on ;
          PL1.Rlsfor = PGML0100.Release_for ;

          PL1.User_modif = PGML0100.User_modif ;
          PL1.Licpgm = PGML0100.Licpgm ;
          PL1.PTF_number = PGML0100.PTF_number ;
          PL1.APAR_ID = PGML0100.APAR_ID ;
          PL1.Crtdata = PGML0100.Creation_data ;
          PL1.Modccsid = PGML0100.Module_CCSID ;
          PL1.Objctllvl = PGML0100.Object_control_level;
          PL1.perf_coll = PGML0100.perf_coll ;
          PL1.Prof_data = PGML0100.Prof_data ;
          PL1.Nb_proc = PGML0100.Nb_proc ;
          PL1.Nb_proc_r = PGML0100.Nb_proc_reordered ;
          PL1.Nb_proc_m = PGML0100.Nb_proc_measured ;
          PL1.Teraspace = PGML0100.Teraspace ;
          PL1.Stgmdl = PGML0100.Storage_model ;
          PL1.Nbsqlstm = PGML0100.Nb_SQL_stmt ;
          PL1.Rdb = PGML0100.Relational_database ;
          PL1.Commit = PGML0100.Commitment_control ;
          PL1.Allowcopy = PGML0100.Allow_copy_of_data ;
          PL1.Sqlclose = PGML0100.Close_SQL_cursors ;
          PL1.Sqlnaming = PGML0100.Naming_convention ;
          PL1.Datfmt = PGML0100.Date_format ;
          PL1.Datsep = PGML0100.Date_separator ;
          PL1.Timfmt = PGML0100.Time_format ;
          PL1.Timsep = PGML0100.Time_separator ;
          PL1.Sqlprep = PGML0100.Delay_PREPARE ;
          PL1.Allowblk = PGML0100.Allow_blocking ;
          PL1.Dftschema = PGML0100.Default_collection_name;
          PL1.Sqlpkg = PGML0100.SQL_package_name ;
          PL1.Sqlpkglib = PGML0100.SQL_package_lib ;
          PL1.Dymusrprf = PGML0100.Dynamic_user_profile ;
          PL1.Sqlsrts = PGML0100.SQL_sort_name ;
          PL1.Sqmsrtslib = PGML0100.SQL_sort_lib ;
          PL1.Sqllangid = PGML0100.SQL_lang_id ;
          PL1.Cnxmth = PGML0100.Connection_method ;
          len = PGML0100.SQL_path_length ;
          PL1.SQL_path = %Subst(PGML0100.SQL_path :1:len) ;
          Write Pgml0100f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The PGML0200 format includes information on all the service programs that are bound to the
       //?programs specified.
       ech.available=0;
       QBNLPGMI (PgmList
          : 'PGML0200'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0200 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL2.type = '*PGM' ;
          PL2.pgm = Pgml0200.Program_name ;
          PL2.Pgmlib = Pgml0200.Program_lib ;
          PL2.Srvpgm = Pgml0200.SrvPgm_name ;
          PL2.Srvpgmlib = Pgml0200.SrvPgm_lib ;
          PL2.Srcpgmsgn = Pgml0200.SrvPgm_Sign ;
          Write Pgml0200f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The PGML0300 format lists data items exported to the activation group. The list data items
       //?are specified in the data export entry in the binding specifications component when the
       //?module was created.
       ech.available=0;
       QBNLPGMI (PgmList
          : 'PGML0300'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0300 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL3.type = '*PGM' ;
          PL3.pgm = PGML0300.Program ;
          PL3.Pgmlib = PGML0300.Program_lib ;
          PL3.Exportsize = PGML0300.export_size ;
          PL3.Exportccid = PGML0300.export_ccsid ;
          PL3.Exportname = PGML0300.export_name ;
          Write Pgml0300f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The PGML0400 format lists data item imports that were resolved by weak exports that had
       //?been exported to an activation group.
       ech.available=0;
       QBNLPGMI (PgmList
          : 'PGML0400'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0400 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL4.type = '*PGM' ;
          PL4.pgm = PGML0400.Program ;
          PL4.Pgmlib = PGML0400.Program_lib ;
          PL4.Importccid = PGML0400.import_ccsid ;
          PL4.Importname = PGML0400.import_name ;
          Write Pgml0400f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The PGML0500 format includes copyright information for the ILE programs specified. The
       //?following table shows how this information is organized.
       ech.available=0;
       QBNLPGMI (PgmList
          : 'PGML0500'
          : pgm+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0500 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL5.type = '*PGM' ;
          PL5.pgm = PGML0500.Program ;
          PL5.Pgmlib = PGML0500.Program_lib ;
          PL5.Copyright = PGML0500.Copyright ;
          Write Pgml0500f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //? suite
       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e


BPR ?p un_module       b
     d                 pi
     d      Mod                      10    const
     d      lib                      10    const
     d len             s              5i 0
     d off             s              5i 0
     d i               s              5i 0
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d USP             s          65535    based(pUSP)
      /free
       ech.available=0;
       qbnrmodi(MODI0100
          : %Size(MODI0100)
          : 'MODI0100'
          : mod+lib
          : ech
          );
B01    If (ech.available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?export API data to DS
       MI1.mod = MODI0100. Module_name ;
       MI1.Modlib = MODI0100. Module_lib ;
       MI1.Modattr = MODI0100. Module_attr ;
       MI1.Moddate = MODI0100. Module_date ;
       MI1.Src = MODI0100. Source_name ;
       MI1.Srclib = MODI0100. Source_lib ;
       MI1.Srcmbr = MODI0100. Source_mbr ;
       MI1.Srcdate = MODI0100. Source_date ;
       MI1.Owner = MODI0100. Module_owner ;
       MI1.Csid = MODI0100. Module_CCSID ;
       MI1.Text = MODI0100. Text_description ;
       MI1.Crtdata = MODI0100. Creation_data ;
       MI1.Srtseq = MODI0100. Sort_sequence_table_name ;
       MI1.Srtseqlib = MODI0100. Sort_sequence_table_library_name ;
       MI1.Langid = MODI0100. Language_identifier ;
       MI1.Optlvl = MODI0100. Optimization_level ;
       MI1.Maxoptlvl = MODI0100. Maximum_optimization_level ;
       MI1.Debug_data = MODI0100. Debug_data ;
       MI1.Compressed = MODI0100. Module_compressed_status ;
       MI1.Minparm = MODI0100. Minimum_number_of_parameters ;
       MI1.Maxparm = MODI0100. Maximum_number_of_parameters ;
       MI1.Modstate = MODI0100. Module_state ;
       MI1.Moddomain = MODI0100. Module_domain ;
       MI1.Exportsym = MODI0100. Number_of_exported_defined_symbols ;
       MI1.Importsym = MODI0100. Number_of_imported_unresolved_symbols ;
       MI1.Rlscrt = MODI0100. Release_module_created_on ;
       MI1.Rlsfor = MODI0100. Release_module_created_for ;
       MI1.Rlsrst = MODI0100. Earliest_release_module_can_be_restored_to ;
       MI1.Perfcol = MODI0100. Enable_performance_collection ;
       MI1.Objcvn = MODI0100. Conversion_required ;
       MI1.Pepind = MODI0100. Program_entry_procedure_name_indicator ;
       MI1.Profildata = MODI0100. Profile_data ;
       MI1.Ildata = MODI0100. Intermediate_language_IL_data ;
       MI1.Teraspace = MODI0100. Teraspace_storage_enabled ;
       MI1.Storagemod = MODI0100. Storage_model ;
       MI1.Cnvdtl = MODI0100. Conversion_details ;
       MI1.Rtlclsrc = MODI0100.Allow_RTVCLSRC ;
       MI1.Nbsqlstm = MODI0100. Number_of_SQL_statements ;
       MI1.Rdb = MODI0100. Relational_database ;
       MI1.Commit = MODI0100. Commitment_control ;
       MI1.Allowcopy = MODI0100. Allow_copy_of_data ;
       MI1.Sqlclose = MODI0100. Close_SQL_cursor ;
       MI1.Sqlnaming = MODI0100. Naming_convention ;
       MI1.Datfmt = MODI0100. Date_format ;
       MI1.Datsep = MODI0100. Date_separator ;
       MI1.Timfmt = MODI0100. Time_format ;
       MI1.Timsep = MODI0100. Time_separator ;
       MI1.Sqlprep = MODI0100. Delay_PREPARE ;
       MI1.Allowblk = MODI0100. Allow_blocking ;
       MI1.Dftschema = MODI0100. Default_collection_name ;
       MI1.Sqlpkg = MODI0100. SQL_package_name ;
       MI1.Sqlpkglib = MODI0100. SQL_package_library_name ;
       MI1.Dymusrprf = MODI0100. Dynamic_user_profile ;
       MI1.Sqlsrts = MODI0100. SQL_sort_sequence_table_name ;
       MI1.Sqmsrtslib = MODI0100. SQL_sort_sequence_table_library_name ;
       MI1.Sqllangid = MODI0100. SQL_language_identifier ;
       MI1.Cnxmth = MODI0100. Connection_method ;
       off = MODI0100. Offset_to_program_entry_procedure_name ;
       len = MODI0100. Length_of_program_entry_procedure_name ;
B01    If len > %Size(MI1.Pepname);
          len = %Size(MI1.Pepname);
E01    Endif;
B01    If len > 0;
          MI1.Pepname = %Subst(MODI0100:off+1:len);
X01    Else;
          MI1.Pepname = '';
E01    Endif;
       off = MODI0100.Offset_to_Licensed_Internal_Code_options ;
       len = MODI0100.Length_of_Licensed_Internal_Code_options ;
B01    If len > %Size(MI1.Liccod );
          len = %Size(MI1.Liccod );
E01    Endif;
B01    If len > 0;
          MI1.Liccod = %Subst(MODI0100:off+1:len);
X01    Else;
          MI1.Liccod = '';
E01    Endif;
       off = MODI0100. SQL_path_offset;
       len = MODI0100. SQL_path_length;
B01    If len > %Size(MI1.SQL_path);
          len = %Size(MI1.SQL_path);
E01    Endif;
B01    If len > 0;
          MI1.SQL_path =%Subst(MODI0100:off+1:len);
X01    Else;
          MI1.SQL_path = '';
E01    Endif;
       Write Modi0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?The MODL0100 format lists the symbols defined in the module and that are exported to other
       //?modules
       ech.available=0;
       QBNLMODI (PgmList
          : 'MODL0100'
          : mod+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
       pMODL0100 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          ML1.Module = MODL0100.Module ;
          ML1.Modulelib = MODL0100.Module_lib ;
B02       Select;
X02          When MODL0100.symbol_type = X'00';
                ML1.Exporttype ='P';
X02          When MODL0100.symbol_type = X'01';
                ML1.Exporttype ='D';
X02          Other;
                ML1.Exporttype = MODL0100.symbol_type ;
E02       Endsl;
          ML1.ARGOPT = MODL0100.ARGOPT ;
          off = MODL0100.symbol_off;
          len = MODL0100.symbol_len ;
B02       If len > %Size(ML1.Export );
             len = %Size(ML1.Export );
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             ML1.Export = %Subst(usp:1:len);
X02       Else;
             MI1.Liccod = '';
E02       Endif;
          pMODL0100 += MODL0100.entry_size;
          Write Modl0100f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The MODL0200 format lists symbols defined external to the module
       //?IE  Imported (unresolved) symbol name
       ech.available=0;
       QBNLMODI (PgmList
          : 'MODL0200'
          : mod+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
       pMODL0200 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          ML2.Module = MODL0200.Module ;
          ML2.Module_lib = MODL0200.Module_lib ;
B02       Select;
X02          When MODL0200.symbol_type = X'00';
                ML2.Importtype = 'P';
X02          When MODL0200.symbol_type = X'01';
                ML2.Importtype = 'D';
X02          Other;
                ML2.Importtype = MODL0200.symbol_type ;
E02       Endsl;
          ML2.ARGOPT = MODL0200.ARGOPT ;
          off = MODL0200.symbol_off;
          len = MODL0200.symbol_len ;
B02       If len > %Size(ML2.Import );
             len = %Size(ML2.Import );
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             ML2.Import = %Subst(usp : 1:len);
X02       Else;
             ML2.Import = '';
E02       Endif;
          pMODL0200 += MODL0200.entry_size;
          Write Modl0200f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The MODL0300 format lists procedure names and their types
       //
       ech.available=0;
       QBNLMODI (PgmList
          : 'MODL0300'
          : mod+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
       pMODL0300 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          ML3.Module = MODL0300.Module ;
          ML3.Module_lib = MODL0300.Module_lib ;
B02       Select;
X02          When MODL0300.type =X'00';
                ML3.Proctype = 'R';
X02          When MODL0300.type =X'01';
                ML3.Proctype = 'E';
X02          Other;
                ML3.Proctype = MODL0300.type ;
E02       Endsl;
          ML3.ARGOPT = MODL0300.ARGOPT ;
          off = MODL0300.procedure_off ;
          len = MODL0300.procedure_len ;
B02       If len > %Size(ML3.Procname);
             len = %Size(ML3.Procname);
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             ML3.Procname= %Subst(usp : 1:len);
X02       Else;
             ML3.Procname= '';
E02       Endif;
          pMODL0300 += MODL0300.entry_size;
          Write Modl0300f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The MODL0400 format lists the objects that are referenced by the module when the module is
       //?bound to an ILE program or service program.
       ech.available=0;
       QBNLMODI (PgmList
          : 'MODL0400'
          : mod+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
       pMODL0400 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          ML4.Module = MODL0400.Module ;
          ML4.Module_lib = MODL0400.Module_lib ;
          ML4.ObjTyp = MODL0400.object_type ;
          ML4.Objlib = MODL0400.Object_lib ;
          off = MODL0400.name_off;
          len = MODL0400.name_len ;
B02       If len > %Size(ML4.Obj );
             len = %Size(ML4.Obj );
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             ML4.Obj = %Subst(usp : 1:len);
X02       Else;
             ML4.Obj = '';
E02       Endif;
          pMODL0400 += MODL0400.entry_size;
          Write Modl0400f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       //?The MODL0500 format lists the copyrights contained in the module.
       ech.available=0;
       QBNLMODI (PgmList
          : 'MODL0500'
          : mod+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
       pMODL0500 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          ML5.Module = MODL0500.Module ;
          ML5.Module_lib = MODL0500.Module_lib ;
          off = MODL0500.copyright_off ;
          len = MODL0500.copyright_len ;
B02       If len > %Size(ML5.Copyright);
             len = %Size(ML5.Copyright);
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             ML5.Copyright = %Subst(usp : 1:len);
X02       Else;
             ML5.Copyright = '';
E02       Endif;
          pMODL0500 += MODL0500.entry_size;
          Write Modl0500f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e

BPR ?p un_srvpgm       b
     d                 pi
     d      srv                      10    const
     d      lib                      10    const
    ? *=----------------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d lah2            ds                  likeds(ListApiHeader) based(pLAH2)
     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       //? Retrieve Program Information
       ech.available=0;
       QBNRSPGM
          ( SPGI0100
          : %Len(SPGI0100)
          : 'SPGI0100'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       SI1.srv = SPGI0100.Service_program_name ;
       SI1.Srvlib = SPGI0100.Service_program_library_name ;
       SI1.Owner = SPGI0100.Service_program_owner ;
       SI1.Srvattr = SPGI0100.Service_program_attribute ;
       SI1.Srvdate = SPGI0100.Creation_date_and_time ;
       SI1.Export = SPGI0100.Export_source_file_name ;
       SI1.Exportlib = SPGI0100.Export_source_file_library_name ;
       SI1.Exportmbr = SPGI0100.Export_source_file_member_name ;
       SI1.Actgrp = SPGI0100.Activation_group_attribute ;
       SI1.Signature = SPGI0100.Current_export_signature ;
       SI1.Usrprf = SPGI0100.User_profile ;
       SI1.Observcpr = SPGI0100.Observable_information_compressed ;
       SI1.Runtimecpr = SPGI0100.Run_time_information_compressed ;
       SI1.Ccsid = SPGI0100.Service_program_CCSID ;
       SI1.Mnmod = SPGI0100.Number_of_modules ;
       SI1.Nbsrv = SPGI0100.Number_of_service_programs ;
       SI1.Nbcyrght = SPGI0100.Number_of_copyrights ;
       SI1.Text = SPGI0100.Text_description ;
       SI1.Shractgrp = SPGI0100.Shared_activation_group ;
       SI1.Alwupd = SPGI0100.Allow_update ;
       SI1.Nburef = SPGI0100.Number_of_unresolved_references ;
       SI1.Useadopt = SPGI0100.Use_adopted_authority ;
       SI1.Alwsrvupd = SPGI0100.Allow_bound_SRVPGM_library_name_update ;
       SI1.Profiledta = SPGI0100.Profiling_data ;
       SI1.Teraspace = SPGI0100.Teraspace_storage_enabled_modules ;
       SI1.Stgmodel = SPGI0100.Storage_model ;
       SI1.Useopti = SPGI0100.Uses_argument_optimization ;
       SI1.State = SPGI0100.Service_program_state ;
       SI1.Domain = SPGI0100.Service_program_domain ;
       SI1.Assocsize = SPGI0100.Associated_space_size ;
       SI1.Staticsize = SPGI0100.Static_storage_size ;
       SI1.Srvsize = SPGI0100.Service_program_size ;
       SI1.Rlscrt = SPGI0100.Release_service_program_created_on ;
       SI1.Rlscanrun = SPGI0100.Earliest_release_service_program_can_run ;
       SI1.Rlsfor = SPGI0100.Release_service_program_created_for ;
       SI1.Alwstaticr = SPGI0100.Allow_static_storage_reinitialization ;
       SI1.Objcnv = SPGI0100.Conversion_required ;
       SI1.Allcrtdta = SPGI0100.All_creation_data ;
       SI1.Cnvdtl = SPGI0100.Conversion_details ;
       SI1.Pagingpool = SPGI0100.Paging_pool ;
       SI1.Pagingamnt = SPGI0100.Paging_amount ;
       Write Spgi0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       // get the list of debug views
       //? Retrieve Module Views
       ech.available=0;
       QteRetrieveModuleViews
          ( vewl0100
          : %Len(vewl0100)
          : 'VEWL0100'
          : srv+lib
          : '*SRVPGM'
          : '*ALL'
          : x10
          : ech
          );
B01    If ech.available > 0;
          if      ech.msgid  = 'CPF9584' // OPM not debuggable
          or      ech.msgid  = 'CPF9599' // CLASS not debuggable
          or      ech.msgid  = 'CPF955F';// not in debug mode
          vewl0100.count = 0;
          else;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
          endif;
E01    Endif;

       //?export API data to DS
       if           vewl0100.count > 0;
       for i = 0 to vewl0100.count - 1 ;
          pvewl0100e = %addr(vewl0100.views) + i * %size(vewl0100e);

       vw1.PGM        = sI1.srv    ;
       vw1.PGMLIB     = si1.srvlib ;
       vw1.PGMATTR    = sI1.srvattr;
       vw1.MOD        = vewl0100e.module      ;
       vw1.view_type  = vewl0100e.viewtype;
                        CHR2HEX
                       (vw1.COMPILER
                       :vewl0100e.CompilerID:20);
        select;
        when %subst(vw1.COMPILER : 1 : 8) =  '00050000'        ;
                    vw1.COMPILER =                'ILE C'       ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00050001'          ;
                    vw1.COMPILER =                'CSET C++'     ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00060000'          ;
                    vw1.COMPILER =                'ILE CL  '     ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00060001'          ;
                    vw1.COMPILER =                'OPM CL   '    ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00070000'          ;
                    vw1.COMPILER =                'OPM COBOL '   ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00070001'          ;
                    vw1.COMPILER =                'ILE COBOL  '  ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00170001'          ;
                    vw1.COMPILER =                'OPM RPG     ' ;
        when %subst(vw1.COMPILER : 1 : 8) =  '00170002'          ;
                    vw1.COMPILER =                'ILE RPG      ';
        when %subst(vw1.COMPILER : 1 : 8) =  '001D0000'          ;
                    vw1.COMPILER =                'JAVA         ';
                    endsl;
       vw1.MAIN       = vewl0100e.Main          ;
       vw1.VIEW_STMP  = vewl0100e.Viewtimes      ;
       vw1.DESC       = vewl0100e.description     ;
       vw1.VIEW_ID    = vewl0100e.Viewnumber       ;
       Write vewl0100f ;
B01    If %Error();
          Message('CPF9801':Spmsid+'-'+Spmsda
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;




       endfor;
       endif;
       ech.available=0;
       //?get srv program info - list of all modules
       //?2010/02/19 : les structures PGML0100 et SPGL0100 se mappent parfaitement
       qbnlspgm (PgmList
          : 'SPGL0100'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? for each module
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL1.type = '*SRVPGM' ;
          PL1.pgm = PGML0100.Program_name ;
          PL1.Pgmlib = PGML0100.Program_lib ;
          PL1.mod = PGML0100.Module_name ;
          PL1.Modlib = PGML0100.Module_lib ;
          PL1.Srcfile = PGML0100.Source_name ;
          PL1.Srclib = PGML0100.Source_lib ;
          PL1.Srcmbr = PGML0100.Source_member ;
          PL1.Modattr = PGML0100.Module_attr ;
          PL1.Moddate = PGML0100.Module_date ;
          PL1.Srcdate = PGML0100.Source_date ;
          PL1.Sort_name = PGML0100.Sort_name ;
          PL1.Sort_lib = PGML0100.Sort_lib ;
          PL1.Lang_id = PGML0100.Lang_id ;
          PL1.Optimize = PGML0100.Optimization ;
          PL1.Maxopt = PGML0100.Maximum_opt ;
          PL1.Debug_data = PGML0100.Debug_data ;
          PL1.Rlscrt = PGML0100.Release_on ;
          PL1.Rlsfor = PGML0100.Release_for ;
          PL1.User_modif = PGML0100.User_modif ;
          PL1.Licpgm = PGML0100.Licpgm ;
          PL1.PTF_number = PGML0100.PTF_number ;
          PL1.APAR_ID = PGML0100.APAR_ID ;
          PL1.Crtdata = PGML0100.Creation_data ;
          PL1.Modccsid = PGML0100.Module_CCSID ;
          PL1.Objctllvl = PGML0100.Object_control_level;
          PL1.perf_coll = PGML0100.perf_coll ;
          PL1.Prof_data = PGML0100.Prof_data ;
          PL1.Nb_proc = PGML0100.Nb_proc ;
          PL1.Nb_proc_r = PGML0100.Nb_proc_reordered ;
          PL1.Nb_proc_m = PGML0100.Nb_proc_measured ;
          PL1.Teraspace = PGML0100.Teraspace ;
          PL1.Stgmdl = PGML0100.Storage_model ;
          PL1.Nbsqlstm = PGML0100.Nb_SQL_stmt ;
          PL1.Rdb = PGML0100.Relational_database ;
          PL1.Commit = PGML0100.Commitment_control ;
          PL1.Allowcopy = PGML0100.Allow_copy_of_data ;
          PL1.Sqlclose = PGML0100.Close_SQL_cursors ;
          PL1.Sqlnaming = PGML0100.Naming_convention ;
          PL1.Datfmt = PGML0100.Date_format ;
          PL1.Datsep = PGML0100.Date_separator ;
          PL1.Timfmt = PGML0100.Time_format ;
          PL1.Timsep = PGML0100.Time_separator ;
          PL1.Sqlprep = PGML0100.Delay_PREPARE ;
          PL1.Allowblk = PGML0100.Allow_blocking ;
          PL1.Dftschema = PGML0100.Default_collection_name;
          PL1.Sqlpkg = PGML0100.SQL_package_name ;
          PL1.Sqlpkglib = PGML0100.SQL_package_lib ;
          PL1.Dymusrprf = PGML0100.Dynamic_user_profile ;
          PL1.Sqlsrts = PGML0100.SQL_sort_name ;
          PL1.Sqmsrtslib = PGML0100.SQL_sort_lib ;
          PL1.Sqllangid = PGML0100.SQL_lang_id ;
          PL1.Cnxmth = PGML0100.Connection_method ;
          len = PGML0100.SQL_path_length ;
          PL1.SQL_path = %Subst(PGML0100.SQL_path :1:len) ;
          Write Pgml0100f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0200'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0200 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL2.type = '*SRVPGM' ;
          PL2.pgm = Pgml0200.Program_name ;
          PL2.Pgmlib = Pgml0200.Program_lib ;
          PL2.Srvpgm = Pgml0200.SrvPgm_name ;
          PL2.Srvpgmlib = Pgml0200.SrvPgm_lib ;
          PL2.Srcpgmsgn = Pgml0200.SrvPgm_Sign ;
          Write Pgml0200f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0300'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0300 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL3.type = '*SRVPGM' ;
          PL3.pgm = PGML0300.Program ;
          PL3.Pgmlib = PGML0300.Program_lib ;
          PL3.Exportsize = PGML0300.export_size ;
          PL3.Exportccid = PGML0300.export_ccsid ;
          PL3.Exportname = PGML0300.export_name ;
          Write Pgml0300f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0400'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0400 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL4.type = '*SRVPGM' ;
          PL4.pgm = PGML0400.Program ;
          PL4.Pgmlib = PGML0400.Program_lib ;
          PL4.Importccid = PGML0400.import_ccsid ;
          PL4.Importname = PGML0400.import_name ;
          Write Pgml0400f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0500'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0500 = pLAH + lah.Data_offset + i * lah.entry_size ;
          PL5.type = '*SRVPGM' ;
          PL5.pgm = PGML0500.Program ;
          PL5.Pgmlib = PGML0500.Program_lib ;
          PL5.Copyright = PGML0500.Copyright ;
          Write Pgml0500f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;
       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0600'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pSPGL0600 = pLAH + lah.Data_offset + i * lah.entry_size ;
          SL6.Srvpgm = SPGL0600.Service_program ;
          SL6.Srvpgmlib = SPGL0600.Service_program_library ;
          SL6.Proc_ccsid = SPGL0600.Procedure_export_CCSID ;
          SL6.Proc_name = SPGL0600.Procedure_export_name ;
          SL6.ARGOPT = SPGL0600.Uses_argument_optimization ;
          Write Spgl0600f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;

       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0700'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pSPGL0700 = pLAH + lah.Data_offset + i * lah.entry_size ;
          SL7.Srvpgm = SPGL0700.Service_program_name ;
          SL7.Srvpgmlib = SPGL0700.Service_program_library ;
          SL7.Data_ccsid = SPGL0700.Data_item_CCSID ;
          SL7.Data_name = SPGL0700.Data_item_name ;
          Write Spgl0700f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;

       ech.available=0;
       qbnlspgm (PgmList
          : 'SPGL0800'
          : srv+lib
          : ech
          );
B01    If ech.available > 0;
          Message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(PgmList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pSPGL0800 = pLAH + lah.Data_offset + i * lah.entry_size ;
          SL8.Srvpgm = SPGL0800.Service_program_name ;
          SL8.Srvpgmlib = SPGL0800.Service_program_library ;
          SL8.Signature = SPGL0800.Signature ;
          Write Spgl0800f ;
B02       If %Error();
             Message('CPF9801':Spmsid+'-'+Spmsda
                :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E02       Endif;
E01    Endfor;

       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
