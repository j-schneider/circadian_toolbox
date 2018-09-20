function set_axis(xmin, xmax)

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
% (LIFESONG FUNCTION)
% Set axes for plotting waveform and events, based on slider position.
% Waveform range is [-1,1], so we plot in [-2,1] to use the bottom
% third for events.

global SONG
global SLIDER
global SECONDS

%set(gca,'YLimMode','manual') 
%keep y min and max 
v = axis;
ymin = v(3);
ymax = v(4);
axis([xmin xmax ymin ymax])
%set slider appropriately?
sliderval = abs(min(((xmax + xmin)/2)/SECONDS,1));

set(SLIDER,'Value',sliderval);
%set(gca,'YLimMode','auto');

