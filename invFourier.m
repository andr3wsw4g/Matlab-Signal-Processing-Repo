% coefficients and time are both vector inputs
function OFunction = invFourier(coefficients, time)
    wo = 2*pi/length(coefficients);
    OFunction = zeros(length(time),1);

    for t = 1:length(time)
        for k = 1:length(coefficients)
            OFunction(t,1) = OFunction(t,1) + coefficients(k) * (exp(1j * k * t * wo));
        end
    end

end
