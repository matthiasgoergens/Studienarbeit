from os import system

name = 'simple'

for n in range(1,13):
	s = ("../dreiecksmatrix/repre.py %(n)s | ./lrs > exts/%(name)s%(n)s.ext" % {'n': n, 'name':name})
	print s
	system(s)

