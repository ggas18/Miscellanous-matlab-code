%% ENSEM Nancy, INPL, Université de Lorraine
%  *******************************  ******** *********       *  *********
%  * Prof:      Benjamin REMY    *         * *       *       *         *
%  * Etudiants: Arouna   GANOU   *  ******** *       *       *        *
%  *            Mahdi    GHARBI  *  *        *       *       *        *
%  *******************************  ******** *********       *        *


alpha=1;
nt=2e5;
L=1;
tmx=1;
h=3:10;
nx=power(2,h)+1;

%=================================================
%=                                               =
%=Erreur en espace  dx                           =
%=                                               =
%=================================================
Norm_errX_exp=[];
Norm_errX_imp=[];
Norm_errX_cn=[];

for i=1:8
    [err_imp,~,~,~]=heatBTCS(nx(i),nt,alpha,L,tmx);
    [err_cn,~,~,~]=heatCN(nx(i),nt,alpha,L,tmx);
    
    Norm_errX_imp=[Norm_errX_imp err_imp];
    Norm_errX_cn=[Norm_errX_cn err_cn];

end

%=================================================
%=                                               =
%=Erreur en espace  dt                           =
%=                                               =
%=================================================
nx=2e3;
nt=power(2,h);

Norm_errT_exp=[];
Norm_errT_imp=[];
Norm_errT_cn=[];

for i=1:8
    [err_imp,~,~,~]=heatBTCS(nx,nt(i),alpha,L,tmx);
    [err_cn,~,~,~]=heatCN(nx,nt(i),alpha,L,tmx);
    
    Norm_errT_imp=[Norm_errT_imp err_imp];
    Norm_errT_cn=[Norm_errT_cn err_cn];

end
%% Les figures
% en espace
figure()
p_cn=loglog(nt,Norm_errX_cn);
hold on
p_imp=loglog(nt,Norm_errX_imp);
p_th=loglog(nt,nt.^(-2));
legend([p_cn,p_imp,p_th],...
       'Crank-Nicholson',...
       'Implicite',...
       'Theorique');
xlabel('Nombre de point en espace');
ylabel('norme ||Uexa-Unum||')
title('Erreur en espace: Implicite et Crank-Nicolson')

% en temps 
figure()
p_cn=loglog(nt,Norm_errT_cn);
hold on
p_imp=loglog(nt,Norm_errT_imp);
p_th_cn=loglog(nt,nt.^(-2));
p_th_imp=loglog(nt,nt.^(-1));
legend([p_cn,p_th_cn,p_imp,p_th_imp],...
       'Crank-Nicolson',...
       'Crank-Nicolson théorique',...
       'Implicite',...
       'Implicite Theorique');
xlabel('Nombre de point en temps');
ylabel('norme ||Uexa-Unum||')
title('Erreur en temps: Implicite et Crank-Nicolson')
% Ce code utilise les fonctions heatFTCS, heatBTCS, heatCN
%les fonctions heatFTCS, heatBTCS, heatCN sont données en annexes
