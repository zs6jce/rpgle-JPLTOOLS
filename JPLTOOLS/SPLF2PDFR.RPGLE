
      /define INFDS
      /define PDF
      /define LOWERCASE

     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
     fqspldta   if   f  382        disk    infsr(*pssr)
     f

      /define DATA_SECTION
      /include jpltools,JP4inc
    ? *include jpltools,JP4PDFSD
      /undefine DATA_SECTION

     D IfsName         s            512a   varying
    ?D*RC              S             10i 0


     d myProcSet       ds                  likeds(pdfprocset)
     d myResource      ds                  likeds(pdfResource)
     d myResource2     ds                  likeds(pdfResource)
     d myContent       ds                  likeds(pdfContent )
     d myStream        s                   like(pdfstream  )
     d myDraw          s                   like(pdfstream  )
     d myText          s                   like(pdfstream  )
     d HasWaterMark    s               n
     d WaterFont       ds                  likeds(PdfFont)
     d LogoImage       ds                  likeds(pdfImage   )
     d LogoIsReady     s               n
     d LogoIsDirty     s               n

     d splf2pdfr       pr
     d spoolname                     10
     d spoolnumber                    5p 0
     d jobname                       10
     d jobuser                       10
     d jobnbr                         6
     d outfile                      250
     d startpage                      5p 0
     d endpage                        5p 0
     d pagemode                      11
     d margins                       10
     d logo_p                       269
     d permission_p                  74
     d fromfile                      10
     d pagesize                      10
     d watermark_p                  200
     d splf2pdfr       pi
     d spoolname                     10
     d spoolnumber                    5p 0
     d jobname                       10
     d jobuser                       10
     d jobnbr                         6
     d outfile                      250
     d startpage                      5p 0
     d endpage                        5p 0
     d pagemode                      11
     d margins                       10
     d logo_p                       269
     d permission_p                  74
     d fromfile                      10
     d pagesize_p                    10
     d watermark_p                  200

     d marginsds       ds            10
     d count                          5i 0
     d LeftMargin                     3p 0
     d RightMargin                    3p 0
     d TopMargin                      3p 0
     d BottomMargin                   3p 0

     d pagesize        ds            10    qualified
     d count                          5i 0
     d height                         3p 0
     d width                          3p 0
     d lpi                            3p 0
     d cpi                            3p 0

     d logo            ds           269    qualified
     d count                          5i 0
     d file                         255
     d type                           5
     d x                              5i 0
     d y                              5i 0
     d zoom                           5p 4

     d permission      ds            74    qualified
     d count                          5i 0
     d set                            1
     d userpassword                  32
     d ownerpassword                 32
     d allowPrint                     1
     d allowassemble                  1
     d allowExtract                   1
     d allowFill                      1
     d allowAnnote                    1
     d allowCopy                      1
     d allowModify                    1
     d Allowed         s             10i 0

     d watermark       ds                  qualified
     d count                          5i 0
     d text                         100
     d font                          12
     d bold                           1
     d italic                         1
     d fontsize                       5i 0
     d x                              5i 0
     d y                              5i 0
     d degree                         5i 0
     d stroke                         7
     d fill                           7

     d x14             s             14
     d WaterColor      ds                  likeds(PdfColorHtml)


     d qusrspla        pr                  extpgm('QUSRSPLA')
     d   Receiver_variable...
     d                             3624
     d   Length_of_receiver_variable...
     d                                9b 0 const
     d   Format_name...
     d                                8    const
     d   Qualified_job_name...
     d                               26    const
     d   Internal_job_identifier...
     d                               16    const
     d   Internal_spooled_file_id...
     d                               16    const
     d   Spooled_file_name...
     d                               10    const
     d   Spooled_file_number...
     d                                9b 0 const
     d   Error_code...
     d                              256    options(*nopass)
     d   Job_system_name...
     d                                8    options(*nopass) const
     d   Spooled_file_creation_date...
     d                                7    options(*nopass) const
     d   Spooled_file_creation_time...
     d                                6    options(*nopass) const

     d Qus_SPLA0200_t  ds                  qualified
     d
     d Bytes_Return                   9b 0
     d Bytes_Avail                    9b 0
     d Format_Name                    8
     d Int_Job_ID                    16
     d Int_Splf_ID                   16
     d Job_Name                      10
     d Usr_Name                      10
     d Job_Number                     6
     d Splf_Name                     10
     d Splf_Number                    9b 0
     d Form_Type                     10
     d Usr_Data                      10
     d Status                        10
     d File_Avail                    10
     d Hold_File                     10
     d Save_File                     10
     d Total_Pages                    9b 0
     d Curr_Page                      9b 0
     d Start_Page                     9b 0
     d End_Page                       9b 0
     d Last_Page_Print...
     d                                9b 0
     d Rest_Page                      9b 0
     d Total_Copies                   9b 0
     d Copies_Rem                     9b 0
     d Lines_Per_Inch                 9b 0
     d Char_Per_Inch                  9b 0
     d Output_Priority...
     d                                2
     d Outq_Name                     10
     d Outq_Lib                      10
     d Date_File_Open                 7
     d Time_File_Open                 6
     d Dev_File_Name                 10
     d Dev_File_Lib                  10
     d Pgm_Name                      10
     d Pgm_Lib                       10
     d Count_Code                    15
     d Print_Text                    30
     d Record_Length                  9b 0
     d Max_Records                    9b 0
     d Dev_Type                      10
     d Ptr_Dev_Type                  10
     d Doc_Name                      12
     d Folder_Name                   64
     d S36_Proc_Name                  8
     d Print_Fidel                   10
     d Repl_Unprint                   1
     d Repl_Char                      1
     d Page_Length                    9b 0
     d Page_Width                     9b 0
     d Number_Separate...
     d                                9b 0
     d Overflow_Line_Nm...
     d                                9b 0
     d DBCS_Data                     10
     d DBCS_Ext_Chars                10
     d DBCS_SOSI                     10
     d DBCS_Char_Rotate...
     d                               10
     d DBCS_Cpi                       9b 0
     d Grph_Char_Set                 10
     d Code_Page                     10
     d Form_Def_Name                 10
     d Form_Def_Lib                  10
     d Source_Drawer                  9b 0
     d Print_Font                    10
     d S36_Spl_ID                     6
     d Page_Rotate                    9b 0
     d Justification                  9b 0
     d Duplex                        10
     d Fold                          10
     d Ctrl_Char                     10
     d Align_Forms                   10
     d Print_Quality                 10
     d Form_Feed                     10
     d Disk_Volume                   71
     d Disk_Label                    17
     d Exch_Type                     10
     d Char_Code                     10
     d Nmbr_Disk_Rcrds...
     d                                9b 0
     d Multiup                        9b 0
     d Frnt_Ovrly_Name...
     d                               10
     d Frnt_Ovrly_Lib_Name...
     d                               10
     d Frnt_Ovrly_Off_Dn...
     d                               15p05
     d Frnt_Ovrly_Off_Across...
     d                               15p05
     d Bck_Ovrly_Name                10
     d Bck_Ovrly_Lib_Name...
     d                               10
     d Bck_Ovrly_Off_Dn...
     d                               15p05
     d Bck_Ovrly_Off_Across...
     d                               15p05
     d Unit_Measure                  10
     d Page_Definition...
     d                               10
     d Page_Definition_Lib...
     d                               10
     d Line_Spacing                  10
     d Point_Size                    15p05
     d Max_Data_Record_Size...
     d                                9b 0
     d File_Buffer_Size...
     d                                9b 0
     d File_Level                     6
     d Coded_Font_Array...
     d                               16
     d Channel_Mode                  10
     d Channel_Code1                  9b 0
     d Channel_Code2                  9b 0
     d Channel_Code3                  9b 0
     d Channel_Code4                  9b 0
     d Channel_Code5                  9b 0
     d Channel_Code6                  9b 0
     d Channel_Code7                  9b 0
     d Channel_Code8                  9b 0
     d Channel_Code9                  9b 0
     d Channel_Code10                 9b 0
     d Channel_Code11                 9b 0
     d Channel_Code12                 9b 0
     d Graphics_Tokenl...
     d                                8
     d Record_Format                 10
     d Reserved1                      2
     d Height_Drawer1                15p05
     d Width_Drawer1                 15p05
     d Height_Drawer2                15p05
     d Width_Drawer2                 15p05
     d Number_Buffers                 9b 0
     d Max_Form_Width                 9b 0
     d Alternate_Form_Width...
     d                                9b 0
     d Alternate_Form_Length...
     d                                9b 0
     d Alternate_Lpi                  9b 0
     d Text_Flags                     2
     d Flg_File_Open                  1
     d Flg_Est_Pge_Cnt...
     d                                1
     d Flg_Pge_Boundary...
     d                                1
     d Flg_Trc                        1
     d Flg_Def_Char                   1
     d Flg_Cpi                        1
     d Flg_Transparency...
     d                                1
     d Flg_Dbl_Wide_char...
     d                                1
     d Flg_Char_Rotate...
     d                                1
     d Flg_Code_Page                  1
     d Flg_Fft_Emphasis...
     d                                1
     d Flg_Scs3812                    1
     d Flg_Sld                        1
     d Flg_Gea                        1
     d Flg_Cmd5219                    1
     d Flg_Cmd3812                    1
     d Flg_Fld_Outline...
     d                                1
     d Flg_Final_Frm_Txt...
     d                                1
     d Flg_Barcode                    1
     d Flg_Color                      1
     d Flg_Drawer_Chg                 1
     d Flg_Charid                     1
     d Flg_Lpi                        1
     d Flg_Font                       1
     d Flg_Highlight                  1
     d Flg_Pge_Rotate                 1
     d Flg_Subscript                  1
     d Flg_Superscript...
     d                                1
     d Flg_Dds                        1
     d Flg_Form_Feed                  1
     d Flg_Scs_Data                   1
     d Flg_User_Gen_Data...
     d                                1
     d Flg_Graphics                   1
     d Flg_Unrecogn_Data...
     d                                1
     d Flg_ASCII_Trans...
     d                                1
     d Flg_Ipds_Trans                 1
     d Flg_Office_Vis                 1
     d Flg_No_Lpi                     1
     d Flg_Cpa3353                    1
     d Flg_Set_Excp                   1
     d Flg_Carriage_Control...
     d                                1
     d Flg_Pge_Pos                    1
     d Flg_Invalid_Char...
     d                                1
     d Flg_Lengths                    1
     d Flg_Pres5a                     1
     d Flg_Resrvd                     1
     d Nbr_Font_Entries...
     d                                9b 0
     d Nbr_Lib_Entries...
     d                                9b 0
     d Font_Entries                1153
     d Lib_Entries                  631
     d Native_AFPDS                   1
     d JOBCCSID_For_CHRID...
     d                                1
     d S36_Continue_Yes...
     d                                1
     d Decimal_Format_Used...
     d                               10
     d Date_File_Last_Accessed...
     d                                7
     d Page_Groups                    1
     d Group_Level_Index...
     d                                1
     d Page_Level_Index...
     d                                1
     d IPDS_Pass_Through...
     d                                1
     dOff_Usr_Rsc_Libl...
     d                                9b 0
     dNbr_Usr_Rsc_Libl...
     d                                9b 0
     dLen_Usr_Rsc_Libl_Entry...
     d                                9b 0
     d Reserved8                      2
     d Corner_Stapling...
     d                                1
     d Edge_Stitch_Edge_Ref...
     d                                1
     d Offset_From_Edge_Ref...
     d                               15p05
     dEdge_Stitch_Nbr_Staples...
     d                                9b 0
     dOffset_Staple_Positions...
     d                                9b 0
     dNbr_of_Staple_Positions...
     d                                9b 0
     dLen_Staple_Position_Entry...
     d                                9b 0
     d Font_Resolution...
     d                               10
     d Rcd_Fmt_Name_Present...
     d                                1
     d Saddle_Stitch_Edge_Ref...
     d                                1
     dSaddle_Stitch_Nbr_Staples...
     d                                9b 0
     dOff_Saddle_Staple_Off...
     d                                9b 0
     dNbr_of_Saddle_Stpl_Off...
     d                                9b 0
     dLen_Saddle_Staple_Off_Entry...
     d                                9b 0
     d Data_Stream_Size...
     d                               15p05
     dOff_Splf_Libl                   9b 0
     dNbr_of_Libraries...
     d                                9b 0
     dLen_Splf_Libl_Entry...
     d                                9b 0
     dOff_IPP_Attrs                   9b 0
     d Reserved2                    180
     d Frnt_Margin_Off_Dn...
     d                               15p05
     d Frnt_Margin_Off_Acr...
     d                               15p05
     d Back_Margin_Off_Dn...
     d                               15p05
     d Back_Margin_Off_Acr...
     d                               15p05
     d Length_Of_Page                15p05
     d Width_Of_Page                 15p05
     d Measure_Method                10
     d Afp_Resource                   1
     d Font_Char_Set                 10
     d Font_Char_Set_Lib...
     d                               10
     d Code_Page_Name                10
     d Code_Page_Lib                 10
     d Coded_Font_Name...
     d                               10
     d Coded_Font_Lib                10
     d DBCS_Coded_Font_Name...
     d                               10
     d DBCS_Coded_Font_Lib...
     d                               10
     d User_Defined_File...
     d                               10
     d Reduce_Output                 10
     d Constant_Back_Overlay...
     d                                1
     d Output_Bin                     9b 0
     d CCSID                          9b 0
     d User_Text                    100
     d Original_System...
     d                                8
     d Original_Net_ID...
     d                                8
     d Splf_Creator                  10
     d Reserved5                      2
     d Usr_Def_Options_Offset...
     d                                9b 0
     d Usr_Def_Options_Number...
     d                                9b 0
     d Usr_Def_Options_Entry_Length...
     d                                9b 0
     d Usr_Defined_Data...
     d                               55
     d Usr_Def_Object_Name...
     d                               10
     d Usr_Def_Object_Lib...
     d                               10
     d Usr_Def_Object_Type...
     d                               10
     d Reserved6                      3
     d Character_Set_Point_Size...
     d                               15p05
     d Coded_Font_Point_Size...
     d                               15p05
     d DBCS_Coded_Font_Point_Size...
     d                               15p05
     d Spooled_File_ASP...
     d                                9b 0
     d Spooled_File_Size...
     d                                9b 0
     d Splf_Size_Multiplier...
     d                                9b 0
     d IPP_JobId                      9b 0
     d Splf_Crt_Security_Method...
     d                                1
     d Splf_Authentication_Method...
     d                                1
     d Wtr_Begin_Process_Date...
     d                                7
     d Wtr_Begin_Process_Time...
     d                                6
     d Wtr_Complete_Proc_Date...
     d                                7
     d Wtr_Complete_Proc_Time...
     d                                6
     d  Job_System_Name...
     d                                8


     d splinfo         ds                  likeds(Qus_SPLA0200_t)
     d len             s              9b 0
     d fnum            s              9b 0
     d format          s              8
     d ijobid          ds                  likeds(jobid)
     d isplfid         ds                  likeds(splfid)
     d errcode         ds                  likeds(errstructure)
     d JOBID           ds                  qualified
     d   JOBIPL                       9b 0
     d   JOBOFF                       9b 0
     d   JOBTOD                       8
     d SPLFID          ds                  qualified
     d   SPLFIPL                      9b 0
     d   SPLFOFF                      9b 0
     d   SPLFTOD                      8
     d ERRSTRUCTURE    ds                  qualified
     d   BYTESPRO                     9b 0
     d   BYTESAVL                     9b 0
     d   EXCPID                       7
     d   RESRVD                       1
     d   EXCPDATA                   240

     d PageCount       s              9b 0
     d LineCount       s              9b 0
     d charCount       s              9b 0
     d xPos            s              9b 0
     d yPos            s              9b 0
     d PdfData         s            378    varying
     d xMax            s              9b 0
     d yMax            s              9b 0

     d PdfOut          s               n
     d PdfPageIsOpen   s               n   inz(*off)
     D RC              S             10i 0

       //?scan the DATA variable for PDF enhancements

     d Enhancement     s            378    varying
     d Epos            s             10i 0
     d PdfFormat       pr
     d   enhancement                378    value varying
     d*PdfColor        ds                  qualified based(template)
     d*red                            5p 4
     d*green                          5p 4
     d*blue                           5p 4
     d checkcolor      pr                  likeds(PdfColorHtml)
     d ColorName                     50    value varying


     d PdfWaterMark    pr                  like(pdfstream  )

     D*RtvDbgAttr      PR                  ExtProc('QteRetrieveDebugAttribute')
     D* DbgAttr                      10a   Const
     D* RtnAttr                      10a
     d*  Error_Code                 256

     d*debugmode       ds                  qualified
     D*DbgAttr                       10a
     D*RtnAttr                       10a
     d*debugging       s               n





    ?d*splfdta         ds
    ?d* skip                          3                                         '001' or '   '
    ?d* spaceline                     1                                         '0' to '9' or ' '
    ?d* data                        378
     d  skipN          s              3s00
     d  spacelinen     s              1s00
     iqspldta   aa
     i                                  1  382  splfdta
     i                                  1    3  skip
     i                                  4    4  spaceline
     i                                  5  382  data
    ?i*                                 1    300skipN
    ?i*                                 4    400spacelinen
     i


      /free
       // debug mode ?
       clear errcode;
       errcode.BYTESPRO =%size(errcode);
       debugmode.dbgattr='*DEBUGJOB';
       debugging=true;
       RtvDbgAttr ( debugmode.DbgAttr :
          debugmode.RtnAttr :
          errcode );
