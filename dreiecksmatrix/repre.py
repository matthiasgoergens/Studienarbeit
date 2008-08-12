#! /usr/bin/python
from pprint import pprint
import numpy as np
import scipy as sp
import scipy.linalg as la

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
        
def part2array(p):
    Sum = sum(p)
    i = 0
    r = enumerate(p)
    
    return (flatten1 (flatten1([S*[c*[0]+[1]+(Sum-c-1)*[0]] for c,S in r])))

def matlabify (r):
    return '['+''.join([' '.join(map(str, line))+';\n' for line in r])+']'

N = 10
reps = [part2array(reversed(p)) for p in part(N,N)]
#pprint (reps)
#pprint (reps)
#print np.matrix(reps)
#print np.rank(np.matrix(reps))
#p,l,u = la.lu(m)
#print "L\n",l
#print "U\n",u
#pprint(reps)
print matlabify(reps)
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
