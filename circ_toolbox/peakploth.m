function [hour,height]=peakploth(ff,start,int,lights,hours)
% PEAKPLOTH 
% [hour,height]=peakploth(ff,start,int,lights,hours)
% needs to be documented or removed


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
global DAILY_HOURS
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
end

tickstep=DAILY_HOURS;
labelstep=1;
if nargin<2
  start=0;
end
if nargin<3
  int=60;
end
if nargin<5
  hours=0;
end
if nargin<6
  cutoff=0.5;
end
showpeaks=1;

f=mean(ff,2);
rawf=f;
if (hours>0)
  f=butt_filter(f,hours*60/int);
end
if int==0 & length(start)>1
  x=start;
  start=x(1);
else
  x=(0:(size(f,1)-1)).*int/60+start;
end

if nargin<4
  lights=[];
end

hold on
% find stderr of mean when more than one
m=[floor(min(x)),ceil(max(x))];
ticks=(m(1)+(tickstep-1)-mod(m(1)-1,tickstep)):tickstep:m(2);
labels=cell(1,length(ticks));
for i=1:labelstep:length(ticks)
  labels{i}=ticks(i);
end
%for i=1:length(ticks)
% if mod(ticks(i),24)==0
%   labels{i}=ticks(i)/24;
% end
%end

currlim=get(gca,'ylim');
ylim=[min(f),max(f)];
if ylim(1)>currlim(1)
  ylim(1)=currlim(1)
end
if ylim(2)<currlim(2)
  ylim(2)=currlim(2)
end

%if ylim(1)>=0
%  ylim(1)=-10;
%end
%if (ylim(2)<200)
%  ylim(2)=200;
%end
if length(lights)>0
  dlights=diff([lights;-1]);
  changes=find(dlights);
  last=m(1);
  for i=1:length(changes)
    xx=changes(i);
    if lights(xx)==0
      zz=fill([last x(xx) x(xx) last],...
	      [ylim(1),ylim(1),ylim(2),ylim(2)],...
	      [.9 .9 .9]);
      set(zz,'LineStyle','none')
      
    end
    last=x(xx);
  end
end

if size(ff,2)>1
  k=size(ff,2);
  s=std(ff,0,2)/sqrt(k);
  n=length(s);
  %plot(x,f+s,'--');
  %plot(x,f-s,'--');
  fill(x([1:n,n:-1:1]),[f'+s',reverse(f'-s')],.8*[ .9 1 .9], ...
     'linestyle',':');
end

%plot(x,f);

%lights_on=min(x(find(u.lights>0)));

[avg,sem,light,edges,centers]=newhist(f,x(1),x(2)-x(1),...
				      DAILY_HOURS*(x(2)-x(1)), ...
				      lights);

set(gca,'xtick',ticks);
set(gca,'xlim',m);
set(gca,'xticklabel',labels);
xlabel('time (h)');
ylabel('activity');
grid on
%ylim=get(gca,'ylim');
set(gca,'ylim',ylim);
set(gca,'layer','top');
if showpeaks
  [pp,px]=findpeaks(f);
  hold on;
  hour=x(px);
  hour=mod(x,DAILY_HOURS);
  height=pp;
  plot(hour,height,'*');
end
if ~isempty(cutoff)
  plot(get(gca,'xlim'),[1 1]*cutoff*mean(rawf),'--');
end
