function luc_analyzeplate(a1,plates,doprint,title) 

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
global normalization_method
normalization_method=6


if nargin<3
  doprint=0;
end
if nargin<4
  title='';
end

for i=1:length(plates)
  p=plates(i);
  for j=1:6
    page(a1,p,j,doprint,title);
  end
end

function page(a1,p,j,doprint,title)
figure
luc_analyze(a1,luc_well(p,((j-1)*8)+(1:8)));

if ~ isempty(title)
  suptitle(title)
end

if doprint 
  print
  close
end

