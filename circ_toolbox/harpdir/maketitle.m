function maketitle(analtype)
% set plot title to current record name plus analysis type (for
% non-tile mode) in HARP

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
global LAYOUT
global CURRENT_RECORD_NAME

if LAYOUT == 3 % tile mode
  name = ['HARP:' CURRENT_RECORD_NAME];
else
  name = ['HARP/' analtype  ': ' CURRENT_RECORD_NAME];
end

set(gcf, 'Name', name)