function [filter_img] = median_filter(noise_img,dim)
    filter_img = medfilt2(noise_img, [dim,dim]);
end