function [filter_img,filter] = low_pass_gaussian_filter(noise_img,dim,dev)
    g = fspecial('gaussian', [dim dim], dev);
    filter_img = conv2(noise_img, g, 'same');
    filter = g;
end