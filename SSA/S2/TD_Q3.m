
clc
Nb=1000;
part=35300-Nb;
load('homermesure.mat');
%y=y1(Nb:Nb+part);
%x=y2(Nb:Nb+part);
ym=y1;
xm=y2;
ym=ym-mean(ym);
xm=xm-mean(xm);
sens=2;
M=8;
[ varXX, varYX,Xm,Ym ] = covarErgStat( xm, ym, M );
hm=varXX\varYX';
x2fm=hb'*Xm;
% on permute pour retrouver la composition temporelle dans le bon ordre
x2fm=circshift(x2fm,M-1,2);
VoixHomerM=ym-x2fm;

