

      *=------------------------------------------------------------------------------------------=*
    ? * this short rpg code is the service program contructor.
    ? * it links the effective code to my usual programming architecture
    ? *
    ? * the effective code is separated in 3 elements
    ? * first is the public prototypes description.
    ? *    This element is in JP4GPSP (JP for General Purpose Service - Public prototypes & fields)
    ? *    This element is loaded via JP4INC, because JP4INC shows all the (public) prototypes
    ? *    a program can need.
    ? *    In my usual architecture, this is done by adding
    ? *    /define XXX
    ? *    at the beginning of any RPG program that will use the XXX procedures
      *
      *    If you want to use JP4GPS from an other language, this is the element that need
      *    to be translated.
      *
    ? * second is the private prototype description.
    ? *    This element is in JP4GPSD (JP for General Purpose Service - Data specs)
    ? *    It is used only in one program, but if you have a different usual programming
    ? *    architecture than mine, it's an element we share without any need to change
    ? *    when you will get the next version.
    ? * third is the private procedure code.
    ? *    This element is in JP4GPSR (JP for General Purpose Service - RPG Code specs)
    ? *    Same target. This shared element will not need change when getting next version
      * An last, don't omit this H spec when you generate a personalized JP4GPS *SRVPGM
      *    h copyright('Author is Jean-Paul Lamontre')
      *=------------------------------------------------------------------------------------------=*
      *=------------------------------------------------------------------------------------------=*
    ? * to compile :
    ? *
    ? * CRTRPGMOD MODULE(JP4GPS) SRCFILE(JPLTOOLS) OPTION(*NODEBUGIO *SRCSTMT
    ? * *SHOWCPY *SECLVL *EXPDDS) DBGVIEW(*ALL) REPLACE(*YES) TGTRLS(V5R3M0) ENBPFRCOL(*FULL)
    ? *
    ? * CRTSRVPGM SRVPGM(JP4GPS) EXPORT(*ALL) BNDDIR(QC2LE QUSAPIBD) ACTGRP(JPLTOOLS)
    ? * OPTION(*DUPPROC) TGTRLS(V5R3M0)
    ? *=------------------------------------------------------------------------------------------=*
      /define INFDS
      *define PDF
      /define PSSR
      /define INZSR
      *define CSYSTEM
      *define ICONV
      *define ERRNO
      *define LOWERCASE
      /define rtvjoba
      /define GPS
     H BNDDIR('QC2LE':'QUSAPIBD')
     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
     hnomain
     h copyright('Author is Jean-Paul Lamontre')
     h OPTION(*NODEBUGIO: *SRCSTMT: *SHOWCPY: *SECLVL: *EXPDDS)


      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

    ?d* public prototypes are defines in /include above
    ?d* private prototypes and workfields are here
      /include jpltools,JP4GPsD

      * PDF service program procedures
      /include jpltools,JP4GPsR

      * other procedures
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc

