    ? */ cleanup old spools
    ? */ compilation :
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
    ? */
      /define INFDS
    ? /define USERSPACE
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION
    ? */================================================================
    ? */
    ? */================================================================
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
    ? */ commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST
     D QCmd            PR                  EXTPGM('QCMD')
     D QCmdLn          PR                  EXTPGM('QUSCMDLN')
     D QCmdChk         PR                  EXTPGM('QCMDCHK')
     D cmd                          400A
     D cmdlen                        15P 5 CONST
     D cmd             S            400A
     D Pos             S              5  0
     DMSGID            S              7A   IMPORT('_EXCP_MSGID')
     Dc_system         pr            10i 0 extproc('system')
     Dparm2                            *   options(*string) value
    ? */ exemple :
     d rc              s              9b 0
     d cmde            s           1000    varying
    ? */         rc =  c_system(cmde );
    ? */         if rc <> 0;
    ? */         dsply msgid;
    ? */         endif;
    ? */ parametres du programme
     d clnsplr         pr
     d   standard                     3p 0
     d   saved                        3p 0
     d   joblog                       3p 0
     d   savedlog                     3p 0
     d clnsplr         pi
     d p_standard                     3p 0
     d p_saved                        3p 0
     d p_joblog                       3p 0
     d p_savedlog                     3p 0
       //?dates to check
     d d_standard      s              7
     d d_saved         s              7
     d d_joblog        s              7
     d d_savedlog      s              7
     d d_selected      s              7
     d MyDay           s               d
     d qjob            ds            26    qualified
     d   name                        10
     d   user                        10    inz('*ALL')
     d   nbr                          6    inz('*ALL')
       //?List Spooled Files (QUSLSPL) API
     d quslspl         pr                  extpgm('QUSLSPL')
     d   user_space                  20    const
     d   Format                       8    const
     d   UserName                    10    const
     d   OutqName                    20    const
     d   FormType                    10    const
     d   UserData                    10    const
       //?Optional Parameter Group 1:
     d   Error_Code                 256    options(*nopass:*varsize)
       //?Optional Parameter Group 2
     d   JobName                     26    options(*nopass) const
     d   Key                         10i 0 options(*nopass) const
     d   keyCount                    10i 0 options(*nopass) const
       //? Optional Parameter Group 3:
     d   ASP                         10i 0 options(*nopass) const
       //? Optional Parameter Group 4:
     d   JobSysName                   8    options(*nopass) const
     d   StrSplCrtDat                 7    options(*nopass) const
     d   StrSplCrtTim                 8    options(*nopass) const
     d   EndSplCrtDat                 7    options(*nopass) const
     d   EndSplCrtTim                 8    options(*nopass) const
       //? Optional Parameter Group 5:
     d   ASPdevice                   10    options(*nopass) const
     D SPLF0300        ds           136    qualified based(pSplf0300)
     d Job_name                      10
     d User_name                     10
     d Job_number                     6
     d Spool_name                    10
     d Spool_number                  10i 0
     d Spool_status                  10i 0
     d Date_created                   7
     d Time_created                   6
     d Spool_schedule                 1
     d Spool_sys_name                10
     d User_data                     10
     d Form_type                     10
     d OutQ_Name                     10
     d OutQ_lib                      10
     d ASP                           10i 0
     d Size                          10i 0
     d sizemultiplier                10i 0
     d Total_pages                   10i 0
     d Copies_to_prod                10i 0
     d Priority                       1
     d Reserved                       3
     d IPP_jobid                     10i 0
       //?loop pointer : 1 to LAH.count
     d iSpl            s             10i 0
     d LAH             ds                  likeds(ListApiHeader) based(pLAH)
     D Usrspc          c                   const( 'WRKSPLF   QTEMP     ' )
     d errcode         ds                  likeds(errorcodehandler)
      /free
       *inlr = *on ;
       //?---------------------------------------------------------------
       //?initialisation generale
       //?---------------------------------------------------------------
