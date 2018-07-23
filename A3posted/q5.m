clear;
close all;
x = zeros(1,32);
x(1,[5,9,13,17,21,25,29]) = [1,1,1,1,1,1,1];
xlim([0,31])
figure(1)
plot(0:31,x)
y = fft(x);
figure(2)
plot(0:31,y)