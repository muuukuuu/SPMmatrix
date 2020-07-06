function draw_bb
% —^‚¦‚ç‚ê‚½strike, dip, rake‚©‚çbeach ball(focal mechanism)‚ð•`‚­
clear all;
figure;

%%% input fault parameters--------------------------------------------

% filename = 'C:\Users\user\Desktop\MT-semi\strike_dip_rake.txt';
% delimiterIn = ' ';
% fm = importdata(filename, delimiterIn);
% s1 = fm.data(:,1);
% d1 = fm.data(:,2);
% r1 = fm.data(:,3);

s1 = 0;
d1 = 90;
r1 = -150;
%%%%--------------------------------------------------------------------

% calculate aux plane parameter
[s2,d2,r2] = cal_AuxPlane(s1,d1,r1);

% draw circle
cx = cos(0:.01:2*pi);
cy = sin(0:.01:2*pi);
axis([-1 1 -1 1]);
axis('square');
axis off;
hold on;
plot(cx,cy,'-k');
fill(cx,cy,'w');

% calculate fault plane line
[x1,y1] = cal_planeline_from_faultpar(s1,d1);
plot(x1,y1,'k');

% calculate aux plane line
[x2,y2] = cal_planeline_from_faultpar(s2,d2);
plot(x2,y2,'k');

% calculate compressive (colored) domain
[X,Y]=cal_compressive_domain(s1,r1,s2,x1,y1,x2,y2);
patch(X,Y,'y');

str=['Strike=',num2str(s1),' Dip=',num2str(d1),' Rake=',num2str(r1)];
t=title(str);
set(t,'fontsize',14);

end