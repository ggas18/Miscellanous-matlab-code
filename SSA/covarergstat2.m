function [ VarXX,VarYX] = covarergstat2( X,y,i,M)
 % Estimation des covariances scatter matrix de X

  N=size(X,2);
  VarXX=(X*X')/N;
  VarYX=(y*X(:,i)')/M;
end
