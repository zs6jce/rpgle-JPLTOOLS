             CMD        PROMPT('Cleanup old spools')
             PARM       KWD(NORMAL) TYPE(*DEC) LEN(3) DFT(7) RANGE(1 +
                          99) SPCVAL((*NOMAX -1)) PROMPT('standard +
                          spools life span')
             PARM       KWD(SAVED) TYPE(*DEC) LEN(3) DFT(21) RANGE(1 +
                          99) SPCVAL((*NOMAX -1)) PROMPT('Saved +
                          spools life span')
             PARM       KWD(JOBLOG) TYPE(*DEC) LEN(3) DFT(2) RANGE(1 +
                          99) SPCVAL((*NOMAX -1)) PROMPT('standard +
                          joblog life span')
             PARM       KWD(SAVEDLOG) TYPE(*DEC) LEN(3) DFT(*NOMAX) +
                          RANGE(1 99) SPCVAL((*NOMAX -1)) +
                          PROMPT('Saved joblog life span')
