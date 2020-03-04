function parm = initialize(logtheta,logthetastd)
    
    logmu_l = logtheta(2); %mu = mean, l = length
    logstd_l = logthetastd(2); %std = standard deviation
    logmu_sf = logtheta(1);
    logstd_sf = logthetastd(1);
    logmu_sn = logtheta(3);
    logstd_sn = logthetastd(3);
    
    log_sigma_f = logmu_sf;% + 0.5*logstd_sf*randn;
    log_sigma_n = logmu_sn;% + 0.5*logstd_sn*randn; %noise
    log_l = logmu_l;% + 0.5*logstd_l*randn;

    init_sig_f = exp(log_sigma_f);
    init_l = exp(log_l);
    init_noise = exp(log_sigma_n);
    
    parm.prior_thetha_mu = exp([logmu_sf logmu_l logmu_sn]);
    parm.prior_thetha_std = exp([logstd_sf logstd_l logstd_sn]);
    
    xs = [];
    ys = [];
    parm.xs = xs;
    parm.ys = ys;
    parm.theta = [init_sig_f, init_l, init_noise];

return