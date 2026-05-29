%% MVCS LAB2
clc
close all
clear

%% Define matrices
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
TAM = [ 
    0.7071 0 0 -0.7071;
    -0.7071 0 0 0.7071;
    -0.1888 0 0 -0.1888;

];

B = 30 * [
    0 0 0;
    0 0 0;
    0 0 0;
    1/m 0 0;
    0 1/m 0;
    0 0 1/m;
] * TAM;

T = 20;
dt = 0.01;
xf = [-1 2 3 0 0 0]';
% xf = [-1 2 3 1 1 1]'; %not reachable state

syms tau real
eA = expm(A*(T-tau));
dG = eA * B * B'* eA';
G = eval(int(dG,tau,0,T));

rankG = rank(G);
disp(['rank(G) = ' num2str(rankG)]);

[cc,rr] = size(G);

pseudo = 1; %flag per usare la pseudo anche se G not full rank

%%
if (rankG == min(cc,rr) || pseudo) % FULL RANK
    %% Define time vector
    dt = 0.01;
    time = 0:dt:20;
    time = time';
    LL = length(time);
    
    %% Compute system input
    %iG = inv(G); % invert Gramian
    iG = pinv(G); % psuedo inverse Gramian, per vedere cosa succede se provo a runnare il sistema 
    u(tau) = B'*eA'*iG*xf;
    u_time = u(time);
    uvalue = [subs(u_time{1}), subs(u_time{2}), subs(u_time{3}), subs(u_time{4})]; 
    
    %% Initialize state
    x0 = [0 0 0 0 0 0]'; % we start from the origin
    x = zeros(6,LL); % this matrix will store the state evolution
    x(:,1) = x0;

    

    %% Simulate system (you can use Euler integration)
    for k = 1:LL-1
        u_k = uvalue(k,:);
        xdot =  dt*(A*x(:,k)+B*u_k');
        x(:,k+1) = x(:,k) + xdot ;
    end
    
    %% Plot state evolution
    figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Set figure to full screen

    %% Plot inputs
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
    
    disp("final state - ref state = " + norm(x(:,end) - xf)); % should be small
    disp("final state - ref state = " + x(:,end) - xf); % should be small
else
    disp("System is not controllable.")
    [U,D,V] = svd(G); % svd decomposition
    disp("U");
    disp(U);
    end
