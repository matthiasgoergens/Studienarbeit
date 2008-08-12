param m := 6;
set N := {1 .. m};
#param t :=  5;
#set T := {1 .. t};

var y[N] real >= 0 <= 1;

set triple := {<a,b,c> in N*N*N with a<b and b<c};
set quintuple := {<a,b,c,d,e> in N*N*N*N*N with a<b and b<c and c<d and d<e };
#set stuple := {<a,b,c,d,e,f,g> in N*N*N*N*N*N*N with a<b and b<c and c<d and d<e and e<f and f<g};
#set ntuple := {<a,b,c,d,e,f,g,h,i> in N*N*N*N*N*N*N*N*N with a<b and b<c and c<d and d<e and e<f and f<g and g<h and h<i};

#do print triple;

subto kamel:
forall <a,b,c> in triple:
       y[a] -y[b] + y[c] <= 1;
subto kamel5:
forall <a,b,c,d,e> in quintuple:
       y[a] -y[b] + y[c] - y[d] + y[e] <= 1;
#subto kamel7:
#forall <a,b,c,d,e,f,g> in stuple:
#       y[a] -y[b] + y[c] - y[d] + y[e] - y[f] + y[g] <= 1;
#subto kamel9:
#forall <a,b,c,d,e,f,g,h,i> in ntuple:
#       y[a] -y[b] + y[c] - y[d] + y[e] - y[f] + y[g] - y[h] + y[i] <= 1;


#subto kamel2:
#forall <a,b,c> in triple:
#       y[a] + y[c] <= 2*y[b];

#param p[<i> in N] := -(-1 ** i);
param p[<i> in N] := random(-1, 1);
#param p[N] := <1> 1, <2> -1, <3> 1, <4> -1, <5> 1, <6> -1, <7> 1, <8>;

maximize profit: sum <i> in N: y[i]*p[i];
