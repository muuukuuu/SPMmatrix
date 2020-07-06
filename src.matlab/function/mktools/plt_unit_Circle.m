function plt_unit_Circle

cx = cos(0:.01:2*pi);
cy = sin(0:.01:2*pi);
axis([-1 1 -1 1]);
axis('square');
axis off;
hold on;
plot(cx,cy,'-k');
fill(cx,cy,'w');

text(0,1.1,0,'N','HorizontalAlignment','center','FontSize',15);
text(1.1,0,0,'E','HorizontalAlignment','center','FontSize',15);
text(0,-1.1,0,'S','HorizontalAlignment','center','FontSize',15);
text(-1.1,0,0,'W','HorizontalAlignment','center','FontSize',15);