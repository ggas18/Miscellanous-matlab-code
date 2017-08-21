%% Paramètre du problème à résoudre
alpha=1;% parametre de la modelisation physique


%% Borne du domaine
xmin=0;
xmax=1;
tc=1;% temps caracteristique
%% Discretisation du domaine
N=100;%
dx=xmax/(N+1);% pas en espace
nt=400;
dt=tc/nt;
% facteur apparaissant frequemment dans nos schemas, on  a prefererr le 
% poser de la sorte pour faciler l'ecriture dans la suite.

theta=alpha*dt/dx^2;


x=0:dx:1;% variable spaciale discretisree
% Taille du vecteur espace
[~,N]=size(x);

%k=1e-3;
%On doit enlever 2 par la suite car on veut travailler sur les solutions
% sont cherchées pour les noeuds internes, les valeurs deux noeuds externes 
% etant imposers par les conditions aux limites nul dans notre cas
% actuels.)



%% Creation d'une matrice triadiagonale,
% c'est une matrice recurrente dans la plus part des probleme faisant
% intervenir des derivees d'ordres 2.


C=full(gallery('tridiag',N-2,-1,2,-1));
gamma=alpha*dt/(dx)^2; % Paramètre modulant la stabilité dans la methode von Neumann

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
U0=(x.*(x-1)/(2*alpha))';


%% Solution methode semi-implicite
Solr_sch=U0(2:end-1,:);

Bin=Br_sch\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*Ar_sch*U1;
    plot(x,[0;U1;0])%Les zeros sont pour les conditions aux bords  de Dirichlet
    hold on
    U1=U2;
    Solr_sch=[Solr_sch U1];
    
end
xlabel('Abscisse')
ylabel('Valeur de la température')
titre=sprintf('Solutions pour \\alpha*dt/dx²=%0.5g',gamma);
title(titre);

