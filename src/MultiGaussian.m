%Yuanzhe Liu
%3/14/2019
%Model 1 Assumes S1 and S2 are independent
%Model 2 Assumes S1 = S2
%Model 3 Assumes S = aI (equal on diagonal)
function [PC1,PC2,m1,m2,S1,S2] = MultiGaussian(training_data,testing_data,Model)
%----------import data---------------
train_set = importdata(training_data);
test_set = importdata(testing_data);
%----------variable declarition--------------
[samples,params] = size(train_set);
[samples_test,p] = size(test_set);
params = params -1;
C1 = [];
C2 = [];
N1 = 0;
N2 = 0;
%seperate by class
for row = 1 : samples
    if train_set(row,params+1) == 1
        C1 = [C1;train_set(row,1:params)];
        N1 = N1 + 1;
    else
        C2 = [C2;train_set(row,1:params)];
        N2 = N2 + 1;
    end
end
%calculate necessary parameters for all 3 models
m1 = mean(C1);
m2 = mean(C2);
S1 = cov(C1)*(N1-1)/N1;
S2 = cov(C2)*(N2-1)/N2;
PC1 = N1 / samples;
PC2 = N2 / samples;
error_rate = 0;
a1 = 0;
a2 = 0;
%calculate revised S1 and S2 for model 2
if Model == 2
    S1 = S1*PC1 + S2*PC2;
    S2 = S1;
end
%calculate revised S1 and S2 for model 3
if Model == 3
   for i = 1 : params
       a1 = a1 + S1(i,i);
       a2 = a2 + S2(i,i);
   end
   a1 = a1 / params;
   a2 = a2 / params;
   S1 = a1* eye(params);
   S2 = a2* eye(params);
end
%for all test samples, calculate the discriminate value and compare with
%the real value
for row = 1 : samples_test
    t = test_set(row,1:params); %test sample features
    g1 = -0.5*log(det(S1)) - (0.5*(t-m1) * inv(S1) * transpose(t-m1)) + log(PC1);
    g2 = -0.5*log(det(S2)) - (0.5*(t-m2) * inv(S2) * transpose(t-m2)) + log(PC2);
    if g1-g2 > 0
        if test_set(row,p) == 2
            error_rate = error_rate + 1;
        end
    else
        if test_set(row,p) == 1
            error_rate = error_rate + 1;
        end
    end
end
error_rate = error_rate / samples_test;
%Model 3 requires to return alpha1 and alpha2
if Model == 3
    S1 = a1;
    S2 = a2;
end
%print parameters to terminal
fprintf('P(C1)=%2.2f, P(C2)=%2.2f\n',PC1,PC2);
disp('mu1:');
disp(m1);
disp('mu2:');
disp(m2);
if Model ~= 3
    disp('S1');
    disp(S1);
    disp('S2');
    disp(S2);
else
    disp('alpha1');
    disp(S1);
    disp('alpha2');
    disp(S2);
end
fprintf('error rate = %2.2f\n', error_rate);
end