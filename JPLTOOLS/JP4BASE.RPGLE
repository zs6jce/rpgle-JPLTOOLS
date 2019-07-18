     h debug datedit(*ymd) datfmt(*ymd-) decedit('0.')
      /define DATA_SECTION
      /include jpltools,JP4inc
      /undefine DATA_SECTION

      /free
        *inlr = *on;
        monitor;
        message('');
        on-error;
        endmon;
        return;
      /end-free
      /define PROCEDURE_SECTION
      /include jpltools,JP4inc
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
