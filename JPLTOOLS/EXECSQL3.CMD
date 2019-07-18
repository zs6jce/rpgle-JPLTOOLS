
/* Commande EXECSQL, mode d'emploi -
EXECSQL permet d'executer une pile de commandes SQL préparées dans un membre   -
source du fichier QTXTSRC (obligatoirement en 80 caractères sinon il y a      -
perte de texte par RUNSQLSTM) -
-
separer chaque commande SQL avec une ligne RUNSQL, pour provoquer la prise en  -
compte de la commande SQL par QSYS/RUNSQLSTM ... COMMIT(*NONE) NAMING(*SYS)    -
                                                                               -
Substitution de parametres :                                                   -
1) la sequence sql :                                                           -
* detruire les données de la société &csoc-
     delete from &target/clicomp where clcsoc = '&csoc'                        -
runsql titre                                                                   -
2) l'appel                                                                     -
excsql ... ((target THELIB) (code 6))                                      -
                                                                               -
excsql respecte les minuscules : dans le texte, dans le nom des variables      -
       (attention, l'as400 met par defaut en majuscule la saisie) et dans     -
       le texte de remplacement                                                -
                                                                               -
remarque : la ligne RUNSQL est reconnue sur deux syntaxes :                    -
RUNSQL                                                                         -
 ou                                                                            -
runsql                                                                         -
mais le mot 'RUNSQL' doit être en position 1 à 6 de la ligne   -
                                                                               -
si le titre est indiqué, il est utilisé comme référence utilisateur du         -
spoule QTMPSQL, sinon référence = ligne du source                              -
                                                                               -
options pour RUNSQLSTM                                                         -
si vous désirez changer les options initiales : COMMIT(*NONE) NAMING(*SYS)     -
ajoutez une ligne SQLOPT (ou sqlopt) suivie des options désirées               -
Options de la commande : COMMIT NAMING ERRLVL DATFMT DATSEP TIMFMT TIMSEP      -
                         SAAFLAG FLAGSTD DECMPT SRTSEQ LANGID PRTFILE          -
chaque ligne SQLOPT annule et remplace la précédente                           -
                                                                               -
gestion des messages. en fait, SQL9010 La commande RUNSQLSTM a échoué.         -
par défaut : sortie brutale en *ESCAPE                                         -
modification : ajouter une ligne MONMSG (ou monmsg) avant le RUNSQL.           -
si cette ligne contient IGNORE ou ignore, les messages sont captures           -
sinon, retour en mode ESCAPE.                                                  -
                                                                               -
gestion des variables                                                          -
la commande EXECSQL permet de nommer et valorier 0 à 10 variables.             -
EXECSQL gère 0 à 20 variables.                                                 -
ajout ou modification d'une variable :                                         -
ajouter une ligne                                                              -
SETVAR variable=valeur                                                         -
la variable &variable prend la valeur valeur, c'est à dire tout ce qu'il y a   -
après le =, mais sans les espaces de gauche ni de droite.                      -
                                                                               -
Attribut utilisateur                                                           -
le RUNSQL détermine si la commande SQL est du type                             -
CREATE something FILENAME attributes                                           -
ou                                                                             -
CREATE something LIBNAME/FILENAME attributes       -
auquel cas il execute aussi un                                                 -
CHGOBJATR OBJ(LIBNAME/FILENAME)                                                -
          OBJTYPE(*FILE)                                                       -
          KEY01(CURLIB/CURFILE/CURMBR)                                       -
          KEY02D(24122004)                                                     -
          KEY02T(235959)                                                       -
          KEY03(EXECSQL)                                                       -
          KEY09('user-attr')                                                   -
          KEY10('Description du fichier')                                      -
avec filename et libname fournis par la commande SQL                           -
avec source file (key01) et date (key02) fournis par sqlc             -
                                                                               -
KEY09 vaut *SAME par defaut, et peut être modifié par l'option                -
ONCREATE-USERATTR=VALEUR (doubler les quotes)                                  -
ONCREATE-USERATTR=VCEBEY                                                     -
KEY10 vaut *SAME par defaut, et peut être modifié par l'option                -
ONCREATE-TEXT=nom d''un petit bonhomme                                     -
                                                                               -
                                                                               -
                                                                               -
comnentaires                                                                   -
mettre une etoile en position 1, ou 2 tirets en position 1                     -
                                                                               -
Mode d'execution :                                                             -
RunSql : utilise RUNSQLQTM et le membre QTEMP/QTMPSRC(QTMPSRC)                 -
ExecuteSql : utilise le mode EmbeddedSql de RPG : prepare + execute            -
ExecuteCli : utilise directement les API SQL Call Level Interface               -
                                                                               -
Options d'execution :                                                          -
Sqlopt : fixe les paramètres de RUNSQLSTM                                      -
ExecOpt : fixe les paramètres de ExecuteCLI                                    -
Remarque : les options de ExecuteSql sont fixées à la compilation de EXECSQL3R -
                                                                               -
execopt COMMIT = *cs                                                           -
execopt NAMING  = *sql                                                         -
execopt DATFMT =*job                                                           -
execopt DATSEP =*slash                                                         -
execopt TIMFMT =*hms                                                           -
execopt TIMSEP  =*colon                                                        -
execopt DFTRDBCOL =*none                                                       -
                                                                               -
extensions : l'option semicolon modifie à la volée l'interpretation du ;       -
execopt semicolon =  exeCUtecli                                                -
--execopt semicolon =  runsql                                                  -
--execopt semicolon =  executesql                                              -
execopt sqlopt génère une instruction SqlOpt                                   -
execopt sqlopt=*gen   synchronise les options ExecuteCLI et RunSql             -
                                                                               -
*/
             CMD        PROMPT('Run a SQL stack')
             PARM       KWD(STACK) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*QSYS) VALUES(*QSYS *IFS) +
                          PROMPT('Stack file system')
 QSYS:       PMTCTL     CTL(STACK) COND((*EQ *QSYS))
 IFS:        PMTCTL     CTL(STACK) COND((*EQ *IFS))
             PARM       KWD(LIBRARY) TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL *LIBL) (*CURLIB *CURLIB) +
                          (*USRLIBL *USRLIBL) (*NONE *NONE)) +
                          PMTCTL(QSYS) PROMPT('Library')
             PARM       KWD(FILE) TYPE(*CHAR) LEN(10) DFT(QTXTSRC) +
                          PMTCTL(QSYS) PROMPT('Source file')
             PARM       KWD(MEMBER) TYPE(*CHAR) LEN(10) DFT(*NONE) +
                          SPCVAL((*NONE *NONE)) PMTCTL(QSYS) +
                          PROMPT('Member')
             PARM       KWD(STARTAT) TYPE(*DEC) LEN(6 0) DFT(000000) +
                          CHOICE('Source text line number') +
                          PMTCTL(QSYS) PROMPT('From line No (6 +
                          digits)')
             PARM       KWD(STOPAT) TYPE(*DEC) LEN(6 0) DFT(999999) +
                          CHOICE('Source text line number') +
                          CHOICEPGM(*NONE) PMTCTL(QSYS) PROMPT('Up +
                          to line No (6 digits)')

             PARM       KWD(STREAM) TYPE(*CHAR) LEN(500) DFT(*NONE) +
                          SPCVAL((*NONE *NONE)) PMTCTL(IFS) +
                          PROMPT('IFS stream file name')
             PARM       KWD(STARTTAG) TYPE(*CHAR) LEN(50) +
                          DFT(*BEGIN) CHOICE('Sample START:') +
                          PMTCTL(IFS) PROMPT('Start TAG')
             PARM       KWD(STOPTAG) TYPE(*CHAR) LEN(50) DFT(*END) +
                          SPCVAL((*NONE *NONE)) CHOICE('Sample +
                          END:') CHOICEPGM(*NONE) PMTCTL(IFS) +
                          PROMPT('End TAG')

             PARM       KWD(HOLD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Hold +
                          spool files')
             PARM       KWD(SPLFNAME) TYPE(*NAME) LEN(10) +
                          DFT(*MEMBER) SPCVAL((*MEMBER)) +
                          PROMPT('Spool file name')
             PARM       KWD(DLTSPLF) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('delete +
                          spool at normal end')
             PARM       KWD(JOBLOG) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Show +
                          SQL statement in JobLog')
             PARM       KWD(SETVAR) TYPE(VAR) MAX(10) +
                          PROMPT('variables')
             PARM       KWD(COMMIT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*NONE) VALUES(*CHG *ALL *CS *NONE *RR +
                          *UR *RS *NC) PROMPT('Commitment control')
             PARM       KWD(NAMING) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SYS) VALUES(*SYS *SQL) PROMPT('Naming')

             PARM       KWD(DATFMT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ISO) VALUES(*JOB *USA *ISO *EUR *JIS +
                          *MDY *DMY *YMD *JUL) PROMPT('Date format')
             PARM       KWD(DATSEP) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*JOB) VALUES(*JOB *SLASH *PERIOD +
                          *COMMA *DASH *BLANK) PROMPT('Date +
                          separator character')
             PARM       KWD(TIMFMT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ISO) VALUES(*HMS *USA *ISO *EUR +
                          *JIS) PROMPT('Time format')
             PARM       KWD(TIMSEP) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*JOB) VALUES(*JOB *COLON *PERIOD +
                          *COMMA *BLANK) PROMPT('Time separator +
                          character')
             PARM       KWD(DFTRDBCOL) TYPE(*CHAR) LEN(10) RSTD(*NO) +
                          DFT(*NONE) PROMPT('Default collection')
             PARM       KWD(DECMPT) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*JOB) VALUES(*JOB *SYSVAL *PERIOD +
                          *COMMA) PROMPT('Decimal Point')
             PARM       KWD(DATABASE) TYPE(*CHAR) LEN(30) +
                          DFT(*LOCAL) PROMPT('Remote database +
                          (=>WRKRDBDIRE)')
             PARM       KWD(USERID) TYPE(*CHAR) LEN(30) DFT(*NONE) +
                          PROMPT('Authorization user id')
             PARM       KWD(PASSWORD) TYPE(*CHAR) LEN(30) DFT(*NONE) +
                          PROMPT('Authentication password')
             PARM       KWD(CHGOBJATR) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Add +
                          source refs into OBJ atr')
             PARM       KWD(INIT) TYPE(*CHAR) LEN(50) DFT('execopt +
                          semicolon=executesql') PROMPT('Initialize +
                          the context')
             PARM       KWD(LAST) TYPE(*CHAR) LEN(50) DFT(';') +
                          PROMPT('Close the stack')


 VAR:        ELEM       TYPE(*NAME) LEN(10) PROMPT('Variable')
             ELEM       TYPE(*CHAR) LEN(50) PROMPT('Value')
