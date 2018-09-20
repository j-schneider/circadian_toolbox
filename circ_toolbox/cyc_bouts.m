function cyc_bouts(file,minpulses,ipimax)

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
total=[];
count=0;
a=cyc_read(file);
first=1;
last=6;
step=1;
bins=first:step:last;
xlim=[first-step/2, last+step/2];
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
    end
    figure(figno)
    clf
  end
  subplot(4,8,1+mod(i-1,32))
  %figure(i)
  bout=s(:,i);
  bout=full(bout(bout>0));
  %hist(bout,bins);
  next = harp_hist(bout,bins)./length(bout);
  bar(bins,next);
  count=count+1;
  if isempty(total)
    total=next;
  else
    total=total+next;
  end
  set(gca,'xlim',xlim);
end
figfonts('FontSize',7);
suptitle(sprintf('%s page %d',file,figno));
figure(figno+1)
total=total./count*100;
bar(bins,total);
title(sprintf('%s (mean cpp density per bout)',file))
