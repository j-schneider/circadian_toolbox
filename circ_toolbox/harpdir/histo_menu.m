function histo_menu
% menu callback for HARP Plot/Histogram

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
INCU_RADIO_Y = 80;

global HISTO_BASELINE
global INCUBATOR

global HISTO_BASELINE_EDIT
global HISTO_BASELINE_TEXT
global HISTO_RADIO_NORMAL
global HISTO_RADIO_CENTER_LIGHT
global HISTO_RADIO_CENTER_DARK
global HISTO_RADIO_ON_TO_OFF
global HISTO_RADIO_OFF_TO_ON

fig = openfig('histo.fig','reuse');

kids = get(fig, 'Children');

HISTO_RADIO_NORMAL = kids(1);
HISTO_RADIO_CENTER_LIGHT = kids(5);
HISTO_RADIO_CENTER_DARK = kids(4);
HISTO_RADIO_ON_TO_OFF = kids(3);
HISTO_RADIO_OFF_TO_ON = kids(2);

HISTO_BASELINE_EDIT = kids(9);
HISTO_BASELINE_TEXT = kids(6);

setnum(HISTO_BASELINE_EDIT, HISTO_BASELINE)
show_baseline_hours(HISTO_BASELINE, HISTO_BASELINE_TEXT)

show_incu_radio(fig, INCU_RADIO_Y, 'histo_incu_radio_callback')
toggle_histo_radio(INCUBATOR, HISTO_BASELINE)
