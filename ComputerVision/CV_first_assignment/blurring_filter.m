function [filter_img,filter] = blurring_filter(img,dim)
    A = ones(dim);
    A = A * 1/(dim^2);
    filter = A;
    filter_img = conv2(img, A, 'same');
end