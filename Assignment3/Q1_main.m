%% Computer Vision Course - Assignment 03

%% Q1 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

I = imread('fig0315c.bmp');   %download fig0315c.bmp from Connect
I2 = histeq(I); % to compare your code vs. Matlab’s function
I3 = my_histeq(I);
subplot(1,3,1),imshow(I),title('original');
subplot(1,3,2),imshow(I2),title('using Matlab histeq')
subplot(1,3,3),imshow(I3),title('using my equalizer');