B01    if (errcode.bytesavl>0);
B02       if errcode.EXCPID  ='CPF9541';
             debugging=false;
X02       else;
             message(errcode.EXCPID:errcode.EXCPDATA:'':'QCPFMSG':'*DIAG');
E02       endif;
E01    endif;
B01    if debugging ;
          message ('':'Under DEBUG mode');
E01    endif;

       marginsds = margins;
       pagesize = pagesize_p;
       logo = logo_p;
       logoisready=false;
       LogoIsDirty=false;
       permission = permission_p;
       watermark = watermark_p;
B01    if logo.file <> *blank;
          //?check logo exists
          message ('':'Check existence of '+ %trim(logo.file));
          rc = access(%trim(logo.file): F_OK);
B02       if (rc <> 0);
             LogoIsDirty = true;
             message(errnomsg(errno):'':'':'QCPFMSG':'*DIAG');
E02       endif;
          if not LogoIsDirty;
             select;
                when logo.type='JPEG';
                   logoImage=pdfpreLoadJpeg(%trim(logo.file) );
                   logoisready=true;
                when logo.type='BMP24';
                   logoImage=pdfpreLoadBMP24(%trim(logo.file) );
                   logoisready=true;
             endsl;
          endif;
E01    endif;
B01    if permission.set = true;
          allowed = Pdf_Allow_Reset;
