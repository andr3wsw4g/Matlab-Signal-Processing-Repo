
t = 0.1:0.1:3;
xt = 1+cos(2*pi*t)/4 + cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;
plot(t,xt);
%fft(xt)
%plot(fft(xt))
coefficients = fourierSeries(xt);
oSize = length(xt);
xtcheck = invFourier(coefficients, t);
hold on
plot (t,xtcheck+0.1);
T = false(2,1);
T(1,1) = test_DTFS(xt,t,"1");
edgecase = [1,3,3,3,3,3,3,2,3,2,1,3,1,3,3,3,3,3,3,2,3,2,1,3,1,3,3,3,3,3];
et = 0.1:0.1:(length(edgecase)*0.1);
coefficients2 = fourierSeries(edgecase);
edgecheck = invFourier(coefficients2,et);
T(2,1) = test_DTFS(xt,t,"2");
load_summary(T);
function load_summary(T)
fprintf("Summary of results:\n");
    for i = 1:length(T)
        if T
            fprintf("Test " + num2str(i) + " Succeeded\n");
        else
            fprintf("Test " + num2str(i) + " Failed\n");
        end
    end
end
function check = test_DTFS(xt,t, test_name)
    check = is_appEq(invFourier(fourierSeries(xt),t),xt);
    if check
        fprintf("Test " + test_name + " Succeeded\n")
    else
        fprintf("Test " + test_name + " Failed\n")
    end
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
