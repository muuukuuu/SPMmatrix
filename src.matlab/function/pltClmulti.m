function [multiPol]=pltClmulti(point_in,wave_in,time_border1,pol_data1ave1,time_border2,pol_data1ave2)

dlength=numel(wave_in(:,1));

% size(pol_data1ave1)
% size(pol_data1ave2)

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
% xlim([0,2000]);
% xlim([2000,3500]);


subplot(3,1,2)
for i=1:numel(point_in)
    multiPol(i)=0;
    for j=1:numel(time_border1)
        if ( i==time_border1(j) )
            for k=1:numel(time_border2)
                if ( time_border1(j)==time_border2(k))
                    multiPol(i)=pol_data1ave1(j)*pol_data1ave2(k);
                end
            end
        end
    end
end
size(multiPol);
plot(point_in,multiPol,'Color',cm(1,:));hold on;
ylabel('Mulitiplied polarity');
xlim([0,dlength]);
% xlim([2000,3500]);

subplot(3,1,3)
plot(time_border1,pol_data1ave1,'Color',cm(2,:));hold on;
plot(time_border2,pol_data1ave2,'Color',cm(4,:));hold on;
ylabel('Polarity');
xlabel('Time (msec)');
xlim([0,dlength]);
% xlim([2000,3500]);
ylim([0,1]);
xlabel('Time (msec)');
ylabel('Polarity');
% title('Linearity');


set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
