function pltZfunc(time_border,point_in,wave_in,ZDp,ZDs,ZDi)

dlength=numel(wave_in(:,1));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 
 
%% ---[Plot wave]---------------------------------------------------    
figure;
subplot(4,1,1)
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))-0.0,'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1.5,'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-3.0,'Color',cm(3,:));hold on;
% xlim([0,2000]);
xlim([0,dlength]);



%% ---[Fig Z_linear]---------------------------------------------------    
subplot(4,1,2)
plot(time_border,ZDp);hold on;
sigma=std(ZDp);
X=[min(time_border),max(time_border)];Y=[3*sigma,3*sigma];
plot(X,Y,'Color',cm(2,:));hold on;
plot(X,-Y,'Color',cm(2,:));hold on;
X2=[min(time_border),max(time_border)];Y2=[2*sigma,2*sigma];
plot(X2,Y2,'--','Color',cm(2,:));hold on;
plot(X2,-Y2,'--','Color',cm(2,:));hold on;
% plot([ppck_obs,ppck_obs],[min(ZDp),max(ZDp)],'Color',cm(4,:));
% xlabel('Time (sec)');
ylabel('Z_{Linear}');
% xlim([0,2000]);
xlim([0,dlength]);
title('Around center freq.');



%% ---[Fig Z_Ellipticity]---------------------------------------------------
subplot(4,1,3)
plot(time_border,ZDs);hold on;
sigma=std(ZDs);
X=[min(time_border),max(time_border)];Y=[3*sigma,3*sigma];
plot(X,Y,'Color',cm(2,:));hold on;
plot(X,-Y,'Color',cm(2,:));hold on;
X2=[min(time_border),max(time_border)];Y2=[2*sigma,2*sigma];
plot(X2,Y2,'--','Color',cm(2,:));hold on;
plot(X2,-Y2,'--','Color',cm(2,:));hold on;
% plot([spck_obs,spck_obs],[min(ZDs),max(ZDs)],'Color',cm(4,:));

% xlabel('Time (sec)');
ylabel('Z_{Ellip}');
% xlim([0,2000]);
xlim([0,dlength]);
title('Around center freq.');


%% ---[Fig Inclination]---------------------------------------------------
subplot(4,1,4)
plot(time_border,ZDi);hold on;
sigma=std(ZDi);
X=[min(time_border),max(time_border)];Y=[3*sigma,3*sigma];
plot(X,Y,'Color',cm(2,:));hold on;
plot(X,-Y,'Color',cm(2,:));hold on;
X2=[min(time_border),max(time_border)];Y2=[2*sigma,2*sigma];
plot(X2,Y2,'--','Color',cm(2,:));hold on;
plot(X2,-Y2,'--','Color',cm(2,:));hold on;
% plot([spck_obs,spck_obs],[min(ZDs),max(ZDs)],'Color',cm(4,:));

% xlabel('Time (sec)');
ylabel('Z_{Ellip}');
% xlim([0,2000]);
xlim([0,dlength]);
title('Around center freq.');

set(gcf,'Position',[159   0   860*0.9   771*0.9]) % By Hotta Dec.18