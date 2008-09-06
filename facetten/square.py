from faceUtil import *

flines = file("exts/simple5.ext",'r').xreadlines()
flines = it.ifilter(isNoComment, flines)


linesa, flines = it.tee(flines)
lin = it.imap (getLinearity, it.ifilter(isLinearity, linesa)) .next()
del linesa

lines = getFacettes(flines)

for n, line in enumerate(lines):
    s,beta = squareItFromTri(line)
    print '%i %s ' % (-beta,  '=' if n < lin else "<=")
    print s


    