B02       if permission.allowPrint = true;
             allowed+=Pdf_Allow_print + pdf_allow_hqprint;
E02       endif;
B02       if permission.allowassemble = true;
             allowed+=Pdf_Allow_assemble ;
E02       endif;
B02       if permission.allowExtract = true;
             allowed+=Pdf_Allow_extract ;
E02       endif;
B02       if permission.allowFill = true;
             allowed+=Pdf_Allow_fill ;
E02       endif;
B02       if permission.allowAnnote = true;
             allowed+=Pdf_Allow_annote ;
E02       endif;
B02       if permission.allowCopy = true;
             allowed+=Pdf_Allow_copy ;
E02       endif;
B02       if permission.allowModify = true;
             allowed+=Pdf_Allow_modify ;
E02       endif;
X01    else;
          allowed=0;//?= not crypted
E01    endif;


       format= 'SPLA0200';
       len =%size(splinfo);
       fnum = spoolnumber;
       clear splinfo ;
       clear errcode;
       errcode.BYTESPRO =%size(errcode);
B01    if fromfile =  '*YES';
          splinfo.PAGE_WIDTH = pagesize.width;
          splinfo.PAGE_length = pagesize.height;
          splinfo.CHAR_PER_INCH = pagesize.cpi;
          splinfo.LINES_PER_INCH= pagesize.lpi;
