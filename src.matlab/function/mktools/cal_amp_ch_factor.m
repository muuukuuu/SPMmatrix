function amp_ch_factor = cal_amp_ch_factor(station, source, rho, v, MT_enu)
% Rp/4πρv^3rを計算するプログラム

[Rp, Rs] = cal_RpRs(station, source, MT_enu); % 任意のモーメントテンソルに対するradiation pattern
amp_const_factor = cal_amp_const_factor(station, source, rho, v);
amp_ch_factor.p  = Rp*amp_const_factor.p; % P波振幅増幅率
amp_ch_factor.s  = Rs*amp_const_factor.s; % S波振幅増幅率


function amp_const_factor = cal_amp_const_factor(station, source, rho, v)
station_rel = station-source; % 観測点-震源の相対位置ベクトル
r = norm(station_rel); % 震源-観測点距離
amp_const_factor.p = 1/(4*pi*rho*(v.p^3)*r);
amp_const_factor.s = 1/(4*pi*rho*(v.s^3)*r);
