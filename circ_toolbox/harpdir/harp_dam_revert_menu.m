function harp_dam_revert_menu(ab)
% menu callback for HARP DAM / Revert

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
global DAM_ORIGINAL_DATA_A
global DAM_ORIGINAL_DATA_B

switch ab
  
 case 1
  
  DAM_DATA_A = DAM_ORIGINAL_DATA_A;
  
 case 2
  
  DAM_DATA_B = DAM_ORIGINAL_DATA_B; 
  
 case 3 

  DAM_DATA_A = DAM_ORIGINAL_DATA_A;
  DAM_DATA_B = DAM_ORIGINAL_DATA_B;
  
end

  