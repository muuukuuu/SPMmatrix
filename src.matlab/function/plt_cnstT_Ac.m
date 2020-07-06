function plt_cnstT_Ac(time_border,wave_in,A_c)

dlength=numel(wave_in(:,1));
X=[1:1:dlength];
%----------[Color map]------------------------------------------------------------
 cm(1,1:3)=  [     0    0.4470    0.7410];
 cm(2,1:3)=  [0.8500    0.3250    0.0980];
 cm(3,1:3)=  [0.9290    0.6940    0.1250];
 cm(4,1:3)=  [0.4940    0.1840    0.5560];
 cm(5,1:3)=  [0.4660    0.6740    0.1880];
 cm(6,1:3)=  [0.3010    0.7450    0.9330];
 cm(7,1:3)=  [0.6350    0.0780    0.1840];
 
% ---[Fig Linearlity and Ellipticity]---------------------------------------------------  
% figure;
% hoge=2;
% log(time_border(1:10)/200);
display('Twice of Swave travel time')
T=6;
M=1.9;
M=2.2;

for i=1:5
        for j=1:4
            Y1(:)=A_c(1,i,j,:);
            Y2(:)=A_c(2,i,j,:);
            Y3(:)=A_c(3,i,j,:);
            size(Y1);

            aveY=(Y1+Y2+Y3)/3;
            t1=749.585-744+T;
            t2=3466.905-3462+T;
            ID=knnsearch(time_border'/200,t2);
           
%             loglog(time_border(ID)/200,aveY(ID),'ok','MarkerFaceColor',cm(i,:));hold on;
%             ylim([10^0,10^6]);
            semilogx(time_border(ID)/200,M-log(aveY(ID)),'ok','MarkerFaceColor',cm(i,:));hold on;


            clear Y1 Y2 Y3 ave    
        end
end
xlabel('Time (sec)');
ylabel('Noise-corrected amplitude');
% legend('G67','','','',...
%         'G23','','','',...
%         'G29','','','',...
%         'G19','','','',...
%         'G24')
set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


