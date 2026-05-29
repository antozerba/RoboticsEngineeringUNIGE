clear;
clc;
close all;

%% SET SIMULATIOM TYPE

measureAll = true;
enableClosedLoop = true;
enableClosedLoopWithObserver = true;
if enableClosedLoopWithObserver
    desc = "closed loop with observer";
elseif enableClosedLoop
    desc = "closed loop";
else
    desc = "open loop";
end

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
    0,0,0,0,0,-gamma/J];

xf = [-1;2;3;0;0;0];
testdesc = "Test";

B = [0,0,0;
     0,0,0;
     0,0,0;
     1/m,0,0;
     0,1/m,0;
     0,0,1/J
     ];

usize = min(size(B));

T = 25;
dt = 0.01;

if measureAll == true
    C = eye(6); %state measurable
else
    C = [1, 0, 0, 0, 0, 0; 
         0, 1, 0, 0, 0, 0; 
         0, 0, 1, 0, 0, 0]; % state measurable only for pose
end

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

%% SET CONTROLLER PARAMETERS
% Set Kc (controlability)
% Kc = zeros(3,6);
% 
% % Set parameters
% Tau = 1;
% xi = 1;
% wn = 1;
% 
% kc1 = -m * wn^2;
% kc2 = -m * wn^2;
% kc3 = -J * wn^2;
% 
% kc4 = alfa - 2*xi*wn*m;
% kc5 = beta - 2*xi*wn*m;
% kc6 = gamma - 2*xi*wn*J;
% Kc(1:3,1:3) = diag([kc1, kc2, kc3]);
% Kc(1:3,4:6) = diag([kc4, kc5, kc6]);


desired_poles = [-1 -1.5 -2 -2.5 -3 -5];
Kc = place(A, B, desired_poles);




%% SET OBSERVER PARAMETERS
% Set Ko (observability)

if measureAll 
    
    % desired_poles = [-1 -1.5 -2 -2.5 -3 -5]*2;
    % Ko = place(A, C', desired_poles)';
    desired_poles = [-1 -1 -5 -1 -1 -3];
    Ko = place(A, C', desired_poles)';
   

else
    Tau = 1;
    xi = 1;
    wn = 10;
    Ko = zeros(6,3);
    wn = 10;
    
    kx1 = 2*xi*wn - alfa/m;
    kx2 = 2*xi*wn - beta/m;
    kx3 = 2*xi*wn - gamma/J;
    
    kx4 = wn^2 - kx1*alfa/m;
    kx5 = wn^2 - kx2*beta/m;
    kx6 = wn^2 - kx3*gamma/J;
    
    Ko(1:3,1:3) = diag([kx1,kx2,kx3]);
    Ko(4:6,1:3) = diag([kx4,kx5,kx6]);
end


%% SIMULATION
u_stdev = 0.1;
y_stdev = 0.0; %noise 

x_ol = x * 0; % ol means Open Loop
x_ol(:,1) = x0;
xHat(:,1) = x0 + [1, -1, 1.5, 0.5, -0.5, -1.5]';
y = zeros(min(size(C)),LL);
yHat = y * 0;
y_noise = y * 0;
yHat(:,1) = C*xHat(:,1);

for k = 1:LL-1
    
    %% Control
    u_k = uvalue(k,:)'; 
    xdot_ol_k = A*x_ol(:,k) + B * u_k;
    x_ol(:,k+1) = x_ol(:,k) + xdot_ol_k * dt;
    if ~enableClosedLoop
        x(:,k+1) = x_ol(:,k+1);
    else
        if enableClosedLoopWithObserver
            uref(:,k) = u_k - Kc*(xHat(:,k)-x_ol(:,k)); %input u che va al sistema formata da u desired u_k and correction
        else
            uref(:,k) = u_k - Kc*(x(:,k)-x_ol(:,k));
        end
        dot_k = A*x(:,k)+ B*uref(:,k);
        x(:,k+1) = x(:,k) + dot_k *dt; 
    end

    %% Measurement update
    y(:,k) = C*x(:,k);

    %% Observer
    y_noise(1:2,k) = y(1:2,k) + y_stdev*randn;
    y_noise(3,k) = y(3,k) + y_stdev*randn;
    u_obs_k = uref(:,k);
    xdotHat = A*xHat(:, k) + B*u_obs_k +Ko*(y_noise(:,k) - yHat(:,k)); 
    xHat(:,k+1) = xHat(:,k) + xdotHat * dt;
    yHat(:,k+1) = C*xHat(:,k+1);
end

%% PLOTS
%% Plot states
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Set figure to full screen
sgtitle("State" + newline + desc) 
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
sgtitle("State estimation error" + newline + desc) 
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
legend('u_1','u_2','u_3','u_4')
xlabel('Time [s]')
ylabel('Inputs')
title(['Input ',newline,desc])
grid on;

% Assuming you have time vector t corresponding to your data
figure;
scatter(x(1,:), x(2,:), [], time, 'filled'); % Plot with color mapping to time
colormap(jet); % Set colormap
cb = colorbar; % Add colorbar
cb.Label.String = 'time [s]'; % Add label to colorbar
xlabel('x [m]');
ylabel('y [m]');
title(['Trajectory', newline, desc]); % Corrected title
grid on;

disp("Final state error:")
x(:,end) - xf

disp("Final est error:")
xHat(end,k+1) - x(end,k+1)