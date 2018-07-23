%   contrastSensitivity.m  

clear; close all

% Which observer to use to perform the task (ideal or Gabor).

%observer = 'ideal';
observer = 'gabor';  

%  Length of signal.  

N = power(2,8);

%  choose the parameters of the Gabor
gabor = make1DGabor( N, 20, 4 );  

%  Choose the range of frequencies and sine amplitudes for the experiment.

frequencies = 1  :  5  : N/2;
amplitudes  = 2.^(-4:.5:4);  

numTrials = 200;

%  psychometric function 
pCorrect  = zeros(length(amplitudes),1);

threshold = zeros(length(frequencies), 1);

%  For each frequency and for each amplitude of the underlying sine,
%  run many trials.  

figure(1)
for kIndex = 1: length(frequencies)
    for amp = 1:length(amplitudes)
        
        numCorrect = 0;
        sinKx = sin( 2*pi/N * frequencies(kIndex) * (0:N-1));
        for trial = 1:numTrials

            %  create the images for this trial
            
            I1 = randn(1,N);
            I2 = randn(1,N);
            
            %  choose whether to add a sine to the first or second, 
            %  based on a coin flip
            
            if (rand > 0.5)
                whichOne = 1;
                I1 = I1 + amplitudes(amp) * sinKx;
            else
                whichOne = 2;
                I2 = I2 + amplitudes(amp) * sinKx;
            end
            
           switch  observer
               case 'ideal'  
                 numCorrect = numCorrect + idealObserver(I1, I2, whichOne);
               case 'gabor' 
                 numCorrect = numCorrect + gaborObserver(I1, I2, gabor, whichOne);
           end
        end
        
        pCorrect(amp) = 100*numCorrect / numTrials;
    end
    
    figure(1)
    plot(amplitudes, pCorrect, '*');
    ylabel('percent correct', 'fontsize',14);
    
    %  Quick and dirty method for computing a 75% threshold:  take
    %  the largest amplitude for which pCorrect is less than 75.
    %  If all amplitudes give pctcorrect less than 75, then returns the max
    %  amplitude.   If no amplitudes give pctcorrect less than 75, then task is
    %  too easy and return threshold 0.  i.e.  infinity sensitivity.
    %  Good enough for our purposes !
    
    threshold(kIndex) = max((pCorrect < 75) .* amplitudes');
    title( [' frequency k = ' num2str(frequencies(kIndex))], 'fontsize', 14 );
    xlabel('amplitude of sinusoid', 'fontsize', 14);
    axis( [amplitudes(1)  amplitudes( length(amplitudes) ) 0 100] )
    pause( 0.1)
end

%  plot the thresholds

figure(2)
for j = 1:length(frequencies)
    plot(frequencies(j), .5, '*r');
end
plot( frequencies, threshold, '*');
xlabel('frequency k', 'fontsize', 14);
ylabel('threshold', 'fontsize', 14);
%%
plot(abs(fft(gabor)));

