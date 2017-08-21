%% Paramètre du problème à résoudre
alpha=1;% paramètre de la modélisation physique


%% Borne du domaine
xmin=0;
xmax=1;
tc=1;% temps caracteristique
%% Discretisation du domaine
dx=xmax/(N+1);% pas en espace
nt=100;
dt=tc/nt;
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

%% affichage de la solution initiale
%figure(1)
%plot(x,U0);
%title('Solution initiale ( t=0)');
%text(x(4),U0(4),sprintf('dx=%f et dt= %f',dx,dt),'Color','b');


%% Solution par methode explicite
Solexp=U0(2:end-1,:);
Bin=Bexp\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*Aexp*U1;
    U1=U2;
    Solexp=[Solexp U1];
    
end
%Conditions aux bords  de Dirichlet 

%% Solution methode implicite
Solimp=U0(2:end-1,:);

Bin=Bimp\eye(N-2);

U1=U0(2:end-1,:);
for i=1:nt
    U2=Bin*Aimp*U1;
    U1=U2;
%     plot(x,[0;U1;0])
%     hold on
%     drawnow
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

%% Analytique
% Recherche d'une solution analytique
t=0:dt:1;
k=1:nt;
alpK=k*pi;
Kk=-4./alpK.^3;
mKk=diag(Kk,0);

Ue=sin(x'*alpK)*mKk*exp(-(alpK.^2)'*t);
plot(x,Ue(:,end))

% Etude de l'erreur
Er=abs(Ue(2:end-1,:)-Solr_sch);

%plot(x,[0;Er(:,end);0])

% Echelle logarithmique
logEr=log(Er);
%plot(x,[0;logEr(:,40);0])
