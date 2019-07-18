      /if defined(DATA_SECTION)                                                 xml-data
      *  /copy qsysinc/qrpglesrc,qxml4pr310 obsolete, replaced by 5733xt1
      /copy QXMLDEV531/QRPGLESRC,QXML4PR531
     d domexcdtap      s               *   inz(%addr(qxml_domexcdata))
     d StringCCSID     s             10i 0 inz(00)
    ? *//?                                   pointer to domexception return area.
    ? *//?prototype of print document routine below,
     d  DomToIfs       pr
     d   domnodep                      *   value
     d   fd                            *   value
     d   incodepage                  10I 0 value
     d  outcodepage                  10I 0 value
     d   xmlencoding                100    varying value
     d typeDOM         ds                  qualified based(typeptr)
     d   dom                           *
     d   root                          *
     d DOMinitializeparser...
     d                 pr
     d DOMTerminateParser...
     d                 pr
     d DOMCreateDocument...
     d                 pr                  likeds(typedom)
     d   Root                          *   value options(*string)
     d DOMReleaseDocument...
     d                 pr
     d   DomDoc                        *
     d DOMAppendElement...
     d                 pr              *
     d   DomDocP                       *
     d   ParentElementP...
     d                                 *
     d   NewElement                    *   value options(*string)
     d DOMCountElement...
     d                 pr            10i 0
     d   DomDocP                       *
     d   Element                       *   value options(*string)
     d DOMReleaseElement...
     d                 pr
     d   elemP                         *
     d DOMAppendText   pr
     d   DomDocP                       *
     d   ParentElementP...
     d                                 *
     d   NewElement                    *   value options(*string)
     d DOMAppendAttribute...
     d                 pr
     d   DomDocP                       *
     d   ParentElementP...
     d                                 *
     d   NewAttribute                  *   value options(*string)
     d   NewText                       *   value options(*string)
     d DOMWriteStream...
     d                 pr            10i 0
     d   DomDocp                       *
     d   FromCodePage                10i 0 value
     d   IfsFile                       *
     d   ToCodePage                  10i 0 value
     d   encoding                   100    varying value
     D QXWOS...
     D                 PR            10I 0                                      Write return code
     D  FD                             *   VALUE                                File Descriptor
     D  DOMCHRPTR                      *   VALUE                                Null terminated stri
     D  STRINGIND                    10I 0 VALUE                                Input string ind (wh
     D  STRLENGTH                    10I 0 VALUE                                String length or 0
     D QXWODS...
     D                 PR            10I 0                                      Write return code
     D  FD                             *   VALUE                                File Descriptor
     D  DOMCHRPTR                      *   VALUE                                DOMString
     D  STRINGIND                    10I 0 VALUE                                Input string ind (wh
     D  STRLENGTH                    10I 0 VALUE                                String length or 0
      /endif                                                                    xml-data
      /if defined(PROCEDURE_SECTION)                                            xml-proc
BPR  p DomToIfs        b
     d DomToIfs        pi
     d  domnodep                       *   value
     d   fd                            *   value
     d   incodepage                  10I 0 value
     d  outcodepage                  10I 0 value
     d   xmlencoding                100    varying value
       //?
     ddomchildp        s               *
     dsavechildp       s               *
     dnodenameP        s               *
     dnodevalP         s               *
     dattrname2P       s               *
     dattrval2P        s               *
     dnodemapP         s               *
     dnodenamecP       s               *
     dnodevalcP        s               *
     dattrname2cP      s               *
     dattrval2cP       s               *
     doutstring        s            132a
     doutstringP       s               *   inz(%addr(outstring))
     doutstring2       s            132a
     doutstring2P      s               *   inz(%addr(outstring2))
     dnodetype         s              5i 0
     dattrlen          s             10i 0
     distrue           s             10i 0
     dsaveattrl        s             10i 0
     dbytesprov        s             10i 0 inz(132)
     dbytesavail       s             10i 0 inz(0)
     dbyteprovP        s               *   inz(%addr(bytesprov))
     dbyteavailP       s               *   inz(%addr(bytesavail))
     dindex            s             10i 0 inz(0)
     dent              s             10i 0 inz(0)
     d rtn             s             10i 0 inz(0)
     d strgbufp        s               *
     d outputstr       s            132a
     d outputstrp      s               *   inz(%addr( outputstr))
       //?get node name, value and type
      /free
       nodenameP = qxmldom_node_getnodename( domnodep);
       nodevalP =qxmldom_node_getnodevalue(domnodep );
       nodetype =qxmldom_node_getnodetype(domnodep );
       //?transcode name and value to character strings from domstring
       //?and then delete the domstrings
       //?based on node type, determine the output
       //?   if node type is text_node
B01    if nodetype = qxml_cmnt_nod;
          outputstr = '<!--';
          rtn=QXWOS(fd:outputstrp: incodepage:4);
          rtn=QXWOdS(fd:nodevalP:incodepage :0);
          outputstr = '-->' + x'250D00';
          rtn=QXWOS(fd:outputstrp: incodepage:0 );
X01    else;
B02       if nodetype =qxml_text_nod;
             rtn=QXWOdS(fd: nodevalP:incodepage :0);
X02       else;
             //?   node type is processing instruction
B03          if nodetype =qxml_pi_nod;
B04             if nodenamecP <> *null and nodevalcP <> *null;
                   outputstr = '<?';
                   rtn=QXWOS(fd: outputstrp:incodepage:2 );
                   rtn=QXWOdS(fd:nodenameP:incodepage :0);
                   rtn=QXWOS(fd:outputstrp:incodepage:2 );
                   outputstr ='?>' + x'250D00';
                   rtn=QXWOS(fd:outputstrp:incodepage:0);
E04             endif;
X03          else;
                //?node type is document - print child nodes
B04             if nodetype =qxml_doc_nod;
                   outputstr = '<?xml version="1.0" ' +
                   //?here is where you might need to specify an encoding if ebcdic
                      xmlencoding + ' ?>' + x'250D00';
                   rtn=QXWOS(fd:
                      outputstrp:incodepage:0);
                   //?here is where you might need to specify a dtd
                   //?outputstr = '<!doctype xxxx system' + ' "xxxx.dtd">' + x'25'
                   //?
                   //?rtn=QXWOS(fd:outputstrp:incodepage:nn)
                   //?
                   domchildp=qxmldom_node_getfirstchild( domnodep);
B05                dow (qxmldom_node_isnull(domchildp) = qxml_nodnotnul);
                    DomToIfs (domchildp:fd:incodepage:outcodepage: xmlencoding);
                      savechildp=domchildp;
                      domchildp=qxmldom_node_getnextsibling( domchildp);
                      qxmldom_node_delete(savechildp);
E05                enddo;
                   qxmldom_node_delete(domchildp);
X04             else;
                   //?node type is element  - print child nodes
B05                if nodetype = qxml_elmnt_nod;
                      //?determine if element node has any 'attributes'
                      nodemapP=qxmldom_node_getattributes(domnodep);
                      attrlen=qxmldom_namednodemap_getlength( nodemapP);
                      saveattrl = attrlen;
                      outputstr = '<';
                      rtn=QXWOS(fd: outputstrp:incodepage:1 );
                      rtn=QXWOdS(fd: nodenameP:incodepage :0);
                      //?do while there are attribute name=value pairs
B06                   dow attrlen > 0;
                         domchildp = qxmldom_namednodemap_item(nodemapP:index);
                         attrname2P = qxmldom_node_getnodename(domchildp);
                         attrval2P =qxmldom_node_getnodevalue( domchildp);
                         outputstr = ' ';
                         rtn=QXWOS(fd: outputstrp:incodepage:1);
                         rtn=QXWOdS(fd: attrname2P:incodepage :0);
                         outputstr = '="';
                         rtn=QXWOS(fd: outputstrp:incodepage:2 );
                         rtn=QXWOdS(fd: attrval2P:incodepage :0);
                         outputstr = '"';
                         rtn=QXWOS(fd: outputstrp:incodepage:1 );
                         index = index +1;
                         attrlen = attrlen -1;
                         qxmldom_node_delete(domchildp);
                         //?end of attribute pairs loop
E06                   enddo;
                      qxmldom_namednodemap_delete(nodemapP);
                      //?process children of node
                      domchildp=qxmldom_node_getfirstchild( domnodep);
B06                   if (qxmldom_node_isnull(domchildp) = qxml_nodnotnul);
                         outputstr = '>' + x'250D00';
                         rtn=QXWOS(fd: outputstrp:incodepage:0 );
                         //?do while there are child nodes
B07                      dow (qxmldom_node_isnull(domchildp) = qxml_nodnotnul);
                    DomToIfs (domchildp:fd:incodepage:outcodepage: xmlencoding);
                            savechildp=domchildp;
                            domchildp=qxmldom_node_getnextsibling(domchildp);
                            qxmldom_node_delete(savechildp);
E07                      enddo;
                         qxmldom_node_delete(domchildp);
                         outputstr = '</';
                         rtn=QXWOS(fd: outputstrp:incodepage:2 );
                         rtn=QXWOdS(fd: nodenameP:incodepage :0);
                         outputstr = '>'+ x'250D00';
                         rtn=QXWOS(fd: outputstrp:incodepage:0 );
X06                   else;
                         qxmldom_node_delete(domchildp);
                         outputstr = '/>' + x'250D00';
                         rtn= QXWOS(fd: outputstrp:incodepage:0);
E06                   endif;
E05                endif;
E04             endif;
E03          endif;
E02       endif;
E01    endif;
      /end-free
EPR  p                 e
BPR  p QXWOS           b
     D QXWOS           Pi            10I 0                                      Write return code
     D  FD                             *   VALUE                                File Descriptor
     D  DOMCHRPTR                      *   VALUE                                Null term string
     D  stringcodepage...
     D                               10I 0 VALUE                                Input string ind (wh
     D  STRLENGTH                    10I 0 VALUE                                String length or 0
    ?d*texte           s           1024    varying
      /free
       //?if strlength = 0;
       //?   texte = %str(domchrptr);
       //?else;
       //?   texte = %str (domchrptr : strlength);
       //?endif;
       //?debugging
       //?message('':texte);
       return qxmlwriteoutputstream(fd
          : DOMCHRPTR
          : STRINGcodepage
          : STRLENGTH );
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p QXWODS          b
     D QXWODS          Pi            10I 0                                      Write return code
     D  FD                             *   VALUE                                File Descriptor
     D  DOMCHRPTR                      *   VALUE                                DOMString
     D  StringCodePage...
     D                               10I 0 VALUE                                Input string ind (wh
     D  STRLENGTH                    10I 0 VALUE                                String length or 0
    ?d*texte           s           1024    varying
     d transcoded      s               *
     d rc              s             10i 0
    ?d*text2p          s               *
    ?d*text2l          s             10i 0
      /free
       //?char* QxmlDOMString_transcode( DOMString obj )
       //?C++ Documentation
       //?Transcodes a DOMString to the platform specific default CCSID
       //?On AS400, this is IBM037. Returns null terminated string
       //?See QxmlDelete_allocstr to free string when finished
       transcoded = QxmlDOMString_transcode( domchrptr );
       //?texte = %str(transcoded);
       rc = qxwos (fd
          : transcoded
          : StringCodePage
          : 0 );
       QxmlDelete_allocstr( transcoded);
       //?Frees up string allocation from DOMString transcode request
       //? dealloc text2p ;
       return rc;
       //?return      qxmlwriteoutputstream(fd
       //?          : DOMCHRPTR
       //?          : Qxml_INDOMSTR
       //?          : STRLENGTH );
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= give to the parser the address of Qxml_DOMEXCDATA data structure
     p DOMinitializeparser...
BPR  p                 b
     d DOMinitializeparser...
     d                 pi
      /free
       qxmlinit( domexcdtap);
       RtvJobA ( JOBI0400
          : %Size( JOBI0400 )
          : 'JOBI0400'
          : '*'
          : *Blank
          : ECH
          );
       StringCCSID = jobi0400.Defaultcodedcharactersetidentifier;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= release parser ressources
EPR  p DOMTerminateParser...
BPR  p                 b
     d DOMTerminateParser...
     d                 pi
      /free
       QxmlTerm();
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= Create a new XML document in a DOM tree
       //?*= returns the new DOM document and the new root element
     p DOMCreateDocument...
BPR  p                 b
     d DOMCreateDocument...
     d                 pi                  likeds(typedom)
     d  lRootName                      *   value options(*string)
     d  lDoc           ds                  likeds(typedom)
     d ldomdocp        s               *
     d lrootp          s               *
     d ldomimplp       s               *
     d ldomdoctp       s               *
     d ldomstring1p    s               *


      /free


       //?create a document implementation
       ldomimplp = qxmldom_domimplementation_getImplementation;//?initialize the implementation
       ldomdoctp = qxmldom_documenttype_null;                  //?initialize the docType
       ldomstring1p = *NULL    ;                               //?initialize the namespace string
       ldomdocp =
          qxmldomimplementation_createdocument
          (ldomimplp:
          ldomstring1p:
          qxml_UNICODE :
          0:
          lrootName :
          StringCCSID ://?qxml_charstr :
          0:
          ldomdoctp);


       //?delete the objects created above that are not needed anymore



       //?get the root element and keep to append additional elements
       lrootp = qxmldomdocument_getdocumentelement(ldomdocp);
       ldoc.dom = ldomdocp;
       ldoc.root = lrootp;
       return ldoc;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= release ressources for a DOM tree
     p DOMreleaseDocument...
BPR  p                 b
     d DOMreleaseDocument...
     d                 pi
     d  lDomDocp                       *
      /free
       QxmlDOM_Document_delete(lDomDocP);
       return ;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= add an element to an existing element
       //?*= returns the new element node
     p DOMAppendElement...
BPR  p                 b
     d DOMAppendElement...
     d                 pi              *
     d  lDomDocP                       *
     d  lParentElementP...
     d                                 *
     d  lNewElement                    *   value options(*string)
     d ldomstring1p    s               *
     d ldomelemp       s               *
     d lchildP         s               *
      /free
       //?create a document element of name 'newelmt' and append to the parent
       //?note that for string elements you can either specify the length or
       //?provide it as a null terminated string (length is 0)
       ldomstring1p=
          qxmlTranscodeToUnicode(lNewElement :
          StringCCSID ://?qxml_charstr :
          0);
       ldomelemp=qxmldomdocument_createelement
          (ldomdocp:
          ldomstring1p:
          qxml_Unicode :
          0);
       lchildp = qxmldomnode_appendchild
          (lParentElementP:
          lDomElemp);
       qxmldomnode_delete(lchildp);
       // qxmldomstring_delete(ldomstring1p);
       return ldomelemp;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= free parser element resources
     p DOMreleaseElement...
BPR  p                 b
     d DOMReleaseElement...
     d                 pi
     d  lelemP                         *
      /free
       qxmldomElement_delete(lelemp);
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*= appends a texte to an element
BPR  p DOMAppendText   b
     d DOMAppendText   pi
     d  lDomDocP                       *
     d  lParentElementP...
     d                                 *
     d  lNewText                       *   value options(*string)
     d lTextElemP      s               *
     d lChildP         s               *
      /free
       //?create a text node and add to parent element
       lTextElemP =
          qxmldomdocument_createtextnode
          (ldomdocp:
          lNewText :
          StringCCSID ://?qxml_charstr :
          0);
       lchildp = qxmldomnode_appendchild(
          lparentelementp:
          ltextelemp );
       qxmldom_text_delete(ltextelemp );
       qxmldom_node_delete(lchildp);
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
       //?*=
     p DOMAppendAttribute...
BPR  p                 b
     d DOMAppendAttribute...
     d                 pi
     d  lDomDocP                       *
     d  lParentElementP...
     d                                 *
     d  lNewAttribute                  *   value options(*string)
     d  lNewText                       *   value options(*string)
     dldomstring       s               *
      /free
       //?create a domstring with value 'attr' and a string of value 'value'
       //?and add attr='value' as an attribute of the parent element
       ldomstring =
          qxmlTranscodeToUnicode(lNewAttribute :
          StringCCSID ://?qxml_charstr :
          0);
       qxmldom_element_setattribute
          (lParentElementp:
          ldomstring :
          qxml_Unicode :
          0:
          lNewText :
          StringCCSID ://?qxml_charstr :
          0);
       // ldomstring_delete(ldomstring );
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
     p DOMCountElement...
BPR  p                 b
     d DOMCountElement...
     d                 pi            10i 0
     d  lDomDocP                       *
     d  lElement                       *   value options(*string)
     d ldomnodelistp   s               *
     d nb              s             10i 0
      /free
       ldomnodelistp =
          qxmldomdocument_getelementsbytagname
          (ldomdocp:
          lelement :
          StringCCSID ://?qxml_charstr :
          0);
       //?verify the resulting node list count (element count should be 4)
       nb =qxmldomnodelist_getlength
          (ldomnodelistp);
       qxmldom_nodelist_delete(ldomnodelistp);
       return nb;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
BPR  p DOMWriteStream  b
     d DOMWriteStream  pi            10i 0
     d  lDomDocp                       *
     d  linCodePage                  10i 0 value
     d  lxmlfile                       *
     d  loutCodePage                 10i 0 value
     d  lencoding                   100    varying value
     d fd              s               *
     dlerrno           s             10i 0 inz(0)
     dlerrnop          s               *   inz(%addr(lerrno))
     d ifsfile         s            256    varying
      /free
       //? note that outputstream open will fail if already exists
       //? so, we test the file existence & detroy if necessary before opening
       ifsfile = %str(lxmlfile);
       rc = access(ifsfile : F_OK);
B01    if (rc <> 0 ) ;
B02       if errno <> 3025 ;
             //?CPE3025 = No such path or directory.
             //?the file exists and there is an other error
             message('':'error CPE' + %char(errno) +
                ' when checking ' + filename );
             escerrno (errno);
E02       endif;
E01    endif;
B01    if (rc = 0);
          //?the file exists; destroy it
          //? cmde='RMVLNK OBJLNK(''' + ifsfile  + ''')';
          //? rc =  c_system(cmde );
          //? if rc <> 0;
          //? message(msgid:'':'':'QCPFMSG');
          //? return rc;
          //? endif;
          rc = unlink(ifsfile);
B02       if rc <> 0;
             escerrno (errno);
E02       endif;
E01    endif;
       fd=qxmlopennewoutputstream
          (lxmlfile :
          0: lerrnop: loutcodepage);
B01    if fd = *null;
          message('':'error: output stream '
             + 'failed.  errno is'
             +%editc(lerrno:'Z')
             );
          return lerrno;
X01    else;
          DomToIfs (ldomdocp: fd:lincodepage:
             loutcodepage : lencoding) ;
          qxmlcloseoutputstream( fd);
          return 0;
E01    endif;
B00    BEGSR *pssr;
       DUMP ;
E00    ENDSR ;
      /end-free
EPR  p                 e
      /endif                                                                    xml-proc
