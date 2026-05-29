clc, clearvars, close all
%------------------
%PUNTO 1
%------------------
img = imread("i235.png");
img = double(img);
figure, imagesc(img), colormap gray
figure, imhist(uint8(img));

%Gaussian Noise (standard deviation=20)
img_gaus = gaussian_noise(img, 20);
figure, imagesc(img_gaus), colormap gray, title('Gaussian Noise Image');
figure, imhist(uint8(img_gaus)), title('Gaussian Histogram');

%Salt & Pepper noise (density=20%) 
salt_img = salt_and_pepper_noise(img, 0.2);
figure, imagesc(salt_img), colormap gray, title('Salt and Pepper Noise Image')
figure, imhist(uint8(salt_img)), title('Salt and Pepper Histogram');

%------------------
%POINT 2
%------------------

%MOVING AVARAGE FILTER 3x3 GAUSS NOISE
[filter_img, K] = moving_average(img_gaus, 3);
figure, imagesc(K), title('Moving Average Filter 3 Gauss noise')
figure, surf(K), title('Surf Moving Average Filter 3')
figure,imagesc(filter_img),colormap gray,title('Moving Average Image 3 Gauss noise')
figure, imhist(uint8(filter_img)), title('Moving Average Image Histogram 3 Gauss noise');
%MOVING AVARAGE FILTER 7x7 GAUSS NOISE
[filter_img, K] = moving_average(img_gaus, 7);
figure, imagesc(K), title('Moving Average Filter 7 Gauss noise')
figure, surf(K), title('Surf Moving Average Filter 7 ')
figure,imagesc(filter_img),colormap gray,title('Moving Average Image 7 Gauss noise')
figure, imhist(uint8(filter_img)), title('Moving Average Image Histogram 7 Gauss noise');
%MOVING AVARAGE FILTER 3x3 SALT NOISE
[filter_img, K] = moving_average(salt_img, 3);
figure, imagesc(K), title('Moving Average Filter 3 Salt noise')
figure, surf(K), title('Surf Moving Average Filter 3')
figure,imagesc(filter_img),colormap gray,title('Moving Average Image 3 Salt noise')
figure, imhist(uint8(filter_img)), title('Moving Average Image Histogram 3 Salt noise');
%MOVING AVARAGE FILTER 7x7 SALT NOISE
[filter_img, filter] = moving_average(salt_img, 7);
figure, imagesc(filter), title('Moving Average Filter 7 Salt noise')
figure, surf(filter), title('Surf Moving Average Filter 7 ')
figure,imagesc(filter_img),colormap gray,title('Moving Average Image 7 Salt noise')
figure, imhist(uint8(filter_img)), title('Moving Average Image Histogram 7 Salt noise');


%LOW PASS GAUSSIAN 3x3 GAUSS NOISE
[filter_img, filter] = low_pass_gaussian_filter(img_gaus, 3, 0.5);
figure, imagesc(filter), title('Low Pass Filter 3 Gauss noise ')
figure, surf(filter), title('Surf Low Pass Filter 3  ')
figure, imagesc(filter_img), colormap gray, title('Low Pass Filter 3 Gauss noise');
figure, imhist(uint8(filter_img)), title('Low Pass Filter Histogram 3 Gauss noise');
%LOW PASS GAUSSIAN 7x7 GAUSS NOISE
[filter_img, filter] = low_pass_gaussian_filter(img_gaus, 7, 1.5);
figure, imagesc(filter), title('Low Pass Filter 7 Gauss noise ')
figure, surf(filter), title('Surf Low Pass Filter 7  ')
figure, imagesc(filter_img), colormap gray, title('Low Pass Filter 7 Gauss noise');
figure, imhist(uint8(filter_img)), title('Low Pass Filter Histogram 7 Gauss noise');

