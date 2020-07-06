function amp_const_factor = cal_amp_const_factor(station, source, rho, v)
% 観測点-震源の相対位置ベクトル
station_rel = station-source; 
 % 震源-観測点距離
r = norm(station_rel);
amp_const_factor.p = 1/(4*pi*rho*(v.p^3)*r);
amp_const_factor.s = 1/(4*pi*rho*(v.s^3)*r);