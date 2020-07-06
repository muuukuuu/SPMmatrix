function [x,y]=plt_polarization(Azimuth,Take_off,Type)
    
    % translate azimuth of map coordinate to Cartesian coordinates coordinate
    Azimuth=map2cart(Azimuth);
    
    %%% This part is for the case when Take off angle is from upward
    % --------------------------------------------------------------
    if(Take_off<90)
        % move station on upper hemispere to lower hemispher
        Azimuth=Azimuth+180;
        Take_off=Take_off;
    elseif(Take_off>90)
        % move station on upper hemispere to lower hemispher
        Azimuth=Azimuth;
        Take_off=180-Take_off;
    end
    % --------------------------------------------------------------
    d2r   = pi/180;
    %%% Azimuth anti-clockwise relative to x-axis, i.e. Cartesian coordinates coordinate system
    %%% Take_off: angle from upward vertical (microseismic)
    %%% Type    : Polarization 1:Compression, -1:dilatation

    theta   = Azimuth*d2r;
    rho     = sqrt(2)*sin((Take_off)/2*d2r);
    
    [x,y] = pol2cart(theta,rho);
    
   if Type == 1  %Push (Positive,+)
           plot(x,y,'ko','MarkerFaceColor','k','MarkerSize',8);
   elseif Type == -1  %Pull (Negative, -)
           plot(x,y,'ko','MarkerFaceColor','w','MarkerSize',8);
   else
           plot(x,y,'k^','MarkerSize',8);
   end

   function [azimuth]=map2cart(input)
       azimuth=-input+180/2;
       