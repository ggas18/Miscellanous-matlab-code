clear all
close all

%% Paramètre physique
alpha=1;
T0= 273.15;

%% Domaine et temps
x_lower=0;
x_upper=1000;
ti=0;
tf=24*3600;

%% Discresation
Nx=1000;
dx=(x_upper-x_lower)/Nx;
x=x_lower+dx/2:dx:x_upper-dx/2;
Nt=1000;
dt=(tf-ti)/(Nt-1);
t=ti:dt:tf;
%Matrice tridiagonale pour la discretisation en espace
C=diag(ones(Nx-3,1),1)-2*diag(ones(Nx-2,1),0)+diag(ones(Nx-3,1),-1);

r=alpha*dt/dx^2;
%% Schema implicite
A=zeros(Nx-1);
A(2:Nx-1,2:Nx-1)=C;
A(2,1)=1;
A=eye(Nx-1)-r*A;
A(1,1)=1;

%% Solution initiale
U0=T0*ones(Nx-1,1);
S=zeros(Nx,Nt);
Ainv=A\eye(Nx-1);
U1=U0;
for i=1:Nt
    S(:,i)=[U1;U1(end)];
    U2=Ainv*U1;
    U1=U2;
end