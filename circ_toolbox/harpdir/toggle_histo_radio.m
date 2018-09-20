function toggle_histo_radio(incubator, baseline)
% toggle histogram dialog radio visibility based on settings

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
global HISTO_HOURS_MIN
global HISTO_HOURS_MAX
global HISTO_FORMAT
global DAYLIGHTS
global MIN_PER_BIN

global HISTO_RADIO_NORMAL
global HISTO_RADIO_CENTER_LIGHT
global HISTO_RADIO_CENTER_DARK
global HISTO_RADIO_ON_TO_OFF
global HISTO_RADIO_OFF_TO_ON

hours = bin2hrs(baseline);

set_histo_format(HISTO_FORMAT)

if ~isempty(DAYLIGHTS)
  show(HISTO_RADIO_NORMAL)
  show(HISTO_RADIO_CENTER_DARK)
  show(HISTO_RADIO_CENTER_LIGHT)
  show(HISTO_RADIO_ON_TO_OFF)
  show(HISTO_RADIO_OFF_TO_ON)
  if incubator & (hours >= HISTO_HOURS_MIN) & (hours <= HISTO_HOURS_MAX)
    enable_histo_format
  else
    disable_histo_format
  end
else
  hide(HISTO_RADIO_NORMAL)
  hide(HISTO_RADIO_CENTER_DARK)
  hide(HISTO_RADIO_CENTER_LIGHT)
  hide(HISTO_RADIO_ON_TO_OFF)
  hide(HISTO_RADIO_OFF_TO_ON)
end


