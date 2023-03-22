function [U, S] = myPCA(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = principalComponentAnalysis(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

% You need to return the following variables correctly.
covMatrix = zeros(n,n);
U = zeros(n);
S = zeros(n);

% ====================== YOUR CODE GOES HERE ======================
% Instructions: You should first compute the covariance matrix. Then, 
%  compute the eigenvectors and eigenvalues of the covariance matrix. 
%
% Note that the dataset X is normalized, when calculating the covariance

%Calculation of the covariance matrix of the data
covMatrix = 1/m.*(transpose(X)*X);

%Getting the  eigenvalues and the eigenvectors from eig()
[tempU, tempS] = eig(covMatrix);

%Sorting eigenvectors with by their eigenvalues
[~,permutation]=sort(diag(tempS), 'descend');
tempS=tempS(permutation,permutation);
tempU=tempU(:,permutation);

%Matrices that we return
S = tempS;
U = tempU;
% =========================================================================

end
