%Yuanzhe Liu
%3/14/2019
ks = [1,3,5,7];
train_data = importdata('D:\hw2\optdigits_train.txt');
test_data = importdata('D:\hw2\optdigits_test.txt');
for i = 1 : 4
    fprintf('k = %d   ', ks(i));
    myKNN(train_data,test_data,ks(i));
end