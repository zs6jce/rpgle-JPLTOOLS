             cmd        prompt('changer d''environnement')

             parm       kwd(jobd) type(qfile) min(1) +
                          prompt('description de travail')
 qfile:      qual       type(*name) len(10)
             qual       type(*name) len(10) dft(*libl) +
                          spcval((*libl) (*curlib)) +
                          prompt('bibliothèque')
