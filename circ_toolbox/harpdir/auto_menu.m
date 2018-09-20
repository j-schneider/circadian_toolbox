function auto_menu
% menu callback for HARP Plot/Autocorrelation

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
global AUTO_PEAK_FROM_HOURS
global AUTO_PEAK_TO_HOURS
global AUTO_PEAK_FROM_HOURS_EDIT
global AUTO_PEAK_TO_HOURS_EDIT

fig = openfig('auto.fig','reuse');

kids = get(fig, 'Children');

AUTO_PEAK_FROM_HOURS_EDIT = kids(5);
AUTO_PEAK_TO_HOURS_EDIT = kids(2);

setnum(AUTO_PEAK_TO_HOURS_EDIT, AUTO_PEAK_TO_HOURS)
setnum(AUTO_PEAK_FROM_HOURS_EDIT, AUTO_PEAK_FROM_HOURS)


  
  