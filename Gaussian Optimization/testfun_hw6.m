function y = testfun_hw6(x,minvalue_noise,cost_noise)
if(nargin<2)
    minvalue_noise = 0; 
    cost_noise = 0;%100;
    snr = 10;
end
x1 = x(1);
x2 = x(2);

y = (x1-30 + randn*minvalue_noise).^2 + cost_noise*randn...
    + sin(x1)+randn +x1-50+...
    + (x2/2-5 + randn*minvalue_noise).^2;
y = awgn(y,snr,'measured');

return