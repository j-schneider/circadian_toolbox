function fly_allplot(a,sep,int,x0)
%FLY_ALLPLOT  Plot all flies' activity together
% fly_allplot(a,sep,int)
%
% a: matrix of data
% sep (optional) separation between flies
% usually, leave sep out and let the function 
% choose a good separation for the plot
%
% see also: fly_pinpoint

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
if nargin<3
  int=60;
end
if nargin<4
  x0=0;
end
cla;hold on
if nargin<2 | sep==0
  sep=10^ceil(log10(2*mean(std(a))));
end
x=0:size(a,1)-1;
x=x*int/60;
x=x+x0;
for i=1:size(a,2)
  plot(x,a(:,i)+i*sep);
end

