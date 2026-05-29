function [filter_img,filter] = moving_average(noise_img,dim)
    K = ones(dim)/(dim^2);
    filter_img = conv2(noise_img, K, 'same');
    filter = K;
end