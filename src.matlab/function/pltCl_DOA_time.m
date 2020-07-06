function pltCl_DOA_time(time_border,point_in,wave_in,pol_data1,inc_data1)

dlength=numel(wave_in(:,1));

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 DOA=85;

% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
subplot(4,1,1)
% plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
% plot(point_in,wave_in(:,1)  ,'Color',cm(1,:));hold on;
% plot(point_in,wave_in(:,2)-1,'Color',cm(2,:));hold on;
% plot(point_in,wave_in(:,3)-2,'Color',cm(3,:));hold on;
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))  ,'Color',cm(1,:));hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1,'Color',cm(2,:));hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-2,'Color',cm(3,:));hold on;


xlim([0,dlength]);
% xlim([3000,3500]);
% xlim([1800,3000]);
% xlim([0,2000]);

subplot(4,1,2)
plot(time_border,pol_data1,'Color',cm(1,:));
xlim([0,dlength]);
ylim([0,1])
xlabel('Time (points)');ylabel('C linear');
% title('Averaged in 4~10 Hz');

subplot(4,1,3)
plot(time_border,inc_data1,'Color',cm(1,:));
line([0,dlength],[DOA,DOA],'Color',cm(2,:));
xlim([0,dlength]);
ylim([0,90])
xlabel('Time (points)');ylabel('DOA inc. deg.');

subplot(4,1,4)
max(1-abs(inc_data1-DOA)/DOA)
id=find(max(1-abs(inc_data1-DOA)/DOA))
% plot(time_border,pol_data1.*(1-abs(inc_data1-DOA)/DOA),'Color',cm(1,:));hold on;
x=time_border;
y=pol_data1.*(1-abs(inc_data1-DOA)/DOA);

DOA1=DOA+5;DOA2=DOA-5;
errBar(1,:)=pol_data1.*(1-abs(inc_data1-DOA1)/DOA1)-pol_data1.*(1-abs(inc_data1-DOA)/DOA);
errBar(2,:)=pol_data1.*(1-abs(inc_data1-DOA2)/DOA2)-pol_data1.*(1-abs(inc_data1-DOA)/DOA);

% plot(time_border,errBar(1,:),'Color',cm(2,:));hold on;
% plot(time_border,errBar(2,:),'Color',cm(3,:));hold on;
% size(x)
% errBar=y1;
shadedErrorBar(x,y,errBar,'r')

% line([0,dlength],[DOA,DOA],'Color',cm(2,:));
xlim([0,dlength]);
ylim([0,1])
xlabel('Time (points)');ylabel('CF');



set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
