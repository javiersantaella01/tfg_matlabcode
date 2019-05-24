function [angle_gra,angle_rad] = angle_intersection(x1,y1,x2,y2,x3,y3,x4,y4)
%ANGLE_INTERSECTION Summary of this function goes here
%   Detailed explanation goes here
v1=[x1,y1]-[x2,y2];
v2=[x3,y3]-[x4-y4];
%angle = acos(sum(v2.*v2)/(norm(v1)*norm(v2)))
angle_rad = abs(pi-(abs((atan((y2-y1)/(x2-x1)) - atan((y4-y3)/(x4-x3))))));
angle_gra = abs(180-(abs((atan((y2-y1)/(x2-x1)) - atan((y4-y3)/(x4-x3))) * 180/pi)));

end

