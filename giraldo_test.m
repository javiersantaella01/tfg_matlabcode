%% Carga las imagenes de test de imageset y las pasa por el detector 
% sacando los resultados
clear all
clc
close all
load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat')
load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat')
rcnn1_evaltest

%% Carga los resultados ya evaluados con las 500 imagenes de test
% y solo muestra los resultados
clear all
clc
close all
load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat')
load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat')
for i=1:size(testData,1)
    i
    I=imread(testData.imageFileName{i});
    show_bboxdetection(i,results,testData);
    lines_violin(i,results,I);
    iou_eval(i,results,testData);
end
%fasterRCNNObjectDetector

%% Carga una imagen cualquiera y la pasa por el detector
% mostrando los resultados
clear all
clc
close all
load('_a1_g_p1_j_smallsize\detector_a1_g_p1_j_124-621.mat')

 filename='images_random\n04536866_4577.JPEG' % detecta bien
% filename='images_random\n04536866_10536.JPEG' % detecta con algo de error
% filename='images_random\n04536866_17332.JPEG' % no detecta bien
rcnn1_evalimage(filename,detector)



%% EVALUACIÓN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cuenta los bb detectados en las 497 results de test:
load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat')
count=0;
count_truth=0;
for i= 1:size(results,1)
    count = count + size(results.Boxes{i},1);
    count_truth = count_truth + 6;
    graph(i)=count;
    graph_truth(i)=count_truth;
end
plot(graph,'b')
hold on
plot(graph_truth,'r')
xlabel('num img')
ylabel('partes violin detectadas')
legend('Partes detectadas','Ground truth')

%% Si hacemos la suma de todas las precisiones por cada parte del violin 
% y hacemos la media aritmética, obtenemos:
clear all
clc
close all
load('_a1_g_p1_j_smallsize\testData_a1_g_p1_j_497-621.mat')
load('_a1_g_p1_j_smallsize\results_a1_g_p1_j_497-621.mat')

detect_v=0;
detect_bh=0;
detect_be=0;
detect_p=0;
detect_vo=0;
detect_b=0;

iou_v=0;
iou_bh=0;
iou_be=0;
iou_p=0;
iou_vo=0;
iou_b=0;

for i=1:size(results,1)
    i
    I=imread(testData.imageFileName{i});
    [iou_violin,iou_bow_hand,iou_bow_end,iou_puente,iou_voluta,iou_barbada] = iou_eval(i,results,testData,true);
    
    % Cuenta solamente el num de detecciones correctas
    if iou_violin>0
        detect_v=detect_v+1;
    end
    if iou_bow_hand>0
        detect_bh=detect_bh+1;
    end
    if iou_bow_end>0
        detect_be=detect_be+1;
    end
    if iou_puente>0
        detect_p=detect_p+1;
    end
    if iou_voluta>0
        detect_vo=detect_vo+1;
    end
    if iou_barbada>0
        detect_b=detect_b+1;
    end
    
    % Cuenta la suma de % de precision de cada parte detectada
    iou_v=iou_v+iou_violin;
    iou_bh=iou_bh+iou_bow_hand;
    iou_be=iou_be+iou_bow_end;
    iou_p=iou_p+iou_puente;
    iou_vo=iou_vo+iou_voluta;
    iou_b=iou_b+iou_barbada;
end

iou_v=iou_v/size(results,1);
iou_bh=iou_bh/size(results,1);
iou_be=iou_be/size(results,1);
iou_p=iou_p/size(results,1);
iou_vo=iou_vo/size(results,1);
iou_b=iou_b/size(results,1);

stem(1:6,[iou_v,iou_bh,iou_be,iou_p,iou_vo,iou_b])
axis([1 6 0 1])
title('IoU score [violin bowhand bowend puente voluta barbada]')
ylabel('media aritmetica 497 imagenes de test')

figure
stem(1:6,[detect_v,detect_bh,detect_be,detect_p,detect_vo,detect_b])
axis([1 6 0 497])
title('Total de partes detectadas [violin bowhand bowend puente voluta barbada]')
ylabel('Total con 497 imagenes de test')