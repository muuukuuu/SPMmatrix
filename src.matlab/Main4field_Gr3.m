close all;
clear;

addpath_naoi_mtlbtools

fnc_pdir = './function/';
path(path,fnc_pdir);

tic

% --- [FFT optimizing process]---
fftw('dwisdom',[]);
fftw('planner','measure');
X = rand(128,1);
tic; fft(X); toc;
tic; fft(X); toc;
fftinfo = fftw('dwisdom');
fftw('dwisdom',fftinfo);

pause

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
%% ---[Stations ]---------------------------
% StName=['G67';'G23';'G29';'G19';'G24';...
%         'G18';'G30';'G20';'G34';'G63';...
%         'G11';'G22';'G36';'G40';'G62';...
%         'G09';'G41';'G33';'G61';'G45';...
%         'G27';'G68';'G21';'G47';'G42';...
%         'G49';'G32';'G55';'G03';'G52';...
%         'G56';'G70';'G07';'G38';'G58'];
StName=['G67';'G23';'G29';'G19';'G24';...
        ];
StName=cellstr(StName);
StNum=numel(StName);
% stflag=2;
depth=['1','2','3','4'];
Dnum=numel(depth);

% % ---[Observed DOA]---
obsDOA=[75,67,67,80,70];

% % ---[Observed Azimuth]---
obsAZI=[320,312,270,290,45];

% % ---[Reference time]---
fs=200;
% ---[day2sec]---
reft=datenum('20161101 000000.315','yyyymmdd HHMMSS.FFF')*24*60*60;

% if(false)
if(true)
for s=1:StNum
    for d=1:Dnum
%     for s=1:1
%     for d=1:1
%         d=4;
        SensName=[char(StName(s)) depth(d)]
        display(['Sensor :',num2str(d),'/',num2str(Dnum)] );
        display(['Station:', num2str(s),'/',num2str(StNum)] );

        %% ---[Reading waveform]---------------------------
        s1='./Data_Waveform/Nov_1_2016_Events/';
        listing = dir(s1);
        k=1;j=1;
        flitflag=0;
        for i=1:numel(listing)
            s2=listing(i).name;
            pattern=SensName;
            k = strfind(s2,pattern);
            if (k~=0)
                wavecandlist(j)=cellstr(s2);
                    j=j+1;
    %             pause
            end
        end

        % ID=find(extractBefore(wavecandlist(1),15)==extractBefore(wavecandlist,15));
        patternx='HH1';patterny='HH2';patternz='HHZ';
        xflag=find(contains(wavecandlist(:),patternx)==1);
        yflag=find(contains(wavecandlist(:),patterny)==1);
        zflag=find(contains(wavecandlist(:),patternz)==1);

        wavefile(1)=strcat(s1,wavecandlist(xflag));
        wavefile(2)=strcat(s1,wavecandlist(yflag));
        wavefile(3)=strcat(s1,wavecandlist(zflag));
        % startsec(1)=extractBetween(wavefile(1),19+28,21+29);
        % startsec(2)=extractBetween(wavefile(2),19+28,21+29);
        % startsec(3)=extractBetween(wavefile(3),19+28,21+29);
        starttimeStr(1)=extractBetween( wavefile(1),19+16,26+29);
        starttimeStr(2)=extractBetween( wavefile(2),19+16,26+29);
        starttimeStr(3)=extractBetween( wavefile(3),19+16,26+29);

        % ---[day2sec]---% unit data.t is day
        startt(1)=datenum(char(starttimeStr(1)),'yyyy.dd.HH.MM.SS.FFF')*24*60*60;
        startt(2)=datenum(char(starttimeStr(2)),'yyyy.dd.HH.MM.SS.FFF')*24*60*60;
        startt(3)=datenum(char(starttimeStr(3)),'yyyy.dd.HH.MM.SS.FFF')*24*60*60;

        wavedata_tmp(1)=rdsac( char(wavefile(1)) );
        wavedata_tmp(2)=rdsac( char(wavefile(2)) );
        wavedata_tmp(3)=rdsac( char(wavefile(3)) );

        len(1)=length(wavedata_tmp(1).t);
        len(2)=length(wavedata_tmp(2).t);
        len(3)=length(wavedata_tmp(3).t);

        % ---[Sec2point]---
        rstartpoint(1)=round(reft-startt(1),3)*fs;
        rstartpoint(2)=round(reft-startt(2),3)*fs;
        rstartpoint(3)=round(reft-startt(3),3)*fs;
        refpoint      =reft                   *fs;

        endtt=min( len-rstartpoint );

        datanum(s,d)=length(wavedata_tmp(1,3).t);
        tmp=round(datanum/24);
