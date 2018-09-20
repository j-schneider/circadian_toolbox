function ls_unzoom_button_cb(obj,eventdata)

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
%global ZOOM_MODE
global PREV_SCALE_STACK
global SCALE
global SONG

[PREV_SCALE_STACK,SCALE(1),SCALE(2)] = stack_pop(PREV_SCALE_STACK)

if (SCALE(1) ~= -1)
  moveto(SCALE(1),SCALE(2));
  set(gca,'YLimMode','auto');
else
  plot_song;
end
