     fRTVMSGSRCpif a e             disk
      /define QUOTE
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION



       //?ECH Error Code Handler

    ?d  ErrorCode...
    ?D                 DS                  qualified
    ?D  provided               1      4B 0 INZ(%size(errorcode))
    ?D  available              5      8B 0 inz(0)
    ?D  msgid                  9     15
    ?D  msgdta                17    255


    ??*---------------------------------------------------------------------------------------------
    ? *-- Retrieve object description: proto, exemple et ds
    ??*---------------------------------------------------------------------------------------------
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
    ? * exemple
    ? * reset errorcode;
    ? * RtvObjD( OBJD0400
    ? *    : %Size( OBJD0400 )
    ? *    : 'OBJD0100'
    ? *    : File.obj + File.lib
    ? *    : '*FILE'
    ? *    : ErrorCode
    ? *    );
    ? * if errorcode.available>0;
    ? *    RcKoAPI(rc:errorcode);
    ? *    RCmessage(rc :'*ESCAPE':'*PGMBDY':1);
    ? * endif;
    ? *OBJD0100 = OBJD0200 jusqu'@ Object change date and time
    ? *OBJD0200 = OBJD0300 jusqu'@ Source file member name
    ? *OBJD0300 = OBJD0400 jusqu'@ Authorized program analysis report (APAR)
     d OBJD0400        ds                  qualified
    ? *OBJD0100 000-090
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
    ? *OBJD0200 090-180
     d obj_attr                      10
     d Text                          50
     d Src_file_name                 10
     d Src_file_lib                  10
     d Src_file_mbr                  10
    ? *OBJD0300 180-460
     d Src_file_upd                  13a
     d Obj_save_dat                  13a
     d Obj_restored                  13a
     d Creator                       10a
     d System_created                 8a
     d Reset_date                     7a
     d Saved_size                    10i 0
     d Save_seqnum                   10i 0
     d Storage                       10a
     d Save_command                  10a
     d Save_volume_ID                71a
     d Save_device                   10a
     d Save_file_name                10a
     d Save_file_lib                 10a
     d Save_label                    17a
     d System_level                   9a
     d  Compiler                     16a
     d Object_level                   8a
     d User_changed                   1a
     d Licensed_pgm                  16a
     d PTF                           10a
     d APAR                          10a
    ?d*OBJD0400 460-965
     d Last_used_date                 7a
     d Usage_info_upd                 1a
     d Days_used                     10i 0
     d Object_size                   10i 0
     d Object_size_m                 10i 0
     d compression                    1a
     d Allow_change                   1a
     d Changed_by_pgm                 1a
     d User_attribute                10a
     d ASP_overflow                   1a
     d Savact_date                   13a
     d auditing                      10a
     d Primary_group                 10a
     d Journal_status                 1a
     d Journal_name                  10a
     d Journal_lib                   10a
     d Journal_images                 1a
     d omitted_entry                  1a
     d Journal_start                 13a
     d Digitally_sign                 1a
     d Saved_size2                   10i 0
     d Saved_size_m                  10i 0
     d ASP_number                    10i 0
     d ASP_device                    10a
     d ASP_device_lib                10a
     d Digitally_sgn2                 1a
     d Digitally_sgn3                 1a
     d Reserved1                      2a
     d Primary_size                  10i 0
     d Optimum_align                  1a
     d ASP_group                     10a
     d ASP_group_lib                 10a
     d jrnrcv_name                   10a
     d jrnrcv_lib                    10a
     d jrnrcv_aspdev                 10a
     d jrnrcv_aspgrp                 10a
     d Reserved2                      1a


    ? * prototype de Retrieve Message (QMHRTVM) API
    ? * Required Parameter Group:
    ? *  1 Message information Output Char(*)
    ? *  2 Length of message information Input Binary(4)
    ? *  3 Format name Input Char(8)
    ? *  4 Message identifier Input Char(7)
    ? *  5 Qualified message file name Input Char(20)
    ? *  6 Replacement data Input Char(*)
    ? *  7 Length of replacement data Input Binary(4)
    ? *  8 Replace substitution values Input Char(10)
    ? *  9 Return format control characters Input Char(10)
    ? *  10 Error code I/O Char(*)
    ? * Optional Parameter Group:
    ? *  11 Retrieve Option Input Char(10)
    ? *  12 CCSID to convert to Input Binary(4)
    ? *  13 CCSID of replacement data Input Binary(4)
    ?d qmhrtvm         pr                  extpgm('QMHRTVM')
    ?d    Receiver                32767a          options( *varsize )
    ?d    len_recvr                  10i 0 const
    ?d    format_name                 8    const                                RTVM0100-0400
    ?d    msgno                       7      const
    ?d    msgf                       20      const
    ?d    msgdata                  6000      const
    ?d    msgdatalen                  9b 0   const
    ?d    usedata                    10      const                              *YES *NO
    ?d    controlchar                10      const                              *YES=asis *NO=format
    ?d    errorhandle               255
    ?d    option                     10    const options(*nopass)
    ?d    ToCCSID                    10i 0 const options(*nopass)
    ?d    dataCCSID                  10i 0 const options(*nopass)

    ?d RTVM0100        ds                  qualified
    ?d Bytes_returned                10i 0
    ?d Bytes_avail                   10i 0
    ?d message_len                   10i 0
    ?d message_len_available...
    ?d                               10i 0
    ?d help_len                      10i 0
    ?d help_len_available...
    ?d                               10i 0
    ?d Message                     5000
    ?d* message text = message, sur messzge_len caracteres
    ?d* help text = message, à partir de message_len caracteres




     d RTVM0400        ds         10000    qualified
    ? *RTV0300
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0

     d Msg_sev                       10i 0

     d Alert_index                   10i 0
     d Alert_option                   9
     d Log_indicator                  1
     d Message_ID                     7
     d Reserved3                      3
     d variable_Nbr                  10i 0
     d CCSID_of_text                 10i 0
     d CCSID_of_data                 10i 0
     d CCSID_returned                10i 0
     d dft_reply_off                 10i 0
     d dft_reply_rtn                 10i 0
     d dft_reply_len                 10i 0
     d message_off                   10i 0
     d message_rtn                   10i 0
     d message_len                   10i 0
     d help_off                      10i 0
     d help_rtn                      10i 0
     d help_avl                      10i 0
     d variable_off                  10i 0
     d variable_rtn                  10i 0
     d variable_len                  10i 0
     d variable_elt                  10i 0
    ? *RTVM0400
     d Reply_type                    10
     d Reserved4                      2
     d Max_reply_len                 10i 0
     d Max_reply_dec                 10i 0
     d reply_off                     10i 0
     d reply_nbr                     10i 0
     d reply_rtn                     10i 0
     d reply_avl                     10i 0
     d reply_entrylen                10i 0
     d reply_entryoff                10i 0
     d special_rtn                   10i 0
     d specl_entryrtn                10i 0
     d specl_entryavl                10i 0
     d specl_entrylen                10i 0
     d lower_rangeoff                10i 0
     d lower_rangertn                10i 0
     d lower_rangeavl                10i 0
     d upper_rangeoff                10i 0
     d upper_rangertn                10i 0
     d upper_rangeavl                10i 0
     d relational_off                10i 0
     d relational_rtn                10i 0
     d relational_avl                10i 0
     d Msg_creadate                   7
     d Reserved5                      1
     d Msg_crealevel                 10i 0
     d Msg_modidate                   7
     d Reserved6                      1
     d Mss_modilevel                 10i 0
     d msg_CCSID                     10i 0
     d dump_list_off                 10i 0
     d dump_list_nbr                 10i 0
     d dump_list_rtn                 10i 0
     d dump_list_avl                 10i 0
     d program_name                  10
     d program_lib                   10





     d msgtxtw         s            200    based(pMsgTxtW)
     d seclvl          s           3000    based(pSecLvl)
















     d    option       s             10
     d    msgno        s              7
     d    addmsgd      s               n
     d    Updmsgd      s               n
     d    chkvar       s               n

     d witherror       s               n   inz(*off )

     d ArcadVer        s              8
     d LibVer          s             10

     d variable        ds                  qualified based(pVariable)
     d   len                         10i 0
     d   size                        10i 0
     d   type                        10

     d v               s              5i 0
     d vMax            s              5i 0



     d RTVMSGSRC       pr
     d   msgf                        20
     d RTVMSGSRC       pi
     d   msgf                        20

      /free
       *INLR=*ON;

