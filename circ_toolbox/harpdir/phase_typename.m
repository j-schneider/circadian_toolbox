function name = phase_typename
% return name for phase type in HARP, used for labeling dialogs

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
global PHASE_TYPE

switch PHASE_TYPE
  
 case 2 % single B
  name = 'Single Phase B';
  
 case 3 % multiple
  name = 'Multiple Phase';
  
 case 4 % bivariate
  name = 'Bivariate Phase';
  
 otherwise % single A

  name = 'Single Phase A';
  
end
