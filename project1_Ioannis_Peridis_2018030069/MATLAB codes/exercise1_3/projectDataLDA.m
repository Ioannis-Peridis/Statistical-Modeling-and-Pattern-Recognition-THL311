function [Z] = projectDataLDA(X, v)

% You need to return the following variables correctly.
Z = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% variable Z has the length of the projection onto v (dot product)
Z = X*v;
% =============================================================

end