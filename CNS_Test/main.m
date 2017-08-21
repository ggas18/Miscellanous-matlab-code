K=0.9;
tr_BO=300*1e-3;%ms8
taux=tr_BO/3;
wn=5/tr_BO;
Ts=30*1e-3;%ms
ksi=1;
%% fonction de transfert du syst�me
sysCont=tf(K,[taux 1]);
Gz=c2d(sysCont,Ts,'zoh');
%% fonction de transfert deris�e
z0=exp(-wn*Ts);
Ad=[1 -2*z0 z0^2];
Bd=[Ts*z0 0]*wn^2;

%% Commande RST
As=[1 0.7782];
Bs=0.7782;
%
r0=1;
R=r0*[1 -1];
%S
S=[(z0^2+As(2)*r0)/Bs (-2*z0-(As(2)-1))/Bs];
t0=0;
t1=S(1)+S(2)-t0;
T=[t1 t0];