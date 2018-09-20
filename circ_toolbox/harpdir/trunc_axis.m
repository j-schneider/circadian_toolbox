function trunc_axis(use_bins)
% set axes for HARP truncation dialog

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
global CURRENT_DATA
global TRUNC_MIN_SLIDER
global TRUNC_MAX_SLIDER
global TRUNC_MIN TRUNC_MAX

% handle DAM data
if isstruct(CURRENT_DATA)
  binbeg = CURRENT_DATA.first;
  binend = CURRENT_DATA.len;
else
  [y,binbeg] = cleanup;
  binend = length(CURRENT_DATA);
end


if use_bins == 1
  xbeg = binbeg;
  xend = binend;
else
  xbeg = bin2day(binbeg);
  xend = bin2day(binend);
end

set(gca, 'XLim', [xbeg xend])

TRUNC_MIN = 0;
TRUNC_MAX = xend;

set(TRUNC_MIN_SLIDER, 'Min', 0, 'Max', xend/2, 'Value',0)
set(TRUNC_MAX_SLIDER, 'Min', xend/2, 'Max', xend, 'Value',xend)

trunc_show

