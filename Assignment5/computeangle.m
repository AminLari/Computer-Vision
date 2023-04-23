function [theta,temp]=computeangle(IGradX,IGradY)
    [a,b]=size(IGradX);
    theta=zeros([a b]);
    for i=1:a
          for j=1:b
                theta(i,j)= atan2(IGradX(i,j),IGradY(i,j));
          end
    end
    temp = theta;
    for i=1:a
      for j=1:b
          if ((-22.5<theta(i,j))&&(theta(i,j)<22.5))||((157.5<theta(i,j))&&(theta(i,j)<181))||((-181<theta(i,j))&&(theta(i,j)<-157.5))
                theta(i,j)=0;
          elseif ((22.5<theta(i,j))&&(theta(i,j)<67.5)) || ((-157.5<theta(i,j))&&(theta(i,j)<-112.5))
                 theta(i,j)=45;
          elseif ((67.5<theta(i,j))&&(theta(i,j)<112.5)) || ((-112.5<theta(i,j))&&(theta(i,j)<-67.5))  
                  theta(i,j)=90;
          elseif ((112.5<theta(i,j))&&(theta(i,j)<157.5)) || ((-67.5<theta(i,j))&&(theta(i,j)<-22.5))
                  theta(i,j)=135;
          end
      end
    end 