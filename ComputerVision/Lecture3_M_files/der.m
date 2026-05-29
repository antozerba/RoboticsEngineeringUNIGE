%image gradient

%artificial image
dx=[1,-1]; %derivative mask for row
dy=[1; -1];%derivative mask for column
img=[ 10*ones(10), 20*ones(10);30*ones(10), 50*ones(10)];
imgx=conv2(img,dx,'same');
imgy=conv2(img,dy,'same');
figure,imagesc(img),colormap gray
figure,imagesc(imgx(:,1:end-1)),colormap gray
figure,imagesc(imgy(1:end-1,:)),colormap gray


%natural image
clear img imgx imgy
load tree
img=double(IN);
imgx=conv2(img,dx,'valid');
imgy=conv2(img,dy,'valid');
figure,imagesc(img),colormap gray
figure,subplot(121),imagesc(imgx),title('imgx'),subplot(122),imagesc(imgy),colormap gray,title('imgy')

