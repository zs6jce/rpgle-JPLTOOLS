     H DEBUG DATEDIT(*YMD)
     H NoMain
     h copyright('Author is Jean-Paul Lamontre')

      // sql wrappers :
      // parameter style general with nulls
      // en cas d'erreur, la fonction retourne null. Pas de SqlStatus @ g{rer

     d BitAnd          pr            20i 0
     d* in values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  in_ind                        5i 0 dim(2) const
     d  outind                        5i 0

     d BitOr           pr            20i 0
     d* in values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  in_ind                        5i 0 dim(2) const
     d  outind                        5i 0

     d BitNot          pr            20i 0
     d* in values
     D P1                            20I 0 Const
     d* null indicators
     d  in_ind                        5i 0 const
     d  outind                        5i 0

     d BitXor          pr            20i 0
     d* in values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  in_ind                        5i 0 dim(2) const
     d  outind                        5i 0

      *=----------------------------------------------------------------------------------=*

     p    BitAnd       b                   export
     d                 pi            20i 0
     d* values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  InIsNull                      5i 0 dim(2) const
     d  OutIsNull                     5i 0
     d result          s             10i 0
      /free
       monitor;
       if InIsNull(1) <> 0 or InIsNull(2) <> 0;
       OutIsNull =-1; // null
       else;
       OutIsNull = 0; // par defaut, sortie correcte

       result = %bitand(p1 : p2);
       endif;
       on-error;
          OutIsNull = -1;
          result=0;
       endmon;
       return result;
       *inrt = *on;

       begsr *pssr ;
          dump ;
          OutIsNull = -1;
          result=0;
          return result;
       endsr ;
      /end-free
     p                 e

      *=----------------------------------------------------------------------------------=*

     p    BitOr        b                   export
     d                 pi            20i 0
     d* values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  InIsNull                      5i 0 dim(2) const
     d  OutIsNull                     5i 0
     d result          s             10i 0
      /free
       monitor;
       if InIsNull(1) <> 0 or InIsNull(2) <> 0;
       OutIsNull =-1; // null
       else;
       OutIsNull = 0; // par defaut, sortie correcte

       result = %bitor(p1 : p2);
       endif;
       on-error;
          OutIsNull = -1;
          result=0;
       endmon;
       return result;
       *inrt = *on;

       begsr *pssr ;
          dump ;
          OutIsNull = -1;
          result=0;
          return result;
       endsr ;
      /end-free
     p                 e

      *=----------------------------------------------------------------------------------=*

     p    BitNot       b                   export
     d                 pi            20i 0
     d* values
     D P1                            20I 0 Const
     d* null indicators
     d  InIsNull                      5i 0 const
     d  OutIsNull                     5i 0
     d result          s             10i 0
      /free
       monitor;
       if InIsNull    <> 0                    ;
       OutIsNull =-1; // null
       else;
       OutIsNull = 0; // par defaut, sortie correcte

       result = %bitnot(p1     );
       endif;
       on-error;
          OutIsNull = -1;
          result=0;
       endmon;
       return result;
       *inrt = *on;

       begsr *pssr ;
          dump ;
          OutIsNull = -1;
          result=0;
          return result;
       endsr ;
      /end-free
     p                 e

      *=----------------------------------------------------------------------------------=*

     p    BitXor       b                   export
     d                 pi            20i 0
     d* values
     D P1                            20I 0 Const
     D P2                            20I 0 Const
     d* null indicators
     d  InIsNull                      5i 0 dim(2) const
     d  OutIsNull                     5i 0
     d result          s             10i 0
      /free
       monitor;
       if InIsNull(1) <> 0 or InIsNull(2) <> 0;
       OutIsNull =-1; // null
       else;
       OutIsNull = 0; // par defaut, sortie correcte

       result = %bitxor(p1 : p2);
       endif;
       on-error;
          OutIsNull = -1;
          result=0;
       endmon;
       return result;
       *inrt = *on;

       begsr *pssr ;
          dump ;
          OutIsNull = -1;
          result=0;
          return result;
       endsr ;
      /end-free
     p                 e
