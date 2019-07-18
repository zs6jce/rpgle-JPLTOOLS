      /if defined(FFD)                                                          sql
      /if defined(DATA_SECTION)

       //?FFD engine. caller is just a wrapper for data export.
       //?caller provide
       //?- ds Elements
       //?- procedures OpenLevel, AddInfo and CloseLevel
       //?- a call to GetFFD, with a pointer on a Elements structure
       //?the engine provide
       //?- calls to the API
       //?- parse of the result
       //?- extract some info
       //?- declare & use hierarchically a dozen of structure of type Elements
       //?- return the hierarchic result in the provided pointer
       //
       //
       //
       //
       //
      /if not defined(elements)
      /define elements
     d elements        ds         65006    based(pelements)    qualified
     d   alloc                       10i00
     d   info                     65000    varying
     d   len                          5u00 overlay(info)
      /endif

     d ffd             ds                  based(pFFD) likeds(elements)
     d atrs            ds                  based(patrs  ) likeds(elements)
     d hdg             ds                  based(phdg   ) likeds(elements)
     d kwds            ds                  based(pkwds  ) likeds(elements)
     d Props           ds                  based(pProps ) likeds(elements)
     d zone            ds                  based(pzone ) likeds(elements)
     d zones           ds                  based(pzones) likeds(elements)
     d fichier         ds                  based(pfichier  ) likeds(elements)
     d wrk             ds                  based(pwrk   ) likeds(elements)





     d atr             pr
     d key                           10    const
     d plevel                          *
     d name                         100    varying const
     d value                        100    varying const









     d OpenLevel       pr
     d   key                         10    const
     d   level                         *
     d AddInfo         pr
     d   key                         10    const
     d   level                         *
     d     text                     100    const varying
     d CloseLevel      pr
     d   key                         10    const
     d  pchild                         *
     d  pparent                        *   options(*nopass)

     d hexa            pr           100    varying
     d  char                         50    varying value






     d i               s             10i 0
     d iScope          s             10i 0
     d iomit           s             10i 0
     d ikeys           s             10i 0
     d idistr          s             10i 0
     d ICHKE           s             10i 0
     d ICHKP           s             10i 0
     d IFLD            s             10i 0
     d IFOP            s             10i 0

    ? * format list
     d fmtlist         ds                  qualified
     d lib                           10    dim(20)
     d file                          10    dim(20)
     d fmt                           10    dim(20)
     d iFmt            s             10i 0

    ? *=-----------------------------------------------------------------------------------------=*
     d QDBRTVFD        pr                  extpgm('QDBRTVFD')
     d Receiver                   65535    options(*varsize)
     d receiver_len                  10i 0 const
     d actual_file                   20
     d Format                         8    const
     d search_file                   20    const
     d format_name                   10    const
     d Override                       1    const
     d System_Input                  10    const
     d Format_type                   10    const
     d Error_Code                          like(ErrorCodeHandler)
    ? *=-----------------------------------------------------------------------------------------=*
     d receiver        s              1    based(preceiver)
     d len             s             10i 0
     d actual_file     s             20
     d FormatAPI       s              8
     d search_file     s             20
     d format_name     s             10
     d Override        s              1
     d System_Input    s             10
     d Format_type     s             10
     d Error_Code      ds                  likeds(ErrorCodeHandler)

    ? *=-----------------------------------------------------------------------------------------=*
    ? *include xcase,rtvfd_ds
     D fh              DS                  qualified based(pfh)                 13
     D   yret                     00010I00
     D   yavl                     00010I00
     D   flg                      00002
     D   Reserved_7               00004
     D   lbnum                    00005I00
     D   knum                     00005I00
     D   kmxl                     00005I00
     D   kflg                     00001
     D   kfdm                     00001
     D   reserved10               00008
     D   aut                      00010
     D   upl                      00001
     D   mxm                      00005I00
     D   wtfi                     00005I00
     D   frt                      00005I00
     D   mnum                     00005I00
     D   apsize                   00005I00
     D   reserved11               00007
     D   brwt                     00005I00
     D   aaf                      00001
     D   fmtnum                   00005I00
     D   fl2                      00002
     D   vrm                      00005I00
     D   aaf2                     00002
     D   crt                      00013
     D   tx                       00050     varying
     D   reserved19               00013
     D   srcf                     00010
     D   srcm                     00010
     D   srcl                     00010
     D   krcv                     00001
     D   reserved20               00023
     D   tcid                     00005I00
     D   asp                      00002
     D   nbit                     00001
     D   mxfnum                   00005I00
     D   reserved22               00076
     D   odic                     00010I00
     D   reserved23               00014
     D   figl                     00005I00
     D   mxrl                     00005I00
     D   reserved24               00008
     D   gkct                     00005I00
     D   os                       00010I00
     D   reserved25               00008
     D   ocs                      00010I00
     D   reserved26               00004
     D   pact                     00002
     D   rls                      00006
     D   reserved27               00020
     D   pfof                     00010I00
     D   lfof                     00010I00
     D   nlsb                     00001
     D   lang                     00003
     D   cnty                     00002
     D   jorn                     00010I00
     D   evid                     00010I00
     D   reserved28               00014
     D fphys           DS                  qualified based(pfphys)              261
     D   palc                     00002
     D   cmps                     00001
     D   off_sqpt                 00010I00
     D   reserved29               00004
     D   prnum                    00010I00
     D   pri                      00005I00
     D   prinum                   00005I00
     D   orid                     00010I00
     D   flags                    00001
     D   otrg                     00010I00
     D   trgn                     00005I00
     D   ofcs                     00010I00
     D   cstn                     00010I00
     D   odl                      00010I00
     D   ovw_mqt                  00010I00
     D   reserved32               00002
     D ftrg            DS                  qualified based(pftrg)               319
     D   ftrgt                    00001
     D   ftrge                    00001
     D   ftpgm                    00010
     D   ftplb                    00010
     D   ftupd                    00001
     D   ftrgf                    00001
     D cst             DS                  qualified based(pcst)                390
     D   csto                     00010I00
     D   hlen                     00010I00
     D   type                     00001
     D   chkpd                    00001
     D   state                    00001
     D   abled                    00001
     D   add_ts                   00013
     D   cst_lin                  00010
     D   cst_lp2                  00010I00
     D   reserved54               00025
     D   cst_name                 00258
     D Keyn            DS                  qualified based(pKeyn)               453
     D   kslen                    00010I00
     D   nokys                    00010I00
     D   klen                     00010I00
     D   Revcst_7                 00052
     D   narray                   10000
     D Narray          DS                  qualified based(pNarray)             466
     D   kname                    00010
     D   Revcst_6                 00022
     D ri              DS                  qualified based(pri)                 477
     D   pkfn                     00010
     D   pkln                     00010
     D   Revcst_3                 00044
     D   fkcdr                    00001
     D   Revcst_4                 00001
     D   fkcur                    00001
     D   Revcst_5                 00061
     D chk_cst         DS                  qualified based(pchk_cst)            510
     D   cst_len                  00010I00
     D   expr_len                 00010I00
     D   Revcst_8                 00024
     D   expr                     10000
     D dtalnk          DS                  qualified based(pdtalnk)             522
     D   coln                     00010I00
     D   ocole                    00010I00
     D   lnkp                     00001
     D   Revdl_1                  00023
     D lnkcole         DS                  qualified based(plnkcole)            540
     D   celen                    00010I00
     D   sevn                     00010I00
     D   colnm                    00010
     D   Revdl_2                  00014
     D   sevnm                    10000
     D rid             DS                  qualified based(prid)                553
     D   rnum                     00005I00
     D   rtl                      00010I00
     D   reserved33               00010
     D   rae                      10000
     D rae             DS                  qualified based(prae)                566
     D   reserved34               00004
     D   rnm                      00010
     D   rrp                      00005I00
     D   rco                      00002
     D   rln                      00005I00
     D   rtv                      00001
     D   rao                      00001
     D   reserved35               00010
     D logl            DS                  qualified based(plogl)               604
     D   oj                       00010I00
     D   scsn                     00005I00
     D   lxp                      00010
     D   lxl                      00010
     D   ovw                      00010I00
     D   lfa                      00001
     D   jtyp                     00001
     D   srcd                     00005I00
     D   wchk                     00001
     D   lotrg                    00010I00
     D   ltrgn                    00005I00
     D   reserved38               00007
     D join            DS                  qualified based(pjoin)               659
     D   nho                      00010I00
     D   reserved40               00004
     D   knum                     00005I00
     D   dnum                     00005I00
     D   ffnum                    00005I00
     D   tfnum                    00005I00
     D   reserved41               00024
     D   sao                      00010I00
     D   dao                      00010I00
     D jfld            DS                  qualified based(pjfld)               678
     D   fnm                      00010
     D   fnum                     00005I00
     D   reserved42               00002
     D   op                       00002
     D   tnm                      00010
     D   tnum                     00005I00
     D   reserved43               00020
     D jdup            DS                  qualified based(pjdup)               705
     D   nm                       00010
     D   jnum                     00005I00
     D   jsfna                    00001
     D   reserved45               00019
     D sql             DS                  qualified based(psql)                725
     D   reserved39               00016
     D   s_start                  00010I00
     D   s_end                    00010I00
     D   s_ccsid                  00005I00
     D   mqtd_o                   00010I00
     D   mqt_cmt                  00002
     D   flgs                     00001
     D   reserved89               00023
     D   ssl                      00010I00
     D   sst                      10000
     D mqth            DS                  qualified based(pmqth)               764
     D   len_sum                  00010I00
     D   N_deps                   00010I00
     D   reserved16               00056
     D mqte            DS                  qualified based(pmqte)               776
     D   reservd117               00016
     D   mqtd_len                 00010I00
     D   mqtd_file                00010
     D   mqtd_lib                 00010
     D   reservd116               00056
     D partnH          DS                  qualified based(ppartnH)             789
     D   Sum                      00010I00
     D   Reserved4                00004
     D   Ran_Hh                   00001
     D   fld                      00001
     D   Reservd230               00230
     D   Num_Parts                00010I00
     D   PartOffset               00010I00
     D   Hk_Offset                00010I00
     D   reservd100               00100
     D partnA          DS                  qualified based(ppartnA)             818
     D   Len                      00010I00
     D   DSN                      00010I00
     D   Num                      00010I00
     D   name_Len                 00010I00
     D   name                     00128
     D   Reserved80               00080
     D   Num_Keys                 00010I00
     D   Range_Off                00010I00
     D   reserved8                00008
     D PartnR          DS                  qualified based(pPartnR)             835
     D   Range_Len                00010I00
     D   Reserved12               00012
     D   Range_Key                00010
     D   Reserved                 00005I00
     D   pt_Rmin                  00001
     D   pt_Rmax                  00001
     D   pt_Rsin                  00001
     D   pt_Rein                  00001
     D   reserved15               00015
     D   pt_Rnull                 00001
     D   pt_Rslen                 00010I00
     D   pt_Relen                 00010I00
     D   Rstart_Off               00010I00
     D   Rend_Off                 00010I00
     D   Reserved14               00014
     D   pt_Rccsid                00005I00
     D partnhh         DS                  qualified based(ppartnhh)            889
     D   HHash_Len                00010I00
     D   HNum_Keys                00010I00
     D   reserved56               00056
     D   pt_hash                  10000
     D partnha         DS                  qualified based(ppartnha)            902
     D   Hash_Key                 00010
     D   reserved22               00022
     D sortseq         DS                  qualified based(psortseq)            912
     D   acst                     00256
     D   ccsd                     00005I00
     D   tbln                     00010
     D   tbll                     00010
     D   srtf                     00001
     D   UCS2SrtLen               00010I00
     D   UCS2_Ccsd                00005I00
     D   reservd101               00019
     D   UCS2Srtseq               10000
     D iddu            DS                  qualified based(piddu)               940
     D   dilk                     00001
     D   inm                      00010
     D   ifd                      00010
     D   diid                     00011
     D   reserved46               00004
     D   dicl                     00010I00
     D   dicc                     00005I00
     D   olng                     00010I00
     D   lnnum                    00005I00
     D   reserved47               00016
     D   dict                     10000
     D sqlname         DS                  qualified based(psqlname)            971
     D   el                       00005I00
     D   fl                       00001
     D   lg                       00005I00
     D   reservd112               00011
     D   am                       10000
     D scope           DS                  qualified based(pscope)              986
     D   reserved48               00048
     D   bf                       00010
     D   bfl                      00010
     D   t                        00010
     D   reserved49               00037
     D   bgky                     00005I00
     D   reserved50               00002
     D   blky                     00005I00
     D   reserved51               00002
     D   fogl                     00005I00
     D   reserved52               00003
     D   soon                     00005I00
     D   soof                     00010I00
     D   ksof                     00010I00
     D   kyct                     00005I00
     D   genf                     00005I00
     D   odis                     00010I00
     D   reserved53               00014
     D omit            DS                  qualified based(pomit)               1024
     D   reserved54               00002
     D   so                       00001
     D   op                       00002
     D   fn                       00010
     D   pnum                     00005I00
     D   sosaf                    00001
     D   fj                       00005I00
     D   reserved56               00008
     D   oso                      00010I00
     D omitP           DS                  qualified based(pomitP)              1079
     D   no                       00010I00
     D   ln                       00005I00
     D   in                       00001
     D   asopaf                   00001
     D   pj                       00005I00
     D   reserved58               00010
     D   vl                       10000
     D keyS            DS                  qualified based(pkeyS)               1108
     D   fld                      00010
     D   reserved59               00003
     D   sq                       00001
     D   reserved61               00018
     D distr           DS                  qualified based(pdistr)              1141
     D   ndgpn                    00010
     D   ndgpl                    00010
     D   nkyn                     00010I00
     D   reservd121               00040
     D   kname                    00010
     D   reservd122               00022
     D journal         DS                  qualified based(pjournal)            1158
     D   ojrn                     00010
     D   olib                     00010
     D   ojpt                     00001
     D   act                      00001
     D   ljrn                     00013
     D   reservd105               00029
     D format          DS                  qualified based(pformat)             1196
     D   byrtn                    00010I00
     D   byava                    00010I00
     D   reserved62               00024
     D   mtf                      00001
     D   xlto                     00010I00
     D   cao                      00010I00
     D   dico                     00010I00
     D   cid                      00005I00
     D   srcd                     00005I00
     D   tcd                      00005I00
     D   lcd                      00005I00
     D   reserved64               00007
     D   tflgs                    00001
     D   lgs                      00001
     D   reserved67               00004
     D   len                      00010I00
     D   name                     00010
     D   seq                      00013
     D   text                     00050
     D   fldnum                   00005I00
     D   Id_Off                   00010I00
     D field           DS                  qualified based(pfield)              1249
     D   defl                     00010I00
     D   ldi                      00030
     D   lde                      00030
     D   typ                      00002
     D   iob                      00001
     D   obo                      00010I00
     D   ibo                      00010I00
     D   ldb                      00005I00
     D   ldd                      00005I00
     D   ldp                      00005I00
     D   kbs                      00001
     D   ldst                     00001
     D   jref                     00005I00
     D   ldst2                    00001
     D   lgs2                     00001
     D   varx                     00005I00
     D   reserved72               00002
     D   lalc                     00005I00
     D   dttf                     00001
     D   dtts                     00001
     D   csid                     00005u00
     D   tsid                     00005u00
     D   hsid                     00005u00
     D   lsid                     00005u00
     D   ldur                     00001
     D   lgs                      00001
     D   wsid                     00005I00
     D   reserved61               00001
     D   reserved62               00001
     D   reserved63               00005I00
     D   lagco                    00001
     D   dspl                     00005I00
     D   usc2                     00001
     D   encode                   00002
     D   reserved74               00063
     D   cplx                     00010I00
     D   bmaxl                    00010I00
     D   bpadl                    00005I00
     D   dicd                     00010I00
     D   dftd                     00010I00
     D   derd                     00010I00
     D   reserved75               00006
     D   txtd                     00010I00
     D   reservd102               00002
     D   refd                     00010I00
     D   edtl                     00005I00
     D   edtd                     00010I00
     D   reserved76               00005I00
     D   chd                      00010I00
     D   vckl                     00005I00
     D   vckd                     00010I00
     D   xals                     00010I00
     D   pnd                      00010I00
     D   reserved77               00008
     D   vpx                      10000
     D reffld          DS                  qualified based(preffld)             1556
     D   rcde                     00001
     D   rfil                     00010
     D   rlib                     00010
     D   rfmt                     00010
     D   rfld                     00030
     D   reserved78               00019
     D editing         DS                  qualified based(pediting)            1578
     D   reserved80               00002
     D   dts                      00001
     D   dpc                      00001
     D   tsc                      00001
     D   nsc                      00001
     D   nsl                      00006
     D   nsr                      00006
     D   csv                      00001
     D   csl                      00006
     D   csr                      00006
     D   pzv                      00001
     D   rlz                      00001
     D   rlv                      00001
     D   lzo                      00001
     D   reserved81               00029
     D edtwrd          DS                  qualified based(pedtwrd)             1679
     D   cde                      00001
     D   cdx                      00001
     D   reserved79               00014
     D   wd                       10000
     D checkH          DS                  qualified based(pcheckH)             1697
     D   nume                     00005I00
     D   reserved82               00014
     D check           DS                  qualified based(pcheck)              1708
     D   cd                       00001
     D   nump                     00005I00
     D   el                       00005I00
     D   reserved83               00011
     D checkp          DS                  qualified based(pcheckp)             1765
     D   pl                       00005I00
     D   reserved84               00014
     D   pv                       10000
     D complex         DS                  qualified based(pcomplex)            1776
     D   enu                      00010I00
     D   nudt                     00128
     D   udt                      00010
     D   dlink                    00001
     D   dinte                    00001
     D   drper                    00002
     D   dwper                    00002
     D   dreco                    00001
     D   dunlk                    00001
     D   reservd150               00010
     D fldtxt          DS                  qualified based(pfldtxt)             1830
     D   txt                      00050
     D fldA            DS                  qualified based(pfldA)               1840
     D   sl                       00005I00
     D   reserved85               00014
     D   sn                       00258
     D flddft          DS                  qualified based(pflddft)             1850
     D   l                        00005I00
     D   a                        00001
     D   reserved87               00013
     D   v                        10000
     D idty            DS                  qualified based(pidty)               1869
     D   Len                      00005I00
     D   OStartWith               00031P00
     D   CStartWith               00031P00
     D   Incr_By                  00010I00
     D   Minimum                  00031P00
     D   Maximum                  00031P00
     D   Cycle                    00001
     D   Order                    00001
     D   Generate                 00001
     D   Curr_Cache               00010U00
     D   Rowid_Gen                00001
     D   Reserved1                00053
     D derivh          DS                  qualified based(pderivh)             1908
     D   tl                       00010I00
     D   nume                     00005I00
     D   ot                       00010I00
     D   Reserved                 00006
     D derived         DS                  qualified based(pderived)            1921
     D   vln                      00010I00
     D   typ                      00005I00
     D   v                        10000
     D fldope          DS                  qualified based(pfldope)             1938
     D   on                       00030
     D   jr                       00005I00
     D   v01                      00005I00
     D   v02                      00005I00
     D   qdtnum                   00005I00
     D   reserved                 00020
     D const           DS                  qualified based(pconst)              1959
     D   ol                       00010I00
     D   ca                       00001
     D   rc                       00001
     D   ft                       00001
     D   sp                       00001
     D   reserved92               00002
     D   cd                       00005I00
     D   cflg                     00002
     D   reserved95               00029
     D   ov                       10000
     D ope             DS                  qualified based(pope)                2033
     D   op                       00001
     D   dtfmt                    00001
     D   dtsep                    00001
     D   fm                       00001
     D   sa                       00001
     D   no                       00005I00
     D   oa                       00001
     D   reserved98               00002
     D   decptchar                00001
     D   o_func_def               00010I00
     D   reservd101               00011
     D derivt          DS                  qualified based(pderivt)             2290
     D   ln                       00005I00
     d   filler_1                     2
     D   txt                      00050
     D colhdg          DS                  qualified based(pcolhdg)             2300
     D   h1                       00020
     D   h2                       00020
     D   h3                       00020
     D iddufmt         DS                  qualified based(piddufmt)            2311
     D   reservd100               00032
     D   cm                       00032     varying
     D iddufld         DS                  qualified based(piddufld)            2323
     D   Reserved                 00016
     D   fco                      02000     varying
     D trans           DS                  qualified based(ptrans)              2335
     D   lnum                     00005I00
     D   tnm                      00010
     D   tln                      00010
     D   cid                      00005I00
     D   reserved99               00010
     D   tbl                      00256
     D casesel         DS                  qualified based(pcasesel)            2350
     D   snum                     00005I00
     D   ln                       00010I00
     D   Reserved                 00010
     D   ao                       10000
     D fct             DS                  qualified based(pfct)                2362
     D   Reserved                 00020
     D   libname                  00010
     D   namelen                  00005I00
     D   funcname                 00128
     D keyH            DS                  qualified based(pkeyH)               2580
     D   Byte_Ret                 00010I00
     D   Byte_Avail               00010I00
     D   Max_KeyLen               00005I00
     D   Key_Count                00005I00
     D   Reserved                 00010
     D   Fmt_Counts               00005I00
     D recK            DS                  qualified based(precK)               2594
     D   Rec_Name                 00010
     D   Reserved1                00002
     D   Num_Keys                 00005I00
     D   Reserved2                00014
     D   KeyInfoOff               00010I00
     D keyF            DS                  qualified based(pkeyF)               2607
     D   IntFldName               00010
     D   ExtFldName               00010
     D   Data_Type                00005I00
     D   Field_Len                00005I00
     D   Num_Digs                 00005I00
     D   Dec_Pos                  00005I00
     D   attr_t                   00001
     D   AltNameLen               00005I00
     D   Alt_Name                 00030
     D   Reserved1                00001
     D   att1_t                   00001
     D   Reserved2                00001
     D trgh            DS                  qualified based(ptrgh)               2649
     D   Bytes_Rtn                00010U00
     D   BytesAvail               00010U00
     D   Reserved1                00052
     D   Num_Trgs                 00010U00
     D   Reserved2                00008
     D   OffEntNum1               00010U00
     D   OffInsGrp                00010U00
     D   OffUpdGrp                00010U00
     D   OffDelGrp                00010U00
     D   OffReadGrp               00010U00
     D   Reserved36               00028
     D   NumSqlTrgs               00010U00
     D   NumNtvTrgs               00010U00
     D   NumInsbTrg               00010U00
     D   NumInsaTrg               00010U00
     D   NumDelbTrg               00010U00
     D   NumDelaTrg               00010U00
     D   NumUpdbTrg               00010U00
     D   NumUpdaTrg               00010U00
     D   NumRedaTrg               00010U00
     D   NumInsiTrg               00010U00
     D   NumDeliTrg               00010U00
     D   NumUpdiTrg               00010U00
     D   Reserved3                00536
     D trgd            DS                  qualified based(ptrgd)               2681
     D   Reserved4                00020
     D   Len                      00010U00
     D   Head_Len                 00010U00
     D   Reserved5                00052
     D   Pgm                      00010
     D   Lib                      00010
     D   Reserved6                00004
     D   Ord_Num                  00010U00
     D   State                    00001
     D   Operative                00001
     D   Type                     00001
     D   Mode                     00001
     D   Orient                   00001
     D   Time                     00001
     D   Event                    00001
     D   Reserved7                00045
     D   OffTrgName               00010U00
     D   Reserved8                00010U00
     D   OffSqlPath               00010U00
     D   OffUpdCols               00010U00
     D   OffWhenCol               00010U00
     D   OffBodyCol               00010U00
     D   OffDepObjs               00010U00
     D   OffTransit               00010U00
     D   OffTrgStmt               00010U00
     D   OffTrgLong               00010U00
     D   Reserved9                00064
     D   Updcond                  00001
     D   AlowRepchg               00001
     D   Threadsafe               00001
     D   Multijob                 00001
     D   Old_Tvar                 00001
     D   New_Tvar                 00001
     D   Old_Ttable               00001
     D   New_Ttable               00001
     D   Self_Ref                 00001
     D   Crt_Ts                   00013
     D   Crt_User                 00010
     D   Pgm_Owner                00010
     D   Trg_Ccsid                00010U00
     D   Reserved34               00001
     D   Mod_Tvar                 00001
     D   Reserved10               00152
     D trgn            DS                  qualified based(ptrgn)               2849
     D   Reserved11               00020
     D   AreaTotLen               00010U00
     D   Lib_Len                  00010U00
     D   Len                      00010U00
     D   Sysgen                   00001
     D   Delim                    00001
     D   Lib_Delim                00001
     D   Type                     00001
     D   Reserved12               00058
     D   Qual                     00268
     D path            DS                  qualified based(ppath)               2893
     D   Reserved13               00020
     D   PathTotLen               00010U00
     D   Path_Len                 00010U00
     D   Reserved14               00036
     D   Path                     10000
     D updcol          DS                  qualified based(pupdcol)             2906
     D   Reserved15               00020
     D   Tot_Len                  00010U00
     D   Num_Cols                 00010U00
     D   Reserved16               00052
     D updcole         DS                  qualified based(pupdcole)            2919
     D   Len                      00010U00
     D   Short_Name               00010
     D   Short_Del                00001
     D   Long_Del                 00001
     D   Long_Same                00001
     D   Long_Len                 00010U00
     D   Reserved17               00027
     D   Long_Name                10000
     D whencol         DS                  qualified based(pwhencol)            2953
     D   Reserved18               00020
     D   Tot_Len                  00010U00
     D   Num_Cols                 00010U00
     D   Self_Ref                 00001
     D   Reserved19               00051
     D whencoe         DS                  qualified based(pwhencoe)            2975
     D   Off                      00010U00
     D   Len                      00010U00
     D   File_Off                 00010U00
     D   File_Len                 00010U00
     D   Lib_Off                  00010U00
     D   Lib_Len                  00010U00
     D   firstEntry               00001
     D   This_File                00001
     D   Long                     00001
     D   Del                      00001
     D   File_Long                00001
     D   File_Del                 00001
     D   Lib_Long                 00001
     D   Lib_Del                  00001
     D   Reserved20               00032
     D bodycol         DS                  qualified based(pbodycol)            3046
     D   Reserved21               00020
     D   Tot_Len                  00010U00
     D   Num_Cols                 00010U00
     D   Self_Ref                 00001
     D   Reserved22               00051
     D bodycoe         DS                  qualified based(pbodycoe)            3068
     D   Off                      00010U00
     D   Len                      00010U00
     D   File_Off                 00010U00
     D   File_Len                 00010U00
     D   Lib_Off                  00010U00
     D   Lib_Len                  00010U00
     D   firstEntry               00001
     D   This_File                00001
     D   Long                     00001
     D   Del                      00001
     D   File_Long                00001
     D   File_Del                 00001
     D   Lib_Long                 00001
     D   Lib_Del                  00001
     D   Reserved23               00032
     D dep             DS                  qualified based(pdep)                3139
     D   Reserved24               00020
     D   DepoTotLen               00010U00
     D   DepoNumOff               00010U00
     D   DepSelfRef               00001
     D   Reserved25               00051
     D depobj          DS                  qualified based(pdepobj)             3159
     D   Type                     00002
     D   Off                      00010U00
     D   Len                      00010U00
     D   Lib_Off                  00010U00
     D   Lib_Len                  00010U00
     D   firstEntry               00001
     D   This_File                00001
     D   Obj_Long                 00001
     D   Obj_Del                  00001
     D   Lib_Long                 00001
     D   Lib_Del                  00001
     D   Reserved26               00040
     D transit         DS                  qualified based(ptransit)            3235
     D   Reserved27               00020
     D   Tot_Len                  00010U00
     D   Oldvar_Len               00010U00
     D   Newvar_Len               00010U00
     D   Oldtbl_Len               00010U00
     D   Newtbl_Len               00010U00
     D   Oldvar_Off               00010U00
     D   Newvar_Off               00010U00
     D   Oldtbl_Off               00010U00
     D   Newtbl_Off               00010U00
     D   Oldvar_Del               00001
     D   Newvar_Del               00001
     D   Oldtbl_Del               00001
     D   Newtbl_Del               00001
     D   Names_Len                00010U00
     D   Reserved28               00048
     D   Names                    10000
     D trgstmt         DS                  qualified based(ptrgstmt)            3284
     D   Reserved29               00020
     D   Tot_Len                  00010U00
     D   Onfile_Off               00010U00
     D   Onfile_Len               00010U00
     D   Onfile_Del               00001
     D   Onlib_Del                00001
     D   OnfileLong               00001
     D   Reserved30               00001
     D   CrtTrgLen                00010U00
     D   When_Len                 00010U00
     D   When_Off                 00010U00
     D   Body_Len                 00010U00
     D   Body_Off                 00010U00
     D   Reserved31               00056
     D   Crt_Trg                  10000
     D trgcmnt         DS                  qualified based(ptrgcmnt)            3325
     D   Reserved32               00020
     D   Tot_Len                  00010U00
     D   Len                      00010U00
     D   Ccsid                    00005U00
     D   Reserved33               00034
     D   Comment                  10000
    ? *=-----------------------------------------------------------------------------------------=*

    ?d*quote           s              1    inz('''')
     d enh_check       pr
     d enh_flda        pr
     d enh_fldtxt      pr
     d enh_field       pr
     d enh_edtwrd      pr
     d enh_colhdg      pr
     d enh_flddft      pr
     d enh_derivh      pr
     d enh_derived     pr
     d enh_ope         pr
     d enh_derivt      pr
     d enh_scope       pr

     d jfile           s             10    dim(50)
     d IsLF            s               n
     d IsSrcPf         s               n                                        01234567 01234567
     d qdbfhfpl        s              2    inz(x'2000')                         00100000 00000000
     d Qdbfhfsu        s              2    inz(x'0800')                         00001000 00000000

    ?d*prop            pr
    ?d*name                         100    varying const
    ?d*value                        100    varying const

     d  libr           s             10A    varying
     d  file           s             10A    varying
     d flibr           s             10A
     d ffile           s             10A
     d  mode           s             20i00

     d proptype        s             10     varying
     d proplen         s             10     varying









     d getffd          pr
     d plevel                          *

      /endif                                                                    sql
      /if defined(PROCEDURE_SECTION)                                            calc
BPR ?p getffd          b
     d getffd          pi
     d plevel                          *

       //?lib
       //?file
       //?mode
       //?properties = info not carried by a keyword. Example : Type, Len
       //?  = 0 : pas de properties : pour le reverse
       //?  = 1 : properties séparé de Keywords : pour le transform LF (pas le surrogate)
       //?  = 2 : properties à la fin des kwd : pour test, pas d'éliminations
       //?  = 3 : =mode2+quelques attributs éliminés : pour Compare Keywords
       //?  = 4 : RTVDDS - pas de properties, mais CCSID mais pas pour les LF


      /free

       OpenLevel('FFD':plevel);
       pFFD = plevel;
       Clear fmtlist;
       Clear iFmt;
       //?* programme principal
       //?* initialisation générale
       len = 50000 ;
       preceiver = %Alloc(len ) ;
       pfh = preceiver ;
       Clear Error_Code;
       Error_Code.Provided=%Size(Error_Code);
       flibr = libr ;
       ffile = file;
       FormatAPI = 'FILD0100' ;
       search_file = file;
       %Subst(search_file:11:10) = libr;
       format_name = '*FIRST' ;
       Override = '0' ;
       System_Input = '*LCL' ;
       Format_type = '*EXT' ;
       //?reclaim all data from a file
       QDBRTVFD ( Receiver
          : len
          : actual_file
          : FormatAPI
          : search_file
          : format_name
          : Override
          : System_Input
          : Format_type
          : Error_Code );

B01    If Error_Code.Available > 0;
          Message(Error_Code.Msgid:Error_Code.Msgdta
             :'':'QCPFMSG':'*ESCAPE':'': 3);
E01    Endif;
       pfh = %Addr(Receiver);
B01    If fh.yret < fh.yavl;
          len = fh.yavl ;
          preceiver = %Realloc(preceiver:len );


          //?reclaim all data from a file
          QDBRTVFD ( Receiver
             : len
             : actual_file
             : FormatAPI
             : search_file
             : format_name
             : Override
             : System_Input
             : Format_type
             : Error_Code );

B02       If Error_Code.Available > 0;
             Message(Error_Code.Msgid:Error_Code.Msgdta
                :'':'QCPFMSG':'*ESCAPE':'': 3);
E02       Endif;
          pfh = %Addr(Receiver);

B02       If fh.yret < fh.yavl;
             Message('':'Allocation error for FILD0100'
                :'':'QCPFMSG':'*ESCAPE':'': 3);

E02       Endif;
E01    Endif;
       //?write header;
       //? dsp_parms();
       //?dsp_fh();

       //?Attributes bytes.

       IsLF = %Bitand(fh.flg:qdbfhfpl)=qdbfhfpl ;
       IsSrcPf = %Bitand(fh.flg:Qdbfhfsu)=Qdbfhfsu ;



       //?284 to the IDDU/SQL Data Dictionary area
B01    If fh.odic <> 0;
          piddu = pfh + fh.odic;
          //?dsp_iddu();
          //?to the SQL long/alias file names area
B02       If iddu.olng <> 0;
             psqlname = pfh + iddu.olng;
             //?dsp_sqlname();
E02       Endif;
E01    Endif;
       //?316 to the file scope array
B01    If fh.os <> 0;   //?repeat
B02       For iScope = 0 To fh.lbnum-1;
             pscope = pfh + fh.os + Iscope*%size(scope);
             enh_scope();
             //?add a format to the format list
B03          If scope.bfl = *loval;
                scope.bfl = libr ;
E03          Endif;
B03          If scope.bf = *loval;
                scope.bf = file ;
E03          Endif;
B03          If iFmt > 0
                   //?nouveau ou déjà identifié ?
X..             And fmtlist.fmt(iFmt)= scope.t ;
                //?   distinct juste sur le format:
                //?   dans le cas d'un lf join, les noms de pf sont dans la table JFILE
                //?   dans le cas d'un lf multiformat, les noms de pf sont dans fmtlist
                //?and fmtlist.lib(iFmt) =SCOPE.BFL
                //?and fmtlist.file(iFmt)=SCOPE.BF  ;
                //?rien
X03          Else;   //?ajouter
                iFmt+=1;
                fmtlist.fmt(iFmt)= scope.t;
                fmtlist.lib(iFmt) =scope.bfl ;
                fmtlist.file(iFmt)=scope.bf ;

E03          Endif;
             //?if Scope.bf = *loval;
             //?else;
             //?   fmtlist.lib(ifmt) = Scope.bfl;
             //?   fmtlist.file(ifmt)=Scope.bf;
             //?endif;
             //?130 to the select/omit specification array
B03          If scope.soof <> 0;   //?repeat
B04             For iomit = 0 To scope.soon - 1;
                   pomit = pfh + scope.soof + Iomit*%size(omit);
                   //?dsp_omit ();
                   //?28 to the select/omit parameters
B05                If omit.oso <> 0;   //?repeat
                      pomitP = pomit + 28;   //?à 1st omitp : in omit
B06                   Dow omitP.no <> 0;
                         pomitP = pfh + omitP.no;
                         //?dsp_omitp ();
E06                   Enddo;
E05                Endif;
E04             Endfor;
E03          Endif;
             //?to the key specification array
B03          If scope.ksof <> 0 ;   //?repeat
B04             For ikeys = 0 To scope.bgky - 1;
                   pkeyS = pfh + scope.ksof + Ikeys*%size(keyS);
                   //?dsp_keys();
E04             Endfor;
E03          Endif;
             //?to the distributed file definition
B03          If scope.odis <> 0;
                pdistr = pfh + scope.odis;
                //?dsp_distr();
B04             If distr.nkyn <> 0;
B05                For idistr = 0 To distr.nkyn - 1;
                      pdistr = pdistr + 64 + Idistr*32;
                      //?dsp_distr();
E05                Endfor;
E04             Endif;
E03          Endif;
E02       Endfor;
E01    Endif;
       //?328 to the alternative collating sequence table section
B01    If fh.ocs <> 0;
          psortseq = pfh + fh.ocs;
          //?dsp_sortseq();
E01    Endif;
       //?364 to the physical file specific attributes section
B01    If fh.pfof <> 0;
          pfphys = pfh + fh.pfof;
          //?dsp_fphys();
          //? 3 to the Partitioned Table area
B02       If fphys.off_sqpt <> 0;
             ppartnH = pfh + fphys.off_sqpt;
             //?dsp_partnh();
B03          If partnH.PartOffset <> 0;   //?repeat
                ppartnA=ppartnH + partnH.PartOffset;
                //?dsp_partna();
B04             If partnA.Range_Off <> 0;   //?repeat
                   pPartnR = ppartnA + partnA.Range_Off;
                   //?dsp_partnr();
E04             Endif;
E03          Endif;
B03          If partnH.Hk_Offset <> 0;
                ppartnhh= ppartnH + partnH.Hk_Offset;
                //?dsp_partnhh();
B04             If partnhh.HNum_Keys <> 0;   //?repeat
                   ppartnha = ppartnhh+ 64;
                   //?dsp_partnha();
E04             Endif;
E03          Endif;
E02       Endif;
          //?19 to the Record ID Codes
B02       If fphys.orid <> 0;
             prid = pfh + fphys.orid ;
             //?dsp_rid();
B03          For i = 0 To rid.rnum - 1;
                prae = prid + 16 + I*32;
                //?dsp_rae();
E03          Endfor;
E02       Endif;
          //?24 to the trigger description area
B02       If fphys.otrg <> 0;
             pftrg = pfh + fphys.otrg;
             //?dsp_ftrg();
E02       Endif;
          //?30 to the constraint definition area
B02       If fphys.ofcs <> 0;
             pcst= pfh + fphys.ofcs;
             //?dsp_cst();
             //?to the next section
B03          If cst.csto <> 0;
                pcst += cst.csto;   //?repeat
                //?dsp_cst();
                //?loop on Constraint Keys (Qdb_Qdbf_Keyn), Key Name Array (Qdb_Qdbf_Narray)
                //?Referential Constraint Definition (Qdb_Qdbf_Riafk_Afkd)
E03          Endif;
E02       Endif;
          //?38 to the datalinks area
B02       If fphys.odl <> 0;
             pdtalnk = pfh + fphys.odl;
             //?dsp_dtalnk();
B03          If dtalnk.ocole <> 0;
                plnkcole = pdtalnk + dtalnk.ocole;
                //?dsp_lnkcole();
E03          Endif;
E02       Endif;
          //?42 to the SQL area
B02       If fphys.ovw_mqt <> 0;
             psql = pfh + fphys.ovw_mqt;
             //?dsp_sql();
B03          If sql.mqtd_o <> 0;
                pmqth = pfh + sql.mqtd_o;
                //?dsp_mqth();
                pmqte = pmqth + 64;
B04             For i = 0 To mqth.N_deps - 1;
                   //?dsp_mqte();
                   pmqth +=mqte.mqtd_len;
E04             Endfor;
E03          Endif;
E02       Endif;
E01    Endif;

       //?368 to the logical file specific attributes section
B01    If fh.lfof <> 0;
          plogl = pfh + fh.lfof;
          //?dsp_logl();
          //?0  to the join specifications
B02       If logl.oj <> 0;
             pjoin = plogl;   //?start join à is at 0 of logl, and at 0 of js.
B03          Dow (join.nho <> 0);
                pjoin = pfh + join.nho;
                //?dsp_join();
                //?40 to the join specification array
B04             If join.knum > 0;
B05                For i = 0 To join.knum - 0;
                      pjfld = pfh + join.sao;
                      //?dsp_jfld();
E05                Endfor;
E04             Endif;
                //?44 to the join duplicate sequence array
B04             If join.dnum > 0;
B05                For i = 0 To join.dnum - 0;
                      pjdup = pfh + join.dao;
                      //?dsp_jdup();
E05                Endfor;
E04             Endif;
E03          Enddo;
E02       Endif;
          //?26 to the SQL area
B02       If logl.ovw <> 0;
             psql = pfh + logl.ovw ;
             //?dsp_sql();
B03          If sql.mqtd_o <> 0;
                pmqth = pfh + sql.mqtd_o;
                //?dsp_mqth();
                pmqte = pmqth + 64;
B04             For i = 0 To mqth.N_deps - 1;
                   //?dsp_mqte();
                   pmqte +=mqte.mqtd_len;
E04             Endfor;
E03          Endif;
E02       Endif;
E01    Endif;
       //?378 to the journal section
B01    If fh.jorn <> 0;
          pjournal = pfh + fh.jorn;
          //?dsp_journal();
E01    Endif;

       //?structure('list of file formats');
B01    For i = 1 To iFmt;
          //?fld('Format name':
          //?   %trim(fmtlist.lib(i))+'/' + %trim(fmtlist.file(i)) + '('
          //?   + %trim(fmtlist.fmt(i)) + ')' );
E01    Endfor;



       pformat = preceiver ;
       Clear Error_Code;
       Error_Code.Provided=%Size(Error_Code);

       FormatAPI = 'FILD0200' ;
       Override = '0' ;
       System_Input = '*LCL' ;
       Format_type = '*EXT' ;


B01    For i = 1 To iFmt;
          //?search_file = fmtlist.file(i) + fmtlist.lib(i) ;
          search_file = ffile + flibr ;
          format_name = fmtlist.fmt(i) ;
          //?openfield('FILE');

          OpenLevel('FICHIER':pfichier);
          AddInfo ('FICHIER':pfichier:'FILE');
          OpenLevel('ATRS':patrs);
          atr('LIB ':patrs:'LIB':libr );
          atr('FILE':patrs:'NAME':file );
          atr('FMT ':patrs:'FMT':fmtlist.fmt(i));
          CloseLevel('ATRS':patrs:pfichier);
          // Message('':'Fichier to FFD');
          CloseLevel('FICHIER':pfichier:pFFD );
          //?reclaim each format description
          QDBRTVFD ( Receiver
             : len
             : actual_file
             : FormatAPI
             : search_file
             : format_name
             : Override
             : System_Input
             : Format_type
             : Error_Code );

B02       If Error_Code.Available > 0;
             Message(Error_Code.Msgid:Error_Code.Msgdta
                :'':'QCPFMSG':'*ESCAPE':'': 3);
E02       Endif;
B02       If Format.byrtn < Format.byava ;
             len = Format.byava;
             preceiver = %Realloc(preceiver:len );


             //?reclaim each format description
             QDBRTVFD ( Receiver
                : len
                : actual_file
                : FormatAPI
                : search_file
                : format_name
                : Override
                : System_Input
                : Format_type
                : Error_Code );

B03          If Error_Code.Available > 0;
                Message(Error_Code.Msgid:Error_Code.Msgdta
                   :'':'QCPFMSG':'*ESCAPE':'': 3);
E03          Endif;
             pformat = %Addr(Receiver);

B03          If Format.byrtn < Format.byava ;
                Message('':'Allocation error for FILD0200'
                   :'':'QCPFMSG':'*ESCAPE':'': 3);

E03          Endif;
E02       Endif;

          //?dsp_parms();
          //?dsp_format();
          //?33 to the translate table specifications
B02       If Format.xlto <> 0;
             ptrans = pformat + Format.xlto;
             //?dsp_trans();
E02       Endif;
          //?37 to the case selection specifications
B02       If Format.cao <> 0;
             pcasesel = pformat + Format.cao;
             //?dsp_casesel();
E02       Endif;
          //?41 to the IDDU/SQL dictionary format information
B02       If Format.dico <> 0;
             piddufmt= pformat + Format.dico;
             //?dsp_iddufmt();
E02       Endif;
          //?145 to the identity information
B02       If Format.Id_Off <> 0;
             pidty= pformat + Format.Id_Off ;
             //?dsp_idty();
E02       Endif;
          //?256 fields
          pfield = pformat+256 ;
          //?openfield('FIELDS');

          OpenLevel('ZONES':pzones);
          AddInfo('ZONES':pzones:'FIELDS');
          OpenLevel('ATRS':patrs);

B02       For IFLD = 0 To Format.fldnum-1;
             // Message('':'Field no '+%Char(IFLD));
             OpenLevel('ZONE':pzone );
             OpenLevel('KWDS':pkwds) ;
B03          If Mode = 0   //?props separés
X03          Or Mode = 1   //?props separés
X03          Or Mode = 4;
                OpenLevel('PROPS':pProps);
X03          Else;
                pProps=pkwds;
E03          Endif;
             //?dsp_field();
             enh_field();
             //?180 to the complex field information
B03          If field.cplx <> 0;
                pcomplex=pfield+field.cplx;
                //?dsp_complex();
E03          Endif;
             //?190 to the IDDU/SQL dictionary field information
B03          If field.dicd <> 0;
                piddufld = pfield + field.dicd ;
                //?dsp_iddufld ();
E03          Endif;
             //?194 to the default value description
B03          If field.dftd <> 0;
                pflddft = pfield + field.dftd ;
                //?dsp_flddft ();
                enh_flddft ();
E03          Endif;
             //?198 to the derived field description
B03          If field.derd <> 0;
                pderivh = pfield + field.derd ;
                enh_derivh ();
                //?  6 to the derived field text
B04             If derivh.ot <> 0;
                   pderivt = pderivh + derivh.ot ;
                   enh_derivt ();
E04             Endif;
                //?4 Number of derived field entries
                //?For IFOP = 0 To derivh.nume-1;
                //?   pfldope = pderivh + 16 + IFOP * derivh.tl ;
                //?   //?dsp_fldope();
                //?Endfor;
E03          Endif;
             //?208 to the field text description
B03          If field.txtd <> 0;
                pfldtxt = pfield + field.txtd ;
                //?dsp_fldtxt ();
                enh_fldtxt ();
E03          Endif;
             //?214 to the field reference information
B03          If field.refd <> 0;
                preffld = pfield + field.refd ;
                //?dsp_reffld ();
E03          Endif;
             //?220 to the edit code/edit word information
B03          If field.edtd <> 0;
                pedtwrd = pfield + field.edtd ;
                //?dsp_edtwrd ();
                enh_edtwrd ();
E03          Endif;
             //?226 to the column heading information
B03          If field.chd <> 0;
                pcolhdg = pfield + field.chd ;
                //?dsp_colhdg ();
                enh_colhdg ();
E03          Endif;
             //?232 to the validity checking data
B03          If field.vckd <> 0;
                pcheckH = pfield + field.vckd ;
                enh_check();
                //?dsp_checkh ();
                pcheck = pcheckH + 16;
B04             For ICHKE = 0 To checkH.nume-1;
                   //?dsp_check();
                   pcheckp = pcheck+16;
B05                For ICHKP = 0 To Check.nump-1;
                      //?dsp_checkp();
                      pcheckp+=checkp.pl+16;
E05                Endfor;
                   pcheck+=Check.el;
E04             Endfor;
E03          Endif;
             //?236 to the alias name entry
B03          If field.xals <> 0;
                pfldA = pfield + field.xals ;
                //?dsp_flda ();
                enh_flda ();
E03          Endif;
             //?240 to the field prompted numeric editing information
B03          If field.pnd <> 0;
                pediting = pfield + field.pnd ;
                //?dsp_editing ();
E03          Endif;
             pfield+=field.defl;


          // if proptype <>'';
             atr('PROPS':pProps:'TYPE':proptype);
             atr('PROPS':pProps:'LEN': proplen );
          // endif;



             CloseLevel('KWDS':pkwds:pzone ) ;
             //?incorporer properties
B03          If Mode = 0   //?props eliminés
X03          Or Mode = 4;
                //?Dealloc(N) pProps ;
E03          Endif;
B03          If Mode = 1;
                CloseLevel('PROPS':pProps:pzone );
E03          Endif;
             CloseLevel('ZONE':pzone :patrs );
E02       Endfor;

          CloseLevel('ATRS':patrs :pzones);
          // Message('':'Zones to FFD');
          CloseLevel('ZONE':pzones:pFFD );

E01    Endfor;


       Dealloc preceiver;


       CloseLevel('FFD':pFFD );
       plevel = pFFD;
       Return;
      /end-free
EPR  p GetFFD          e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p hexa            b
     d hexa            pi           100    varying
     d  char                         50    varying value
     d value           s            100    varying
     D len1            s             10i 0
    ? * returns char representation of any hexadecimal string
     D Chr2Hex         Pr                  ExtProc('cvthc')
     D  Tgt                            *   value
     D  Src                            *   value
     D  TgtLen                       10i 0 Value
      /free

       len1= %Len(char)*2 ;
       %Len(value)=len1;
       Chr2Hex (%Addr(value)+2 :%Addr(char)+2 : len1) ;
       Return 'X'''+value +'''';
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p dsp_parms       b
     d dsp_parms       pi
      /free
       //?structure('API parameters');
       //?fld('Qualified returned file name'         :actual_file );
       //?fld('Format name'                          :FormatAPI               );
       //?fld('Qualified file name'                  :search_file             );
       //?fld('Record format name'                   :format_name             );
       //?fld('Override processing'                  :Override                );
       //?fld('System'                               :System_Input            );
       //?fld('Format type'                          :Format_type             );
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
    ? *include xcase,rtvfd_pi


    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_check       b
     d
     d number          s             60    varying
     d asis            s               n
     d keyname         s             50    varying
     d keyvalue        s             50    varying
      /free
       //?dsp_checkh ();
       pcheck = pcheckH + 16;
B01    For ICHKE = 0 To checkH.nume-1;
          //?dsp_check();
          //?   DDSI keyword identifier.
          asis = True;
          keyname ='';
          keyvalue='';
B02       Select ;
X02          When Check.cd = X'63' ;
                //?pas pour les LF
                //?keyname = 'CHKMSGID ';
B03             If Mode = 1;
X03             Else;
                   //?atr('KWDS':pkwds :'CHKMSGID ':'');
                   keyname= 'CHKMSGID' ;
E03             Endif;
X02          When Check.cd = X'64' ;
                keyname = 'CHECK';
                keyvalue= 'ME';
X02          When Check.cd = X'66' ;
                keyname = 'CHECK';
                keyvalue= 'FE';
X02          When Check.cd = X'67' ;
                //?pas pour les LF
                //?keyname = 'CHECK';
                //?keyvalue= 'MF';
B03             If Mode = 1;
X03             Else;
                   atr('KWDS':pkwds :'CHECK':'MF');
E03             Endif;
X02          When Check.cd = X'71' ;
                keyname = 'RANGE';
                asis = False;
X02          When Check.cd = X'72' ;
                keyname = 'VALUES';
                asis = False;
X02          When Check.cd = X'73' ;
                keyname = 'COMP';
                keyvalue= 'GT ';
                asis = False;
X02          When Check.cd = X'74' ;
                keyname = 'COMP';
                keyvalue= 'GE ';
                asis = False;
X02          When Check.cd = X'75' ;
                keyname = 'COMP';
                keyvalue= 'EQ ';
                asis = False;
X02          When Check.cd = X'76' ;
                keyname = 'COMP';
                keyvalue= 'NE ';
                asis = False;
X02          When Check.cd = X'77' ;
                keyname = 'COMP';
                keyvalue= 'LE ';
                asis = False;
X02          When Check.cd = X'78' ;
                keyname = 'COMP';
                keyvalue= 'LT ';
                asis = False;
X02          When Check.cd = X'79' ;
                keyname = 'COMP';
                keyvalue= 'NL ';
                asis = False;
X02          When Check.cd = X'7A' ;
                keyname = 'COMP';
                keyvalue= 'NG ';
                asis = False;
X02          When Check.cd = X'A0' ;
                keyname = 'CHECK';
                keyvalue= 'M10';
X02          When Check.cd = X'A1' ;
                keyname = 'CHECK';
                keyvalue= 'M11';
X02          When Check.cd = X'A2' ;
                keyname = 'CHECK';
                keyvalue= 'VN ';
X02          When Check.cd = X'A3' ;
                keyname = 'CHECK';
                keyvalue= 'AB ';
X02          When Check.cd = X'A5' ;
                keyname = 'CHECK';
                keyvalue= 'VNE';
X02          When Check.cd = X'A6' ;
                keyname = 'CHECK';
                keyvalue= 'M10F';
X02          When Check.cd = X'A7' ;
                keyname = 'CHECK';
                keyvalue= 'M11F';
E02       Endsl;


B02       If keyname <> '';
             pcheckp = pcheck+16;
B03          For ICHKP = 0 To Check.nump-1;
                //?dsp_checkp();
B04             If keyname = 'CHKMSGID' And ICHKP = 1;
                   keyvalue+=%Subst(checkp.pv:1:checkp.pl) +'/';
X04             Elseif asis;
                   keyvalue+=%Subst(checkp.pv:1:checkp.pl) +' ';
X04             Else;
B05                Select ;
X05                   When field.typ =X'0004' ;
                         keyvalue+= Quote(
                            %Subst(checkp.pv:1:checkp.pl)
                            :False) +' ';
X05                   When field.typ =X'0002'
X05                   Or field.typ =X'0003';
                         number= %Subst(checkp.pv:1:checkp.pl) ;
B06                   If %Bitand(%Subst(number:%Len(number):1) : X'F0') = X'C0';
                            %Subst(number:%Len(number):1) =
                               %Bitor( %Subst(number:%Len(number):1) : X'F0');
                            number='+'+number;
X06                      Elseif
                         %Bitand(%Subst(number:%Len(number):1) : X'F0') = X'D0';
                            %Subst(number:%Len(number):1) =
                               %Bitor( %Subst(number:%Len(number):1) : X'F0');
                            number='-'+number;
E06                      Endif;
B06                      If field.ldd> 0;
B07                         If field.ldp > 0;
                               number = %Subst(number:1:%Len(number)-field.ldp)
                        +'.'+ %Subst(number:%Len(number)-field.ldp+1:field.ldp);
X07                         Else;


E07                         Endif;
E06                      Endif;
                         keyvalue+=number+' ';
X05                   Other;
                         keyvalue+=%Subst(checkp.pv:1:checkp.pl) +' ';
E05                Endsl;
E04             Endif;
                pcheckp+=checkp.pl+16 ;
E03          Endfor;

             atr('KWDS':pkwds:keyname:keyvalue);

E02       Endif;


          pcheck+=Check.el;
E01    Endfor;

      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*

    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_flda        b
     d
      /free
       //?mode Compare KWD : pas de ALIAS
B01    If Mode = 3 ;
X01    Else;
          atr('KWDS':pkwds:'ALIAS':%Trim(fldA.sn));
E01    Endif;


      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_fldtxt      b
     d
      /free
       if mode = 3;
       return;
       endif;
B01    If fldtxt.txt = ''   //?preserver TEXT('  ')   ?
X01    Or fldtxt.txt = field.lde ;
          //?atr('KWDS':pkwds:'TEXT':' '                              ) ;
X01    Else;
          atr('KWDS':pkwds:'TEXT': Quote( %Trim(fldtxt.txt) ) ) ;
E01    Endif;


      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_field       b
     d
    ? *.....A..........T.Name++++++RLen++TDpB......Functions+++++++++++++++++++++++++++
     d name            s             10
     d r               s              1
     d len             s             20    varying
     d t               s             20    varying
     d dp              s              2
     d b               s              1
     d function        s             36    varying
     d keyname         s             50    varying
     d keyvalue        s             50    varying
      /free

       name = field.lde ;

       //?openfield(name);
       //?OpenLevel(pzone);
       AddInfo('ZONE':pzone :name);



B01    Select;
X01       When field.typ = X'0000' ;   //?BINARY
             t = 'B';
             len = %Char(field.ldd) ;
X01       When field.typ = X'0001' ;   //?FLOAT
             t = 'F';
             len = %Char(field.ldd) ;
             dp = %Char(field.ldp) ;
B02          If field.ldb = 8;
                //?function='FLTPCN(*DOUBLE)';
                keyname= 'FLTPCN' ;
                keyvalue='*DOUBLE';
E02          Endif;
X01       When field.typ = X'0002' ;   //?ZONED DECIMAL
             t = 'S';
             len = %Char(field.ldd) ;
             dp = %Char(field.ldp) ;
X01       When field.typ = X'0003' ;   //?PACKED DECIMAL
             t = 'P';
             len = %Char(field.ldd) ;
             dp = %Char(field.ldp) ;
X01       When field.typ = X'0004' ;   //?CHARACTER
             t = 'A';
             len = %Char(field.ldb) ;
X01       When field.typ = X'8004' ;   //?VAR CHARACTER
             t = 'A';
             len = %Char(field.ldb-2) ;
             //?pas pour les LF
             //?function='VARLEN';
             keyname= 'VARLEN';
             keyvalue='';
B02          If field.lalc > 0;
                //?function+='('+%char(field.lalc)+')';
                keyvalue= %Char(field.lalc) ;
E02          Endif;
B02          If Mode = 1;
                atr('PROPS':pProps:keyname:keyvalue);
X02          Else;
                atr('KWDS':pkwds :keyname:keyvalue);
E02          Endif;
             keyname='';
             keyvalue='';
X01       When field.typ = X'0005' ;   //?GRAPHIC
             t = 'G';
             len = %Char(field.Ldb/2) ;
X01       When field.typ = X'8005' ;   //?VAR GRAPHIC
             t = 'G';
             len = %Char(field.Ldb/2 - 1) ;
             //?pas pour les LF
             //?function='VARLEN';
             keyname= 'VARLEN';
             keyvalue='';
B02          If field.lalc > 0;
                //?function+='('+%char(field.lalc)+')';
                keyvalue= %Char(field.lalc) ;
E02          Endif;
B02          If Mode = 1;
                atr('PROPS':pProps:keyname:keyvalue);
X02          Else;
                atr('KWDS':pkwds :keyname:keyvalue);
E02          Endif;
             keyname='';
             keyvalue='';
X01       When field.typ = X'0006' ;   //?DBCS-CAPABLE
             t = 'O';
             len = %Char(field.ldb) ;
X01       When field.typ = X'8006' ;   //?VAR DBCS-CAPABLE
             t = 'O';
             len = %Char(field.ldb) ;
             //?pas pour les LF
             //?function='VARLEN';
             keyname= 'VARLEN';
             keyvalue='';
B02          If field.lalc > 0;
                //?function+='('+%char(field.lalc)+')';
                keyvalue= %Char(field.lalc) ;
E02          Endif;
B02          If Mode = 1;
                atr('PROPS':pProps:keyname:keyvalue);
X02          Else;
                atr('KWDS':pkwds :keyname:keyvalue);
E02          Endif;
             keyname='';
             keyvalue='';
X01       When field.typ = X'000B' ;   //?DATE
             t = 'L';
X01       When field.typ = X'000C' ;   //?TIME
             t = 'T';
X01       When field.typ = X'000D' ;   //?TIMESTAMP
             t = 'Z';
X01       When field.typ = X'4004' ;   //?BLOB/CLOB
             t = 'LOB';
             len = %Char(field.bmaxl) ;
X01       When field.typ = X'4005' ;   //?DBCLOB
             t = 'DBLOB';
             len = %Char(field.ldb) ;
X01       When field.typ = X'4006' ;   //?CLOB-OPEN
             t = 'CLOB-OPEN';
             len = %Char(field.ldb) ;
X01       When field.typ = X'8044' ;   //?DATALINK-CHAR
             t = 'DLINK-CHAR';
             len = %Char(field.ldb) ;
X01       When field.typ = X'8046' ;   //?DATALINK-OPEN
             t = 'DLINK_OPEN';
             len = %Char(field.ldb) ;
X01       When field.typ = X'FFFF' ;   //?NULL
             t = 'NULL';
             len = %Char(field.ldb) ;
E01    Endsl;

       atr('KWDS':pkwds:keyname:keyvalue);
       // CPD7440 Field must be blank for record,
       // Field must be blank for record, select, omit, or CONCAT.
       proptype = t;
       proplen = len+' '+dp ;
       // atr('PROPS':pProps:'TYPE':t);
       // atr('PROPS':pProps:'LEN':len+' '+dp);
B01    If field.csid <> 0;
          //?mode Compare KWD : pas de CCSID pour les dates
B02       If (t = 'L' Or t = 'T' Or t = 'Z');
X02       Else;
B03          If Mode = 3;
X03          Elseif Mode = 1;
X03          Else;
B04             If Mode = 4;
B05                If IsLF;
                      atr('PROPS':pProps:'CCSID': %Char(field.csid) );
X05                Else;
                      atr('KWDS':pkwds :'CCSID': %Char(field.csid) );
E05                Endif;
X04             Else;
                   atr('PROPS':pProps:'CCSID': %Char(field.csid) );
E04             Endif;
E03          Endif;
E02       Endif;
E01    Endif;

B01    Select;   //   Qddffiob
X01       When field.iob = X'01';
             atr('PROPS':pProps:'READONLY':'');
X01       When field.iob = X'02';
             atr('PROPS':pProps:'WRITEONLY':'');
E01    Endsl;
       //?select;
       //?when field.kbs = 'X'; //  Alphabetic only.
       //?when field.kbs = 'A'; //  Alphameric shift.
       //?when field.kbs = 'N'; //  Numeric shift.
       //?when field.kbs = 'S'; //  Signed numeric.
       //?when field.kbs = 'Y'; //  Numeric only.
       //?when field.kbs = 'D'; //  Digits only.
       //?when field.kbs = 'M'; //  Numeric only character.
       //?when field.kbs = 'W'; //  Katakana.
       //?when field.kbs = 'H'; //  Hexadecimal.
       //?when field.kbs = 'I'; //  Inhibit keyboard entry.
       //?when field.kbs = 'J'; //  DBCS only.
       //?when field.kbs = 'E'; //  DBCS either.
       //?when field.kbs = 'O'; //  DBCS open.
       //?when field.kbs = 'B'; //  Binary character.
       //?when field.kbs =  X'00';//No shift expected.
       //?endsl;
B01    If field.kbs <> X'00';
          atr('KWDS':pkwds :'REFSHIFT':field.kbs);
E01    Endif;

B01    If field.typ = X'000B'
X01    Or field.typ = X'000c';
B02       Select;
X02          When field.typ = X'000B' ;   //?DATE

                keyname='DATFMT';
X02          When field.typ = X'000C' ;   //?TIME

                keyname='TIMFMT';
E02       Endsl;


B02       Select;
X02          When field.dttf = X'FE';   //? The format associated with the job.

                atr('KWDS':pkwds:keyname: '*JOB');
X02          When field.dttf = X'FF';   //? The format associated with the QDT.

                atr('KWDS':pkwds:keyname: '*QDT ');
X02          When field.dttf = X'01';   //? The *USA format.

                atr('KWDS':pkwds:keyname: '*USA ');
X02          When field.dttf = X'03';   //? The *ISO format.

                atr('KWDS':pkwds:keyname: '*ISO ');
X02          When field.dttf = X'05';   //? The *EUR format.

                atr('KWDS':pkwds:keyname: '*EUR ');
X02          When field.dttf = X'07';   //? The *JIS format (date only).

                atr('KWDS':pkwds:keyname: '*JIS');
X02          When field.dttf = X'09';   //? The SAA timestamp.

                atr('KWDS':pkwds:keyname: 'SAA');
X02          When field.dttf = X'17';   //? The *MDY format (date only).

                atr('KWDS':pkwds:keyname: '*MDY');
X02          When field.dttf = X'18';   //? The *DMY format (date only).

                atr('KWDS':pkwds:keyname: '*DMY');
X02          When field.dttf = X'19';   //? The *YMD format (date only).he job.

                atr('KWDS':pkwds:keyname: '*YMD');
X02          When field.dttf = X'1A';   //? The *JUL format (date only).he QDT.

                atr('KWDS':pkwds:keyname: '*JUL');
X02          When field.dttf = X'1B';   //? The *HMS format (time only).

                atr('KWDS':pkwds:keyname: '*HMS');
X02          When field.dttf = X'25';   //? The *CMDY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*CMDY');
X02          When field.dttf = X'26';   //? The *CDMY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*CDMY ');
X02          When field.dttf = X'27';   //? The *CYMD format (pseudo date).

                atr('KWDS':pkwds:keyname: '*CYMD ');
X02          When field.dttf = X'28';   //? The *MDYY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*MDYY ');
X02          When field.dttf = X'29';   //? The *DMYY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*DMYY ');
X02          When field.dttf = X'2A';   //? The *YYMD format (pseudo date).

                atr('KWDS':pkwds:keyname: '*YYMD ');
X02          When field.dttf = X'2B';   //? The *YM format (pseudo date).

                atr('KWDS':pkwds:keyname: '*YM ');
X02          When field.dttf = X'2C';   //? The *MY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*MY ');
X02          When field.dttf = X'2D';   //? The *YYM format (pseudo date).

                atr('KWDS':pkwds:keyname: '*YYM ');
X02          When field.dttf = X'2E';   //? The *MYY format (pseudo date).

                atr('KWDS':pkwds:keyname: '*MYY ');
X02          When field.dttf = X'30';   //? The *LONGJUL format (pseudo date).

                atr('KWDS':pkwds:keyname: '*LONGJUL ');
E02       Endsl;
E01    Endif;



B01    If field.typ = X'000B'
X01    Or field.typ = X'000c';
B02       Select;
X02          When field.typ = X'000B' ;   //?DATE

                keyname='DATSEP';
X02          When field.typ = X'000C' ;   //?TIME
                keyname='TIMSEP';
E02       Endsl;


B02       Select;
X02          When field.dtts = X'00';   //? The separator associated with the job.

                atr('KWDS':pkwds:keyname: '*JOB ');
X02          When field.dtts = X'EE';   //? The implied separator is used.

X02          When field.dtts = '/' ;   //? The slash is used.
                atr('KWDS':pkwds:keyname: Quote('/') );
X02          When field.dtts = '-' ;   //? The dash is used.
                atr('KWDS':pkwds:keyname: Quote('-') );
X02          When field.dtts = '.' ;   //? The period is used.
                atr('KWDS':pkwds:keyname: Quote('.') );
X02          When field.dtts = ' ' ;   //? The blank is used.
                atr('KWDS':pkwds:keyname: Quote(' ') );
X02          When field.dtts = ':' ;   //? The colon is used.
                atr('KWDS':pkwds:keyname: Quote(':') );
E02       Endsl;
E01    Endif;

B01    If %Bitand(field.ldst2 : X'80') = X'80';
          //?pas pour les LF
B02       If Mode = 1;
X02       Else;
             atr('KWDS':pkwds :'ALWNULL':'');
E02       Endif;
E01    Endif;

B01    If field.derd <> 0;
          atr('PROPS':pProps:'DERIVED':'') ;
          //?donc pas de rename
E01    Endif ;



B01    If field.lde = field.ldi;
B02       If Mode = 1
B02       or Mode = 2;
             atr('PROPS':pProps:'FIELDNAME':%Trim(field.lde));
B03          If field.jref <> 0;
                atr('PROPS':pProps:'FILENAME':jfile(field.jref));
X03          Elseif fmtlist.file(i) <> file;
                atr('PROPS':pProps:'FILENAME':fmtlist.file(i)) ;
E03          Endif;
E02       Endif;
E01    Endif;

B01    If field.derd = 0;   //?sans info derivee
B02       If field.lde <> field.ldi;
B03          If Mode = 1
B03          or Mode = 2;
                atr('PROPS':pProps:'FIELDNAME':%Trim(field.ldi));
B04             If field.jref <> 0;
                   atr('PROPS':pProps:'FILENAME':jfile(field.jref));
X04             Elseif fmtlist.file(i) <> file;
                   atr('PROPS':pProps:'FILENAME':fmtlist.file(i)) ;
E04             Endif;
X03          Elseif Mode = 4;
                atr('KWDS':pkwds :'RENAME':%Trim(field.ldi));
X03          Else;
                atr('PROPS':pProps:'RENAME':%Trim(field.ldi));
E03          Endif;
E02       Endif;
E01    Endif;


B01    If field.jref <> 0;
B02       If Mode = 1;
             atr('PROPS':pProps:'JREF':%Char(field.jref));
X02       Else;
             atr('KWDS':pkwds :'JREF':%Char(field.jref));
E02       Endif;
E01    Endif;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_edtwrd      b
     d keyvalue        s             50    varying
      /free
B01    If edtwrd.cde<>'';
          keyvalue= edtwrd.cde ;
B02       If edtwrd.cdx <> '';
             keyvalue+=' '+edtwrd.cdx;
E02       Endif;

          atr('KWDS':pkwds:'EDTCDE':keyvalue );
E01    Endif;
B01    If %Subst(edtwrd.wd:1:field.edtl-16) <>'';
          atr('KWDS':pkwds:'EDTWRD'
             : Quote( %Subst(edtwrd.wd:1:field.edtl-16) :False));

E01    Endif;

      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_colhdg      b
     d keyvalue        s            100    varying
      /free
B01    If (colhdg.h1 <>'' And colhdg.h1 <> field.lde)
X01    Or colhdg.h2 <>''
X01    Or colhdg.h3 <>'' ;
          //?OpenLevel('WRK':pwrk ) ;
          //?AddInfo('WRK':pwrk :'COLHDG');


          //?OpenLevel('HDG':phdg);
          //?If colhdg.h1 <>'' ;
          //?   AddInfo('COLHDG1':phdg: Quote(%Trim(colhdg.h1) ));
          //?Endif;
          //?If colhdg.h2 <>'' ;
          //?   AddInfo('COLHDG2':phdg: Quote(%Trim(colhdg.h2) ));
          //?Endif;
          //?If colhdg.h3 <>'' ;
          //?   AddInfo('COLHDG3':phdg: Quote(%Trim(colhdg.h3) ));
          //?Endif;
          //?CloseLevel('HDG':phdg:pwrk);
          //?CloseLevel('WRK':pwrk:pkwds);

          keyvalue = Quote(%Trim(colhdg.h1));
B02       If colhdg.h2 <>'' ;
             keyvalue+= ' ' +Quote(%Trim(colhdg.h2));
E02       Endif;
B02       If colhdg.h3 <>'' ;
             keyvalue+= ' ' +Quote(%Trim(colhdg.h3));
E02       Endif;
          atr('KWDS':pkwds:'COLHDG':keyvalue );
E01    Endif;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_derivh      b
     d                 pi
     d i               s              5u00
      /free







B01    For i = 1 To derivh.nume ;
B02       If i = 1;
             pderived = pderivh+16 ;
X02       Else;
             pderived+=derived.vln ;
E02       Endif;
          enh_derived();
E01    Endfor;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
       /end-free
EPR  p                 e
BPR ?p enh_derived     b
     d                 pi
      /free






B01    Select;
X01       When derived.typ = 0;
             pfldope= pderived+ 6 ;
             //?dspfldop();
X01       When derived.typ = 1;
             pconst = pderived+ 6 ;
             //?dspconste();
X01       When derived.typ = 2;
             pope = pderived+ 6 ;
             enh_ope();
E01    Endsl;


B01    Begsr *pssr;
          Dump;
E01    Endsr;
       /end-free
EPR  p                 e
BPR ?p enh_ope         b
     d                 pi
     d v100            s            100    varying
      /free

       //? 'Derived operator.'
B01    Select;
X01       When
                ope.op= X'02';
             v100 = %Trim(field.ldi ) + ' '
                + %Char(fldope.v01)
                + ' '
                + %Char(fldope.v02 - fldope.v01 + 1) ;
             atr('KWDS':pkwds:'SST':v100);
E01    Endsl;
       //? if        ope.o_func_def  > 0;
       //?   pfunc = pope+ope.func_def;
       //? //dspfunc();
       //? endif;

B01    Begsr *pssr;
          Dump;
E01    Endsr;
       /end-free
EPR  p                 e








BPR ?p enh_derivt      b
     d                 pi
     d v100            s            100    varying
     d i               s              5i00
     d fnc             s             10    varying
      /free

       v100 = %Subst(derivt.txt:1:derivt.ln-4);
       i = %Scan('(':v100);
B01    If i > 0;
          fnc = %Subst(v100:1:i-1);
          v100=%Subst(v100:i+1);
          %Len(v100)-=1;
          atr('KWDS':pkwds :fnc:v100);
          // cpd7440
          clear proptype  ;
          clear proplen   ;

E01    Endif;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
       /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_flddft      b
     d dds             s            100    varying
      /free
B01    If IsLF ;
          Return;
E01    Endif;
B01    If %Subst(flddft.v:1:flddft.l-16) <> '' ;
          //?pas en mode Compare KWD
B02       If Mode = 3;
X02       Elseif Mode = 1;
X02       Else;
             atr('KWDS':pkwds :'DFT': (%Subst(flddft.v:1:flddft.l-16)) ) ;
E02       Endif;
E01    Endif;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
BPR ?p enh_scope       b

      /free

       jfile(iScope+1)=scope.bf;






      /end-free
EPR  p                 e
BPR ?p atr             b
     d atr             pi
     d key                           10    const
     d plevel                          *
     d name                         100    varying const
     d value                        100    varying const

      /free
B01    If name <> '';
          OpenLevel(key:pwrk ) ;
          AddInfo(%Trim(key)+' Key':pwrk :name );
          AddInfo(%Trim(key)+' Val':pwrk :value );
          CloseLevel(key:pwrk:plevel );
E01    Endif;
B01    Begsr *pssr;
          Dump;
E01    Endsr;
      /end-free
EPR  p                 e
    ? *=-----------------------------------------------------------------------------------------=*
      /endif                                                                    procedure
      /endif                                                                    ffd
