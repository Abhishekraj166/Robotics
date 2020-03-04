




function y = kernel(xs1,xs2,x,sigf,l)
   %Complete this part
    %y = sig_f.^2*exp(-(x1-x).*(x1-x)/ (2*l^2)) ;
    y=sigf.^2*exp(-((xs1-x).*(xs1-x)/ (2*l^2))+((xs2-x).*(xs2-x)/ (2*l^2))) ;
return