%         point=[1:1:datanum];
        % point=point/fs; %[point to sec]

        % ---[Wavedata process]---
        wavedata_tmp2(1).d(1:endtt)=wavedata_tmp(1).d(rstartpoint(1)+1:endtt+rstartpoint(1) );
        wavedata_tmp2(2).d(1:endtt)=wavedata_tmp(2).d(rstartpoint(2)+1:endtt+rstartpoint(2) );
        wavedata_tmp2(3).d(1:endtt)=wavedata_tmp(3).d(rstartpoint(3)+1:endtt+rstartpoint(3) );
        wavedata_tmp2(1).t(1:endtt)=wavedata_tmp(1).t(rstartpoint(1)+1:endtt+rstartpoint(1) );
        wavedata_tmp2(2).t(1:endtt)=wavedata_tmp(2).t(rstartpoint(2)+1:endtt+rstartpoint(2) );
        wavedata_tmp2(3).t(1:endtt)=wavedata_tmp(3).t(rstartpoint(3)+1:endtt+rstartpoint(3) );

        wavedata_tmp2(1).t=wavedata_tmp2(1).t-wavedata_tmp2(1).t(1);
        wavedata_tmp2(2).t=wavedata_tmp2(2).t-wavedata_tmp2(2).t(1);
        wavedata_tmp2(3).t=wavedata_tmp2(3).t-wavedata_tmp2(3).t(1);

        wavedata(s,d,1:3)=wavedata_tmp2;
        clear wavedata_tmp wavedata_tmp2
    end
end
end
% ---[Entire/part of wave]---
% t1=1/fs;t2=endtt/fs; % all
t1=748;t2=758; % M1.9
% t1=3466;t2=3476; % M2.2
% t1=7399;t2=7409; % B1
% t1=762;t2=768;   % B2
% t1=1957;t2=1962; % B3
% t1=3357;t2=3362; % B4
% t1=995;t2=1000; % B5
% t1=2192;t2=2200; % B6

% t1=3466;t2=3486; % M2.2


%% Parameter Setting
%%% Analysis parameter
dlength=datanum;                          % Length of wavedate [points]
dlength=max(datanum);                     % Length of wavedate [points]
fs=200;                                   % Sampling Frequency [Hz]
fft_N=128;                                % Length of data at FFT [points]
stepI=1;                                  % Step Number [-]
win_length=50;                            % Length of analysis window
% stepN=(dlength-win_length)/stepI-1;     %
stepN=(dlength-win_length)/stepI+1;       % Number of step [-]
freq_C=30;                                % Center Frequency [Hz]
deltaF=20;                                %

disp(['SamplingF = ',num2str(fs),' Hz']);
disp(['fft num   = ',num2str(fft_N),' points']);
disp(['window    = ',num2str(win_length),' points']);
disp(['window    = ',num2str(win_length/fs),' sec']);
disp(['Center f  = ',num2str(freq_C),' Hz']);
disp(['freq band = ',num2str(freq_C-deltaF/2),'~',num2str(freq_C+deltaF/2),' Hz']);
disp(['Freq reso = ',num2str(fs/fft_N),' Hz']);

%%% Bandpass filter setting
flc= 20;                                   % Lower limit of frequency [Hz]
fhc= 40;                                 % Higher limit of frequency[Hz]

% flc= 2;                                   % Lower limit of frequency [Hz]
% fhc= 50;                                 % Higher limit of frequency[Hz]
n= 4; Rp = 0.5;                           % Parameter setting for filter
Wn = [flc fhc]/(fs/2);                    % [lower cut off fr?@higher cut off fr]
% [b,a] = cheby1(n,Rp,Wn);                  % making Chebyshev Type I filter
[b,a] = butter(n,Wn,'bandpass');                  % making Butterworth filter 
% [b,a] = butter(9,15/fs/2,'high');                  % making Butterworth filter 



