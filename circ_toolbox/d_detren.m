function [y,m,b,esq,R]=d_detren(x,y)
%D_DETREN Dusty's linear detrending function
% [y,m,b,esq,R]=d_detren(x,y)
% this function is same as notrend(x,y). 
% see help notrend

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
  y=x;
  x=1:length(y);
  x=x';
end
[m,b,esq,R]=slope(x,y);
line=m*x+b;
y=y-line;
