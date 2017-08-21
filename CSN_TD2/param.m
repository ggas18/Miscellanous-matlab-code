A=[ 0   1
    0  -1];
B=[0;1];
C=[1 0]; 
D=0;
Ts=0.1;
sys=ss(A,B,C,D);
sysd=c2d(sys,Ts,'zoh');
[F,G,E,J]=ssdata(sysd);
Fcal=[1 1-exp(-Ts)
    0 exp(-Ts)];
Gcal=[Ts-1+exp(-Ts);1-exp(-Ts)];
Com=[G F*G];
rg=rank(Com);
if( rg==2)
    disp('Système commandable')
end
vAp=[0 0];
K=acker(F,-G,vAp);
Ca=[eye(2);C];
Da=zeros(3,1);

