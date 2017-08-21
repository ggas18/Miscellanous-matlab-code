%param du système
Ksys=10;

%période d'échantillonnage
Te=1e-3;

%systeme continu
sys_con=tf(10,[0.01 1]);

%discretisation
sys_dis=c2d(sys_con,Te,'zoh');
[B,A]=tfdata(sys_dis,'v');

%Réponse à 5% à t=10ms
tr=10e-3;
w0=3/tr;
m=0.7;

%Pole continue
p1=-m*w0-1i*w0*sqrt(1-m^2);
p2=-m*w0+1i*w0*sqrt(1-m^2);
%Pole discret

z1=exp(p1*Te);
z2=exp(p2*Te);

%RST
p0=1;
r0=p0;
R=r0*[1 -1];
s1=(-(z1+z2)*p0+1.95*r0)/.95;
s0=(z1*z2*p0-0.9*r0)/0.95;
S=[s1 s0];
t0=-10;
t1=(s1+s0)-t1;
T=[s1 s0];

