function cyc_bouts2(file,minpulses,ipimax)

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University.             %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is not removed.   %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global doprint
total=[];
total0=[];
count=0;
a=cyc_read(file);
edges=[-inf 2 3 4 5 +inf ];
first=edges(2);
last=edges(end-1);
step=1;
xlim=[first-step, last+step];
fakeedges=[xlim(1),edges(2:end-1),xlim(2)];
bins=(fakeedges(2:end)+fakeedges(1:end-1))/2;
xtick=edges(2:end-1);
ipi=a(:,3);
cyc=a(:,5);
good=(ipi>0 & ipi < ipimax);
boutno=(cumsum(diff(good)==-1)+1).*good(2:end);
cyc_good=cyc(2:end);
cyc_good=cyc_good(boutno>0);
boutno=boutno(boutno>0);
s=sparse(1:length(cyc_good),boutno,cyc_good);
len_bouts=sum(spones(s));
s=s(:,find(len_bouts>=minpulses));
for i=1:size(s,2)
  if (mod(i,32)==1)
    figno=1+floor(i/32);
    if (figno>1)
      figfonts('FontSize',7);
      suptitle(sprintf('%s page %d',file,figno-1));
      colormap('default')
      if doprint
	orient landscape
	print
      end
    end
    figure(figno)
    clf
  end
  subplot(4,8,1+mod(i-1,32))
  %figure(i)
  bout=s(:,i);
  bout=full(bout(bout>0));
  %hist(bout,bins);
  next0 = histc(bout,edges);
  next0 = next0(1:end-1);
  next=next0./length(bout);
  bar(bins,next);
  set(gca,'xlim',xlim,'xtick',xtick);
  count=count+1;
  if isempty(total)
    total0=next0;
    total=next;
  else
    total=total+next;
    total0=total0+next0;
  end
end


% ------------------------------

figfonts('FontSize',7);


suptitle(sprintf('%s page %d',file,figno));
colormap('default')
if doprint
 
  orient landscape
  print
end
figure(figno+1)
clf
total=total *100 ./ count;
bar(bins,total);
hold on
yl=get(gca,'ylim');
xl=get(gca,'xlim');
delta=(yl(2)-yl(1))*(1/20);
epsilon=(xl(2)-xl(1))*(1/40);
for i=1:length(total)
  text(bins(i)-epsilon,total(i)+delta,sprintf('%0.1f',total(i)))
end
set(gca,'xlim',xlim,'xtick',xtick); 




title(sprintf('%s (mean cpp density per bout)',file))
xlabel('CPP CATEGORIES')
ylabel('PERCENT')
if doprint 
  orient portrait
  colormap(white)
  print('-depsc',[file,'.eps'])
  if doprint==1
    print
  end
end
figure(figno+2)
clf
bar(bins,total0);
set(gca,'xlim',xlim,'xtick',xtick);
title(sprintf('%s (total cpp)',file))
ylabel('total counts')
if doprint
  colormap(white)
  print
end
