%The phase information is crucial to reconstruct the correct spatial structure 
%of the image in the spatial domain

load tree
img=double(IN);
IMG=fft2(img);
MOD=abs(IMG);
PHI=angle(IMG);

figure,imagesc(img), colormap gray,axis square

figure,imagesc(log(fftshift(MOD))), colormap gray,xlabel('wx'),ylabel('wy'),axis square

figure,imagesc(fftshift(PHI)), colormap gray,xlabel('wx'),ylabel('wy'),axis square

figure,imagesc(real(fftshift((ifft2(MOD))))), colormap gray,xlabel('x'),ylabel('y'),axis square

figure,imagesc(real((ifft2(exp(i*PHI))))), colormap gray,xlabel('x'),ylabel('y'),axis square