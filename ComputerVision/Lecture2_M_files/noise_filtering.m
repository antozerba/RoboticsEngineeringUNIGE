%noise

%%%%%%%%%%%%%%%%%%%
%%%synthetic images  artificial imgage 
A=zeros(101);
A(:,50:end)=1;
figure,imagesc(A),colormap gray
B=A+0.1*randn(size(A));   %0.1 is the standard deviation
figure,imagesc(B),colormap gray
figure,plot(A(40,:),'r'),hold on-,plot(B(40,:),'b')

%smoothing by averaging 
K=ones(3)/9;
outc=conv2(B,K,'same');
figure,imagesc(outc),colormap gray,title('smoothing by averaging')
figure,plot(A(40,:),'r'),hold on,plot(outc(40,:),'b'),plot(outc(40,:),'g')

%non-linear filter
outm=medfilt2(B,[3,3]);
figure,imagesc(outm),colormap gray,title('non-linear filter')
figure,plot(A(40,:),'r'),hold on,plot(outc(40,:),'b'),plot(outm(40,:),'g')

%%%%%%%%%%%%%%%%%%
%%%%real-world images
load tree
figure,imagesc(IN),colormap gray

%normal distribution
img=double(IN)+20*randn(size(IN));%20 is the standard deviation
figure,imagesc(img),colormap gray
%
%smoothing by averaging 
K=ones(3)/9;
outc=conv2(img,K,'same');
figure,imagesc(outc),colormap gray,title('smoothing by averaging')
%
%non-linear filter
outm=medfilt2(img,[3,3]);
figure,imagesc(outm),colormap gray,title('non-linear filter')

%Salt and pepper 
load tree
IN=double(IN);
[rr,cc]=size(IN);
indices=full(sprand(rr,cc,0.2));%0.2 is the noise density 
mask1=indices>0 & indices<0.5;  mask2=indices>=0.5;
out= IN.*(~mask1) ;
out=out.*(~mask2)+149*mask2;
figure,imagesc(out),colormap gray
%
%smoothing by averaging
outc=conv2(out,K,'same');
figure,imagesc(outc),colormap gray,title('smoothing by averaging')
%
%non-linear filter
outm=medfilt2(out,[3,3]);
figure,imagesc(outm),colormap gray,title('non-linear filter')

