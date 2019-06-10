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


function [outputArg1,outputArg2] = show_bboxdetection(i,results,testData)
%SHOW_BBOXDETECTION Muestra las partes detectadas
%   INPUTS
%   i -> idx de la imagen del testData
%   results -> resultados del detector.
%   testData -> testData
%   OUTPUTS
%   No outputs 


%% Show results of test image "i"
%i=11;
A = imread(testData.imageFileName{i});
A = insertObjectAnnotation(A,'rectangle',results.Boxes{i},cellstr(results.Labels{i}));
%figure
%imshow(A)

GT = imread(testData.imageFileName{i});
try
GT = insertObjectAnnotation(GT,'rectangle',testData.violin{i},'violin');
catch
end
try
GT = insertObjectAnnotation(GT,'rectangle',testData.bow_hand{i},'bow_hand');
catch
end
try
GT = insertObjectAnnotation(GT,'rectangle',testData.bow_end{i},'boe_end');
catch
end
try
GT = insertObjectAnnotation(GT,'rectangle',testData.voluta{i},'voluta');
catch
end
try
GT = insertObjectAnnotation(GT,'rectangle',testData.puente{i},'puente');
catch
end
try
GT = insertObjectAnnotation(GT,'rectangle',testData.barbada{i},'barbada');
catch
end
figure
subplot(1,3,1)
imshow(GT)
title('original')
subplot(1,3,2)
imshow(A)
title('detection')

end

