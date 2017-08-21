%% Definition du domaine
lx=1;
ly=1;

%% Definition des nombres de points de maillage
%pas de temps
Nx=60;
Ny=60;
h=lx/(Nx-1);
k=ly/(Ny-1);
x=0:h:lx;
y=0:k:ly;
% Constantes recurrentes dans les schemas
a=sqrt(k^2/(2*(h^2+k^2)));
b=sqrt(h^2/(2*(h^2+k^2)));
c=sqrt(h^2*k^2/(2*(h^2+k^2)));


%% Assemblage de A et F
A=zeros(Nx*Ny);
F=zeros(Nx*Ny,1);

for j=1:Ny
    for i=1:Nx
        k1=(j-1)*Nx+i;
        k2=(j-1)*Nx+i-1;
        k3=(j-1)*Nx+i+1;
        k4=(j-1-1)*Nx+i;
        k5=(j-1+1)*Nx+i;
        k6=(j-1+2)*Nx+i;
        if i>1 && i<Nx && j>1 && j<Ny
            F(k1,1)=-c^2*f(x(i),y(j),lx,ly);
            A(k1,k1)=1;
            A(k1,k2)=-a^2;
            A(k1,k3)=-a^2;
            A(k1,k4)=-b^2;
            A(k1,k5)=-b^2;
        end
        if i==1 || i==Nx || j==Ny
            F(k1,1)=0;
            A(k1,k1)=1;
        end
        if j==1 && i>1 && i<Nx
            F(k1,1)=2*k*b^2*g(x(i),lx,ly)-c^2/2*f(x(i),y(j),lx,ly);
            A(k1,k1)=1;
            A(k1,k2)=-a^2;
            A(k1,k3)=-a^2;
            A(k1,k5)=-2*b^2;
        end
        
            
    end 
end

%% Solution
K=1; % par recherche de valeur propre du laplacien
Ue=K*sin(pi*x/lx)'*sin(pi*y/ly);

%% Solution par DF
U=A\F;

Usm2=reshape(U,Nx,Ny);
figure();surf(Ue-Usm2);
title('Ordre 2 methode 2')
