function set_histo_format(which)
% set format in HARP Histogram dialog

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
global HISTO_RADIO_NORMAL
global HISTO_RADIO_CENTER_LIGHT
global HISTO_RADIO_CENTER_DARK
global HISTO_RADIO_ON_TO_OFF
global HISTO_RADIO_OFF_TO_ON

radios = {HISTO_RADIO_CENTER_LIGHT, ...
          HISTO_RADIO_CENTER_DARK, ...
          HISTO_RADIO_ON_TO_OFF, ...
          HISTO_RADIO_OFF_TO_ON};

if ~which
  turnon(HISTO_RADIO_NORMAL)
else
  turnoff(HISTO_RADIO_NORMAL)
end

for i = 1:length(radios)
  if i == which
    turnon(radios{i})
  else
    turnoff(radios{i})
  end
end

