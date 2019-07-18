      /free
       Exec Sql Update Xcsrcmbr Set
          "type" = : New_type
          , Text = : New_text
          , Updtime = : New_updtime
          , Hascrtdup = : New_hascrtdup
          , Haspfcmd = : New_haspfcmd
          Where Current Of K2 ;
