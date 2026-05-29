clc, clearvars
%---------------
%POINT 1
%---------------
sd = 1;
LoG1 = laplacian_of_gaussian(sd);
figure, imagesc(LoG1), colormap gray, title('Lap of Gaussian sd1');
figure, surf(LoG1),  title('Surf Lap of Gaussian sd1');
sd = 3.5;
LoG3 = laplacian_of_gaussian(sd);
figure, imagesc(LoG3), colormap gray, title('Lap of Gaussian sd3.5');
figure, surf(LoG3),  title('Surf Lap of Gaussian sd1');

img = imread("Lab3_testimages/boccadasse.jpg");
img = rgb2gray(img);
img = double(img);
figure, imagesc(img), colormap gray;
img_log1 = conv2(img, LoG1,"same" );
figure, imagesc(img_log1), colormap gray;

tresh = 25;
[rr,cc] = size(img_log1);
T = zeros(rr,cc);
for i = 1:rr-1
    for j = 1:cc-1
        % orizzontale
        if (img_log1(i,j) * img_log1(i,j+1) < 0)
            if(abs(img_log1(i,j) - img_log1(i,j+1)) > tresh)
                T(i,j) = 1;
            end
         
        end
        % verticale
        if (img_log1(i,j) * img_log1(i+1,j) < 0)
            if(abs(img_log1(i,j) - img_log1(i+1,j)) > tresh)
                 T(i,j) = 1;
            end
        end
    end
end
figure, imagesc(T), colormap gray, title('Log1 edge detection')

tresh = 0;
img_log3 = conv2(img, LoG3,"same" );
figure, imagesc(img_log3), colormap gray;
[rr,cc] = size(img_log3);
Z = zeros(rr,cc);
for i = 1:rr-1
    for j = 1:cc-1
        % orizzontale
        if(img_log3(i,j) * img_log3(i,j+1) < 0)
            if(abs(img_log3(i,j) - img_log3(i,j+1)) > tresh)
                T(i,j) = 1;
            end
        end
        % verticale
        if(img_log3(i,j) * img_log3(i+1,j) < 0)
            if(abs(img_log3(i,j) - img_log3(i+1,j)) > tresh)
                T(i,j) = 1;
            end
        end
    end
end
figure, imagesc(Z), colormap gray, title('Log3 edge detection')

figure,imagesc(edge(img,'log')),colormap gray,title('Laplacian of Gaussian')

%---------------
%POINT 2
%---------------
