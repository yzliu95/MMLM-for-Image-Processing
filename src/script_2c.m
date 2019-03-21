%Yuanzhe Liu
%3/14/2019
train_data = importdata('D:\hw2\optdigits_train.txt');
test_data = importdata('D:\hw2\optdigits_test.txt');
%import data
[train_samples,data_columns]=size(train_data);
[test_samples,~]=size(test_data);
% PCA process, get all eigenvectors and eigenvalues
[PCA_matrix, eigenvalue] = myPCA(train_data,2);
m = mean(train_data(:,1:data_columns-1));
PCA_train_data = train_data(:,1:data_columns -1) - m;
PCA_test_data = test_data(:,1:data_columns -1) - m;
PCA_train_data = PCA_train_data * PCA_matrix;
PCA_test_data = PCA_test_data * PCA_matrix;
PCA_train_data = [PCA_train_data,train_data(:,data_columns)].';
PCA_test_data = [PCA_test_data,test_data(:,data_columns)].';
color = [0.5 0.5 0.5;0 0.5 0; 0 0 1;  0 1 0;  0 1 1;  1 0 0;  1 0 1;  1 1 0;  1 0.5 1;0 0.5 0.5];
subplot(1,2,1);
hold on;
axis([-40,40,-30,30]);
txt = ["0","1","2","3","4","5","6","7","8","9"];
b = zeros(1,10);
for i = 1 : train_samples
    if b(PCA_train_data(3,i) + 1) <= 10 
        b(PCA_train_data(3,i)+1) = b(PCA_train_data(3,i)+1) + 1;
        text(PCA_train_data(1,i),PCA_train_data(2,i),txt(PCA_train_data(3,i)+1),'Color',color(PCA_train_data(3,i)+1,:));
    end
    scatter(PCA_train_data(1,i),PCA_train_data(2,i),[],color(PCA_train_data(3,i)+1,:));
end
title('trainning data');
subplot(1,2,2);
hold on;
axis([-40,40,-30,30]);
b = zeros(1,10);
for i = 1 : test_samples
    if b(PCA_test_data(3,i) + 1) <= 10 
        b(PCA_test_data(3,i)+1) = b(PCA_test_data(3,i)+1) + 1;
        text(PCA_test_data(1,i),PCA_test_data(2,i),txt(PCA_test_data(3,i)+1),'Color',color(PCA_test_data(3,i)+1,:));
    end
    scatter(PCA_test_data(1,i),PCA_test_data(2,i),[],color(PCA_test_data(3,i)+1,:));
end
title('test data');