function [ X ] = const(x,M)
% on passe une matrice ligne et on on obtient la matrice 
%circulaireS
 N= size(x,2);
 x= [x(1:M) x];
 X=zeros(M,N);
 for j=1:N
     X(:,j)=x(j:j+M-1);
 end
end

