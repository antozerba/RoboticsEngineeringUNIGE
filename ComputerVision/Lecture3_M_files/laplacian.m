%

s=1.5;%standard deviation. It is related to spatial support NxN: 
       %N is the smallest odd integer greater than or equal to 6s

sp=ceil(s*3); %approximantion
[X,Y]=meshgrid(-sp:sp);
Z=(1/(2*pi*s^2))*((X.^2+Y.^2 -2*s^2)/s^4).*exp(-(X.^2+Y.^2)/(2*s^2));

figure,imagesc(Z),colormap gray
figure,surf(Z)