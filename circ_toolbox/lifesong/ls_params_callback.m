function ls_params_callback

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
GUI_W = 500;
GUI_H = 300;
BUTTON_X = 20;
BUTTON_Y = 50;

global SECONDS
global EDIT_SECONDS

figure
set_size(GUI_W, GUI_H)

uicontrol(gcf, 'Style','text', 'String','Duration (sec):', ...
	  'Position', [20 100 200 100], ...
	  'FontSize', 18, ...
	  'BackgroundColor', get(gcf, 'Color'))


EDIT_SECONDS = uicontrol(gcf, 'Style','edit', ...
	  'Position', [210 165 100 40], ...
	  'FontSize', 18, ...
          'String', num2str(SECONDS));


add_button('Okay', BUTTON_X, BUTTON_Y, 'ls_params_okay_callback');
add_button('Cancel', BUTTON_X+380, BUTTON_Y, 'ls_close_callback');