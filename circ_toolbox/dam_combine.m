function u=dam_combine(o1,o2)

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
l1=size(o1.data,1);
l2=size(o2.data,1);
l=min(l1,l2);
o1=dam_truncate(o1,0,l,'bins');
o2=dam_truncate(o2,0,l,'bins');
u=o1;
u.data=[o1.data,o2.data];
u.boards=[o1.boards;o2.boards];
u.channels=[o1.channels;o2.channels];
u.len=l;
for i=1:size(o2.data,2)
  u.headers{end+1}=o2.headers{i};
  u.names{end+1}=o2.names{i};
  u.daylight{end+1}=o2.daylight{i};
end
