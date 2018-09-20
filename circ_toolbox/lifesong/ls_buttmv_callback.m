function ls_buttmv_callback

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
% called when mouse button is moved; useful for highlighting

global LAST_POINT
global LAST_LINE
global BUTTDOWN
global BUTTONID

% highlight only if button down
if ~BUTTDOWN return, end

% highlight only if left button down
if ~strcmp(BUTTONID, 'normal'), return, end

point = get(gca, 'CurrentPoint');
x = point(1,1);
last_x = LAST_POINT(1,1);

% highlight by drawing a big thick line between the previous
% mouse position and the current one
ylim = get(gca, 'YLim');
y = (ylim(1) + ylim(2)) / 2;
if LAST_LINE, delete(LAST_LINE), end
LAST_LINE = plot([last_x x], [y y], 'Color',[.5 .5 .5], ...
		 'LineWidth',500, 'EraseMode','xor');
drawnow

