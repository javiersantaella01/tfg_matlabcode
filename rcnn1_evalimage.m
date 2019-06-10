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


function [outputArg1,outputArg2] = rcnn1_evalimage(filename,detector)
%RCNN1_EVALIMAGE Evalua una imagen por el detector y muestra los
%resultados.
%   INPUTS
%   filename -> Nombre de la imagen ('images_random\n04536866_4577.JPEG')
%   detector -> Modelo pre-entrenado ('detector_a1_g_p1_j_124-621.mat')
%   OUTPUTS
%   No outputs

%%
i=1;
doTrainingAndEval=true;
if doTrainingAndEval

        % Carga la imagen.
        I = imread(filename);
        
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
        
    
else
    % Carga los resultados sin hacer Eval
    load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat')
end

end

