%Yuanzhe Liu
%3/14/2019
function [Projmatrix, eigenvalue] = myLDA(data, num_principal_components)
[row,col]=size(data);
%sort samples by classes
class = unique(data(:,col)).';
count = length(class);
[all_c,order] = sort(data(:,col));
data_s = data(order,:);
len = zeros(1,count);
len(count) = row+1;
idx = 1;
all_c = all_c.';
i = 1;
%find out where the next class starts
for r = 1 : row
   if all_c(r) ~= class(i)
        len(i) = r;
        i = i + 1;
   end
end
len = [1,len];
Sw = zeros(col-1);
Sb = zeros(col-1);
m = mean(data_s(:,1:col-1));
for i = 1:count
    %get samples in a same class
    temp = data_s(len(i):len(i+1)-1,1:col-1);
    [row_t,col_t] = size(temp); 
    %count Sw and Sb
    Sw = Sw + cov(temp)*(row_t-1)/row_t;
    Sb = Sb + (mean(temp)-m).' * (mean(temp)-m) * row_t;
end
%calculate w and its eigenvalue as solution
prop = pinv(Sw) * Sb;
[V,D] = eig(prop);
D = diag(D).';
[~,order]=sort(D,'descend');
V = V(:,order);
D = D(:,order);
Projmatrix = V(:,1:num_principal_components);
eigenvalue = D(:,1:num_principal_components);
end