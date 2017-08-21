L=640;
l=600;
mu1=[10;10;50];
mu1=uint8(mu1);

mu2=[255,0,0];
mu2=uint8(mu2);
% creation de la matrice image
C= zeros(L,l,3);
for i=1:L
    for j=1:l
        if(i<=L/4 || j<l/4)
        C(i,j,:)=mu1;
        else
            C(i,j,:)=mu2;
        end
    end
end

%% Test
redChannel = 255 * ones(200, 200, 'uint8');
greenChannel = 255 * ones(200, 200, 'uint8');
blueChannel = 255 * zeros(200, 200, 'uint8');
% Blacken the inner most 150x150 for red
% so that it will be only Green.
redChannel(25:174, 25:174) = 0;
% Set the inner most 100x100 for red and
% Clears the inner most 100 x 100 for green
% so that it will be only red.
redChannel(50:149, 50:149) = 255;
greenChannel(50:149, 50:149) = 0;
rgbImage = cat(3, redChannel, greenChannel, blueChannel);
imshow(rgbImage);

%% std
 X = [4 -2 1; 9 5 7];
 var0=std(X,0,1);
 var1=std(X,0,2);