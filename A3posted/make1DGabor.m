function [gabor] = make1DGabor(N, k0, bandwidth)
%
% Returns an Nx1 1D complex Gabor with standard 
% deviation center frequency (k0) cycles per N samples   
% where k0 does not need to be an integer.
%
%  This Gabor has both real and imaginary parts, i.e. it is both a cosine 
%  Gabor and a sine Gabor.   So the response of the Gabor is a complex 
%  number.  The magnitude of the response is the sqrt of the sum of squares
%  of the cosine and sine Gabor responses just like the complex cells you
%  worked with earlier.   (When Hubel and Wiesel used the term 
%  "complex" cell, they did not have complex Gabors in mind.  The idea of
%  modelling with Gabors didn't come until a few decades after they
%  introduced the term.)
%
% The bandwidth of the Gaussian is defined here as twice the standard 
% deviation. Note that this is not defined by "half height".  
%

cosine = cos(2 * pi/ N * (0:(N-1)) * k0 ) ;
  sine = sin(2 * pi/ N * (0:(N-1)) * k0 ) ;

sigX =  N/ (2*pi) / (bandwidth/2);   %  sigX = N/(2 pi)/sigK

%  Define the Gabor to have origin x=0 at index (N/2 + 1).   

x = ((1:N) - (N/2 + 1));
Gaussian = 1/(sqrt(2*pi)*sigX) * ...
    exp(- x.*x/ (2 * sigX*sigX) );

cosGabor = Gaussian .* cosine;
sinGabor = Gaussian .* sine;
gabor = cosGabor + 1i * sinGabor;