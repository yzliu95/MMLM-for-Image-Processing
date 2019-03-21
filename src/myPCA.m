%Yuanzhe Liu
%3/14/2019
%This is for Question2(b), takes in formatted data and number of PC,
%returns number of PC and corresponding eighenvalues. 
function [PrincComp, eigenvalue] = myPCA(data, num_principal_components)
[row,col]=size(data);
s = cov(data(:,1:col-1)) * (row - 1) / row;
[V,D] = eig(s);
D = diag(D).';
[~,order]=sort(D,'descend');
V = V(:,order);
D = D(:,order);
PrincComp = V(:,1:num_principal_components);
eigenvalue = D(:,1:num_principal_components);
end