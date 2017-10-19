clear all
close all

%% Chargement des données

%donnée 1
Dat1
u1=u;
y1=y;
N=size(u,1)/2;

%% Partition des données

uIdentification=u(1:N);
yIdentification=y(1:N);

uValidation=u(N+1:end-2000);
yValidation=y(N+1:end-2000);


