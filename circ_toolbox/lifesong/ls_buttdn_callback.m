function ls_buttdn_callback

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
% called when mouse button is depressed; useful for highlighting
% and pulse recording

global LAST_POINT
global BUTTDOWN
global BUTTONID

% flag is used by ls_buttmv_callback
BUTTDOWN = 1;

% left('normal'), middle('extend'), or right('alt') button
BUTTONID = get(gcf, 'SelectionType');

% left does highlighting/zooming
if strcmp(BUTTONID, 'normal')
  
% right button zooms out  
elseif strcmp(BUTTONID, 'alt')
  reset_axis
  reset_slider
end


% ls_buttmv_callback will check X coordinate of down-point to
% decided whether to select a pulse or to highlight
LAST_POINT = get(gca, 'CurrentPoint');
