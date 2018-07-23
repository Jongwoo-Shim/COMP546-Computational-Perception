close all
clear

N = 256;

I =  makeImageCheckerboard(N);
for k = 1:3
    I( :, N/2 +1 : N,  k) =  I(: , N/2 +1 : N,  k) * 0.2 ;
end
figure
image(I);
sig_localmean = 16;
R = squeeze( double( I(:,:,1) ) );      %  read up on what 'squeeze' does
G = squeeze( double( I(:,:,2) ) );
intensity = (R + G)/2;

Rlocalmean  = imgaussfilt( R, sig_localmean ); 
Glocalmean  = imgaussfilt( G, sig_localmean );
intensityLocalMean= (Rlocalmean +   x Glocalmean)/2;
colorContrast  =   (R-G) ./ intensityLocalMean;

figure
imagesc(colorContrast);
colormap(gray(256)), colorbar
title('Color Contrast')