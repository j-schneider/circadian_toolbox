% o=dam_lightson(o)
% drops the initial dark bins of a data record
% and renames the hours so that lights on becomes zero.

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function o=dam_lightson(o)
l = o.lights;
d = diff(l);
oni = find(d==1);
if isempty(oni)
  fprintf('ERROR: no lights on information\n');
else
  oni=oni+2;
  o=dam_truncate(o,oni,0,'bins');
  o.x = o.x - o.x(1);
  o.start = o.start - o.x(1);
end
  
