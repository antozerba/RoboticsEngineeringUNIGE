%Image segmentation based on color
%Geometrical properties of regions (blob analysis

%%%color spaces
img_rgb=imread('color-balls.jpg');
img_hsv=rgb2hsv(img_rgb);
figure,image(img_rgb)
figure,subplot(236)
subplot(231),imagesc(img_rgb(:,:,1)),colormap gray,title('R component')%as intensity
subplot(232),imagesc(img_rgb(:,:,2)),colormap gray,title('G component')%as intensity
subplot(233),imagesc(img_rgb(:,:,3)),colormap gray,title('B component')%as intensity
subplot(234),imagesc(img_hsv(:,:,1)),colormap gray,title('H component')%as intensity
subplot(235),imagesc(img_hsv(:,:,2)),colormap gray,title('S component')%as intensity
subplot(236),imagesc(img_hsv(:,:,3)),colormap gray,title('V component')%as intensity

%simple segmentation
[rr,cc,pp]=size(img_hsv);
seg=zeros(rr,cc);
mask=img_hsv(:,:,1)>0.40 & img_hsv(:,:,1)<0.44; %threshold on the hue componet
seg=seg+mask;
figure,imagesc(seg),colormap gray, title('segmented object (blob)') %binary image (segmented image, i.e. detection of a given color)

%%%Properties of image regions  (blob analysis)
%binary image seg has only one detected object, the white area (blob), thus
%we can consider the seg image as labeled one, i.e. the unique blob has
%label 1

prop=regionprops(seg, 'Area','Centroid','BoundingBox');
xc=floor(prop(1).Centroid(1));
yc=floor(prop(1).Centroid(2));
ul_corner_width=prop(1).BoundingBox;
figure,imagesc(seg),colormap gray,title('detected object')
hold on
plot(xc,yc,'*r')
rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0])

