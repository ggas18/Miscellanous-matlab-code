% pas d'expace
Creation_Schema


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