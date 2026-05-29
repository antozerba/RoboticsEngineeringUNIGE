%------------------------
%ZERBATO ANTONIO
%email addr: 8999827@studenti.unige.it 
%------------------------
function [x] = SimulateSysEuler(A, B, u, t, x0, dt)
    x = zeros(size(A,1),size(t,2));  % declare the state matrix with same number of columns of the t matrix, corrisponding to the time vector, in this way we implement the summation
    x(:,1) = x0; %initial condition
    for k = 1 : size(t,2) - 1 
        x(:,k+1) = x(:,k) + dt*(A*x(:,k)+B*u(:,k));
    end
end