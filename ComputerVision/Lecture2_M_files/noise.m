%%%%noise
load tree
figure,imagesc(IN),colormap gray

%normal distribution
out=double(IN)+10*randn(size(IN));%10 is the standard deviation
figure,imagesc(out),colormap gray
out=double(IN)+30*randn(size(IN));%30 is the standard deviation
figure,imagesc(out),colormap gray
%about noise distribution
a=randn(1,100);
figure,hist(a,21)

%Salt and pepper 
IN=double(IN);
[rr,cc]=size(IN);
maxv=max(max(IN));
indices=full(sprand(rr,cc,0.3));%0.3 is the noise density 
mask1=indices>0 & indices<0.5;  mask2=indices>=0.5;%matlab masking technique
out= IN.*(~mask1) ;
out=out.*(~mask2)+maxv*mask2;
figure,imagesc(out),colormap gray