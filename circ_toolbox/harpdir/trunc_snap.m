function trunc_snap
% snap min/max limits to daylight transitions in HARP truncation
% dialog

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
global TRUNC_MIN_SLIDER
global TRUNC_MAX_SLIDER

incu = incu_radio_value;
diff = trunc_diff(incu);

TRUNC_MIN_SLIDER = snap_trunc_slider(TRUNC_MIN_SLIDER, diff);
TRUNC_MAX_SLIDER = snap_trunc_slider(TRUNC_MAX_SLIDER, diff);


  
