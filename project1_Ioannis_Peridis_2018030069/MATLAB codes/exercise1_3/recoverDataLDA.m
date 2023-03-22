function [X_rec] = recoverDataLDA(Z, v)

% You need to return the following variables correctly.
X_rec = zeros(size(Z, 1), length(v));

% ====================== YOUR CODE HERE ======================
%Z contains the length of the projections of xi onto v and
%X_rec contains all scaled v's 
X_rec = Z * v';
% =============================================================

end
