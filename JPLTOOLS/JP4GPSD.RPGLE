    ? *=------------------------------------------------------------------------------------------=*
      *
      *  If you need to change anything in this code, feed back !
      *  so, I will take care of the update in next version
      *
    ? *=------------------------------------------------------------------------------------------=*
    ?d* public prototypes are defines in /include

    ?**-- Retrieve object description:

     D QUSROBJD        Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )

     d OBJD0200        ds                  qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Object_name                   10
     d Object_lib                    10
     d Object_type                   10
     d Return_lib                    10
     d Obj_ASP_nbr                   10i 0
     d Object_owner                  10
     d Object_domain                 02
     d Creation_dts                  13
     d change_dts                    13
     d obj_attr                      10
     d Text                          50
     d Src_file_name                 10
     d Src_file_lib                  10
     d Src_file_mbr                  10

    ?**-- Retrieve member description:
     D QUSRMBRD        Pr                  ExtPgm( 'QUSRMBRD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjMbr                       10a   Const
     D  Overide                       1a   Const
     D  Error                     32767a          Options( *VarSize )

     d MBRD0100        ds           135    qualified
     d Bytes_returned                10i 0
     d Bytes_avail                   10i 0
     d Object_name                   10
     d Object_lib                    10
     d Object_mbr                    10
     d Object_attr                   10
     d Object_type                   10
     d IsSourceFile                   1

    ?**-- Change Object Description (QLICOBJD) API
     D QLICOBJD        Pr                  ExtPgm( 'QLICOBJD' )
     d  RtnLibName                   10
     D  ObjName                      20    Const
     D  ObjType                      10    Const
     D  ChangedInfo                 316    Const
     D  Error                     32767a          Options( *VarSize )




