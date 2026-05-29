function [new_img] = scaling_img(img,scaling_factor)
    [cc, rr] = size(img);
    [X, Y] = meshgrid(1:rr, 1:cc);
    Xc = X - floor(cc/2); 
    Yc = Y - floor(rr/2);
    Xs = Xc/scaling_factor + floor(cc/2);
    Ys = Yc/scaling_factor + floor(rr/2);
    new_img = griddata(X,Y, double(img), Xs, Ys, 'linear');

end