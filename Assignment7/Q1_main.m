%% Computer Vision Course - Assignment 07

%% Q1 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

I = imread('5.jpg');
ImageWithCorners = detectCorners(I,0.7,3,0.04);
