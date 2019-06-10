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


function [a,b] = coeffs_recta(x1,y1,x2,y2)
%COEFFS_RECTA: Calcula los coeficientes de la recta a partir de dos puntos.
%   INPUTS
%   x1, y1 -> Punto 1
%   x2, y2 -> Punto 2
%   OUTPUTS
%   a, b -> Coeficientes de la recta y=a*x+b

coefficients = polyfit([x1,x2],[y1,y2],1);
a = coefficients(1);
b = coefficients(2);
end

