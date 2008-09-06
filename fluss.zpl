param q := 10;
param p := 10;
param hammWeight := 10;
set columns := {1 .. q};
set rows := {1 .. p};
set hammWeights := {1 .. p};

set V_ := {<s,c,h> in rows * columns * hammWeights
    #nur so ueberhaupt erreichbar:
    with  #c <= s and
    	 h*c <= s
};
set V := V_ + {<0,0,hammWeight>};


set A := {<s,c,h,s_,c_,h_> in V * V
      	  with c+1==c_
	  and h >= h_ and h_ == s_ - s
	  };
var f[A] real >= 0 <= infinity;

set aus[<s,c,h>    in V] :=   {<s, c, h>}*V inter A;
set ein[<s_,c_,h_> in V] := V*{<s_,c_,h_>}  inter A;

subto eingang:
      sum <s,c,h,s_, c_, h_> in aus[0,0,hammWeight]: f[s,c,h,s_,c_,h_] == 1;
subto balance:
      forall <sx,cx,hx> in V_ with sx < p:
      	     sum  <s,c,h, s_, c_, h_> in ein[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_] ==
      	     sum  <s,c,h, s_, c_, h_> in aus[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_];

set Y := {<s,c> in rows * columns
    with c <= s};
param m[<s,c> in Y] := random(-10,10);
var y[Y] real >= 0 <= infinity;

subto coupling:
forall <sx,cx> in Y:
       y[sx,cx] == sum <s, c, h, s_, c_, h_> in A
              	   with c+1 == cx
		   and cx == c_
	    	   and s < sx and sx <= s_ :
	   	   f[s, c, h, s_, c_, h_];
maximize s: sum <s,c> in Y: m[s,c]*y[s,c];
