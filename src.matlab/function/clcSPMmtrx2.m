function [Data1,Data3]=clcSPMmtrx2(fft_N,wave)

% number of points when FFT

wave_x=wave(1,:);
wave_y=wave(2,:);
wave_z=wave(3,:);

 % Calculate power/cross spectra
X=fft(wave_x,fft_N);
Y=fft(wave_y,fft_N);
Z=fft(wave_z,fft_N);

Sxx=X.*conj(X);Syy=Y.*conj(Y);Szz=Z.*conj(Z);
Sxy=X.*conj(Y);Sxz=X.*conj(Z);Syx=Y.*conj(X);
Syz=Y.*conj(Z);Szx=Z.*conj(X);Szy=Z.*conj(Y);

SPMtemp=[0 0 0;0 0 0;0 0 0];

for j=1:fft_N
    
    SPM =[      Sxx(j)  real(Sxy(j))     real(Sxz(j)); 
           real(Syx(j))      Syy(j)      real(Syz(j));
           real(Szx(j)) real(Szy(j))          Szz(j)];
       
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
    [gomi,incl1]=cart2sph(V(1,3),V(2,3),V(3,3));
    incl1=incl1*180/pi;
%     incl1=atan(sqrt(V(3,3)/V(1,3)^2+V(2,3)^2))*180/pi;
    
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
        incl1=incl1*(-1);
    end;
    
    %% Analysis for 1st component( d(1) eigen value of 3rd comp. )
    pol3=1-(2*d(1)/(d(2)+d(3)));
%     [pol1,pol3,d(1),d(2),d(3)]
%     pause
    
    azim3=atan(V(2,1)/V(1,1))*180/pi;
    [gomi,incl3]=cart2sph(V(1,1),V(2,1),V(3,1));
    incl3=incl3*180/pi;
%     incl3=atan(sqrt(V(3,1)/V(1,1)^2+V(2,1)^2))*180/pi;
    
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
        incl3=incl3*(-1);
    end;        
    
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
    
