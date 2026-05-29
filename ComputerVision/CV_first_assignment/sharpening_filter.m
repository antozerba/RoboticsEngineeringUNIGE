function [filter_img,filter,detail_img] = sharpening_filter(img,dim)
    [im, impulse] = impulse_filter(img, dim);
    [im, blurred] = blurring_filter(img, dim);
    detail_img = double(img) - double(im);
    detail = impulse - blurred; 
    filter = impulse + detail;
    filter_img = imfilter(img,filter, 'replicate', 'conv');
end