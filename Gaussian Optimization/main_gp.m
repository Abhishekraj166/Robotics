%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% ME594 Class material
% Gaussian process regression exercise
% By Myunghee Kim
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% test optimization
plot_flag = 1; video_flag = 0;

% initialize parameters
logtheta = log([1500 5 0.1]);
logthetastd = log([100 10 3]);
sn_bound = [0.1 100];
p_bounds = [20 1000];
parm = initialize(logtheta,logthetastd);
parm.sn_bound = sn_bound;
parm.p_bounds = p_bounds;
%============
% provide 3 data points first
%xval = [30 50 90];
c1=randi([-10,40],20,1)
c2=randi([-10,40],20,1)
for i=1:20
    xs1=c1(i,1);
    xs2=c2(i,1);
    x=[xs1 xs2]
    Data=testfun_hw6(x)
    D(i,:)=[xs1 xs2 Data];
end
%scatter3(D(:,1),D(:,2),D(:,3))
xs1=D(:,1);
xs2=D(:,2);
ys=D(:,3);
parm.x1 = xs1;
parm.x2=xs2;
parm.ys = ys;
parm.best_x1 = xs1(end);
parm.best_x2 = xs2(end);
parm.besty = ys(end);
if(plot_flag)
    hold on;
    color_green = [0 0 100]/256;
   % htrace=scatter3(R(:,1),R(:,2),R(:,3));title('plot 20 points')
   % htrace=scatter3(x1,x2,ys);title('plot 20 points')
    %htrace = plot(x1,x2,ys,'ko');
    %set(htrace,'MarkerFaceColor',0.5*[1 1 1]);
    
    %hocurrent = scatter3(parm.best_x1,parm.best_x2,parm.besty,'o');
    %set(hocurrent,'MarkerFaceColor',color_green,'MarkerEdgeColor',color_green);
end


%--------------------
% check prediction results using best estimated parameters
parm.norm_y = ys - mean(ys);
parm.xnew = 0:5:100;
for i=1:length(parm.xnew)
%for i=1:length(parm.xnew)
    
  [gpmean(i) gpvar(i)]= getGPmu_var(parm.xnew(i),parm);
end
gpmean = gpmean+mean(ys);
gpmean_opt=gpmean
gpvar_opt=gpvar

%-------------------
% Optimize hyper parameters
[theta, best_ll]= optimize_hyper_parms_simple(parm,parm.norm_y);
parm_opt = parm;
parm_opt.theta = theta; 
%%
%----------------
% Get new GP vals
for i=1:length(parm.xnew)
 [gpmean_opt(i) gpvar_opt(i)]= getGPmu_var(parm_opt.xnew(i),parm_opt);
end
gpmean_opt = gpmean_opt+mean(yval);

%%
% Visualize results
parm.x_min = min(parm.xnew);
parm.x_max = max(parm.xnew);
x = parm.xnew;
C = 0.7*[1 1 1];
figure;
subplot(2,1,1)
hold on;
y1 = sqrt(gpvar)+gpmean;
y2 = -sqrt(gpvar)+gpmean;
h = fill([x fliplr(x)],[y1 fliplr(y2)],C);
set(h,'edgecolor','white');
plot(parm.xnew,gpmean,'b-');
plot(xval,yval,'r*');
xlim([parm.x_min parm.x_max]);
xlabel('x');
ylabel('Posterior distribution');
box off;

subplot(2,1,2)
hold on;
x = parm.xnew;
y1 = sqrt(gpvar_opt)+gpmean_opt;
y2 = -sqrt(gpvar_opt)+gpmean_opt;
h = fill([x fliplr(x)],[y1 fliplr(y2)],C);
set(h,'edgecolor','white');
plot(parm.xnew,gpmean_opt,'b-');
plot(xval,yval,'r*');
xlim([parm.x_min parm.x_max]);
xlabel('x');
ylabel('Posterior distribution');
box off;
