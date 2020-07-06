function draw_Fault_Plane
% wulff -- Program for plotting a Wulff net
% to plot points, first calculate theta = pi*(90-azimuth)/180
% then rho = tan(pi*(90-dip)/360), and finally the components
% xp = rho*cos(theta) and yp = rho*cos(theta)
% Written by Gerry Middleton, November 1995
clear all;
figure;



%% input fault par ----------------------------------
% filename = 'C:\Users\user\Desktop\MT-semi\strike_dip_rake.txt';
% delimiterIn = ' ';
% fm = importdata(filename, delimiterIn);
% s1 = fm.data(:,1);
% d1 = fm.data(:,2);
% r1 = fm.data(:,3);

s1 = 80;
d1 = 70;
r1 = 0;
%% --------------------------------------------------
d2r=pi/180;

if d1 >= 90
    d1 = 89.9;
end

N = 50;
cx = cos(0:pi/N:2*pi);
cy = sin(0:pi/N:2*pi);
axis([-1 1 -1 1]);
axis('square');
axis off;
hold on;
bb = plot(cx,cy,'-k');
fill(cx,cy,'w');

%% plot fault plane line ---------------------------
psi = [0:pi/N:pi];
dip = d1*d2r;
strike = s1*d2r;
radip = atan(tan(dip)*sin(psi));
rproj = sqrt(2)*sin((pi/2 - radip)/2);

xx = rproj .* sin(psi);
yy = rproj .* cos(psi);

x = cos(-strike)*xx - sin(-strike)*yy;
y = sin(-strike)*xx + cos(-strike)*yy;
bb = plot(x,y,'-k');
%% --------------------------------------------------

%% plot pole of fault plane -------------------------
dip_az = (90-s1)-90;
theta  = pi*(dip_az+180)/180;                        % az converted to MATLAB angle
rho = sqrt(2)*sin(pi*(d1)/360);                      % projected distance from origin

xp = rho .* cos(theta);
yp = rho .* sin(theta);
pol = plot(xp,yp,'ro');
%% -------------------------------------------------

axis('square');
end