%% Kinematic Model Class - GRAAL Lab
classdef cartesianControl < handle
    % KinematicModel contains an object of class GeometricModel
    % gm is a geometric model (see class geometricModel.m)
    properties
        gm % An instance of GeometricModel
        k_a
        k_l
    end

    methods
        % Constructor to initialize the geomModel property
        function self = cartesianControl(gm,angular_gain,linear_gain)
            if nargin > 2
                self.gm = gm;
                self.k_a = angular_gain;
                self.k_l = linear_gain;
            else
                error('Not enough input arguments (cartesianControl)')
            end
        end
        function [x_dot]=getCartesianReference(self,bTg, phase)
            %% getCartesianReference function
            % Inputs :
            % bTg : goal frame
            % Outputs :
            % x_dot : cartesian reference for inverse kinematic control

            %phase: 1 -> tool goal contro, 2-> ee goal control


            if phase == 1
                T_b_t = self.gm.getToolTransformWrtBase();
                O_b_t =  T_b_t(1:3,4);
                O_b_g = bTg(1:3,4);
                r = O_b_g - O_b_t; % Compute position error
               
                bRt = T_b_t(1:3,1:3);
                bRg = bTg(1:3,1:3);
                tRg = bRt'*bRg;
        
                [h, theta] = RotToAngleAxis(tRg);
                rho_t = h*theta;
                rho_b = bRt * rho_t;
        
                e = [rho_b; r];
                disp("e TT")
                disp(e);
        
                
                Ka = self.k_a * eye(3);
                Kl = self.k_l * eye(3);
                K = [Ka, zeros(3,3);
                     zeros(3,3), Kl];
                
                x_dot = K * e; % Compute the control output
            else
                %PHASE 2:focusing on ee goal
                bTe = self.gm.getTransformWrtBase(self.gm.jointNumber);
                bOe = bTe(1:3,4);
                bOg = bTg(1:3,4);
                r_ee = bOg - bOe;

                bRg = bTg(1:3,1:3);
                bRe = bTe(1:3,1:3);
                eRg = bRe'*bRg;

                [h_ee, theta_ee] = RotToAngleAxis(eRg);
                rho_ee = h_ee*theta_ee;
                b_rho_ee = bRe * rho_ee;
                e = [b_rho_ee; r_ee];
                disp("e EE");
                disp(e);

                Ka = self.k_a * eye(3);
                Kl = self.k_l * eye(3);
                K = [Ka, zeros(3,3);
                     zeros(3,3), Kl];
                
                x_dot = K * e; % Compute the control output
               

            end
            
        end
    end
end

