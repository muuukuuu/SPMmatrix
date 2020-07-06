function pltVec(point_in,time_border,wave_in,fs,fft_N,Vnorm,Vintenorm)

dlength=numel(wave_in(:,1))
% dlength=1000;

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
% t1=3466;t2=3476; % M2.2
% t1=7399;t2=7409; % B1
t1=762;t2=768;   % B2
% t1=1957;t2=1962;   % B3
% t1=3357;t2=3362; % B4
% t1=995;t2=1000; % B5
% t1=2192;t2=2200; % B6


% ---[Fig Norm length]---------------------------------------------------    
if true
    figure;
    % subplot(3,1,1)
    Y=1:fft_N;
    subplot(4,1,1)
    
    plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))  ,'Color',cm(1,:));hold on;
    plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1,'Color',cm(2,:));hold on;
    plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-2,'Color',cm(3,:));hold on;
    
%     plot([ppck_obs,ppck_obs],[-1,1],'Color',cm(4,:));plot([spck_obs,spck_obs],[-1,1],'Color',cm(4,:));
    xlim([0,dlength]);
    xlim([t1 t2]);
    hold on

%     sb=subplot(3,1,[2,3]);
    subplot(4,1,[2,3]);
    contourf(time_border,Y*fs/fft_N,Vnorm','LineStyle','none');
    xlim([0,dlength]);
    xlim([t1 t2]);

    ylim([0,fs/2]);
    xlabel('Time (points)');ylabel('Frequency (Hz)');
    
    %----Color bar----------------------------------------------------------
%     caxis([ -30 10 ]) ;
    c=colorbar('eastoutside');
    c.Label.String =('log10(Norm)');
    hold on;

    subplot(4,1,4)
    plot(time_border,Vintenorm);
    xlim([0,dlength]);
    xlim([t1 t2]);
%     ylim([0,90]);
    xlabel('Time (points)');ylabel('DOA inc.');
    
    
    set(gcf,'Position',[159   0   860*0.8   771*0.9]) % By Hotta Dec.18
end


% ---[Fig DOA ]---------------------------------------------------    
