%%%Sobel edge detector
dx=[1 0 -1; 2 0 -2; 1 0 -1];
dy=[1 2 1; 0  0  0; -1 -2 -1];
tmp=imread('left_#290gray.bmp','bmp');
I=double(tmp);
figure,imagesc(I),colormap gray
Ix=conv2(I,dx,'same');
Iy=conv2(I,dy,'same');
M=sqrt(Ix.^2 + Iy.^2);%magnitude
figure,imagesc(M),colormap gray, colorbar,title('Magnitude map')
I_edge=M>100; %Threshold
figure,imagesc(~I_edge),colormap gray,title('Edge map')%binary image

%noise
I=double(tmp)+10*randn(size(I));
figure,imagesc(I),colormap gray
Ix=conv2(I,dx,'same');
Iy=conv2(I,dy,'same');
M=sqrt(Ix.^2 + Iy.^2);
figure,imagesc(M),colormap gray,colorbar,title('Magnitude map (noise)')
I_edge=M>100;
figure,imagesc(~I_edge),colormap gray,title('Edge map (noise)')
outm=medfilt2(I_edge,[3,3]);
figure,imagesc(~outm),colormap gray,title('Edge map (noise filtered out by median)')
