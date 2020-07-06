function MT_enu = faultpar2MT_enu(strike_deg, dip_deg, rake_deg)
% Stein and Wysesson; An Introduction to Seismology earthquakes
% and earth structure, p.218 eq.(1) and (2)

[n, d] = cal_nd_enuvec_from_faultpar(strike_deg, dip_deg, rake_deg);
MT_enu = nd2MT(n, d);

function MT = nd2MT(n, d)
% Stein and Wysesson; An Introduction to Seismology earthquakes
% and earth structure, p.243 eq.(4)

MT = zeros(3,3);
for i =1:3
    for j = 1:3
        MT(i,j) = n(i)*d(j)+n(j)*d(i);
    end
end


