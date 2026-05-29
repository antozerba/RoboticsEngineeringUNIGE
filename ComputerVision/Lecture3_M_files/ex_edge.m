%edge detectors

tmp=imread('left_#290gray.bmp','bmp');
I=double(tmp(1:256,1:256));
figure,imagesc(I),colormap gray


figure,imagesc(edge(I,'sobel')),colormap gray,title('Sobel')

figure,imagesc(edge(I,'log')),colormap gray,title('Laplacian of Gaussian')

figure,imagesc(edge(I,'canny',[],0.5)),colormap gray,title('Canny: s=0.5')

figure,imagesc(edge(I,'canny',[],1)),colormap gray,title('Canny: s=1')

figure,imagesc(edge(I,'canny',[],2)),colormap gray,title('Canny: s=2')