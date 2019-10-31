function OFunction = invFourier(coefficients, time)
wo = 2*pi/length(coefficients);
OFunction = zeros(length(time),1);
for j =1:length(time)
    for k = 1:length(coefficients)
        OFunction(j,1) = OFunction(j,1) + coefficients(k)*(exp(1.0i*k*j*wo));
    end
end
end