X01    else;
          QUSRSPLA( splinfo : len: format: jobname+jobuser+jobnbr
             :ijobid : isplfid : spoolname: fnum:errcode);
B02       if (errcode.bytesavl>0);
             message(errcode.EXCPID:errcode.EXCPDATA:'':'QCPFMSG':'*ESCAPE');
E02       endif;
B02       if splinfo.afp_resource='Y';
             message('CPF9898':'AFP data not supported'
             + '. Abnormal termination.'
             :'*LIBL':'QCPFMSG':'*ESCAPE':'*PGMBDY':1);
E02       endif;
          //?cpi & lpi are in tenths
          splinfo.CHAR_PER_INCH /=10 ;
          splinfo.LINES_PER_INCH/=10 ;
E01    endif;
       //?
       //?destroy if exist then create a file
       //?
       ifsname = %trim(outfile);
       PdfNewFile(Ifsname
          : spoolname
          : allowed
          : permission.userpassword
          : permission.ownerpassword
          );






       //?prepare foundation objects
       PdfNewRoot();
       PdfNewOutlines();
       PdfNewPages();
       //?calculation of watermark font
B01    if watermark.text =  '*NONE';
          haswatermark=false;
X01    else;
          haswatermark=true ;
          x14 =watermark.font + watermark.italic + watermark.bold;
B02       select;
X02          when x14           ='COURIER     00';
                waterfont= PdfLoadFont1('F2' :pdf_Courier);
X02          when x14           ='COURIER     01';
                waterfont= PdfLoadFont1('F2' :pdf_Courier:pdf_bold);
X02          when x14           ='COURIER     10';
                waterfont= PdfLoadFont1('F2' :pdf_Courier:pdf_italic);
X02          when x14           ='COURIER     11';
                waterfont= PdfLoadFont1('F2' :pdf_Courier:pdf_bold:pdf_italic);
X02          when x14           ='HELVETICA   00';
                waterfont= PdfLoadFont1('F2' :pdf_Helvet );
X02          when x14           ='HELVETICA   01';
                waterfont= PdfLoadFont1('F2' :pdf_Helvet :pdf_bold);
X02          when x14           ='HELVETICA   10';
                waterfont= PdfLoadFont1('F2' :pdf_Helvet :pdf_italic);
X02          when x14           ='HELVETICA   11';
                waterfont= PdfLoadFont1('F2' :pdf_Helvet :pdf_bold:pdf_italic);
X02          when x14           ='TIMES       00';
                waterfont= PdfLoadFont1('F2' :pdf_Times  );
X02          when x14           ='TIMES       01';
                waterfont= PdfLoadFont1('F2' :pdf_Times  :pdf_bold);
X02          when x14           ='TIMES       10';
                waterfont= PdfLoadFont1('F2' :pdf_Times  :pdf_italic);
X02          when x14           ='TIMES       11';
                waterfont= PdfLoadFont1('F2' :pdf_Times  :pdf_bold:pdf_italic);
X02          when watermark.font='SYMBOL      ';
                waterfont= PdfLoadFont1('F2' :pdf_Symbol );
X02          when watermark.font='ZAPFDINGBATS';
                waterfont= PdfLoadFont1('F2' :pdf_Zapf   );
X02          other;
                waterfont= PdfLoadFont1('F2' :pdf_Courier);
E02       endsl;
          //?watermark will be converted to pdf after PdfPage is open
