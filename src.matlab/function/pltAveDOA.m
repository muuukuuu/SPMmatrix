function pltAveDOA(point_in,time_border,wave_in,azi_data1ave,inc_data1ave)
dlength=numel(wave_in(:,1));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 t1=748;t2=758;   % M1.9
% t1=3466;t2=3476; % M2.2
% t1=7399;t2=7409; % B1
t1=762;t2=768;   % B2
% t1=1957;t2=1962;   % B3
% t1=3357;t2=3362; % B4
% t1=995;t2=1000; % B5
% t1=2192;t2=2200; % B6


% ---[Plot average DOA]---------------------------------------------------    
figure;
subplot(3,1,1)
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1.5,'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-3,'Color',cm(3,:));hold on;
% xlim([500,600]);
% xlim([0,dlength]);
xlim([t1 t2]);
hold on

subplot(3,1,2)
plot(time_border,azi_data1ave,'Color',cm(1,:));hold on;
% xlim([0,dlength]);
xlim([t1 t2]);
ylim([0,360]);
xlabel('Time (sec)');ylabel('Azimuth of P-DOA');

subplot(3,1,3)
plot(time_border,inc_data1ave,'Color',cm(1,:));hold on;
% plot(time_border,eig3Inc,'Color',cm(2,:));hold on;
% xlim([0,dlength]);
xlim([t1 t2]);
ylim([0,90]);
xlabel('Time (sec)');ylabel('Inc of P-DOA');

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18



% ---[Plot average DOA]---------------------------------------------------    
% figure;
% subplot(3,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
% % xlim([500,600]);
% xlim([0,dlength]);
% hold on
% 
% subplot(3,1,2)
% plot(time_border,eig3Azi,'Color',cm(1,:));hold on;
% xlim([0,dlength]);ylim([0,360]);
% xlabel('Time (sec)');ylabel('Azimuth of normal Vec. S wave');
% 
% subplot(3,1,3)
% plot(time_border,eig3Inc,'Color',cm(1,:));hold on;
% xlim([0,dlength]);ylim([-90,90]);
% xlabel('Time (sec)');ylabel('Inc of normal Vec. S wave');

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

