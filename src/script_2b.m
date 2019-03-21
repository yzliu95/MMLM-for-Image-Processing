%Yuanzhe Liu
%3/14/2019
train_data = importdata('D:\hw2\optdigits_train.txt');
test_data = importdata('D:\hw2\optdigits_test.txt');
[train_samples,data_columns]=size(train_data);
[test_samples,~]=size(test_data);
% PCA process, get all eigenvectors and eigenvalues
[eigenvector, eigenvalue] = myPCA(train_data,data_columns-1);
% calculate principle components that covers 90% of variance
percent = 0;
sum_eigenvalues = sum(eigenvalue);
iter_eigenvalues = 0;
num_pc = 0;
s = 0;
y = [];
for i = 1 : data_columns -1
s = s + eigenvalue(1,i);
y = [y,s/sum_eigenvalues];
end
plot(y,'-o');
while percent < 0.9
    num_pc = num_pc + 1;
    iter_eigenvalues = iter_eigenvalues + eigenvalue(1,num_pc);
    percent = iter_eigenvalues / sum_eigenvalues;
end
% PCA process for training data and test data
PCA_matrix = eigenvector(:,1:num_pc);
m = mean(train_data(:,1:data_columns-1));
PCA_train_data = train_data(:,1:data_columns -1) - m;
PCA_test_data = test_data(:,1:data_columns -1) - m;
PCA_train_data = PCA_train_data * PCA_matrix;
PCA_test_data = PCA_test_data * PCA_matrix;
PCA_train_data = [PCA_train_data,train_data(:,data_columns)];
PCA_test_data = [PCA_test_data,test_data(:,data_columns)];
%%%%%%   testing    %%%%%%%%%
ks = [1,3,5,7];
fprintf('min number of principle components that covers 0.9 variance: %d \n',num_pc);
for i = 1 : 4
    fprintf('k = %d   ', ks(i));
    myKNN(PCA_train_data,PCA_test_data,ks(i));
end
