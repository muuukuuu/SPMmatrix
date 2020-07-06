function [S,t]=MakeSyntheticWave()
%%% Parameter setting
    fs=100;                     %sampling frequency [Hz]
    f =5;                       %frequency of synthetic signal [Hz]
    f2 =15;                     %frequency of synthetic signal [Hz]
    fc = (f+f2)/2;
    T=1/fs;                     %sampling period [sec]
    t=T:T:25;                   %Length of signal [sec]
%     t=0:T:10;                   %Length of signal [sec]
    SN=25.2;                       %SN ratio[dB]
    
    A=[1;1;1];                  %[ratio of 3 component wave]
    beta=3;                     %positive constant number on attenuation[msec-1]
    theta1=45;phi1=60;
    
    s=zeros(3,numel(t));
    
    % P wave SN28  
%     stemp=exp(-beta*t).*sin(2*pi*f*(t));
    stemp2=exp(-beta*t).*sin(2*pi*f2*(t));
    
%--- Richer wavelet version  
%--- P-wave  
    t2=t-10*T;
    temp=(1-2*(pi^2)*(fc^2).*t2.^2).*exp(-2*(pi^2)*(fc^2).*t2.^2);
    temp(1,numel(temp)+1)=0;
    stemp=diff(temp);
    stemp=stemp./max(stemp);
    clear temp
    
%--- S-wave  
    fc=fc*3/5;
    temp=(1-2*(pi^2)*(fc^2).*t2.^2).*exp(-2*(pi^2)*(fc^2).*t2.^2);
    temp(1,numel(temp)+1)=0;
    stemp2=diff(temp);
    stemp2=stemp2./max(stemp2);
    
%     stemp(1,:)=exp(-beta*t).*sin(2*pi*f*(t));
%     stemp(2,:)=exp(-beta*t).*sin(2*pi*f*(t)-pi/2/2);
%     stemp(3,:)=exp(-beta*t).*sin(-2*pi*f*(t)-pi/2/3);
    
    Amp1=dB2Amp(SN);
%     stemp=Amp1.*stemp;
%     stemp2=A.*stemp2;
%   stemp2=A.*B'.*stemp2;
    B=drctnalcsn(theta1,phi1);
    stemp=A.*B'.*stemp;
%     stemp=A.*stemp;
    
    Amp2=dB2Amp(SN+5);
    B=drctnalcsn(theta1+90,phi1+90);
    stemp2=A.*B'.*stemp2;
%     stemp2=A.*stemp2;
    stemp2=stemp2.*1.25;
   
    s(:,20/T+1:25/T)=stemp (:,1:5/T);
    s(:,21/T+1:25/T)=stemp2(:,1:4/T);
    

%     % P wave SN8.3
%     stemp=exp(-beta*t).*sin(2*pi*f*(t));
%     SN=16.8;
%     theta1=40;phi1=70;
%     Amp=dB2Amp(SN);
%     stemp=A./Amp1*Amp*stemp;
% %     stemp2=stemp(1,:);
%     B=drctnalcsn(theta1,phi1);
%     stemp=B'.*stemp;
%     s(:,70/T+1:75/T)=stemp(:,1:5/T);
    
%     % P wave SN2.6
%     stemp=exp(-beta*t).*sin(2*pi*f*(t));
%     SN=14.2;
%     theta1=40;phi1=70;
%     Amp=dB2Amp(SN);
%     stemp=A./Amp1*Amp*stemp;
% %         stemp2=stemp(1,:);
%     B=drctnalcsn(theta1,phi1);
%     stemp=B'.*stemp;
%     s(:,120/T+1:125/T)=stemp(:,1:5/T);
    
    % S wave SN3     -23
%     stemp=exp(-beta*t).*sin(2*pi*f*(t));
    stemp(1,:)=exp(-beta*t).*( sin(2*pi*f*(t))         );
    stemp(2,:)=exp(-beta*t).*( sin(2*pi*f*(t)-pi/2/2)  );
%     stemp(3,:)=exp(-beta*t).*( sin(2*pi*f*(t)-pi/2/3));
    stemp(3,:)=exp(-beta*t).*( sin(2*pi*f*(t)-pi/2/3) + 0.5*sin(2*pi*1.5*f*(t)) );

    SN=14.4;
    theta1=40;phi1=70;
    Amp=dB2Amp(SN);
    stemp=1/Amp1*Amp*stemp;
%         stemp2=stemp(1,:);
    B=drctnalcsn(theta1,phi1);
%     stemp=B'.*stemp;
%     s(:,170/T+1:175/T)=stemp(:,1:5/T);
%     s(:,700:900)=stemp(:,1:201);
    
%----[Noise]------
    %--- White noise
    N=-1+(2)*rand(numel(t),3);
    
    %--- Bandpass --> Band Pass Noise Oleg version
%     N(1,:)=olegNoise2;
%     N(2,:)=olegNoise2;
%     N(3,:)=olegNoise2;
%     N=N';
%     
%     N(:,1)=N(:,1)/max( N(:,1) );
%     N(:,2)=N(:,2)/max( N(:,2) );
%     N(:,3)=N(:,3)/max( N(:,3) );

%     [pxx, w] = periodogram( N(:,1) );
%     subplot( 2,1,1 )
%     plot( w/pi*fs/2, pxx );

    %--- Bandpass --> Band Pass Noise
    fm= 7;                               % Center freq.
    f1= 4;                      % lower freq
    f2= 12;                      % higher freq
    oct_band= [f1 f2]/(fs/2);            % Bandpath
    n=5;                                 % Parameter setting for filter
    b = fir1(n,oct_band,'bandpass');
%     freqz(b);
    
    N(:,1)=filter(b,1,N(:,1));
    N(:,2)=filter(b,1,N(:,2));
    N(:,3)=filter(b,1,N(:,3));

%%     Noise check plot
    figure
    subplot( 3,1,1 )
        plot( t, N(:,1) );
    subplot( 3,1,2 )
        [pxx, w] = periodogram( N(:,1) );
        plot( w/pi*fs/2, pxx );
    subplot( 3,1,3 )
        periodogram( N(:,1) );

    %------------------
    SN=16;
    Amp=dB2Amp(SN);
    N=N./Amp;
        
    SNR(1) = 10*log10( var(s(1,20/T+1:21/T))/var(N(20/T+1:21/T,1)) );
    SNR(2) = 10*log10( var(s(2,20/T+1:21/T))/var(N(20/T+1:21/T,2)) );
    SNR(3) = 10*log10( var(s(3,20/T+1:21/T))/var(N(20/T+1:21/T,3)) );
    
    SNR
% %     mean(SNR)
%     pause
    
% S=s';
S=s'+N;
        
    
function Amp=dB2Amp(dB)
    Amp=10^(dB/20);
    
function A=drctnalcsn(theta1,phi1)
    % map coordinate to cartesian coordinate
    theta1=90-theta1;
    phi1=phi1;
    
    A(1)=cos(pi*(phi1/180))*cos(pi*(theta1/180));
    A(2)=cos(pi*(phi1/180))*sin(pi*(theta1/180));
    A(3)=sin(pi*(phi1/180));
    
        

