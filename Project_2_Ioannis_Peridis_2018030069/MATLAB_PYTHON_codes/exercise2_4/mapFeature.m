function ret = mapFeature( X )
% Map Feature Summary of this function below
    [n,m] = size(X);
    ret = zeros(n,m);

    for i=1:n
        
        ret(i,1) = X(i,1)-(norm(X(i,:))^2) -4;
            
        ret(i,2)= X(i,2)-(norm(X(i,:))^2) -4;
        
    end

end
