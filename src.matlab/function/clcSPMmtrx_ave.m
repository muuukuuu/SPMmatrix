function [Data1,Data3,lamda,n_smooth]=clcSPMmtrx_ave(fft_N,wave,freq_C,deltaF,fs)
% number of points when FFT

wave_x=wave(1,:);
wave_y=wave(2,:);
wave_z=wave(3,:);

 % Calculate power/cross spectra
Sxx=fft(wave_x,fft_N).*conj(fft(wave_x,fft_N));
Syy=fft(wave_y,fft_N).*conj(fft(wave_y,fft_N));
Szz=fft(wave_z,fft_N).*conj(fft(wave_z,fft_N));
Sxy=fft(wave_x,fft_N).*conj(fft(wave_y,fft_N));   
Sxz=fft(wave_x,fft_N).*conj(fft(wave_z,fft_N));
Syx=fft(wave_y,fft_N).*conj(fft(wave_x,fft_N));
Syz=fft(wave_y,fft_N).*conj(fft(wave_z,fft_N));
Szx=fft(wave_z,fft_N).*conj(fft(wave_x,fft_N));  
Szy=fft(wave_z,fft_N).*conj(fft(wave_y,fft_N));

SPMtemp=[0 0 0;0 0 0;0 0 0];

for j=1:1
    % averaging spectra     
    freq=freq_C;
    ff = round(freq/(fs/fft_N)); %fs/fft_N: Freq resolution
%     deltaF=5;
    n_smooth=round(0.5*deltaF/(fs/fft_N));  % -->m=3
%     n_smooth=1

    Pxx=mean(Sxx(ff-n_smooth:ff+n_smooth));
    Pyy=mean(Syy(ff-n_smooth:ff+n_smooth));
    Pzz=mean(Szz(ff-n_smooth:ff+n_smooth));       
    Pxy=mean(Sxy(ff-n_smooth:ff+n_smooth));
    Pxz=mean(Sxz(ff-n_smooth:ff+n_smooth));
    Pyx=mean(Syx(ff-n_smooth:ff+n_smooth));                
    Pyz=mean(Syz(ff-n_smooth:ff+n_smooth));
    Pzx=mean(Szx(ff-n_smooth:ff+n_smooth));  
    Pzy=mean(Szy(ff-n_smooth:ff+n_smooth));

    % Define SPM matrix         
    SPM =[      Pxx  real(Pxy)     real(Pxz); 
           real(Pyx)      Pyy      real(Pyz);
           real(Pzx) real(Pzy)          Pzz];
        
%     SPM =[      Sxx(j)  real(Sxy(j))     real(Sxz(j)); 
%            real(Syx(j))      Syy(j)      real(Syz(j));
%            real(Szx(j)) real(Szy(j))          Szz(j)];

    % % ----- Analysis ---              
    % Getting eigen vector of SPM matrix
    SPMtemp=SPM+SPMtemp;
    d=eig(SPM);
    [V,D]=eig(SPM);
%     [d(1),d(2),d(3)]
%     pause

    %% Analysis for 1st component( d(3) eigen value of 1st comp. )
    pol1=((d(3)-d(1))^2+(d(3)-d(2))^2+(d(2)-d(1))^2)/(2*(d(3)+d(2)+d(1))^2);
    azim1=atan(V(2,3)/V(1,3))*180/pi;
%     incl1=atan(sqrt(V(3,3)/V(1,3)^2+V(2,3)^2))*180/pi;
    [gomi,incl1]=cart2sph(V(1,3),V(2,3),V(3,3));
%     incl1=incl1*180/pi;
    incl1=abs(incl1)*180/pi;

    % azim,inc in map coordinate
    if(V(3,3) >0) 
        if(V(1,3) >0) && (V(2,3) >0) 
        azim1=270-azim1;
        end;
        if(V(1,3) >0) && (V(2,3) <0) 
        azim1=270-azim1;
        end;   
        if(V(1,3) <0) && (V(2,3) >0) 
        azim1=90-azim1;
        end;           
        if(V(1,3) <0) && (V(2,3) <0) 
        azim1=90-azim1;
        end;           
    end;
    if(V(3,3) <0) 
        if(V(1,3) >0) && (V(2,3) >0) 
        azim1=90-azim1;
        end;
        if(V(1,3) >0) && (V(2,3) <0) 
        azim1=90-azim1;
        end;   
        if(V(1,3) <0) && (V(2,3) >0) 
        azim1=270-azim1;
        end;           
        if(V(1,3) <0) && (V(2,3) <0) 
        azim1=270-azim1;
        end;           
    end;

    %% Analysis for 1st component( d(1) eigen value of 3rd comp. )
    pol3=1-(2*d(1)/(d(2)+d(3)));
%     [pol1,pol3,d(1),d(2),d(3)]
%     pause
    
    azim3=atan(V(2,1)/V(1,1))*180/pi;
%     incl3=atan(sqrt(V(3,1)/V(1,1)^2+V(2,1)^2))*180/pi;
    [gomi,incl3]=cart2sph(V(1,1),V(2,1),V(3,1));
%     incl3=incl3*180/pi;
    incl3=abs(incl3)*180/pi;
    
    % azim,inc in map coordinate
    if(V(3,1) >0) 
        if(V(1,1) >0) && (V(2,1) >0) 
        azim3=270-azim3;
        end;
        if(V(1,1) >0) && (V(2,1) <0) 
        azim3=270-azim3;
        end;   
        if(V(1,1) <0) && (V(2,1) >0) 
        azim3=90-azim3;
        end;           
        if(V(1,1) <0) && (V(2,1) <0) 
        azim3=90+azim3;
        end;           
    end;
    if(V(3,1) <0) 
        if(V(1,1) >0) && (V(2,1) >0) 
        azim3=90-azim3;
        end;
        if(V(1,1) >0) && (V(2,1) <0) 
        azim3=90-azim3;
        end;   
        if(V(1,1) <0) && (V(2,1) >0) 
        azim3=270-azim3;
        end;           
        if(V(1,1) <0) && (V(2,1) <0) 
        azim3=270-azim3;
        end;           
    end;        
    
    lamda=[D(3,3),D(2,2),D(1,1)];
    azim_data1(j)=azim1;
    incl_data1(j)=incl1;
    pol_data1(j) =pol1;
    azim_data3(j)=azim3;
    incl_data3(j)=incl3;
    pol_data3(j) =pol3;
    
    
    Data1(j,1)=azim_data1(j);
    Data1(j,2)=incl_data1(j);
    Data1(j,3)=pol_data1(j);
    Data3(j,1)=azim_data3(j);
    Data3(j,2)=incl_data3(j);
    Data3(j,3)=pol_data3(j);
end
    
