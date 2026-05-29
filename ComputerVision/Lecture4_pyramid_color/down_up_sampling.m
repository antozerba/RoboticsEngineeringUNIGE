%
lpf = [1 4 6 4 1]/16;%1D low pass filter

img=double(imread('cameraman.tif','tif'));
figure,imagesc(img),colormap gray

%%%%downsample with low pass filter
figure,imagesc(img(1:4:end,1:4:end)),title('downsample without LP'),colormap gray

tmp=conv2(conv2(double(img),lpf,'same'),lpf','same');%we apply two times the 1D convolution -> we have 2D convolution
tmp1=tmp(1:2:end,1:2:end);

tmp2=conv2(conv2(tmp1,lpf,'same'),lpf','same');
figure,imagesc(tmp2(1:2:end,1:2:end)),title('downsample with LP'),colormap gray



%%%%upsample
tmp3=tmp2(1:2:end,1:2:end);
[rr,cc]=size(tmp3);
[Xo,Yo]=meshgrid(1:cc,1:rr);
[Xn,Yn]=meshgrid(1:0.5:(cc+0.5),1:0.5:(rr+0.5));

tmp2up=griddata(Xo,Yo,tmp3,Xn,Yn,'linear',{'Qt','Qbb','Qc','Qz'} );
%figure,imagesc(tmp2up),colormap gray

[rr,cc]=size(tmp2up);
[Xo,Yo]=meshgrid(1:cc,1:rr);
[Xn,Yn]=meshgrid(1:0.5:(cc+0.5),1:0.5:(rr+0.5));
tmp1up=griddata(Xo,Yo,tmp2up,Xn,Yn,'linear',{'Qt','Qbb','Qc','Qz'} );
figure,imagesc(tmp1up),title('upsample'),colormap gray