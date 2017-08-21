%% Paramètre du problème à résoudre
alpha=10;% paramètre de la modélisation physique


%% Borne du domaine
xmin=0;
xmax=1;
%% Discretisation du domaine
dx=1e-3;% pas en espace
dt=1e-3;% pas du temps
% facteur apparaissant frequemment dans nos schemas, on  a preferé le 
% poser de la sorte pour faciler l'écriture dans la suite.

theta=alpha*dt/dx^2;


x=0:dx:1;% variable spaciale discretisée
% Taille du vecteur espace
[~,N]=size(x);

k=1e-3;
%On doit enlever 1 par la suite car on veut travailler sur les solutions
% sont cherchées pour les noeuds internes, les valeurs deux noeuds externes 
% etant imposés par les conditions aux limites nul dans notre cas
% actuels.)



%% Creation d'une matrice triadiagonale,
% c'est une matrice recurrente dans la plus part des problème faisant
% intervenir des derivées d'ordres 2.


C=full(gallery('tridiag',N-1,-1,2,-1));
% Discretisation de la sollicitation.
% Bien que considérée nulle dans le TD, nous le gardons les équations pour
% une approche plus générale pour notre code.
F=zeros(N-1,1);

%% Schema implicite
Aimp=eye(N-1);
Bimp=eye(N-1)+theta*C;


%% Schema explicite
Aexp=eye(N-1)-theta*C;
Bexp=eye(N-1);

%% r_Schema 
r=1/2; % Donc le schema de Crank-Nicholson par défaut dans ce programme
Ar_sch= r*Aimp+(1-r)*Aexp;
Br_sch=r*Bimp+(1-r)*Bexp;

%% Solution initiale
U0=x.*(x-1)/(2*alpha);

%% affichage de la solution initiale
plot(x,U0);
title('Solution initiale ( t=0)');
text(x(4),U0(4),sprintf('dx=%f et dt= %f',dx,dt),'Color','b');


%% Solution
% Solution explicite à l'intant 50*dt;
n=50;
U=(Aexp^n)*U0(2:end-1)+dt*somPart(Aexp,n-1)*F;

