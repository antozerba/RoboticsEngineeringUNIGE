%------------------------
%ZERBATO ANTONIO
%email addr: 8999827@studenti.unige.it 
%------------------------



clc;
clear;
close all;
addpath 'include'

%% Parameters
alfa = 1.4;
beta = 1.8;
gamma = 1.05;
m = 13.5;
J = 0.37;

%% Matrices
% Define the system matrices
A = [0,0,0,1,0,0;
     0,0,0,0,1,0;
     0,0,0,0,0,1;
     0,0,0,-alfa/m,0,0;
     0,0,0,0,-beta/m,0;
     0,0,0,0,0,-gamma/J
    ];
B = [0,0,0;
     0,0,0;
     0,0,0;
     1/m,0,0;
     0,1/m,0;
     0,0,1/J
     ];

%% Simulation
dt = 0.01; % integration step
t = 0:dt:10; % time vector

%% Input
u = zeros(3, length(t)); % input
u(1,:) = 3 * ones(1,length(t));
u(2,:) = 3 * ones(1,length(t));
u(3,:) = 2 * ones(1,length(t));

%% Initial state
x0 = [1;2;3;0;0;0]; % initial state

%% Simulation using analytical formula
x = SimulateSysAnalytical(A, B, u, t, x0, dt);

%% Simulation using Euler integration
xEuler = SimulateSysEuler(A, B, u, t, x0, dt);

%ANALITICAL EVOLUTION
%The evolution of the the state system shows in the figure seems
%reasonable with the data provided. For the implementation of the system
%the the first three variables are strongly linked to the last ones.
%As we can see from the graph the x_3 var, the angle, grows linearly
%after some time. This reflects its correlation with the x_6 var,
%the angular velcity, which stays constant during time. The some logics
%applys to the other variables. 
figure;
plot(t, x(1,:), 'r', 'DisplayName', 'x_1'); % x position
hold on;
plot(t, x(2,:), 'b', 'DisplayName', 'x_2'); % y position
hold on;
plot(t, x(3,:), 'g', 'DisplayName', 'x_3'); % angle
hold on;
plot(t, x(4,:), 'c', 'DisplayName', 'x_4'); % x linear velocity
hold on;
plot(t, x(5,:), 'm', 'DisplayName', 'x_5'); % y linear velocity
hold on;
plot(t, x(6,:), 'y', 'DisplayName', 'x_6'); % w angular velocity

xlabel('t[s]');
ylabel('x');
title('System state (analytical formula)');
legend;
grid on;

%EULER EVOLUTION
%The differences between the analitical and the euler representation are
%barely noticeable.  
figure;
plot(t, xEuler(1,:), 'r', 'DisplayName', 'x_1'); % x position
hold on;
plot(t, xEuler(2,:), 'b', 'DisplayName', 'x_2'); % y position
hold on;
plot(t, xEuler(3,:), 'g', 'DisplayName', 'x_3'); % angle
hold on;
plot(t, xEuler(4,:), 'c', 'DisplayName', 'x_4'); % x linear velocity
hold on;
plot(t, xEuler(5,:), 'm', 'DisplayName', 'x_5'); % y linear velocity
hold on;
plot(t, xEuler(6,:), 'y', 'DisplayName', 'x_6'); % w angular velocity


xlabel('t[s]');
ylabel('x');
title('System state (Euler integration)');
legend;
grid on;

% Plot difference in percentage of Euler - analytical
%The percentage difference between the two methos are really small(the max value is 3%, the angular velocity),  even if they are not of the same order. This
%indicates that the chosen integration step is sufficient little to ensure
%a good approximation of the analitical representation. 
figure;
plot(t, (xEuler(1,:) - x(1,:))./x(1,:) * 100, 'r', 'DisplayName', 'x_1');
hold on;
plot(t, (xEuler(2,:) - x(2,:))./x(2,:) * 100, 'b', 'DisplayName', 'x_2');
hold on;
plot(t, (xEuler(3,:) - x(3,:))./x(3,:) * 100, 'g', 'DisplayName', 'x_3');
hold on;
plot(t, (xEuler(4,:) - x(4,:))./x(4,:) * 100, 'c', 'DisplayName', 'x_4');
hold on;
plot(t, (xEuler(5,:) - x(5,:))./x(5,:) * 100, 'm', 'DisplayName', 'x_5');
hold on;
plot(t, (xEuler(6,:) - x(6,:))./x(6,:) * 100, 'y', 'DisplayName', 'x_6');
xlabel('t[s]');
ylabel('Difference perce3ntage %');
title('State estimation difference percentage % (Euler - analytical)');
legend;
grid on;

% 
% The only value which changes is w cuase its time costant is very low compared to the other (considering a dt= 0.01), this means that the state evolves rapidally and
% the Euler approximation is not very good, whereas the Anatyical way performs better cause its more accurate but more computatational complex. 