function pltWvSpect(fs,dlength,wave_in)


%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
% ---[Plot Entire wave]-------------------------------------------------------------------- 
% p1(1)=55;p2(1)=70;
% p1(2)=90;p2(2)=105;
% p1(3)=130;p2(3)=145;
% p1(4)=145;p2(4)=160;
% p1(5)=160;p2(5)=180;
% p1(6)=190;p2(6)=200;
% p1(7)=200;p2(7)=215;
% 
% p1(1)=55+438.5/fs;
% p1(2)=90+366.5/fs;
% p1(3)=130+449.5/fs;
% p1(4)=145+489.5/fs;
% p1(5)=160+405.5/fs;
% p1(6)=190+364.5/fs;
% p1(7)=200+190.5/fs

% for i=1:6
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,1).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,1).d)-0,...
%         'Color',cm(i,:));hold on;
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,2).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,2).d)-1.5,...
%         'Color',cm(i,:));hold on;
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,3).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,3).d)-3,...
%         'Color',cm(i,:));hold on;
% end
% for i=7:7
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,1).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,1).d)-0,...
%         'Color',cm(i,:));hold on;
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,2).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,2).d)-1.5,...
%         'Color',cm(i,:));hold on;
%     plot(point(p1(i)*fs:p2(i)*fs)/fs,wavedata(1,3).d(p1(i)*fs:p2(i)*fs)/max(wavedata(1,3).d)-3,...
%         'Color',cm(i,:));hold on;
% end
% xlim([0,300]);
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


% ---[Plot wave in]-------------------------------------------------------------------- 
% figure
% point_in=1:dlength;
% point_in=point_in/fs;
% 
% % subplot(2,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))-0,'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-2,'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-4,'Color',cm(1,:));hold on;
% % ylabel('');
% yticklabels([]);
% xlabel('Time(sec)');
% set(gcf,'Position',[159   0   860*0.9   771*0.45]); % By Hotta Dec.18




% ---[Plot wave in]-------------------------------------------------------------------- 
figure
point_in=1:dlength;

subplot(3,1,1)
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% xlim([0 2*10^4])
ylabel('x');

subplot(3,1,2)
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(1,:));hold on;
% xlim([0 2*10^4])
ylabel('y');

subplot(3,1,3)
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(1,:));hold on;
% xlim([0 2*10^4])
ylabel('z');
xlabel('points');
set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18



% figure
% point_in=1:dlength;
% subplot(3,1,1)
% plot(point_in,wave_in(:,1)/max( abs(wave_in(:,1)) ),'Color',cm(1,:),'linewidth',1);hold on;
% % xlim([1500 3500]);ylim([-1 1]);
% 
% subplot(3,1,2)
% max( abs(wave_in(:,2)))
% plot(point_in,wave_in(:,2)/max( abs(wave_in(:,2)) ),'Color',cm(2,:),'linewidth',1);hold on;
% % xlim([1500 3500]);ylim([-1 1]);
% 
% subplot(3,1,3)
% plot(point_in,wave_in(:,3)/max( abs(wave_in(:,3)) ),'Color',cm(3,:),'linewidth',1);hold on;
% % xlim([1500 3500]);ylim([-1 1]);
% 
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


% ---[Plot Spectram in log]-------------------------------------------------------------------- 
figure;
subplot(3,1,1)
periodogram(wave_in(:,1),rectwin(length(wave_in(:,1))),length(wave_in(:,1)),fs,'psd');hold on;
% ylim([-40 40]);

subplot(3,1,2)
periodogram(wave_in(:,2),rectwin(length(wave_in(:,2))),length(wave_in(:,2)),fs,'psd');hold on;
% ylim([-40 40]);

subplot(3,1,3)
periodogram(wave_in(:,3),rectwin(length(wave_in(:,3))),length(wave_in(:,3)),fs,'psd');hold on;
% ylim([-40 40]);

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

 
% % ---[Plot Spectram in linear]-------------------------------------------------------------------- 
% figure;
% subplot(3,1,1)
% [pxx, w] = periodogram( wave_in(:,1) );
% plot( w/pi*fs/2, pxx );
% 
% subplot(3,1,2)
% [pxx, w] = periodogram( wave_in(:,2) );
% plot( w/pi*fs/2, pxx );
% 
% subplot(3,1,3)
% [pxx, w] = periodogram( wave_in(:,3) );
% plot( w/pi*fs/2, pxx );


% figure;
% subplot(3,1,1)
% periodogram(wave_in(:,1),rectwin(length(wave_in(:,1))),length(wave_in(:,1)),fs)
% subplot(3,1,2)
% periodogram(wave_in(:,2),rectwin(length(wave_in(:,2))),length(wave_in(:,2)),fs)
% subplot(3,1,3)
% periodogram(wave_in(:,3),rectwin(length(wave_in(:,3))),length(wave_in(:,3)),fs)
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


figure;
subplot(3,1,1)
spectrogram(wave_in(:,1),40,38,128,fs,'yaxis')
subplot(3,1,2)
spectrogram(wave_in(:,2),40,38,128,fs,'yaxis')
subplot(3,1,3)
spectrogram(wave_in(:,3),40,38,128,fs,'yaxis')


set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
