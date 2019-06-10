% ======================================================================= %
%  Trabajo final de grado
%  Reconocimiento automático de la posición del violín y el arco para la evaluación automática de la interpretación musical 
%  Grado en Ingenieria de Sistemas Audiovisuales
%  Javier Santaella Sánchez
%  ESCOLA SUPERIOR POLITÈCNICA UPF
%  Año 2019
%  Tutor: Sergio Ivan Giraldo Mendez
% ======================================================================= %
%%



%% Evalua Detector usando Test Set
% load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat')
% load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat')

doTrainingAndEval=true;
if doTrainingAndEval
    % Tabla para contener los bbox, las puntuaciones y las etiquetas generadas por el detector.
    numImages = height(testData)
    results = table('Size',[numImages 3],...
        'VariableTypes',{'cell','cell','cell'},...
        'VariableNames',{'Boxes','Scores','Labels'});
    
    p=1;
    % Ejecuta el detector en cada imagen en el testset y recoge los resultados.
    for i = 1:numImages
        i
        % Carga la imagen.
        I = imread(testData.imageFileName{i}); % Carga la imagen
        
        % Ejecuta el detector.
        [bboxes, scores, labels] = detect(detector, I);
        
        % Resultados con varios bbox por cada parte del violin.
        all_results.Boxes{i} = bboxes;
        all_results.Scores{i} = scores;
        all_results.Labels{i} = labels;
        
        % Nos quedamos con el mejor bbox por cada parte del violin:
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
        
        % Resultados solo con el mejor bbox por parte del violin detectada:
        results.Boxes{i} = selectedBboxes;
        results.Scores{i} = selectedScores;
        results.Labels{i} = selectedLabels;
        if length(selectedLabels)==6
            perfect_detection(p)=i % Guardamos el idx de las imagenes con todas las partes detectadas
            p=p+1;
        end
        
        show_bboxdetection(i,results,testData); % Muestra las partes detectadas.
        lines_violin(i,results,I); % Dibuja las lineas del violín y del arco y calcula los angulos.
        iou_eval(i,results,testData); % Muestra los resultados del IoU.
        
    end
else
    % Carga los resultados sin hacer Eval
    load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat')
end
