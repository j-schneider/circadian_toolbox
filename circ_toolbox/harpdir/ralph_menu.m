function ralph_menu(ab)
% menu callback for "Ralph" actogram plot on HARP DAM data

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

figure

switch ab
  
 case 2
  ralph(DAM_DATA_B)
  name = 'B';
  
 otherwise
  ralph(DAM_DATA_A)
  name = 'A';
end

set(gcf, 'Name', ['HARP Ralph ' name])

  