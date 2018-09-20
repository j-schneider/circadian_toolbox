function o=dam_mergea(varargin)
%DAM_MERGEA Align-then-merge function
% o=dam_mergea(o1,o2)
% this is the same as DAM_MERGE but will align based on the 
% hour information
%
% If you specify more than two, they will be all merged, adding
% one by one. 

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
if length(varargin)<2
  error('Incorrect number of parameters')
elseif length(varargin)==2
  o=do_mergea(varargin{1},varargin{2});
else
  o=varargin{1};
  for i=2:length(varargin)
    fprintf('--- dam_merga: Combined merger step %d\n',i-1);
    o=dam_mergea(o,varargin{i});
  end
end

function o=do_mergea(o1,o2)
first=max(o1.x(1),o2.x(1));
loss1=sum(o1.x < first);
loss2=sum(o2.x < first);
if (loss1+loss2)>0
  fprintf('dam_mergea: Starting times: (%.1f, %.1f), ',o1.x(1), ...
	  o2.x(2));
end
if loss1>0
  fprintf('removing %d bins off group 1\n',loss1)
  o1=dam_truncate(o1,loss1+1,0,'bins');
end
if loss2>0
  fprintf('removing %d bins off group 2\n',loss2)
  o2=dam_truncate(o2,loss2+1,0,'bins');
end
o=dam_merge(o1,o2);
