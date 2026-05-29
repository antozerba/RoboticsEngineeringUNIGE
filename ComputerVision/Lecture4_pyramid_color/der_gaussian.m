%derivative of Gaussian 
img=double(imread('cameraman.tif','tif'));
figure,imagesc(img),colormap gray

%%%1st scale
sigma=1;%std
sp=3*sigma;%spatial support
[X,Y]=meshgrid(-sp:sp,-sp:sp);%spatial domain sampling
GX=X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
GY=Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));
figure,
subplot(121),imagesc(GX),title('Gx'),
subplot(122),imagesc(GY),title('Gy'),colormap gray
Ix=conv2(img,GX,'same');
Iy=conv2(img,GY,'same'); 
figure,
subplot(121),imagesc(Ix),title('Ix'),
subplot(122),imagesc(Iy),title('Iy'),colormap gray


%%%2st scale
sigma=4;%std
sp=3*sigma;%spatial support
[X,Y]=meshgrid(-sp:sp,-sp:sp);%spatial domain sampling
GX=X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
GY=Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));
figure,
subplot(121),imagesc(GX),title('Gx'),
subplot(122),imagesc(GY),title('Gy'),colormap gray
Ix=conv2(img,GX,'same');
Iy=conv2(img,GY,'same'); 
figure,
subplot(121),imagesc(Ix),title('Ix'),
subplot(122),imagesc(Iy),title('Iy'),colormap gray
