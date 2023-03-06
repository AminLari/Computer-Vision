%% Computer Vision Course - Assignment 02

%% Q3 - Mohammadamin Lari - Student# 66427311

clc
close all
clear all

I = imread('petito_dark2.png');
I2 = intensityStretch(I,2,50,2,200);
