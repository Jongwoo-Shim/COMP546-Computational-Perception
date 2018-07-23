function [Ileft, Iright] = mkRandomDotStereogram(N,disparitySquare,corr)
%  Make a random dot stereogram with a central square protruding from a 
%  plane.  The plane has disparity = 0.  The central square has some positive
%  disparity.

    if ~exist('corr','var')
        corr = true;
    end

    Ileft = rand(N,N);
    Iright = Ileft;
    Iright(N/4:3*N/4, N/4:3*N/4) = Ileft(N/4:3*N/4, N/4  + disparitySquare: ...
                                                    3*N/4 + disparitySquare);
    Iright(N/4:3*N/4, 3*N/4+1:3*N/4+disparitySquare) = rand(N/2+1, disparitySquare);

    %  Make the intensities either -1, 0, 1, and in particular,  the mean is 0.   
    %  The reason is that a cos Gabor has a positive response to a non-zero mean whereas a 
    %  sine Gabor has no response to a non-zero mean.   So, if the image has
    %  a mean different from 0,  then the cosGabor will give a much greater
    %  response than the sine Gabor.    This is a technicality that I am taking care of
    %  for you.  I don't wan't to bother you with it, at least not now. 

    Ileft  =  -1.0 * (Ileft < 0.25)  + 1.0 * (Ileft > 0.75);    %  and 0 if  .25 < I < .75
    Iright =  -1.0 * (Iright < 0.25) + 1.0 * (Iright > 0.75);   %  and 0 if  .25 < I < .75

    if ~corr
     Iright = -1 * Iright;   
    end
    
end