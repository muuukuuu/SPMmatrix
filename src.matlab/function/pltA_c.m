function pltA_c(time_border,sec_in,wave_in,A_c)

dlength=numel(wave_in(:,1));
X=[1:1:dlength];
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
subplot(2,1,1)
% subplot(5,1,1)
% plot(sec_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
% plot(sec_in,wave_in(:,2)/max(abs(wave_in(:,2)))-2,'Color',cm(2,:));hold on;
% plot(sec_in,wave_in(:,3)/max(abs(wave_in(:,3)))-4,'Color',cm(3,:));hold on;
% xlim([min(sec_in),max(sec_in)]);

plot(X/200,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
plot(X/200,wave_in(:,2)/max(abs(wave_in(:,2)))-2,'Color',cm(2,:));hold on;
plot(X/200,wave_in(:,3)/max(abs(wave_in(:,3)))-4,'Color',cm(3,:));hold on;
xlim([0,dlength/200]);


for i=1:4
%     subplot(2,1,2)
    subplot(4,1,i)
    Y1(:)=A_c(1,i,:);    Y2(:)=A_c(2,i,:);    Y3(:)=A_c(3,i,:);
%     loglog(time_border,Y,'.-','MarkerSize',10,'Color',cm(1,:));hold on;
%     loglog(time_border,Y,'.-','MarkerSize',10,'Color',cm(2,:));hold on;
%     loglog(time_border,Y,'.-','MarkerSize',10,'Color',cm(3,:));hold on;
    % xlim([min(sec_in),max(sec_in)]);
    % xlim([0,dlength]);
    % ylim([0,1])

    loglog(time_border/200,Y1,'.-','MarkerSize',8,'Color',cm(1,:));hold on;
    loglog(time_border/200,Y2,'.-','MarkerSize',8,'Color',cm(2,:));hold on;
    loglog(time_border/200,Y3,'.-','MarkerSize',8,'Color',cm(3,:));hold on;
    aveY=(Y1+Y2+Y3)/3;
    loglog(time_border/200,aveY,'.-','MarkerSize',8,'Color','k');hold on;
%     ylim([10^0,10^6]);

    xlabel('Time (sec)');
    ylabel('Noise-corrected amplitude');
    clear Y1 Y2 Y3 aveY
end


set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


