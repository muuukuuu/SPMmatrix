function plt_ch_CC(time_border,point_in,wave_in,CC)

dlength=numel(wave_in(:,1));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 t1=748-10;t2=758+10;   % M1.9
%  t1=3466;t2=3476; % M2.2
% t1=7399;t2=7409; % B1
% t1=762;t2=768;   % B2
% t1=1957;t2=1962;   % B3
% t1=3357;t2=3362; % B4
% t1=995;t2=1000; % B5
% t1=2192;t2=2200; % B6

% t1=748;t2=768;   % M1.9+B2

% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
% ---------
subplot(2,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
% plot(point_in,wave_in(:,1)  ,'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)-1,'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)-2,'Color',cm(3,:));hold on;
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))  ,'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1,'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-2,'Color',cm(3,:));hold on;


% xlim([0,dlength]);
% xlim([3000,3500]);
% xlim([1800,3000]);
% xlim([0,2000]);
xlim([t1 t2]);


subplot(2,1,2)
plot(time_border,CC,'Color',cm(1,:));hold on;
xlim([t1 t2]);
% ylim([0,90])
xlabel('Time (sec)');ylabel('CC');
set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

return


% ---------
subplot(4,1,2)
yyaxis left

plot(time_border,inc_data1ave,'Color',cm(1,:));hold on;
% line([0,dlength],[DOA,DOA],'Color',cm(2,:));
% xlim([0,dlength]);
xlim([t1 t2]);
ylim([0,90])
xlabel('Time (points)');ylabel('DOA inc. deg.');

yyaxis right
plot(time_border,prob);hold on;
ylabel('Ef for DOA');
ylim([0,1]);
% xlabel('Time (points)');ylabel('C linear');
% title('Averaged in 4~10 Hz');


% ---------
subplot(4,1,3)
yyaxis left
ID=find(azi_data1ave<0);
azi_data1ave(ID)=azi_data1ave(ID)+360;
clear ID
ID=find(azi_data1ave>180);
azi_data1ave(ID)=azi_data1ave(ID)-180;
plot(time_border,azi_data1ave,'Color',cm(1,:));hold on;
xlim([t1 t2]);
ylim([0,180])
xlabel('Time (points)');
ylabel('DOA azi. deg.');

yyaxis right
plot(time_border,prob_azi);hold on;
ylabel('Ef for DOA Azi');ylim([0,1]);


% ---------
subplot(4,1,4)
plot(time_border,cf,'Color',cm(6,:));hold on;
plot(time_border,cf_both,'Color',cm(7,:));hold on;
% line([t1 t2],[0.64 0.64],'Color',cm(6,:));hold on;
legend('Inc','Inc+Azi')
    
xlim([0,dlength]);
xlim([t1 t2]);

ylim([0,1])
xlabel('Time (points)');ylabel('CF');
% legend('L2norm','product')

% %----Color bar----------------------------------------------------------
% caxis([ 0 1 ]) ;
% c=colorbar('eastoutside');
% c.Label.String = 'alpha';
% % xlabel('Linearity');
% hold on;



set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
