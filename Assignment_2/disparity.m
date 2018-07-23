%  Assignment 2  COMP 546  Winter 2018
%
%  Create a simple random dot stereogram with left and right images
%  Ileft and Iright.  Filter the stereo pair with a family of 
%  binocular complex Gabors.  

clear 
%close all
N = 256;

%  number of families of disparity tuned Gabors 
numdisparities = 17;   
%  e.g.  -8 to 8,  or -16 to 16 if we step by 2,  -32 to 32 if we step by 4

step = 1;
disparities = ((1:numdisparities) - ceil(numdisparities/2))*step;

M = 16;    % window width on which Gabor is defined
k = 2;    % frequency
%  wavelength of underlying sinusoid is M/k pixels per cycle.

% select orientation of gabor filters

orientation = 'vertical'; % vertical/horizontal/diagonal
switch orientation
    case 'vertical'
        [cosGabor, sinGabor] = make2DGabor(M,2,0);  
    case 'horizontal'
        [cosGabor, sinGabor] = make2DGabor(M,0,2);   
    case 'diagonal'
        [cosGabor, sinGabor] = make2DGabor(M,sqrt(2),sqrt(2));  
    otherwise
        fprintf('unknown orientiation.. using default(vertical)\n');
        [cosGabor, sinGabor] = make2DGabor(M,2,0);  
end

%  Make a random dot stereogram with a central square protruding from a 
%  plane.  The plane has disparity = 0.  The central square has some positive
%  disparity.

disparitySquare = 4;
%  To make anti-correlated pair set correlate = false;
correlated = true;
[Ileft, Iright] = mkRandomDotStereogram(N,disparitySquare,correlated);

% Show the image as an anaglyph

figure
I = zeros(N,N,3);
I(:,:,1) = Ileft;       %  put left eye image into the R channel
I(:,:,2) = Iright;      %  put right eye image into the G and B channels
I(:,:,3) = Iright;

image(I);
title(['disparity of center is ' num2str(disparitySquare)  ' pixels'])
axis square
axis off

%  To define disparity tuned Gabor cell, we want to shift the left  
%  Gabor cells relative to the right one. 
%  If the shift is 0, then the cell is tuned to 0 
%  disparity as was the case looked at in the lecture.  If we want 
%  a different disparity then we need to shift by some other amount
%  which I am calling d_Gabor.
%
%  The binocular complex cell's response at (x,y) is the length of the vector
%  that is defined by the sum of the responses of the (cos, sin) Gabors   
%  of the left and right eye Gabor cells.   To compute 
%  the binocular complex cell response, take the cross correlation of the sin 
%  and cos Gabors with the left image and right images -- four cross correlations needed.    
%  To define have a binocular complex cell that has a preferred 
%  disparity,  we need to combine the responses of one eye with shifted responses of the other eye.


figure
responses = zeros(N,N,numdisparities);    %  compute responses for all different disparities

Ileft_filtered_cos  = filter2( cosGabor, Ileft, 'same');
Ileft_filtered_sin  = filter2( sinGabor, Ileft, 'same');
Iright_filtered_cos = filter2( cosGabor, Iright, 'same');
Iright_filtered_sin = filter2( sinGabor, Iright, 'same');


%%%---------   ADD YOUR BELOW CODE HERE   


%%%----------   ADD YOUR CODE ABOVE HERE -----------------%

%  2D response plots for different disparity tuned cells

%  'responses' is the responses of a family of binocular disparity tuned complex
%  Gabor cells.  Each family has particular peak disparity to which it is tuned.    
%  'responses' is an N x N x 17 matrix

for j = 1:numdisparities
    if mod(j, 2) == 1  % image plot only for odd numbered indices of disparities
        subplot(3,3, (j+1)/2);   %  3x3 plot
        
        %  responses may be positive or negative.   Remap them to [0, 255]
        subimage( remapImageUint8( squeeze(responses(:,:,j))) );
        colormap gray
        title( ['tuned to d = ' num2str(disparities(j)) ] );
        axis off
    end
end

%  Code for 1D plots of mean responses in the centers versus surrounds for
%  different disparity tuned cells.

sumResponseCenter          = zeros(numdisparities,1);
meanResponseSurround       = zeros(numdisparities,1);

for j = 1:numdisparities
  center =  responses(N/4:3*N/4, N/4:3*N/4,j);
  sumResponseCenter(j) = sum(center(:));
end
Ncenter = power(N/2 + 1 ,2);
meanResponseCenter = sumResponseCenter / Ncenter;  
figure
plot(disparities, meanResponseCenter,  '-*b'); 
hold on

for j = 1:numdisparities
  center =  responses(N/4:3*N/4, N/4:3*N/4,j);
  sumResponseCenter(j) = sum(center(:));
end

for j = 1:numdisparities
   meanResponseSurround(j) = ...
       (sum(sum(responses(:, :,j))) - sumResponseCenter(j)) /  (N*N - power(N/2+1,2));
end

plot(disparities, meanResponseSurround,'*-r');
legend(['mean response in center square (disparity = ' num2str(disparitySquare) ') '], 'mean response in background (disparity = 0)');
xlabel('disparity tuning of Gabor family','FontSize',12);
ylabel('mean response of Gabor family ','FontSize',12);
title(['wavelength = ' num2str(M/k) ' ,  sigma = ' num2str(M/k/2) ' (pixels)'],'FontSize',12);

