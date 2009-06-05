access settings;
if(!settings.multipleView)
 settings.batchView=false;
settings.tex="pdflatex";

// Beginning of Asymptote Figure 1
eval(quote{
defaultfilename='asymptoteTest_1';

// Global Asymptote definitions can be put here.
usepackage("bm");
texpreamble("\def\v#1{\bm{#1}}");

size(4cm,0);
pen colour1=red;
pen colour2=green;

pair z0=(0,0);
pair z1=(-1,0);
pair z2=(1,0);
real r=1.5;
path c1=circle(z1,r);
path c2=circle(z2,r);
fill(c1,colour1);
fill(c2,colour2);

picture intersection=new picture;
fill(intersection,c1,colour1+colour2);
clip(intersection,c2);

add(intersection);

draw(c1);
draw(c2);

//draw("$\A$",box,z1);              // Requires [inline] package option.
//draw(Label("$\B$","$B$"),box,z2); // Requires [inline] package option.
draw("$A$",box,z1);
draw("$\v{B}$",box,z2);

pair z=(0,-2);
real m=3;
margin BigMargin=Margin(0,m*dot(unit(z1-z),unit(z0-z)));

draw(Label("$A\cap B$",0),conj(z)--z0,Arrow,BigMargin);
draw(Label("$A\cup B$",0),z--z0,Arrow,BigMargin);
draw(z--z1,Arrow,Margin(0,m));
draw(z--z2,Arrow,Margin(0,m));

shipout(bbox(0.25cm));
});
// End of Asymptote Figure 1

// Beginning of Asymptote Figure 2
eval(quote{
defaultfilename='asymptoteTest_2';
size(0,4cm);

// Global Asymptote definitions can be put here.
usepackage("bm");
texpreamble("\def\v#1{\bm{#1}}");


import three;
//settings.render=8;

draw(unitcube,blue);
label("$V-E+F=2$",(0,1,0.5),3Y,blue+fontsize(20));
});
// End of Asymptote Figure 2

// Beginning of Asymptote Figure 3
eval(quote{
defaultfilename='asymptoteTest_3';
size(390.0pt);

// Global Asymptote definitions can be put here.
usepackage("bm");
texpreamble("\def\v#1{\bm{#1}}");


pair z0=(0,0);
pair z1=(2,0);
pair z2=(5,0);
pair zf=z1+0.75*(z2-z1);

draw(z1--z2);
dot(z1,red+0.15cm);
dot(z2,darkgreen+0.3cm);
label("$m$",z1,1.2N,red);
label("$M$",z2,1.5N,darkgreen);
label("$\hat{\ }$",zf,0.2*S,fontsize(24)+blue);

pair s=-0.2*I;
draw("$x$",z0+s--z1+s,N,red,Arrows,Bars,PenMargins);
s=-0.5*I;
draw("$\bar{x}$",z0+s--zf+s,blue,Arrows,Bars,PenMargins);
s=-0.95*I;
draw("$X$",z0+s--z2+s,darkgreen,Arrows,Bars,PenMargins);
});
// End of Asymptote Figure 3
