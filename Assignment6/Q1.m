%% Computer Vision Course - Assignment 06

%% Q1 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

I1 = imread('periodic1.bmp');
I2 = imread('periodic2.bmp');

cleanImage1 = removePeriodic(I1);
cleanImage2 = removePeriodic(I2);