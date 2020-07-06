function plt3cmpwv(t,wave,flag)
% flag=1 --> normalized

figure;
if flag==1
    wave(:,1)=wave(:,1)/max( wave(:,1) );
    wave(:,2)=wave(:,2)/max( wave(:,2) );
    wave(:,3)=wave(:,3)/max( wave(:,3) );
end

    subplot(3,1,1)
    plot(t,wave(:,1));hold on;
    ylim([-1 1]);
    xlabel('Time (sec)');ylabel('EW');
    
    subplot(3,1,2)
    plot(t,wave(:,2));hold on;
    ylim([-1 1]);
    xlabel('Time (sec)');ylabel('NS');

    
    subplot(3,1,3)
    plot(t,wave(:,3) );hold on;
    ylim([-1 1]);
    xlabel('Time (sec)');ylabel('UD');
    
set(gcf,'Position',[159   0   860*0.65   771*0.9]) % By Hotta Dec.18
    
