%% Computer Vision Course - Assignment 03

%% Q2 - Mohammadamin Lari - Student# 66427311

function out = addShadow(inp,thr,blr,dist)
    % checking Grayscale input image
    [rows, columns, numberOfColorChannels] = size(inp);
    if numberOfColorChannels > 1
        inp = rgb2gray(inp);
    end
    
    [h,w] = size(inp);
    
    Ido = inp;
    Ise = inp;
    Ichar = inp;
    
    for i = 1:h
        for j = 1:w
            if inp(i,j) < thr
                Ise(i,j) = 0;
            end
        end
    end

    for i = 1:h
        for j = 1:w
            if inp(i,j) > thr
                Ichar(i,j) = 0;
            end
        end
    end
    
    thr = thr/255;
    Ido = im2bw(inp,thr);
    Ido = imcomplement(Ido);
    
    se = strel('disk',7);
    Ido = imclose(Ido,se);
    
    Ido = uint8(Ido).*255;
    filt = fspecial('gaussian', blr*5, blr);
    Ido = imfilter(Ido, filt,'replicate'); 

    for i = 1:h
        for j = 1:w
            if Ido(i,j) > 100
                Ido(i,j) = 0;
            end
        end
    end
    
    filt2 = fspecial('gaussian', blr*3, blr*3);
    Ido = imfilter(Ido, filt2,'replicate');
    Ido = Ido.*3;
    Ido = circshift(Ido, [round(dist/2) round(dist/1.8)]);

    
    out = Ichar - Ido + Ise;

end
