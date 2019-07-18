             CMD        PROMPT('Convertion Base64')

             PARM       KWD(FROM) TYPE(*PNAME) LEN(255) MIN(1) +
                          PROMPT('IFS file to read')
             PARM       KWD(TO) TYPE(*PNAME) LEN(255) MIN(1) +
                          PROMPT('IFS file to write')
             PARM       KWD(FROMTYPE) TYPE(*CHAR) DFT(*BIN) +
                          SPCVAL((*BASE64 *N) (*BIN *N)) +
                          PROMPT('Input File Type')

