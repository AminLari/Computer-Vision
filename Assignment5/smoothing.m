function [IGradX, IGradY, Ismooth]= smoothing(I1,sig)
   f = fspecial('gaussian',sig*5,sig);
   Ismooth= conv2(I1,f);
   gradXmask=[-1 0 1;
              -2 0 2; 
              -1 0 1];
  gradYmask=[1 2 1;
             0 0 0; 
            -1 -2 -1];
  IGradX= conv2(Ismooth,gradXmask);
  IGradY= conv2(Ismooth,gradYmask);
    