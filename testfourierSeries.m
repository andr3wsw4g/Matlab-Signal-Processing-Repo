 t = 0.1:0.1:3;
xt = 1+cos(2*pi*t)/4 + cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;
plot(t,xt);
%fft(xt)
%plot(fft(xt))
coefficients = fourierSeries(xt);
oSize = length(xt);
xtcheck = invFourier(coefficients, t);
hold on
plot (t,xtcheck+0.1)
T1 = false;
if is_appEq(xt,xtcheck);
    fprintf("First Test Passed.\n")
    T1 = true;
end
edgecase = [1,3,3,3,3,3,3,2,3,2,1,3,1,3,3,3,3,3,3,2,3,2,1,3];
et = 0.1:0.1:(length(edgecase)*0.1)
coefficients2 = fourierSeries(edgecase);
edgecheck = invFourier(coefficients2,et);
T2 = false;
if is_appEq(edgecase, edgecheck);
    fprintf("Second Test Passed.\n")
    T2 = true;
end
fprintf("Printing summary of results.\n")
fprintf("First test:")
if T1
    fprintf(" True \n")
else
    fprintf(" False \n")
end
    fprintf("Second test:")
if T2
    fprintf(" True \n")
else
    fprintf(" False \n")
end


function eq = is_appEq(arr1,arr2); %function to check if arr1 close toarr2
eq = true;
if length(arr1) ~= length(arr2);
    eq = false;
end
for i=1:length(arr1)
    if (eq== false)
        break
    end
    %Below is a long if statement that checks whether the diff.
    %between the real and imaginary parts is less than 10^-6
    eq = eq && ( (real(arr1(i)-arr2(i))^2 < 10^-12) &&((imag(arr1(i)-arr2(i))^2 < 10^-12)));
end
end
