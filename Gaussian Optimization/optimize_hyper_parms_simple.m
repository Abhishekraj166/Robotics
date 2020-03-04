function [theta, best_ll]= optimize_hyper_parms_simple(parm,norm_ys)
    options = optimoptions('fmincon','GradObj','on','Display','off','MaxFunEvals',3000,...
        'ObjectiveLimit',0,'TolX',10^-8,'TolFun',10^-8,'DiffMaxChange',10000);
    option2 = optimset('Display','off','MaxIter',1000,'TolX',10^-10,'TolFun',10^-10);

    trainparm = parm; train_norm_ys = norm_ys;
    logth0 = log(parm.theta);
    xs = trainparm.xs;
    init_ll = log_like_with_gradient(logth0,norm_ys,xs);%,trainparm.prior_thetha_mu, trainparm.prior_thetha_std);
    log_th_init = logth0;
    logpmax = log([ones(1,2)*trainparm.p_bounds(2) trainparm.sn_bound(2)]);
    logpmin = log([ones(1,2)*trainparm.p_bounds(1) trainparm.sn_bound(1)]);

    [logtheta_opt,fval,exitflag,output,grad,hessian] = fmincon(@(logth)log_like_with_gradient(logth,train_norm_ys,xs),log_th_init,...
           [], [], [], [], logpmin, logpmax,[],option2);

    theta = exp(logtheta_opt);
    best_ll = fval;   
   
    fprintf('best_post = %f, %f  best_log = %f,  initial log = %f \n',theta(1),theta(2),best_ll,init_ll);
   
return


