function pltaveCl_DOA_wndw(point_in,wave_in,fft_N,win_length_opt,Re_wndw)
fs=200;
pol_data1ave(:,:)=Re_wndw(1,4,:,1,:);
inc_data1ave(:,:)=Re_wndw(1,4,:,2,:);
sec(:,:)=Re_wndw(1,4,:,5,:);
winnum=numel(win_length_opt)

map=colormap(winter(4));

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
 t1=762;t2=767;   % B2
%  t1=1957;t2=1962;   % B3
%  t1=3357;t2=3362; % B4
%  t1=995;t2=1000; % B5
%  t1=2192;t2=2200; % B6


% ---[Fig Linearlity and Ellipticity]---------------------------------------------------    
figure;
subplot(3,1,1)
plot(point_in,wave_in(:,1)/max(abs(wave_in(:,1)))  ,'Color','k');hold on;
plot(point_in,wave_in(:,2)/max(abs(wave_in(:,2)))-1,'Color','k');hold on;
plot(point_in,wave_in(:,3)/max(abs(wave_in(:,3)))-2,'Color','k');hold on;
% for i=1:1
for i=1:numel(win_length_opt)
    X=[t1,t1+win_length_opt(i)/fs];
    Y=[-2.2-0.1*i,-2.2-0.1*i];
    line(X,Y,'Color',cm(i,:),'LineWidth',1.5);hold on
end
xlim([t1 t2]);

subplot(3,1,[2,3])
subplot(3,1,2)
% for i=1:numel(win_length_opt)
for i=1:winnum
    k=nnz(sec(i,:))
    plot(sec(i,1:k),pol_data1ave(i,1:k),'Color',cm(i,:),'Linewidth',1);hold on;
    clear k
end
xlim([t1 t2]);
% xlim([763 766]);
ylim([0,1])
xlabel('Time (sec)');ylabel('C linear');


subplot(3,1,3)
for i=1:winnum
    k=nnz(sec(i,:))
    plot(sec(i,1:k),inc_data1ave(i,1:k),'Color',cm(i,:),'Linewidth',1);hold on;
    clear k
end
xlim([t1 t2]);
% xlim([763 766]);
ylim([0,90])
xlim([t1 t2]);



set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18
