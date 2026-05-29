clc, clearvars, close all
addpath('include');



%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 1  Angle-axis to rot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("PUNTO 1 Angle-axis to rot");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

disp("----------------------------------------");
disp("1.2")
disp("----------------------------------------");
theta = deg2rad(90);

h = [1,0,0];

R = AngleAxisToRot(h,theta);
disp (R);
plotframe(R);


disp("----------------------------------------");
disp("1.3")
disp("----------------------------------------");

theta = deg2rad(60);

h = [0,0,1];

R = AngleAxisToRot(h,theta);
disp (R);

disp("----------------------------------------");
disp("1.4")
disp("----------------------------------------");

rho = [-pi/3, -pi/6, pi/3];

theta = sqrt(rho(1,1)^2 + rho(1,2)^2 + rho(1,3)^2);

h = rho' / theta;  

R = AngleAxisToRot(h,theta);
disp("display theta:")
theta = rad2deg(theta);
disp(theta);
disp("display h:")
disp(h);
disp("display R:")
disp (R);
  

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 2 Rot to angle-axis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("PUNTO 2 Rot to angle-axis");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

disp("----------------------------------------");
disp("2.2")
disp("----------------------------------------");
R = [1 0 0;
     0 0 -1;
     0 1 0];

[h,theta] = RotToAngleAxis(R);

if theta == -5
    disp("Input Matrix is not Rotable")
end

disp("display theta:")
theta = rad2deg(theta);
disp(theta);

disp("display h:")
disp(h)

disp("----------------------------------------");
disp("2.3")
disp("----------------------------------------");

R = [1/2        -sqrt(3)/2    0;
     sqrt(3)/2       1/2      0;
     0                0       1];

[h,theta] = RotToAngleAxis(R);

if theta == -5
    disp("Input Matrix is not Rotable")
end

disp("display theta:")
theta = rad2deg(theta);
disp(theta);

disp("display h:")
disp(h)

disp("----------------------------------------");
disp("2.4")
disp("----------------------------------------");

R = [1 0 0;
     0 1 0;
     0 0 1];

[h,theta] = RotToAngleAxis(R);

if theta == -5
    disp("Input Matrix is not Rotable")
end

disp("display theta:")
theta = rad2deg(theta);
disp(theta);

disp("display h:")
disp(h)

disp("----------------------------------------");
disp("2.5")
disp("----------------------------------------");

R = [-1 0  0;
     0  -1 0;
     0  0  1];

[h,theta] = RotToAngleAxis(R);

if theta == -5
    disp("Input Matrix is not Rotable")
end

disp("display theta:")
theta = rad2deg(theta);
disp(theta);

disp("display h:")
disp(h);

disp("----------------------------------------");
disp("2.6")
disp("----------------------------------------");

R = [-1 0  0;
     0  1  0;
     0  0  1];

[h,theta] = RotToAngleAxis(R);

if theta == -5
    disp("Input Matrix is not Rotable")
else
    disp("display theta:")
    theta = rad2deg(theta);
    disp(theta);
    disp("display h:")
    disp(h);
end

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 3    Euler to rot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("PUNTO 3 Euler to rot");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("----------------------------------------");
disp("3.2")
disp("----------------------------------------");

R = YPRToRot(0,0,pi/2);
disp("display R:")
disp(R);

disp("----------------------------------------");
disp("3.3")
disp("----------------------------------------");

R = YPRToRot(deg2rad(60),0,0);
disp("display R:")
disp(R);

disp("----------------------------------------");
disp("3.4")
disp("----------------------------------------");

R = YPRToRot(pi/3,pi/2,pi/4);
disp("Gimbal Lock");
disp("display R:")
disp(R);

disp("----------------------------------------");
disp("3.5")
disp("----------------------------------------");

R = YPRToRot(0,pi/2,-pi/12);
disp("Gimbal Lock");
disp("display R:")
disp(R);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 4    Rot to Euler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("PUNTO 1.4 Rot to Euler");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

disp("----------------------------------------");
disp("4.2")
disp("----------------------------------------");

R = [1 0 0;
     0 0 -1;
     0 1 0];

[psi, theta, phi] = RotToYPR(R);

disp("display psi:")
psi = rad2deg(psi);
disp(psi);
disp("display theta:")
theta = rad2deg(theta);
disp(theta);
disp("display phi:")
phi = rad2deg(phi);
disp(phi);

disp("----------------------------------------");
disp("4.3")
disp("----------------------------------------");


R = [1/2        -sqrt(3)/2    0;
     sqrt(3)/2       1/2      0;
     0                0       1];

[psi, theta, phi] = RotToYPR(R);

disp("display psi:")
psi = rad2deg(psi);
disp(psi);
disp("display theta:")
theta = rad2deg(theta);
disp(theta);
disp("display phi:")
phi = rad2deg(phi);
disp(phi);


disp("----------------------------------------");
disp("4.4")
disp("----------------------------------------");


