function v = fisherLinearDiscriminant(X1, X2)

	%number of features for each class
    numOfFeatures = size(X1, 2);
    %number of samples for each class
    m1 = size(X1, 1);
    m2 = size(X2, 1);
	
    for  i = 1 : numOfFeatures
        mu1(i) = sum(X1(:,i))*(1/m1);% mean value of X1
    end
    mu1 = mu1';%Turing mu1 to a column vector
    
    for  i = 1 : numOfFeatures
        mu2(i) = sum(X2(:,i))*(1/m2);% mean value of X2
    end
    mu2 = mu2';%Turing mu2 to a column vector
    
    %Scatter matrix of X1
    S1 = (1/m1).*(transpose(X1) * X1);
    
    %Scatter matrix of X2
    S2 = (1/m2).*(transpose(X2) * X2);
    
    %Sum of the Covariance Matrices*(a-priori p of each class) is the total within-class variance if the 2 classes
    p1 = m1/(m1+m2);
    p2 = m2/(m1+m2);
    Sw =p1*S1 + p2*S2;

    %optimal direction for maximum class separation 
    v = inv(Sw)*(mu1-mu2);
    v = v/norm(v);