B01    if %Parms() < 1;
          MESSAGE('CPF9898':'MSGF SVP':'*LIBL':'QCPFMSG'
             :'*ESCAPE':'*PGMBDY':1);
E01    Endif;

       Reset ERRORCODE;
       RtvObjD( OBJD0400
          : %Size( OBJD0400 )
          : 'OBJD0100'
          //?123456789 123456789
          : msgf
          : '*MSGF'
          : ERRORCODE
          );
B01    if ERRORCODE.AVAILABLE>0;
          MESSAGE(ERRORCODE.MSGID:ERRORCODE.MSGDTA:'*LIBL':'QCPFMSG'
             :'*ESCAPE':'*PGMBDY':1);
E01    Endif;


       //?lire tout     MSGF

       option='*FIRST';
B01    For EVER;





          Reset ERRORCODE;
          QMHRTVM
             ( RTVM0400
             : %Size(RTVM0400)
             : 'RTVM0400'
             : msgno
             : msgf
             : ''
             : 0
             : '*NO'
             : '*YES'
             : ERRORCODE
             : option
             : 0
             : 0
             );
B02       if ERRORCODE.AVAILABLE>0;
             MESSAGE(ERRORCODE.MSGID:ERRORCODE.MSGDTA:'*LIBL':'QCPFMSG'
                :'*ESCAPE':'*PGMBDY':1);
             Leave;
