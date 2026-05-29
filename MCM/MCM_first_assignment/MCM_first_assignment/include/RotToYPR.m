function [psi,theta,phi] = RotToYPR(R)
    
    isRotation = IsRotationMatrix(R);

    if isRotation
        theta = atan2 (-R(3,1), sqrt((R(1,1))^2 + (R(2,1))^2));
        if theta > (-pi/2) + 10^-3 && theta < (pi/2) - 10^-3
            psi = atan2 (R(2,1), R(1,1)); 
            phi = atan2 (R(3,2), R(3,3));
        elseif -pi/2 <= theta && theta <= -pi/2 + 10^-3
            disp("Gimbal Lock, theta=-pi/2")
            psi = 0;
            phi = atan2 (R(1,2), R(1,3));
        elseif (pi/2) - 10^-3 <= theta && theta <= pi/2
            disp("Gimbal Lock, theta=pi/2")
            psi = 0;
            phi = atan2 (-R(1,2), R(1,3));
        end
    else
        disp("The matrix is not rotable");
        theta = null;
        phi = null;
        psi = null;
    end

end