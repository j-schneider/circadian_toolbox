function ls_zoom_button_cb(obj,eventdata)

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
global ZOOM_MODE

button_state = get(obj,'Value');

if button_state == get(obj,'Max')
    % toggle button is pressed
    disp('ZOOM_BUTTON_DOWN')
    ZOOM_MODE = 1;
elseif button_state == get(obj,'Min')
    % toggle button is not pressed
    disp('ZOOM_BUTTON_UP')
    ZOOM_MODE = 0;
end
