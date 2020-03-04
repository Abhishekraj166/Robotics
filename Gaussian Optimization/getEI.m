function ei = getEI(best,mu_t,var_t)
    %[mu_t, var_t] = getGPmu_var(x,parm);
    sigma = sqrt(var_t);
    
    % Calculate u
    u = (best - mu_t - 0.01)/sigma;
    try
        ucdf = normcdf(u);
        updf = normpdf(u);
        ei = sigma .* (u .* ucdf + updf); %ucdf = CDF, updf = PDF
    catch
       fprintf('u = %f, best = %f, mut = %f, sigma = %f \n',u,best,mu_t,sigma);
       ei = 1000;
    end

end