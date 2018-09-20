function [data,x]=dam_mean(o,wells)
%[g,x]=dam_cleanup(o.data(:,wells),o.start,o.int);

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
if nargin<2
  wells=1:size(o.f,2);
end
b=o.f(:,wells);
meangraph(b,o.x(1),o.int);
xlabel('time (hrs.)')
ylabel('mean activity');  
title(sprintf('%s-%s (n=%d)',o.names{wells(1)},o.names{wells(end)},length(wells)));
 
