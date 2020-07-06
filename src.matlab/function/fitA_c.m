function bestx=fitA_c(time_border,ID,A_c)


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
% for i=1:5
%     for j=1:4
figure
flag=2;

for i=1:5
    subplot(3,2,i)

    for j=1:4
        Y1(:)=A_c(1,i,j,:);
        Y2(:)=A_c(2,i,j,:);
        Y3(:)=A_c(3,i,j,:);

%         loglog(time_border/200,Y1,'.-','MarkerSize',8,'Color',cm(1,:));hold on;
%         loglog(time_border/200,Y2,'.-','MarkerSize',8,'Color',cm(2,:));hold on;
%         loglog(time_border/200,Y3,'.-','MarkerSize',8,'Color',cm(3,:));hold on;
        aveY=(Y1+Y2+Y3)/3;
        obs=aveY(ID);
        tdata=time_border(ID)/200;
        fun = @(x)Acmodel(x,obs,tdata);
        
        x0 = [10^15,2.5,0.003];
        bestx = fminsearch(fun,x0);
        
        N=bestx(1);gamma=bestx(2);b=bestx(3);
        A_c_model(1:numel(tdata))=N*(tdata).^(-gamma).*exp(-b*tdata);
        
        Nb(i,j)=bestx(1);gammab(i,j)=bestx(2);bb(i,j)=bestx(3);
        if (flag==1)
            constb19(i,j)=log(N)-1.9;
            constb22(i,j)=log(N)-2.2;
        elseif (flag==2)
            load const1.9.mat
            const19=constb;clear constb
            MagEst19(i,j)=log(N)-const19(i,j);

            load const2.2.mat
            const22=constb;clear constb 
            MagEst22(i,j)=log(N)-const22(i,j);
        end
        
        loglog(time_border/200,aveY,'-','Color',[0.6 0.6 0.6]);hold on;
        loglog(tdata,obs,'-','Color',cm(i,:));hold on;
        loglog(tdata,A_c_model,'-','LineWidth',3,'Color',cm(i,:));hold on;

        %         ylim([10^0,10^6]);

        clear Y1 Y2 Y3 aveY
    end
%     xlim([8 50])
    xlabel('Time (sec)');
    ylabel('Noise-corrected amplitude');
%     mean(Nb(i,:))
%     mean(gammab(i,:))
%     mean(bb(i,:))
%     mean(constb(i,:))
end

% constb
xlabel('Time (sec)');
ylabel('Noise-corrected amplitude');
% xlim([8 50])
set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18


save MagEst1.9.mat MagEst19
save MagEst2.2.mat MagEst22

% figure;
% for i=1:5
%     plot(i,constb(i,:),'.','MarkerSize',10,'Color',cm(i,:));hold on;
%     plot(i,mean(constb(i,:)),'o','Color',cm(i,:));hold on;
% end
% xlim([0 6]);
% xlabel('Station');
% ylabel('const value');

% save const1.9.mat constb


end

function funfit = Acmodel(x,obs,tdata)
    N=x(1);
    gamma=x(2);
    b=x(3);

    A_c_model(1:numel(tdata))=N*(tdata).^(-gamma).*exp(-b*tdata);
    mdl=A_c_model;
    funfit = sum( (obs-mdl).^2 );
end