E01    endif;
       //?prepare the font list to be used in the pdf
       //?load each font
       // PdfCourier  =PdfLoadFont1('F1' :pdf_Courier);
       PdfLoadFont3('F1' :'*LIBL/PLUGFONT':'/home/lamontre/trado.ttf'
       :pdfcourier);
       //?prepare a procset list
       myProcset=PdfLoadProcset(pdf_procpdf : pdf_procimagec);
       myResource =PdfNewResource(myProcset);
B01    if logoIsReady;
B02       select;
X02          when logo.type='JPEG';
                pdfmemLoadJpeg(logoimage);
X02          when logo.type='BMP24';
                pdfmemLoadBMP24(logoimage) ;
E02       endsl;
          pdfresourceAddImage(myresource :LogoImage);
E01    endif;
       //?reference the fonts to be used in the pdf
       PdfResourceAddFont( myResource : PdfCourier );
B01    if haswatermark;
          PdfResourceAddFont( myResource : WaterFont );
E01    endif;
       PdfCloseResource ( myResource);

       pdfout=*off;
       pagecount=0;
       linecount=999;
B01    if endpage = -1;
E01    endpage = *hival;
E00    endif;
       //?            132             100
       xMax = splinfo.PAGE_WIDTH /%float(splinfo.CHAR_PER_INCH)*72.0;//?72 ? 75 ? 120 ? 720 ? 72 !
       //?            66              60
       yMax = splinfo.PAGE_length /%float(splinfo.LINES_PER_INCH)*72.0;

       //?page 0 : report errors
       //?report error on unknown logo file
B01    if LogoIsDirty;
          xPos = 0;
          yPos = 0;
B02       if RightMargin = -1;
             RightMargin = LeftMargin ;
E02       endif;
B02       if TopMargin = -1 ;
             TopMargin = LeftMargin ;
E02       endif;
B02       if BottomMargin = -1 ;
             BottomMargin = LeftMargin ;
E02       endif;
          PdfNewPage(pdf_Custom    :'Page '+%char(pageCount):xmax:ymax
             : LeftMargin
             : RightMargin
             : TopMargin
             : BottomMargin );
          PdfPageIsOpen=true;
          PdfPageResource(myResource);
          PdfNewOutline('Page '+%char(pageCount));
          xPos = 0;
          yPos = pdfTextRow();
          myDraw =PdfStrmSaveGraphicState();
          MyText =PdfTextOpen();
          MyText+=PdfTextFont(PdfCourier
             : %int(120/(splinfo.CHAR_PER_INCH )));
          MyText+=PdfStrmStrokingColorGray(0);
          MyText+=PdfStrmFillingColorGray(0);

          //?add log text
          myText+=PdfTextGoTo(xPos:yPos);
          MyText+=PdfTextadd(
             'Logo error : no such path or directory "'
             + %trim(logo.file) + '"'
             );
E03       //?close the log page
          MyText+=PdfTextClose();
          MyDraw+=PdfStrmRestoreGraphicState();
          MyContent = PdfLoadContent(MyDraw+myText);
          PdfPageContent (myContent );
          PdfClosePage( );
          PdfPageIsOpen=false;
          linecount = 999;
E01    endif;
B01    for ever;
          read qspldta;
B02       if %eof;
             leave;
E02       endif;
B02       if %check('0123456789':skip)=0 ;
             skipn=%int(skip) ;
X02       else;
             skipn=0;
E02       endif;
B02       if %check('0123456789':spaceline )=0;
             spacelinen=%int(spaceline);
X02       else ;
             spacelinen=0;
E02       endif ;

          //?capture enhancements : line starts with 'pdf' or 'htm'
          skip = lcase(skip);
B02       if skip = 'htm';
             iter;
E02       endif;
B02       if skip = 'pdf'   ;
B03          if pdfout = *off;
                iter;
E03          endif;
             //?inspection of the string : lowercase
             enhancement=lcase(data);
             //?isolate the first word
             Epos=%scan(' ':enhancement);
B03          if %subst(enhancement:1:epos) = 'format';
                pdfFormat(enhancement);
E03          endif;
             iter;
E02       endif;
          //?compute skip-to value
B02       if skip <> *blank and spaceline <> '>';
             //?not blank means goto this line
B03          if skipn < linecount;
                //?new page requested
B04             if pdfpageisopen;
                   //?first, close current page
                   MyText+=PdfTextClose();
                   MyDraw+=PdfStrmRestoreGraphicState();
                   MyContent = PdfLoadContent(MyDraw+myText);
                   PdfPageContent (myContent );
                   PdfClosePage( );
                   PdfPageIsOpen=false;
E04             endif;
                //?add a page to the pdf
                pagecount+=1;
                //?compute segment request
B04             if startpage <= pagecount and pagecount <= endpage;
                   pdfout = *on;
X04             else;
                   pdfout = *off;
E04             endif;
                xPos = 0;
                yPos = 0;
B04             if pdfout;
B05                if RightMargin = -1;
                      RightMargin = LeftMargin ;
E05                endif;
B05                if TopMargin = -1 ;
                      TopMargin = LeftMargin ;
E05                endif;
B05                if BottomMargin = -1 ;
                      BottomMargin = LeftMargin ;
E05                endif;
                   PdfNewPage(pdf_Custom    :'Page '+%char(pageCount):xmax:ymax
                      : LeftMargin
                      : RightMargin
                      : TopMargin
                      : BottomMargin );
                   PdfPageIsOpen=true;
                   PdfPageResource(myResource);
                   PdfNewOutline('Page '+%char(pageCount));
                   xPos = 0;
                   yPos = pdfTextRow();
                   linecount = 0;
                   myDraw =PdfStrmSaveGraphicState();
B05                if LogoIsReady;
                      myDraw+=PdfDrawImage(LogoImage:logo.x:logo.y:logo.zoom);
E05                endif;
B05                if HasWatermark;
                      myDraw+=PdfWaterMark();
E05                endif;
E04             endif;
                //?count line number
