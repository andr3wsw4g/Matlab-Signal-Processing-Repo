 t = 0.1:0.1:3;
xt = 1+cos(2*pi*t)/4 + cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;
plot(t,xt)
%fft(xt)
%plot(fft(xt))
appfourier(xt);
