function [b, R2a, pvalue_f, pvalue_t,T]=RLM(X,y)



%nb de variables explicatives

p=size(X,2)-1;


%taille d'echantillon
n=size(X,1);
%calcul de b
b=(X'*X)\X'*y;

%résidus
y_hat=X*b;
e=y-y_hat;

%estimation de l'�cart-type de l'erreur
s=sqrt(1/(n-p)*norm(e)^2);

%Somme des carrés
SCT= norm(y-mean(y))^2;
SCM= norm(y-y_hat)^2;
SCE=norm(y_hat-mean(y))^2;

%Vérification de la décomposition de la variabilité totale (Pythagore):
%(SCT==SCM+SCE)
if(abs(SCT-(SCM+SCE))<=1e-9) 
    disp('Somme des carrés correcte');
end


%R^2 ajusté:
R2a=1-(n-1)/(n-p-1)*SCE/SCT;

%Test de Ficher global
R=sqrt((SCT-SCE)/SCT);
F=(R^2/(1-R^2))*(n-p-1)/p;


pvalue_f=1-cdf('f',F,p,n-p-1);

Vxx=(X'*X)\eye(p+1);

%Tests sur les paramètres
T=zeros(1,p+1);
pvalue_t=zeros(1,p+1);


%calculer T et les pvalues associées

for k=1:p+1
    T(k)=b(k)/(s*sqrt(Vxx(k,k)));
    pvalue_t(k)=2*(1-cdf('t',abs(T(k)),n-p-1));
end

end
