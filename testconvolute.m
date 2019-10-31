xt = ones(1,100);%function x(t)
ht = 0.01:0.01:2;%function h(t)
Zt = convolute(xt,ht);%function Z(t), convoluted function
cCheck = conv(0.01*xt,ht);%Our check for our test
Zt %comment out if you want to print @MickeyDang
cCheck %comment out if you want to print @MickeyDang
T1 = false; %Bool for Test 1
if is_appEq(Zt,cCheck) %Easier to set a tolerance because MATLAB has negative 0's
    fprintf("Test1 has passed. Convolution matches with conv(xt,ht)");
    T1 = true;
end

%Run Test two 
t = 0.01:0.01:2
sint = sin(2*pi*t);
cost = cos(2*pi*t);
Z2 = convolute(sint,cost);
cCheck2 = conv(.01*sint,cost);
Z2 %comment out if you want to print @MickeyDang
cCheck2 %comment out if you want to print @MickeyDang
T2 = false; %Bool for Test two
if is_appEq(Z2,cCheck2)
    fprintf("Test2 has passed. Convolution matches with conv(xt,ht)\n");
    T2 = true;
end
%Load Summary
fprintf("Summary of Test Results:\n")
if T1
    fprintf("Test1: Success\n")
else
    fprintf("Test1: Failed\n")
end
if T2
    fprintf("Test2: Success\n")
else
    fprintf("Test2: Failed\n")
end
    
function a = is_appEq(arr1,arr2);
check = (arr1 > arr2 -10^(-6));
check2 = (arr1 < arr2 +10^(-6));
a = isequal(check,check2)
end