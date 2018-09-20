function [on,off]=analights(x,lights)
% ANALIGHTS find time of lights on and lights off from lights
% vector. 
% [on,off]=analights(x,lights)

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
  h=24;
else
  h=DAILY_HOURS;
end
l=lights;
d=diff(l);
if isempty(d)
  on=[];
  off=[];
else
  on=x(find(d==1));
  off=x(find(d==-1));
  on=mod(on,h);
  off=mod(off,h);
end

if nargout<1
    on=on';
    on
    off=off';
    off
end


