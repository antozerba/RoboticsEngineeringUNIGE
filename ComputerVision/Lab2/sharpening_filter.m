function [filter_img,filter] = sharpening_filter(img,dim)
    [im, impulse] = impulse_filter(img, dim);
    [im, blurred] = blurring_filter(img, dim);
    filter = 2* impulse - blurred;
    filter_img = conv2(img,filter, 'same');
end