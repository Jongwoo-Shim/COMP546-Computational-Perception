clear;
close all;

N = 1024;
x = 0:1:2048;
signal = sin((2*pi/N)*x); 

figure
plot(x,signal)
xlabel('X')
ylabel('Y')
title('Signal')

W = 1 - cos((2*pi/2048) * x);
figure
plot(x,W)
xlabel('X')
ylabel('Y')
title('Window')


newSignal = signal .* W;

figure
plot(x,newSignal);
title('window * signal');

figure 
plot(x,fft(signal));
title('F-Trans Signal');

figure
plot(x,fft(W));
title('F-Trans Window');

figure
plot(x,fft(newSignal));
title('F-Trans (Cos * Sin)');

figure
plot(x,(conv(fft(signal),fft(W),'same')))
title('Convulution of F-Trans(Cos * Sin)')