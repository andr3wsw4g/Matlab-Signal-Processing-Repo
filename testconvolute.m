xt = ones(1,100);
ht = 0.01:0.01:2;
a = length(xt);
Z = convolute(xt,ht)
Z(1,1) = Z(1,1)
a = conv(0.01*xt,ht)