function pltAveCl(time_border,point_in,wave_in,fft_N,pol_data1ave)

dlength=numel(wave_in(:,1));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 

% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
subplot(3,1,1)
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
xlim([0,dlength]);

subplot(3,1,2)
Y=1:fft_N;
plot(time_border,pol_data1ave,'Color',cm(1,:));
xlim([0,dlength]);ylim([0,1])
xlabel('Time (sec)');ylabel('C linear');



set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
