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

% Este script es personal y solo se ha utilizado una vez al princpio del proyecto. 
% Toma el ground_truth de videolabeler, lo parsea
% al formato de la tabla de la red neuronal y modifica la resolucion
% de los boundingboxes. Se ha utilizado desde el PC en el que se
% ha elaborado el proyecto para obtener la tabla violinDataset que sirve
% de entrada a la red neuronal, y posiblemente solo funcione en este PC
% debido a que las rutas de las imagenes apuntan a este PC concreto.
% De todas formas ejecutar este script no es necesario una vez se tiene una
% base de imagenes personal, o se carga la utilizada en este proyecto.


gTruth_a1 = load('s_a1.mat');
gTruth_g = load('s_g.mat');
gTruth_p1 = load('s_p1.mat');
gTruth_j = load('s_j.mat');
%%
 bdd=[
     gTruth_a1.s_a1_1;
     gTruth_a1.s_a1_2;
     gTruth_a1.s_a1_3;
     gTruth_a1.s_a1_4;
     gTruth_a1.s_a1_5;
     gTruth_a1.s_a1_6;
     gTruth_g.s_g_1;
     gTruth_g.s_g_2;
     gTruth_g.s_g_6;
     gTruth_g.s_g_7;
     gTruth_g.s_g_8;
     gTruth_g.s_g_10;
     gTruth_p1.s_p1_1;
     gTruth_p1.s_p1_2;
     gTruth_p1.s_p1_3;
     gTruth_p1.s_p1_4;
     gTruth_p1.s_p1_5;
     gTruth_p1.s_p1_6;
     gTruth_p1.s_p1_7;
     gTruth_p1.s_p1_8;
     gTruth_j.s_j_3;
     gTruth_j.s_j_5;
     gTruth_j.s_j_6;
     gTruth_j.s_j_7;
     gTruth_j.s_j_8;
     gTruth_j.s_j_9;
     ]

imageFileName=[];
violin=[];
bow_hand=[];
bow_end=[];
voluta=[];
barbada=[];
puente=[];

for i=1:length(bdd)
    imageFileName = [imageFileName;bdd(i, 1).DataSource.Source];
    violin = ([violin;bdd(i, 1).LabelData.violin]);
    bow_hand = ([bow_hand;bdd(i, 1).LabelData.bow_hand]);
    bow_end = ([bow_end;bdd(i, 1).LabelData.bow_end]);
    voluta = ([voluta;bdd(i, 1).LabelData.voluta]);
    barbada = ([barbada;bdd(i, 1).LabelData.barbada]);
    puente = ([puente;bdd(i, 1).LabelData.puente]);
end

partsViolin = table(imageFileName, violin,bow_hand,bow_end,voluta,barbada,puente)


%% Cambiamos las rutas a la carpeta /imageset/ para que puedan ser cogidas
% desde cualquier PC, y cambiamos la resolucion de los boundingbox debido
% a que las imagenes contenidas en la carpeta imageset han sido reducidas
% en escala para acelerar el proceso.
violinDataset = partsViolin;
extension = '.jpg';
for k=1:size(violinDataset,1)
    k
    path = violinDataset{k,1};
    [~,filename,~] = fileparts(char(path));
    width = size(imread(strcat('imageset/',filename,extension)),2);
    heigth = size(imread(strcat('imageset/',filename,extension)),1);
    width_original = size(imread(strcat('imageset_originalsize/',filename,extension)),2);
    heigth_original = size(imread(strcat('imageset_originalsize/',filename,extension)),1);
    factor=(width/width_original+heigth/heigth_original)/2;
    violinDataset.violin{k}=(violinDataset.violin{k}).*factor;
    violinDataset.bow_hand{k}=(violinDataset.bow_hand{k}).*factor;
    violinDataset.bow_end{k}=(violinDataset.bow_end{k}).*factor;
    violinDataset.voluta{k}=(violinDataset.voluta{k}).*factor;
    violinDataset.barbada{k}=(violinDataset.barbada{k}).*factor;
    violinDataset.puente{k}=(violinDataset.puente{k}).*factor;
end