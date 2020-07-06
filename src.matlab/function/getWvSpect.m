function [pxx1,pxx2,pxx3,f1,f2,f3]=getWvSpect(fs,dlength,wave_in)


%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
% ---[Plot wave in]-------------------------------------------------------------------- 
% figure
% point_in=1:dlength;
% subplot(3,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% subplot(3,1,2)
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% subplot(3,1,3)
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

figure
point_in=1:dlength;
subplot(3,1,1)
plot(point_in,wave_in(:,1),'Color',cm(1,:));hold on;
subplot(3,1,2)
plot(point_in,wave_in(:,2),'Color',cm(2,:));hold on;
subplot(3,1,3)
plot(point_in,wave_in(:,3),'Color',cm(3,:));hold on;

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

% ---[Plot Spectram]-------------------------------------------------------------------- 
figure;
subplot(3,1,1)
[pxx1,f1]=periodogram(wave_in(:,1)/max(abs(wave_in(:,1))),rectwin(length(wave_in(:,1))),length(wave_in(:,1)),fs,'psd');
% [pxx1,f1]=periodogram(wave_in(:,1),rectwin(length(wave_in(:,1))),length(wave_in(:,1)),fs,'psd');
periodogram(wave_in(:,1),rectwin(length(wave_in(:,1))),length(wave_in(:,1)),fs,'psd');hold on;

subplot(3,1,2)
[pxx2,f2]=periodogram(wave_in(:,2)/max(abs(wave_in(:,2))),rectwin(length(wave_in(:,2))),length(wave_in(:,2)),fs,'psd');
% [pxx2,f2]=periodogram(wave_in(:,2),rectwin(length(wave_in(:,2))),length(wave_in(:,2)),fs,'psd');
periodogram(wave_in(:,2),rectwin(length(wave_in(:,2))),length(wave_in(:,2)),fs,'psd');

subplot(3,1,3)
[pxx3,f3]=periodogram(wave_in(:,3)/max(abs(wave_in(:,3))),rectwin(length(wave_in(:,3))),length(wave_in(:,3)),fs,'psd');
% [pxx3,f3]=periodogram(wave_in(:,3),rectwin(length(wave_in(:,3))),length(wave_in(:,3)),fs,'psd');
periodogram(wave_in(:,3),rectwin(length(wave_in(:,3))),length(wave_in(:,3)),fs,'psd');

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


%%---[Averaging PSD in log]---
flag=0;
if (flag==1)
    pxx1temp=movmean(log10(pxx1),5);
    pxx2temp=movmean(log10(pxx2),5);
    pxx3temp=movmean(log10(pxx3),5);
    
    pxx1=10.^pxx1temp;
    pxx2=10.^pxx2temp;
    pxx3=10.^pxx3temp;
    
%%---[Averaging PSD in linear]---
elseif (flag==2)
    pxx1temp=movmean(pxx1,5);
    pxx2temp=movmean(pxx2,5);
    pxx3temp=movmean(pxx3,5);
    
    pxx1=pxx1temp;
    pxx2=pxx2temp;
    pxx3=pxx3temp;
end

% % ---[Plot Spectram]-------------------------------------------------------------------- 
% figure;
% subplot(3,1,1)
% plot(f1,10*log10(pxx1))
% 
% subplot(3,1,2)
% plot(f2,10*log10(pxx2))
% 
% subplot(3,1,3)
% plot(f3,10*log10(pxx3))
% 
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
% 
% % ---[Plot Spectram]-------------------------------------------------------------------- 
% figure;
% subplot(3,1,1)
% plot(f1,sqrt(pxx1))
% 
% subplot(3,1,2)
% plot(f2,sqrt(pxx2))
% 
% subplot(3,1,3)
% plot(f3,sqrt(pxx3))
% 
% set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

