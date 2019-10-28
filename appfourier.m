
function appfourier(xt)
%THIS PORTION WILL HAVE TO DO THE PEAK APPROXIMATION
%this array contains: the derivative of the function at different points
nt = xt/max(xt);
[m] = (max(xt));
[M,I] = find(xt==m);
dI = zeros(length(I)-1,1);

for d=2:length(I);
    dI(d-1) = I(d) - I(1);
end
%dI(1) = dI(1)
T = find_period(xt,dI)
ans = fourierapp(xt, T)
%exp = exp(2*pi/6.*t*k)
end
function p = find_period(xt, I)
p = 0
%Try every peak distance and check the period
for i = 1:length(I) ;
    for j = 1 : length(xt) - I(i);
        if xt(j) ~= xt(j +I(i));
            j = length(xt)- I(i);
        else if (j) ==length(xt) - I(i);
            p = I(i)
            break;
        end
    end
    if p ~= 0
        break
    end
    end
end
end

function ak = fourierapp(xt,T)
wo = 2*pi/T;
ak = zeros(2*length(xt)-1,1);
for k = 1: length(ak)
    for j = 1:length(T)
        ak(k) = ak(k) + 1/T*xt(j)*(exp(1.0i*j*wo*(k - length(xt)-1))) ;
    end
end
end

    
    