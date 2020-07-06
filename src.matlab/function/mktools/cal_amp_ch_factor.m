function amp_ch_factor = cal_amp_ch_factor(station, source, rho, v, MT_enu)
% Rp/4�΃�v^3r���v�Z����v���O����

[Rp, Rs] = cal_RpRs(station, source, MT_enu); % �C�ӂ̃��[�����g�e���\���ɑ΂���radiation pattern
amp_const_factor = cal_amp_const_factor(station, source, rho, v);
amp_ch_factor.p  = Rp*amp_const_factor.p; % P�g�U��������
amp_ch_factor.s  = Rs*amp_const_factor.s; % S�g�U��������


function amp_const_factor = cal_amp_const_factor(station, source, rho, v)
station_rel = station-source; % �ϑ��_-�k���̑��Έʒu�x�N�g��
r = norm(station_rel); % �k��-�ϑ��_����
amp_const_factor.p = 1/(4*pi*rho*(v.p^3)*r);
amp_const_factor.s = 1/(4*pi*rho*(v.s^3)*r);
