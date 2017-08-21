K=0.9;
tr_BO=300*1e-3;%ms8
taux=tr_BO/3;
wn=5/tr_BO;
Ts=30*1e-3;%ms
ksi=1;
%% fonction de transfert du système
%On applique directement la formule du cours pour un système d'ordre1
%
a=1/taux;
A0=K/taux;
Bsys=(A0/a)*(1-exp(-a*Ts));
Asys=[1  exp(-a*Ts)+(A0/a)*(1-exp(-a*Ts))];
%% fonction de transfert derisée
z0=exp(-wn*Ts);
Ad=[1 -2*z0 z0^2];
Bd=[Ts*z0 0]*wn^2;

%% Commande RST
As=[1 0.7723];
Bs=0.7782;
%As=Asys;
%Bs=Bsys;
%
r0=1;
R=r0*[1 -1];
%S
S=[(z0^2+As(2)*r0)/Bs (-2*z0-(As(2)-1))/Bs];
t0=0;
t1=S(1)+S(2)-t0;
T=[t1 t0];