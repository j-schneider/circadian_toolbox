function dam_pgram(o,wells,beghrs,endhrs,conf)
%DAM_PGRAM Plot periodogram of selected fly or average of flies
% dam_pgram(o,wells)
%
% o: dam data as obtained with dam_load
% wells: list of wells (either one well for periodogram of that fly or
% list of wells to average before computing periodogram)
%
% Optional parameters : dam_pgram(o,wells,beghrs,endhrs,conf)
% see help pgram for explanation of those. 

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
%defaults: use zero
if nargin<3, beghrs=0; end
if nargin<4, endhrs=0; end
if nargin<5, conf=0; end
if nargin<2, wells=1:size(o.f,2); end

x=mean(o.f(:,wells),2);
pgram(x,beghrs,endhrs,conf,o.int);
