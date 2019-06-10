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


function [outputArg1,outputArg2] = lines_violin(i,results,I)
%LINES_VIOLIN Calcula y dibuja las lineas del violin y arco:
%   INPUTS
%   i -> idx de la imagen del testData
%   results -> resultados del detector.
%   I -> imagen del testData
%   OUTPUTS
%   No outputs 

subplot(1,3,3)
imshow(I)
hold on

violin=results.Boxes{i}(find(contains(string(results.Labels{i}),'violin')),:);
bow_hand=results.Boxes{i}(find(contains(string(results.Labels{i}),'bow_hand')),:);
bow_end=results.Boxes{i}(find(contains(string(results.Labels{i}),'bow_end')),:);
puente=results.Boxes{i}(find(contains(string(results.Labels{i}),'puente')),:);
voluta=results.Boxes{i}(find(contains(string(results.Labels{i}),'voluta')),:);
barbada=results.Boxes{i}(find(contains(string(results.Labels{i}),'barbada')),:);

% Center points of each part
if length(violin)==4
    vx = violin(1)+violin(3)/2;
    vy = violin(2)+violin(4)/2;
end
if length(bow_hand)==4
    bhx = bow_hand(1)+bow_hand(3)/2;
    bhy = bow_hand(2)+bow_hand(4)/2;
end
if length(bow_end)==4
    bex = bow_end(1)+bow_end(3)/2;
    bey = bow_end(2)+bow_end(4)/2;
end
if length(puente)==4
    px = puente(1)+puente(3)/2;
    py = puente(2)+puente(4)/2;
end
if length(voluta)==4
    vox = voluta(1)+voluta(3)/2;
    voy = voluta(2)+voluta(4)/2;
end
if length(barbada)==4
    bx = barbada(1)+barbada(3)/2;
    by = barbada(2)+barbada(4)/2;
end

line_violin = false;
line_bow = false;

%% Line VIOLIN x1 y1 x2 y2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vbpvo 4

if length(violin)==4 && length(barbada)==4 && length(puente)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a B pasando por P
    [a,b] = coeffs_recta(vox,voy,px,py);
    x1=vox;
    y1=voy;
    x2=bx; % x=(y-b)/a
    y2=x2*a+b; % y=a*x+b
    %y2=by;
    plot([x1 x2], [y1 y2],'g');
    xlabel('vbpvo 4')
    
    line_violin = true;
end

% bpvo 3

if length(barbada)==4 && length(puente)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a B
    [a,b] = coeffs_recta(vox,voy,px,py);
    x1=vox;
    y1=voy;
    x2=bx; % x=(y-b)/a
    %y2=x2*a+b; % y=a*x+b
    y2=by;
    plot([x1 x2], [y1 y2],'g');
    xlabel('bpvo 3')
    
    line_violin = true;
end

% vbp 3

if length(violin)==4 && length(barbada)==4 && length(puente)==4 && line_violin==false
    % Recta de B a V
    %[a,b] = coeffs_recta(bx,by,px,py);
    x1=bx;
    y1=by;
    x2=violin(1)+violin(3); % x=(y-b)/a
    y2=vy; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vbp 3')
    
    line_violin = true;
end

% vbvo 3

if length(violin)==4 && length(barbada)==4 && length(voluta)==4 && line_violin==false
    % Recta de B a VO
    %[a,b] = coeffs_recta(bx,by,px,py);
    x1=bx;
    y1=by;
    x2=vox; % x=(y-b)/a
    y2=voy; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vbvo 3')
    
    line_violin = true;
end

% vpvo 3

if length(violin)==4 && length(puente)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a V pasando por P
    [a,b] = coeffs_recta(vox,voy,px,py);
    x1=vox;
    y1=voy;
    x2=violin(1); % x=(y-b)/a
    y2=x2*a+b; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vpvo 3')
    
    line_violin = true;
end

% vb 2

if length(violin)==4 && length(barbada)==4 && line_violin==false
    % Recta de B a V
    %[a,b] = coeffs_recta(bx,by,px,py);
    x1=bx;
    y1=by;
    x2=violin(1)+violin(3); % x=(y-b)/a
    y2=vy; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vb 2')
    
    line_violin = true;
end

% vvo 2

