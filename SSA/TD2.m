clear all
clc
%% Filtre de Wiener
load('homermesure.mat');
M=8;
x=y2;
y=y1;
mu_y=mean(y);
y=y-mean(y);
%Les moyennes
% Les variances
X=const(x,M);
mu_X=mean(transpose(X))';
Y=const(y,M);
N=size(X,2);
x1_hat=zeros(1,N);
x=x-mean(x);
X=const(x,M);
[VarXX,~]=covarergstat2(X,0,1,M);
for j=1:N
[~,VarYX]=covarergstat2(X,y(j),j,M);
beta=VarYX*(VarXX)^(-1);
x1_hat(j)=beta*(X(:,j)-mu_X)+mu_y;
end
