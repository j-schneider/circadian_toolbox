function harp_dam_truncate(ab)
% HARP menu callback for DAM Truncate

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
global DAM_DATA_A
global DAM_DATA_B
global CURRENT_DATA
global CURRENT_RECORD_NAME
global DAYLIGHTS
global DAM_WHICH

if ab == 1
  CURRENT_RECORD_NAME = 'DAM A';
  o = DAM_DATA_A;
else
  CURRENT_RECORD_NAME = 'DAM B';
  o = DAM_DATA_B;
end

CURRENT_DATA = o;
DAYLIGHTS = o.lights;
DAM_WHICH = ab;

trunc_menu
