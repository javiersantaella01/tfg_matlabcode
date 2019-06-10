% ======================================================================= %
%  Trabajo final de grado
%  Reconocimiento automático de la posición del violín y el arco para la evaluación automática de la interpretación musical 
%  Grado en Ingenieria de Sistemas Audiovisuales
%  Javier Santaella Sánchez
%  ESCOLA SUPERIOR POLITÈCNICA UPF
%  Año 2019
%  Tutor: Sergio Ivan Giraldo Mendez
% ======================================================================= %



%% EJEMPLOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1.
    % Realiza el entrenamiento con la base de datos creada (
    % y utilizando la red ResNet-50.
    clear all
    clc
    close all
    load('_a1_g_p1_j_smallsize\violinDataset_a1_g_p1_j_621.mat') % Carga el dataset utilizado.

    % Split el dataset:
    rng(0); % Set random seed to ensure example training reproducibility.
    % Randomly split data into a training and test set:
    shuffledIdx = randperm(height(violinDataset));
    idx = floor(0.2 * height(violinDataset));
    trainingData = violinDataset(shuffledIdx(1:idx),:);
    testData = violinDataset(shuffledIdx(idx+1:end),:);

    %Realiza el training a partir de trainingData:
    rcnn1



%% 2.
    % Carga las imagenes de test de imageset y las pasa por el detector 
    % sacando los resultados
    clear all
    clc
    close all
    load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat') % Carga el detector entrenado
    load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat') % Carga el test data
    rcnn1_evaltest % Evalua el test data por el detector

    
    
%% 3.
    % Carga los resultados ya evaluados con las 500 imagenes de test
    % y solo muestra los resultados
    clear all
    clc
    close all
    load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat') % Carga el test data
    load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat') % Carga los resultados evaluados
    
    % Muestra solamente los resultados:
    for i=1:size(testData,1)
        i
        I=imread(testData.imageFileName{i});
        show_bboxdetection(i,results,testData);
        lines_violin(i,results,I);
        iou_eval(i,results,testData);
    end

    
    
%% 4.
    % Carga una imagen cualquiera y la pasa por el detector
    % mostrando los resultados
    clear all
    clc
    close all
    load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat') % Carga el detector entrenado

     filename='images_random\n04536866_4577.JPEG' % detecta bien
    % filename='images_random\n04536866_10536.JPEG' % detecta con algo de error
    % filename='images_random\n04536866_17332.JPEG' % no detecta bien
    
    % Evalua la imagen por el detector:
    rcnn1_evalimage(filename,detector)
