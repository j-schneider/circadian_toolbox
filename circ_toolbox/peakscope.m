% PEAKSCOPE Find peaks in average signal
% [pp,px]=peakscope(f,wells,start,int,filter_hours,lights,opt...)
%
% Peakscope averages a signal over several 24-hour periods (or
% as set by the global variable DAILY_HOURS) using the newhist
% function. This is sort of like what an osciloscope would do. 
% It finds the peaks in the averaged signal and returns a list.
% 
% See also: Twopeakscope, newhist
%
% opt: 1/0          do/don't print
%      'realtime'   use realtime instead of lights on 
% 

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
function [pp,px]=peakscope(f,wells,start,int,filter_hours,lights, ...
			   varargin)
global DAILY_HOURS
realtime=0;
threshold=0.26; % only peaks at 20% and higher are printed
doplot=1;
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
end
if isempty(wells) | wells==0
  wells=1:size(f,2);
end
f=f(:,wells);
if size(f,2) > 0
  % average first, then filter
  f=mean(f,2);
end
if (nargin<7)
  doplot=1;
else
  for i=1:length(varargin)
    par=varargin{i};
    if isnumeric(par)
      doplot=par;
    else
      switch(par)
       case 'realtime'
	realtime=1;
       otherwise
	error('wrong argument');
      end
    end
  end
end
if (nargin<6)
  lights=[];
end
if (nargin<5)
  filter_hours=0;
end
if filter_hours>0
  f=butt_filter(f,round(filter_hours*60/int));
end
firstx=start;
if ~isempty(lights)
  [on,off]=analights(start+(0:size(f,1)-1)*int/60,lights);
  if ~isempty(on) & (realtime==0)
    firstx=on(1);
  end
end
[avg,sem,light,edges,centers]=newhist(f,start,int,round(DAILY_HOURS*60/int),firstx,lights);
%e=[edges,edges(2:end)+edges(end)];
%%%%x=[centers,(centers+24)];
%x=(e(2:end)+e(1:end-1))/2;
%%%%y=[avg;avg];
add=2;
x=[centers,centers(1:add)+24];
y=[avg;avg(1:add)];
edges=[edges,edges(2:add+1)+24];
%whos x y
if ~isempty(lights)
  light=[light;light(1:add)];
  if (realtime==0)
    x=x-firstx;
    edges=edges-firstx;
  end
end
[pp,px]=findpeaks(y);
pp=pp';
px=x(px);
if doplot
  plot(x,y,'-');
  set(gca,'xlim',x([1,end]));
  ymx=max(y);
  ymi=min(y);
  ysp=max(ymx-ymi,1);
  set(gca,'ylim',[ymi-0.1*ysp ymx+0.1*ysp]);
  rep=get(gca,'NextPlot');
  hold on
  if ~isempty(lights)
    yl=get(gca,'ylim');
    for i=1:length(x)
      daycolor=[1 1 .9];
      nightcolor=[.8 .85 1];
      color=(1-light(i))*nightcolor + light(i)*daycolor;
      obj=patch([edges(i) edges(i+1) edges(i+1) edges(i)], ...
		[yl(1) yl(1) yl(2) yl(2)],...
		[-2 -2 -2 -2],...
		color);
      set(obj,'LineStyle','none');
    end
  end
  maxpeak=max(pp);
  %plot(px,pp,'o')
  for i=1:length(pp)
    if pp(i)>=maxpeak*threshold
      % peak is significant, plot it
      plot(px(i),pp(i),'o');
      u=text(px(i),pp(i),sprintf(' %.1f(%.0f%%)',mod(px(i),DAILY_HOURS),100*pp(i)/max(pp)));
    end
  end
  mod24lbl;
  set(gca,'NextPlot',rep);
end
[tmp,order]=sort(pp);
order=order(end:-1:1);
pp=pp(order);
px=px(order);

