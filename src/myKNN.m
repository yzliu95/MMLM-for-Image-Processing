%Yuanzhe Liu
%3/14/2019
function [pred] = myKNN(train_set,test_set,k)
%variable declaration
[sample_train, params] = size(train_set);
[sample_test, category] = size(test_set);
params = params -1;
err = 0;
pred = [];
%test all samples...
for row_test = 1:sample_test
   nearest = zeros(2,k);
   %first fill the nearest k neighbors with their categories and their
   %distance
   for row_train = 1:k
       nearest(1,row_train) = train_set(row_train,category);
       nearest(2,row_train) = norm(test_set(row_test,1:params) - train_set(row_train,1:params));
   end
   %for the rest of samples in training data, if the new distance is
   %shorter than the max distance in the KNNs, replace it
   for row_train = k:sample_train
       d = norm(test_set(row_test,1:params) - train_set(row_train,1:params));
       [max_v,idx] = max(nearest(2,:));
       if d < max_v
          nearest(1,idx) =  train_set(row_train,category);
          nearest(2,idx) = d;
       end
   end 
   prediction = mode(nearest(1,:));
   pred = [pred;prediction]; %append for output
   if prediction ~= test_set(row_test,category)
       err = err + 1;
   end   
end
%print error rate to terminal
err = err / sample_test;
disp('error rate : ');
disp(err);
end