%% IMPORT FROM IMAGELABELER
% load('gTruth_violin_bow_points_rev1.mat','gTruth')
% 
% imageFileName=gTruth.DataSource.Source
% violin=gTruth.LabelData.violin
% bow_hand=gTruth.LabelData.bow_hand
% bow_end=gTruth.LabelData.bow_end
% voluta=gTruth.LabelData.voluta
% barbada=gTruth.LabelData.barbada
% puente=gTruth.LabelData.puente
% partsViolin = table(imageFileName, violin,bow_hand,bow_end,voluta,barbada,puente)

load_dataset

% extension = '.jpg';
% for k=1:size(partsViolin,1)
%     path = partsViolin{k,1};
%     [~,filename,~] = fileparts(char(path));
%     partsViolin{k,1} = {strcat('imageset/',filename,extension)};
% end

%%
doTrainingAndEval = false;
if ~doTrainingAndEval && ~exist('fasterRCNNResNet50VehicleExample.mat','file')
    % Download pretrained detector.
    disp('Downloading pretrained detector (118 MB)...');
    pretrainedURL = 'https://www.mathworks.com/supportfiles/vision/data/fasterRCNNResNet50VehicleExample.mat';
    websave('fasterRCNNResNet50VehicleExample.mat',pretrainedURL);
end

%%
% Unzip vehicle dataset images.
%unzip vehicleDatasetImages.zip

% Load vehicle dataset ground truth.
%data = load('vehicleDatasetGroundTruth.mat');
%vehicleDataset = data.vehicleDataset;

%%
% violinDataset = partsViolin;

% Add the fullpath to the local vehicle data folder.
%violinDataset.imageFileName = fullfile(pwd, violinDataset.imageFileName);

% % Read one of the images.
% I = imread(violinDataset.imageFileName{10});
% 
% % Insert the ROI labels.
% I = insertShape(I, 'Rectangle', violinDataset.voluta{10});
% 
% % Resize and display image.
% I = imresize(I,3);
% figure
% imshow(I)

%% Split the data set

% Set random seed to ensure example training reproducibility.
rng(0);

% Randomly split data into a training and test set.
shuffledIdx = randperm(height(violinDataset));
idx = floor(0.2 * height(violinDataset));
trainingData = violinDataset(shuffledIdx(1:idx),:);
testData = violinDataset(shuffledIdx(idx+1:end),:);

%% Configure Training Options

% Options for step 1.
options = trainingOptions('sgdm', ...
    'MaxEpochs', 5, ...
    'MiniBatchSize', 1, ...
    'InitialLearnRate', 1e-3, ...
    'CheckpointPath', tempdir);

% Train Faster R-CNN
UseParallel=true;
doTrainingAndEval=true;

if doTrainingAndEval
    
    % Train Faster R-CNN detector.
    %  * Use 'resnet50' as the feature extraction network. 
    %  * Adjust the NegativeOverlapRange and PositiveOverlapRange to ensure
    %    training samples tightly overlap with ground truth.
    [detector, info] = trainFasterRCNNObjectDetector(trainingData, 'resnet50', options, ...
        'NegativeOverlapRange', [0 0.3], ...
        'PositiveOverlapRange', [0.6 1]);
else
    % Load pretrained detector for the example.
    %pretrained = load('fasterRCNNResNet50VehicleExample.mat');
    pretrained = load('rcnn_rev1.mat');
    detector = pretrained.detector;
end

% Note: This example verified on an Nvidia(TM) Titan X with 12 GB of GPU
% memory. Training this network took approximately 10 minutes using this setup.
% Training time varies depending on the hardware you use.

% %% run the detector on one test image.
% 
% % Read a test image.
% I = imread(testData.imageFileName{1});
% 
% % Run the detector.
% [bboxes,scores,label] = detect(detector,I);
% 
% % Annotate detections in the image.
% I = insertObjectAnnotation(I,'rectangle',bboxes,cellstr(label));
% figure
% imshow(I)

