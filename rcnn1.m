% ======================================================================= %
%  Trabajo final de grado
%  Reconocimiento autom�tico de la posici�n del viol�n y el arco para la evaluaci�n autom�tica de la interpretaci�n musical 
%  Grado en Ingenieria de Sistemas Audiovisuales
%  Javier Santaella S�nchez
%  ESCOLA SUPERIOR POLIT�CNICA UPF
%  A�o 2019
%  Tutor: Sergio Ivan Giraldo Mendez
% ======================================================================= %
%%

% load('_a1_g_p1_j_smallsize\trainingData_a1_g_p1_j_124-621.mat')

%% 1. Configura las Training Options:

% Options for step 1.
options = trainingOptions('sgdm', ...
    'MaxEpochs', 5, ...
    'MiniBatchSize', 1, ...
    'InitialLearnRate', 1e-3, ...
    'CheckpointPath', tempdir);

% 2. Train Faster R-CNN
% UseParallel=true; % Solo funciona con algunas GPU de NVIDIA
doTrainingAndEval=true;
if doTrainingAndEval  
    % Train Faster R-CNN detector.
    %  * 'resnet50' capa de extraccion de features. 
    [detector, info] = trainFasterRCNNObjectDetector(trainingData, 'resnet50', options, ...
        'NegativeOverlapRange', [0 0.3], ...
        'PositiveOverlapRange', [0.6 1]);
else
    % Carga pretrained detector del proyecto.
    load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

