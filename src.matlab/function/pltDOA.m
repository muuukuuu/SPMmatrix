function pltDOA(point_in,time_border,wave_in,fs,fft_N,flc,fhc,azi_data1,azi_data1ave,inc_data1,inc_data1ave)

dlength=numel(wave_in(:,1));
dlength=1000;

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 

if true
    figure;
    % ---[Waveform]---------------------------------------------------    
%     subplot(3,1,1)
    subplot(4,1,1)
    plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
    plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
    plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
    % xlim([500,600]);
    xlim([0,dlength]);
    hold on

    % ---[DOA eig1 Azimuth]---------------------------------------------------    
%     subplot(3,1,2)
    subplot(4,1,[2,3])
    Y=1:fft_N;
    contourf(time_border,Y*fs/fft_N,azi_data1','LineStyle','none');hold on;
    % box on;
    xlim([0,dlength]);
    ylim([0,fs/2]);
    xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title('DOA eig1 azimuth');

    %----Color bar----------------------------------------------------------
    % caxis([ 0 360 ]) ;
    % colorbar('eastoutside');
    % xlabel('Lnearity');
    % hold on;


    % % ---[DOA eig1 Inc]---------------------------------------------------   
    subplot(3,1,3)
    % subplot(3,1,[2,3])
    contourf(time_border,Y*fs/fft_N,inc_data1','LineStyle','none');
    xlim([0,dlength]);
    ylim([0,fs/2]);
        subplot(4,1,4)
    plot(time_border,inc_data1ave);
    xlim([0,dlength]);
    ylim([0,90]);
    xlabel('Time (points)');ylabel('DOA');
    
    xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title('DOA eig1 inc');

    %----Color bar----------------------------------------------------------
    % caxis([ 0 90 ]) ;
    % colorbar('eastoutside');
    % xlabel('Lnearity');
    % hold on;
    set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
end


if false
    figure;
    % ---[ Waveform ]---------------------------------------------------    
    subplot(3,1,1)
    plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
    plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
    plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
    % xlim([500,600]);
    xlim([0,dlength]);
    hold on;

    % ---[DOA eig3 Azimuth]---------------------------------------------------    
    subplot(3,1,2)
    % subplot(2,1,1)
    Y=1:fft_N;
    contourf(time_border,Y*fs/fft_N,azi_data3','LineStyle','none');hold on;
    % box on;
    xlim([0,dlength]);
    ylim([0,fs/2]);ylim([flc/2,fhc*2]);
    xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title('DOA eig3 azimuth');

    %----Color bar----------------------------------------------------------
    % caxis([ 0 360 ]) ;
    % colorbar('eastoutside');
    % xlabel('Lnearity');
    % hold on;


    % % ---[DOA eig3 Inc]---------------------------------------------------    
    subplot(3,1,3)
    % subplot(3,1,[2,3])
    contourf(time_border,Y*fs/fft_N,inc_data3','LineStyle','none');
    xlim([0,dlength]);
    ylim([0,fs/2]);ylim([flc/2,fhc*2]);
    xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title('DOA eig3 inc');

    %----Color bar----------------------------------------------------------
    % caxis([ 0 90 ]) ;
    % colorbar('eastoutside');
    % xlabel('Lnearity');
    % hold on;

    set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
end


if true
    % ---[Fig DOA P wave]---------------------------------------------------    
    figure;
    % subplot(3,1,1)
    Y=1:fft_N;
    subplot(4,1,1)
    plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
    plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
    plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
%     plot([ppck_obs,ppck_obs],[-1,1],'Color',cm(4,:));plot([spck_obs,spck_obs],[-1,1],'Color',cm(4,:));
    xlim([0,dlength]);
    hold on

    % sb=subplot(3,1,[2,3]);
    subplot(4,1,[2,3]);
    contourf(time_border,Y*fs/fft_N,inc_data1','LineStyle','none');
    % xlim([0,1000/fs]);
    xlim([0,dlength]);
    ylim([0,fs/2]);
    xlabel('Time (points)');ylabel('Frequency (Hz)');
    title('DOA inclination of 1st eigen vector');

    subplot(4,1,4)
    plot(time_border,inc_data1ave);
    xlim([0,dlength]);
    ylim([0,90]);
    xlabel('Time (points)');ylabel('DOA');

    set(gcf,'Position',[159   0   860*0.9   771*0.9]) % By Hotta Dec.18
end



