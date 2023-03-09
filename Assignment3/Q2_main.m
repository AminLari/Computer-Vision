%% Computer Vision Course - Assignment 03

%% Q2 - Mohammadamin Lari - Student# 66427311

clc 
clear all
close all 

I = imread('coins.png');    	% Image must be grayscale from 0 to 255
I2 = addShadow(I,90,5,10);  	% Threshold=90, blur amount=5, distance=10
subplot(1,2,1), imshow(I), title('original');
subplot(1,2,2), imshow(I2), title('with shadows');