B04             if pdfout;
                   MyText =PdfTextOpen();
                   MyText+=PdfTextFont(PdfCourier
                      : %int(120/(splinfo.CHAR_PER_INCH )));
                   MyText+=PdfStrmStrokingColorGray(0);
                   MyText+=PdfStrmFillingColorGray(0);
E04             endif;
E03          endif;
             yPos-= PdfFontSize*(skipn-linecount);
             linecount =skipn;
E02       endif;
          //?compute spacing
B02       if spaceline <> *blank and spaceline <> '0' and spaceline <> '>';
             ypos -= PdfFontSize * spacelinen ;
             linecount+=spacelineN;
E02       endif;
          //?add spool text
B02       if pdfout;
B03          if spaceline =  '>';
                pdfData = %subst(Data:1:skipn) ;
                MyText+=PdfTextadd( pdfdata );
                charcount+=skipn;
X03          else;
                pdfData = %trimr(Data) ;
                myText+=PdfTextGoTo(xPos:yPos);
B04             if %len(pdfdata) > 0;
                   MyText+=PdfTextadd( pdfdata );
E04             endif;
                charcount=%len(pdfdata);
E03          endif;
E02       endif;
E01    endfor;
B01    if pdfpageisopen;
          MyText+=PdfTextClose();
          MyContent = PdfLoadContent(MyDraw+myText);
          PdfPageContent (myContent );
          PdfClosePage( );
E01    endif;
       //?close the pdf
       PdfCloseOutlines();
       PdfClosePages();
       PdfCloseRoot(pagemode);
       PdfCloseFile();
       *inlr = *on;
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
    ? *include jpltools,JP4PDFSC
    ? *=---------------------------------------------------------------=*
BPR  p pdfformat       b
     d pdfformat       pi
     d   enhancement                378    value varying
     d pos             s             10i 0
     d parameter       s             50    varying
     d name            s             20    varying
     d value           s             30    varying
     d MyColor         ds                  likeds(PdfColorHtml)
     d GotAColor       s               n   inz(*off)
     d MyTextSize      s             10u00 inz(10)
    ? * debug fields
     d d1              s             10i 0
     d d2              s             10i 0
     d d3              s             10i 0
     d d4              s             10i 0
     d d5              s             10i 0
     d d6              s             10i 0
     d d7              s             10i 0
     d d8              s             10i 0
     d d9              s             10i 0
    ? /free
       //?mydraw & mytext variables are global
       //?enhancement supported :
       //?format backcolor(mistyrose) textsize(11)
       //?remove 'format'
       enhancement = %triml(%subst(enhancement:8));
       //?search for ') ' marker of end of parameter
B01    for ever;
          pos = %scan(')':enhancement );
B02       if pos = 0;
             leave;
E02       endif;
          parameter=%subst(enhancement:1:pos-1);
          enhancement = %triml(%subst(enhancement:pos+1));
          //?search for '(' separator of name and value
          pos = %scan('(':parameter   );
B02       if pos = 0;
             leave;
E02       endif;
          name = %subst(parameter:1:pos-1);
          value = %subst(parameter:pos+1);
B02       select;
X02          when name = 'backcolor';
                MyColor=CheckColor(value);
                gotacolor=true;
X02          when name='textsize';
B03             monitor;
                   MyTextSize=%int(value);
                   on-error;
                   MyTextSize=1;
E03             endmon;
X02          other;
                //?ignored
E02       endsl;
E01    endfor;

B01    if not gotAColor;
          mycolor=CheckColor('gray');
E01    endif;

       //?set the back color : draw back to the text a rectangle filled with the color
       mydraw+=pdfStrmFillingcolorrgb(
          mycolor.red
          :mycolor.green
          :mycolor.blue);
       d1 = pdftextcol() ;
       d2 = pdfFontSize ;
       d3 = charcount ;
       d4 = pdftextrow() ;
       d5 = MyTextSize ;

       //?cpi * fontsize = 120      splinfo.CHAR_PER_INCH
       //?charcount = nb car deja imprimes
       //?position curseur, en pouce = charcount / cpi
       //?apres convertion en pouce, convertir en DPI par * 72
       //?la mise en place de format fontface() fontsize() va mettre tout ce calcul a genoux


       myDraw+=PdfDrawAddRectangle(//?x y w h
          pdftextcol() + 72 / splinfo.CHAR_PER_INCH * charcount
          : pdftextrow() -2
          : MyTextSize * 72 / splinfo.CHAR_PER_INCH
          : pdffontsize()
          );
       mydraw+=PdfDrawClosePath(pdf_fill);


B01    begsr *pssr;
          dump;
E01    endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR  p checkcolor      b
     d checkcolor      pi                  likeds(PdfColorHtml)
     d ColorName                     50    value varying
     d Result          ds                  likeds(PdfColorHtml)
     d hexa3           ds             7
     d diese                          1
     d rgb                            6
     d red                            2    overlay(rgb)
     d green                          2    overlay(rgb:*next)
     d blue                           2    overlay(rgb:*next)
     d bin3            ds             3
     d r                              3u 0
     d g                              3u 0
     d b                              3u 0
     D Hex2Chr         Pr                  ExtProc('cvtch')
     D  Tgt                       32767A   Options(*VarSize)
     D  Src                       65534A   Options(*VarSize)
     D  SrcLen                       10i 0 Value
    ? /free
       hexa3 = ''       ;//?not understouud
B01    if %subst(colorname:1:1) = '#'  ;
          hexa3 = colorname;
X01    else;
          //?convert named color to hexa color
B02       select ;
X02          when colorname = 'aliceblue';
                hexa3='#f0f8ff';
X02          when colorname = 'antiquewhite';
                hexa3='#faebd7';
X02          when colorname = 'aqua';
                hexa3='#00ffff';
X02          when colorname = 'aquamarine';
                hexa3='#7fffd4';
X02          when colorname = 'azure';
                hexa3='#f0ffff';
X02          when colorname = 'beige';
                hexa3='#f5f5dc';
X02          when colorname = 'bisque';
                hexa3='#ffe4c4';
X02          when colorname = 'black';
                hexa3='#000000';
