function pltCl(time_in,time_border,wave_in,fs,fft_N,flc,fhc,pol_data1,pol_data1ave)

dlength=numel(time_in(:,1));
point=1:dlength;


wave_in(:,1)=detrend(wave_in(:,1));
wave_in(:,2)=detrend(wave_in(:,2));
wave_in(:,3)=detrend(wave_in(:,3));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 t1=748;t2=758;   % M1.9
%  t1=3466;t2=3476; % M2.2
%  t1=7399;t2=7409; % B1
%  t1=762;t2=768;   % B2
%  t1=1957;t2=1962;   % B3
%  t1=3357;t2=3362; % B4
%  t1=995;t2=1000; % B5
%  t1=2192;t2=2200; % B6

% t1=datenum('2018-01-08 14:00:40');
% t2=datenum('2018-01-08 14:01:20');

% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
subplot(4,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;

plot(time_in,wave_in(:,1)/max(abs(wave_in(:,1)))  ,'Color',cm(1,:));hold on;
plot(time_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1,'Color',cm(2,:));hold on;
plot(time_in,wave_in(:,3)/max(abs(wave_in(:,3)))-2,'Color',cm(3,:));hold on;
% xlim([0,dlength]);
% datetick('x',21);
% datetick('x',21,'keepticks');
xlim([t1 t2]);
hold on;


subplot(4,1,[2,3])
Y=1:fft_N;
contourf(time_border,Y*fs/fft_N,pol_data1','LineStyle','none');
% xlim([0,dlength]);
% datetick('x',21);
xlim([t1 t2]);

% xlim([]);
ylim([0,fs/2]);

ylabel('Frequency (Hz)');
title('Linearity');
hold on


% %----Color bar----------------------------------------------------------
caxis([ 0 1 ]) ;
c=colorbar('eastoutside');
c.Label.String = 'Linearity';
% xlabel('Linearity');
hold on;


subplot(4,1,4)
plot(time_border,pol_data1ave,'Color',cm(1,:));
% xlim([0,dlength]);
% datetick('x',21);
xlim([t1 t2]);
ylim([0,1]);

xlabel('Time');ylabel('Ave Clinear');
hold on;


set(gcf,'Position',[159   0   860*0.8   771*0.9]); % By Hotta Dec.18
