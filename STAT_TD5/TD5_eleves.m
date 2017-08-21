close all
clear all
clc


A=load('ExoAzote.csv');
y=A(:,5);
%----------------------------------------------
%Question 1
%Analyse descriptive des donnees
%plotmatrix(A,'*')
corA=corr(A); %matrice des correlations

%----------------------------------------------

%----------------------------------------------
%Question 2
%% Modèle 0

X0=[ones(size(A,1),1),A(:,1:4)];
 

[b, R2a, pvalue_f, pvalue_t,T]=RLM_eleves(X0,y);
%% premiere itération modele Ag Fo Co

X1=[ones(size(A,1),1),A(:,1:2),A(:,4)];

[b1, R2a1, pvalue_f1, pvalue_t1,T1]=RLM_eleves(X1,y);

%% deuxième itération Fo Co
X2=[ones(size(A,1),1),A(:,2),A(:,4)];

[b2, R2a2, pvalue_f2, pvalue_t2,T2]=RLM_eleves(X2,y);