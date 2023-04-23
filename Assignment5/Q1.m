%% Computer Vision Course - Assignment 05

%% Q1 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

I = imread('gateway_arch.jpg');
E = myCanny(I,0.2,5);
