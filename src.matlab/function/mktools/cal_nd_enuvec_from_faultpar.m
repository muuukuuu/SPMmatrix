function [n, d] = cal_nd_enuvec_from_faultpar(strike_deg, dip_deg, rake_deg)
% n(1) =  sind(dip_deg)*cosd(strike_deg);
% n(2) = -sind(dip_deg)*sind(strike_deg);
% n(3) =  cosd(dip_deg);
% 
% d(1) =  cosd(rake_deg)*sind(strike_deg) - sind(rake_deg)*cosd(dip_deg)*cosd(strike_deg);
% d(2) =  cosd(rake_deg)*cosd(strike_deg) + sind(rake_deg)*cosd(dip_deg)*sind(strike_deg);
% d(3) =  sind(rake_deg)*sind(dip_deg);

% Added by Muku-----
    % slip vector in geographic coordinate (NorthWestUp: NWU)
    % Equations from Sten_Wynession pp218     
    n(1) = -sind(dip_deg)*sind(strike_deg);
    n(2) = -sind(dip_deg)*cosd(strike_deg);
    n(3) =  cosd(dip_deg);

    % slip vector in ENU (EastNorthUp) coodinate
    % by rotation matrix for z-axis
    t=-pi/2;
    Rz = [cos(t) sin(t) 0;...
          -sin(t) cos(t) 0;...
          0 0 1];
    n=Rz*n';

    d(1) =  cosd(rake_deg)*cosd(strike_deg) + sind(rake_deg)*cosd(dip_deg)*sind(strike_deg);
    d(2) = -cosd(rake_deg)*sind(strike_deg) + sind(rake_deg)*cosd(dip_deg)*cosd(strike_deg);
    d(3) =  sind(rake_deg)*sind(dip_deg);
    d=Rz*d';
% End added muku