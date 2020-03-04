function [ll, dll]=log_like_with_gradient(logtheta,norm_ys,xs)
% input: log sigf and l, normalied measured y, x, and noise
% output: negative log likelihood, and derivative of log likelihood

    sig_f = exp(logtheta(1));
    l = exp(logtheta(2));
    sn2 = exp(2*logtheta(3));
    
    n = length(norm_ys);
    if(size(norm_ys,1) ~= 1)
        norm_ys = norm_ys';
    end
    
    K = compute_cov(xs,sig_f,l,0);
    
    try
        L = chol(K+sn2*eye(n)); sl =   1;
        if(sn2<1e-6)
            L = chol(K+sn2*eye(n)); sl =   1;
        else
            L = chol(K/sn2+eye(n)); sl = sn2;  
        end
    catch
        ll = 0;
        asf = 0;%-1;
        l = 0;%-1;
        sn = 0;%-1;
        dll = [asf; l; sn];
        return;
    end

    % calculate independent log hyperpriors    
    alpha = L\(L'\norm_ys')/sl; 
    ll = -0.5*norm_ys*alpha - sum(log(diag(L))) - n/2*log(2*pi*sl) ;
    ll = -ll; 

    if(nargout>1)
        Q = L\(L'\eye(n))/sl-alpha*alpha';
        Ksf = compute_cov(xs,sig_f,l,sn2,1);
        Kl = compute_cov(xs,sig_f,l,sn2,2);
        asf = sum(sum(Q.*Ksf))/2;
        l = sum(sum(Q.*Kl))/2;
        sn = sn2*trace(Q);
        dll = [asf; l; sn];
    end
return