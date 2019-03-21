%Yuanzhe Liu
%3/14/2019
faces_train_data = importdata('D:/hw2/face_train_data_960.txt');
faces_test_data= importdata('D:/hw2/face_test_data_960.txt');
faces_data = [faces_train_data;faces_test_data];
[row,col] = size(faces_data);
[eigenface,~] = myPCA(faces_data,5);
eigenface = eigenface.';
for i = 1 : 5
    subplot(1,5,i);
    imagesc(reshape(eigenface(i,:),32,30)');
end