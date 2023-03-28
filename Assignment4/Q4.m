%% Computer Vision Course - Assignment 04

%% Q4 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

I1 = imread ('445_descr.png');
figure, imshow(I1), title('Input image');

% Removing upper part of the text
S = strel('disk',3);
I2 = imopen(I1,S);

% Removing bottom part of the text
I3 = imclose(I1,S);

% Extracting boundary between upper and bottom texts
S = strel('disk',10);
Iprime = imopen(I1,S);
I = imbinarize(Iprime,0.01);
I = imcomplement(I);
[L, n]=bwlabel(I);
prop = regionprops(L);
cent = cat(1, prop(:).Centroid);
boundary = round(cent(1,1) - 113);

% Extracting background
I4 = zeros(size(I1,1),size(I1,2));
for i=1:size(I1,1)
    for j=1:size(I1,2)
        if i < boundary
            I4(i,j) = I2(i,j);
        else
            I4(i,j) = I3(i,j);
        end
    end
end

% Extracting bottom part of the text
I5 = uint8(I4)-I1;
I5 = imbinarize(I5,0.01);

% Extracting upper part of the text
I6 = I1-uint8(I4);
I6 = imbinarize(I6,0.01);

% Negative image
I7 = imcomplement(I5+I6);

% Clarifying the text
S2 = strel('disk',1);
I8 = imerode(I7,S2);

figure, subplot(1,2,2), imshow(uint8(I4)), title('Background Only');
subplot(1,2,1), imshow(I8), title('Text Only');
