param nn := 15;
param ncluster :=nn;
param nstates := nn;
param hoehe := nn;
set cluster := {1 .. ncluster};
set states := {1 .. nstates};
set hoehen := {1 .. hoehe};

set V_ := {<s,c,h> in states * cluster * hoehen
    #nur so ueberhaupt erreichbar:
    with  #c <= s and
    	 h*c <= s
};
set V := V_ + {<0,0,hoehe>};


set A := {<s,c,h,s_,c_,h_> in V * V
      	  with c+1==c_
	  and h >= h_ and h_ == s_ - s
	  };
var f[A] real >= 0 <= infinity;

set aus[<s,c,h>    in V] :=   {<s, c, h>}*V inter A;
set ein[<s_,c_,h_> in V] := V*{<s_,c_,h_>}  inter A;

subto balance:
      forall <sx,cx,hx> in V_ with sx < nstates:
      	     sum  <s,c,h, s_, c_, h_> in ein[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_] ==
      	     sum  <s,c,h, s_, c_, h_> in aus[sx,cx,hx]:
	     f[s,c,h, s_, c_, h_];

set Y := {<s,c> in states * cluster
    with c <= s};

param pf[<s,c,h,s_,c_,h_> in A] := random(-1,1);
param y[<s,c> in Y] := 0;
##var y[Y] real >= 0 <= infinity;

# [[7 0 0 0 0 0]
#  [7 0 0 0 0 0]
#  [5 2 0 0 0 0]
#  [2 5 0 0 0 0]
#  [0 4 3 0 0 0]
#  [0 2 3 2 0 0]]


#  param y[Y] := 
#     | 1 , 2 , 3 , 4 , 5 , 6 |
#  | 1| 7 , 0 , 0 , 0 , 0 , 0 |
#  | 2| 7 , 0 , 0 , 0 , 0 , 0 |
#  | 3| 5 , 2 , 0 , 0 , 0 , 0 |
#  | 4| 2 , 5 , 0 , 0 , 0 , 0 |
#  | 5| 0 , 4 , 3 , 0 , 0 , 0 |
#  | 6| 0 , 2 , 3 , 2 , 0 , 0 |;

subto eingang:
      sum <s,c,h,s_, c_, h_> in aus[0,0,hoehe]: f[s,c,h,s_,c_,h_] ==
      sum <s,c> in Y with s == 1: y[s,c];

subto coupling:
forall <sx,cx> in Y:
       y[sx,cx] == sum <s, c, h, s_, c_, h_> in A
              	   with c+1 == cx
		   and cx == c_
	    	   and s < sx and sx <= s_ :
	   	   f[s, c, h, s_, c_, h_];
maximize s: sum <s,c,h,s_,c_,h_> in A: pf[s,c,h,s_,c_,h_]*f[s,c,h,s_,c_,h_];
