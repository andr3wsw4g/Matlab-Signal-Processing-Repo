xt = ones(1,100);%function x(t)
ht = 0.01:0.01:2;%function h(t)
Zt = convolute(xt,ht);%function Z(t), convoluted function
cCheck = conv(0.01*xt,ht);%Our check for our test
Zt; %comment out if you want to print @MickeyDang
cCheck; %comment out if you want to print @MickeyDang
T = false(2,1);
T(1,1) = test_convolute(xt,ht,"1"); %Bool for Test 1


%Run Test two 
t = 0.01:0.01:2;
sint = sin(2*pi*t);
cost = cos(2*pi*t);
T(2,1) = test_convolute(xt,ht,"2"); %Bool for Test two

%Load Summary
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
function check = test_convolute(xt,ht, test_name)
    check = is_appEq(conv(0.01*xt,ht),convolute(xt,ht));
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
