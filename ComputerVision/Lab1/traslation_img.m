function [tras_img] = traslation_img(img, tras)
    [rr,cc] = size(img);
    [X,Y]=meshgrid(1:cc,1:rr);
    XC=X-floor(cc/2); YC=Y-floor(rr/2);
    Xn=XC + tras +floor(cc/2);
    Yn=YC + tras +floor(rr/2);
    tras_img = griddata(X,Y,double(img), Xn,Yn, 'linear');
end