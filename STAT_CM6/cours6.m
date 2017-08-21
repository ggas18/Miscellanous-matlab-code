close all
clear all 

x_es=load('esthetique_plantes.csv');
x_pol=load('polution_vs_plantes.csv');
tau=load('taux_de_plomb_savoie.csv');
tau_ev=load('taux_de_plomb_avant_apres.csv');
%% Test sur l'effet des plantes eliminatrices
N_ev=size(tau_ev,1);
D=tau_ev(:,1)-tau_ev(:,2);
% test de normalité
figure();qqplot(D);
mu0=0;
T_ev=(mean(D)-mu0)/(std(D)/sqrt(N_ev));
p_ev=1-cdf('T',T_ev,N_ev-1);
%% Test sur l'effet de l'explication des plantes elimintrices sur les
%  les reponses
N_es=size(x_es,1);
D_es=x_es(:,1)-x_es(:,2);
%test de normalité
figure();qqplot(D_es);
mu_es0=0;
T_es=(mean(D_es)-mu_es0)/(std(D_es)/sqrt(N_es));
p_es=1-cdf('T',T_es,N_es-1);
%% Test par rapport au standard
Tau0=350;
N_tau=size(tau,1);
Z=(mean(tau)-Tau0)/(std(tau)/sqrt(N_tau));
p_tau=cdf('T',Z,N_tau);

%% Regression linéaire
A=corr(x_pol(:,1),x_pol(:,2));
N_re=size(x_pol,1);
X(:,1)=ones(N_re,1);
X(:,2)=x_pol(:,1);
Y=x_pol(:,2);
beta=(X'*X)\(X'*Y);
e= Y-X*beta;
figure();qqplot(e);