E02       Endif;
B02       if RTVM0400.Bytes_returned <= 8 ;
             Leave;
E02       Endif ;
          option='*NEXT';
          msgno=RTVM0400.MESSAGE_ID  ;
B02       if msgno = '';
             Leave;
E02       Endif;
B02       if %Int(EVER/100)*100=EVER;
             MESSAGE('CPF9898':msgno:'*LIBL':'QCPFMSG'
                :'*STATUS':'*EXT');
E02       Endif;
          CMD='ADDMSGD MSGID('+msgno+') MSGF('
             + %Trim(%Subst(msgf:11))+'/'+%Trim(%Subst(msgf:1:10))+') ';

          pMsgTxtW= %Addr(RTVM0400) + RTVM0400.message_off;
          CMD +=' MSG('+   QUOTE(
             %Subst(msgtxtw:1:RTVM0400.message_len)
             )+') ';
          if RTVM0400.help_rtn > 0;
          pSecLvl = %Addr(RTVM0400) + RTVM0400.help_off;

          CMD +=' SECLVL('+   QUOTE(
             %Subst(seclvl :1:RTVM0400.help_rtn)
             )+') ';
             endif;
          if RTVM0400.Msg_sev  > 0;
          CMD+=' SEV('+%Char(RTVM0400.Msg_sev)+') ';
          endif;
          vMax=RTVM0400.VARIABLE_RTN/RTVM0400.variable_elt;
          if vmax > 0;
          CMD +='FMT(';
B02       For v = 0 TO vMax-1;
             pVariable=%Addr(RTVM0400)+RTVM0400.variable_off
                + V*RTVM0400.variable_elt;
             CMD +='('+%Trim(variable.type)+' '
                + %Char(variable.len) +' '
                +%Char(variable.size)+')';
E02       EndFor;
          CMD +=')';
          endif;
          Write RTVMSGSRCF;
E01    EndFor;



       Return;

      /end-free
      /DEFINE PSSR
      /free
B01    BegSr *PSSR ;
          Dump(A) ;
E01    EndSr '*CANCL';
      /end-free
      /define INZSR





      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
