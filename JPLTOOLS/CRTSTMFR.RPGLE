      /define INFDS
      /define IFS
      /define quote

     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
     h  BNDDIR('QC2LE')

      /define DATA_SECTION
      /include jpltools,jp4inc
      /undefine DATA_SECTION

     d crtstmfr        pr
     d  filename                    255
     d  UnlinkStmt                    4
     d  authority                     5i 0
     d  ccsid                         5i 0
     d  edit                          4
     d crtstmfr        pi
     d  filename                    255
     d  unlinkStmf                    4
     d  authority                     5i 0
     d  ccsid                         5i 0
     d  edit                          4

     d rc              s             10i 0
     d accessmode      s              5i 0
     D    FileHandle   s             10i 0
     d  Stmfname       s            255    varying
    ? * commande as400
     D QCmdExec        PR                  EXTPGM('QCMDEXC')
     D cmd                         5000A   CONST
     D cmdlen                        15P 5 CONST
     D cmd             s           5000A
     d err             s              5i 0
     d CreateIt        s               n

      /free
       CreateIt = false;
       stmfname= %trim(filename) ;
          //?check if stream file already exists
          rc = access( stmfname : F_OK);
B01    if rc < 0;
          //?cannot get acess to the streamfile
          err=errno();
B02       if err= 3025;//?3025 = file not found
             createIt=True;
X02       else;
             //?unattended error, abnormal end
             escerrno(errno);
E02       endif;
E01    endif;
B01    if rc = 0;//?file exists
          //?if stream file already exists, do nothing but EDTF
B02       if UnlinkStmf='*YES';
             //?remove the file, if exists
             rc= unlink (stmfName);
B03          if rc <> 0;
                escerrno(errno);
E03          endif;
             createIt=True;
E02       endif;
E01    endif;
B01    if CreateIt;
E01       //?create a file & declare implicit code page converter
E01       FileHandle = open(stmfName
E01          : O_CREAT + O_WRONLY + O_TRUNC + O_CCSID
E01          : Authority
E01          : CCSID ) ;
B02       if FileHandle = -1;
E01          escerrno(errno);
E02       endif;
E01
E01       Rc = close( FileHandle) ;
B02       if rc <> 0;
E01          escerrno(errno);
E02       endif;
E01    endif;
E01
B01    if edit='*YES';
E01       cmd='EDTF '+quote(stmfname);
E01       qcmdexec(cmd: %len(cmd));
E01    endif;
E01



       *inlr = *on;
B01
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

