function [R] = AngleAxisToRot(h,theta)

    I = [1 0 0;
         0 1 0;
         0 0 1];

    H = [   0   -h(3)  h(2);
           h(3)   0    -h(1);
          -h(2)  h(1)    0];

    R = I + sin(theta)*H + (1-cos(theta))*H^2;
   
end