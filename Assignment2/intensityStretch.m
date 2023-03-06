%% Computer Vision Course - Assignment 02

%% Q3 - Mohammadamin Lari - Student# 66427311

function [myoutput] = intensityStretch(inp,r1,r2,s1,s2)
    % checking Grayscale input image
    [rows, columns, numberOfColorChannels] = size(inp);
    if numberOfColorChannels > 1
        inp = rgb2gray(inp);
    end
    figure , imshow(inp);
    title("Grayscale Input Image");
    
    myoutput = inp;
    [h,w] = size(inp);
    arr = inp(:);
    max_intensity = max(arr);
    min_intensity = min(arr);

    if r1 < min_intensity
        disp('Unvalid input! Parameter r1 must be greater than %d.',min_intensity);
    end
    if r2 > max_intensity 
        disp('Unvalid input! Parameter r2 must be less than %d.',max_intensity);
    end
    if s1 < 0
        disp('Unvalid input! Parameter s1 must be greater than 0.');
    end
    if s2 > 255
        disp('Unvalid input! Parameter s2 must be less than 255.');
    end
   
    if r1 >= min_intensity && r2 <= max_intensity && s1 >= 0 && s2 <= 255
        slope = (s2-s1)/(r2-r1);
        intercept = s2 - slope*r2;
        for i = 1:h
            for j = 1:w
                myoutput(i,j) = (inp(i,j)*slope) + intercept;
            end
        end
    end
    
    figure , imshow(myoutput);
    title("Modified Image");
end