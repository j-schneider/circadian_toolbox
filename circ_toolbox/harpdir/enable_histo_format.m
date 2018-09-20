function enable_histo_format
% enable Histogram format radios in HARP

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
global HISTO_RADIO_CENTER_DARK
global HISTO_RADIO_CENTER_LIGHT
global HISTO_RADIO_ON_TO_OFF
global HISTO_RADIO_OFF_TO_ON

enable(HISTO_RADIO_NORMAL)
enable(HISTO_RADIO_CENTER_DARK)
enable(HISTO_RADIO_CENTER_LIGHT)
enable(HISTO_RADIO_ON_TO_OFF)
enable(HISTO_RADIO_OFF_TO_ON)
