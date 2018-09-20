function do_trunc
% truncate current signal using current global data and settings
% from HARP

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
global TRUNC_BINS 
global TRUNC_MIN
global TRUNC_MAX 
global CURRENT_DATA
global DAYLIGHTS
global DAM_WHICH
global DAM_DATA_A
global DAM_DATA_B

if TRUNC_BINS
  lobin = TRUNC_MIN;
  hibin = TRUNC_MAX;
else
  lobin = day2bin(TRUNC_MIN);
  hibin = day2bin(TRUNC_MAX);
end

lobin = max(fix(lobin), 1);

% handle DAM data
if isstruct(CURRENT_DATA)
  hibin = min(fix(hibin), CURRENT_DATA.len);
  if ~isempty(DAYLIGHTS)
    beg = CURRENT_DATA.first;
    dlobin = max(lobin - beg, 1); % daylight is already cut off at beginning
    dhibin = hibin - beg;
    DAYLIGHTS = DAYLIGHTS(dlobin:dhibin, :);
  end
  CURRENT_DATA = dam_truncate(CURRENT_DATA, lobin, hibin, 'bins');
  if DAM_WHICH == 1
    DAM_DATA_A = CURRENT_DATA;
  else
    DAM_DATA_B = CURRENT_DATA;
  end
  
else
  hibin = min(fix(hibin), length(CURRENT_DATA));
  CURRENT_DATA = CURRENT_DATA(lobin:hibin);
  if ~isempty(DAYLIGHTS)
    DAYLIGHTS = DAYLIGHTS(lobin:hibin,:);
  end
end

