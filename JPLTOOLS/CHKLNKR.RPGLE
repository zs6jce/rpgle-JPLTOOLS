      /define INFDS
      /define IFS

     h debug datedit(*ymd) datfmt(*iso-) decedit('0.')
     h  BNDDIR('QC2LE')

      /define DATA_SECTION
      /include jpltools,jp4inc
      /undefine DATA_SECTION

     d chklnkr         pr
     d  filename                    255
     d  authority                    10
     d chklnkr         pi
     d  filename                    255
     d  authority                    10
     d rc              s             10i 0
     d accessmode      s              5i 0
      /free


       //? check the IFS file name : authority *EXISTS


       rc = access(%trim(filename): F_OK);
B01    if (rc <> 0);
          EscErrno(errno:3);
E01    endif;

       //?check the authority level

B01    if authority <> '*EXISTS';  //
B02       select;
X02          when authority ='*R   ';
                accessmode = r_ok ;
X02          when authority ='*RW  ';
                accessmode = r_ok + w_ok ;
X02          when authority ='*RWX ';
                accessmode = r_ok + w_ok + x_ok;
X02          when authority ='*RX  ';
                accessmode = r_ok + x_ok;
X02          when authority ='*W   ';
                accessmode = w_ok ;
X02          when authority ='*WX  ';
                accessmode = w_ok + x_ok;
X02          when authority ='*X   ';
                accessmode = x_ok;
E02       endsl;
          rc = access(%trim(filename): accessmode);
B02       if (rc <> 0);
             EscErrno(errno);
E02       endif;
E01    endif;


       *inlr = *on;
B01
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

