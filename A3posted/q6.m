close all
file = 1;
switch file
    case 1
        [y,Fs] = audioread('audioclip-1523676650.jpg');
    case 2
        [y, Fs]  = audioread('Eeeee.wav');
    case 3
        [y,Fs] = audioread('crumple.wav');
    case 4
        [y,Fs] = audioread('Hello.wav');
end    
%sound(y,Fs); 
transform = fft(y);
figure(1)
plot(log(1:5000) * 44100/5000 , transform(1:5000));
xlabel('Frequency')
ylabel('Amplitude')
title('A')
figure(2)
spectrogram(y,256,0,256,44100)
view([90, -90])
title('A - 256')

figure(3)
spectrogram(y,16384,0,16384,44100)
view([90, -90])
title('A - 16384')
%spectrogram(signal, samplesPerBlock, 0, freqPerBlock, samplingRate )