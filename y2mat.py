#! /usr/bin/python

from pprint import pprint

s = """y#1#1                                               1 	(obj:0.097627)
y#2#1                                               1 	(obj:0.185689)
y#3#1                                               1 	(obj:0.688531)
y#4#1                                            0.55 	(obj:0.0897664)
y#4#2                                            0.45 	(obj:0.694503)
y#5#1                                            0.55 	(obj:0.291788)
y#5#2                                            0.45 	(obj:-0.231237)
y#6#2                                               1 	(obj:0.927326)
y#7#2                                             0.6 	(obj:0.0577898)
y#7#3                                             0.4 	(obj:-0.0400457)
y#8#2                                             0.6 	(obj:-0.325208)
y#8#4                                             0.4 	(obj:0.296344)
y#9#3                                             0.6 	(obj:0.740024)
y#9#4                                             0.4 	(obj:0.740175)
y#10#3                                            0.6 	(obj:0.357759)
y#10#4                                            0.1 	(obj:-0.763451)
y#10#5                                            0.3 	(obj:0.441265)
y#11#4                                            0.7 	(obj:-0.170676)
y#11#5                                            0.3 	(obj:-0.0527992)
y#12#5                                              1 	(obj:0.235271)
y#13#6                                              1 	(obj:0.804697)
y#14#6                                            0.5 	(obj:-0.369143)
y#14#7                                            0.5 	(obj:0.215661)
y#15#7                                              1 	(obj:0.990599)
y#0#0                                               1 	(obj:-0.682061)
"""

def lines():
    while True:
        try:
            line = raw_input()
            if line:
                yield line
        except EOFError, e:
            return

def xy(lines):
    for line in lines:
#        print line
        ypart, val, _ = line.split()
        _,y,x = ypart.split('#')
        if (x,y) != ("0","0"):
            yield (int(x), int(y)), 100*float(val)


d = dict(list(xy(filter(None, lines()))))

#pprint (d)

def maxXY (d):
    xs, ys = zip(*d.keys())
    return max(xs), max(ys)
def prettyStr(d):
    mx, my = maxXY(d)
    return ''.join([''.join(["%3.0f" % d.get((j,i), 0) + " " for j in range(1,mx+1)])
                    + '\n' for i in range(1,my+1)])

print prettyStr(d)
