%% Computer Vision Course - Assignment 01

%% Q1 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

% Part a
I1 = imread('okanagan.jpg');
figure , imshow(I1);

% Part b
figure , imshow(I1(:,:,1));
title('Red');

figure , imshow(I1(:,:,2));
title('Green');

figure , imshow(I1(:,:,3));
title('Blue');

% Part c
I1 = rgb2gray(I1);
figure , imshow(I1);
title('I1');

% Part d
num = size(I1);
fprintf("The image I1 has %d rows of %d column.\n",num(1),num(2));

% Part e
% whos I1
% Name        Size              Bytes  Class
% I1        400x600            240000  uint8 

% Part f
arr = I1(:);
max_intensity = max(arr);
min_intensity = min(arr);
fprintf("Gray level range in I1: %d to %d\n", min_intensity, max_intensity);

% Part g
I2 = immultiply(I1,4);
figure , imshow(I2);
title('I2');

arr2 = I2(:);
max_intensity2 = max(arr2);
min_intensity2 = min(arr2);
fprintf("Gray level range in I2: %d to %d\n", min_intensity2, max_intensity2);

%% Q2 - Mohammadamin Lari - Student# 66427311

I3 = imread('cameraman.tif');
[h,w] = size(I3);
I4 = I1;
I4(num(1)-h+1:num(1),1:w) = I3;
figure , imshow(I4,[]);
title('Cameraman merged with I1');

%% Q3 - Mohammadamin Lari - Student# 66427311

I5 = I1;
for i = 1:num(1)
    for j = 1:num(2)
        if I5(i,j)>175
            I5(i,j) = 0;
        end
    end
end

figure , imshow(I5);
title('Background (sky) removed!');
