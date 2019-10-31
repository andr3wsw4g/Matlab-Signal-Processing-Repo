
function Z = convolute(x, y)
Z = zeros(1,length(x) + length(y) - 1);
%Using the sampling property
%Convolution becomes length(x)*length(y) summations
for indX = 1:(length(x))
    for indY = 1:(length(y))
        %The (-1) on the Z index is because MATLAB ARRAYS start at 1
        %Indexing of c+d to store where the addition is stored
        Z(1,indX+indY-1) = Z(1,indX+indY-1) +  0.01*x(indX)*y(indY);
    end
end
end