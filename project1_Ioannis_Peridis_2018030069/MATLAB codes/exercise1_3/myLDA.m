function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes)  %The number of classes
    totalSamples = size(Samples, 1);%The number of total samples
    %Within class scatter matrix
    Sw = zeros(NumFeatures,NumFeatures);
    Sb = zeros(NumFeatures,NumFeatures);

    %For each class i
	%Find the necessary statistics
    classSamples = zeros(1,NumClasses);
	
    for i = 1 : NumClasses
        classSamples(i) = sum(Labels == Classes(1)); 
        P(i) = classSamples(i)/totalSamples;%Calculate the Class Prior Probability
    end
	
    %Calculate the Class Mean 
    for i = 1 : NumClasses
        %getting the samples of i-th class
        samplesOfClassi = Samples(Labels == Classes(i),:);
        %average over columns(features) for i-th class
        mu(i,:) = mean(samplesOfClassi , 1); 
    end
    
    
    %This is the calculation of  the Within Class Scatter Matrix
    for i = 1 : NumClasses
        %Getting the samples of i-th class
        samplesOfClassi = Samples(Labels == Classes(i),:);
        %Calculating the within class covariance matrix for i-th class
        Si = (1/classSamples(i)).*(transpose(samplesOfClassi)*samplesOfClassi);
        %Calculating the total within class scatter matrix
        Sw = Sw + (P(i)* Si);
    end
    
    %This is the calculation of the Global Mean
	m0= mean(mu);
   
    %This is the calculation ofthe Between Class Scatter Matrix
	 for i = 1 : NumClasses
         Sb = Sb + P(i)* (transpose(mu(i,:) - m0) * (mu(i,:) - m0));
     end
    
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    
    %Perform Eigendecomposition
	%This is the calculation of the U that contains the eigenvectors
    %This is the calculation of S that contains the eigenvalues in its diagonal
    [tempU, tempS] = eig(EigMat);

    %Sorting eigenvectors by their eigenvalues
    [~,permutation]=sort(diag(tempS), 'descend');
    tempS=tempS(permutation,permutation);
    tempU=tempU(:,permutation);
	
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors
	A = tempU(:, 1:NewDim);
