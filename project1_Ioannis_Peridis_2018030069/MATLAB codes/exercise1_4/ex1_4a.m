close all;
clear;
clc;

%These are the means of the 2 distributions 
m1 = [3 3];
m2 = [6 6];
%These are the covariance matrices of the 2 distributions
s1 = [1.2 -0.4; -0.4 1.2];
s2 = [1.2 0.4; 0.4 1.2];

%Axis
x1 = [0.1:0.01:10];
x2 = [0.1:0.01:10];
%Creation of the (x-y) grid in order to use the mvnpdf
[X1,X2] = meshgrid(x1,x2);

%Creation of the 3d normal pdf of the variable x1 and x2
Y1 = mvnpdf([X1(:) X2(:)],m1,s1);
%Reshaping so we will be able to plot in 3d and get the contours,because mvnpdf returns a vector and not a matrix
Y1_reshaped = reshape(Y1,length(x1),length(x2));

figure(1);
hold on;
title('\Sigma_1 \neq \Sigma_2 ');
contour(x1,x2,Y1_reshaped,'Color','g');

%We are following the same process for the 2nd distribution

%Creation of the 3d normal pdf of the variable x1 and x2
Y2 = mvnpdf([X1(:) X2(:)],m2,s2);
%Reshaping so we will be able to plot in 3d and get the contours,because mvnpdf returns a vector and not a matrix
Y2_reshaped = reshape(Y2,length(x1),length(x2));
contour(x1,x2,Y2_reshaped,'k');

for P1 = [0.1, 0.25 ,0.5, 0.75, 0.9]
    P2 = 1 - P1;
    y = (1.61*log(P1/P2)+18)./x1;
    plot(y,x1);
    axis([0 10 0 10]);
end
legend('\Sigma_1','\Sigma_2','P1 = 0.1','P1 = 0.25','P1 = 0.5','P1 = 0.75','P1 = 0.9');
hold off;