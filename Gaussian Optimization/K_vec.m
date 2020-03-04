


%function Kv = K_vec(xs,x,sig_f,l)
function Kv = K_vec(x1,x2,x,sig_f,l)
    ns = length(x1);
    Kv = zeros(ns,1);
    for i=1:ns
       % Kv(i) = kernel(xs(i),x , sig_f,l); %Complete this part  - kernel(x1,x2,sig_f,l)
       Kv(i) = kernel(x1(i),x2(i) ,x, sig_f,l);
    end
    
return