B01    dou true;//?do one time
          d_standard='0010101';
          d_saved   ='0010101';
          d_joblog  ='0010101';
          d_savedlog='0010101';
B02       if p_standard > 0;
             MyDay=%date()-%days(p_standard);
             d_standard = %char(MyDay:*cymd0);
E02       endif;
B02       if p_saved > 0;
             MyDay=%date()-%days(p_saved );
             d_saved = %char(MyDay:*cymd0);
E02       endif;
B02       if p_joblog > 0;
             MyDay=%date()-%days(p_joblog );
             d_joblog = %char(MyDay:*cymd0);
E02       endif;
B02       if p_savedlog > 0;
             MyDay=%date()-%days(p_savedlog);
             d_savedlog = %char(MyDay:*cymd0);
E02       endif;
          clear errcode;
          errcode.provided =%size(errcode);
          //?prepare the list of spools
          //?create a user space
          quscrtus ( Usrspc//?get memory for array
             : *BLANK
             : 1
             : x'00'
             : '*ALL'
             : *BLANK
             : '*YES'
             : Errcode
             : '*USER'
             );
B02       if (errcode.available>0);
             message(errcode.msgid:errcode.msgdta:'':'QCPFMSG'          );
             leave;
E02       endif;
          //?with attribute auto-extensible
          quscusat ( Lib
             : Usrspc
             : Attributes
             : ErrCode
             );
B02       if (errcode.available>0);
             message(errcode.msgid:errcode.msgdta:'':'QCPFMSG'          );
             leave;
E02       endif;
          //?get list of spools
          quslspl(usrspc//? user_space
             : 'SPLF0300'             //  Format
             : '*ALL'                 //  UserName
             : '*ALL'                 //  OutqName
             : '*ALL'                 //  FormType
             : '*ALL'                 //  UserData
             : errcode );
B02       if (errcode.available>0);
             message(errcode.msgid:errcode.msgdta:'':'QCPFMSG');
             w2flsp = '50';
             iter;
E02       endif;
          //?use LAH as a mask to format & read the user space
          qusptrus(usrspc : pLAH);
B02       for iSpl= 0 to lah.count - 1;
             //?get data to load element
             psplf0300 = pLAH + LAH.Data_Offset + iSpl * LAH.entry_Size ;

B03          if  splf0300.spool_name = 'QPJOBLOG'  and
                   (splf0300.spool_status = 4 or splf0300.spool_status = 6);
                d_selected = d_savedlog ;
E03          endif;
B03          if  splf0300.spool_name = 'QPJOBLOG'  and
                 not ( splf0300.spool_status = 4 or splf0300.spool_status = 6) ;
                d_selected = d_joblog ;
E03          endif;
B03          if  splf0300.spool_name<> 'QPJOBLOG'  and
                   (splf0300.spool_status = 4 or splf0300.spool_status = 6);
                d_selected = d_saved ;
E03          endif;
B03          if splf0300.spool_name<> 'QPJOBLOG'  and
                 not ( splf0300.spool_status = 4 or splf0300.spool_status = 6) ;
                d_selected = d_standard;
E03          endif;
B03          if splf0300.date_created < d_selected;
                //?dltsplf
                cmde='DLTSPLF FILE('+%trim(Splf0300.Spool_name)+
                   ') JOB('+Splf0300.Job_number+'/'+%trim(splf0300.User_name)+
                   '/'+%trim(splf0300.Job_name)+
                   ') SPLNBR('+%char(splf0300.Spool_number)+')' ;
                message('CPF9898':cmde:'':'QCPFMSG');
                rc = c_system(cmde );
B04             if rc <> 0;
                   message(msgid:'':'':'QCPFMSG');
E04             endif;
E03          endif;
E02       endfor;
E01    enddo ;
       //?---------------------------------------------------------------
       //?begsr        ;
       //?endsr;
       //?---------------------------------------------------------------
      /end-free
    ? *//----------------------------------------------------------------
    ? *// *inzsr, sr pmqsnd, sp *pssr , ...
    ? *//----------------------------------------------------------------
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
