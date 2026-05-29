function [filter_img,filter] = impulse_filter(img, dim)
    A = zeros(dim);
    [rr, cc] = size(A);
    i = ceil(rr/2);
    j = ceil(cc/2);
    A(i,j) = 1;
    filter = A;
    filter_img = conv2(img, A, 'same');
end