%LOW PASS GAUSSIAN 3x3 SALT NOISE
[filter_img, filter] = low_pass_gaussian_filter(salt_img, 3, 0.5);
figure, imagesc(filter), title('Low Pass Filter 3 Salt noise ') %gia mostrato su
figure, surf(filter), title('Surf Low Pass Filter 3  ') %gia mostrato su
figure, imagesc(filter_img), colormap gray, title('Low Pass Filter 3 Salt noise');
figure, imhist(uint8(filter_img)), title('Low Pass Filter Histogram 3 Salt noise');
%LOW PASS GAUSSIAN 7x7 SALT NOISE
[filter_img, filter] = low_pass_gaussian_filter(salt_img, 7, 1.5);
figure, imagesc(filter), title('Low Pass Filter 7 Salt noise ') %gia mostrato su
figure, surf(filter), title('Surf Low Pass Filter 7  ') %gia mostrato su
figure, imagesc(filter_img), colormap gray, title('Low Pass Filter 7 Salt noise');
figure, imhist(uint8(filter_img)), title('Low Pass Filter Histogram 7 Salt noise');


%MEDIAN FILTER 3x3 GAUSS NOISE
filter_img = median_filter(img_gaus, 3);
figure, imagesc(filter_img), colormap gray, title('Median Filter 3 Gauss noise');
figure, imhist(uint8(filter_img)), title('Median Filter Histogram 3 Gauss noise');
%MEDIAN FILTER 7x7 GAUSS NOISE
filter_img = median_filter(img_gaus, 7);
figure, imagesc(filter_img), colormap gray, title('Median Filter 7 Gauss noise');
figure, imhist(uint8(filter_img)), title('Median Filter Histogram 7 Gauss noise');

%MEDIAN FILTER 3x3 SALT NOISE
filter_img = median_filter(salt_img, 3);
figure, imagesc(filter_img), colormap gray, title('Median Filter 3 Salt noise');
figure, imhist(uint8(filter_img)), title('Median Filter Histogram 3 Salt noise');
%MEDIAN FILTER 7x7 SALT NOISE
filter_img = median_filter(salt_img, 7);
figure, imagesc(filter_img), colormap gray, title('Median Filter 7 Salt noise');
figure, imhist(uint8(filter_img)), title('Median Filter Histogram 7 Salt noise');


%---------------
%POINT 3
%---------------

%IMPULSE FILTER
[filter_img, filter] = impulse_filter(img, 7);
figure, imagesc(filter_img), colormap gray, title('Impulse Filter Image')
figure, imagesc(filter), title('Impulse Filter') %filter
figure, surf(filter), title('Surf Impulse Filter'); %surf filter

%SHIFTED FILTER
[filter_img, filter] = shift_filter(img, 7);
figure, imagesc(filter_img), colormap gray, title('Shift Filter Image')
figure, imagesc(filter), title('Shift Filter') %filter
figure, surf(filter), title('Surf Shift Filter'); %surf filter


%BLURRING 
[filter_img, filter] = blurring_filter(img, 7);
figure, imagesc(filter_img), colormap gray, title('Blurring Filter Image')
figure, imagesc(filter), title('Blurring Filter') %filter
figure, surf(filter), title('Surf Blurring Filter'); %surf filter

%SHARPENING
[filter_img, filter] = sharpening_filter(img, 7);
figure, imagesc(filter_img), colormap gray, title('Sharpening Filter Image')
figure, imagesc(filter), title('Sharpening Filter') %filter
figure, surf(filter), title('Surf Sharpening Filter'); %surf filter

%---------------
%POINT 4
%---------------
%FTT FIGURE
FZ = fft2(img);
MOD = abs(FZ);
figure,imagesc(log(fftshift(MOD))), colormap gray,  xlabel('wx'),ylabel('wy'), title('Magnitude of FTT image');

%FTT GAUSSIAN
gfilter = fspecial('gaussian', [101 101], 5);
FZ = fft2(gfilter);
FZ = fftshift(FZ);
MOD = abs(FZ);
figure, imagesc(MOD), colormap gray, xlabel('wx'),ylabel('wy'),title('abs(FTT) Low-pass Gaussian Filter');


%FTT SHARPING
filter = zeros(101);
[sharped_img, sharp_filter] = sharpening_filter(img, 7);
filter(47:53,47:53) = sharp_filter;
FT = fft2(filter);
MOD = abs(FT);
figure, imagesc(log(fftshift(MOD))), colormap gray, xlabel('wx'),ylabel('wy'),title('abs(FTT) Sharping Filter');
