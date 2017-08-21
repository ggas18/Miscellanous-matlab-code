clc
load('homerbruitseul.mat');
ym=y1;
xm=y2;
ym=ym-mean(ym);
xm=xm-mean(xm);
OrdMax=50;
err=zeros(1,OrdMax);
for M=1:OrdMax
[ varXX, varYX,Xm,Ym ] = covarErgStat( xm, ym, M );
hm=varXX\varYX';
x2f=hm'*Xm;
% on permute pour retrouver la composition temporelle dans le bon ordre
x2f=circshift(x2f,M-1,2);
VoixHomer=ym-x2f;
err(M)=norm(VoixHomer);
end

%% 
clc
load('homerbruitseul.mat');


yb=y1;% Notre sortie c'est le signal y1( ici c'est sans la voix du pilote)
xb=y2;% notre signal d'entrée c'est le bruit du moteur.

% On soustrait les moyennes pour avoir un signal à moyenne nulle pour que
% l'estimation de nos covariances soit une formule exactes.
yb=yb-mean(yb);
xb=xb-mean(xb);

%
M=8;
[ varXX, varYX,Xb,Yb ] = covarErgStat( xb, yb , M );
hb=varXX\varYX';


% On charge les données de mesure pour avoir les données mesurées.
load('homermesure.mat');

ym=y1;
xm=y2;
ym=ym-mean(ym);
xm=xm-mean(xm);
sens=2;
M=8;
[~, ~,Xm,~ ] = covarErgStat( xm, ym, M );

x2f=hb'*Xm;
% on permute pour retrouver la composition temporelle dans le bon ordre
x2f=circshift(x2f,M-1,2);
VoixHomer=ym-x2f;

plot(VoixHomer)
