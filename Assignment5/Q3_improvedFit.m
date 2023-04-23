%% Computer Vision Course - Assignment 05

%% Q3 (Improved Fit) - Mohammadamin Lari - Student# 66427311
 
clc
clear all
close all

% read image and find its edges
I = imread('gateway_arch.jpg');
%imshow(I,[]);

%E = edge(I, 'method' , THRESH , SIGMA); 
E = edge(I, 'canny',0.3,0.9);
%figure, imshow(E,[]);

% choose parabola sizes to try 
C = 0.011:0.001:0.0125;
c_length = numel(C); 
[M,N] = size(I);

% accumulator array H(N,M,C) initialized with zeros 
H = zeros(M,N,c_length);

% vote to fill H 
[y_edge, x_edge] = find(E); % get edge points

for i = 1:length(x_edge)    % for all edge points
    for c_idx=1:c_length    % for all c
        for a = 1:N
            b = round(y_edge(i)-C(c_idx)*(x_edge(i)-a)^2);
            if(b < M && b >= 1) 
                H(b,a,c_idx) = H(b,a,c_idx)+1; 
            end
        end
    end
end

% Find the local maxima in a 3D neighborhood
Hdilated = imdilate(H, ones(30,30,10));

% We want those places where H = Hdialated and THRESH_low < H < THRESH_high
THRESH_low = 0.8 * max(H(:));
THRESH_high = 0.99 * max(H(:));

Hpeaks = (H == Hdilated) & (H > THRESH_low) & (H < THRESH_high);

% Find indices of the peaks (the nonzero points). 
[iRow,iCol,iDepth] = ind2sub(size(Hpeaks), find(Hpeaks));

% draw parabolas
figure, imshow(I) , title('A more precise detection of Parabola using Hough Transform');
for i=1:length(iRow)
    x0 = iCol(i);
    y0 = iRow(i);
    r0 = C(iDepth(i));
    for x=1:M
        y = round(y0 + r0*(x-x0)^2);
        if y<=N && y >= 1
            rectangle('Position', [x y 1 1], 'EdgeColor', 'r');
        end
    end
end
 