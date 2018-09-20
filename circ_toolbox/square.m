function t=square(n,m,k)
%SQUARE Quick and dirty square wave generator
% t=square(n,m,k)
% This q&d function simply generates a vector
% of zeros and ones, that begins with n zeros,
% then switches to m ones, and so on until k
% total elements.

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
s=[zeros(1,n),ones(1,m)];
t=[];

for i=n+m:n+m:k
  t=[t,s];
end
if length(t)<k
  t=[t,s(1:k-length(t))];
end
t=t';


