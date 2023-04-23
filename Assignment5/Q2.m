%% Computer Vision Course - Assignment 05

%% Q2 - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

I = imread('fig1039a.png');

% detect edges
E = edge(I,'log');
imshow(I);

% find circles
[centers, radii] = imfindcircles(E,[30 70]);

% show output
viscircles(centers, radii,'EdgeColor','r');
title("r1=" + round(radii(1),1) + " at (" + round(centers(3)) +"," + round(centers(1)) + ") , r2=" + round(radii(2),1) + " at (" + round(centers(4))+"," + round(centers(2)) + ")" );
