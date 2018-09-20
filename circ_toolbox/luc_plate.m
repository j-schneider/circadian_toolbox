function [p,w]=luc_plate(well)
%LUC_PLATE  Convert from absolute wells to plate,wells
% [plates,wells]=luc_plate(wells)
% takes in a well number or list of well  numbers
% and returns the plate and wells numbers
% 
% see also: luc_well
%
% example:
%>> [p,w]=luc_plate([51 52 53])
%
%p =
%
%     2     2     2
%
%
%w =
%
%     3     4     5

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

p=floor((well-1)/48)+1;
w=mod((well-1),48)+1;
