clear all
clc
load('homerbruitseul.mat');
sens=2;
M=8;
y=y1;
x=y2;
y=y-mean(y);
x=x-mean(x);

xt=x(1:M);
yt=y(1:M);

N=size(x,2);
Y=zeros(M,N);
X=zeros(M,N);

for k=1:M-1
    X(k,:)=circshift(xt,-k+1,sens);
    Y(k,:)=circshift(yt,-k+1,sens);
end
x=[x x(1:M)];
y=[y y(1:M)];

for t=M:N
    X(t,:)=x(t:t+M-1);
    y(t,:)=y(t:t+M-1);
    varXX=X*X'/N;
    varYX=Y(end,:)*X'/N;
    h=varXX\varYX';
    x2f=h'*X;
    % on permute pour retrouver la composition temporelle dans le bon ordre
end

x2f=circshift(x2f,M-1,2);
VoixHomer=y1-x2f;