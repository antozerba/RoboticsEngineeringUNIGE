function [filter] = laplacian_of_gaussian(sd)
    s = ceil(3*sd);
    [X,Y] = meshgrid(-s:s);
    filter = (1/(2*pi*sd^2))*((X.^2+Y.^2 -2*sd^2)/sd^4).*exp(-(X.^2+Y.^2)/(2*sd^2));
    
end