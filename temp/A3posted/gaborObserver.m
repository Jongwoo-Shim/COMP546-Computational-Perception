%   gaborObserver.m
%
%   takes two signals as input, convolves with a Gabor function, 
%   chooses which has larger response and then outputs 1 if the larger
%   response indeed contains the sinusoidal signal (whichOne) and 0 if
%   the one that gives larger response did not contain the signal.  

function [response] = gaborObserver( I1, I2, gabor, whichOne )
%
%  Note that the Gabor here is complex Gabor.  It has both real and
%  imaginary parts.

response1 = mean( abs( conv(I1, gabor, 'same')));
response2 = mean( abs( conv(I2, gabor, 'same')));

if response1 > response2
    %  observer responds 1
    response = (whichOne == 1);
else
    %  observer responds 2
    response = (whichOne == 2);
end