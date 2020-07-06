function fig_set_aspect(h,val_height,val_aspect)
% fig_set_aspect v2.0
% v2.0 : 2011.03.03
%        remove ax accept ratio setting
% ----------------
% h : figure handle
% val_heit in cm
% ----------------

set(h,'PaperUnits','centimeters');
set(h,'PaperPosition',val_height*[0 0 val_aspect 1]);