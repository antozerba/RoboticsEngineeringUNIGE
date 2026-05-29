function [img_gaus] = gaussian_noise(img,dev)
    img_gaus = img+ dev*randn(size(img));
end