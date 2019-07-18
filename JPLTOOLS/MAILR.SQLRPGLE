    ? *  this program receive these parameters from the MAIL command, and sends a mail
    ? *  MAIL SUBJECT('a new mail tool')
    ? *       SENDER(*me)
    ? *       RECEIVER((*TO 'you@company.com')
    ? *                (*CC 'you@company.com')
    ? *                (*BCC 'you@company.com'))
    ? *       MESSAGE('<html><body><h3>Hello,<br>How are you ?</h3></body></html>')
    ? *       MSGTYPE('text/html')
    ? *       ATTACH((*BIN *ATTACHED 'image/jpeg' '/jpl/jpl.bmp'))
    ? *=---------------------------------------------------------------------------------------
    ? * to compile :
    ? *=---------------------------------------------------------------------------------------
    ? *  CRTDTAARA DTAARA(MAIL)
    ? *            TYPE(*CHAR)
    ? *            LEN(100)
    ? *            VALUE('/Mail')
    ? *            TEXT('Mail temporary files root')
    ? *
    ? *
    ? *  references :
    ? *  rfc822 : mail header (http://www.nalanda.nitc.ac.in/misc/rfc/html/rfc822.html)
    ? *  rfc1521 : mimemail (http://www.nalanda.nitc.ac.in/misc/rfc/html/rfc1521.html)
    ? *
    ? *
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define INFDS
      /define IFS
      /define LOWERCASE
      /define CSYSTEM
      /define DATA_SECTION
      /define ICONV
      /include jpltools,JP4inc
      /undefine DATA_SECTION
     D IfsName         s            512a   varying
     D MimeCheckEmail  pr              n
     D email                        256a   varying
    ? *==================================================================
    ? * Type definitions for Code Conversion APIs
    ? *==================================================================
     D* iconv_t        ds                  based(pDummy)
     d*                                    qualified
     D*  rc                          10i 0
     D*  cd                          10i 0 dim(12)
    ? *==================================================================
    ? * Prototype for iconv_open()--Code Conversion Allocation API
    ? *==================================================================
     D*iconv_open      pr                  extproc('QtqIconvOpen') like(iconv_t)
     D* pToCode                        *   value
     D* pFromCode                      *   value
    ? *==================================================================
    ? * Prototype for iconv()--Code Conversion API
    ? *==================================================================
     D iconv_c         pr            10i 0 extproc('iconv')
     D   cd                                value  like(iconv_t)
     D   pInBuf                        *   const
     D   inBytesLft                  10u 0 const
     D   pOutBuf                       *   const
     D   outBytesLft                 10u 0 const
    ? *==================================================================
    ? * Prototype for iconv_close()--Code Conversion Deallocation API
    ? *==================================================================
     D*iconv_close     pr            10i 0 extproc('iconv_close')
     D*  cd                                value  like(iconv_t)
    ? *==================================================================
    ? * SendMail from TCP tools
    ? * =doc=
    ? * iseries info center
    ? *  reseau
    ? *   tcpip
    ? *    courrier electronique
    ? *     send and receive email
    ? *      qtmmsendmail api
    ? *     troubleshoot email
    ? *      solve problems with qtmmsendmail
    ? *==================================================================
    ? * void QtmmSendMail( /* Message Description Pointer */
    ? *
    ? *                       char *             Filename,
    ? *                       long int *         Filename_Length,
    ? *                       char *             Originator,
    ? *                       long int *         Originator_Length,
    ? *                       Qtmm_ADDT0100_t *  First_Recipient,
    ? *                       long int  *        Total_Num_Of_Recipients,
    ? *                       void  *       /* API Returned Error  */
    ? *                       );
     d qtmmsendmail    pr                  extproc('QtmmSendMail')
     d   Filename                   255
     d   Filename_Len                      like(typebin4)
     d   Sender                     255
     d   Sender_Len                        like(typebin4)
     d   Recipients                 280    dim(1000)
     d   Recipients_nbr...
     d                                     like(typebin4)
     d   API_Return                 256

     D MimeClose       pr
     D MimeOpen        pr
     D  FileName                    512a   varying const
     D MimeSubject     pr
     d    Subject                    70    varying const
     d MimeImportance  pr
     d    Importance                 10
     d MimePriority    pr
     d    Priority                   10            const
     d MimeSensitivity...
     d                 pr
     d    Sensitivity                20            const
     d MimeNotify      pr
     d    NotifyTo                   70            const
     d MimeBoundary    pr
     d    Boundary                  256    varying const
     d MimeSender      pr
     d    Sender                    256    varying const
     d MimeReceiver    pr
     d    Type                        3u00 const
     d    Receiver                  256    varying const
     d MimeFlushHeader...
     d                 pr
     d MimeBody        pr
     d    MimeText                 5000    varying const
     d    MimeType                   30    varying const
     d MimeAttach      pr
     d    filename                  512            const
     d    MimeType                   40    varying const
     d    BinText                     1            const
     d    EmbbedAttach...
     d                                1            const
     d    rename                    512    varying const options(*nopass)
     D MimeGetB64      pr
     D FromFName                    512a           const
     D MimeGetText     pr
     D FromFName                    512a           const
     D MimeSend        pr
    ? * Retrieve TCP/IP Attributes (QtocRtvTCPA) API
    ? * 1 Receiver variable Output Char(*)
    ? * 2 Length of receiver variable Input Binary(4)
    ? * 3 Format name Input Char(8)
    ? * 4 Error code I/O Char(*)
    ?d*QtocRtvTCPA     pr                  extproc('QtocRtvTCPA')
    ?d*  Receiver                      *   value
    ?d*  Length                       9b 0 value
    ?d*  Format                       8    value
    ?d*  API_Return                    *   value

     D QtocRtvTcpA     Pr                  ExtProc( 'QtocRtvTCPA' )
     D  RtRcvVar                  32767a          Options( *VarSize )
     D  RtRcvVarLen                  10i 0 Const
     D  RtFmtNam                      8a   Const
     D  RtError                   32767a          Options( *VarSize )

     d TCPA0100        ds                  qualified based(pTCPA0100)
     d Bytes_returned                 9b 0
     d Bytes_avail                    9b 0
     d stack_status                   9b 0
     d How_long                       9b 0
     d starteddate                    8
     d startedTime                    6
     d endedDate                      8
     d endedtime                      6
     d Whostartedjob                 10
     d Whostarteduser                10
     d Whostartednb                   6
     d Whostartedid                  16
     d Whoendedjob                   10
     d Whoendeduser                  10
     d Whoendednb                     6
     d Whoendedid                    16
     d Offset_information...
     d                                9b 0
     d Length_information...
     d                                9b 0
     d Limited_mode                   9b 0

     d TCPA0300        ds                  qualified based(pTCPA0300)
     d Offset_to_list_of_internet_addresses...
     d                                9b 0
     d Number_of_internet_addresses...
     d                                9b 0
     d Entry_length_for_list_of_internet_addresses...
     d                                9b 0
     d DNS_protocol...
     d                                9b 0
     d Retries...
     d                                9b 0
     d Time_interval...
     d                                9b 0
     d Search_order...
     d                                9b 0
     d Initial_domain_name_server...
     d                                9b 0
     d DNS_listening_port...
     d                                9b 0
     d Host_name...
     d                               64
     d Domain_name...
     d                              255
     d Reserved...
     d                                1
     d Domain_search_list...
     d                              255
    ? * http://www.systeminetwork.com/artarchive/index.cfm?fuseaction=viewNewsletterArticle
    ? * &articleID=52432&webID=1001&override=0
    ? *
    ? * Get SMTP Name Programmatically
    ? * by Scott Klement
    ? * System iNetwork Programming Tips Editor
    ? * April 17, 2006
    ? *
    ? *
    ? *
    ? *Search System Directory (QOKSCHD) API
    ? *
    ? *  Required Parameter Group:
    ? *
    ? *1 Receiver variable Output Char(*)
    ? *2 Length of receiver variable Input Binary(4)
    ? *3 Format name of receiver variable Input Char(8)
    ? *4 Function Input Char(10)
    ? *5 Keep temporary resource indicator Input Char(1)
    ? *6 Request variable Input Char(*)
    ? *7 Length of request variable Input Binary(4)
    ? *8 Format name of request variable Input Char(8)
    ? *9 Error code I/O Char(*)
     d qokschd         Pr                  ExtPGM('QOKSCHD')
     d   Receiver_variable...
     d                            32767a          Options( *VarSize )
     d   Length_of_receiver...
     d                               10i 0 const
     d   Format                       8    const
     d   Function                    10    const
     d   Keep_indicator...
     d                                1    const
     d   Request                  32767a   const  Options( *VarSize )
     d   Length_of_request...
     d                               10i 0 const
     d   Format_of_request...
     d                                8    const
     d   Error_code               32767a          Options( *VarSize )
     d
     d p               s               *
     d SREQ0100        ds                  qualified
     d CCSID                         10i 0
     d Character                     10i 0
     d Code_page                     10i 0
     d Wildcard                       4
     d Convert_data                   1
     d Data_to_search                 1
     d Run_verify                     1
     d Continue_Hnd                   1
     d Resource_hnd                  16
     d Search_format                  8
     d Search_Offset                 10i 0
     d Search_count                  10i 0
     d Return_Format                  8
     d Return_Offset                 10i 0
     d Return_Count                  10i 0
     d Users_Format                   8
     d Users_count                   10i 0
     d User_Format                    8
     d Order_Format                   8
     d Return_order                   1
     d Reserved                       3
     d Search_array                1028a

     d SREQ0101        ds          1028    qualified based(pSreq0101)
     d Entry_Length                  10i 0
     d Compare                        1
     d name                          10
     d Product_ID                     7
     d Case                           1
     d Reserved                       1
     d Value_Length                  10i 0
     d Value                       1000a
    ?d*SREQ0102        ds                  qualified
     d SREQ0103        ds                  qualified based(pSreq0103)
     d Value                         10a
     d SREQ0200        ds                  qualified
     d   directory_type...
     d                                1
     d   handle...
     d                               17
     d SRCV0100        ds                  qualified
     d   bytes_returned...
     d                               10i 0
     d   Offset_to_order_array...
     d                               10i 0
     d   Offset_to_users...
     d                               10i 0
     d   count...
     d                               10i 0
     d   Continuation_handle...
     d                                1
     d   Resource_handle...
     d                               16
     d   data...
     d                            10000

     d SRCV0101        ds                  qualified based(pSrcv0101)
     d   Length                      10i 0
     d   count                       10i 0
     d   Array                    32767a
    ?d*SRCV0111        ds                  qualified
     d SRCV0112        ds                  qualified based(pSrcv0112)
     d   CCSID                       10i 0
     d   Code_page                   10i 0
     d   Length                      10i 0
     d   value                    32767a
    ?d*SRCV0120        ds                  qualified
    ?d*SRCV0200        ds                  qualified

     D MimeFile        ds                  qualified
     d    filename                  512    varying
     d    Subject                    70    varying
     d    Importance                 10                                         Low,
    ?d*                                                                         Medium,
    ?d*                                                                         High
     d    Priority                   10                                         non-urgent
    ?d*                                                                         normal
    ?d*                                                                         urgent
     d    Sensitivity                20                                         normal,
    ?d*                                                                         personal,
    ?d*                                                                         private,
    ?d*                                                                         Company-Confidential
     d    NotifyTo                   70
     d    Boundary                  256    varying
     d    Sender                    256    varying
     d    Receiver                     *
     d    ReceiverCount...
     d                                5u00
     d    ReceiverSize...
     d                                5u00
     d    ToList                  10000    varying
     d    CCList                  10000    varying
     d    BCCList                 10000    varying

    ? * list separators
     d    ToSep        s             10    varying inz('To:')
     d    ccSep        s             10    varying inz('Cc:')
     d    bccSep       s             10    varying inz('Bcc:')

     d MimeValue       ds                  qualified
     d   Importance_low...
     d                               10    inz('Low')
     d   Importance_Medium...
     d                               10    inz('Medium')
     d   Importance_High...
     d                               10    inz('High')
     d   Priority_nonurgent...
     d                               10    inz('non-urgent')
     d   Priority_normal...
     d                               10    inz('normal')
     d   Priority_urgent...
     d                               10    inz('urgent')
     d   Sensitivity_normal...
     d                               20    inz('normal')
     d   Sensitivity_personal...
     d                               20    inz('personal')
     d   Sensitivity_private...
     d                               20    inz('private')
     d   Sensitivity_confidential...
     d                               20    inz('company-confidential')
     d   Send_To                      3u00 inz(0)
     d   Send_CC                      3u00 inz(1)
     d   Send_BCC                     3u00 inz(2)
     d   Attach_InBody...
     d                                 n   inz(*on)
     d   Attach_AsFile...
     d                                 n   inz(*off)
     d   Attach_Binary...
     d                                1    inz('B')
     d   Attach_Text...
     d                                1    inz('T')

     d MimeFileHandle  s             10i 0
     d MimeBuffer      s          65000    varying
     d rc              s             10i 0

     d mailr           pr
     d subject                       70
     d sender                       250
     d receiver                   25602                                         100*(4+250)+100*2+2
     d body                        5000
     d msgtype                       30
     d attach                     36202                                          100*(2+255+40+5+10)
     d importance                    10
     d priority                      10
     d sensitive                     20

     d mailr           pi
     d subject                       70
     d sender                       250
     d receiver                   25602                                         100*(4+250)+100*2+2
     d body                        5000
     d msgtype                       30
     d attach                     36202
     d importance                    10
     d priority                      10
     d sensitive                     20

     d count           s              5i00 based(countP)
     d offset          s              5i00 based(offsetP)
     d UserName        s             10

     d aReceiver       ds                  based(aReceiverP)
     d  receiverNb                    2
     d  sendAs                        4
     d  sendAddr                    250

     d anAttachment    ds                  based(AnAttachmentP)
     d  AffNb                         2
     d  AttBinText                    5
     d  AttEmbbed                    10
     d  AttType                      40
     d  AttName                     255
     d  AttRename                    50
     d  bintext        s              1
     d  InBody         s               n

     d  MailRoot       s            100    dtaara(mail)

     d mai0001         ds                  qualified
     d  pos                           5u00
     d  email                       256
     d  allowed                      69

      /free
       UseErrno();
       PortableChar = ConvCcsid(PortablecharInz.ccsid:0:PortableCharInz);
       PortableChar.CCSID=0;
       in MailRoot;
       UserName = spjbus;
        ifsname = %trim(mailroot)
           +'/' + %trim(spjbnm) + '_' + %trim(spjbus) + '_'
           + %char(SPJBNB)      + '_'
           + %xlate('.:/-':'____':%char(%timestamp()))
                           + '_mailwork.txt';
       mimeOpen(IfsName) ;
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;
       mimesubject(%trim(subject));
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;
       mimeSender(%trim(sender)) ;
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;
       //?
       //? 00030208 01080008 00025CC2 C3C39185   - ..........*BCCje
       //? 81954B97 81A4934B 93819496 95A39985   - an.paul.lamontre
       //? 44839695 A2A493A3 8195A34B A59693A5   - @consultant.volv
       //? 964B8396 94404040 40404040 40404040   - o.com
       //? 40404040 40404040 40404040 40404040   -
       //?
       //? 1-2 : nb valeurs
       //? {nb @ 1} * 2 + 1 = @ 1 valeur
       //? @ valeur -> longueur + texte
       countP= %addr(Receiver);
B01    for iFor = 1 to count;
          offsetP = %addr(Receiver)+iFor*2;
          aReceiverP = %addr(Receiver) + offset ;
B02       select;
X02          when sendas = '*TO';
                mimeReceiver(mimevalue.Send_To : %trim(SendAddr));
X02          when sendas = '*CC';
                mimeReceiver(mimevalue.Send_CC : %trim(SendAddr));
X02          when sendas = '*BCC';
                mimeReceiver(mimevalue.Send_BCc: %trim(SendAddr));
E02       endsl;
          //?if errno() <> 0;
          //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
          //?endif;
E01    endfor;
       //? if notify <> '';
       //?    mimenotify(notify);
       //? endif;
       MimeFlushHeader();
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;

B01    if body    <> '';
          mimebody(%trim(body ):%trim(msgtype));
E01    endif;
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;


       //?mime types : look at 'HKEY_CLASSES_ROOT\MIME\Database\Content Type'
       countP= %addr(Attach );
B01    if count > 0;
B02       for iFor = 1 to count;
             offsetP = %addr(Attach )+iFor*2;
             anAttachmentP = %addr(Attach)+offset;
B03          if AttBinText = '*BIN';
                bintext = mimevalue.attach_binary;
X03          else;
                bintext = mimevalue.attach_text ;
E03          endif;
B03          if AttEmbbed  = '*BODY' ;
                inbody = mimevalue.attach_inbody;
X03          else;
                inbody = mimevalue.attach_asFile;
E03          endif;




             mimeattach( attName : AttType
                : bintext : inbody: attRename);
             //?if errno() <> 0;
             //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
             //?endif;
E02       endfor;
E01    endif;
       MimeClose();

       //?debug
       //  unlink('/jpl/debug.txt');
       //  link(ifsname : '/jpl/debug.txt');
           link(ifsname :
                       '/jpl/' + %trim(spjbnm) + '_' + %trim(spjbus) + '_'
                      + %char(SPJBNB)      + '_'
                      + %xlate('.:/-':'____':%char(%timestamp()))
                                      + '_mailwork.txt');


       //?CPY OBJ('/jpl/MailText.txt')
       //?  TOOBJ('/jpl/lastMail.txt')
       //?delete the file
       //? rc= unlink ('/jpl/lastMail.txt');
       //? if rc <> 0;
       //?    if errno <> 3025;
       //?       escerrno(errno);
       //?    endif;
       //? endif;
       //? rc =  c_system('cpy obj(''' + mimefile.filename
       //?    + ''') toobj(''/jpl/lastMail.txt'')'
       //?    );
       //? if rc <> 0;
       //?    message(msgid:'':'':'QCPFMSG');
       //? endif;
       MimeSend() ;
       *inlr = *on;


      /define PSSR
B00    begsr *pssr ;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;
       unlink(IfsName) ;
E00    endsr '*CANCL';
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
    ? *=---------------------------------------------------------------=*

BPR  p MimeCheckEmail  b
     D MimeCheckEmail  pi              n
     D email                        256a   varying
     D emailName       s            256a   varying
     D emailDomain     s            256a   varying
     D checker         s            256a   varying
     d i               s              5u00
     d j               s              5u00
     d nbrdots         s              5u00
     d AllowedChar     s             69    inz('-
     d                                     abcdefghijklmnopqrstuvwxyz-
     d                                     ABCDEFGHIJKLMNOPQRSTUVWXYZ-
     d                                     0123456789.-_@[]#')
     d AllowedIP       c                   const('0123456789.')
     d NumberSign      s              1    inz('#')
     d LsqB            s              1    inz('[')                             left square bracket
     d RsqB            s              1    inz(']')                             Right square bracket
     d x1b             s              1
     d x1e             s              1
     D APIError        ds
     D  APIBytes               1      4B 0
     D  APIreturn              5      8B 0
     D  CpfID                  9     15
     D  CpfDta                17    256
      /free
        // inz constants sensitives to ccsid
        allowedChar = 'abcdefghijklmnopqrstuvwxyz'
              + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
              + '0123456789.-_'
              + portablechar.AtSign
              + portablechar.LeftBracket
              + portablechar.RightBracket
              + portablechar.NumberSign;

            NumberSign=portablechar.NumberSign;
            LsqB      =portablechar.LeftBracket ;
            RsqB      =portablechar.RightBracket ;
      /end-free
B01  c                   if        email = '*ME'
B02  c                   do        1
      /free
             //?search my mail with Search System Directory (QOKSCHD) API
             clear sreq0100;
             sreq0100.CCSID = 0 ;
             sreq0100.Character = 0 ;
             sreq0100.Code_page = 0 ;
             sreq0100.Wildcard       = ''                  ;
             sreq0100.Convert_data   = '0'                 ;
             sreq0100.Data_to_search = '0'                 ;
             sreq0100.Run_verify     = '1'                 ;
             sreq0100.Continue_Hnd   = '0'                 ;
             sreq0100.Resource_hnd   = ''                  ;
             sreq0100.Search_format  = 'SREQ0101'          ;
             sreq0100.Search_Offset =
                %addr(sreq0100.search_array)
                - %addr(sreq0100 );
             sreq0100.Search_count = 0 ;
             sreq0100.Return_Format  = 'SREQ0103'          ;
             //?   sreq0100.Return_Offset = ? ;
             sreq0100.Return_Count = 0 ;
             sreq0100.Users_Format   = 'SRCV0101'          ;
             sreq0100.Users_count = 0 ;
             sreq0100.User_Format    = 'SRCV0112'          ;
             sreq0100.Order_Format   = ''                  ;
             sreq0100.Return_order   = '0'                 ;
             sreq0100.Reserved       = ''                  ;

             sreq0100.Search_array   = ''                  ;
             p = %addr(sreq0100.search_array);
             psreq0101 = p;
             //?critere de recherche
             //?sur le profil utilisateur
             sreq0101.Value = spjbus;
             sreq0101.Value_Length = 10;
             sreq0101.name = 'USER';
             sreq0101.compare='1';
             sreq0101.Product_ID ='*IBM';
             sreq0101.Case='0';
             sreq0101.entry_length = 28 + sreq0101.Value_Length ;

             p+=sreq0101.entry_length;
             sReq0100.search_count+=1;
             //?information recherchee
             sreq0100.Return_Offset = p - %addr(sreq0100);
             psreq0103 = p;
             sreq0103.value='*SMTP';
             sreq0100.Return_Count+= 1 ;

             clear ApiError ;
             ApiBytes= %size(ApiError) ;
             qokschd(
                srcv0100
                : %len(srcv0100)
                : 'SRCV0100'
                : '*SEARCH'
                : '0'
                : sreq0100
                : %len(sreq0100)
                : 'SREQ0100'
                : ApiError );

B03          if apireturn = 0
X..             and srcv0100.count=1;
                //?srvc0100.count = 1 or there is an error *=0 : not defined *> 1 : strange
                p = %addr(srcv0100);
                psrcv0101 = p + srcv0100.Offset_to_users;
                pSRcv0112 = psrcv0101 + 8;
                email = %subst(srcv0112.value:1:srcv0112.length);
                pSrcv0112+=srcv0112.length+12;
                email+=portablechar.AtSign
                          +%subst(srcv0112.value:1:srcv0112.length);
                email=lcase(email);
X03          else;
                i = %len(tcpa0100)+%len(tcpa0300) ;
                pTcpa0100 = %alloc(i);
                clear ApiError ;
                ApiBytes= %size(ApiError) ;
                //?QtocRtvTCPA(ptcpa0100:i:'TCPA0300':%addr(ApiError));
                qtocRtvTcpA( TCPA0100
                   : i
                   : 'TCPA0300'
                   : ApiError
                   ) ;
B04             if apireturn > 0;
                   message(cpfid:cpfdta);
                   clear tcpa0100;
E04             endif;
                ptcpa0300 = ptcpa0100+tcpa0100.Offset_information;
                email = %trim(username)+'.' + %trim(tcpa0300.Host_name)
                   +portablechar.AtSign
                        + %trim(tcpa0300.Domain_name);
                dealloc Ptcpa0100;
E03          endif ;
E02       enddo;
          message('':'*ME=' + email);
E01    endif ;
       //?valid characters only
       //?i know, it would be cleaner with a regular expression.
       //?lack of time
       //?lost web page on regexp in rpg
       //?if you improve this procedure, feed back.
          mai0001.pos = 0;
          mai0001.email=email;
          mai0001.allowed=allowedchar;
       i = 0;
       i = %check(AllowedChar :Email);
B01    if i > 0;
          mai0001.pos = i;
          message('MAI0001':mai0001);
          return false;
E01    endif;
       //?* one @ is mandatory
       i = 0;
       i = %scan(portablechar.AtSign:email);
B01    if i <= 1;
          message('MAI0002':mai0001);
          return false;
E01    endif;
       emailName = %subst(email:1:i-1);
       emailDomain=%subst(email:i+1);
       //?* Only one @ is allowed
       i = 0;
       i = %scan(portablechar.AtSign :emailDomain);
B01    if i >= 1;
          message('MAI0003':mai0001);
          return false;
E01    endif;
       //?* Unsupported initial/ending char.s in email1
       i = %len(EmailName);
       x1b = %subst(emailName:1:1) ;
       x1e = %subst(emailName:i:1) ;
B01    if x1b='.' or x1e= '.'      ;
          message('MAI0004':mai0001);
          return false;
E01    endif ;
       //?* Groups of consecutive chars not allowed in emailDomain
       i = %scan('..':EmailDomain)   ;
B01    if i>0 ;
          message('MAI0005':mai0001);
          return false;
E01    endif ;
       i = %scan('-.':EmailDomain)      ;
B01    if i>0 ;
          message('MAI0006':mai0001);
          return false;
E01    endif ;
       i = %scan('_.':EmailDomain);
B01    if i>0 ;
          message('MAI0007':mai0001);
          return false;
E01    endif ;
       i = %scan('.-':EmailDomain)   ;
B01    if i>0 ;
          message('MAI0008':mai0001);
          return false;
E01    endif ;
       i = %scan('._':EmailDomain)      ;
B01    if i>0 ;
          message('MAI0009':mai0001);
          return false;
E01    endif ;
       i = %scan(NumberSign+'.':EmailDomain);
B01    if i>0 ;
          message('MAI0010':mai0001);
          return false;
E01    endif ;
       i = %scan('.'+NumberSign:EmailDomain)   ;
B01    if i>0 ;
          message('MAI0011':mai0001);
          return false;
E01    endif ;
       //?* Unsupported initial/ending char.s in EmailDomain
       i = %len(emailDomain);
       x1b = %subst(EmailDomain:1:1) ;
       x1e = %subst(EmailDomain:i:1) ;
B01    if x1b                    ='.' or
             x1b                    ='-' or
             x1b                    ='_' or
             x1b =NumberSign or
             x1e                    ='.' or
             x1e                    ='-' or
             x1e                    ='_' or
             x1e =NumberSign ;
          message('MAI0012':mai0001);

          return false;
E01    endif ;
       //?* If "EmailDomain" = [ipaddress]
B01    if x1b =LSqB and
             x1e <>RSqB ;
          message('MAI0013':mai0001);
          return false;
E01    endif ;
B01    if x1b <>LSqB and
             x1e =RSqB ;
          message('MAI0014':mai0001);
          return false;
E01    endif ;
       //?* Check the IP Address
B01    IF x1b =LSqB and
             x1e =RSqB ;
B02       if i < 7 ;
             message('MAI0015':mai0001);
             return false;
E02       endif ;
          j = %scan(AllowedIP:%subst(EmailDomain:2:i-2));
B02       if j > 0;
             message('MAI0016':mai0001);
             return false;
E02       endif;
          nbrdots = 0 ;
B02       for j = 2 to i-2;
B03          if %subst(emaildomain:j:1) = '.';
                nbrdots+=1;
E03          endif;
E02       endfor;
B02       if nbrdots <> 3 ;
             message('MAI0017':mai0001);
             return false;
E02       endif ;
E01    endif ;
       return true;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeSend        b
     D MimeSend        pi
    ? *=============================================
    ? * "QTMMSNDMAIL" REQUIRED PARAMETER GROUP
     D MyMimeFile      s            255a
     D MimeFileLn      s              9b 0
     D Sender          s            255a
     D SenderL         s              9b 0
     D Recipients      s            280    dim(1000)
     D TotalRecp       s              9B 0
    ? * API error info
     D APIError        ds
     D  APIBytes               1      4B 0
     D  APIreturn              5      8B 0
     D  CpfID                  9     15
     D  CpfDta                17    256
    ? *=============================================
    ? *  LAYOUT OF A SINGLE RECIPIENT (ADDT0100)
     D Recipient       ds
    ? *                                           offset to next address structure
     D  OffSet                 1      4B 0
    ? *                                           length of recipient e-mail address
     D  ToAddrLen              5      8B 0
    ? *                                           always 'ADDT0100'
     D  Format                 9     16
    ? *                                           distribution type: 0=normal, 1=cc, 2=bcc
     D  DistrType             17     20B 0
     D  Reserved              21     24B 0
    ? *                                           e-mail address of recipient
     D  ToAddr                25    280
    ? *=============================================                                          RADDAT
    ? * VARIABLES USED BY SUBPROCEDURE "iconv*"                                               RADDAT
     D  isInitIconv    s               n   inz(*off) static                                   RADDAT
     D  toCode         ds                  qualified                                          RADDAT
     D         ccsid                 10i 0 inz(500)                                           RADDAT
     D         convA                 10i 0 inz(0)                                             RADDAT
     D         subA                  10i 0 inz(0)                                             RADDAT
     D         shftA                 10i 0 inz(1)                                             RADDAT
     D         lnOpt                 10i 0 inz(0)                                             RADDAT
     D         erOpt                 10i 0 inz(1)                                             RADDAT
     D         res                   12a   inz(*ALLx'00')                                     RADDAT
     D  fromCode       ds                  qualified                                          RADDAT
     D          ccsid                10i 0 inz(0)                                             RADDAT
     D          convA                10i 0 inz(0)                                             RADDAT
     D          subA                 10i 0 inz(0)                                             RADDAT
     D          shftA                10i 0 inz(1)                                             RADDAT
     D          lnOpt                10i 0 inz(0)                                             RADDAT
     D          erOpt                10i 0 inz(1)                                             RADDAT
     D          res                  12a   inz(*ALLx'00')                                     RADDAT
     D  hIconv         ds                  likeds(iconv_t) inz
     d
    ? *==================================================================
     D i               s             10i 0
     D ToAddrCount     s             10i 0
     d eMail           s            255    varying
     d NewRec          ds                  based(NewRecP)
     d rlen                           3u00
     d rtype                          3u00
     d RAddr                        256    varying
      /free
?      //?* Initialize Code Conversion
       //?if errno() <> 0;
       //?message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
       //?endif;
B01    if not isInitIconv ;
          hIconv = iconv_open(%addr(toCode) :
             %addr(fromCode) ) ;
B02       if hiconv.rc <> 0;
B03          if errno() <> 0;
                message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
E03          endif;
E02       endif;
          isInitIconv = *on ;
E01    endif ;
       //?* Prepare to Send MIME message
       CpfID = ' '    ;
       MyMimeFile = MimeFile.filename ;
       MimeFileLn = %len(%trimr(MyMimeFile)) ;
       //?emails have to be in ccsid 500

       Sender=mimefile.sender;
       rc = iconv_c(hIconv:
          %addr(Sender ): %size(Sender ):
          %addr(Sender ): %size(Sender )) ;
B01    if rc< 0;
B02       if c_errno <> 0;
             message(errnomsg(c_errno):'':'*LIBL':'QCPFMSG') ;
E02       endif;
E01    endif;
       SenderL = %len(%trimr(Sender ));
       Format     = 'ADDT0100'  ;
       Reserved = 0 ;
       //?* Fill in the "Recipients" array
       NewRecP = mimefile.receiver ;
B01    for i = 1 to mimefile.receivercount;

          clear recipient;
          ToAddr = raddr;
          //?*                  check recipient's e-mail
          rc= iconv_c(hIconv:
             %addr(ToAddr): %size(ToAddr):
             %addr(ToAddr): %size(ToAddr)) ;
B02       if rc < 0;
B03          if errno() <> 0;
                message(errnomsg(errno()):'':'*LIBL':'QCPFMSG') ;
E03          endif;
E02       endif;
          ToAddrLen = %len(%trimr(ToAddr)) ;
B02       if rType = 0 or rType = 1 or rType = 2 ;
             DistrType = rType ;
X02       else;
             DistrType = 0 ;
E02       endif;
B02       if i < mimefile.receivercount;
             OffSet= 280 ;
E02       endif;
          format='ADDT0100';

          Recipients(i) = recipient ;
          NewRecP+=rlen;
E01    endfor;
       //?* Total number of recipients
       TotalRecp = mimefile.receivercount;
       //?* Call API to send e-mail
       clear ApiError ;
       ApiBytes= %size(ApiError) ;

       QtmmSendMail(
          MyMimeFile
          : MimeFileLn
          : Sender
          : SenderL
          : Recipients
          : TotalRecp
          : APIError ) ;
       //?* Retrieve error message, if any
B01    IF ApiReturn>=8 ;
          message (CpfId : Cpfdta : '' : 'QCPFMSF':'*ESCAPE');
X01    ELSE ;
          message('':'MIME message submitted to MSF' );
E01    ENDIF ;
       //?* End Code Conversion
B01    if isInitIconv ;
          iconv_close(hIconv) ;
          isInitIconv = *off ;
E01    endif ;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
BPR  p MimeClose       b
     D MimeClose       pi
     D WriteData       s          65535
     D WriteLen        s             10i 0
     D RC              S             10i 0
    ? /free
       mimebuffer = crlf + '--' + mimefile.boundary + '--' + crlf;
       WriteLen=%len(MimeBuffer);
       writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;
       Rc = close(MimeFileHandle) ;
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeOpen        b
     D MimeOpen        pi
     D  FileName                    512a   varying const
    ? /free
       //?delete the file
       rc= unlink (FileName );
B01    if rc <> 0;
B02       if errno <> 3025;
             escerrno(errno);
E02       endif;
E01    endif;
       //?create a file & declare implicit code page converter
       MimeFileHandle = open(FileName
          : O_CREAT + O_WRONLY + O_TRUNC + O_CODEPAGE
          : S_IRWXU + S_IROTH
          : CP_ISO8859_1 ) ;
B01    if MimeFileHandle = -1;
          escerrno(errno);
E01    endif;
       //?close the file to be able
       Rc = close(MimeFileHandle) ;
       //?to reopen it with O_TEXTDATA flag, the ones that controls code page convertion
       MimeFileHandle = open(FileName
       //?: O_RDWR + O_APPEND) ;
          : O_TEXTDATA + O_RDWR + O_APPEND) ;
       clear mimefile;
       Mimefile.filename = filename;
       Mimefile.importance='Low';
       Mimefile.priority='normal';
       Mimefile.sensitivity='normal';
       //? Mimefile.boundary='**jpltools/' + %char(SPJBNB)
       //?    + '/' + %trim(spjbus) + '/' + %trim(spjbnm) + '**';
       Mimefile.boundary= %char(SPJBNB)
          + %trim(spjbus) + %trim(spjbnm) ;
       mimefile.receiver = %alloc(1);
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeSubject     b
     D MimeSubject     pi
     d    Subject                    70    varying const
    ? /free
       mimefile.subject=subject;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeImportance  b
     d MimeImportance  pi
     d    Importance                 10
    ? /free
B01    if importance = MimeValue.Importance_low or
             importance = mimevalue.Importance_Medium or
             importance = mimevalue.Importance_High ;
          mimefile.importance = importance;
E01    endif;
       return ;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimePriority    b
     d MimePriority    pi
     d    Priority                   10            const
    ? /free
B01    if priority = mimevalue.Priority_nonurgent or
             priority = mimevalue.Priority_normal or
             priority = mimevalue.Priority_urgent ;
          mimefile.priority = priority;
E01    endif;
       return ;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p MimeSensitivity...
BPR  p                 b
     d MimeSensitivity...
     d                 pi
     d    Sensitivity                20            const
    ? /free
B01    if Sensitivity = mimevalue.Sensitivity_normal or
             Sensitivity = mimevalue.Sensitivity_personal or
             Sensitivity = mimevalue.Sensitivity_private or
             Sensitivity = mimevalue.Sensitivity_confidential ;
          mimefile.sensitivity = sensitivity;
E01    endif;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeNotify      b
     d MimeNotify      pi
     d    NotifyTo                   70            const
    ? /free
       mimefile.notifyto = notifyTo;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeBoundary    b
     d MimeBoundary    pi
     d    Boundary                  256    varying const
    ? /free
       mimefile.boundary = boundary;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
     p MimeFlushHeader...
BPR  p                 b
     d MimeFlushHeader...
     d                 pi
     D WriteData       s          65535
     D WriteLen        s             10i 0
     D RC              S             10i 0
    ? /free
       mimebuffer='';
       mimebuffer+= 'MIME-Version: 1.0' + crlf ;
       mimebuffer += 'From: ' + mimefile.sender + crlf ;
B01    if %len(mimefile.tolist) > 0;
          mimebuffer+=mimefile.Tolist + crlf ;
E01    endif;
B01    if %len(mimefile.cclist) > 0;
          mimebuffer+=mimefile.cclist + crlf ;
E01    endif;
       //? if %len(mimefile.bcclist) > 0;
       //?    mimebuffer+=mimefile.bcclist + crlf ;
       //? endif;
       MimeBuffer+=
          'Subject: ' + mimefile.subject + crlf
          + 'X-Mailer: IBM Internet Messaging Framework '
          + 'from SystemI5' + crlf
          + 'Importance: ' + mimefile.importance +crlf
          + 'Priority: ' + mimefile.priority + crlf
          + 'Sensitivity: ' + mimefile.sensitivity + crlf
          + 'Content-Type: multipart/mixed;'+crlf+' boundary="'
          + mimefile.boundary + '"' + crlf + crlf ;
       //? + '--' + mimefile.boundary + crlf;


       WriteLen=%len(MimeBuffer);
       writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeBody        b
     d MimeBody        pi
     d    MimeText                 5000    varying const
     d    MimeType                   30    varying const
     D WriteData       s          65535
     D WriteLen        s             10i 0
     D RC              S             10i 0
      /free

       mimebuffer = crlf + '--' + mimefile.boundary + crlf;


       mimebuffer+= 'Content-Type: ' +  mimetype ;
B01    if lcase(mimetype) = 'text/plain'           ;
          mimebuffer +='; charset=ISO-8859-1';
E01    endif;
       mimebuffer+=crlf;

       mimebuffer += 'Content-Disposition: inline;'   ;
       mimebuffer+=crlf;

       mimebuffer+='Content-Description: ' + crlf+crlf;

       WriteLen=%len(MimeBuffer);
       writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;

B01
       mimebuffer = mimetext ;
B01    for ever;
          rc = %scan('\n':mimebuffer);
B02       if rc=0;
             leave;
E02       endif;
          mimebuffer =%replace(crlf:mimetext:rc:2);
E01    endfor;
       WriteLen=%len(MimeBuffer);
       writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;

       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
BPR  p MimeAttach      b
     d MimeAttach      pi
     d    filename                  512            const
     d    MimeType                   40    varying const
     d    BinText                     1            const
     d    EmbbedAttach...
     d                                1            const
     d    rename                    512    varying const options(*nopass)
    ?d****MimeType     s             40    varying
     d Embbed          s               n
     D WriteData       s          65535
     D WriteLen        s             10i 0
     D RC              S             10i 0
     d attName         s            512    varying
     d wMimeType       s             40    varying
     d again           s               n
    ?d*filename        s            512
    ?d*pFileName0      s               *   inz(%addr(FileName0))
    ?d*len             s              5u 0
      /free



       //?check           ?
       //?!! eliminate leading length 2 bytes
       //?len=%len(filename)+1;
       //?%str(pFilename0: len            )=  filename;
       //?filename512 = filename  ;
       rc = access(%trim(filename) :F_OK);
B01    if (rc <> 0);
          escerrno(errno);
E01    endif;

       mimebuffer = crlf + '--' + mimefile.boundary + crlf;

B01    if %parms() >= 5;
          attname= %trim(lcase(rename));
E01    endif;
B01    if attname = '' or attname='*same';
          attname = %trim(lcase(filename));
E01    endif;
       //?remove path from filename
       attname=%xlate('/':'\':attName);
       again = true;
B01    for ever ;
          rc = %scan('\':AttName);
B02       if rc = 0;
             leave;
E02       endif;
          AttName = %subst(attname:rc+1);
E01    endfor;

B01    if embbedAttach = mimevalue.attach_inbody;
          embbed= true;
X01    else;
          embbed=false;
E01    endif;
       //?* Content-type='other' can only be "attached"
B01    if lcase(MimeType)='other';
          embbed=false;
E01    endif ;
       //?* For attachments, Content-type must be "application-octect/stream"
       wmimetype = lcase(mimetype);
B01    //?if embbed=false;
       //?  wmimeType='application/octet-stream';
E01    //?endif;

       mimebuffer+= 'Content-Type: ' + wmimetype ;
B01    if lcase(mimetype) = 'text/plain' and embbed;
          mimebuffer +='; charset=ISO-8859-1';
X01    elseif lcase(%subst(mimetype:1:4))<>'text';
          mimebuffer+= '; name="' + AttName + '"';
E01    endif;
       mimebuffer+=crlf;

B01    if embbed ;
          mimebuffer += 'Content-Disposition: inline;'   ;
X01    else;
          mimebuffer += 'Content-Disposition: attachment;'    ;
E01    endif;
B01    //?if lcase(%subst(mimetype:1:4))<>'text';
       mimebuffer+= ' filename="' + AttName + '"' ;
E01    //?endif;
       mimebuffer+=crlf;

B01    if BinText = 'B';
          mimebuffer+='Content-Transfer-Encoding: base64' + crlf +crlf;
X01    else;
          mimebuffer+='Content-Description: ' + crlf+crlf;
E01    endif;

       WriteLen=%len(MimeBuffer);
       writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
B01    if rc = -1;
          escerrno(errno);
E01    endif;

B01    if BinText = 'T';
          mimeGetText(FileName);
X01    else;
          mimeGetB64 (FileName);
E01    endif;

       //? mimebuffer =  crlf
       //?   +  '--' + mimefile.boundary + crlf;
       //? WriteLen=%len(MimeBuffer);
       //? writedata =MimeBuffer ;//?remove varlen (the first 2 chars)
       //? rc = write(MimeFileHandle : WriteData : WriteLEN ) ;
       //? if rc = -1;
       //?    escerrno(errno);
       //? endif;

       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
BPR  p MimeSender      b
     d MimeSender      pi
     d    Sender                    256    varying const
     d MailAddress     s            256    varying
     c/free
       mailaddress = sender;
B01    if mimeCheckEMail(MailAddress) = false ;
          dumpcallstack();
          needdump=false;
          message('MAI0018':mai0001
             :'':'':'*ESCAPE':'*PGMBDY':1);
E01    endif;
?
       mimefile.sender = MailAddress;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;
E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
BPR  p MimeReceiver    b
     d MimeReceiver    pi
     d    Type                        3u00 const
     d    Receiver                  256    varying const
     d len             s              3u00
     d NewRec          ds                  based(NewRecP)
     d rlen                           3u00
     d rtype                          3u00
     d RAddr                        256    varying
     d EMail           s            256    varying

    ? /free
       email=receiver ;//?*ME converted by MimeCheckMail
B01    if mimeCheckEMail(email ) = false ;
          dumpcallstack();
          needdump=false;
          message('MAI0019':mai0001
             :'':'':'*ESCAPE':'*PGMBDY':1);
E01    endif;
       len = %len(email )+4;
       mimefile.receiversize +=len;
       mimefile.receivercount+=1 ;
       mimefile.receiver = %realloc(mimefile.receiver:mimefile.receiversize);
       NewrecP = mimefile.receiver + mimefile.receiversize - len ;
       rLen = len;
       rtype = type;
       raddr = email ;
B01    select;
X01       when type = mimevalue.Send_To ;
             Mimefile.Tolist+=Tosep + EMAIL;
             Tosep=';';
X01       when type = mimevalue.Send_cc ;
             Mimefile.cclist+=CCsep + EMAIL;
             ccsep=';';
X01       when type = mimevalue.Send_bcc ;
             Mimefile.bcclist+=BCCsep + EMAIL;
             bccsep=';';
E01    endsl;



       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR ?P                 e
    ? *=---------------------------------------------------------------=*
    ? *  BASE64 conversion- How it works
    ? *
    ? *  1. Read IFS file (UNIX-type APIs)
    ? *  2. Split the read 'string' into 3 byte chunks.
    ? *  3. Each chunk has to be converted as follow:
    ? *     Split 24 bits of the chunk into four 6bit binary numbers,
    ? *     convert each number to decimal and using the table below
    ? *     assign a character to the number.
    ? *      ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef
    ? *      ghijklmnopqrstuvwxyz0123456789+/
    ? *
    ? *  A is character for weight 0, B for 1,...,/ for 63.
    ? *  4. Last chunk of the file may not be 3 bytes; if so:
    ? *     For 1 byte chunk return two converted characters
    ? *     and '==', for 2 byte chunk return 3 converted characters
    ? *     and '='.
    ? *
    ? *  5. Each output record cannot exceed 76 char
    ? *
    ? *=====================================================================
    ? *   position IN data  :01234567.01234567.01234567.
    ? *   Value             :abcdefgh ijklmnop qrstuvwx
    ? *
    ? *   position OUT data :01234567.01234567.01234567.01234567.
    ? *   index value in B64:00abcdef 00ghijkl 00mnopqr 00stuvwx
    ? *
    ? *==================================================================
    ? *  "MimeCpyB64" subprocedure
    ? *  Purpose: Copy a binary file to the MIME file using BASE64 conversion
    ? *  Inputs:  Name of the file to be copied
    ? *  Outputs: none
BPR  P MimeGetB64      b
     D MimeGetB64      pi
     D FromFName                    512a   const
    ? *==================================================================
     D InputHand       s             10i 0
     d cvtbase64       ds
     d b64                            1    dim(64)
     D cvtTable                      64a   inz('ABCDEFGHIJKLMNOPQRSTUVWXYZabcde+
     D                                     fghijklmnopqrstuvwxyz0123456789+/')
     d In              ds             4
     d in1u                           3u00
     d in234                          3a
     d   in2a                         1    overlay(in234)
     d   in3a                         1    overlay(in234:*next)
     d   in4a                         1    overlay(in234:*next)
     d in4u                          10u00 overlay(in)
     d Out             ds             4
     d out1a                          1
     d out2a                          1
     d out3a                          1
     d out4a                          1
     d MimeOut         s              3u00
     D BytesIn         s             10i 0
     D BytesOut        s             10i 0

      /free
       cvtbase64 = cvttable;
       //?*  Open INPUT BINARY file
       //?*  for binary process
       InputHand = open(%trim(FromFName)
          : O_RDONLY) ;

       mimeout = 0;
B01    for ever;
          //?* Copy converting data
          BytesIn = read(InputHand
             : %addr(In234 )
             : 3 ) ;
B02       if bytesin = 0;
             leave;
E02       endif;
B02       if bytesin<= 2;
             in4a=x'00';
E02       endif;
B02       if bytesin<= 1;
             in3a= x'00';
E02       endif;
          in1u=0;
          in4u*=64;
          out1a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out2a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out3a= b64(in1u+1);
          in1u=0;
          in4u*=64;
          out4a= b64(in1u+1);

B02       if bytesin<= 2;
             out4a= '=';
E02       endif;
B02       if bytesin<= 1;
             out3a= '=';
E02       endif;

          BytesOut = write(MimeFileHandle
             : %addr(Out )
             : 4 ) ;

          mimeout+=Bytesout ;
B02       if mimeout>=76;
             bytesout=write(MimeFileHandle: crlf : 2);
             mimeout=0;
E02       endif;
B02       if bytesin < 3;
             leave;
E02       endif;
E01    endfor ;
       //?* Close the files
       rc = close(InputHand) ;
       return ;

B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR  P MimeGetB64      e
    ? *==================================================================
    ? *  "MimeCpyTxt" subprocedure
    ? *  Purpose: Append an ASCII text file to the MIME file
    ? *  Inputs:  Name of the file to be copied
BPR  P MimeGetText     b
     D MimeGetText     pi
     D FromFName                    512a   const
     D FileHandl1      s             10i 0
     d ReadData        s          65535
     D BytesIn         s             10i 0
     D BytesOut        s             10i 0
      /free

       //?* Open the input file
       FileHandl1 = open(%trim(FromFName) : O_RDONLY + O_TEXTDATA) ;

B01    for ever;
          //?* Copy the input file to the MIME file
          BytesIn = read(FileHandl1
             : %addr(readdata)
             : 65535 ) ;
B02       if BytesIn = 0 ;
             leave;
E02       endif;
          BytesOut = write(MimeFileHandle : %addr(ReadData) : BytesIn) ;
B02       if bytesin < 65535;
             leave;
E02       endif;
E01    endfor;


       //?* Close the input file
       Rc = close(FileHandl1) ;
       return;
B00    begsr *pssr;
       if NeedDump;
          dumpcallstack();
          dump ;
          needdump=false;
       endif;

E00    endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ?p*                b
    ? */free
    ? * begsr *pssr;
      *if NeedDump;
      *   dumpcallstack();
      *   dump ;
      *   needdump=false;
      *endif;
    ? * endsr;
    ? */end-free
    ?P*                 e
    ? *=---------------------------------------------------------------=*
