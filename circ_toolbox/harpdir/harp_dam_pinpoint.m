function harp_dam_pinpoint(ab)
% HARP menu callback for DAM Pinpoint

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

if ab == 1
  o = DAM_DATA_A;
else
  o = DAM_DATA_B;
end

figure

[good,bad] = fly_pinpoint(o.f);

if ab == 1
  DAM_DATA_A = dam_select(o, good);
else
  DAM_DATA_B = dam_select(o, good);
end



