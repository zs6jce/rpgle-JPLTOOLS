


     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define SQL
      /define USERSPACE
      /define  getmessage
      /define  lowercase

      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
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

    ?d*MODL0200        ds          5000    qualified based(pMODL0200)
    ?d*  entry_size                  10i 0
    ?d*  Module                      10
    ?d*  Module_lib                  10
    ?d*  symbol_type                  1
    ?d*  Reserved                     3
    ?d*  symbol_off                  10i 0
    ?d*  symbol_len                  10i 0
    ?d*  argopt                      10
    ?d*  Reserved CHAR(*)
    ?d*  Imported (unresolved) symbol name CHAR(*)
    ? *
    ?d*MODL0300        ds          5000    qualified based(pMODL0300)
    ?d*  entry_size                  10i 0
    ?d*  Module                      10
    ?d*  Module_lib                  10
    ?d*  type                         1
    ?d*  Reserved                     3
    ?d*  procedure_off...
    ?d*                              10i 0
    ?d*  procedure_len...
    ?d*                              10i 0
    ?d*  argopt                      10
    ?d*  Reserved CHAR(*)
    ?d*  Procedure name CHAR(*)
    ? *
    ?d*MODL0400        ds          5000    qualified based(pMODL0400)
    ?d*  entry_size                  10i 0
    ?d*  Module                      10
    ?d*  Module_lib                  10
    ?d*  object_type                 10
    ?d*  Object_lib                  10
    ?d*  name_off                    10i 0
    ?d*  name_len                    10i 0
    ?d*  Reserved CHAR(*)
    ?d*  Object name CHAR(*)
    ? *
    ?d*MODL0500        ds          5000    qualified based(pMODL0500)
    ?d*  entry_size                  10i 0
    ?d*  Module                      10
    ?d*  Module_lib                  10
    ?d*  copyright_off...
    ?d*                              10i 0
    ?d*  copyright_len...
    ?d*                              10i 0
    ?d*  Reserved CHAR(*)
    ?d*  Copyright CHAR(*)
    ? *
    ? * Retrieve Module Information (QBNRMODI) API
    ?d*qbnrmodi        pr                  extpgm('QBNRMODI')
    ?d*  receiver                 30000          options( *varsize )
    ?d*  receiverlen                 10i 0 const
    ?d*  format                       8    const
    ?d*  QualMod                     20    const
    ?d*  Error_Code                 256          options(*varsize)
    ? *
    ?d*MODI0100        ds          5000    qualified
    ?d*
    ?d*returned...
    ?d*                              10i 0
    ?d*available...
    ?d*                              10i 0
    ?d*Module_name...
    ?d*                              10
    ?d*Module_lib...
    ?d*                              10
    ?d*Module_attr...
    ?d*                              10
     d*Module_date...
    ?d*                              13
    ?d*Source_name...
    ?d*                              10
    ?d*Source_lib...
    ?d*                              10
    ?d*Source_mbr...
    ?d*                              10
    ?d*Source_date...
    ?d*                              13
    ?d*Reserved1...
    ?d*                              10
    ?d*Module_owner...
    ?d*                              10
    ?d*Reserved11...
    ?d*                               2
    ?d*Module_CCSID...
    ?d*                              10i 0
    ?d*Text_description...
    ?d*                              50
    ?d*Creation_data...
    ?d*                               1
    ?d*Sort_sequence_table_name...
    ?d*                              10
    ?d*Sort_sequence_table_library_name...
    ?d*                              10
    ?d*Language_identifier...
    ?d*                              10
    ?d*Reserved2...
    ?d*                               3
    ?d*Optimization_level...
    ?d*                              10i 0
    ?d*Maximum_optimization_level...
    ?d*                              10i 0
    ?d*Debug_data...
    ?d*                               1
    ?d*Module_compressed_status...
    ?d*                               1
    ?d*Reserved3...
    ?d*                               2
    ?d*Minimum_number_of_parameters...
    ?d*                              10i 0
    ?d*Maximum_number_of_parameters...
    ?d*                              10i 0
    ?d*Module_state...
    ?d*                               1
    ?d*Module_domain...
    ?d*                               1
    ?d*Reserved4...
    ?d*                               2
    ?d*Number_of_exported_defined_symbols...
    ?d*                              10i 0
    ?d*Number_of_imported_unresolved_symbols...
    ?d*                              10i 0
    ?d*Release_module_created_on...
    ?d*                               6
    ?d*Release_module_created_for...
    ?d*                               6
    ?d*Earliest_release_module_can_be_restored_to...
    ?d*                               6
    ?d*Enable_performance_collection...
    ?d*                               1
    ?d*Conversion_required...
    ?d*                               1
    ?d*Offset_to_program_entry_procedure_name...
    ?d*                              10i 0
    ?d*Length_of_program_entry_procedure_name...
    ?d*                              10i 0
    ?d*Program_entry_procedure_name_indicator...
    ?d*                               1
    ?d*Profile_data...
    ?d*                              10
    ?d*Intermediate_language_IL_data...
    ?d*                               1
    ?d*Teraspace_storage_enabled...
    ?d*                               1
    ?d*Storage_model...
    ?d*                               1
    ?d*Conversion_details...
    ?d*                               1
    ?d*Allow_RTVCLSRC...
    ?d*                               1
    ?d*Offset_to_Licensed_Internal_Code_options...
    ?d*                              10i 0
    ?d*Length_of_Licensed_Internal_Code_options...
    ?d*                              10i 0
    ?d*Reserved6...
    ?d*                              68
    ?d*Number_of_SQL_statements...
    ?d*                              10i 0
    ?d*Relational_database...
    ?d*                              18
    ?d*Commitment_control...
    ?d*                              10
    ?d*Allow_copy_of_data...
    ?d*                              10
    ?d*Close_SQL_cursor...
    ?d*                              10
    ?d*Naming_convention...
    ?d*                              10
    ?d*Date_format...
    ?d*                              10
    ?d*Date_separator...
    ?d*                               1
    ?d*Time_format...
    ?d*                              10
    ?d*Time_separator...
    ?d*                               1
    ?d*Delay_PREPARE...
    ?d*                              10
    ?d*Allow_blocking...
    ?d*                              10
    ?d*Default_collection_name...
    ?d*                              10
    ?d*SQL_package_name...
    ?d*                              10
    ?d*SQL_package_library_name...
    ?d*                              10
    ?d*Dynamic_user_profile...
    ?d*                              10
    ?d*SQL_sort_sequence_table_name...
    ?d*                              10
    ?d*SQL_sort_sequence_table_library_name...
    ?d*                              10
    ?d*SQL_language_identifier...
    ?d*                              10
    ?d*Connection_method...
    ?d*                              10
    ?d*SQL_path_offset...
    ?d*                              10i 0
    ?d*SQL_path_length...
    ?d*                              10i 0
    ?d*Reserved7...
    ?d*Program_entry_procedure_name...
    ?d*SQL_path...
    ?d*Licensed_Internal_Code_options...
    ? *
    ? * List ILE Program Information (QBNLPGMI) API
    ?d*QBNLPGMI        pr                  extpgm('QBNLPGMI')
    ?d*usrspc                        20    const
    ?d*format                         8    const
    ?d*QualPgm                       20    const
    ?d*Error_code                   255           options( *varsize )
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

    ?d*Pgml0200        ds                  qualified based(pPGML0200)
    ?d*  Program_name                10
    ?d*  Program_lib                 10
    ?d*  SrvPgm_name                 10
    ?d*  SrvPgm_lib                  10
    ?d*  SrvPgm_Sign                 16
    ? *
    ?d* PGML0300       ds                  qualified based(pPGML0300)
    ?d* Program                      10
    ?d* Program_lib                  10
    ?d* export_size                  10i 0
    ?d* export_ccsid                 10i 0
    ?d* export_length                10i 0
    ?d* export_name                 256
    ?d*
    ?d* PGML0400       ds                  qualified based(pPGML0400)
    ?d* Program                      10
    ?d* Program_lib                  10
    ?d* import_ccsid                 10i 0
    ?d* import_length                10i 0
    ?d* import_name                 256
    ?d*
    ?d* PGML0500       ds                  qualified based(pPGML0500)
    ?d* Program                      10
    ?d* Program_lib                  10
    ? *
    ?d* Copyright_len                10i 0
    ?d* Copyright                   256
    ?d*
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
    ?d* SPGL0700       ds                  qualified based(pSPGL0700)
    ?d* Service_program_name...
    ?d*                              10
    ?d* Service_program_library...
    ?d*                              10
    ?d* Data_item_CCSID...
    ?d*                              10i 0
    ?d* Data_item_name_length...
    ?d*                              10i 0
    ?d* Data_item_name...
    ?d*                             256
    ?d* SPGL0800       ds                  qualified based(pSPGL0800)
    ?d* Service_program_name...
    ?d*                              10
    ?d* Service_program_library...
    ?d*                              10
    ?d* Signature...
    ?d*                              16
    ? *
    ? * List Service Program Information (QBNLSPGM) API
     d qbnlspgm        pr                  extpgm('QBNLSPGM')
     d   UserSpace                   20    const
     d   format                       8    const
     d   QualSrvPgm                  20    const
     d   Error_Code                 256          options(*varsize)

    ? * returns char representation of any hexadecimal string
    ?D*Chr2Hex         Pr                  ExtProc('cvthc')
    ?D* Tgt                         100    options(*varsize)
    ?D* Src                         100    options(*varsize)
    ?D* TgtLen                       10i 0 Value







    ? * Retrieve Module Views (QteRetrieveModuleViews) API
    ?d*QteRetrieveModuleViews...
    ?d*                pr                  extproc('QteRetrieveModuleViews')
    ?d* Receiver                    100    options(*varsize)
    ?d* ReceiverLen                  10i 0 const
    ?d* Format                        8    const
    ?d* QualProgram                  20    const
    ?d* type                         10    const
    ?d* Module                       10    const
    ?d* RtnLib                       10
    ?d* Errorcode                   256    options(*varsize)
    ? *
    ?d*vewl0100        ds          1000    qualified
    ?d*  returned                    10i 0
    ?d*  available                   10i 0
    ?d*  count                       10i 0
    ?d*  views                        1
    ? *
    ?d*vewl0100e       ds                  qualified based(pvewl0100e)
    ?d*  Module                      10
    ?d*  Viewtype                    10
    ?d*  CompilerID                  20
    ?d*  Main                        10
    ?d*  Viewtimes                   13
    ?d*  description                 50
    ?d*  Reserved1                    3
    ?d*  Viewnumber                  10i 0
    ?d*  viewcount                   10i 0
    ? *
    ? *
    ? * Retrieve Program Information (QCLRPGMI) API
    ?d*QCLRPGMI        pr                  extpgm('QCLRPGMI')
    ?d*  receiver                 30000          options( *varsize )
    ?d*  receiverlen                 10i 0 const
    ?d*  format                       8    const
    ?d*  QualPgm                     20    const
    ?d*  Error_Code                 256          options(*varsize)
    ? *
    ?d*PGMI0100        ds                  qualified
    ?d*Bytes_returned...
    ?d*                              10i 0
    ?d*Bytes_available...
    ?d*                              10i 0
    ?d*Program_name...
    ?d*                              10
    ?d*Program_library_name...
    ?d*                              10
    ?d*Program_owner...
    ?d*                              10
    ?d*Program_attribute...
    ?d*                              10
    ?d*Creation_date_and_time...
    ?d*                              13
    ?d*Source_file_name...
    ?d*                              10
    ?d*Source_file_library_name...
    ?d*                              10
    ?d*Source_file_member_name...
    ?d*                              10
    ?d*Source_file_updated_date_and_time...
    ?d*                              13
    ?d*Observable_information...
    ?d*                               1
    ?d*User_profile_option...
    ?d*                               1
    ?d*Use_adopted_authority...
    ?d*                               1
    ?d*Log_commands...
    ?d*                               1
    ?d*Allow_RTVCLSRC...
    ?d*                               1
    ?d*Fix_decimal_data...
    ?d*                               1
    ?d*Text_description...
    ?d*                              50
    ?d*Type_of_program...
    ?d*                               1
    ?d*Teraspace_storage_enabled_program...
    ?d*                               1
    ?d*Reserved1...
    ?d*                              58
    ?d*Minimum_number_of_parameters...
    ?d*                              10i 0
    ?d*Maximum_number_of_parameters...
    ?d*                              10i 0
    ?d*Program_size...
    ?d*                              10i 0
    ?d*Associated_space_size...
    ?d*                              10i 0
    ?d*Static_storage_size...
    ?d*                              10i 0
    ?d*Automatic_storage_size...
    ?d*                              10i 0
    ?d*Number_of_MI_instructions...
    ?d*                              10i 0
    ?d*Number_of_MI_ODT_entries...
    ?d*                              10i 0
    ?d*Program_state...
    ?d*                               1
    ?d*Compiler_identification...
    ?d*                              14
    ?d*Earliest_release_program_can_run...
    ?d*                               6
    ?d*Sort_sequence_table_name...
    ?d*                              10
    ?d*Sort_sequence_table_library_name...
    ?d*                              10
    ?d*Language_identifier...
    ?d*                              10
    ?d*Program_domain...
    ?d*                               1
    ?d*Conversion_required...
    ?d*                               1
    ?d*Conversion_details...
    ?d*                               1
    ?d*Reserved2...
    ?d*                              19
    ?d*Optimization...
    ?d*                               1
    ?d*Paging_pool...
    ?d*                               1
    ?d*Update_program_automatic_storage_area_...
    ?d*                               1
    ?d*Clear_program_automatic_storage_area_...
    ?d*                               1
    ?d*Paging_amount...
    ?d*                               1
    ?d*Reserved3...
    ?d*                              18
    ?d*Program_entry_procedure_module...
    ?d*                              10
    ?d*Program_entry_procedure_module_library...
    ?d*                              10
    ?d*Activation_group_attribute...
    ?d*                              30
    ?d*Observable_information_compressed...
    ?d*                               1
    ?d*Run_time_information_compressed...
    ?d*                               1
    ?d*Release_program_created_on...
    ?d*                               6
    ?d*Shared_activation_group...
    ?d*                               1
    ?d*Allow_update...
    ?d*                               1
    ?d*Program_CCSID...
    ?d*                              10i 0
    ?d*Number_of_modules...
    ?d*                              10i 0
    ?d*Number_of_service_programs...
    ?d*                              10i 0
    ?d*Number_of_copyrights...
    ?d*                              10i 0
    ?d*Number_of_unresolved_references...
    ?d*                              10i 0
    ?d*Release_program_created_for...
    ?d*                               6
    ?d*Allow_static_storage_reinitialization...
    ?d*                               1
    ?d*All_creation_data...
    ?d*                               1
    ?d*Allow_bound_SRVPGM_library_name_update...
    ?d*                               1
    ?d*Profiling_data...
    ?d*                              10
    ?d*Teraspace_storage_enabled_modules...
    ?d*                               1
    ?d*Storage_model...
    ?d*                               1
    ?d*Uses_argument_optimization...
    ?d*                              10
    ?d*Reserved4...
    ?d*                              77
    ?d*
    ? * Retrieve Service Program Information (QBNRSPGM) API
    ?d*QBNRSPGM        pr                  extpgm('QBNRSPGM')
    ?d*  receiver                 30000          options( *varsize )
    ?d*  receiverlen                 10i 0 const
    ?d*  format                       8    const
    ?d*  QualSrv                     20    const
    ?d*  Error_Code                 256          options(*varsize)
    ? *
    ?d*SPGI0100        ds                  qualified
    ?D*Bytes_returned...
    ?D*                              10i 0
    ?D*Bytes_available...
    ?D*                              10i 0
    ?D*Service_program_name...
    ?D*                              10
    ?D*Service_program_library_name...
    ?D*                              10
    ?D*Service_program_owner...
    ?D*                              10
    ?D*Service_program_attribute...
    ?D*                              10
    ?D*Creation_date_and_time...
    ?D*                              13
    ?D*Export_source_file_name...
    ?D*                              10
    ?D*Export_source_file_library_name...
    ?D*                              10
    ?D*Export_source_file_member_name...
    ?D*                              10
    ?D*Activation_group_attribute...
    ?D*                              30
    ?D*Current_export_signature...
    ?D*                              16
    ?D*User_profile...
    ?D*                               1
    ?D*Observable_information_compressed...
    ?D*                               1
    ?D*Run_time_information_compressed...
    ?D*                               1
    ?D*Service_program_CCSID...
    ?D*                              10i 0
    ?D*Number_of_modules...
    ?D*                              10i 0
    ?D*Number_of_service_programs...
    ?D*                              10i 0
    ?D*Number_of_copyrights...
    ?D*                              10i 0
    ?D*Text_description...
    ?D*                              50
    ?D*Shared_activation_group...
    ?D*                               1
    ?D*Allow_update...
    ?D*                               1
    ?D*Number_of_unresolved_references...
    ?D*                              10i 0
    ?D*Use_adopted_authority...
    ?D*                               1
    ?D*Allow_bound_SRVPGM_library_name_update...
    ?D*                               1
    ?D*Profiling_data...
    ?D*                              10
    ?D*Teraspace_storage_enabled_modules...
    ?D*                               1
    ?D*Storage_model...
    ?D*                               1
    ?D*Uses_argument_optimization...
    ?D*                              10
    ?D*Reserved1...
    ?D*                              70
    ?D*Service_program_state...
    ?D*                               1
    ?D*Service_program_domain...
    ?D*                               1
    ?D*Associated_space_size...
    ?D*                              10i 0
    ?D*Static_storage_size...
    ?D*                              10i 0
    ?D*Service_program_size...
    ?D*                              10i 0
    ?D*Release_service_program_created_on...
    ?D*                               6
    ?D*Earliest_release_service_program_can_run...
    ?D*                               6
    ?D*Release_service_program_created_for...
    ?D*                               6
    ?D*Allow_static_storage_reinitialization...
    ?D*                               1
    ?D*Conversion_required...
    ?D*                               1
    ?D*All_creation_data...
    ?D*                               1
    ?D*Conversion_details...
    ?D*                               1
    ?D*Reserved2...
    ?D*                              90
    ?D*Paging_pool...
    ?D*                               1
    ?D*Paging_amount...
    ?D*                               1
    ? *
     d ModList         s             20    inz('MODLIST   QTEMP     ')
     d srvList         s             20    inz('SRVLIST   QTEMP     ')
     d srvProc         s             20    inz('SRVPROC   QTEMP     ')
     d ProcLah         ds                  likeds(ListApiHeader) based(pProcLah)
     d iProc           s              5i 0
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
     d getprc          pr




     d un_SrvPgm       pr



     d  SPGIobj        s             20

     d wrkbndprc2      pr
     d wrkbndprc2      pi
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


     d bnd_LIB         s             10
     d bnd_name        s             10
     d OBJ_LIB         s             10
     d rtn_LIB         s             10
     d OBJ_name        s             10
     d OBJ_TYPE        s             10
     d procname        s            256


     d obj_rtnLIB      s             10
     d mod_LIB         s             10
     d mod_rtnLIB      s             10
     d mod_name        s             10

     c/free

       Exec Sql
          Set Option Commit = *none
          , Closqlcsr = *endactgrp
          , Datfmt = *iso
          , Timfmt = *iso
          , Naming = *sys
          , Sqlpath= *libl
          ;
       //?modules user space
       Quscrtus (ModList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : ModList : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?service programs user space
       Quscrtus (srvList:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : srvList : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?service procs    user space
       Quscrtus (srvProc:*blank:1:X'00':'*ALL':*blank:'*YES':ech:'*USER');
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? with attribute auto-extensible
       Quscusat ( lib : srvProc : Attributes : ech );
B01    If (ech.Available>0);
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //?*SYS -> *LIBL
       Exec Sql
          Declare C1 Cursor For
          Select Bndrlb, Bndrnm, Bnolnm, Bnobnm, Bnobtp From Wrkbndprcb
          ;
       Exec Sql Open C1;
B01    If Sqlcod <> *zero;
          Escsqler (Sqlcod:Sqlerm);
E01    Endif;

B01    For Ever;
          Exec Sql Fetch C1 Into
             : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             ;
B02       If Sqlcod = 100 ;
             Leave;
E02       Endif;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Getprc();
E01    Endfor;
       Exec Sql Close C1;
B01    If Sqlcod <> *zero;
          Escsqler (Sqlcod:Sqlerm);
E01    Endif;


       Qusdltus (ModList:ech);
       Qusdltus (srvList:ech);



       Return;
    ? /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc


BPR ?p getprc          b
    ? *=-----------------------------------------------------------------------
     d                 pi
     d
    ?d*=---------------------------------

     d i               s              5i 0
      /free
       ech .Available=0;
       //?check object exists
       RtvObjD (OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : OBJ_name +OBJ_LIB
          : OBJ_TYPE
          : ech
          );
B01    If ech.Available>0;
          procname=Getmessage(ech.Msgid:ech.Msgdta);
          obj_rtnLIB = '*NOTFOUND';
          Exec Sql
             Insert Into Wrkbndprcp Values
             ( : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             , : obj_rtnLIB
             , ''
             , ''
             , ''
             , : procname )
             ;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Return;
E01    Endif;

       obj_rtnLIB = OBJD0200.Return_lib ;
B01    If OBJ_TYPE = '*MODULE';
          mod_LIB = OBJD0200.Return_lib ;
          mod_name = OBJ_name;
          obj_rtnLIB = '*MODULE';
          OBJ_name = '*MODULE';
          un_Module ( );
X01    Elseif OBJ_TYPE = '*SRVPGM';
          un_SrvPgm ( );
E01    Endif;

B01    Begsr *pssr;
          Dump;
E01    Endsr;

      /end-free
EPR  p                 e




BPR ?p un_module       b
     d                 pi


     d len             s              5i 0
     d off             s              5i 0
     d i               s              5i 0
     d IsExported      s               n
     d lah             ds                  likeds(ListApiHeader) based(pLAH)
     d USP             s          65535    based(pUSP)
      /free
       ech.Available=0;
       //?The MODL0100 format lists the symbols defined in the module and that are exported to other
       //?modules
       RtvObjD (OBJD0200
          : %Size( OBJD0200 )
          : 'OBJD0200'
          : mod_name +mod_LIB
          : '*MODULE'
          : ech
          );
B01    If ech.Available>0;
          procname=Getmessage(ech.Msgid:ech.Msgdta);
          mod_rtnLIB = '*NOTFOUND';
          Exec Sql
             Insert Into Wrkbndprcp Values
             ( : bnd_LIB
             , : bnd_name
             , : OBJ_LIB
             , : OBJ_name
             , : OBJ_TYPE
             , : obj_rtnLIB
             , : mod_LIB
             , : mod_rtnLIB
             , : mod_name
             , : procname )
             ;
B02       If Sqlcod <> *zero;
             Escsqler (Sqlcod:Sqlerm);
E02       Endif;
          Return;
E01    Endif;
       mod_rtnLIB = OBJD0200.Return_lib ;
       ech.Available=0;
       QBNLMODI (ModList
          : 'MODL0100'
          : mod_name+mod_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(ModList : pLAH);
       pMODL0100 = pLAH + lah.Data_offset ;
B01    For i = 0 To lah.Count - 1;
          //?When MODL0100.symbol_type = X'00';
          //?   ML1.Exporttype ='P';
          //?When MODL0100.symbol_type = X'01';
          //?   ML1.Exporttype ='D';
          off = MODL0100.symbol_off;
          len = MODL0100.symbol_len ;
B02       If len > %Size(procname );
             len = %Size(procname );
E02       Endif;
B02       If len > 0;
             pUSP = pLAH + off;
             procname = %Subst(usp:1:len) ;
X02       Else;
             procname='*NONE';
E02       Endif;
          //?pour un module de srvpgm, verifier que la procedure est effectivement exportée
B02       If OBJ_TYPE = '*MODULE';
             IsExported = True ;
X02       Else;
             IsExported = False;
B03          For iProc = 0 To ProcLah.Count - 1;
                pSPGL0600 = pProcLah + ProcLah.Data_offset
                   + iProc * ProcLah.entry_size ;
B04             If procname = SPGL0600.Procedure_export_name ;
                   SPGL0600.Procedure_export_name = '';
                   IsExported = True;
                   Leave;
E04             Endif;
E03          Endfor;
E02       Endif;
B02       If IsExported;
             Exec Sql
                Insert Into Wrkbndprcp Values
                ( : bnd_LIB
                , : bnd_name
                , : OBJ_LIB
                , : OBJ_name
                , : OBJ_TYPE
                , : obj_rtnLIB
                , : mod_LIB
                , : mod_rtnLIB
                , : mod_name
                , : procname )
                ;
B03          If Sqlcod <> *zero;
                Escsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;
          pMODL0100 += MODL0100.entry_size ;

E01    Endfor;
       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e

BPR ?p un_srvpgm       b
     d                 pi


    ? *=----------------------------------------
     d lah             ds                  likeds(ListApiHeader) based(pLAH)

     d i               s              5i 0
     d i2              s              5i 0
     d len             s              5i 0
      /free
       ech.Available=0;
       //?get srv program info - list of all exported procs
       qbnlspgm (srvProc
          : 'SPGL0600'
          : OBJ_name+OBJ_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       Qusptrus(srvProc : pProcLah);
       //?get srv program info - list of all modules
       //?2010/02/19 : les structures PGML0100 et SPGL0100 se mappent parfaitement
       qbnlspgm (srvList
          : 'SPGL0100'
          : OBJ_name+OBJ_LIB
          : ech
          );
B01    If ech.Available > 0;
          Message(ech.Msgid:ech.Msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY');
E01    Endif;
       //? for each module
       Qusptrus(srvList : pLAH);
B01    For i = 0 To lah.Count - 1;
          pPGML0100 = pLAH + lah.Data_offset + i * lah.entry_size ;
          mod_name = PGML0100.module_name ;
          mod_LIB = PGML0100.Module_lib ;
          un_Module();
E01    Endfor;

       //?les procedures des modules non disponibles
B01    For iProc = 0 To ProcLah.Count - 1;
          pSPGL0600 = pProcLah + ProcLah.Data_offset
             + iProc * ProcLah.entry_size ;
          procname = SPGL0600.Procedure_export_name ;
B02       If procname <> '';
             Exec Sql
                Insert Into Wrkbndprcp Values
                ( : bnd_LIB
                , : bnd_name
                , : OBJ_LIB
                , : OBJ_name
                , : OBJ_TYPE
                , : obj_rtnLIB
                , '*UNKNOWN'
                , '*UNKNOWN'
                , '*UNKNOWN'
                , : procname )
                ;
B03          If Sqlcod <> *zero;
                Escsqler (Sqlcod:Sqlerm);
E03          Endif;
E02       Endif;





E01    Endfor;

       Return;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
