function w=luc_well(plate,well) 
%LUC_WELL  Convert from plate, wells to absolute wells
% w=luc_well(plate,wells)
%
% Returns the well numbers correspoinding to 
% the plate and wells requested.
%
% see also: luc_plate
%
% example: 
%>>  luc_well(2,[3 4 5])
%
%ans =
%
%    51    52    53

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
w=(plate-1)*48+well;
