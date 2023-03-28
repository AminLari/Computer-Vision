%% Computer Vision Course - Assignment 04

%% Q3 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

I1 = imread ('particles.png');
figure, imshow(I1), title('Input image');

%% Part A
[L, n] = bwlabel(I1);
prop = regionprops(L);

areas = cat(2, prop(:).Area);
cent = cat(1, prop(:).Centroid);
arr = [];

% Finding non-overlapping particles
for i=1:n
    if areas(i)>230 && areas(i)<275 && cent(i,1)>10 && cent(i,2)>10 && cent(i,1)<625 && cent(i,2)<355
        arr = [arr, i];
    end
end

nonover = zeros(size(I1,1),size(I1,2));
for i=1:size(I1,1)
    for j=1:size(I1,2)
        for k=1:size(arr,2)
            if(L(i,j)==arr(k))
                nonover(i,j)=1;
            end
        end
    end
end
figure, subplot(3,1,2),imshow(nonover),title('nonoverlapping particles');


I2 = imclearborder(I1); % removing particles that are merged with boundary

% Finding particles merged with the boundary
I3 = I1 - I2; 
subplot(3,1,1), imshow(I3),title('particles merged with the boundary');

% Finding overlapping particles
I4 = I2 - nonover;
subplot(3,1,3),imshow(I4),title('overlapping particles');

%% Part B

% Creating segmentation-based RGB image
I_color(:,:,1) = 255* I3;
I_color(:,:,2) = 255* nonover;
I_color(:,:,3) = 255* I4;

figure, imshow(I_color), title('3 classes of particles');
