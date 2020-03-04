% a)
clc;
clear all;
P1=randi([-10,40],20,1)
P2=randi([-10,40],20,1)
for i=1:20
    x1=P1(i,1);
    z2=P2(i,1);
    x=[x1 z2]
    M=testfun_hw6(x)
    D(i,:)=[x1 z2 M];
end
scatter3(D(:,1),D(:,2),D(:,3))

%% b)
