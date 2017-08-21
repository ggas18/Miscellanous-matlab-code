clear
%% Parametres du probleme
alpha=1;
%% Etude de la precision

%% Traitement de la variable temporelle
tc=1;
dt=1e-2;
nt=1+tc/dt;


%% Donnees utiles pour la solution analytique
t=0:dt:tc;
k=2*(1:nt)+1;
alpK=k*pi;
Kk=-4./alpK.^3;
mKk=diag(Kk,0);

%% Calcul de la norme pour chaque solution avec un pas consideré
%On choisit des pas d'espace
NbPas=10;
puiss=-NbPas:-2;
% On choisit une discretisation de l'espace de temps en 
% puissance entière negative de 10
pas=power(2,puiss);

NormErrExp=[];
NormErrImp=[];
NormErrSem=[];

for k=1:NbPas-1
dx=pas(k);
%% Discretisation du domaine
% facteur apparaissant frequemment dans nos schemas, on  a preferé le 
% poser de la sorte pour rendre simple l'écriture dans la suite.

theta=alpha*dt/dx^2;


x=0:dx:1;% variable spaciale discretisée
 % Taille du vecteur espace
[~,N]=size(x);

%On doit enlever 2 par la suite car on veut travailler sur les solutions
% sont cherchées pour les noeuds internes, les valeurs deux noeuds externes 
% etant imposés par les conditions aux limites nul dans notre cas
% actuels.)



%% Creation d'une matrice triadiagonale,
% c'est une matrice recurrente dans la plus part des problème faisant
% intervenir des derivées d'ordres 2.

C=full(gallery('tridiag',N-2,-1,2,-1));

%% Schema explicite
 Aexp=eye(N-2)-theta*C;
 Bexp=eye(N-2);


%% Schema implicite
Aimp=eye(N-2);
Bimp=eye(N-2)+theta*C;

%% r_Schema 
r=1/2; % Donc le schema de Crank-Nicholson par défaut dans ce programme
Ar_sch= r*Aimp+(1-r)*Aexp;
Br_sch=r*Bimp+(1-r)*Bexp;

%% Solution initiale
U0=sin(pi*x)';



%% Solution methode implicite
Solexp=[]; %=U0(2:end-1,:);

Bin_exp=Bexp\eye(N-2);

 U1=U0(2:end-1,:);
 for i=1:nt
    U2=Bin_exp*Aexp*U1;
    U1=U2;
    Solexp=[Solexp U1];
    
 end

%% Solution methode implicite
Solimp=[]; %=U0(2:end-1,:);

Bin_im=Bimp\eye(N-2);

 U1=U0(2:end-1,:);
 for i=1:nt
    U2=Bin_im*Aimp*U1;
    U1=U2;
    Solimp=[Solimp U1];
    
 end


%% Solution methode semi-implicite
  Solr_sch=[]; %=U0(2:end-1,:);

  Bin_sc=Br_sch\eye(N-2);

  U1=U0(2:end-1,:);
  for i=1:nt
    U2=Bin_sc*Ar_sch*U1;
    U1=U2;
    Solr_sch=[Solr_sch U1];
    
  end
  %Ue=sin(x'*alpK)*mKk*exp(-(alpK.^2)'*t);
  Ue=sin(pi*x)'*exp(-alpha*pi^2*t);
  NormErrExp=[NormErrExp norm((Ue(2:end-1,:)-Solexp))];
  NormErrImp=[NormErrImp norm((Ue(2:end-1,:)-Solimp))];
  NormErrSem=[NormErrSem norm((Ue(2:end-1,:)-Solr_sch))];
end

%% Les figures
figure()
loglog(pas,NormErrExp,'r-')
title('Ordre explicite')

figure()
loglog(pas,NormErrImp, 'b-')
hold on
loglog( pas,NormErrSem,'g-');
title('Ordre: Implicite & Crank-Nicholson')

