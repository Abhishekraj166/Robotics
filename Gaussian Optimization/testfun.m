function y = testfun(x,minvalue_noise,cost_noise)
if(nargin<2)
    minvalue_noise = 0; 
    cost_noise = 0;
end
%y = (x-200)^2+2*randn;
%y = sin(x)+randn +x-50;
%y = (x-50+randn*0.1).^2+randn*100;
%y = (x-50+randn*1).^2+randn*100;
%y = (x-50+randn*0.1).^2;
y = (x-50 + randn*minvalue_noise).^2 + cost_noise*randn;
%y = sin(x)+cos(x+randn)+randn;
return