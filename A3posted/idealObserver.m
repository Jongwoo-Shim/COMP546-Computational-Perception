%   idealObserver.m
%
%   

function [response] = idealObserver( I1, I2, whichOne )

%  compare the maximum Fourier coefficient to the mean for each image
%  (If the two images have the same noise, then you could just as easily
%  compare only the maximum Fourier coefficients)

t1 = max( abs(fft(I1))) / mean( abs( fft(I1) ));
t2 = max( abs(fft(I2))) / mean( abs( fft(I2) ));

if (t1 > t2)
    response = (whichOne == 1);
else
    response = (whichOne == 2);
end