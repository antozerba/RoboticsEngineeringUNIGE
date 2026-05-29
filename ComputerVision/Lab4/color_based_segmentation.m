clc, clearvars, close all;


img1 = imread("Lab4_testimages/ur_c_s_03a_01_L_0376.png");
img2 = imread("Lab4_testimages/ur_c_s_03a_01_L_0377.png");
img3 = imread("Lab4_testimages/ur_c_s_03a_01_L_0378.png");
img4 = imread("Lab4_testimages/ur_c_s_03a_01_L_0379.png");
img5 = imread("Lab4_testimages/ur_c_s_03a_01_L_0380.png");
img6 = imread("Lab4_testimages/ur_c_s_03a_01_L_0381.png");
figure, imagesc(img1), colormap gray;
figure, imagesc(img1(:,:,1)),colormap gray,title('R component');
figure, imagesc(img1(:,:,2)),colormap gray,title('G component');
figure, imagesc(img1(:,:,3)),colormap gray,title('B component');

img ={img1,img2,img3,img4,img5,img6};




for i=1:6;
    img{i} = rgb2hsv(img{i});
end

figure, imagesc(img{1}), colormap gray;
figure, imagesc(img{1}(:,:,1)), colormap gray, title('H component');


%--------------
%POINT 3
%--------------
H = img{1}(:,:,1);
r = H(390:400,575:595);
std = std(r(:));
mean = mean(r(:));
%--------------
%POINT 4
%--------------
[rr,cc,pp] = size(img{1});
seg = zeros(rr,cc);
mask = img{1}(:,:,1) > mean -std & img{1}(:,:,1) < mean +std;
seg = seg + mask;
figure, imagesc(seg), colormap gray, title('Seg');
L = bwlabel(seg);
prop=regionprops(L, 'Area','Centroid','BoundingBox');
[value, ind] = max([prop.Area]);
xc=floor(prop(ind).Centroid(1));
yc=floor(prop(ind).Centroid(2));
ul_corner_width=prop(ind).BoundingBox;
figure,imagesc(seg),colormap gray,title('Black Car')
hold on
plot(xc,yc,'*r')
rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0])

%--------------
%POINT 5
%--------------
[rr,cc,pp] = size(img{1});
red = zeros(rr,cc);
mask = img{1}(:,:,1) > 0.97 & img{1}(:,:,1) < 1;
red = red + mask;
figure, imagesc(red), colormap gray, title('Seg');
L = bwlabel(red);
prop=regionprops(L, 'Area','Centroid','BoundingBox');
[value, ind] = max([prop.Area]);
xc=floor(prop(ind).Centroid(1));
yc=floor(prop(ind).Centroid(2));
ul_corner_width=prop(ind).BoundingBox;
figure,imagesc(red),colormap gray,title('Red Car')
hold on
plot(xc,yc,'*r')
rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0])