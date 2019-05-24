
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

% clear all;
% load('trainingData_a1_g_p1_j.mat');
% trainingData.violin=cellfun(@(x) x.*0.1465,trainingData.violin,'un',0);
% trainingData.bow_hand=cellfun(@(x) x.*0.1465,trainingData.bow_hand,'un',0);
% trainingData.bow_end=cellfun(@(x) x.*0.1465,trainingData.bow_end,'un',0);
% trainingData.voluta=cellfun(@(x) x.*0.1465,trainingData.voluta,'un',0);
% trainingData.barbada=cellfun(@(x) x.*0.1465,trainingData.barbada,'un',0);
% trainingData.puente=cellfun(@(x) x.*0.1465,trainingData.puente,'un',0);
% i=150
% 
% for i=1:300
% I=imread(trainingData.imageFileName{i});
% try
% I = insertObjectAnnotation(I,'rectangle',trainingData{i,:}{5},'bb');
% catch
% end
% imshow(I)
% end

% %%
% extension = '.jpg';
% for k=1:size(trainingData,1)
%     k
%     path = trainingData{k,1};
%     [~,filename,~] = fileparts(char(path));
%     width = size(imread(strcat('imageset/',filename,extension)),2);
%     heigth = size(imread(strcat('imageset/',filename,extension)),1);
%     width_original = size(imread(strcat('imageset_originalsize/',filename,extension)),2);
%     heigth_original = size(imread(strcat('imageset_originalsize/',filename,extension)),1);
%     factor=(width/width_original+heigth/heigth_original)/2;
%     trainingData.violin{k}=(trainingData.violin{k}).*factor;
%     trainingData.bow_hand{k}=(trainingData.bow_hand{k}).*factor;
%     trainingData.bow_end{k}=(trainingData.bow_end{k}).*factor;
%     trainingData.voluta{k}=(trainingData.voluta{k}).*factor;
%     trainingData.barbada{k}=(trainingData.barbada{k}).*factor;
%     trainingData.puente{k}=(trainingData.puente{k}).*factor;
% end


%%
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