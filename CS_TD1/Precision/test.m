% Pour tester le code
t_c=1;
t_0=0;
t_f=t_c;

% On prend plusieurs pas de temps en fonction de n
nt=2:8;
N=2^10;%power(2,nt);%%2^nt;
% On prend plusieurs pas de temps en fonction de m
mx=2:8;
M=power(2,mx);
err_exp=[];%erreur explicite
err_imp=[];%erreur implicite
err_cn=[];%erreur crank-nicolson
for i=1:4
    [~,err,~,~]=cha_exp(t_0,t_f,M(i),N);
    err_exp=[err_exp norm(err)];
end
figure();hold on
for i=1:7
    [u,err,x,~]=cha_imp(t_0,t_f,M(i),N);
    plot(x,u(:,5));
    err_imp=[err_imp norm(err)];
    
    [~,err,~,~]=cha_cn(t_0,t_f,M(i),N);
    err_cn=[err_cn norm(err)];
end

N=power(2,nt);
M=2^10;
err_exp_t=[];%erreur explicite
err_imp_t=[];%erreur implicite
err_cn_t=[];%erreur crank-nicolson
for i=1:4
    [~,err,~,~]=cha_exp(t_0,t_f,M,N(i));
    err_exp_t=[err_exp_t norm(err)];
end
figure();hold on
for i=1:7
    [u,err,x,~]=cha_imp(t_0,t_f,M,N(i));
    plot(x,u(:,5));
    err_imp_t=[err_imp_t norm(err)];
    
    [~,err,~,~]=cha_cn(t_0,t_f,M,N(i));
    err_cn_t=[err_cn_t norm(err)];
end
