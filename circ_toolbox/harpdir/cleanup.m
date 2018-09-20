function [y,beg] = cleanup
% clean up signal by remove leading negative values in HARP

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
% remove leading negatives

global CURRENT_DATA
noneg = find(CURRENT_DATA >= 0);
beg = noneg(1);
y = CURRENT_DATA(beg:end);

% replace interior negatives with means of values bracketing them

posbeg = 0;
inneg  = 0;

for i = 1:length(y)
  if y(i) < 0
    inneg = 1;
  else
    if inneg
      y(posbeg+1:i-1) = (y(posbeg) + y(i)) / 2;
    end
    posbeg = i;
    inneg = 0;
  end
end


