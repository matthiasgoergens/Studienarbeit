param m := 50;
set N := {1 .. m};
set H := {-1,0,1};

set V := N*H;
set V_ := N*H \ {<1,-1>, <m, 1>};
do print V;

#set L[<i> in N] := {<j> in N with j < i};
#set R[<i> in N] := {<j> in N with     i < j};

set aus[<n,h> in V] := {<n+1,h>, <n,h+1>} inter V;
set ein[<n,h> in V] := {<n-1,h>, <n,h-1>} inter V;

set A := union <n,h> in V: {<n,h>} * aus[n,h];

var x[N] real;
var f[A] real;

subto eingang:
      sum <n,h> in aus[1,-1]: f[1,-1,n,h] == 1;
subto balance:
      forall <n,h> in V_:
      	     sum  <n_,h_> in ein[n,h]:
	     f[n_,h_,n,h] ==
      	     sum  <n_,h_> in aus[n,h]:
	     f[n,h,n_,h_];
subto coupling:
      forall <n> in N:
      	     sum <n_,h_> in ein[n,0]: f[n_,h_,n,0] == x[n];

param p[<i> in N] := random(-10, 10);

maximize profit: sum <i> in N: x[i]*p[i];
