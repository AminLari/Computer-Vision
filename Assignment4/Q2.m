%% Computer Vision Course - Assignment 04

%% Q2 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

I = imread ('money.png');
I1 = im2bw(I,0.05);

% Filling gaps
S = strel('disk',1);
I2 = imclose(I1,S);

% Removing overlaps
S4 = strel('disk',90);
I2 = imopen(I2, S4);

% Connected-component analyze
[L,n] = bwlabel(I2);
prop = regionprops(L);
areas = cat(2, prop(:).Area);

% Segmentation based on size of regions
indices1 = find(areas>100000); 
indices2 = find(areas>45000);
indices3 = find(areas>25000);

n1 = size(indices1,2); % n1 is the number of the $2 coins
n2 = size(indices2,2); % n2 is the number of the $2 and $1 coins together
n3 = size(indices3,2); % n3 is the number of all the coins together

% Calculation of the amount of money in the picture
num = n1*2 + (n2-n1)*1 + (n3-n2)*0.25;

figure, imshow(I), title("There is $" + num + " in this image.");
