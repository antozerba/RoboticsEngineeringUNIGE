
%%%%%%%%%%%%%%%%%%%%
% ZERBATO ANTONIO MCM_exam_16/01/2025
%%%%%%%%%%%%%%%%%%%%


%% Template Exam Modelling and Control of Manipulators
clc;
close all;
clear;
addpath('include'); % put relevant functions inside the /include folder 
addpath('include/utils'); % put relevant functions inside the /include folder 

%% Compute the geometric model for the given manipulator
iTj_0 = BuildTree();

disp('iTj_0')
disp(iTj_0);
jointType = [0 0 0 0 0 1 0]; % specify two possible link type: Rotational, Prismatic.
q = [pi/2, -pi/4, 0, -pi/4, 0, 0.15,pi/4]';

% control proportional gain 
k_a = 0.4;
k_l = 0.4;

% joints upper and lower bounds 
qmin = -3.14 * ones(7,1);
qmin(6) = 0;
qmax = +3.14 * ones(7,1);
qmax(6) = 1;

%% Define the tool frame rigidly attached to the end-effector

eTt = [0,-1,0,0;
       1,0,0,0;
       0,0,1,0.130;
       0,0,0,1;
    ];
disp("eTt");
disp(eTt);



%% Define the goal
% Goal definition (phase 1, must be reached by the tool)
bOg_tool = [0.0087, 0.5808, 0.6714]';
gamma_g_tool = [1.0363, 0.3218, -0.0077];
bRg_tool = YPRtoRot(gamma_g_tool(1), gamma_g_tool(2), gamma_g_tool(3));
bTg_tool = [
            bRg_tool, bOg_tool;
            0 , 0, 0, 1;
            ];
disp("bTg_tool");
disp(bTg_tool);

% Goal definitison (phase 2, must be reached by the ee)
bOg_ee = [0.0202, 0.7779, 0.9927]';
gamma_g_ee = [-0.3876, -0.3614, -0.3647];
bRg_ee = YPRtoRot(gamma_g_ee(1), gamma_g_ee(2), gamma_g_ee(3));
bTg_ee = [
            bRg_ee, bOg_ee;
            0 , 0, 0, 1;
        ];
disp("bTg_ee");
disp(bTg_ee);


%% Initialize Geometric Model (GM) and Kinematic Model (KM)
% Initialize geometric model with q0
gm = geometricModel(iTj_0,jointType,eTt);

% Update direct geoemtry given q0
gm.updateDirectGeometry(q);

% Initialize the kinematic model given the goemetric model
km = kinematicModel(gm);

%% Define the goal frame and initialize cartesian control
% Cartesian control initialization
cc = cartesianControl(gm, k_a, k_l);

%% Initialize control loop
% Simulation variables
samples = 100;
t_start = 0.0;
t_end = 20.0;
dt = (t_end-t_start)/samples;
time = t_start:dt:t_end; 

% Initializing plot
show_simulation = true; %% DO NOT CHANGE
pm = plotManipulators(show_simulation); %% DO NOT CHANGE
pm.initMotionPlot(time, bTg_tool(1:3,4), bTg_ee(1:3,4), "");


gt_reached = 0; 
phase = 1; %phase 1 -> tool contro | 2-> ee control
%first goal
bTg = bTg_tool;
    
%% Kinematic Simulation
for t = time

    if gt_reached == 1
        bTg = bTg_ee; %changing the goal for SECOND PHASE
        disp("CHANGING GOAL")
    end
    
    % Updating geometric model 
    gm.updateDirectGeometry(q);
    
    % Get the cartesian error given an input goal frame
    x_dot = cc.getCartesianReference(bTg, phase); 
    
    % Update the jacobian matrix of the given model
    km.updateJacobian(phase);
    
    % Inverse Kinematics: compute desired joint velocities 
    q_dot =  pinv(km.J)* x_dot;
    
    % simulating the robot
    q = KinematicSimulation(q,q_dot, dt, qmin, qmax );
    
    % Plot
    pm.plotIter(gm, km, t, q_dot); % DO NOT CHANGE
  


    % Check if goal_tool is reached
    if phase == 1
        if(norm(x_dot(1:3)) < 0.01 && norm(x_dot(4:6)) < 0.01)
            disp('Reached Requested Pose TOOL')
            disp(t)
            gt_reached = 1;
            phase = 2;
        end
    else 
        if(norm(x_dot(1:3)) < 0.01 && norm(x_dot(4:6)) < 0.01)
            disp('Reached Requested EE TOOL')
            disp(t)
            break
        end
    end
end

%% Final plots
pm.plotFinalConfig(gm, "", ""); % CHANGE THIS FUNCTION CALL IF IT IS NECESSARY

%%CHECKING
bTe = gm.getTransformWrtBase(gm.jointNumber);
bOe = bTe(1:3,4);
bRe = bTe(1:3,1:3);
eRg_ee = bRe' * bRg_ee;
[h_ee, theta_ee] = RotToAngleAxis(eRg_ee);
rho_ee = h_ee*theta_ee;
b_rho_ee = bRe * rho_ee;


disp("bOe final");
disp(bOe);
disp("Final Distance error");
r_ee = bOg_ee - bOe;
disp(r_ee);
disp("Final Misalignment error");
disp(b_rho_ee);


