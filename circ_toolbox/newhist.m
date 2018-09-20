%  [avg,sem,light,edges,centers]=newhist(f,start,int,nbins, ...
%					       xstart,lights)

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
%Added lines 85-89 & commented line 90 & 99  [j.schneider@utoronto.ca July 2008]

function [avg,sem,light,edges,centers]=newhist(f,start,int,nbins, ...
					       xstart,lights)
if nargin<6
  lights=[];
end
if nargin<5
  xstart=[];
end
if nargin<4
  nbins=[];

end
global DAILY_HOURS
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
end
hours=DAILY_HOURS;
if isempty(nbins)
  nbins=round(hours);
end
  
x=(0:length(f)-1)*int/60+start;
binsize = hours/nbins;

if isempty(xstart)
  xstart=x(1)-binsize;
end    


binno=1+round(mod(ceil(mod(x-xstart,hours)/hours*nbins)-1,nbins));
xstart=mod(xstart,hours);
edges=(0:nbins)*binsize+xstart;
%normalize edges to start btw 0 and 24
edges=edges-DAILY_HOURS*floor(edges(1)/DAILY_HOURS);
%edges=(xstart:binsize:DAILY_HOURS)';
centers=((edges(2:end)+edges(1:end-1))/2);
%centers=mod(centers,hours);
s=sparse(binno,1,f);
sumsq=sparse(binno,1,f.^2);
c=sparse(binno,1,1);
s=full(s);
c=full(c);
sumsq=full(sumsq);
avg = full(s ./ c);
se = sqrt(((sumsq ./ c) - (avg.^2)));
sem = se ./ sqrt(c);

if ~isempty(lights)
  ls=full(sparse(binno,1,lights));
  lmean=ls ./c;
  light=lmean;
else
  light=[];
end

if (nargout==0)
  % draw the histogram
  % map=colormap;
  rep=get(gca,'NextPlot');
  for i=1:length(centers)
    %u=bar(centers(i),avg(i));
    u=patch(edges([i i+1 i+1 i]),[0 0 avg(i) avg(i)],[1 1 1 1],[0 0 1]);
    hold on
    if ~isempty(light)
    %  i=1+floor(light(i)*size(cmap,1));
     % set(u,'FaceColor',cmap(i,:))
     daycolor=[1 1 1];
     nightcolor=[.5 .5 .5];
     %color=[0 0 1] + light(i)*[1 1 0];
     if light(i)<=mean(light)
         color=nightcolor;
     else
         color=daycolor;
     end
%      color=(1-light(i))*nightcolor + light(i)*daycolor;
     set(u,'FaceColor',color);
     %if light(i)<1
     %  set(u,'EdgeColor',color);
     %end
    end
  end
  % errorbars
  obj=errorbar(centers,avg,zeros(1,length(centers)),sem,'k.');
%  set(obj(2),'marker','none');
  set(gca,'NextPlot',rep);
  halfstep=(edges(2)-edges(1))/2;
  set(gca,'xlim',[edges(1)-halfstep, edges(end)+halfstep]);
  marksperday=4;
  marksize=hours/marksperday;
  firstmark=marksize*floor(xstart/marksize);
  tickmarks=((0:marksperday+1)*marksize+firstmark);
  set(gca,'xtick',tickmarks);
  set(gca,'xticklabel',mod(tickmarks,hours));
end

