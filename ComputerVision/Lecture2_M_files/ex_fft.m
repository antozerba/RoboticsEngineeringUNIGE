%FFT
%grating
w=64;
[X1,Y1]=meshgrid(1:w); %pixel
X=X1-w/2; Y=Y1-w/2;
Z=sin(2*pi*0.1*X); %0.1 is the frequency (cycles per pixel!)
figure,mesh(Z),xlabel('x'),ylabel('y'),zlabel('z')
figure,imagesc(Z),colormap gray,xlabel('x'),ylabel('y')
FZ=fftshift(fft2(Z));
figure,mesh(abs(FZ)),xlabel('wx'),ylabel('wy'),zlabel('abs(F)')
figure,imagesc(abs(FZ)),colormap gray,xlabel('wx'),ylabel('wy')

%different frequency
Z=sin(2*pi*0.2*X); %0.2 is the frequency
figure,imagesc(Z),colormap gray,xlabel('x'),ylabel('y')
FZ=fftshift(fft2(Z));
figure,imagesc(abs(FZ)),colormap gray,xlabel('wx'),ylabel('wy')

%different orientation
Z=sin(2*pi*0.1*(X+Y)); %0.1 is the frequency
figure,imagesc(Z),colormap gray,xlabel('x'),ylabel('y')
FZ=fftshift(fft2(Z));
figure,imagesc(abs(FZ)),colormap gray,xlabel('wx'),ylabel('wy')

%Gaussian
Z=exp((-X.^2 -Y.^2)/(2*5^2));%standard deviation: 5 pixels
figure,mesh(Z),xlabel('x'),ylabel('y'),zlabel('z')
figure,imagesc(Z),colormap gray,xlabel('x'),ylabel('y')
FZ=fftshift(fft2(Z));
figure,mesh(abs(FZ)),xlabel('wx'),ylabel('wy'),zlabel('abs(F)')%low-pass filter
figure,imagesc(abs(FZ)),colormap gray,xlabel('wx'),ylabel('wy')

%box
Z=zeros(w);
vi=-5:5;
Z(w/2+vi,w/2+vi)=1;
figure,mesh(Z),xlabel('x'),ylabel('y'),zlabel('z')
figure,imagesc(Z),colormap gray,xlabel('x'),ylabel('y')
FZ=fftshift(fft2(Z));
figure,mesh(abs(FZ)),xlabel('wx'),ylabel('wy'),zlabel('abs(F)')
figure,imagesc(abs(FZ)),colormap gray,xlabel('wx'),ylabel('wy')

