function do_norm(mode)
% perform one of seven different normalization modes on current signal
% using current global data and setting in HARP.  See NORMALIZE
% function for the definitions of these modes.

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
global MIN_PER_BIN

[y,beg] = cleanup;

y = normalize(y, mode, MIN_PER_BIN);

% copy detrended data back to current record after negative lead
CURRENT_DATA(beg:end) = y;


