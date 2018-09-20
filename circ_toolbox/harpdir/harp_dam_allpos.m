function harp_dam_allpos(mon, onoff)
% menu callback toggle usage of all or no positions in monitor, in HARP
% DAM dialog

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
global DAM_SELECT_MENUS

if onoff
  newstate = 'on';
else
  newstate = 'off';
end

items = DAM_SELECT_MENUS(mon,:);

for pos = 1:length(items)
  item = items(pos);
  if item
    set(item, 'Checked', newstate)
  end
end

