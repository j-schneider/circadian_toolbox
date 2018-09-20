function do_filter
% filter current data using current global data and settings from HARP

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

global FILTER_ORDER
global FILTER_TWICE
global FILTER_LO_HOURS
global FILTER_HI_HOURS

[y,beg] = cleanup;

% filter non-negative data
y = butt_filter(y, FILTER_LO_HOURS, FILTER_HI_HOURS, FILTER_ORDER, ...
		FILTER_TWICE);

% overwrite original with filterd
CURRENT_DATA(beg:end) = y;
