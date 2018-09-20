function ls_slider_callback

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
% called when slider button is released; scrolls to new area

global SLIDER
global SECONDS

% get current view range
xlim = get(gca, 'XLim');
xmin = xlim(1);
xmax = xlim(2);
xrng = (xmax - xmin) / 2;

% use slider location to generate new range
newctr = get(SLIDER, 'Value') * SECONDS;
newxmin = newctr - xrng;
newxmax = newctr + xrng;

% keep range in [0,SECONDS]
if newxmin < 0, newxmin = 0; end
if newxmax > SECONDS, newxmin = SECONDS; end

set(gca,'YLimMode','manual')
% set display to new range
set_axis(newxmin, newxmax)
