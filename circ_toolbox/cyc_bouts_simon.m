function cyc_bouts_simon(file,minpulses,ipimax,...
			 where,xlab,ylab,ytick)

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
 end
  bout=s(:,i);
  bout=full(bout(bout>0));
  next0 = histc(bout,edges);
  next0 = next0(1:end-1);
  next=next0./length(bout);
  count=count+1;
  if isempty(total)
    total0=next0;
    total=next;
  else
    total=total+next;
    total0=total0+next0;
  end
end



total=total *100 ./ count;

subplot(4,6,where), bar(bins,total,'k')

set(gca, 'XLim', [1 6], 'XTick',[0 2 3 4 5], 'YLim',[0 60], 'YTick',ytick);

xlabel(xlab)
ylabel(ylab)

drawnow
