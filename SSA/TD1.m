L=250;
l=250;
green=uint8([0,255,0]);
blue=uint8([0,0,255]);
red=uint8([255,0,0]);
mu0=blue+red;

mu1=green+red;
%% creation de la matrice image
I= zeros(L,l,3);
for i=1:L
    for j=1:l
        if(i<=L/4 || j<l/4)
        I(i,j,:)=mu0;
        else
            I(i,j,:)=mu1;
        end
    end
end

%% Ajout d'un bruit gaussian de moyenne nulle
sigma0=10;
Ibruitee=imnoise(I,'gaussian',0,sigma0^2);

