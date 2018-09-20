function o=dam_align(o1,o2)
%DAM_MERGEA Align-then-merge function
% o=dam_mergea(o1,o2)
% this is the same as DAM_MERGE but will align based on the 
% hour information

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
first=max(o1.x(1),o2.x(1));
loss1=sum(o1.x < first);
loss2=sum(o2.x < first);
if loss1>0
  fprintf('Removing %d bins off group 1\n',loss1)
  o1=dam_truncate(o1,loss1+1,0,'bins');
end
if loss2>0
  fprintf('Removing %d bins off group 2\n',loss2)
  o2=dam_truncate(o1,loss2+1,0,'bins');
end
o=dam_merge(o1,o2);
