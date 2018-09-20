function mod24lbl
% MOD24LBL set x axis labels to hours or days, as needed

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
global DAILY_HOURS
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
end
xl=get(gca,'xlim');
span=xl(2)-xl(1);
days=span/DAILY_HOURS;
if (days<0.5)
  hpt=1;
elseif (days<1)
  hpt=2;
elseif (days<2.5)
  hpt=4; %hours-per-tick
else
  hpt=24;
end
hpt=hpt * DAILY_HOURS/24;

first=hpt*ceil(xl(1)/hpt);
last=hpt*floor(xl(2)/hpt);
ticks=first:hpt:last;
set(gca,'xtick',ticks);
set(gca,'xticklabel',mod(ticks,DAILY_HOURS));

