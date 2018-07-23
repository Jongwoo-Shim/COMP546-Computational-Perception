clear;
close all;
S = [0 0 0 -1 -1 0 0 0]
shiftedS = fftshift(S);
shiftedS;
Y = fft([1 0 0 0 0 0 0 1]);
figure(1)
plot([1:8],Y);

N = 64;
x = zeros(1,N);
x(1,[N/2,N/2 + 1, N/2 + 2]) = [-1,1,-1];
xshifted = fftshift(x);
y = fft(xshifted);
figure(2)
plot(1:64 , y(1:64))