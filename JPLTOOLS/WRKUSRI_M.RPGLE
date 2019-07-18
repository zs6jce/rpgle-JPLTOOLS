
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
    ? /define PSSR
    ? /define inzsr
    ? /define wrkusrinfo

      /define LOWERCASE

     h nomain
     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')


      /define FILE_SECTION
      /include jpltools,jp4inc
      /undefine FILE_SECTION

    ? */================================================================
    ? */ modèle de programme
    ? */================================================================
    ? */les adaptations nécessaires sont marquées  : HERE
    ? */HERE replace LF wrkdftp  (& wrkdftf) with target file to update
     fwrkusrip  uf a e           k disk    rename(wrkusrip:wrkusrif) usropn
     f                                     prefix('USR.')

     d usr           e ds                  qualified extname(wrkusrip)


      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

    ? */ parametres du programme

BPR ?p GetUsrInfo      b                   export
     d GetUsrInfo      pi           100    varying
     d  keyword                      10    const
     d  p_usrprf                     10    const options(*nopass)
    ?d*=------------------
     d  usrprf         s             10
      /free
B01    If %Parms() > 2;
          usrprf = p_usrprf;
X01    Else;
          usrprf = Spcusr;
E01    Endif;
       Open Wrkusrip;
       Chain (usrprf:keyword) Wrkusrip;
       Close Wrkusrip;
B01    If %Found();
          Return usr.Value;
E01    Endif;
       Return '';
B01    Begsr *pssr;
          Dumpcallstack();
          Dump(A);
E01    Endsr ;

       //?----------------------------------------------------------------
       //?*inzsr, sr pmqsnd, sp *pssr , ...
       //?----------------------------------------------------------------
      /end-free
EPR  p GetUsrInfo      e
BPR ?p SetUsrInfo      b                   export
     d SetUsrInfo      pi
     d  keyword                      10    const
     d  Value                       100    const varying
     d  p_usrprf                     10    const options(*nopass)
    ?d*=------------------
     d  usrprf         s             10
      /free
B01    If %Parms() > 2;
          usrprf = p_usrprf;
X01    Else;
          usrprf = Spcusr;
E01    Endif;
       Open Wrkusrip;
       Chain (usrprf:keyword) Wrkusrip;
B01    If %Found();
          usr.Value = Value;
          Update Wrkusrif;
X01    Else;
          usr.usrprf = usrprf;
          usr.keyword = keyword;
          usr.Value = Value;
          Write Wrkusrif;
E01    Endif;
       Close Wrkusrip;
       Return ;
B01    Begsr *pssr;
          Dumpcallstack();
          Dump(A);
E01    Endsr ;

       //?----------------------------------------------------------------
       //?*inzsr, sr pmqsnd, sp *pssr , ...
       //?----------------------------------------------------------------
      /end-free
EPR  p SetUsrInfo      e
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
