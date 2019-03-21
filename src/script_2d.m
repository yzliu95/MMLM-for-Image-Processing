%Yuanzhe Liu
%3/14/2019
train_data = importdata('D:\hw2\optdigits_train.txt');
test_data = importdata('D:\hw2\optdigits_test.txt');
[train_samples,data_columns]=size(train_data);
[test_samples,~]=size(test_data);
lda = [2,4,9];
k = [1,3,5];
m = mean(train_data(:,1:data_columns-1));
%%%%%%   testing    %%%%%%%%%
for lda_iter = lda
[W,~]=myLDA(train_data,lda_iter);
    for k_iter = k
    LDA_train_data = (train_data(:,1:data_columns -1)-m) * W;
    LDA_test_data = (test_data(:,1:data_columns -1)-m) * W;
    LDA_train_data = [LDA_train_data,train_data(:,data_columns)];
    LDA_test_data = [LDA_test_data,test_data(:,data_columns)];
    fprintf('L = %d, k = %d   ', lda_iter,k_iter);
    myKNN(LDA_train_data,LDA_test_data,k_iter);
    end
end
