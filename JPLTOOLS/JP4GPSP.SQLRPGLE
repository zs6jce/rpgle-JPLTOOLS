    ? *=------------------------------------------------------------------------------------------=*
      *
      *  If you need to change anything in this code, feed back !
      *  so, I will take care of the update in next version
      *
    ? *=------------------------------------------------------------------------------------------=*

     d ChkObj          pr              n   extproc('JP4GPS.ChkObj')             true=object exists
     d   ObjName                     20    const                                x10 name + x10 lib
     d   ObjType                     10    const
     d   ech                               likeds(errorcodehandler)

     d ChkMbr          pr              n   extproc('JP4GPS.ChkMbr')             true=object exists
     d   MbrName                     30    const                                file + lib + mbr
     d   ech                               likeds(errorcodehandler)

     d chgobjatr       pr              n   extproc('JP4GPS.ChgObjAtr')          true=done
     d   OBJ                         20    const
     d   OBJTYPE                     10    const
     d   ech                               likeds(errorcodehandler)
     d   KEY01                       30    const
     d   KEY02                       13    const
     d   KEY03                       13    const
     d   KEY04                        8    const
     d   KEY05                       13    const
     d   KEY06                        7    const
     d   KEY07                        6    const
     d   KEY08                        5    const
     d   KEY09                       10    const
     d   KEY10                       50    const
     d   KEY11                        5    const
     d   KEY12                        5    const
     d   KEY13                        5    const
     d   KEY14                        4    const
     d   KEY15                        5    const
     d   KEY16                        5    const
     d   KEY17                       10    const
