function [ r ] = page_hinckley(X, mu0, mu1, sigma0 )
%PAGE_HINCKLEY Summary of this function goes here
%   Detailed explanation goes here
N= size(X,2);
if( nargin<2)
    Ndeb=ceil(N/10);
    mu0=mean(X(1:Ndeb));
    
end
if( nargin<3)
    mu1=mean(X(Ndeb+1:end));
end
if(nargin<4)
    sigma0=((Ndeb-1)*std(X(1:Ndeb)+(N-Ndeb-1)*std(X(Ndeb+1,end))/(N-2);
end
r=1;
for i=1:N
    S=sqrt();
    T=(mean(X(1:i))-mean(X(i+1:end))/(
end

end

