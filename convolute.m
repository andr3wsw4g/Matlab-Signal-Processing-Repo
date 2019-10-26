
function Z = convolute(x, y)
Z = zeros(length(x) + length(y) - 1,1);
for c = 1:(length(x))
    for d = 1:(length(y))
        Z(c+d-1,1) = Z(c+d-1,1) +  0.01*x(c)*y(d);
    end
end
end