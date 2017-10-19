%% ENSEM Nancy, INPL 

%% Travaux Pratiques d'identification des systèmes
%  Identification de systèmes linéaires sous matlab
%  Professeur: DAAFOUZ Jamal
%  Etudiant(s):   GANOU Arouna


%% 

close all

%% Données
Donnees
N=200;
%donnees d'identification
uIdentification=u(1:N);
yIdentification=y(1:N);
%donnees de validation
uValidation=u(N+1:end-1);
yValidation=y(N+1:end-1);

Hs=10; %en Hz
Ts=1/Hs;
tempsId=Ts*(0:N-1);% pour commencer à temps t=0
tempsVal=Ts*(0:(max(size(u)-N-2)));
%% Ordre 1 Y(t+1)=-a1*Y(t)+b1*U(t) sans retard

p1=2;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y1=yIdentification;
% Affectation de la matrice Phi
Phi1(:,1)=[0; -Y1(1:N-1)];
Phi1(:,2)=uIdentification(1:N);
% Calcul de theta
theta1=(Phi1'*Phi1)\Phi1'*Y1;


%% Ordre 2 Y(t)=-a1*Y(t-1)-a2*Y(t-2)+b1*U(t)

p2=3;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y2=yIdentification;
% Affectation de la matrice Phi
Phi2(:,1)=[0;0;-Y2(1:N-2)];
Phi2(:,2)=[0;-Y2(1:N-1)];
Phi2(:,3)=uIdentification(1:N);
% Calcul de theta
theta2=(Phi2'*Phi2)\(Phi2'*Y2);

%% Ordre 3  Y(t)=-a1*Y(t-1)-a2*Y(t-2)-a3*Y(t-3)+b1*U(t)
p3=4;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y3=yIdentification;
% Affectation de la matrice Phi
Phi3(:,1)=[0;0;0;-Y3(1:N-3)];
Phi3(:,2)=[0;0;-Y3(1:N-2)];
Phi3(:,3)=[0;-Y3(1:N-1)];
Phi3(:,4)=uIdentification(1:N);
% Calcul de theta
theta3=(Phi3'*Phi3)\Phi3'*Y3;

%% Ordre 3  Y(t)=-a1*Y(t-1)-a2*Y(t-2)-a3*Y(t-3)-a4*Y(t-4)+b1*U(t)
p4=5;% Nombre de paramètre à identifier.
% Dimensionnement des matrices
%  theta=zeros(p,1);
%  Y=zeros(N,1);
%  Phi=zeros(N,p);
%Affectation de Y
Y4=yIdentification;
% Affectation de la matrice Phi
Phi4(:,1)=[0;0;0;0;-Y4(1:N-4)];
Phi4(:,2)=[0;0;0;-Y4(1:N-3)];
Phi4(:,3)=[0;0;-Y4(1:N-2)];
Phi4(:,4)=[0;-Y4(1:N-1)];
Phi4(:,5)=uIdentification(1:N);
% Calcul de theta
theta4=(Phi4'*Phi4)\Phi4'*Y4;

%% Systèmes trouvés
sysARX1=tf(theta1(end),[1 theta1(1:end-1)'],Ts,'Variable','z^-1');
sysARX2=tf(theta2(end),[1 theta2(1:end-1)'],Ts,'Variable','z^-1');
sysARX3=tf(theta3(end),[1 theta3(1:end-1)'],Ts,'Variable','z^-1');
sysARX4=tf(theta4(end),[1 theta4(1:end-1)'],Ts,'Variable','z^-1');

%% Simulation avec les données

%ordre 1
yARX11=lsim(sysARX1,uIdentification,tempsId);%donnee identification
yARX12=lsim(sysARX1,uValidation,tempsVal);%donnee validation

%ordre 2
yARX21=lsim(sysARX2,uIdentification,tempsId);%donnee identification
yARX22=lsim(sysARX2,uValidation,tempsVal);%donnee validation

%ordre 3
yARX31=lsim(sysARX3,uIdentification,tempsId);%donnee identification
yARX32=lsim(sysARX3,uValidation,tempsVal);%donnee validation

%ordre 4
yARX41=lsim(sysARX4,uIdentification,tempsId);%donnee identification
yARX42=lsim(sysARX4,uValidation,tempsVal);%donnee validation

%% Calcul des critères

%ordre 1
critArx11=(1/N)*norm((yIdentification-yARX11),2)^2;
critArx12=(1/N)*norm((yValidation-yARX12),2)^2;

%ordre 2
critArx21=(1/N)*norm((yIdentification-yARX21),2)^2;
critArx22=(1/N)*norm((yValidation-yARX22),2)^2;

%ordre 3
critArx31=(1/N)*norm((yIdentification-yARX31),2)^2;
critArx32=(1/N)*norm((yValidation-yARX32),2)^2;

%ordre 1
critArx41=(1/N)*norm((yIdentification-yARX41),2)^2;
critArx42=(1/N)*norm((yValidation-yARX42),2)^2;

%% Les profils des reponses
figure();hold on
fId=plot(tempsId,yIdentification,'c-');
fVal=plot(tempsVal,yValidation,'c-');
%ordre 1
f1Id=plot(tempsId,yARX11,'b:');
f1Val=plot(tempsVal,yARX12,'b-');

%ordre 2
f2Id=plot(tempsId,yARX21,'g:');
f2Val=plot(tempsVal,yARX22,'g-');

%ordre 3
f3Id=plot(tempsId,yARX31,'y:');
f3Val=plot(tempsVal,yARX32,'y-');

%ordre 4
f4Id=plot(tempsId,yARX41,'r:');
f4Val=plot(tempsVal,yARX42,'r-');
legend([fId,fVal,f1Id,f1Val,f2Id,f2Val,f3Id,f3Val,f4Id,f4Val],...
       'Données identification',...
       'Données validation',...
       'ordre 1 identification','Ordre 1 validation',...
       'ordre 2 identification','Ordre 2 validation',...
       'ordre 3 identification','Ordre 3 validation',...
       'ordre 4 identification','Ordre 4 validation');

xlabel('temps');
ylabel('Reponses');
title('Modele ARX sans decalage');
