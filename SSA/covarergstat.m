function [ VarXX,VarYX] = covarergstat( X,Y,M)
 % Estimation des covariances scatter matrix de X
  N=size(X,2);
  Xconst=const(X,M);
  Yconst=const(Y,M);
  VarXX=1/N*(Xconst(:,1)*Xconst(:,1)');
  VarYX=1/N*(Yconst*Xconst');
  
end

