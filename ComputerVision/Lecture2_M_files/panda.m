tmp=imread('panda.png');
im=rgb2gray(tmp);
fsize=33;
for sigma=1:3:9 
	h = fspecial('gaussian', fsize, sigma);
	out = imfilter(im, h); 
	imagesc(out);colormap gray
	pause; 
    imagesc(h);
    pause
end
