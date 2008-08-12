param nn := 10;
param ncluster := nn;
param nstates := nn;
set cluster := {1 .. ncluster};
set states := {1 .. nstates};

set V := {<s,c> in states*cluster with s >= c} + {<0,0>};
set V_ := V \ ({nstates}*cluster);

set aus[<s,c> in V] := {<s+1,c>,<s+1,c+1>} inter V;
set ein[<s,c> in V] := {<s-1,c>,<s-1,c-1>} inter V;

set A := union <s,c> in V: {<s,c>}*aus[s,c];

#var y[states * cluster] binary;
var y[V] real >=0 <=1;

var f[A] real >= 0;

#y = map (sum . aus) V

subto start:
      y[0,0] == 1;
subto ausf:
      forall <s,c> in V \ ({nstates}*cluster):
      	     sum <s_,c_> in aus[s,c]: f[s,c,s_,c_] == y[s,c];
subto einf:
      forall <s,c> in V \ {<0,0>}:
      	     sum <s_,c_> in ein[s,c]: f[s_,c_,s,c] == y[s,c];
## Erhält die Ganzzahligkeit nicht: #?
subto absteigend:
      forall <c> in cluster with c > 1:
      	     sum <s> in proj(states*{<c>} inter V, <1>) : y[s, c] <=
	     sum <s> in proj(states*{<c>} inter V, <1>): y[s, c-1] ;
subto diag:
     forall <s> in states with s>2:
      	     y[s,s] == y[s-1,s-1];
subto ndiag:
      forall <s,c> in V_ with c>s/2 and c > 1:
      	     forall <sx,cx> in aus[s,c] inter {<s+1,c+1>}:
 	      	     y[s,c] == y[s+1,c+1];


param p[<s,c> in V] := random(-1,1);

maximize s: sum <s,c> in V: p[s,c]*y[s,c];


# subto zeilensumme:
#       forall <s> in states:
#       	     sum <c> in cluster: y[s,c] == 1;
# subto ordered:
#       forall <s,C> in states*cluster with s > 1:
#       	     sum <c> in cluster with c <= C: y[s-1,c] +
# 	     sum <c> in cluster with c >  C: y[s,  c] >= 1;

# subto absteigend:
#       forall <c> in cluster with c > 1:
#       	     sum <s> in states: y[s, c] <=
# 	     sum <s> in states: y[s, c-1] ;
# subto lowerTri:
#       forall <s,c> in states*cluster with s<c:
#       	     y[s,c]==0;

# param p[<s,c> in states*cluster] := random(-10,10);

# maximize s: sum <s,c> in states*cluster: p[s,c]*y[s,c];
