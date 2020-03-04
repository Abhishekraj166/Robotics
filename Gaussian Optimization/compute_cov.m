%function K = compute_cov(xs,sig_f,l,noise,ord)
function K = compute_cov(x1,x2,sig_f,l,noise)
    
%     if(nargin < 5)
%         ord = 0;
%     end
    ns = max(size(x1));
    if(size(x1,1)~=1)
        x1 = x1';
    end
    
    ns1 = max(size(x2));
    if(size(x2,1)~=1)
        x2 = x2';
    end
    
    b1 = repmat(x1,ns,1);
    dist1 = (b1-b1')/l;
    sqdist1 = dist1.*dist1;
     
    b2 = repmat(x2,ns1,1);
    dist2 = (b2-b2')/l;
    sqdist2 = dist2.*dist2;
% 
%     if(ord == 0) % no derivative 
 %     K = sig_f^2*exp(-(x1-x2)^2/2*l^2);% + noise*eye(ns);
      K=sig_f^2*exp(-(sqdist1/ 2)+ (sqdist2/2)) +noise*eye(ns);
%     elseif (ord == 1) %derivative to sig_f
%         K = 2*sig_f^2*exp(-sqdist/2);
%     elseif (ord == 2) % derivative to l
%         K = sig_f^2*exp(-sqdist/2).*sqdist;
%     else
%         error('only derivative works');
%     end

return