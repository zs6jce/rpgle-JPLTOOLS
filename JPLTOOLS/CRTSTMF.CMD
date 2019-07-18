

             CMD        PROMPT('Create Stream File')

             PARM       KWD(STMF) TYPE(*PNAME) LEN(255) MIN(1) +
                          EXPR(*YES) PROMPT('Stream file Name')
             PARM       KWD(UNLINK) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) PROMPT('Force +
                          Creation')
             PARM       KWD(AUT) TYPE(*INT2) DFT(448) +
                          SPCVAL((*USR_READ 256) (*USR_WRITE 128) +
                          (*USR_EXEC 64) (*GRP_READ 32) (*GRP_WRITE +
                          16) (*GRP_EXEC 8) (*PUBLIC_READ 4) +
                          (*PUBLIC_WRITE 2) (*PUBLIC_EXECUTE 1)) +
                          PROMPT('Authority')
             PARM       KWD(CCSID) TYPE(*INT2) RSTD(*NO) DFT(*JOB) +
                          SPCVAL((*JOB 0) (*UTF8 1208) (*UTF16 +
                          1200) (*UCS2 13488) (*PCASCII 1252)) +
                          PROMPT('Coded Character Set ID')
             PARM       KWD(EDIT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) PROMPT('Start +
                          Edit')


