%% Evaluate Detector Using Test Set
%temp = load('testData_a1_g_p1_j.mat');
%testData = temp.testData;
%%
%load('testData_a1_g_p1_j_497-621.mat')

doTrainingAndEval=true;
if doTrainingAndEval
    % Create a table to hold the bounding boxes, scores, and labels output by
    % the detector.
    numImages = height(testData)
    results = table('Size',[numImages 3],...
        'VariableTypes',{'cell','cell','cell'},...
        'VariableNames',{'Boxes','Scores','Labels'});
    
    p=1;
    % Run detector on each image in the test set and collect results.
    for i = 1:numImages
        i
        % Read the image.
        I = imread(testData.imageFileName{i});
        
        % Run the detector.
        [bboxes, scores, labels] = detect(detector, I);
        
        % Collect the results.
        % Collect the results.
        all_results.Boxes{i} = bboxes;
        all_results.Scores{i} = scores;
        all_results.Labels{i} = labels;
        
        %[selectedBboxes,selectedScores,selectedLabels,index] = selectStrongestBboxMulticlass(bboxes,scores,labels)
        selectedBboxes=[];
        selectedLabels=[];
        selectedScores=[];
        for k=1:length(labels)
            idx = find(max(max(scores)));
            if find(contains(string(selectedLabels),string(labels(idx)))) >= 1

            else
                selectedBboxes = [selectedBboxes;bboxes(idx,:)];
                selectedLabels = [selectedLabels;labels(idx,:)];
                selectedScores = [selectedScores;scores(idx,:)];
                bboxes(idx,:)=[];
                labels(idx,:)=[];
                scores(idx,:)=[];
                
            end
        end
        
        % Collect the results.
        % Collect the results.
        results.Boxes{i} = selectedBboxes;
        results.Scores{i} = selectedScores;
        results.Labels{i} = selectedLabels;
        if length(selectedLabels)==6
            perfect_detection(p)=i
            p=p+1;
        end
        
        show_bboxdetection(i,results,testData);
        lines_violin(i,results,I);
        iou_eval(i,results,testData);
        
        % Annotate detections in the image.
        %I = insertObjectAnnotation(I,'rectangle',results.Boxes{i},cellstr(results.Labels{i}));
        %I = insertObjectAnnotation(I,'rectangle',selectedBboxes,cellstr(results.Labels{i}));
        %figure
        %imshow(I)
    end
else
    % Load pretrained detector for the example.
    pretrained = load('fasterRCNNResNet50VehicleExample.mat');
    results = pretrained.results;
end
    
%%
% Extract expected bounding box locations from test data.
%expectedResults = testData(:, 2:end);

% Evaluate the object detector using Average Precision metric.
%[ap, recall, precision] = evaluateDetectionPrecision(results, expectedResults);


%%
% Plot precision/recall curve
% for i=1:length(recall)
%     figure
%     plot(recall{i},precision{i})
%     xlabel('Recall')
%     ylabel('Precision')
%     grid on
%     title(sprintf('Average Precision = %.2f', ap(i)))
% end