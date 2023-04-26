function outp = FourierDescriptor(inp,M,mode)
    I1 = im2bw(inp);

    % find edges
    I3 = edge(I1,'canny');
    [a,b] = size(I3);
    
    % find coordinate of edge pixels
    [columns, rows] = find(I3);
    N = size(rows,1);
    border = [rows(:), columns(:)];
          
    % Validation of M parameter
    if M > N
        M = N;
    end
    
    % convert coordinate to complex number
    z = complex(border(:,1),border(:,2));
    
    % compute DFT
    F = [];
    ff = 0;
    for k=0:N-1
        for m=0:N-1
            ff = ff + z(m+1)*exp(-(j*2*pi*k*m)/N); 
        end
        F = [F ff];
        ff = 0;
    end
    
    % version configuration
    if mode == 0
        outp = F;
    
    elseif mode == 1 
        F = F(2:end);
        outp = F;

    elseif mode == 2
        F = F/F(1);
        outp = F;
            
    elseif mode == 3
        F = F/F(1);
        F = F(2:end);
        outp = F;      
    end
end