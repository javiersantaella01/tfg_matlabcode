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


function [angle_gra,angle_rad] = angle_intersection(x1,y1,x2,y2,x3,y3,x4,y4)
%ANGLE_INTERSECTION Calcula el angulo (gra&rad) dada la intersección de dos
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

