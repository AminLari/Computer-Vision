clc
clear all
close all
%%
Files = dir('dataset\test');
m = size(Files, 1) - 2;
FileName = Files(3).name;
target = append('dataset\test\',FileName);
I = imread(target);
m = size(Files, 1) - 2;
    [a, b, c] = size(I);
    testset = uint8(zeros(a, b, c, m));

    % read train images
    for k=3:length(Files)
        FileNames=Files(k).name;
        target = append('dataset\test\',FileNames);
        I = imread(target);
        testset(:,:,:,k-2) = I;
    end

f = fopen('dataset\TestY.txt');
tline = fgetl(f);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(f);
end
fclose(f);
arr = cell2mat(tlines);
arr = uint8(str2num(arr(:,4:5)));
%%
Model = TrainRectanglesCounter();
%%
YPred = predict(Model,testset);
YPred = uint8(YPred);
count = 0;

%idx = randperm(m,100);
%figure
for i = 1:200
    %subplot(2,2,i)
    %I = testset(:,:,:,idx(i));
    %imshow(I)
    label = YPred(i);
    %title(string(label));
    if label == arr(i)
        count = count + 1;
    end
end
accuracy = count / 200*100;
fprintf("Accuracy: %d percent \n", accuracy);