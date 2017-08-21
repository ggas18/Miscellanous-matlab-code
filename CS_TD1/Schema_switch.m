%% Paramètre du problème à résoudre
alpha=1;% paramètre de la modélisation physique


%% Borne du domaine
xmin=0;
xmax=1;
%% Discretisation du domaine
% Les pas
dx=1e-3;% pas en espace
tc=1; %temps caractéristique
nt=100;% nombre de points considérés dans l'intervalle de temps [0:tc] 
dt=tc/nt;%pas de temps

% facteur apparaissant frequemment dans nos schemas, on  a preferé le 
% poser de la sorte pour faciler l'écriture dans la suite.
theta=alpha*dt/dx^2;


x=0:dx:1;% variable spaciale discretisée
% Taille du vecteur espace
[~,N]=size(x);

%k=1e-3;
%On doit enlever 2 par la suite car on veut travailler sur les solutions
% sont cherchées pour les noeuds internes, les valeurs deux noeuds externes 
% etant imposés par les conditions aux limites nul dans notre cas
% actuels.)



%% Creation d'une matrice triadiagonale,
% c'est une matrice recurrente dans la plus part des problème faisant
% intervenir des derivées d'ordres 2.


C=full(gallery('tridiag',N-2,-1,2,-1));
% Discretisation de la sollicitation.
% Bien que considérée nulle dans le TD, nous le gardons les équations pour
% une approche plus générale pour notre code.
F=zeros(N-2,1);

%% Schema implicite
Aimp=eye(N-2);
Bimp=eye(N-2)+theta*C;


%% Schema explicite
Aexp=eye(N-2)-theta*C;
Bexp=eye(N-2);

%% r_Schema 
r=1/2; % Donc le schema de Crank-Nicholson par défaut dans ce programme
Ar_sch= r*Aimp+(1-r)*Aexp;
Br_sch=r*Bimp+(1-r)*Bexp;

%% Solution initiale
U0=(x.*(1-x)/(2*alpha))';


%% Switch

%{
choix=sprintf(['Quelle methode voulez vous utiliser:\n',...
    ' 1=Explicite \n 2=Implicite\n 3=Semi-implicite\n']);
methode = input(choix);
 
switch methode
    case 1 
            disp('Method is explicite')
            A=Aexp;
            B=Bexp;
    case 2
            disp('Method is implicite')
            A=Aimp;
            B=Bimp;
    case 3
            disp('Method is semi-implicite')
            A=Ar_sch;
            B=Br_sch;
                
    otherwise
            disp('Method not supported.')
end
Sol=U0(2:end-1,:);

Bin=B\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*A*U1;
    U1=U2;
    Sol=[Sol U1];
    
end
%}

%% Etude de la precision
% On suppose que le schema a été choisi par la saisie au clavier.
% On ne va pas traiter le cas explicite car le schema est install donc 
% l'erreur est incontroble.


%On choisit des pas d'espace
NbPas=10;
puiss=-NbPas:-1;
% On choisit une discretisation de l'espace de temps en 
% puissance entière negative de 10
pas=power(2,puiss);

NormErrImp=[];
NormErrSem=[];
for k=1:NbPas
dx=pas(k);
%% Discretisation du domaine
% facteur apparaissant frequemment dans nos schemas, on  a preferé le 
% poser de la sorte pour faciler l'écriture dans la suite.

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
U0=(x.*(x-1)/(2*alpha))';


%% Solution methode implicite
Solimp=U0(2:end-1,:);

Bin=Bimp\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*Aimp*U1;
    U1=U2;
    Solimp=[Solimp U1];
    
end


%% Solution methode semi-implicite
Solr_sch=U0(2:end-1,:);

Bin=Br_sch\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*Ar_sch*U1;
    U1=U2;
%     plot(x,[0;U1;0])
%     hold on
%     drawnow
    Solr_sch=[Solr_sch U1];
    
end
  Ue=sin(x'*alpK)*mKk*exp(-(alpK.^2)'*t);
  NormErrImp=[NormErrImp norm(Ue(2:end-1,:)-Solimp)];
  NormErrSem=[NormErrSem norm(Ue(2:end-1,:)-Solr_sch)];

  
end
