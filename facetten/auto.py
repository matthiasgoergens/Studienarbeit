from os import system


for n in range(1,13):
    s = ("../dreiecksmatrix/repre.py %(n)s | ./lrs > exts/%(n)sd.ext &" % {'n': n})
    print s
    system(s)

