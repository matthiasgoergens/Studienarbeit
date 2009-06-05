access settings;
if(!settings.multipleView)
 settings.batchView=false;
settings.tex="pdflatex";

// Beginning of Asymptote Figure 1
eval(quote{
defaultfilename='asymptoteTestSimple_1';

size (3cm);
draw (unitcircle);
});
// End of Asymptote Figure 1
