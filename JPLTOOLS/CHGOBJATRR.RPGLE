      /define INFDS
      /define GPS
     H BNDDIR('QC2LE':'QUSAPIBD')
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
     h copyright('Author is Jean-Paul Lamontre')
     h OPTION(*NODEBUGIO: *SRCSTMT: *SHOWCPY: *SECLVL: *EXPDDS)
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION
     d chgobjatrr      pr
     d   OBJ                         20
     d   OBJTYPE                     10
     d   KEY01                       30
     d   KEY02                       13
     d   KEY03                       13
     d   KEY04                        8
     d   KEY05                       13
     d   KEY06                        7
     d   KEY07                        6
     d   KEY08                        5
     d   KEY09                       10
     d   KEY10                       50
     d   KEY11                        5
     d   KEY12                        5
     d   KEY13                        5
     d   KEY14                        4
     d   KEY15                        5
     d   KEY16                        5
     d   KEY17                       10
     d chgobjatrr      pi
     d   OBJ                         20
     d   OBJTYPE                     10
     d   KEY01                       30
     d   KEY02                       13
     d   KEY03                       13
     d   KEY04                        8
     d   KEY05                       13
     d   KEY06                        7
     d   KEY07                        6
     d   KEY08                        5
     d   KEY09                       10
     d   KEY10                       50
     d   KEY11                        5
     d   KEY12                        5
     d   KEY13                        5
     d   KEY14                        4
     d   KEY15                        5
     d   KEY16                        5
     d   KEY17                       10
     d*ech             ds                  likeds(errorcodehandler)
     d*                                    inz(*likeds)
      /free
       reset ech   ;
       if chgobjatr (
         OBJ
       : OBJTYPE
       : ech
       : KEY01
       : KEY02
       : KEY03
       : KEY04
       : KEY05
       : KEY06
       : KEY07
       : KEY08
       : KEY09
       : KEY10
       : KEY11
       : KEY12
       : KEY13
       : KEY14
       : KEY15
       : KEY16
       : KEY17
       )       = false;
             message(ech.msgid:ech.msgdta:'*LIBL':'QCPFMSG':'*ESCAPE':'*':3);
          return;
E01    endif;
       message(ech.msgid:ech.msgdta
          :'*LIBL':'QCPFMSG':'*INFO':'*':3);
       return;
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
