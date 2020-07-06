function pltParticle(target,target2,win_length,dlength,wave_in)
target
target2

point_in=1:dlength;
% win_length=

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 
%  wave_in=wave_in/10^6*0.0007622*1000 ; %micro volt --> mm/sec

% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
subplot(2,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))-0,'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,1)))-1,'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,1)))-2,'Color',cm(3,:));hold on;

tcenter=target;
area([tcenter-win_length/2,tcenter+win_length/2],[-3,-3],'FaceColor',cm(4,:),'FaceAlpha',0.3,'LineStyle','none');hold on;
area([tcenter-win_length/2,tcenter+win_length/2],[1,1],'FaceColor',cm(4,:),'FaceAlpha',0.3,'LineStyle','none');hold on;

tcenter2=target2;
area([tcenter2-win_length/2,tcenter2+win_length/2],[-3,-3],'FaceColor',cm(4,:),'FaceAlpha',0.3,'LineStyle','none');hold on;
area([tcenter2-win_length/2,tcenter2+win_length/2],[1,1],'FaceColor',cm(4,:),'FaceAlpha',0.3,'LineStyle','none');hold on;
xlim([0,dlength]);


subplot(2,2,3)
T=[tcenter-win_length/2:1:tcenter+win_length/2];
g=mean(wave_in(T,:));
plot3(wave_in(T,1)-g(1),wave_in(T,2)-g(2),wave_in(T,3)-g(3),'.-','MarkerSize',10);hold on;
xlabel('x');ylabel('y');zlabel('z');
box on;grid on;
axis equal;
axis square;
% xlim([-20 20]);ylim([-20 20]);zlim([-20 20]);
xlim([-50000 50000]);ylim([-50000 50000]);zlim([-50000 50000]);



subplot(2,2,4)
T2=[tcenter2-win_length/2:1:tcenter2+win_length/2];
T2=[tcenter-win_length/2:1:tcenter2+win_length/2];
g=mean(wave_in(T2,:));
plot3(wave_in(T2,1)-g(1),wave_in(T2,2)-g(2),wave_in(T2,3)-g(3),'.-','MarkerSize',10);hold on;
xlabel('x');ylabel('y');zlabel('z');
box on;grid on;
% axis equal;
% axis square;

xlim([-20000 20000]);ylim([-20000 20000]);zlim([-20000 20000]);


set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
