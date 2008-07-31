param ncluster := 20;
param nstates := 20;
param hoehe := 20;
set cluster := {1 .. ncluster};
set states := {1 .. nstates};
set hoehen := {1 .. hoehe};

set V_ := {<s,c,h> in states * cluster * hoehen
    #nur so ueberhaupt erreichbar:
    with c <= s and
    	 h <= s/c};
set V := V_ + {<0,0,hoehe>};


set A := {<s,c,h,s_,c_,h_> in V * V
      	  with c+1==c_
	  and h >= h_ and h_ == s_ - s
	  };
var f[A] real;

set aus[<s,c,h>    in V] :=   {<s, c, h>}*V inter A;
set ein[<s_,c_,h_> in V] := V*{<s_,c_,h_>}  inter A;

subto eingang:
      sum <s,c,h,s_, c_, h_> in aus[0,0,hoehe]: f[s,c,h,s_,c_,h_] == 1;
subto balance:
      forall <sx,cx,hx> in V_ with sx < nstates:
      	     sum  <s,c,h, s_, c_, h_> in ein[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_] ==
      	     sum  <s,c,h, s_, c_, h_> in aus[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_];

set Y := {<s,c> in states * cluster
    with c <= s};
param p[<s,c> in Y] := random(-10,10);
var y[Y] real >= -infinity <= infinity;

subto coupling:
forall <sx,cx> in Y:
       y[sx,cx] == sum <s, c, h, s_, c_, h_> in A
              	   with c+1 == cx
		   and cx == c_
	    	   and s < sx and sx <= s_ :
	   	   f[s, c, h, s_, c_, h_];
maximize s: sum <s,c> in Y: p[s,c]*y[s,c];
