function [cf,cf_doa,cf2,cf_azi,cf_both]=calCF_azi(hoge,hoge2,cl,DOAinc,DOAazi)
% function prob=calCF(estimate,Cl)

%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 

obsDOA=DOAinc;
obsAZI=DOAazi;

if(obsAZI<0)
    obsAZI=obsAZI+360;
end
if(obsAZI>180)
    obsAZI=obsAZI-180;
end

obsUnc=10;

%% ---[estimated DOA --> probability of known DOA]--- 
% pd=makedist('Normal','mu',obsDOA,'sigma',obsUnc);
pd=makedist('HalfNormal','mu',0,'sigma',obsUnc);
pd.sigma;
pd.var;
pd.mean;
pd.std;

estDOA=[0:1:90];
y  = pdf(pd,estDOA );


%% ---[estimated Azi --> probability of known DOA]--- 
% pd=makedist('Normal','mu',obsDOA,'sigma',obsUnc);
pd=makedist('HalfNormal','mu',0,'sigma',obsUnc*2);
pd.sigma;
pd.var;
pd.mean;
pd.std;

estAzi=[0:1:180];
y2  = pdf(pd,estAzi );


% figure
% subplot 221
% plot(estDOA,y,'Color',cm(1,:));hold on;
% xlim([0 90]);
% 
% subplot 222
% plot(estDOA,y/max(y),'Color',cm(1,:));hold on;
% xlim([0 90]);
% xlabel('Difference from empirical DOA (deg.)')
% ylabel('evaluation function for DOA')
% 
% subplot 223
% plot(estAzi,y2,'Color',cm(2,:));hold on;
% xlim([0 180]);
% 
% subplot 224
% plot(estAzi,y2/max(y2),'Color',cm(2,:));hold on;
% xlim([0 180]);
% xlabel('Difference from empirical DOA_Azi (deg.)')
% ylabel('evaluation function for DOA_Azi')


% ---[Estimated DOA_inc]---
estDOA=hoge;
diff=abs(estDOA-obsDOA);
prob=pdf(pd,diff);
prob=prob/max(prob);


% ---[Estimated DOA_azi]---
estAzi=hoge2;
ID=find(estAzi<0);
estAzi(ID)=estAzi(ID)+360;
clear ID
ID=find(estAzi>180);
estAzi(ID)=estAzi(ID)-180;

diff=abs(estAzi-obsAZI);
prob_azi=pdf(pd,diff);
prob_azi=prob_azi/max(prob_azi);




% figure
% subplot 221
% histogram(estDOA);
% xlabel('Estimated DOA inc. (deg.)')
% xlim([0 90]);
% 
% subplot 222
% histogram(diff);
% xlabel('diff angle (deg.)')
% xlim([0 90]);
% 
% 
% subplot 223
% plot(diff,prob,'.','Color',cm(1,:));hold on;
% xlim([0 90]);
% xlabel('diff angle (deg.)')
% ylabel('CF DOA inc.')
% 
% subplot 224
% histogram(prob);
% xlabel('CF DOA inc.')
% xlabel('frequency')



% figure
% subplot 311
% plot(cl);
% 
% subplot 312
% plot(hoge,'Color',cm(1,:));hold on;
% plot(diff,'Color',cm(2,:));hold on;
% 
% % yyaxis right
% % plot(prob,'Color',cm(3,:));hold on;
% 
% subplot 313
% plot(prob,'Color',cm(3,:));hold on;


%% ---[Calc Characteristic function]---
cf_doa=prob;
cf=cf_doa.*cl;

cf_azi=prob_azi;
cf2=cf_azi.*cl;

cf_both=(cf_azi.*cl)+(cf_doa.*cl);
cf_both=cf_both./2;


% close all
% prob=1-stdscr/5;
% prob = 1-cdf(pd,diff);

% figure
% subplot 211
% histogram(diff);hold on;
% histogram(diff2);hold on;
% xlabel('Angle (deg.)');
% legend('Diff. agle','DOA inc')
% 
% % prob = cdf(pd,diff);
% 
% subplot 212
% histogram(prob)
% set(gca,'Yscale','log');
% xlabel('Probability');
% ylabel('Frequency');





%% ---[Characteristc function]--- 
% cl=0.9;
% alph=0.7;
% for j=1:10
%     alph=j*0.1;
%     for i=1:numel(cl)
%         ch(i,j)=sqrt( alph*cl(i)^2+(1-alph)*prob(i)^2 );
%     %     plot(estDOA,Ch);hold on;
%     end
% end
% xlabel('Differential angle (deg.)');

