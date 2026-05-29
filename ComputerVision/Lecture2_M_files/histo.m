%Histogram 
load tree
IN=double(IN);
figure,image(IN),colormap gray(256)
figure, imhist(uint8(IN),256)

%Contrast Stretching (also useful for image normalization)
M=max(max(IN));
m=min(min(IN));
out=((IN-m)/(M-m))*255;
figure,image(out),colormap gray(256)
figure, imhist(uint8(out),256)

%histogram equalization 
load tree
OUT = histeq(IN);
figure,image(OUT),colormap gray(256)
figure, imhist(uint8(OUT),256)





