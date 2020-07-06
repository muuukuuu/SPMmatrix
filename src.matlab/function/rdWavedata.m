function wavedata=rdWavedata

addpath_naoi_mtlbtools

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

% % ---[Reference time]---
fs=200;
% ---[day2sec]---
reft=datenum('20161101 000000.315','yyyymmdd HHMMSS.FFF')*24*60*60;

for s=1:StNum
    for d=1:Dnum
    % for s=1:1
    % for d=1:1
    %     d=4;
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

%         datanum(s,d)=length(wavedata_tmp(1,3).t);
%         tmp=round(datanum/24);
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