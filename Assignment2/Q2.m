%% Computer Vision Course - Assignment 02

%% Q2 - Mohammadamin Lari - Student# 66427311

clc
close all
clear all

%% Part a
%{ 
    Theoritical Explanation: 
        In order to fix the perspective in an image, we need to select 4
        control points, and then map them to a rectangular shape by a projectve
        transform. The reason that we need 4 points for projective
        transform is that it has 8 unknown variables to be determined. We
        can select a constant rectangular frame for output of the
        transform, but here I am using the longest vertices of the 
        shape selected by the user. Then the command 'fitgeotrans' is 
        finding the transform matrix between input and output shapes. In 
        the end, we apply the transform to input image to fix the perspective. 
        The transform matrix can be written in the form below:
        T = [a1 a2 b1;
             a3 a4 b2;
             c1 c2 1]
        where [a1 a2;a3 a4] is a rotation matrix. The [b1;b2] matrix is a
        translation vector and moves the points. The [c1 c2] matrix is the
        projection vector which helps to map the infinity point in 3D to be
        mapped to a finite coordinate in 2D space. To obtain the output, we
        need to use the following equation:
        [a1 a2 b1;    [x;    [u;
         a3 a4 b2;  *  y;  =  v;
         c1 c2 1]      1]     1]
        
%}


%% Part b

% checking Grayscale input image
I = imread('prespective.jpg');
[rows, columns, numberOfColorChannels] = size(I);
if numberOfColorChannels > 1
    I = rgb2gray(I);
end
I = im2double(I);
figure , imshow(I);
title("Grayscale Input Image");

% selection of 4 points by user and drawing a rectangle around them
[x1,y1] = ginput(1);
rectangle('Position', [x1-2 y1-2 4 4], 'EdgeColor', 'r', 'LineWidth', 1); 
[x2,y2] = ginput(1);
rectangle('Position', [x2-2 y2-2 4 4], 'EdgeColor', 'r', 'LineWidth', 1); 
[x3,y3] = ginput(1);
rectangle('Position', [x3-2 y3-2 4 4], 'EdgeColor', 'r', 'LineWidth', 1); 
[x4,y4] = ginput(1);
rectangle('Position', [x4-2 y4-2 4 4], 'EdgeColor', 'r', 'LineWidth', 1); 

% output frame size
mywidth = max(x2-x1, x4-x3);
myheight = max(y3-y1, y4-y2);

% mapping to a rectangular frame
u1 = x1;
v1 = y1;

u2 = x1 + mywidth;
v2 = y1;

u3 = x1;
v3 = y1 + myheight;

u4 = x1 + mywidth;
v4 = y1 + myheight;

arr = [x1 y1; x2 y2; x3 y3; x4 y4];
arr_tr = [u1 v1; u2 v2; u3 v3; u4 v4];

% finding transform matrix
T = fitgeotrans(arr, arr_tr, 'projective');

% applying transform to input image
I2 = imwarp(I,T);
figure , imshow(I2);
title('Modified Image'); 
