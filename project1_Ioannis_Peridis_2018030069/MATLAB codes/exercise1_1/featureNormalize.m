function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

%Initializing all the variables used
N = size(X,1);
numOfFeat = size(X,2);

mu = zeros (1,numOfFeat);
sigma = zeros (1,numOfFeat);
X_norm = zeros(N,numOfFeat);

for i = 1 : numOfFeat
    mu(i) = sum(X(:,i))/ N;% mean of each column (feature)
end

for i = 1 : numOfFeat
    sigma(i) = sqrt(sum(((X(:,i)-mu(i)).^2))/(N-1));% standart deviation of each column
end

for k = 1 : numOfFeat
    
    for i= 1 : N
       X_norm(i,k) = (X(i,k) - mu(k))/sigma(k);% normalize each column independently 
    end
  
end

% ============================================================

end
