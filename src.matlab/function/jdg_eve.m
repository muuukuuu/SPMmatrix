function [Prank,Srank]=jdg_eve(ZDp,ZDs,ZDinc,time_border)

Psigma=std(ZDp);
Ssigma=std(ZDs);
Incsigma=std(ZDinc);

%% Rank Pick 
[Prank,Srank]=rnkPck(ZDp,ZDs,time_border,Psigma,Ssigma);
Incrank=rnkInc(ZDinc,time_border,Incsigma);


%% Linearity, Ellipticity
for i=1:numel(time_border)
    for j=1:3
        if (Prank(i)==3)
            if (Srank(i)==j )
                Prank(i)=Prank(i)*1+j;
            end
        elseif (Prank(i)==2)
            if (Srank(i)==j)
                Prank(i)=Prank(i)*1+j;
            end
        elseif (Prank(i)==1)
            if (Srank(i)==j)
                Prank(i)=Prank(i)*1+j;
            end
        end
    end
end


%% +Vertical arrival for Prank
for i=1:numel(time_border)    
    for j=1:3
        if (Incrank(i)==3)
            Prank(i)=Prank(i)*1+j;
        elseif (Incrank(i)==2)
            Prank(i)=Prank(i)*1+j;
        elseif (Incrank(i)==1)
            Prank(i)=Prank(i)*1+j;
        end
    end
end

%% perpendicularity of Direction of arrival
% for j=3:-1:1
%     IDP=find(Prank==3*10+j);
%     if(numel(IDP)~=0)
%         for k=3:-1:1 % Prank loop
%             IDS=find(Srank==k);
%             if(numel(IDS)~=0)
%                 for l=1:numel(IDP)     % Pcandidate loop
%                     for m=1:numel(IDS) % Scandidate loop
%                         if (IDP(l)<IDS(m))
%                             dangle(l,m)=abs( eig1Azi(IDP(l))-eig3Azi(IDS(m)) );
%                             if (dangle(l,m)<=10)
%                                 Srank(IDS(m))=Srank(IDS(m))+3;                             
%                             elseif (10<dangle(l,m) && dangle(l,m)<=20)
%                                 Srank(IDS(m))=Srank(IDS(m))+2;
%                             elseif (20<dangle(l,m) && dangle(l,m)<=30)
%                                 Srank(IDS(m))=Srank(IDS(m))+1;
%                             end
% %                             if (temp_dangle>dangle(l,m))
% %                                 temp_dangle=dangle(l,m);                               
% %                             end
%                         end                        
%                     end
%                 end
%             end
%         end
%     end
% %     min(dangle)
% end




function [Prank,Srank]=rnkPck(ZDp,ZDs,time_border,Psigma,Ssigma)
for i=1:numel(time_border)
    % Ranking P
    if (ZDp(i)>=Psigma*1)
        if (ZDp(i)>=Psigma*3)
            Prank(i,1)=3; % 99% reliability
        elseif (ZDp(i)>=Psigma*2 && ZDp(i)<Psigma*3)
            Prank(i,1)=2; % 95% reliability
        else
            Prank(i,1)=1; % 86% reliability
        end
    else
        Prank(i,1)=0;
    end

    % Ranking S
    if (ZDs(i)>=Ssigma*1)
        if (ZDs(i)>=Ssigma*3)
            Srank(i,1)=3; % 99% reliability
        elseif (ZDs(i)>=Ssigma*2 && ZDs(i)<Ssigma*3)
            Srank(i,1)=2; % 95% reliability
        else
            Srank(i,1)=1; % 86% reliability
        end
    else
        Srank(i,1)=0;
    end
end

function [Incrank]=rnkInc(ZDinc,time_border,Incsigma)
for i=1:numel(time_border)
    if (ZDinc(i)>=Incsigma*1)
        if (ZDinc(i)>=Incsigma*3)
            Incrank(i,1)=3; % 99% reliability
        elseif (ZDinc(i)>=Incsigma*2 && ZDinc(i)<Incsigma*3)
            Incrank(i,1)=2; % 95% reliability
        else
            Incrank(i,1)=1; % 86% reliability
        end
    else
        Incrank(i,1)=0;
    end
end