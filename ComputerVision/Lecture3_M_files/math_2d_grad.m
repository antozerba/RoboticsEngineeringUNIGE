%math_2d_grad
x=-4:8/14:4; y=x;
[X,Y]=meshgrid(x,y);%sampling of the 2D domain
F = 100 - 0.5 * X.^2 - 0.5 * Y.^2;
figure,surf(X,Y,F),xlabel('X'),ylabel('Y'),zlabel('Z')
figure,imagesc(F),colormap gray

figure,imagesc(x,y,F),colormap gray
hold on
quiver(X,Y,-X,-Y,'r') % Gradient = [df(x,y)/dx , df(x,y)/dy] = [- x , - y]

