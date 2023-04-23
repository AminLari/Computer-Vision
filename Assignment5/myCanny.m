function [outp,al,mm] = myCanny(inp,thr,sig)
    I = im2double(inp);
    [a,b]=size(I);

    % smoothing using gaussian filter
    f = fspecial('gaussian', floor(sig*5/2), floor(sig/2));
    I2 = imfilter(I,f);
    %figure, imshow(I2), title('Gaussian Filter applied');
    
    % Sobel filters
    wx = [-1 -2 -1; 0 0 0; 1 2 1];
    wy = wx';
    
    gx = imfilter(I2,wx);
    gy = imfilter(I2,wy);
    
    % Compute Gradient magnitude and angle
    M = (gx .^2 + gy.^2) .^0.5;
    alpha = atan2(gx,gy);
    alpha = rad2deg(alpha);

    I3 = M;
    I4 = alpha;
    
    Thigh = thr*max(max(I3))*255;
    Tlow = 0.4*Thigh;
    
    % Compute and display alpha
    %figure, imshow(I3,[]), title('Gradient Magnitude');
    %figure, imshow(I4,[]), title('Alpha: [-180,180]');
    
    temp = alpha;
    
    for i=1:a
      for j=1:b
          if ((-22.5<alpha(i,j))&&(alpha(i,j)<22.5))||((157.5<alpha(i,j))&&(alpha(i,j)<181))||((-181<alpha(i,j))&&(alpha(i,j)<-157.5))
                alpha(i,j)=0;
          elseif ((22.5<alpha(i,j))&&(alpha(i,j)<67.5)) || ((-157.5<alpha(i,j))&&(alpha(i,j)<-112.5))
                 alpha(i,j)=45;
          elseif ((67.5<alpha(i,j))&&(alpha(i,j)<112.5)) || ((-112.5<alpha(i,j))&&(alpha(i,j)<-67.5))  
                  alpha(i,j)=90;
          elseif ((112.5<alpha(i,j))&&(alpha(i,j)<157.5)) || ((-67.5<alpha(i,j))&&(alpha(i,j)<-22.5))
                  alpha(i,j)=135;
          end
      end
    end
    
    %non-maxima suppression
    M = padarray(M,[1 1],'replicate');
    alpha = padarray(alpha,[1 1],'replicate');
    for i=2:size(I,1)+1
        for j=2:size(I,2)+1
            if (alpha(i,j)==135)
                 if ((M(i-1,j+1)>M(i,j))||(M(i+1,j-1)>M(i,j)))
                      M(i,j)=0;
                  end
            elseif (alpha(i,j)==45)   
                  if ((M(i+1,j+1)>M(i,j))||(M(i-1,j-1)>M(i,j)))
                       M(i,j)=0;
                  end
            elseif (alpha(i,j)==90)   
                  if ((M(i,j+1)>M(i,j))||(M(i,j-1)>M(i,j)))
                      M(i,j)=0;
                  end
            elseif (alpha(i,j)==0)   
                  if ((M(i+1,j)>M(i,j))||(M(i-1,j)>M(i,j)))
                      M(i,j)=0;
                  end
            end
        end
    end

%     for i=2:size(I,1)+1
%         for j=2:size(I,2)+1
%             if alpha(i,j)>=-22.5 && alpha(i,j)<22.5
%                 if M(i,j)< M(i-1,j) || M(i,j)< M(i+1,j)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=22.5 && alpha(i,j)<67.5
%                 if M(i,j)< M(i-1,j-1) || M(i,j)< M(i+1,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=67.5 && alpha(i,j)<112.5
%                 if M(i,j)< M(i,j-1) || M(i,j)< M(i,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=112.5 && alpha(i,j)<157.5
%                 if M(i,j)< M(i+1,j-1) || M(i,j)< M(i-1,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=157.5 && alpha(i,j)<=180
%                 if M(i,j)< M(i-1,j) || M(i,j)< M(i+1,j)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=-180 && alpha(i,j)<-157.5
%                 if M(i,j)< M(i-1,j) || M(i,j)< M(i+1,j)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=-157.5 && alpha(i,j)<-112.5
%                 if M(i,j)< M(i-1,j-1) || M(i,j)< M(i+1,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=-112.5 && alpha(i,j)<-67.5
%                 if M(i,j)< M(i,j-1) || M(i,j)< M(i,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             elseif alpha(i,j)>=-67.5 && alpha(i,j)<-22.5
%                 if M(i,j)< M(i+1,j-1) || M(i,j)< M(i-1,j+1)
%                     M(i,j)=0;
%                 else
%                     continue;
%                 end
%             end
%         end
%     end
    
    I5 = M(2:size(I,1)+1,2:size(I,2)+1);
    Ip = I5;
    %figure, imshow(I5,[]), title('Non-maximal Suppression');
    %S = strel('disk',1);
    I5=im2uint8(I5)/10;
    
    Thigh = thr*max(I5,[],'all');
    Tlow = 0.4*Thigh;

    % double thresholding
    I6 = zeros(size(I,1),size(I,2));
    
    for i=1:size(I,1)
        for j=2:size(I,2)
            if I5(i,j)>=Thigh
                I6(i,j) = I5(i,j);
            elseif I5(i,j)>Tlow && I5(i,j)<Thigh
                I6(i,j) = I5(i,j);
            end
        end
    end
    
    I6 = padarray(I6,[1 1],'replicate');

    outp = zeros(size(I6,1),size(I6,2));
    for i=2:size(I6,1)-1
        for j=2:size(I6,2)-1
            if (I6(i,j)>Thigh)
                outp(i,j)=I6(i,j);
                 for i2=(i-1):(i+1)
                     for j2= (j-1):(j+1)
                         if (I6(i2,j2)>Tlow)&&(I6(i2,j2)<Thigh)
                             outp(i2,j2)=I6(i,j);
                         end
                     end
                  end
            end
       end
    end
    
    outp = outp(2:size(I,1)+1,2:size(I,2)+1);
    %figure, imshow(outp,[]), title('Canny Edges');
figure;
  subplot(2,3,1);imshow(I2,[]);title('Gaussian Filter Applied');
  subplot(2,3,2);imshow(I3);title('Gradient magnitude');
  subplot(2,3,3);imshow(I4,[]);title('Alpha:[-180,180]');
  subplot(2,3,4);imshow(alpha,[]);title('Alpha:only 4 directions');
  subplot(2,3,5);imshow(Ip);title('Non-maximal suppression');
  subplot(2,3,6);(imshow(outp,[]));title('Canny Edges');
end