%%% ---[Input wave start point]---------------------------------------------------------
p1=1/fs;p2=endtt/fs;   % All
% p1=1/fs;p2=endtt/fs/4/4;   % All
% p1=p1+endtt/fs/4/4*2;
% p2=endtt/fs/4/4*4;
p1=748;p2=758;   % M1.9
% p1=3466;p2=3476; % M2.2
% p1=7399;p2=7409; % B1
% p1=762;p2=768;   % B2
% p1=1957;p2=1962; % B3
% p1=3357;p2=3362; % B4
% p1=995;p2=1000; % B5
% p1=2192;p2=2200; % B6

% p1=748;p2=768;   % M1.9+B2
% p1=3466;p2=3486; % M2.2+B

% % ---[Setting]---
Re=zeros(StNum,Dnum,5,4000);
% Re=zeros(StNum,Dnum,9,4000);
% Re=zeros(StNum,Dnum,9,3000000);
% Re=zeros(1,Dnum,5,max(dlength));

% for s=1:StNum
for s=1:1
%     for d=1:Dnum        
    for d=1:1
        d=4
        display(['Sensor :',num2str(d),'/',num2str(Dnum)] );
        display(['Station:', num2str(s),'/',num2str(StNum)] );

        %%% ---[Input wave]---------------------------------------------------------
%         wave_in(:,1)=filter(b,a,detrend(wavedata(s,d,1).d(p1*fs:p2*fs)));
%         wave_in(:,2)=filter(b,a,detrend(wavedata(s,d,2).d(p1*fs:p2*fs)));
%         wave_in(:,3)=filter(b,a,detrend(wavedata(s,d,3).d(p1*fs:p2*fs)));

        wave_in(:,1)=wavedata(s,d,1).d(p1*fs:p2*fs);
        wave_in(:,2)=wavedata(s,d,2).d(p1*fs:p2*fs);
        wave_in(:,3)=wavedata(s,d,3).d(p1*fs:p2*fs);

        dlength=length(wave_in(:,1));
        point_in=1:dlength;

        sec_in=wavedata(s,d,1).t(p1*fs:p2*fs)*24*60*60;
        stepN=(dlength-win_length)/stepI+1;       % Number of step [-]

        
        %% SPM calclation and analysis
        SPMdata1=zeros(stepN,fft_N,3);SPMdata3=zeros(stepN,fft_N,3);
        SPMdata1ave=zeros(stepN,1,3);SPMdata3ave=zeros(stepN,1,3);

        k=1;
        parfor i=1:stepN
        %         display(['SPM loop:',num2str(i),'/',num2str(stepN)] );
        %         display(['SPM loop:',num2str(i/stepN*100),'%' ]);
        %         if (i/stepN*100 >= k)
        %              display(['SPM loop:',num2str(i/stepN*100),'%' ]);
        %             toc
        %             k=k+1;
        %         end
            pnt_start=1+stepI*(i-1); % Point based
            pnt_end=stepI*(i-1)+win_length;
        %         pnt_center(i)=pnt_start;
            pnt_center(i)=pnt_start+win_length/2;

            wave_x = detrend(wave_in(pnt_start:pnt_end,1));
            wave_y = detrend(wave_in(pnt_start:pnt_end,2));
            wave_z = detrend(wave_in(pnt_start:pnt_end,3));

            whann=hann(win_length);

            input_wave1=wave_x.*whann;
            input_wave2=wave_y.*whann;          
            input_wave3=wave_z.*whann;
            input_wave=[input_wave1,input_wave2,input_wave3]';


            [SPMdata1(i,:,:),SPMdata3(i,:,:),Vinte(i,:),Vnorm(i,:,:),Inte_angle(i,:)]=clcSPMmtrx3(fft_N,input_wave);
        %     Vinte_norm(i)=norm(Vinte(i,:));

            [SPMdata1ave(i,:,:),SPMdata3ave(i,:,:),m]=clcSPMmtrx_ave2(fft_N,input_wave,freq_C,deltaF,fs);
            time_border(i)=pnt_center(i); 
        end


        % load('ResultSPM_test.mat')
        pol_data1=SPMdata1(:,:,3);azi_data1=SPMdata1(:,:,1);inc_data1=SPMdata1(:,:,2);
        pol_data1ave=SPMdata1ave(:,:,3);azi_data1ave=SPMdata1ave(:,:,1);inc_data1ave=SPMdata1ave(:,:,2);

        pol_data3=SPMdata3(:,:,3);azi_data3=SPMdata3(:,:,1);inc_data3=SPMdata3(:,:,2);
        pol_data3ave=SPMdata3ave(:,:,3);azi_data3ave=SPMdata3ave(:,:,1);inc_data3ave=SPMdata3ave(:,:,2);

        Vnorm_temp=Vnorm;
        clear Vnorm

        Vnorm1=Vnorm_temp(:,:,1);
        Vnorm2=Vnorm_temp(:,:,2);
        Vnorm3=Vnorm_temp(:,:,3);

        % Vnorm_temp(:,:)=Vnorm(:,1,:);
        % clear Vnorm
        % Vnorm=Vnorm_temp;


        %% Figure & Analysis
        %% ---[Plot Linearity]---------------------------------------------------    
        pltCl(sec_in,sec_in(time_border),wave_in,fs,fft_N,flc,fhc,pol_data1,pol_data1ave);

        % filename=['PlotCl_',SensName,'_B1_7399-7409']
        % filename=['PlotCl_',SensName,'_M2.2_3466-3476']
        % print(filename,'-dpng');

        %% ---[Plot ave Linearity]---------------------------------------------------    
