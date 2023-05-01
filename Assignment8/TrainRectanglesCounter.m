%% Computer Vision Course - Assignment 08

%% Q1 - Mohammadamin Lari - Student# 66427311

function outp = TrainRectanglesCounter()
    % initialization
    Files = dir('dataset\train');
    FileName = Files(3).name;
    target = append('dataset\train\',FileName);
    I = imread(target);
    
    m = size(Files, 1) - 2;
    [a, b, c] = size(I);
    Xtrain = uint8(zeros(a, b, c, m));

    % read train images
    for k=3:length(Files)
        FileNames=Files(k).name;
        target = append('dataset\train\',FileNames);
        I = imread(target);
        Xtrain(:,:,:,k-2) = I;
    end
    
    % read train ground-truth labels
    f = fopen('dataset\TrainY.txt');
    tline = fgetl(f);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1} = tline;
        tline = fgetl(f);
    end
    fclose(f);
    Ytrain = cell2mat(tlines);
    Ytrain = uint8(str2num(Ytrain(:,4:5)));
    
    % Train/Validation Split
    idx=randperm(m);
    p = 0.8;
    h = round(p*m);
    
    X1 = uint8(zeros(a, b, c, h));
    X2 = uint8(zeros(a, b, c, m-h));
    
    for i = 1:h
        X1(:,:,:,i) = Xtrain(:,:,:,idx(i));
        Y1(i,1) = Ytrain(idx(i));
    end
    for i = h+1:m
        X2(:,:,:,i) = Xtrain(:,:,:,idx(i));
        Y2(i,1) = Ytrain(idx(i));
    end
    
    % load pre-trained AlexNet model
    net = alexnet;
    inputSize = net.Layers(1).InputSize;

    % modify network
    layersTransfer = net.Layers(1:end-9);
    
    layers = [
    layersTransfer
    fullyConnectedLayer(1)
    batchNormalizationLayer
    reluLayer
    regressionLayer];
    
    % Freeze weights for faster training
    %layers(1:16) = freezeWeights(layers(1:16));

    % set training options
    options = trainingOptions('adam', ...
    'MiniBatchSize',32, ...
    'MaxEpochs',30, ...
    'InitialLearnRate',1e-2, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{X2, Y2}, ...
    'ValidationFrequency',10, ...
    'Verbose',false, ...
    'Plots','training-progress');
    
    netTransfer = trainNetwork(X1,Y1,layers,options);

    outp = netTransfer;
end