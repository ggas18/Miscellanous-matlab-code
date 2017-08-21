% chargement des données
data=load('TPStat001.mat');
x=data.x;
y=data.y;
N=max(size(x));
% previsualisation des données
%plot(x,y,'*','MarkerSize',20);

%calcul des paramètres généraux sur les données
mean_x=mean(x);
mean_y=mean(y);
var_xy=mean((x-mean_x).*(y-mean_y));
var_x=var(x);
var_y=var(y);


%paramètre de regression
b=var_xy/var_x;
a=mean_y-b*mean_x;

% previsualisation des données
figure()
plot(x,y,'*');
hold on
xarray=min(x):0.01:max(x);
yhat_array=a+b*xarray;
plot(xarray,yhat_array,'r');

%analyse des résidus
y_m=a+b*x;
err=y-y_m;
figure();plot(x,err)
%test de normalité
figure();qqplot(err)
%test de l'homoscedasticité
s=sqrt(1/(N-2)*norm(err)^2);
%% Test d'hypothèse 

%les ecarts-types
s_alpha=sqrt(s^2*(1/N+mean_x^2/sum((x-mean_x).^2)));
s_beta=sqrt(s^2/sum((x-mean_x).^2));

%les stats
%H0: beta=0
H0_beta=0;
stat_beta=(b-H0_beta)/s_beta^2;
p_val=1-tcdf(stat_beta,N-2);

%% Coefficient de determination R=norm(y_m-mean_y
R=sqrt(var_xy^2/(var_x*var_y));%car on est en |R²

%% Qu3
niv=10/100;
t10=tinv(1-niv,N-2);
figure()
%plot(x,y,'*');
hold on
plot(xarray,yhat_array,'r');
Conf_bas3=a+b*xarray-t10*s*sqrt(1/N+(xarray-mean_x).^2/norm(x-mean_x)^2);
Conf_haut3=a+b*xarray+t10*s*sqrt(1/N+(xarray-mean_x).^2/norm(x-mean_x)^2);
%resolution exacte
syms valeur
%Recherche de la valeur exacte pour la resistance  800
Yhat_1=800;
eqn=a+b*valeur-t10*s*sqrt(1/N+(valeur-mean_x).^2/norm(x-mean_x)^2)==Yhat_1;
%valeur exacte pour 800
s=solve(eqn,valeur);
v_exact_1=double(s);
%Recherche de la valeur exacte pour la resistance  2000
Yhat_2=800;
eqn=a+b*valeur-t10*s*sqrt(1/N+(valeur-mean_x).^2/norm(x-mean_x)^2)==Yhat_2;
%valeur exacte pour 2000
v_exact_2=double(solve(eqn,valeur));
plot(xarray',Conf_bas3)
plot(xarray',Conf_haut3)

%% Qu4
niv=10/100;
t10=tinv(1-niv,N-2);
figure()
%plot(x,y,'*');
hold on
plot(xarray,yhat_array,'r');
Conf_bas4=a+b*xarray-t10*s*sqrt(1+1/N+(xarray-mean_x).^2/norm(x-mean_x)^2);
Conf_haut4=a+b*xarray+t10*s*sqrt(1+1/N+(xarray-mean_x).^2/norm(x-mean_x)^2);
%v_exact=
plot(xarray,Conf_bas4)
%plot(xarray',Conf_haut4)


