function trunc_update_limits(h, newpos)
% update limit value reporting in HARP truncation dialog

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
global TRUNC_MIN 
global TRUNC_MAX 
global TRUNC_MIN_SLIDER 
global TRUNC_MAX_SLIDER

if h == TRUNC_MIN_SLIDER
  oldx = TRUNC_MIN;
  TRUNC_MIN = newpos;
else          % max
  oldx = TRUNC_MAX;
  TRUNC_MAX = newpos;
end

minval = get(TRUNC_MAX_SLIDER, 'Value');
maxval = get(TRUNC_MIN_SLIDER, 'Value');

set(TRUNC_MIN_SLIDER, 'Max', minval)
set(TRUNC_MAX_SLIDER, 'Min', maxval)

plot_trunc_limit(oldx)
plot_trunc_limit(newpos)

trunc_edit_update

