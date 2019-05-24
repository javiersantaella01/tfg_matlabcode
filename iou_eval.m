function [iou_violin,iou_bow_hand,iou_bow_end,iou_puente,iou_voluta,iou_barbada] = iou_eval(i,results,testData,nofigures)
%IOU_EVAL Summary of this function goes here
%   Detailed explanation goes here

violin=results.Boxes{i}(find(contains(string(results.Labels{i}),'violin')),:);
bow_hand=results.Boxes{i}(find(contains(string(results.Labels{i}),'bow_hand')),:);
bow_end=results.Boxes{i}(find(contains(string(results.Labels{i}),'bow_end')),:);
puente=results.Boxes{i}(find(contains(string(results.Labels{i}),'puente')),:);
voluta=results.Boxes{i}(find(contains(string(results.Labels{i}),'voluta')),:);
barbada=results.Boxes{i}(find(contains(string(results.Labels{i}),'barbada')),:);

%% Calculates IOU for each BB
%i=1;
C = imread(testData.imageFileName{i});
% violin iou
C=insertShape(C,'FilledRectangle',testData.violin{i},'Color','green');
C=insertShape(C,'FilledRectangle',violin,'Color','yellow');
% bow_hand iou
C=insertShape(C,'FilledRectangle',testData.bow_hand{i},'Color','green');
C=insertShape(C,'FilledRectangle',bow_hand,'Color','yellow');
% bow_end iou
C=insertShape(C,'FilledRectangle',testData.bow_end{i},'Color','green');
C=insertShape(C,'FilledRectangle',bow_end,'Color','yellow');
% % puente iou
C=insertShape(C,'FilledRectangle',testData.puente{i},'Color','red');
C=insertShape(C,'FilledRectangle',puente,'Color','blue');
% % voluta iou
C=insertShape(C,'FilledRectangle',testData.voluta{i},'Color','red');
C=insertShape(C,'FilledRectangle',voluta,'Color','blue');
% % barbada iou
C=insertShape(C,'FilledRectangle',testData.barbada{i},'Color','red');
C=insertShape(C,'FilledRectangle',barbada,'Color','blue');

if ~exist('nofigures')
    figure
    subplot(1,2,1)
    imshow(C)
    title('IoU') 
else
     % No figures  
end

try
    iou_violin = bboxOverlapRatio(testData.violin{i},violin);
catch
    iou_violin = 0;
end

try
iou_bow_hand = bboxOverlapRatio(testData.bow_hand{i},bow_hand);
catch
    iou_bow_hand = 0;
end

try
iou_bow_end = bboxOverlapRatio(testData.bow_end{i},bow_end);
catch
    iou_bow_end = 0;
end

try
iou_puente = bboxOverlapRatio(testData.puente{i},puente);
catch
    iou_puente = 0;
end

try
iou_voluta = bboxOverlapRatio(testData.voluta{i},voluta);
catch
    iou_voluta = 0;
end

try
iou_barbada = bboxOverlapRatio(testData.barbada{i},barbada);
catch
    iou_barbada = 0;
end


if length(iou_violin)<1
    iou_violin = 0; end
if length(iou_bow_hand)<1
    iou_bow_hand = 0; end
if length(iou_bow_end)<1
    iou_bow_end = 0; end
if length(iou_puente)<1
    iou_puente = 0; end
if length(iou_voluta)<1
    iou_voluta = 0; end
if length(iou_barbada)<1
    iou_barbada = 0; end

if ~exist('nofigures')
    subplot(1,2,2)
    stem(1:6,[iou_violin,iou_bow_hand,iou_bow_end,iou_puente,iou_voluta,iou_barbada])
    title('IoU score [violin bowhand bowend puente voluta barbada]')
else
     % No figures 

end

end

