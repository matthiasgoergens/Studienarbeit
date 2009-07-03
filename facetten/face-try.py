from faceUtil import *

n = 3

flines = file("exts/part%s.ext" % n,'r').xreadlines()
flines = it.ifilter(isNoComment, flines)


linesa, flines = it.tee(flines)
lin = it.imap (getLinearity, it.ifilter(isLinearity, linesa)) .next()
del linesa

lines = getFacettes(flines)
def blowUp(face):
    ls, r = face[0], face[1:]
    return [ls] + flatten1([[c] * (len(r) - i) for i, c in enumerate(r)])
        

ilines = [map(int,line.split()) for line in lines]
for n, face in enumerate(ilines):
    print ' '.join(map(str,blowUp(face)))


