function [avg,sem]=fly_hist(f,start,int,p)
% FLY_HIST
% [avg,sem]=fly_hist(f,start,int)
% or [avg,sem]=fly_hist(f,start,par)
% par: parameter bundle. See help dam_hist_par

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<4
  if isstruct(int)
    p=int;
    int=p.int;
  else
    p=dam_hist_par;
  end
end
p
hours=p.hours;
hours_per_bin=p.barSize/60;

clf;
%f=o.data(:,wells(i));
nbins=round(p.hours * 60/(p.barSize));
%[f,x]=dam_cleanup(f,start,int,1);
start
x=(0:length(f)-1)*60/int+start;
xfirst=min(find(x>(p.skipDays*hours)));
xlast=xfirst-1+nbins*floor((length(x)-xfirst+1)/nbins);
f=f(xfirst:xlast);
x=x(xfirst:xlast);
%fprintf('%d full days',length(f)/nbins);
n=length(f);
binno=floor((60/p.barSize)*mod(x-p.firstHour,hours))+1
binhour=(0:hours_per_bin:hours-hours_per_bin)+p.firstHour;
binhour=mod(binhour,1)*60+100*floor(mod(binhour,24));
if p.lightsOff>p.lightsOn
  bindark=(binhour > p.lightsOn) & (binhour <= p.lightsOff);
else
  bindark=~((binhour > p.lightsOff) & (binhour <= p.lightsOn));
end
%biny=1+floor(((1:length(binno))-1)/48);
%sparse=full(sparse(binno,biny,f));
s=full(sparse(binno,1,f));
c=full(sparse(binno,1,ones(size(f,1),1)));
avg=s ./ c;
sumsq=full(sparse(binno,1,f.^2));
se=sqrt(((sumsq ./ c) - (avg.^2)));
sem=se ./ sqrt(c);
[s,c,avg,sumsq,se,sem];
for i=1:length(s)
  a=[i-1 i i i-1];
  b=[ 0 0 avg(i) avg(i)];
  
  patch(a,b,bindark(i));
end
if (p.plotSEM)
  hold on
  plot((1:length(s))-0.5,avg+sem,'.');
end
set(gca,'xtick',1:8:length(binhour),'xticklabel',binhour(1:8: ...
						  length(binhour)));
set(gca,'tickdir','out');
title(sprintf('%s (days=%d)',o.names{i},length(f)/nbins));
xlabel('hours');ylabel('mean activity');
