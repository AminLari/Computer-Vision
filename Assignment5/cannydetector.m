function [Ioutput]= cannydetector(I,thr,sig)
I1=im2double(I);
[IGradX, IGradY, Ismooth]= smoothing(I1,sig);
Iabst = (IGradX .^2 + IGradY.^2) .^0.5;
[theta,temp]=computeangle(IGradX,IGradY);
[Iabst1]=nonmaximalsupression(Iabst,theta);
Ie=im2uint8(Iabst1);
Th=thr*max(max(Ie));
Tl=0.4*Th;
[Ie1]=gradingedges(Ie,Tl,Th);
[Ifinal]=connectingedge(Ie1,Tl,Th);
theta2=padarray(theta,[1 1]);
Ifinal= Ifinal(7:end-7,7:end-7);
Ioutput=Ifinal;
figure;
  subplot(2,3,1);imshow(Ismooth);title('Gaussian Filter Applied');
  subplot(2,3,2);imshow(Iabst);title('Gradient magnitude');
  subplot(2,3,3);imshow(temp,[]);title('Alpha:[-180,180]');
  subplot(2,3,4);imshow(theta);title('Alpha:only 4 directions');
  subplot(2,3,5);imshow(Ie);title('Non-maximal suppression');
  subplot(2,3,6);(imshow(Ifinal));title('Canny Edges');