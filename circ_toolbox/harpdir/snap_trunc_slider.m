function slider = snap_trunc_slider(slider, where)
% snap min/max sliders to nearest daylight transition in HARP
% truncation dialog

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
global TRUNC_BINS_RADIO

oldpos = get(slider, 'Value');

trans = find(where);

if ~uival(TRUNC_BINS_RADIO)
  trans = bin2day(trans);
end

dist = abs(oldpos - trans);
newpos = trans(find(dist == min(dist)));
set(slider, 'Value', newpos)
trunc_update_limits(slider, newpos)
