%Gaussian Smoothing at Different Scales

img=double(imread('cameraman.tif','tif'));

for sigma=1:4;%std: different scales
    sp=3*sigma;%spatial support
    [X,Y]=meshgrid(-sp:sp,-sp:sp);%spatial domain sampling
    G=exp(-(X.^2+Y.^2)/(2*sigma^2));
    imgs=conv2(img,G,'same');%smoothing 
    figure,subplot(121),imagesc(img),subplot(122),imagesc(imgs),colormap gray
end
figure,imagesc(G),colormap gray