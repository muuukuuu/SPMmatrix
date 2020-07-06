function [Rp, Rs] = cal_RpRs(station, source, MT)

RadG    = cal_RpRsG(station, source);

% �^����ꂽ���[�����g�e���\�������ɑ΂���Radiation pattern���v�Z
Rp = zeros(3,1);
Rs = zeros(3,1);       
for i = 1:3 % Moment tensor 9�����ɑ΂���loop 1
    for j = 1:3 % Moment tensor 9�����ɑ΂���loop 2
        for n = 1:3 % �ψ�3�����ɑ΂���loop
            Rp(n) = Rp(n) + RadG(i,j).p(n)*MT(i,j);
            Rs(n) = Rs(n) + RadG(i,j).s(n)*MT(i,j);
        end
    end
end

function Rad  = cal_RpRsG(station, source)
% ���[�����g�e���\���e�����ɑ΂���C
%�@Radiation pattern�W���̃O���[���֐����v�Z
%�ifrom Aki and Richards 4.29�j

% station�̕����]���̌v�Z
r   = norm(station - source);
gam = (station - source) ./ r;

% Radiation pattern�W��
for p=1:3
    for q = 1:3
        for n = 1:3
            Rad(p,q).p(n) = gam(n)*gam(p)*gam(q);
            Rad(p,q).s(n) = -(gam(n)*gam(p) - (n==p))*gam(q);            
        end
    end
end