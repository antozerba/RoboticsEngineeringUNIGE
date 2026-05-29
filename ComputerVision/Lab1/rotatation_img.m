function [new_img] = rotatation_img(img,deg)
    [rr,cc] = size(img);
    alfa = deg2rad(deg);
    [X,Y] = meshgrid(1:cc,1:rr);
    XC=X-floor(cc/2); YC=Y-floor(rr/2);
    Xn=(XC.*cos(alfa)- YC.*sin(alfa)) +floor(cc/2); 
    Yn= (XC.*sin(alfa)+YC.*cos(alfa)) +floor(rr/2);
    new_img = griddata(X,Y,double(img),Xn,Yn, 'linear');
end