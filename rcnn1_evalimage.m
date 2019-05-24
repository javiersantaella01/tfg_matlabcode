function [outputArg1,outputArg2] = rcnn1_evalimage(filename,detector)
%RCNN1_EVALIMAGE Summary of this function goes here
%   Detailed explanation goes here

%%
i=1;
doTrainingAndEval=true;
if doTrainingAndEval

        % Read the image.
        I = imread(filename);
        
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
        
        %show_bboxdetection(i,testData,results);
        A=I;
        A = insertObjectAnnotation(A,'rectangle',results.Boxes{i},cellstr(results.Labels{i}));
        
        figure
        subplot(1,3,1)
        imshow(I)
        title('original')
        subplot(1,3,2)
        imshow(A)
        title('detection')
        
        % Lines violin function %%%%%%%%%%%%%
        lines_violin(1,results,I);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Annotate detections in the image.
        %I = insertObjectAnnotation(I,'rectangle',results.Boxes{i},cellstr(results.Labels{i}));
        %I = insertObjectAnnotation(I,'rectangle',selectedBboxes,cellstr(results.Labels{i}));
        %figure
        %imshow(I)
    
else
    % Load pretrained detector for the example.
    pretrained = load('fasterRCNNResNet50VehicleExample.mat');
    results = pretrained.results;
end

end

