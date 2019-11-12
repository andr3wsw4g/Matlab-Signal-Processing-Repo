% This file checks both the analysis and synthesis equations of the fourier series

hold off

% Boolean array of test cases
T = false(2,1);

% Test 1. Happy path.
t = 0.1:0.01:3;
xt = 1+cos(2*pi*t)/4 + cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;
% expected value
plot(t,xt);
hold on

coefficients = fourierSeries(xt);
xtcheck = invFourier(coefficients, t);

% actual value (shifted up by 0.1 for comparison)
plot(t,xtcheck + 0.1);
hold on

% Assert whether expected == actual
T(1,1) = test_DTFS(xt,t,"1");

% Test 2. Edge case with period.
edgecase = [1,3,3,3,3,3,3,2,3,2,1,3,1,3,3,3,3,3,3,2,3,2,1,3,1,3,3,3,3,3];
et = 0.1:0.1:(length(edgecase)*0.1);
coefficients2 = fourierSeries(edgecase);
edgecheck = invFourier(coefficients2,et);
T(2,1) = test_DTFS(xt,t,"2");


load_summary(T);

% Helper Functions Below

% Prints summary of results for test cases
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

% Assert function
function check = test_DTFS(xt,t, test_name)
    check = is_appEq(invFourier(fourierSeries(xt),t),xt);
    if check
        fprintf("Test " + test_name + " Succeeded\n")
    else
        fprintf("Test " + test_name + " Failed\n")
    end
end

% check if arr1 close to arr2
function eq = is_appEq(arr1,arr2); 
    eq = true;

    if length(arr1) ~= length(arr2);
        eq = false;
    end

    for i=1:length(arr1)
        if (eq== false)
            break
        end
        % Checks whether the diff between the real and imaginary parts is less than 10^-6
        eq = eq && ( (real(arr1(i)-arr2(i))^2 < 10^-12) &&((imag(arr1(i)-arr2(i))^2 < 10^-12)));
    end

end
