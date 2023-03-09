%% Computer Vision Course - Assignment 03

%% Q1 - Mohammadamin Lari - Student# 66427311

function out = my_histeq(inp,thr,blr,dist)
    % checking Grayscale input image
    [rows, columns, numberOfColorChannels] = size(inp);
    if numberOfColorChannels > 1
        inp = rgb2gray(inp);
    end
    
    out = inp;
    [h,w] = size(inp);
    MN = h*w;
    
    histo = zeros(256,1);
    PDF = zeros(256,1);
    CDF = zeros(256,1);
    
    for i = 1:h
        for j = 1:w
            for k = 0:255
                if inp(i,j) == k
                    histo(k+1) = histo(k+1) + 1;
                end
            end
        end
    end
    
    for k = 1:256
        PDF(k) = histo(k)/MN;
        CDF(k) = sum(PDF(1:k));
    end
    
    CDF = round(255.*CDF);
    
    for i = 1:h
        for j = 1:w
            for k = 0:255
                if inp(i,j) == k
                    out(i,j) = CDF(k+1);
                end
            end
        end
    end  
            
end
