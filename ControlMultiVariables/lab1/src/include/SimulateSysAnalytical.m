%------------------------
%ZERBATO ANTONIO
%email addr: 8999827@studenti.unige.it 
%------------------------
function [x] = SimulateSysAnalytical(A, B, u, t, x0, dt)
    x = zeros(size(A,1),size(t,2)); % declare the state matrix with same number of columns of the t matrix, corrisponding to the time vector, in this way we implement the summation
    x(:,1) = x0; % initial condition
    for k = 2 : size(t,2)
        I_k = expm(A*(t(k)-t(1)))*x0; %first term (free response)
        for i = 1 : k - 1
            I_k = I_k + expm(A*(t(k)-t(i)))*B*u(:,i)*dt; %computing the sum of the first term with the second term (forced response) at every iteration 
        end
        x(:,k) = I_k; %storing the result in the state matrix to represent its evolution over time
    end
end