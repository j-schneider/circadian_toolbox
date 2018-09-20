function undo_menu
% menu callback for HARP Modify / UndoAll.  Re-inits record and
% daylight values to original loaded values.

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
global DAYLIGHTS
global ORIGINAL_DATA
global ORIGINAL_DAYLIGHTS

CURRENT_DATA = ORIGINAL_DATA;

if ~isempty(DAYLIGHTS)
  DAYLIGHTS = ORIGINAL_DAYLIGHTS;
end


