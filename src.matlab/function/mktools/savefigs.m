function savefigs()
prompt = 'Enter filename ';
str = input(prompt,'s');

set(gcf,'Position',[159   0   860*0.9   771*0.9]); % By Hotta Dec.18

% print -painters -depsc output.eps
filename=[str, '.png']
% print -painters -dpng filename
print(str,'-dpng','-r300');

filename=[str, '.fig']
saveas(gcf,filename);

% filename=[str, '.fig']
% print -painters -fig filename
% savefig('output')

