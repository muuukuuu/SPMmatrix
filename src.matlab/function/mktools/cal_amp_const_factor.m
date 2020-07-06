function amp_const_factor = cal_amp_const_factor(station, source, rho, v)
% �ϑ��_-�k���̑��Έʒu�x�N�g��
station_rel = station-source; 
 % �k��-�ϑ��_����
r = norm(station_rel);
amp_const_factor.p = 1/(4*pi*rho*(v.p^3)*r);
amp_const_factor.s = 1/(4*pi*rho*(v.s^3)*r);