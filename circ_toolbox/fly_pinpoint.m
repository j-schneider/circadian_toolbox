function [good,bad]=fly_pinpoint(a,wells,sep)
%FLY_PINPOINT  Manually choose (bad) flies from activity plot
% [good,bad] = fly_pinpoint(a,wells,sep)
%
% Plots activity of all flies on a (selected wells) and waits for user
% click. Clicking on a fly's line moves it from the 'good' list to the
% 'bad', and viceversa. Use this function to manually sort out good
% from bad flies. see also: fly_allplot optional parameter: sep (just
% as in fly_allplot).

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
if nargin<2
  wells=1:size(a,2);
end
b=a(:,wells);
if nargin<3
  sep=10^ceil(log10(2*mean(std(b))));
end
n=size(b,2);
m=size(b,1);
for i=1:n
  b(:,i)=b(:,i)+i*sep;
end
good=1:n;
bad=[];
plotem(b,wells,good,bad)
xl=get(gca,'xlim');
yl=get(gca,'ylim');
finished=0;  
grid on
while ~finished
  [x,y]=ginput(1);
  x=round(x);
  if (x<xl(1)) | (x>xl(2)) | (y<yl(1)) | (y>yl(2)) | x<=0 | x>m;
    finished=1;
  else
    d=(b(x,:)-y).^2;
    j=find(d==min(d));
    j=j(1);
    if ismember(j,bad)
      bad=setdiff(bad,j);
      good=[good,j];
    else
      good=setdiff(good,j);
      bad=[bad,j];
    end
    plotem(b,wells,good,bad)
  end
end
good=wells(good);
bad=wells(bad);

function plotem(b,wells,good,bad)
clf;hold on
for i=1:length(good)
  plot(b(:,good(i)));
end
for i=1:length(bad)
  plot(b(:,bad(i)),'r');
end
xl=get(gca,'xlim');
set(gca,'xtick',0:24:xl(2));
set(gca,'xticklabel',[]);    
if (~isempty(good))
  title(['GOOD ',sprintf('%d ',wells(good))]);
end
if (~isempty(bad))
  xlabel(['BAD ',sprintf('%d ',wells(bad))]);
end
grid on
