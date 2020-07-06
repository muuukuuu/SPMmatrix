function [x,y] = cal_planeline_from_faultpar(strike, dip)

d2r = pi/180;
N=180;

if dip>=90
    dip = 89.999;
end

strike = strike*d2r;
   dip = dip*d2r;

phi = 0:pi/N:pi;
radip = atan(tan(dip)*sin(phi));
rproj = sqrt(2)*sin((pi/2 - radip)/2);
xp  = rproj .* sin(phi);
yp  = rproj .* cos(phi);

x = cos(-strike)*xp - sin(-strike)*yp;
y = sin(-strike)*xp + cos(-strike)*yp;
   
end

