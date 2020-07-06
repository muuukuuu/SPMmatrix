function [Rp, Rs] = cal_RpRs(station, source, MT)

RadG    = cal_RpRsG(station, source);

% 与えられたモーメントテンソル成分に対するRadiation patternを計算
Rp = zeros(3,1);
Rs = zeros(3,1);       
for i = 1:3 % Moment tensor 9成分に対するloop 1
    for j = 1:3 % Moment tensor 9成分に対するloop 2
        for n = 1:3 % 変位3成分に対するloop
            Rp(n) = Rp(n) + RadG(i,j).p(n)*MT(i,j);
            Rs(n) = Rs(n) + RadG(i,j).s(n)*MT(i,j);
        end
    end
end

function Rad  = cal_RpRsG(station, source)
% モーメントテンソル各成分に対する，
%　Radiation pattern係数のグリーン関数を計算
%（from Aki and Richards 4.29）

% stationの方向余弦の計算
r   = norm(station - source);
gam = (station - source) ./ r;

% Radiation pattern係数
for p=1:3
    for q = 1:3
        for n = 1:3
            Rad(p,q).p(n) = gam(n)*gam(p)*gam(q);
            Rad(p,q).s(n) = -(gam(n)*gam(p) - (n==p))*gam(q);            
        end
    end
end