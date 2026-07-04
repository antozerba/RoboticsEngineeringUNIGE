% Set the parameters which have the "Determined by student" comment to tune
% the Kalman filter. Do not modify anything else in this file.

% Uncertainty on initial position of the robot.
sigmaX     = 5/3;         % Determined by student GAUSSIAN
sigmaY     = 5/3;         % Determined by student GAUSSIAN
sigmaTheta = deg2rad(10);   % Determined by student GAUSSIAN
Pinit = diag( [sigmaX^2 sigmaY^2 sigmaTheta^2] ) ;

% Measurement noise.
sigmaXmeasurement = 23/sqrt(12);  % Determined by student UNIFORM DISTR
sigmaYmeasurement = 10/sqrt(12);  % Determined by student UNIFORM DISTR

Qgamma = diag( [sigmaXmeasurement^2 sigmaYmeasurement^2] ) ;


% Input noise
% sigmaTuning = 0.06 ; %correct one
sigmaTuning = 1 ; %too high i trust measurements too much 
% sigmaTuning = 0.001 ; %too high i trust model (odom) too much 
Qwheels = sigmaTuning^2 * eye(2) ;
Qbeta   = jointToCartesian * Qwheels * jointToCartesian.' ; 

% State noise
Qalpha = zeros(3) ;

% Mahalanobis distance threshold
mahaThreshold = sqrt(chi2inv(0.95,2)); 
