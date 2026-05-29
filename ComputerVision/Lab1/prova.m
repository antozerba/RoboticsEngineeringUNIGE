clearvars, clc

load data
img = imread('boccadasse.jpg');
img_gray = rgb2gray(img);
figure, imagesc(img_gray), colormap gray


%SCALING
z = 2.2;
scaling_img = scaling_img(img_gray, z);
figure, imagesc(scaling_img), colormap gray, title('scaled img')
axis equal

%TRASLATION
t = 12;
translated_img = traslation_img(img_gray, t);
figure, imagesc(translated_img), colormap gray, title('traslated img');


%ROTATION
a = 20;
rot_img = rotatation_img(img_gray, a);
figure, imagesc(rot_img), colormap gray, title('rotate img')