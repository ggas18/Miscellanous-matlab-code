function [ SomPart ] = somPart( A, n)
 % Ce code vous permet d'avoir la somme partielle
 % des puissance d'une matrice A de 0 à n;
 syms k 
 SomPart=symsum(A^k, k, 0, n);
 
end

