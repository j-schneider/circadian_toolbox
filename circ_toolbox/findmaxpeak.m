function [p,x]=findmaxpeak(r)
%FINDMAXPEAK find highest peak on a vector
% [p,x]=findmaxpeak(r)
% calls findpeaks to find all peaks
% then keeps just the tallest one

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
[p,x]=findpeaks(r);
if ~isempty(p)
  i=find(p==max(p));
  i=i(1);
  p=p(i);
  x=x(i);
end