X02          when colorname = 'blanchedalmond';
                hexa3='#ffebcd';
X02          when colorname = 'blue';
                hexa3='#0000ff';
X02          when colorname = 'blueviolet';
                hexa3='#8a2be2';
X02          when colorname = 'brown';
                hexa3='#a52a2a';
X02          when colorname = 'burlywood';
                hexa3='#deb887';
X02          when colorname = 'cadetblue';
                hexa3='#5f9ea0';
X02          when colorname = 'chartreuse';
                hexa3='#7fff00';
X02          when colorname = 'chocolate';
                hexa3='#d2691e';
X02          when colorname = 'coral';
                hexa3='#ff7f50';
X02          when colorname = 'cornflower';
                hexa3='#6495ed';
X02          when colorname = 'cornsilk';
                hexa3='#fff8dc';
X02          when colorname = 'crimson';
                hexa3='#dc143c';
X02          when colorname = 'cyan';
                hexa3='#00ffff';
X02          when colorname = 'darkblue';
                hexa3='#00008b';
X02          when colorname = 'darkcyan';
                hexa3='#008b8b';
X02          when colorname = 'darkgoldenrod';
                hexa3='#b8860b';
X02          when colorname = 'darkgray'
X02            or colorname = 'darkgrey';
                hexa3='#a9a9a9';
X02          when colorname = 'darkgreen';
                hexa3='#006400';
X02          when colorname = 'darkkhaki';
                hexa3='#bdb76b';
X02          when colorname = 'darkmagenta';
                hexa3='#8b008b';
X02          when colorname = 'darkolivegreen';
                hexa3='#556b2f';
X02          when colorname = 'darkorange';
                hexa3='#ff8c00';
X02          when colorname = 'darkorchid';
                hexa3='#9932cc';
X02          when colorname = 'darkred';
                hexa3='#8b0000';
X02          when colorname = 'darksalmon';
                hexa3='#e9967a';
X02          when colorname = 'darkseagreen';
                hexa3='#8fbc8b';
X02          when colorname = 'darkslateblue';
                hexa3='#483d8b';
X02          when colorname = 'darkslategray'
X02            or colorname = 'darkslategrey';
                hexa3='#2f4f4f';
X02          when colorname = 'darkturquoise';
                hexa3='#00ced1';
X02          when colorname = 'darkviolet';
                hexa3='#9400d3';
X02          when colorname = 'deeppink';
                hexa3='#ff1493';
X02          when colorname = 'deepskyblue';
                hexa3='#00bfff';
X02          when colorname = 'dimgray'
X02            or colorname = 'dimgrey';
                hexa3='#696969';
X02          when colorname = 'dodgerblue';
                hexa3='#1e90ff';
X02          when colorname = 'firebrick';
                hexa3='#b22222';
X02          when colorname = 'floralwhite';
                hexa3='#fffaf0';
X02          when colorname = 'forestgreen';
                hexa3='#228b22';
X02          when colorname = 'fuchia';
                hexa3='#ff00ff';
X02          when colorname = 'gainsboro';
                hexa3='#dcdcdc';
X02          when colorname = 'ghostwhite';
                hexa3='#f8f8ff';
X02          when colorname = 'gold';
                hexa3='#ffd700';
X02          when colorname = 'goldenrod';
                hexa3='#daa520';
X02          when colorname = 'gray'
X02            or colorname = 'grey';
                hexa3='#808080';
X02          when colorname = 'green';
                hexa3='#008000';
X02          when colorname = 'greenyellow';
                hexa3='#adff2f';
X02          when colorname = 'honeydew';
                hexa3='#f0fff0';
X02          when colorname = 'hotpink';
                hexa3='#ff69b4';
X02          when colorname = 'indianred';
                hexa3='#cd5c5c';
X02          when colorname = 'indigo';
                hexa3='#4b0082';
X02          when colorname = 'ivory';
                hexa3='#fffff0';
X02          when colorname = 'khaki';
                hexa3='#f0e68c';
X02          when colorname = 'lavender';
                hexa3='#e6e6fa';
X02          when colorname = 'lavenderblush';
                hexa3='#fff0f5';
X02          when colorname = 'lawngreen';
                hexa3='#7cfc00';
X02          when colorname = 'lemonchiffon';
                hexa3='#fffacd';
X02          when colorname = 'lightblue';
                hexa3='#add8e6';
X02          when colorname = 'lightcoral';
                hexa3='#f08080';
X02          when colorname = 'lightcyan';
                hexa3='#e0ffff';
X02          when colorname = 'lightgoldenrodyellow';
                hexa3='#fafad2';
X02          when colorname = 'lightgreen';
                hexa3='#90ee90';
X02          when colorname = 'lightgray'
X02          or   colorname = 'lightgrey';
                hexa3='#d3d3d3';
X02          when colorname = 'lightpink';
                hexa3='#ffb6c1';
X02          when colorname = 'lightsalmon';
                hexa3='#ffa07a';
X02          when colorname = 'lightseagreen';
                hexa3='#20b2aa';
X02          when colorname = 'lightskyblue';
                hexa3='#87cefa';
X02          when colorname = 'lightslategray'
X02            or colorname = 'lightslategrey';
                hexa3='#778899';
X02          when colorname = 'lightsteelblue';
                hexa3='#b0c4de';
X02          when colorname = 'lightyellow';
                hexa3='#ffffe0';
X02          when colorname = 'lime';
                hexa3='#00ff00';
X02          when colorname = 'limegreen';
                hexa3='#32cd32';
X02          when colorname = 'linen';
                hexa3='#faf0e6';
X02          when colorname = 'magenta';
                hexa3='#ff00ff';
X02          when colorname = 'maroon';
                hexa3='#800000';
X02          when colorname = 'mediumaquamarine';
                hexa3='#66cdaa';
X02          when colorname = 'mediumblue';
                hexa3='#0000cd';
X02          when colorname = 'mediumorchid';
                hexa3='#ba55d3';
X02          when colorname = 'mediumpurple';
                hexa3='#9370db';
