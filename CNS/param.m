%% Paramètres intrinsèques du modèle initial
A=[-0.02   1    1
    -0.01 -1    0
     0     1    0];
B=[1.6;0.23;0];
Couv=eye(3);
D=zeros(3,1);
vpOuv=eig(A);

%% commandabilté
Co=ctrb(A,B);
n=rank(Co);


%% Systeme augmenté
C=[1 0 0];
Ae=[ A zeros(3,1)
     C zeros(1,1)];
Be=[B;zeros(1)];
Ci=eye(3);
Ce=[C zeros(1)];
De=zeros(1);
ComE=ctrb(Ae,Be);


%% Cahier des charges
Ksi=0.7;
w0=1;
tr=3;
p1=w0*(-Ksi+1i*sqrt(1-Ksi^2));
p2=w0*(-Ksi-1i*sqrt(1-Ksi^2));
p3=10*real(p1);
p4=11*real(p1);
p=[p1 p2 p3 p4];
K=place(Ae,Be,p);

K1=K(1:3);
Ks=K(4);
sys=ss(Ae,Be,Ce,De);


%% Commande LQR
Q=diag([1,1,1,10]);
R=1;
[Klqr,~,~] = lqr(sys,Q,R,0);

K1lqr=Klqr(1:3);
Kslqr=Klqr(4);


%% simulation du modèle simulink
% simOut = sim('modFer','SimulationMode','normal','AbsTol','1e-5',...
%             'SaveState','on','StateSaveName','xout',...
%             'SaveOutput','on','OutputSaveName','yout',...
%  'SaveFormat', 'Dataset');
% outputs = simOut.get('yout')
