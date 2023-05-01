%% Computer Vision Course - Assignment 08

%% Q1 - Mohammadamin Lari - Student# 66427311

clc
clear all
close all

%% Load test set

% initialization
Files = dir('dataset\test');
m = size(Files, 1) - 2;
FileName = Files(3).name;
target = append('dataset\test\',FileName);
I = imread(target);
m = size(Files, 1) - 2;
    [a, b, c] = size(I);
    Xtest = uint8(zeros(a, b, c, m));

    % read test images
    for k=3:length(Files)
        FileNames=Files(k).name;
        target = append('dataset\test\',FileNames);
        I = imread(target);
        Xtest(:,:,:,k-2) = I;
    end
 
% read test ground-truth labels
f = fopen('dataset\TestY.txt');
tline = fgetl(f);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(f);
end
fclose(f);
Ytest = cell2mat(tlines);
Ytest = uint8(str2num(Ytest(:,4:5)));

%% Train Network and Save Model
Model = TrainRectanglesCounter();
save Model

%% Evaluate Model

% load saved model
load Model

for i = 1:200
    YPred(i) = predict(Model,Xtest(:,:,:,i));
end
YPred = round(YPred);

idx = randperm(m,6);
figure
for i = 1:6
    subplot(2,3,i)
    I = Xtest(:,:,:,idx(i));
    imshow(I)
    label = YPred(i);
    title(string(label));
end

%% Compute Accuracy
load Model

for i = 1:200
    YPred(i) = predict(Model,Xtest(:,:,:,i));
end
YPred = round(YPred);

count = 0;
for i = 1:200
    label = YPred(i);
    if label == Ytest(i)
        count = count + 1;
        fprintf("Ground-truth: %f | Prediction: %f \n", Ytest(i),label); 
    end
end
fprintf("--------------------------------------------- \n");

accuracy = (count / 200)*100;
fprintf("Accuracy: %f percent \n", accuracy);