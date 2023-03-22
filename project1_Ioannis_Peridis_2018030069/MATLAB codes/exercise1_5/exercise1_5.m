close all;
clear;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');

%Get a matrix with all the images(training and testing)
 totalImages_train = cat(1,train_C1_images,train_C2_images );
 totalImages_test = cat(1,test_C1_images,test_C2_images);
 
%Plot two images. 1st Digit=1 and 2nd Digit=2)
 imageC1 = squeeze(train_C1_images(10,:,:));
 imageC2 = squeeze(train_C2_images(10,:,:));
 plotDigit(1,imageC1);
 plotDigit(2,imageC2);
 pause;
 
%============================================
%% Compute Aspect Ratio

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)

%Initialization of Aspect Ratio Vector
aRatio_train = [];
aRatio_test = [];

 for i =1 : size(totalImages_train,1 )
     image_in_train = squeeze(totalImages_train(i,:,:));
     aRatio_train = [aRatio_train computeAspectRatio(image_in_train)]; 
 end
 
 for i =1 : size(totalImages_test,1)
     image_in_test = squeeze(totalImages_test(i,:,:));
     aRatio_test = [aRatio_test computeAspectRatio(image_in_test)]; 
 end
 
 %Finding Minimum and Maximum aspect ratio accross all the images, also finding their indexes for using in plots
 [minAspectRatio, ind_min] = min(aRatio_train);
 [maxAspectRatio, ind_max] = max(aRatio_train);
 
%============================================
%% Bayesian Classifier

% Prior Probabilities
 totalSamples = size(totalImages_train,1);
 Class1samples = size(train_C1_images,1);
 Class2samples = size(train_C2_images,1);
 PC1 = Class1samples/totalSamples
 PC2 = Class2samples/totalSamples

% Likelihoods
%Calculation of mean and sigma for each class
%Given a class, the aspect ratio is Given from a normal distribution

%Claculation of the mean of aspect ratios for each class
mu = [mean(aRatio_train(1:Class1samples)) mean(aRatio_train(Class1samples+1:end))];

%Calculation of the standard deviation of the aspect ratios for each class
sigma = [sqrt(mean((aRatio_train(1:Class1samples)-mu(1)).^2))...
sqrt(mean((aRatio_train(Class1samples+1:end)-mu(2)).^2)) ];

% Generation of the p(x_i| C1) and  p(x_i| C1)
  PgivenC1 = normpdf(aRatio_test,mu(1),sigma(1));
  PgivenC2 = normpdf(aRatio_test,mu(2),sigma(2));

% Posterior Probabilities
 PC1givenL = PC1 * PgivenC1;
 PC2givenL = PC2 * PgivenC2;

% Classification result
 false_pred = 0;
   for i = 1 : size(totalImages_test,1)
      if PC1givenL(i) >= PC2givenL(i) 
          BayesClass(i) = 1;
      else 
          BayesClass(i) = 2;
      end
  end
 
 predictionsForClass1 = BayesClass(1:size(test_C1_images,1));
 predictionsForClass2 = BayesClass(size(test_C1_images,1)+1:end);
 falsePredClass1 = sum(predictionsForClass1==2);
 falsePredClass2 = sum(predictionsForClass2==1);
 
% Count misclassified digits
 count_errors = falsePredClass1 + falsePredClass2;

% Total Classification Error (percentage)
 Error = 100*(count_errors/size(totalImages_test,1))