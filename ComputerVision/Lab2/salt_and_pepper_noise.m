function [salt_img] = salt_and_pepper_noise(img,dev)
    [rr,cc] = size(img);
    maxv = max(max(img));
    indices=full(sprand(rr,cc,dev));
    mask1 = indices > 0 & indices <0.5;
    mask2 = indices >= 0.5;
    salt_img = img.*(~mask1);   
    salt_img = salt_img.*(~mask2) + mask2*maxv;

end