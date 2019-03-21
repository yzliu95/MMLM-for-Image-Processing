%Yuanzhe Liu
%3/14/2019
train_data = importdata('D:/hw2/face_train_data_960.txt');
test_data= importdata('D:/hw2/face_test_data_960.txt');
[train_samples,data_columns]=size(train_data);
[test_samples,~]=size(test_data);
train_data = [train_data;test_data];
% PCA process, get all eigenvectors and eigenvalues
[eigenv, ~] = myPCA(train_data,data_columns-1);
m = mean(train_data(:,1:data_columns-1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = [10,50,100];
for j = 1:3
    faces = train_data(1:5,1:end-1);
    W = eigenv(:,1:K(j)); 
    faces = (faces(:,1:data_columns -1) - m)*W*W.' + m;
    for i = 1 : 5
        s = sprintf('K=%d, Img%d', K(j), i);
        subplot(3,5,(j-1)*5+i);
        imagesc(reshape(faces(i,:),32,30)');
        title(s);
    end
end



