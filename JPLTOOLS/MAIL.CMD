             CMD        PROMPT('Send a MIME mail')
             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(70) MIN(1) +
                          EXPR(*YES) PROMPT('Subject')
             PARM       KWD(SENDER) TYPE(*CHAR) LEN(250) MIN(1) +
                          EXPR(*YES) PROMPT('From')
             PARM       KWD(RECEIVER) TYPE(SENDTO) MIN(1) MAX(100) +
                          PROMPT('To')
             PARM       KWD(MESSAGE) TYPE(*CHAR) LEN(5000) +
                          EXPR(*YES) PROMPT('Mail Body')
             PARM       KWD(MSGTYPE) TYPE(*CHAR) LEN(30) RSTD(*YES) +
                          DFT('text/plain') +
                          SPCVAL(('text/calendar') ('text/css') +
                          ('text/h323') ('text/html') ('text/iuls') +
                          ('text/plain') ('text/scriptlet') +
                          ('text/webviewhtml') ('text/x-component') +
                          ('text/xml') ('text/x-ms-iqy') +
                          ('text/x-ms-rqy') ('text/x-scriptlet') +
                          ('text/x-vcard')) EXPR(*YES) PROMPT('Mail +
                          body type')
             PARM       KWD(ATTACH) TYPE(ATTACH) MAX(100) +
                          PROMPT('IFS file to attach')

             PARM       KWD(IMPORTANCE) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(MEDIUM) VALUES(LOW MEDIUM +
                          HIGH) MIN(0) EXPR(*YES) PROMPT('Importance')
             PARM       KWD(PRIORITY) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(NORMAL) VALUES(NONURGENT NORMAL +
                          URGENT) MIN(0) EXPR(*YES) PROMPT('Priority')
             PARM       KWD(SENSITIVE) TYPE(*CHAR) LEN(20) +
                          RSTD(*YES) DFT(NORMAL) VALUES(NORMAL +
                          PERSONAL PRIVATE COMPANYCONFIDENTIAL) +
                          MIN(0) EXPR(*YES) PROMPT('Sensitivity')
/* NOTIFY DEMANDE UN NOM DE FICHIER IFS !?? PAS COMPIRIS POURQUOI */
  /*         PARM       KWD(NOTIFY) TYPE(*CHAR) LEN(250) MIN(1) +
    /*                    EXPR(*YES) PROMPT('Disposition notify to ')       */

 SENDTO:     ELEM       TYPE(*NAME) LEN(4) RSTD(*YES) SPCVAL((*TO) +
                          (*CC) (*BCC)) MIN(1) PROMPT('Send TO, CC +
                          or BCC')  EXPR(*YES)
             ELEM       TYPE(*CHAR) LEN(250) MIN(1) PROMPT('Receiver +
                          Address') EXPR(*YES)
 ATTACH:     ELEM       TYPE(*NAME) LEN(5) RSTD(*YES) DFT(*TEXT) +
                          SPCVAL((*BIN) (*TEXT)) EXPR(*YES) +
                          PROMPT('Send as Text or Binary')

             ELEM       TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ATTACHED) VALUES(*ATTACHED *BODY) +
                          EXPR(*YES) PROMPT('show as')
             ELEM       TYPE(*CHAR) LEN(40) +
                          SPCVAL(('application/cdf') +
                          ('application/fractals') +
                          ('application/futuresplash') +
                          ('application/hta') +
                          ('application/mac-binhex40') +
                          ('application/msaccess') +
                          ('application/ms-infopath.xml') +
                          ('application/msword') +
                          ('application/octet-stream') +
                          ('application/pkcs10') +
                          ('application/pkcs7-mime') +
                          ('application/pkcs7-signature') +
                          ('application/pkix-cert') +
                          ('application/pkix-crl') +
                          ('application/postscript') +
                          ('application/schdpl32') +
                          ('application/vnd.adobe.edn') +
                          ('application/vnd.adobe.pdx') +
                          ('application/vnd.adobe.rmf') +
                          ('application/vnd.adobe.xdp+xml') +
                          ('application/vnd.adobe.xfd+xml') +
                          ('application/vnd.adobe.xfdf') +
                          ('application/vnd.ms-excel') +
                          ('application/vnd.ms-mediapackage') +
                          ('application/vnd.ms-pki.certstore') +
                          ('application/vnd.ms-pki.pko') +
                          ('application/vnd.ms-pki.seccat') +
                          ('application/vnd.ms-pki.stl') +
                          ('application/vnd.ms-powerpoint') +
                          ('application/vnd.ms-publisher') +
                          ('application/vnd.ms-wpl') +
                          ('application/x-cdf') +
                          ('application/x-complus') +
                          ('application/x-compress') +
                          ('application/x-compressed') +
                          ('application/x-ebx') +
                          ('application/x-gzip') +
                          ('application/x-ica') +
                          ('application/x-internet-signup') +
                          ('application/x-iphone') +
                          ('application/x-latex') +
                          ('application/x-mix-transfer') +
                          ('application/xml') +
                          ('application/x-mplayer2') +
                          ('application/x-msexcel') +
                          ('application/x-mspowerpoint') +
                          ('application/x-ms-wmd') +
                          ('application/x-ms-wmz') +
                          ('application/x-pkcs12') +
                          ('application/x-pkcs7-certificates') +
                          ('application/x-pkcs7-certreqresp') +
                          ('application/x-pnagent') +
                          ('application/x-sapshortcut') +
                          ('application/x-shockwave-flash') +
                          ('application/x-stuffit') +
                          ('application/x-tar') +
                          ('application/x-troff-man') +
                          ('application/x-wmplayer') +
                          ('application/x-x509-ca-cert') +
                          ('application/x-zip-compressed') +
                          ('audio/aiff') ('audio/basic') +
                          ('audio/mid') ('audio/midi') +
                          ('audio/mp3') ('audio/mpeg') +
                          ('audio/mpegurl') ('audio/mpg') +
                          ('audio/wav') ('audio/x-aiff') +
                          ('audio/x-background') ('audio/x-mid') +
                          ('audio/x-midi') ('audio/x-mp3') +
                          ('audio/x-mpeg') ('audio/x-mpegurl') +
                          ('audio/x-mpg') ('audio/x-ms-wax') +
                          ('audio/x-ms-wma') ('audio/x-wav') +
                          ('image/bmp') ('image/gif') +
                          ('image/jpeg') ('image/pjpeg') +
                          ('image/png') ('image/tiff') +
                          ('image/vnd.ms-modi') ('image/xbm') +
                          ('image/x-icon') ('image/x-jg') +
                          ('image/x-png') ('image/x-wmf') +
                          ('image/x-xbitmap') ('message/rfc822') +
                          ('midi/mid') ('text/calendar') +
                          ('text/css') ('text/h323') ('text/html') +
                          ('text/iuls') ('text/plain') +
                          ('text/scriptlet') ('text/webviewhtml') +
                          ('text/x-component') ('text/xml') +
                          ('text/x-ms-iqy') ('text/x-ms-rqy') +
                          ('text/x-scriptlet') ('text/x-vcard') +
                          ('video/avi') ('video/mpeg') +
                          ('video/mpg') ('video/msvideo') +
                          ('video/x-mpeg') ('video/x-mpeg2a') +
                          ('video/x-ms-asf') +
                          ('video/x-ms-asf-plugin') +
                          ('video/x-msvideo') ('video/x-ms-wm') +
                          ('video/x-ms-wmv') ('video/x-ms-wmx') +
                          ('video/x-ms-wvx')) EXPR(*YES) +
                          PROMPT('Mime type')
             ELEM       TYPE(*CHAR) LEN(255) EXPR(*YES) PROMPT('IFS +
                          File Name')
             ELEM       TYPE(*CHAR) LEN(50) DFT(*SAME) EXPR(*YES) +
                          PROMPT('Rename as')









