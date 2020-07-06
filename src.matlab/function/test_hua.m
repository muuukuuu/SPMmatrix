clear all;

load('data_hua.mat')
dt=ttime(2)-ttime(1);

ttsample=length(ttime);

%% all component
for ii = 1:1:15
%     rtime= ttime+stime(ii);
%     plot(rtime,wave(:,ii)/max(abs(wave(:,ii)))+ii,'k')
    pad0 = floor(stime(ii)/dt);
    wavenew(1:pad0,ii) =0;
    wavenew(pad0+1:ttsample,ii) = wave(1:ttsample-pad0,ii);
    plot(ttime,wavenew(:,ii)/max(abs(wavenew(:,ii)))+ii,'k')
%     text(90,ii,headers{1,ii+INR-1}.kstnm);
%     text(91,ii,headers{1,ii+INR-1}.kcmpnm);
end
xlim([90,100])
box on
xlabel('Time (s)','fontsize',12,'fontweight','bold');
grid on


%% Z component
wavez = zeros(ttsample,5);
wave1 = zeros(ttsample,5);
wave2 = zeros(ttsample,5);
figure
hold on
cnt =1;
for ii = 15:-3:3
   wavez(:,cnt)=wavenew(:,ii);
   plot(ttime,wavez(:,cnt)/max(abs(wavez(:,cnt)))+cnt);
%    text(90,cnt,headers{1,ii+INR-1}.kstnm);
%    text(91,cnt,headers{1,ii+INR-1}.kcmpnm); 
   cnt = cnt+1;
end
xlim([90,100])
box on
xlabel('Time (s)','fontsize',12,'fontweight','bold');
grid on



%% H1 component
figure
hold on
cnt =1;
for ii = 13:-3:1
   wave1(:,cnt)=wavenew(:,ii);
   plot(ttime,wave1(:,cnt)/max(abs(wave1(:,cnt)))+cnt);
%    text(90,cnt,headers{1,ii+INR-1}.kstnm);
%    text(91,cnt,headers{1,ii+INR-1}.kcmpnm); 
   cnt = cnt+1;
end
xlim([90,100])
box on
xlabel('Time (s)','fontsize',12,'fontweight','bold');
grid on

%% H2 component
figure
hold on
cnt =1;
for ii = 14:-3:2
   wave2(:,cnt)=wavenew(:,ii);
   plot(ttime,wave2(:,cnt)/max(abs(wave2(:,cnt)))+cnt);
   text(90,cnt,headers{1,ii+INR-1}.kstnm);
   text(91,cnt,headers{1,ii+INR-1}.kcmpnm); 
   cnt = cnt+1;
end
xlim([90,100])
box on
xlabel('Time (s)','fontsize',12,'fontweight','bold');
grid on
