function [X_new] = EvolutionModel(Xodo,u)
    %u=[v,w] 
    %Xodo=[x,y,theta]

    x_new = Xodo(1) + u(1)*cos(Xodo(3));
    y_new = Xodo(2) + u(1)*sin(Xodo(3));
    theta_new = Xodo(3) + u(2);
    X_new = [x_new, y_new, theta_new]';

end