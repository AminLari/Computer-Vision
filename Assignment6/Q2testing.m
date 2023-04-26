%% Computer Vision Course - Assignment 06

%% Q2 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

%N is the first N components in the descriptor
%version:
% 0 - orignial descriptor
% 1 - exclude DC component
% 2 - divide by first component (normalization)
% 3 - apply both 1 & 2

N = 80;        
version = 3;

trainImages = {};
trainImages{1} = imread('train\0_r.bmp');
trainImages{2} = imread('train\1_r.bmp');
trainImages{3} = imread('train\2_r.bmp');

trainDescriptors = {};
trainDescriptors{1} = FourierDescriptor(trainImages{1},N,version);
trainDescriptors{2} = FourierDescriptor(trainImages{2},N,version);
trainDescriptors{3} = FourierDescriptor(trainImages{3},N,version);

testImages = {};
testImages{1} = imread('test\0_1.bmp');
testImages{2} = imread('test\0_2.bmp');
testImages{3} = imread('test\1_1.bmp');
testImages{4} = imread('test\1_2.bmp');
testImages{5} = imread('test\2_1.bmp');
testImages{6} = imread('test\2_2.bmp');
actualLabels = [0;0;1;1;2;2];

testDescriptors = {};
testDescriptors{1} = FourierDescriptor(testImages{1},N,version);
testDescriptors{2} = FourierDescriptor(testImages{2},N,version);
testDescriptors{3} = FourierDescriptor(testImages{3},N,version);
testDescriptors{4} = FourierDescriptor(testImages{4},N,version);
testDescriptors{5} = FourierDescriptor(testImages{5},N,version);
testDescriptors{6} = FourierDescriptor(testImages{6},N,version);


[~,numOfTestSamples] = size(testImages);
[~,numOfClasses] = size(trainImages);

classifiedCorrectly = 0;
for i = 1:numOfTestSamples
   minDistance = 999999;
   predLabel = -1;
   for j = 1:numOfClasses
       d = EuclideanDistance(trainDescriptors{j},testDescriptors{i});
       if(d < minDistance)
          minDistance = d;
          predLabel = j-1;
       end
   end
   if(predLabel == actualLabels(i))
       display(strcat(int2str(actualLabels(i)),' is classified correctly'));
       classifiedCorrectly = classifiedCorrectly+1;
   else
       display(strcat(int2str(actualLabels(i)),' is classified wrongly as ',int2str(predLabel)));
   end
   figure, 
   subplot(1,2,1),imshow(testImages{i}),title('test image');
   subplot(1,2,2),imshow(trainImages{predLabel+1}),title('matched training image');  
end
acc = classifiedCorrectly/numOfTestSamples;
display(sprintf('the accuracy is :%.6f',acc*100));

