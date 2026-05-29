clear;
clc;
close all;

%% SET SYSTEM PARAMETERS
alfa = 1.4;
beta = 1.8;
gamma = 1.05;
m = 13.5;
J = 0.37;
A = [0,0,0,1,0,0;
     0,0,0,0,1,0;
     0,0,0,0,0,1;
     0,0,0,-alfa/m,0,0;
     0,0,0,0,-beta/m,0;
     0,0,0,0,0,-gamma/J
    ];

xf = [-1;2;3;0;0;0];

B = [0 0 0;
    0 0 0;
    0 0 0;
    1/m 0 0;
    0 1/m 0;
    0 0 1/J];
usize = min(size(B));

T = 25;
dt = 0.01;

C = zeros(3,6);
C(1:3,1:3) = diag([1,1,1]);
 


%%

syms tau real

tic
eA = expm(A*(T-tau));
dG = eA*B*B'*eA';
G = vpa(int(dG,tau,0,T));

rankG = rank(G);
disp(['rank(G) = ' num2str(rankG)]);

if rankG == 6
    iG = inv(G);
else
    iG = pinv(G);
    warning("System has rank " + rankG + "! It is not fully controllable.")
end

u(tau) = B'*eA'*iG*xf;

toc
time = [0:dt:T];
time = time';
LL = length(time);

u_time = u(time);
uvalue = [eval(u_time{1}), eval(u_time{2}), eval(u_time{3})];

x0 = [0 0 0 0 0 0]'; % we start from the origin
x = zeros(6,LL); % this is only needed to log the results and plot them
xHat = zeros(6,LL); % this is only needed to log the results and plot them
x(:,1) = x0;

%% COMPUTE GRAMIAN FOR OBSERVABILITY
syms t real
tic
eA = expm(A*(T-t));
dG = eA'*C'*C*eA;
G_obs = vpa(int(dG,t,0,T));

rankG_obs = rank(G_obs);
disp(['rank(G) = ' num2str(rankG_obs)]);
 
if(rankG_obs == size(A,1)) 
    disp("System fully obseravable")
end

%% COMPUTE KALMAN FOR OBSERVABILITY
K = obsv(A, C);
rank_K = rank(K);
if(rank_K== size(A,1)) 
    disp("System fully obseravable")
end





%% SET OBSERVER PARAMETERS
% Set Ko (observability)

C = eye(6); %measure all the state 
Ko = zeros(6,6);
desired_poles = [-5 -6 -7 -8 -9 -10];
Ko = place(A, C', desired_poles)';

%% SIMULATION
xHat(:,1) = x0 + [1, -1, 1.5, 0.5, -0.5, -1.5]';
y = zeros(min(size(C)),LL);
yHat = C*xHat(:,1);
yHat(:,1) = yHat;

for k = 1:LL-1
    
    %% Control
    u_k = uvalue(k,:)';
    xdot_k = A*x(:,k) + B*u_k;
    x(:,k+1) = x(:, k) + xdot_k *dt;

    %% Measurement update
    y(:,k) = C*x(:,k);
                                                                    
    %% Observer
    dx_est = A*xHat(:,k) + B*u_k + Ko*(y(:,k)- yHat(:,k));
    xHat(:,k+1) = xHat(:,k) + dx_est * dt;
    yHat(:,k+1) = C*xHat(:,k+1);
end

%% PLOTS
%% Plot states
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Set figure to full screen
sgtitle("State") 
% Subplot 1: X Position
subplot(2,3,1);
plot(time, x(1,:),'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(1), 'linewidth',3);
xlabel('Time[s]');
ylabel('X[m]');
legend('State','Reference');
grid on;
title('X');

% Subplot 2: Y Position
subplot(2,3,2);
plot(time, x(2,:), 'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(2), 'linewidth',3);
xlabel('Time[s]');
ylabel('Y[m]');
legend('State','Reference');
grid on;
title('Y');

% Subplot 3: Theta
subplot(2,3,3);
plot(time, x(3,:), 'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(3), 'linewidth',3);
xlabel('Time[s]');
ylabel('Yaw[rad]');
legend('State','Reference');
grid on;
title('Yaw');

% Subplot 4: v_x
subplot(2,3,4);
plot(time, x(4,:), 'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(4), 'linewidth',3);
xlabel('Time[s]');
ylabel('v_x[m/s]');
legend('State','Reference');
grid on;
title('v_x');

% Subplot 5: v_y
subplot(2,3,5);
plot(time, x(5,:), 'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(5), 'linewidth',3);
xlabel('Time[s]');
ylabel('v_y[m/s]');
legend('State','Reference');
grid on;
title('v_y');

% Subplot 6: Yaw rate
subplot(2,3,6);
plot(time, x(6,:),'linewidth',3);
hold on;
plot(time, ones(size(time)) * xf(6), 'linewidth',3);
xlabel('Time[s]');
ylabel('Yaw rate[rad/s]');
legend('State','Reference');
grid on;
title('Yaw rate');

%% State stimation error
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Set figure to full screen
sgtitle("State estimation error") 
% Subplot 1: X Position
subplot(2,3,1);
plot(time, x(1,:) - xHat(1,:),'linewidth',3);
xlabel('Time[s]');
ylabel('X[m]');
grid on;
title('X');

% Subplot 2: Y Position
subplot(2,3,2);
plot(time, x(2,:) - xHat(2,:), 'linewidth',3);
xlabel('Time[s]');
ylabel('Y[m]');
grid on;
title('Y');

% Subplot 3: Theta
subplot(2,3,3);
plot(time, x(3,:) - xHat(3,:), 'linewidth',3);
xlabel('Time[s]');
ylabel('Yaw[rad]');
grid on;
title('Yaw');

% Subplot 4: v_x
subplot(2,3,4);
plot(time, x(4,:) - xHat(4,:), 'linewidth',3);
xlabel('Time[s]');
ylabel('v_x[m/s]');
grid on;
title('v_x');

% Subplot 5: v_y
subplot(2,3,5);
plot(time, x(5,:) - xHat(5,:), 'linewidth',3);
xlabel('Time[s]');
ylabel('v_y[m/s]');
grid on;
title('v_y');

% Subplot 6: Yaw rate
subplot(2,3,6);
plot(time, x(6,:) - xHat(6,:), 'linewidth',3);
xlabel('Time[s]');
ylabel('Yaw rate[rad/s]');
grid on;
title('Yaw rate');


figure;
plot(time,uvalue(:,1), 'linewidth',3)
hold on
plot(time,uvalue(:,2), 'linewidth',3)
plot(time,uvalue(:,3), 'linewidth',3)
legend('u_1','u_2','u_3')
xlabel('Time [s]')
ylabel('Inputs')
title('Input ')
grid on;

% Assuming you have time vector t corresponding to your data
figure;
scatter(x(1,:), x(2,:), [], time, 'filled'); % Plot with color mapping to time
colormap(jet); % Set colormap
cb = colorbar; % Add colorbar
cb.Label.String = 'time [s]'; % Add label to colorbar
xlabel('x [m]');
ylabel('y [m]');
title('Trajectory'); % Corrected title
grid on;

disp(['Final state error: ', num2str((x(:,end) - xf)')]);

disp(['Final est error: ', num2str((xHat(:,k+1) - x(:,k+1))')]);