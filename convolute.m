function Z = convolute(x, y)
Z = zeros(1,length(x) + length(y) - 1);
% Define x as a series of impulses
% Define y[] as the set of shifted and scaled y's due to each impulse of x
% Define z as the summation of shifted and scaled y's. AKA convolution.

% Constant interval for sampling
TIME_INTERVAL = 0.01;

% Handles the convolution of each impulse in x with Yy
for impulseOffset = 1:(length(x))
    % Handles building z using shifted and scaled y
    for indexY = 1:(length(y))
        indexShiftedY = impulseOffset + indexY - 1;
        scaleFactor = x(impulseOffset);
        Z(1, indexShiftedY) = Z(1, indexShiftedY) +  TIME_INTERVAL * scaleFactor * y(indexY);
    end
end
end