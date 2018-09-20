function cyc_bouts3(file,minpulses,ipimax)

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
edges=[-inf 0:.5:10 +inf ];
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
allbouts=[];
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
  allbouts=[allbouts;bout];
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
    all=next;
  else
    total=total+next;
    total0=total0+next0;
  end
end
figfonts('FontSize',7);
suptitle(sprintf('%s page %d',file,figno));
colormap('default')
if doprint
  orient landscape
  print
end
figure(figno+1)
clf
total=total ./ count;
bar(bins,total);
set(gca,'xlim',xlim,'xtick',xtick); 

title(sprintf('%s (mean cpp density per bout)',file))
ylabel('%')
if doprint
  colormap(white)
  print
end
figure(figno+2)
clf
bar(bins,total0);
set(gca,'xlim',xlim,'xtick',xtick);
title(sprintf('%s (total cpp)',file))
ylabel('total counts')
[h,p,ksstat,cv]=kstest(allbouts)
xlabel(sprintf('K-S stat=%g cutoff=%g reject=%g',ksstat,cv,h));
if doprint
  colormap(white)
  print
end

