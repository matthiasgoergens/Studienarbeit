#! /usr/bin/python
from pprint import pprint
import numpy as np
import scipy as sp
import scipy.linalg as la
import getopt

def flatten1(m):
    return sum(m, [])

def cross(a,b):
    return [i+j for i in a for j in b]

def reversed(l):
    ll = l[:]
    ll.reverse()
    return ll
#print cross ([[1],[2]],[['a'],['b']])
def part(n,k):
    if n == 0:
        return [[]]
    else:
        return flatten1([cross([[i]],part(n-i,i)) for i in range(min(k, n), 0, -1)])
def flattenTri(A, s):
    return [A[i][0:i+1] for i in range(s)]


def part2array(p):
    Sum = sum(p)
    i = 0
    r = enumerate(p)
    t = (flatten1([S*[c*[0]+[1]+(Sum-c-1)*[0]] for c,S in r]))
    return flatten1(flattenTri(t, Sum))
#    return (flatten1 (t))

def part2square(p):
    Sum = sum(p)
    i = 0
    r = enumerate(p)
    t = (flatten1([S*[c*[0]+[1]+(Sum-c-1)*[0]] for c,S in r]))
#    return flatten1(flattenTri(t, Sum))
    return t

    

def matlabify (r):
    n = size(r)
    return '['+''.join([' '.join(map(str, line))+';\n' for line in r])+']'

def fluss(r):
    l = len(r)
    def down(r):
        return [[r[y][x] and r[y-1][x] for x in range(y)] for y in range(1,l)]
    def downRight(r):
        return [[r[y][x] and r[y-1][x-1] for x in range(1,y+1)] for y in range(1,l)]
    return (flatten1(down(r) + downRight(r)))

def fluesse(N):
    return [fluss(part2square(p)) for p in part(N,N)]
   

def lrsify (r):
    if r[0]:
        n = len(r)
    else:
        n = 1
#    print r
    dim = len(r[0])
    A = '\n'.join([' '.join(map(str, [1]+line)) for line in r])
    return """fnord

V-representation
begin
%(n)s  %(dp)s  integer
%(A)s
end""" % {'n': n, 'dp': dim+1, 'A':A};

import sys
N = int(sys.argv[1])

## Fluss
        
#print lrsify(fluesse (N))

# Partitionen:

def unify(p):
    n = sum(p)
    return p + [0]*(n-len(p))
    
def differ(p):
    from operator import sub
    n = sum(p)
    return map(sub, [n]+p,p+[0])

parts = part(N,N)
#print (lrsify(map(unify, parts)))
#pprint (             map (unify, parts))
#pprint (map (differ, map (unify, parts)))
print lrsify(map (differ, map (unify, parts)))

#print lrsify(reps)

#reps = [part2square(p) for p in part(N,N)]
#print map (reversed, part (N,N))
#pprint (reps)
#pprint (reps)
#print np.matrix(reps)
#print np.rank(np.matrix(reps))
#p,l,u = la.lu(m)
#print "L\n",l
#print "U\n",u
#pprint(reps)
#print reps


#fluss(reps)
#print len(reps)

#print matlabify(reps)
# print "SUM:"
# print (sum(reps))
# while len(reps):
#     print "---------"
#     s = sum(reps)
# # ##    pprint (reps)
# #     print "Sum:\n", s
#     if len([p for p in reps if 1 in (p*s)]) == 0:
#          break
# # #    for p in reps:
# # #        "+++"
# # #        print p
# # #        print p*s
# # #        print "1 in p*s:", (1 in p*s)
# # #    raw_input()
# # #    print "++++"
#     reps = [p for p in reps if 1 not in (p*s)]
# print (sum(reps))
# # pa = part2array


# # print np.rank(s)
# # print s
# # s -=  1 * pa([2,2,1,1])
# # print s
# # #s -= pa([3,2])
