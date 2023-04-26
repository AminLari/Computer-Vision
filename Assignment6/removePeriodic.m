function outp = removePeriodic(inp)
    f = im2gray(inp);
    figure,subplot(2,2,1), imshow(f, []),title('Input Image');
    
    % Fourier Transform
    F = fftshift(fft2(double(f)));
    S = log(abs(F));
    subplot(2,2,2), imshow(S,[]),title('Frequency Domain');
    [a, b] = size(S);
   
    I2 = S;

    for i=1:a
        for j=1:b
            if (abs(i - round(a/2)) > 30 || abs(j - round(b/2)) > 30) && (abs(j - round(b/2)) > 2) && (abs(i - round(a/2)) > 1)
                if I2(i,j) > 8.6 
                    I2(i,j) = 0; 
                end
            end
        end
    end
    subplot(2,2,3), imshow(I2,[]),title('Locate/Remove Periodic Noise');
    
    % multiplication (equal to convolution in spacial domain)
    I3 = I2.*F;
    
    % inverse Fourier Transform
    outp = real( ifft2( ifftshift(I3) ) );
    subplot(2,2,4), imshow(outp,[]),title('Output Image');
end