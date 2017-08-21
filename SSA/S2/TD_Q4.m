clc
Nb=1000;
part=35300-Nb;
load('homerbruitseul.mat');


yb=y1;% Notre sortie c'est le signal y1
xb=y2;% notre signal d'entrée c'est le bruit du moteur.

% On soustrait les moyennes pour avoir un signal à moyenne nulle pour que
% l'estimation de nos covariances soit une formule exactes.
yb=yb-mean(yb);
xb=xb-mean(xb);

%
M=8;
[ varXX, varYX,Xb,Yb ] = covarErgStat( xb, yb , M );
hb=varXX\varYX';
x2fb=hb'*Xb;
% on permute pour retrouver la composition temporelle dans le bon ordre
x2fb=circshift(x2fb,M-1,2);
VoixHomerB=yb-x2fb;


