clear

Dmin=5;
Dmax=5.040;
moy0=5.020;
alpha1=0.05/2;
alpha2=1-0.05/2;
Qalpha1=norminv(1-alpha1, 0,1);
Qalpha2=norminv(alpha1,0,1);
sigma0=(Dmax-moy0)/Qalpha1;


% import data
c= load('Donnes_CouronnesDentees.txt');
[N,~]=size(c);
Sobs=std(c);
X2alpha1=(1/2)*(Qalpha1+sqrt(2*(N-1)-1))^2;
X2alpha2=(1/2)*(Qalpha2+sqrt(2*(N-1)-1))^2;
SigmaMin=sqrt((N-1)*Sobs^2/X2alpha1);
SigmaMax=sqrt((N-1)*Sobs^2/X2alpha2);

Yobs=(N-1)*Sobs^2/sigma0^2;
Zobs=sqrt(2*Yobs)-sqrt(2*(N-1)+1);
pvaleur=1-normcdf(Zobs,0,1);
%% puissance
%Sous H1
sigma1=Sobs;
Qalpha3=norminv(1-0.01/2, 0,1);
Salpha1=sigma0*(Qalpha1+sqrt(2*(N-1)-1))/sqrt(2*(N-1));
Salpha3=sigma0*(Qalpha3+sqrt(2*(N-1)-1))/sqrt(2*(N-1));
Khialpha3=(N-1)*Salpha3^2/sigma1^2;
Khialpha1=(N-1)*Salpha1^2/sigma1^2;
Zalpha3=sqrt(2*Khialpha3)-sqrt(2*(N-1)-1);
Zalpha1=sqrt(2*Khialpha1)-sqrt(2*(N-1)-1);
gamma3=normcdf(-Zalpha3,0,1)+(1-normcdf(Zalpha3,0,1));
gamma1=normcdf(-Zalpha1,0,1)+(1-normcdf(Zalpha1,0,1));

%% Un test d'adéquation
h=histogram(c,5:0.01:5.06);
Val=h.Values;
h.delete
close
Val=[Val(1:3),sum(Val(4:6))];
sig0=0.01;
mu0=5.020;
p=[normcdf((5.01-mu0)/sig0)-normcdf((5-mu0)/sig0) normcdf((5.02-mu0)/sig0)-normcdf((5.01-mu0)/sig0) normcdf((5.03-mu0)/sig0)-normcdf((5.02-mu0)/sig0) normcdf((5.06-mu0)/sig0)-normcdf((5.03-mu0)/sig0)];
if( p*N>5 & N>=50)
    disp('Les conditions du test du Khi2 sont bien verifiées');
end
%% Estimation de la stat de test
%Estimation
[~,k]=size(p);
Khiobs=sum(((Val-p*N).^2)./(p*N));
p_value_ad_test=1-chi2cdf(Khiobs,k-1);
