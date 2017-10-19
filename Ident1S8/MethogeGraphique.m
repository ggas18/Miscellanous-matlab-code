%% Travaux Pratiques d'identification des systèmes
%  Identification de systèmes linéaired sous matlab
%  Professeur: DAAFOUZ Jamal
%  Etudiant(s):   GANOU Arouna

%%
close all

%% TP1 SEANCE  1
Donnees
uIdentification=u(1:200);
yIdentification=y(1:200);
N=200;

%% Modele d'ordre 1

% recherche de taux
K1=yIdentification(200)/uIdentification(200);
fe=10;% en Hz
te=1/fe;
taux=(130-100)*te;

%% Modele d'ordre 2

K2=yIdentification(200)/uIdentification(200);
dY=yIdentification(2:200)- yIdentification(1:199);
%plot(yModele,x)
ti=114;
si=0.63/max(yIdentification);
xi=0.05;
T2=(xi-1)/log(xi);
T1=T2/xi;
%% Validation
%donnees de validation
uValidation=u(201:400);
yValidation=y(201:400);
%systeme du premier ordre trouvé
num1=K1;
dem1=[taux 1];
sys1erord1=tf(num1,dem1);
%systeme du deuxieme ordre trouvé
num2=K2;
dem2=[T1*T2 (T1+T2) 1];
sys1erord2=tf(num2,dem2);
%temps
temps=te*(0:N-1)';

%criteres systeme d'ordre 1
yChapeau11=lsim(sys1erord1,uIdentification,temps);
yChapeau12=lsim(sys1erord1,uValidation,temps);
Critere11=(1/N)*norm((yIdentification-yChapeau11),2)^2;
Critere12=(1/N)*norm((yValidation-yChapeau12),2)^2;

%criteres systeme d'ordre 2
yChapeau21=lsim(sys1erord2,uIdentification,temps);
yChapeau22=lsim(sys1erord2,uValidation,temps);
Critere21=(1/N)*norm((yIdentification-yChapeau21),2)^2;
Critere22=(1/N)*norm((yValidation-yChapeau22),2)^2;

%% Stockage des critères
% Tous les critères sont dans ce tableau
%Première ligne les critères pour le premier ordre
%Deuxième ligne pour les critèred du deuxième ordre
%Première colone pour la première partie des donnees
%Deuxième colonne pour la deuxième partie des données
%Critere=zeros(size(Critere11),size(Critere12),size(Critere21),size(Critere22));
Critere=[Critere11 Critere12
        Critere21  Critere22];
%% Figures pour le tableau des validations croisées
figure()
pIdentenfication=plot(temps,yIdentification, 'g');
hold on
pValidation=plot(temps,yValidation,'y');
pOrdre11=plot(temps,yChapeau11, 'r*');
pOrdre12=plot(temps,yChapeau12, 'r-');
pOrdre21=plot(temps,yChapeau21, 'b*');
pOrdre22=plot(temps,yChapeau22, 'b');
legend([pIdentenfication, pValidation, pOrdre11, pOrdre12, pOrdre21, pOrdre22],...
        'Donnée Identification',...
        'Donnée Validation',...
        'Ordre1 Identification','Ordre1 Validation',...
        'Ordre2 Identification','Ordre2 Validation')
xlabel('Temps')
ylabel('Reponses')
title('Les 4 reponses')
%% Simulation avec la totalité des données 

[nTotEchan,~]=size(u);
tempsTotal=te*(0:nTotEchan-1);% pour commencer à temps t=0
yChapeauOrdre1=lsim(sys1erord1,u,tempsTotal);
yChapeauOrdre2=lsim(sys1erord2,u,tempsTotal);

%% Figure pour la validation avec les toutes les données

figure();
pDonneeTotale=plot(tempsTotal,y,'g');
hold on
pOrdre1=plot(tempsTotal,yChapeauOrdre1,'r');
pOrdre2=plot(tempsTotal,yChapeauOrdre2,'b');
legend([pDonneeTotale,pOrdre1,pOrdre2],...
    'Données','Simulation ordre1','Simulation Ordre2');
xlabel('temps');
ylabel('Reponses aux simulations');



