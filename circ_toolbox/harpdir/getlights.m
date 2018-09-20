function lights = getlights(beg)
% reuturn daylight array based on presence of daylight data and choice
% of incubator in HARP.  Argument BEG specifies first non-negative bin.

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
global INCUBATOR
global DAYLIGHTS

lights = [];
if ~isempty(DAYLIGHTS)
  if INCUBATOR    
    lights = DAYLIGHTS(beg:end, INCUBATOR); 
  end
end
