function plot_events(events)

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
SYMBOLS = 'x+*sdv^<>';

% we want events in lower part of display
ylim = get(gca, 'YLim');
ymin = ylim(1);
ymax = ylim(2);
yrange = ymax - ymin;
yscale = yrange/2 * .1;

for i = 1:size(events,1)
  event = events(i,:);
  key = event(1);
  evtbeg = event(2);
  evtend = event(3);
  ypos = ymin + key * yscale;
  plot(evtbeg, ypos, [SYMBOLS(key) 'r'], 'MarkerSize',12); 
  plot([evtbeg evtend], [ypos ypos], 'r')
end
