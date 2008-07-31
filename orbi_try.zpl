param ncluster := 10;
param nstates := 10;
set cluster := {1 .. ncluster};
set states := {1 .. nstates};

#var y[states * cluster] binary;
var y[states * cluster] real >=0 <=1;

subto zeilensumme:
      forall <s> in states:
      	     sum <c> in cluster: y[s,c] == 1;
subto ordered:
      forall <s,C> in states*cluster with s > 1:
      	     sum <c> in cluster with c <= C: y[s-1,c] +
	     sum <c> in cluster with c >  C: y[s,  c] >= 1;

subto absteigend:
      forall <c> in cluster with c > 1:
      	     sum <s> in states: y[s, c] <=
	     sum <s> in states: y[s, c-1] ;
subto lowerTri:
      forall <s,c> in states*cluster with s<c:
      	     y[s,c]==0;

param p[<s,c> in states*cluster] := random(-10,10);

maximize s: sum <s,c> in states*cluster: p[s,c]*y[s,c];
