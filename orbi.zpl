param nn := 100;
param ncluster := nn;
param nstates := nn;
set cluster := {1 .. ncluster};
set states := {1 .. nstates};

set V := {<s,c> in states*cluster};# with s >= c};# + {<0,0>};
#set V_ := V \ ({nstates}*cluster);

set down := {<s,c,s_,c_> in V*V
    	      with s + 1 == s_ 
    	      and c == c_};
set downRight := {<s,c,s_,c_> in V*V
    	      with s + 1 == s_ 
    	      and c + 1 == c_};

set ausD [<s,c> in V] := {<s+1,c>} inter V;
set ausDR[<s,c> in V] := {<s+1,c+1>} inter V;

set einD[<s,c> in V] := {<s-1,c>} inter V;
set einDR[<s,c> in V] := {<s-1,c-1>} inter V;

set aus[<s,c> in V] := ausD[s,c] + ausDR[s,c]; #{<s+1,c>,<s+1,c+1>} inter V;
set ein[<s,c> in V] := einD[s,c] + einDR[s,c]; #{<s-1,c>,<s-1,c-1>} inter V;

set row[<s> in states] := {<s_,c> in V with s==s_};

set top[<s,c> in V] := {<s_, c_> in V
    	      	        with 1 < s_
			and s_ <= s
			and  c_ == c};


set A := union <s,c> in V: {<s,c>}*aus[s,c];

#var y[states * cluster] binary;
var y[V] real >=0 <=1;

var f[A] real >= 0;

#y = map (sum . aus) V

#subto start:
#      y[0,0] == 1;

subto lines:
      forall <s> in states:
      	     sum <s_,c> in row[s]: y[s_,c] == 1;
subto down:
      forall <s,c,s_,c_> in down:
      	     f[s,c,s_,c_] ==
      	     - sum <cx> in cluster with 1<=cx and cx<  c: y[s,cx]
	     + sum <cx> in cluster with 1<=cx and cx<= c_ : y[s_, cx];
subto downRight:
      forall <s,c,s_,c_> in downRight:
      	     f[s,c,s_,c_] ==
      	     + sum <cx> in cluster with 1<=cx and cx<= c: y[s,cx]
	     - sum <cx> in cluster with 1<=cx and cx< c_: y[s_, cx];
subto absteigend:
      forall <S,C,S_,C_> in downRight:
      	     sum <sT,cT> in top[S,C] with cT>C: f[sT-1, cT, sT, cT] >=
      	     sum <sT,cT> in top[S_,C_]: f[sT-1, cT, sT, cT];
      	   	     	 
      	     
#subto ausf:
#      forall <s,c> in V \ ({nstates}*cluster):
#      	     sum <s_,c_> in aus[s,c]: f[s,c,s_,c_] == y[s,c];
#subto einf:
#      forall <s,c> in V \ {<0,0>}:
#      	     sum <s_,c_> in ein[s,c]: f[s_,c_,s,c] == y[s,c];
## Erhält die Ganzzahligkeit nicht: #?
#subto absteigend:
#      forall <c> in cluster with c > 1:
#      	     sum <s> in proj(states*{<c>} inter V, <1>) : y[s, c] <=
#	     sum <s> in proj(states*{<c>} inter V, <1>): y[s, c-1] ;
#subto diag:
#     forall <s> in states with s>2:
#      	     y[s,s] == y[s-1,s-1];
#subto ndiag:
#      forall <s,c> in V_ with c>s/2 and c > 1:
#      	     forall <sx,cx> in aus[s,c] inter {<s+1,c+1>}:
# 	      	     y[s,c] == y[s+1,c+1];


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
