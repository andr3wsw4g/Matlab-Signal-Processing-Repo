
function fourier = fourierSeries(xt)
%THIS PORTION WILL HAVE TO DO THE PEAK APPROXIMATION
%this array contains: the derivative of the function at different points

T = find_period(xt)
fourier = fourierapp(xt, T);
end
function p = find_period(xt)
p = length(xt);
[m] = (max(xt));
[M,iI] = find(xt==m);
I = zeros(length(iI)-1,1);

for d=2:length(iI);
    I(d-1,1) = iI(d) - iI(1);
end
I(1,1) = I(1,1);
%Try every peak distance and check the period
for i = 1:length(I) ;
    
    for j = 1 : length(xt) - I(i,1);
        if xt(j) ~= xt(j +I(i,1));
            break;
        else if (j) ==length(xt) - I(i,1);
                %fprintf("Got here at i:")
                %i
                %fprintf("and j:")
                %j
            p = I(i,1);
            break
        end
    end
    if p ~= length(xt);
        break
    end
    end
end
end

function coefficients = fourierapp(xt,T)
if T <= 1
    

else
wo = 2*pi/T;
coefficients = zeros(T,1);
for k = 1:(T)
    for j = 1:(T)
        coefficients(k) = coefficients(k) + 1/T*xt(j)*(exp(-1.0i*j*wo*(k)));
    end
end
end
end



   
    