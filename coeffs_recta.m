function [a,b] = coeffs_recta(x1,y1,x2,y2)
%COEFFS_RECTA Summary of this function goes here
%   Detailed explanation goes here
coefficients = polyfit([x1,x2],[y1,y2],1);
a = coefficients(1);
b = coefficients(2);
end

