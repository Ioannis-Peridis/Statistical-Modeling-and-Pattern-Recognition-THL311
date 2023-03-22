close all;clc;clear all;

X = [1 1; -1 1; 1 -1; -1 -1;  2 2; -2 2; 2 -2; -2 -2;  ];
Xa = mapFeature(X);
%%%%%%%%%%%%%%%%
figure(1);
grid on;
axis([-5 5 -5 5]);
xlabel('x1');
ylabel('x2');

hold on;
plot(X(1:4,1),X(1:4,2), 'bo');
plot(X(5:8,1),X(5:8,2), 'ro');
hold off;
%%%%%%%%%%%%%%%%
figure(2);
grid on;
xlabel('x1');
ylabel('x2');
axis([-15 0 -15 0]);
hold on;
plot(Xa(1:4,1),Xa(1:4,2), 'bo');
plot(Xa(5:8,1),Xa(5:8,2), 'ro');
hold off;