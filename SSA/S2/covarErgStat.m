function [ varXX, varYX,X,Y ] = covarErgStat( x, y , M )
% On prend nos données en paramètre et on calcule les 
% On forme la grande matrice des realisation de X et on
% calcule les covariances.

N=size(x,2);
Y=zeros(M,N);
X=zeros(M,N);

for k=1:M
    X(k,:)=circshift(x,-k+1,2);
    Y(k,:)=circshift(y,-k+1,2);
end

varXX=X*X'/N;
varYX=Y(end,:)*X'/N;

end

