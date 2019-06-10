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


function [angle_gra,angle_rad] = angle_intersection(x1,y1,x2,y2,x3,y3,x4,y4)
%ANGLE_INTERSECTION Calcula el angulo (gra&rad) dada la intersecci�n de dos
%rectas:
%   INPUTS
%   x1,y1 x2,y2 -> Puntos recta 1
%   x3,y3 x4,y4 -> Puntos recta 2
%   OUTPUTS
%   angle_gra -> Angulo de la interseccion de las dos rectas en GRA
%   angle_rad -> Angulo de la interseccion de las dos rectas en RAD

v1=[x1,y1]-[x2,y2];
v2=[x3,y3]-[x4-y4];

angle_rad = abs(pi-(abs((atan((y2-y1)/(x2-x1)) - atan((y4-y3)/(x4-x3))))));
angle_gra = abs(180-(abs((atan((y2-y1)/(x2-x1)) - atan((y4-y3)/(x4-x3))) * 180/pi)));
end