%         pltAveCl(time_border,point_in,wave_in,fft_N,pol_data1ave)

        %% ---[Plot DOA]---------------------------------------------------    
%         pltDOAazi(sec_in,sec_in(time_border),wave_in,fs,fft_N,azi_data1,azi_data1ave);
        pltDOA4(sec_in,sec_in(time_border),wave_in,fs,fft_N,inc_data1,inc_data1ave)
%         pltDOA4(time_in,time_border,wave_in,fs,fft_N,inc_data1,inc_data1ave)
        BrightBandsColor = BrightBandsColormap;
        colormap(BrightBandsColor);

        % filename=['PlotDOA_',SensName,'_B1_7399-7409']
        % filename=['PlotDOA_',SensName,'_M1.9_748-758']
        % filename=['PlotDOA_',SensName,'_M2.2_3466-3476']
        % print(filename,'-dpng');

        %% ---[Plot ave DOA]---------------------------------------------------    
%         pltAveDOA(sec_in,sec_in(time_border),wave_in,azi_data1ave,inc_data1ave);

        %% ---[Plot Product of Linearity]---------------------------------------------------    
        % pltProduct(point_in,time_border,wave_in,fs,fft_N,pol_data1,pol_data1ave,inc_data1,inc_data1ave)

        %% ---[Plot lamda]---------------------------------------------------    
        % pltlamda(point_in,time_border,wave_in,fs,fft_N,pol_data1ave,azi_data1ave,inc_data1ave,lamda)

        %% ---[Calc CF]---------------------------------------------------    
        [cf,cf_doa]=calCF(inc_data1ave,pol_data1ave,obsDOA(s));
%         [cf,cf_doa,cf2,cf_azi,cf_both]=calCF_azi(inc_data1ave,azi_data1ave,pol_data1ave,obsDOA(s),obsAZI(s));
        % [cf,cf2]=calCF2(inc_data1ave,Inte_angle(:,2),pol_data1ave,obsDOA(s));
        plt_ch(sec_in(time_border),sec_in,wave_in,pol_data1ave,inc_data1ave,cf_doa,cf);
%         plt_ch_azi(sec_in(time_border),sec_in,wave_in,pol_data1ave,inc_data1ave,cf_doa,cf,azi_data1ave,cf_azi,cf_both);

        %% ---[Plot Eigen Vec]---------------------------------------------------    
        % pltVec(sec_in,sec_in(time_border),wave_in,fs,fft_N,log10(Vnorm1),log10(Vinte_norm) )
        % pltVec(sec_in,sec_in(time_border),wave_in,fs,fft_N,Vnorm1,Vinte_norm )

        %% ---[SAVE result]---------------------------------------------------    
        % save('ResultMain_test.mat','SPMdata1','SPMdata3','SPMdata1ave','SPMdata3ave','pnt_center');
%         Re(s,d,1,1:stepN)=pol_data1ave;
%         Re(s,d,2,1:stepN)=inc_data1ave;
%         Re(s,d,3,1:stepN)=cf_doa;
%         Re(s,d,4,1:stepN)=cf;
%         
%         Re(s,d,5,1:stepN)=sec_in(time_border);
% 
%         Re(s,d,6,1:stepN)=azi_data1ave;
%         Re(s,d,7,1:stepN)=cf_azi;
%         Re(s,d,8,1:stepN)=cf2;
%         
%         Re(s,d,9,1:stepN)=cf_both;
        
        clear wave_in time_bordertime
        % close all
    end;toc
end;toc
