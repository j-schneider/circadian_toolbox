function [ri,rs,px]=acplot(ac,x,in,peakrange,int)
%ACPLOT Draw autocorrelation graph
% [ri,rs,px]=acplot(ac,x,in,peakrange)
% draws autocorrelation graph
% ac: autocorrelation info (see autoco)
% x: lag 
% in: confidence interval
% peakrange: find peak btween peakrange(1) and peakrange(2)
% and compute rhythmicity index there.
% 
% see help rindex for an explanation of the output parameters. 

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
reset(gca)
rindex=[];
peakx=[];
%does this work
if nargin>6
    x = x*int/60
end
%did it work?
hold on
fill([-100 -100 100 100] , [in,-in,-in,in], ...
       [.9 .9 .9]);
plot(x,ac)

set(gca,'ylim',[-1.2 1.2])
set(gca,'xlim',[-72 72])

ticklist=-3*24:12:3*24;

for i=1:length(ticklist) 
  if (mod(i-1,2)==0)
    ticklabel{i}=num2str(ticklist(i));
  else
    ticklabel{i}=[];
  end
end
set(gca,'xtick',ticklist,'xticklabel',ticklabel,'xgrid','on','ygrid','on')
set(gca,'box','on')
xlabel('Lag (h)');
ylabel('Autocorrelation');
if nargin>3 & ~isempty(peakrange)
  [ri,rs,px]=rindex_raw(ac,x,in,peakrange);
  py=ri;
  plot(px,py,'*');  
  rindex=py/in;
  peakx=px;
  mybox(sprintf('p=%2.1fh RI=%3.2f RS=%3.1f',px/2,py,rindex),3);
end

%line([-100 100],[in,in],'LineStyle',':');
%line([-100 100],[0 0 ],'LineStyle',':');
%line([-100 100],[-in,-in],'LineStyle',':');
