clc, clearvars, close all
%%%%DIGITAL IMAGE REPRESENTATION
% A=[0.490,0.310,0.200;0.177,0.813,0.011;0.000,0.010,0.990]
% figure, imagesc(A), colormap(gray)


% %%%DIGITAL IMAGE REPRESENTATION
load tree.mat
% IN(1:40:end,1:40:end)
% figure,imagesc(IN(1:40:end,1:40:end)),colormap gray
% figure,surf(double(IN(1:5:end,1:5:end)))
% figure,imagesc(double(IN(1:1:end,1:1:end))),colormap gray

%%%%Spatial resolution
step=1;
for a=1:4
    figure,imagesc(IN(1:step:end,1:step:end)),colormap gray
    step=step*2;
end

%%%TRUECOLOR IMAGES
img=imread('left_#290.bmp','bmp');
figure,image(img)

%%%colormap 
figure,imagesc(double(IN)),colormap gray
figure,imagesc(double(IN)),colormap pink
figure,imagesc(double(IN)),colormap jet
