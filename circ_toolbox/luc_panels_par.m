function p=luc_panels_par

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
p.int=60;
p.peak=1;
p.name='';
p.normalize=1;
p.peakzone=[15 33];
global normalization_method
if isempty(normalization_method)
    normalization_method=4;
end;
p.normalization_method=normalization_method;
p.mesaOrder=[];
p.mesaFunct='dusty';
p.peakRange=[16 32];
p.filterHours=4;