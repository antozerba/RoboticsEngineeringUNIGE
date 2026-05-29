%
lpf = [1 4 6 4 1]/16;%1D low pass filter
load tree
figure,imagesc(IN),colormap gray
figure,imagesc(IN(1:4:end,1:4:end)),colormap gray

tmp=conv2(conv2(double(IN),lpf),lpf');%we apply two times the 1D convolution -> we have 2D convolution
tmp1=tmp(1:2:end,1:2:end);
tmp2=conv2(conv2(tmp1,lpf),lpf');
figure,imagesc(tmp2(1:2:end,1:2:end)),colormap gray