X02          when colorname = 'mediumseagreen';
                hexa3='#3cb371';
X02          when colorname = 'mediumslateblue';
                hexa3='#7b68ee';
X02          when colorname = 'mediumspringgreen';
                hexa3='#00fa9a';
X02          when colorname = 'mediumturquoise';
                hexa3='#48d1cc';
X02          when colorname = 'mediumvioletred';
                hexa3='#c71585';
X02          when colorname = 'midnightblue';
                hexa3='#191970';
X02          when colorname = 'mintcream';
                hexa3='#f5fffa';
X02          when colorname = 'mistyrose';
                hexa3='#ffe4e1';
X02          when colorname = 'moccasin';
                hexa3='#ffe4b5';
X02          when colorname = 'navajowhite';
                hexa3='#ffdead';
X02          when colorname = 'navy';
                hexa3='#000080';
X02          when colorname = 'oldlace';
                hexa3='#fdf5e6';
X02          when colorname = 'olive';
                hexa3='#808000';
X02          when colorname = 'olivedrab';
                hexa3='#6b8e23';
X02          when colorname = 'orange';
                hexa3='#ffa500';
X02          when colorname = 'orangered';
                hexa3='#ff4500';
X02          when colorname = 'orchid';
                hexa3='#da70d6';
X02          when colorname = 'palegoldenrod';
                hexa3='#eee8aa';
X02          when colorname = 'palegreen';
                hexa3='#98fb98';
X02          when colorname = 'paleturquoise';
                hexa3='#afeeee';
X02          when colorname = 'palevioletred';
                hexa3='#db7093';
X02          when colorname = 'papayawhip';
                hexa3='#ffefd5';
X02          when colorname = 'peachpuff';
                hexa3='#ffdab9';
X02          when colorname = 'peru';
                hexa3='#cd853f';
X02          when colorname = 'pink';
                hexa3='#ffc0cb';
X02          when colorname = 'plum';
                hexa3='#dda0dd';
X02          when colorname = 'powderblue';
                hexa3='#b0e0e6';
X02          when colorname = 'purple';
                hexa3='#800080';
X02          when colorname = 'red';
                hexa3='#ff0000';
X02          when colorname = 'rosybrown';
                hexa3='#bc8f8f';
X02          when colorname = 'royalblue';
                hexa3='#4169e1';
X02          when colorname = 'saddlebrown';
                hexa3='#8b4513';
X02          when colorname = 'salmon';
                hexa3='#fa8072';
X02          when colorname = 'sandybrown';
                hexa3='#f4a460';
X02          when colorname = 'seagreen';
                hexa3='#2e8b57';
X02          when colorname = 'seashell';
                hexa3='#fff5ee';
X02          when colorname = 'sienna';
                hexa3='#a0522d';
X02          when colorname = 'silver';
                hexa3='#c0c0c0';
X02          when colorname = 'skyblue';
                hexa3='#87ceeb';
X02          when colorname = 'slateblue';
                hexa3='#6a5acd';
X02          when colorname = 'slategray'
X02            or colorname = 'slategrey';
                hexa3='#708090';
X02          when colorname = 'snow';
                hexa3='#fffafa';
X02          when colorname = 'springgreen';
                hexa3='#00ff7f';
X02          when colorname = 'steelblue';
                hexa3='#4682b4';
X02          when colorname = 'tan';
                hexa3='#d2b48c';
X02          when colorname = 'teal';
                hexa3='#008080';
X02          when colorname = 'thistle';
                hexa3='#d8bfd8';
X02          when colorname = 'tomato';
                hexa3='#ff6347';
X02          when colorname = 'turquoise';
                hexa3='#40e0d0';
X02          when colorname = 'violet';
                hexa3='#ee82ee';
X02          when colorname = 'wheat';
                hexa3='#f5deb3';
X02          when colorname = 'white';
                hexa3='#ffffff';
X02          when colorname = 'whitesmoke';
                hexa3='#f5f5f5';
X02          when colorname = 'yellow';
                hexa3='#ffff00';
X02          when colorname = 'yellowgreen';
                hexa3='#9acd32';
E02       endsl;
E01    endif;
       //?no color ?
B01    if hexa3 = '';
          message('':'unknown color : '+colorname+'. Set to red');
          hexa3='#ff0000';
E01    endif;
       //?convert hexa string to hexa bin
       rgb=ucase(rgb);
       hex2chr(bin3:rgb:6);
       result.red = r / 255;
       result.green = g / 255;
       result.blue = b/ 255;

       return result;


B01    begsr *pssr;
          dump;
E01    endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
BPR  p PdfWaterMark    b
     d PdfWaterMark    pi                  like(pdfstream  )
    ?d*watermark : read it from global variable
     d MyWaterMark     s                   like(pdfstream  )
    ? /free
       mywatermark=
          PdfStrmSaveGraphicState()
          + PdfStrmTranslate(watermark.x:watermark.y)
          + PdfStrmRotate(watermark.degree)
          + PdfTextOpen()
          + PdfTextFont(WaterFont:watermark.fontsize)
          + PdfTextRendering(Pdf_Fill:Pdf_Stroke);
       waterColor=CheckColor(watermark.stroke);
       mywatermark+=
          pdfStrmStrokingcolorrgb(watercolor.red
          : watercolor.green
          : watercolor.blue);
       waterColor=CheckColor(watermark.fill );
       mywatermark+=
          pdfStrmFillingcolorrgb(watercolor.red
          : watercolor.green
          : watercolor.blue);
       mywatermark+=
          PdfTextadd(%trim(watermark.text))
          + PdfTextClose()
          + PdfStrmRestoreGraphicState();
       return MyWaterMark;
B01    begsr *pssr;
          dump;
E01    endsr;
    ? /end-free
EPR  P                 e
    ? *=---------------------------------------------------------------=*
    ? *=---------------------------------------------------------------=*
    ?p*                b
    ? */free
    ? * begsr *pssr;
    ? * dump;
    ? * endsr;
    ? */end-free
    ?P*                 e
    ? *=---------------------------------------------------------------=*