if length(violin)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a V
    %[a,b] = coeffs_recta(bx,by,px,py);
    x1=vox;
    y1=voy;
    x2=violin(1); % x=(y-b)/a
    y2=violin(2)+violin(4)/2; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vvo 2')
    
    line_violin = true;
end

% vp 2

if length(violin)==4 && length(puente)==4 && line_violin==false
    % Recta violin pasando por P
    [a,b] = coeffs_recta(violin(1),vy,px,py);
    x1=violin(1);
    y1=x1*a+b;
    x2=violin(1)+violin(3); % x=(y-b)/a
    y2=x2*a+b; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('vp 2')
    
    line_violin = true;
end

% bvo 2

if length(barbada)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a B
    %[a,b] = coeffs_recta(bx,by,px,py);
    x1=vox;
    y1=voy;
    x2=bx; % x=(y-b)/a
    y2=by; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('bvo 2')
    
    line_violin = true;
end

% bp 2

if length(barbada)==4 && length(puente)==4 && line_violin==false
    % Recta de B a P y doblamos desde P
    [a,b] = coeffs_recta(bx,by,px,py);
    x1=bx;
    y1=by;
    x2=abs(bx+px); % x=(y-b)/a
    y2=x2*a+b; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('bp 2')
    
    line_violin = true;
end

% pvo 2

if length(puente)==4 && length(voluta)==4 && line_violin==false
    % Recta de VO a P y doblamos desde P
    [a,b] = coeffs_recta(vox,voy,px,py);
    x1=vox;
    y1=voy;
    x2=abs(vox-px)*2; % x=(y-b)/a
    y2=x2*a+b; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('pvo 2')
    
    line_violin = true;
end

% v 1

if length(violin)==4 && line_violin==false
    % Recta violin
    %[a,b] = coeffs_recta(vox,voy,px,py);
    x1=violin(1);
    y1=vy;
    x2=violin(1)+violin(3); % x=(y-b)/a
    y2=vy; % y=a*x+b
    plot([x1 x2], [y1 y2],'g');
    xlabel('v 1')
    
    line_violin = true;
end

% otherwise NO DETECT


%% Line BOW x3 y3 x4 y4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bhbep 3

if length(bow_hand)==4 && length(bow_end)==4 && length(puente)==4 && line_bow==false
    % Recta de BE a BH pasando por P
    [a,b] = coeffs_recta(bex,bey,px,py);
    x3=bex;
    y3=bey;
    x4=bhx;
    %y4=bhx*a+b;
    y4=bhy; % y=a*x+b
    %x4=(y4-b)/a; % x=(y-b)/a
    x4=bhx;
    plot([x3 x4], [y3 y4],'r');
    ylabel('bhbep 3')
    
    line_bow = true;
end

% bhbe 2

if length(bow_hand)==4 && length(bow_end)==4 && line_bow==false
    % Recta de BE a BH
    %[a,b] = coeffs_recta(bex,bey,px,py);
    x3=bex;
    y3=bey;
    y4=bhy; % y=a*x+b
    x4=bhx;
    plot([x3 x4], [y3 y4],'r');
    ylabel('bhbe 2')
    
    line_bow = true;
end

% bep 2

if length(bow_end)==4 && length(puente)==4 && line_bow==false
    % Recta de BE a P y doblamos desde P
    [a,b] = coeffs_recta(bex,bey,px,py);
    x3=bex;
    y3=bey;
    x4=px-abs(bex-px)*2;
    y4=x4*a+b; % y=a*x+b
    
    plot([x3 x4], [y3 y4],'r');
    ylabel('bep 2')
    
    line_bow = true;
end

% bhp 2

if length(bow_hand)==4 && length(puente)==4 && line_bow==false
    % Recta de BH a P y doblamos desde P
    [a,b] = coeffs_recta(bhx,bhy,px,py);
    x3=bhx;
    y3=bhy;
    x4=px-abs(bhx+px)*2;
    y4=x4*a+b; % y=a*x+b
    
    plot([x3 x4], [y3 y4],'r');
    ylabel('bhp 2')
    
    line_bow = true;
end

%otherwise NO DETECT


%% ANGLE
try
    [angle_gra,angle_rad] = angle_intersection(x1,y1,x2,y2,x3,y3,x4,y4) % Calcula el angulo (gra&rad) entre la interseccion de las dos rectas.
    
catch
    
end

end

%end
