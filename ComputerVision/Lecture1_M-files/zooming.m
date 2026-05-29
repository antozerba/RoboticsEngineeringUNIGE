%zooming

load tree
[rr,cc]=size(IN);
figure,imagesc(IN),colormap gray
zf=2.8; %zooming factor

%forward warping
for ii=1:rr
    for jj=1:cc
        ri=round(zf*ii);
        ci=round(zf*jj);
        tmp(ri,ci)=IN(ii,jj);
    end
end

r0=ceil(ri/2); c0=r0;
vv=-floor(rr/2):floor(rr/2);
out1=tmp(r0+vv,c0+vv);
figure,imagesc(out1),colormap gray,title('forward warping')

%backward warping
[X,Y]=meshgrid(1:cc,1:rr);
XC=X-floor(cc/2); YC=Y-floor(rr/2);
Xn=XC/zf +floor(cc/2);
Yn=YC/zf +floor(rr/2);
% XC=X; YC=Y;
% Xn=XC/zf ;
% Yn=YC/zf ;


figure,imagesc(griddata(X,Y,double(IN),Xn,Yn,'linear')),colormap gray,title('backward warping')
