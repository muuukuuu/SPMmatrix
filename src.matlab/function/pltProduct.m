function pltProduct(point_in,time_border,wave_in,fs,fft_N,pol_data1,pol_data1ave,inc_data1,inc_data1ave)
% product of poldata and inc data

dlength=numel(wave_in(:,1));
% dlength=000;

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
 
multi=(inc_data1'/90).*pol_data1';
multi_ave=(inc_data1ave/90).*pol_data1ave;

if true
    % ---[Fig DOA P wave]---------------------------------------------------    
    figure
    subplot(4,1,1)
    plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1))),'Color',cm(1,:));hold on;
    plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2))),'Color',cm(2,:));hold on;
    plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3))),'Color',cm(3,:));hold on;
    % xlim([500,600]);
    xlim([0,dlength]);
%     xlim([3000,3500]);
    hold on
    
    subplot(4,1,[2,3]);
    Y=1:fft_N;
    contourf(time_border,Y*fs/fft_N,multi,'LineStyle','none');
    % xlim([0,1000/fs]);
    xlim([0,dlength]);
%     xlim([3000,3500]);
    ylim([0,fs/2]);
    xlabel('Time (points)');ylabel('Frequency (Hz)');
    title('Product of Cf and DOA inc.');
    hold on;
    
%   %----Color bar----------------------------------------------------------
%     caxis([0 1]);colorbar;
%     hold on;

    subplot(4,1,4)
    plot(time_border,multi_ave);hold on;
    plot(time_border,inc_data1ave/90);hold on;
    plot(time_border,pol_data1ave);hold on;
    xlim([0,dlength]);
%     xlim([3000,3500]);
    ylim([0,1]);
    xlabel('Time (points)');
%     ylabel('DOA inc.');
    hold on;
    
    legend('product','DOAinc','Cfunc')

    set(gcf,'Position',[159   0   860*0.9   771*0.9]) % By Hotta Dec.18
end



