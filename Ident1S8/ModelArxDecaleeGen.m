%% ENSEM Nancy, INPL 

%% Travaux Pratiques d'identification des systèmes
%  Identification de systèmes linéaired sous matlab
%  Professeur:    DAAFOUZ Jamal
%  Etudiant(s):   GANOU Arouna
%%

close all

%% Données
Donnees;
N=200;
%donnees d'identification
uIdentificationARX=u(1:N);
yIdentificationARX=y(1:N);
%donnees de validation
uValidationARX=u(N+1:end-1);
yValidationARX=y(N+1:end-1);

Fs=10; %en Hz
Ts=1/Fs;
temps=Ts*(0:2*N);% pour commencer à temps t=0
%% Ordre 1 Y(t+1)=-a1*Y(t)+b1*U(t) sans retard
n1d=1;%ordre du modèle
p1d=n1d+1;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y1d=yIdentificationARX(n1d+1:end);
% Affectation de la matrice Phi
Phi1d(:,1)=-yIdentificationARX(1:end-n1d);
Phi1d(:,2)=uIdentificationARX(n1d+1:end);
% Calcul de theta
theta1d=(Phi1d'*Phi1d)\Phi1d'*Y1d;


%% Ordre 2 Y(t)=-a1*Y(t-1)-a2*Y(t-2)+b1*U(t)
n2d=2;%ordre du modèle
p2d=n2d+1;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y2d=yIdentificationARX(n2d+1:end);
% Affectation de la matrice Phi
Phi2d(:,1)=-yIdentificationARX(1:end-n2d);
Phi2d(:,2)=-yIdentificationARX(2:end-n2d+1);
Phi2d(:,4)=uIdentificationARX(n2d:end-1);
Phi2d(:,3)=uIdentificationARX(n2d+1:end);

% Calcul de theta
theta2d=(Phi2d'*Phi2d)\(Phi2d'*Y2d);

%% Ordre 3  Y(t)=-a1*Y(t-1)-a2*Y(t-2)-a3*Y(t-3)+b1*U(t)
n3d=3; %ordre du modèle
p3d=n3d+1;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y3d=yIdentificationARX(n3d+1:end);
% Affectation de la matrice Phi
Phi3d(:,1)=-yIdentificationARX(1:end-n3d);
Phi3d(:,2)=-yIdentificationARX(2:end-n3d+1);
Phi3d(:,3)=-yIdentificationARX(3:end-n3d+2);
Phi3d(:,4)=uIdentificationARX(n3d-1:end-2);
Phi3d(:,5)=uIdentificationARX(n3d:end-1);
Phi3d(:,6)=uIdentificationARX(n3d+1:end);

% Calcul de theta
theta3d=(Phi3d'*Phi3d)\Phi3d'*Y3d;

%% Ordre 4 Y(t)=-a1*Y(t-1)-a2*Y(t-2)-a3*Y(t-3)-a4*Y(t-4)+b1*U(t)
n4d=4; %ordre du modèle
p4d=n4d+1;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y4d=yIdentificationARX(n4d+1:end);
% Affectation de la matrice Phi
Phi4d(:,1)=-yIdentificationARX(1:end-n4d);
Phi4d(:,2)=-yIdentificationARX(2:end-n4d+1);
Phi4d(:,3)=-yIdentificationARX(3:end-n4d+2);
Phi4d(:,4)=-yIdentificationARX(4:end-n4d+3);
Phi4d(:,5)=uIdentificationARX(n4d-2:end-3);
Phi4d(:,6)=uIdentificationARX(n4d-1:end-2);
Phi4d(:,7)=uIdentificationARX(n4d:end-1);
Phi4d(:,8)=uIdentificationARX(n4d+1:end);

% Calcul de theta
theta4d=(Phi4d'*Phi4d)\Phi4d'*Y4d;

%% Systèmes trouvés
sysARXD1=tf(theta1d(end)',[1 theta1d(1:end-1)'],Ts,'Variable','z^-1');
sysARXD2=tf(theta2d(3:end)',[1 theta2d(1:2)'],Ts,'Variable','z^-1');
sysARXD3=tf(theta3d(4:end)',[1 theta3d(1:3)'],Ts,'Variable','z^-1');
sysARXD4=tf(theta4d(5:end)',[1 theta4d(1:4)'],Ts,'Variable','z^-1');

%% Simulation avec les données
%ordre 1
yARXD1=lsim(sysARXD1,u,temps);
%ordre 2
yARXD2=lsim(sysARXD2,u,temps);

%ordre 3
yARXD3=lsim(sysARXD3,u,temps);
%ordre 4
yARXD4=lsim(sysARXD4,u,temps);
%% Les critères

%ordre 1
critArxD11=(1/N)*norm((yIdentificationARX-yARXD1(1:N)),2)^2;
critArxD12=(1/N)*norm((yValidationARX-yARXD1(N+1:2*N)),2)^2;

%ordre 2
critArxD21=(1/N)*norm((yIdentificationARX-yARXD2(1:N)),2)^2;
critArxD22=(1/N)*norm((yValidationARX-yARXD2(N+1:2*N)),2)^2;


%ordre 3
critArxD31=(1/N)*norm((yIdentificationARX-yARXD3(1:N)),2)^2;
critArxD32=(1/N)*norm((yValidationARX-yARXD3(N+1:2*N)),2)^2;

%ordre 1
critArxD41=(1/N)*norm((yIdentificationARX-yARXD4(1:N)),2)^2;
critArxD42=(1/N)*norm((yValidationARX-yARXD4(N+1:2*N)),2)^2;

%% Les profils des reponses
figure();hold on
fId=plot(temps(1:N),yIdentificationARX,'k-');
fVal=plot(temps(N+1:2*N),yValidationARX,'c-');
%ordre 1
f1Id=plot(temps(1:N),yARXD1(1:N),'b:');
f1Val=plot(temps(N+1:2*N),yARXD1(N+1:2*N),'b-');

%ordre 2
f2Id=plot(temps(1:N),yARXD2(1:N),'g:');
f2Val=plot(temps(N+1:2*N),yARXD2(N+1:2*N),'g-');

%ordre 3
f3Id=plot(temps(1:N),yARXD3(1:N),'y:');
f3Val=plot(temps(N+1:2*N),yARXD3(N+1:2*N),'y-');

%ordre 4
f4Id=plot(temps(1:N),yARXD4(1:N),'r:');
f4Val=plot(temps(N+1:2*N),yARXD4(N+1:2*N),'r-');
legend([fId,fVal,f1Id,f1Val,f2Id,f2Val,f3Id,f3Val,f4Id,f4Val],...
       'Sortie Reellle identification',...
       'Sortie Reelle validation',...
       'ordre 1 identification','Ordre 1 validation',...
       'ordre 2 identification','Ordre 2 validation',...
       'ordre 3 identification','Ordre 3 validation',...
       'ordre 4 identification','Ordre 4 validation');
xlabel('temps')
ylabel('Reponses');
title('Modele ARX decale General');
%% Performance en fonction de l'ordre
critId=[critArxD11, critArxD21, critArxD31, critArxD41];
critVal=[critArxD12, critArxD22, critArxD32, critArxD42];
ord=1:4;
figure();plot(ord,critId,'b-',ord,critVal,'g-');
legend('Sur donnees identification', 'Sur donnees validation');
xlabel('ordre');
ylabel('critère');
title('Critère en fonction des ordres')
