function trunc_edit_update
% update HARP truncation dialog edit widgets using min/max slider values

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
global TRUNC_MIN_EDIT
global TRUNC_MAX_EDIT

slide2edit(TRUNC_MIN_EDIT, TRUNC_MIN_SLIDER)
slide2edit(TRUNC_MAX_EDIT, TRUNC_MAX_SLIDER)