R = [    0             -sqrt(2)/2             sqrt(2)/2;
        1/2        (sqrt(2)*sqrt(3))/4     (sqrt(2)*sqrt(3))/4;
     -sqrt(3)/2         sqrt(2)/4            sqrt(2)/4];

[psi, theta, phi] = RotToYPR(R);

disp("display psi:")
psi = rad2deg(psi);
disp(psi);
disp("display theta:")
theta = rad2deg(theta);
disp(theta);
disp("display phi:")
phi = rad2deg(phi);
disp(phi);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 5    Rot to angle-axis with eigenvectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("PUNTO 1.5  Rot to angle-axis with eigenvectors");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

disp("----------------------------------------");
disp("5.1")
disp("----------------------------------------");

R = [1 0 0;
     0 0 -1;
     0 1 0];


is_rot = IsRotationMatrix(R);

if is_rot
    [h,theta] = RotToAngleAxis(R);
    disp("Primo metodo");
    disp("h:");
    disp(h);
    disp("theta:");
    disp(rad2deg(theta));
    
    disp("Secondo metodo");
    h = eigen_H(R);
    disp("h: ");
    disp(h);
    [~,theta] = RotToAngleAxis(R);
    disp("theta:");
    disp(rad2deg(theta));
else 
    disp("NOT A ROTATION MATRIX")
end


disp("----------------------------------------");
disp("5.2")
disp("----------------------------------------");

R = (1/9) * [4 -4 -7;
              8  1  4;
             -1 -8  4];

is_rot = IsRotationMatrix(R);

if is_rot
    [h,theta] = RotToAngleAxis(R);
    disp("Primo metodo");
    disp("h:");
    disp(h);
    disp("theta gradi:");
    disp(rad2deg(theta));
    disp("theta rad:");
    disp(theta);
    
    disp("Secondo metodo");
    h = eigen_H(R);
    disp("h: ");
    disp(h);
    [~,theta] = RotToAngleAxis(R);
    disp("theta gradi:");
    disp(rad2deg(theta));
    disp("theta rad:");
    disp(theta);
else 
    disp("NOT A ROTATION MATRIX")
end


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 6    Frame tree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transformation matrx frame <1> wrt <world>
T01 = [ 1  0  0   0;
        0  1  0   0;
        0  0  1 175;
        0  0  0   1 ];
[R1,p1] = extractRT(T01);

% Transformation matrx frame <2> wrt <1>
T12 = [-1  0  0   0;
        0  0  1   0;
        0  1  0  98;
        0  0  0   1 ];
T = T01*T12;
[R2,p2] = extractRT(T);

% Transformation matrx frame <3> wrt <2>
T23 = [ 0  0  1 105;
        0  1  0   0;
       -1  0  0   0;
        0  0  0   1 ];
T = T01*T12*T23;
[R3,p3] = extractRT(T);

% Transformation matrx frame <4> wrt <3>
T34 = [ 0     0   -1     0;
        0    -1    0   145.50;
       -1     0    0   326.50;
        0     0    0     1];

% Transformation matrx frame <5> wrt <4>
T45 = [ 0     0    1     35;
       -1     0    0      0;
        0    -1    0      0;
        0     0    0      1];

% Transformation matrx frame <6> wrt <5>
T56 = [ 0     1    0      0;
        0     0    1      0;
        1     0    0    385;
        0     0    0      1];

% Transformation matrx frame <7> wrt <6>
T67 = [ 0     0    1    153;
        1     0    0      0;
        0     1    0      0;
        0     0    0      1];

a = 30;

T1 = T01;          
T2 = T1 * T12;     
T3 = T2 * T23;    
T4 = T3 * T34;    
T5 = T4 * T45;     
T6 = T5 * T56;     
T7 = T6 * T67;   

Tlist = {T1,T2,T3,T4,T5,T6,T7};
labels = { 'X_1','X_2','X_3','X_4','X_5','X_6','X_7';
           'Y_1','Y_2','Y_3','Y_4','Y_5','Y_6','Y_7';
           'Z_1','Z_2','Z_3','Z_4','Z_5','Z_6','Z_7'};

% World Frame
plotframe('LabelBasis', true, ...
          'Labels', {'X_{world}','Y_{world}','Z_{world}'}, ...
          'TextProperties', {'FontAngle','italic'})

for k = 1:7
    [R, p] = extractRT(Tlist{k});
    plotframe(R, p/a, 'MatrixIndexing','columnmajor', 'LabelBasis', true, ...
              'Labels', labels(:,k)', ...
              'TextProperties', {'FontAngle','italic'})
end
view(0, 0);

figure
axes('DataAspectRatio', [1 1 1], 'View', [37.5 30])
hold on, grid on

plotframe('LabelBasis', true, ...
          'Labels', {'X_{world}','Y_{world}','Z_{world}'}, ...
          'TextProperties', {'FontAngle','italic'})

for k = 1:7
    [R, p] = extractRT(Tlist{k});
    plotframe(R, p/a, 'MatrixIndexing','columnmajor', 'LabelBasis', true, ...
              'Labels', labels(:,k)', ...
              'TextProperties', {'FontAngle','italic'})
end
