function outp = detectCorners(inp,sig1,sig2,alpha)
   I1 = im2double(rgb2gray(inp));
   
   % Step A
   f = fspecial('gaussian', round(6*sig1), sig1);
   I2 = imfilter(I1, f,'same');
   
   wx = [-1 -2 -1;0 0 0;1 2 1];
   wy = wx';
   
   gx = imfilter(I2, wx,'same');
   gy = imfilter(I2, wy,'same');
   
   % Step B
   A = gx.^2;
   B = gx.*gy;
   C = gy.^2;
   
   % Step C
   f2 = fspecial('gaussian', round(6*sig2), sig2);
   
   Ag = imfilter(A, f2,'same');
   Bg = imfilter(B, f2,'same');
   Cg = imfilter(C, f2,'same');
   
   % Step D
   tr = Ag + Cg;
   det = Ag.*Cg - Bg.*Bg;
   
   % Step E
   R = det - alpha.*((tr).^2);
   
   % Step F
   radius = 1;
   N = 2 * radius + 1;
   Rdilated = imdilate (R, strel('disk', N)); % Grey scale dilate.
   
   % Step G
   R0 = 0.01 * max(max(R));
   corners = (R == Rdilated) & (R > R0);
   
   outp = corners;
   
   % Step H
   [r, c] = find(outp); % Find row,col coords .
   figure, imshow (inp),title('Image with Detected Corners'), hold on
   plot(c, r, 'rs');
   
end