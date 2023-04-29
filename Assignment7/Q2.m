%% Computer Vision Course - Assignment 07

%% Q2 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

%% Initialization

% Cell size selection
size = input("Please enter HOG transform cell size: ");

while size ~=2 && size ~=4 && size ~=8 && size ~=16 && size ~=32 
    disp('ERROR! Wrong Cell Size! Cell size has to be one of the following values:[2,4,8,16,32].');
    size = input("Please enter HOG transform cell size: ");
end

% Setting feature vector size
if size == 2
    num = 70308;
elseif size == 4
    num = 16740;
elseif size == 8
    num = 3780;
elseif size == 16
    num = 756;
elseif size == 32
    num = 108;
end

% Initialize output paramters
total = 14;
count = 0;
outp = zeros(14);

%% Train

% Extraction of HOG features for the training images (human)
Files=dir('train\human');
F = zeros(20,num);

for k=3:length(Files)
    FileNames=Files(k).name;
    target = append('train\human\',FileNames);
    I = imread(target);
    I2 = imresize(I,[128, 64]);
    I2 = im2single(I2);

    F(k-2,:) = extractHOGFeatures(I2,'CellSize',[size size]);
end

% Extraction of HOG features for the training images (non human)
Files2=dir("train\not human");

for k=3:length(Files2)
    FileNames=Files2(k).name;
    target = append("train\not human\",FileNames);
    I = imread(target);
    I2 = imresize(I,[128, 64]);
    I2 = im2single(I2);

    F(k+8,:) = extractHOGFeatures(I2,'CellSize',[size size]);
end

% Ground Truth Labels for SVM training
labels = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

% Train SVM
model = fitcsvm(F,labels);

%% Test

% Extraction of HOG features for the test images (human)
Files = dir('test\human');
featu = zeros(20,num);

for k=3:length(Files)
    FileNames=Files(k).name;
    target = append('test\human\',FileNames);
    I = imread(target);
    I2 = imresize(I,[128, 64]);
    I2 = im2single(I2);

    featu(k-2,:) = extractHOGFeatures(I2,'CellSize',[size size]);
    
    % predict using trained SVM
    outp(k-2) = predict(model,featu(k-2,:));
    
    % compare prediction with ground truth label
    if outp(k-2) == 1
        count = count + 1;
    end
end

% Extraction of HOG features for the test images (non human)
Files = dir('test\not human');

for k=3:length(Files)
    FileNames=Files(k).name;
    target = append('test\not human\',FileNames);
    I = imread(target);
    I2 = imresize(I,[128, 64]);
    I2 = im2single(I2);

    featu(k+5,:) = extractHOGFeatures(I2,'CellSize',[size size]);
    
    % predict using trained SVM
    outp(k+5) = predict(model,featu(k+5,:));
    
    % compare prediction with ground truth label
    if outp(k+5) == 0
        count = count + 1;
    end
end

%% Visualization

% Accuracy calculation
accuracy = (count/total) * 100;
message = sprintf("The accuracy of trained model is %f percent.", accuracy);
disp(message);

% Plot accuracy vs HOG cell size
x = [2,4,8,16,32];
y = [100, 100, 100, 92.86, 71.43];
plot(x,y,'bo','linewidth',2),title('Accuracy of trained SVM versus HOG cell size'),xlabel('Cell Size'),ylabel('Accuracy (%)'),ylim([0 110]);

