%Yuanzhe Liu
%3/14/2019
train_data = importdata('D:\hw2\optdigits_train.txt');
test_data = importdata('D:\hw2\optdigits_test.txt');
%import data
[train_samples,data_columns]=size(train_data);
[test_samples,~]=size(test_data);
% LDA process, get all eigenvectors and matrix
[LDA_matrix, eigenvalue] = myLDA(train_data,2);
m = mean(train_data(:,1:data_columns-1));
LDA_train_data = train_data(:,1:data_columns -1) - m;
LDA_test_data = test_data(:,1:data_columns -1) - m;
LDA_train_data = LDA_train_data * LDA_matrix;
LDA_test_data = LDA_test_data * LDA_matrix;
LDA_train_data = [LDA_train_data,train_data(:,data_columns)].';
LDA_test_data = [LDA_test_data,test_data(:,data_columns)].';
color = [0.5 0.5 0.5;0 0.5 0; 0 0 1;  0 1 0;  0 1 1;  1 0 0;  1 0 1;  1 1 0;  1 0.5 1;0 0.5 0.5];
subplot(1,2,1);
hold on;
axis([-4,4,-4,4]);
txt = ["0","1","2","3","4","5","6","7","8","9"];
b = zeros(1,10);
for i = 1 : train_samples
    if b(LDA_train_data(3,i) + 1) <= 10 
        b(LDA_train_data(3,i)+1) = b(LDA_train_data(3,i)+1) + 1;
        text(LDA_train_data(1,i),LDA_train_data(2,i),txt(LDA_train_data(3,i)+1),'Color',color(LDA_train_data(3,i)+1,:));
    end
    scatter(LDA_train_data(1,i),LDA_train_data(2,i),[],color(LDA_train_data(3,i)+1,:));
end
title('trainning data');
subplot(1,2,2);
hold on;
axis([-4,4,-4,4]);
b = zeros(1,10);
for i = 1 : test_samples
    if b(LDA_test_data(3,i) + 1) <= 10 
        b(LDA_test_data(3,i)+1) = b(LDA_test_data(3,i)+1) + 1;
        text(LDA_test_data(1,i),LDA_test_data(2,i),txt(LDA_test_data(3,i)+1),'Color',color(LDA_test_data(3,i)+1,:));
    end
    scatter(LDA_test_data(1,i),LDA_test_data(2,i),[],color(LDA_test_data(3,i)+1,:));
end
title('test data');