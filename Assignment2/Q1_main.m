%% Computer Vision Course - Assignment 02

%% Q1 - Mohammadamin Lari - Student# 66427311

clc
close all
clear all

I1 = imread('prespective.jpg');
I2 = adjustBrightness(I1,75,'b');