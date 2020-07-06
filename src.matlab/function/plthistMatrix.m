function plthistMatrix(mtrx,time)

figure;

subplot(3,3,1)
histogram(mtrx(1,1,time,:));
xlabel(['Sxx']);ylabel(['frequency']);

subplot(3,3,2)
histogram(mtrx(1,2,time,:));
xlabel(['Sxy']);ylabel(['frequency']);

subplot(3,3,3)
histogram(mtrx(1,3,time,:));
xlabel(['Sxz']);ylabel(['frequency']);



subplot(3,3,4)
histogram(mtrx(2,1,time,:));
xlabel(['Syx']);ylabel(['frequency']);

subplot(3,3,5)
histogram(mtrx(2,2,time,:));
xlabel(['Syy']);ylabel(['frequency']);

subplot(3,3,6)
histogram(mtrx(2,3,time,:));
xlabel(['Syz']);ylabel(['frequency']);



subplot(3,3,7)
histogram(mtrx(3,1,time,:));
xlabel(['Szx']);ylabel(['frequency']);

subplot(3,3,8)
histogram(mtrx(3,2,time,:));
xlabel(['Szy']);ylabel(['frequency']);

subplot(3,3,9)
histogram(mtrx(3,3,time,:));
xlabel(['Szz']);ylabel(['frequency']);


set(gcf,'Position',[159   0   860*0.9   771*0.9]) % By Hotta Dec.18
