%% Computer Vision Course - Assignment 02

%% Q1 - Mohammadamin Lari - Student# 66427311

function [outputim] = adjustBrightness(inputim,per,typ)
    % checking Grayscale input image
    [rows, columns, numberOfColorChannels] = size(inputim);
    if numberOfColorChannels > 1
        inputim = rgb2gray(inputim);
    end
    inputim = im2double(inputim);
    figure , imshow(inputim);
    title("Grayscale Input Image");
    
    outputim = inputim;
    [h,w] = size(inputim);
    for i = 1:h
        for j = 1:w
            if typ == 'b'
                outputim(i,j) = inputim(i,j)*(1+(per/100));
            elseif typ == 'd'
                outputim(i,j) = inputim(i,j)*(1-(per/100));
            end
        end
    end
    if typ ~= 'b' && typ ~= 'd'
        disp('Unvalid input! Please either enter "b" to brighten or "d" to darken the image.');
    end
    figure , imshow(outputim);
    title("Modified Image");
end