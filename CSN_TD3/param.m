
%Linear Analysis
K=1.098;
taux=0.977;

Te=10e-3;

%systeme continu
sys_con=tf([K*taux 1],[1 0]);

%discretisation
sys_dis=c2d(sys_con,Te,'zoh');
[Bpi,Api]=tfdata(sys_dis,'v');


%systeme continu
sys_con=tf([K*taux 1],[1 0]);

%discretisation
sys_dis=c2d(sys_con,Te,'zoh');
[Bpsys,Apsys]=tfdata(sys_dis,'v');

%butterworth
N=5;
Fe=1/Te;