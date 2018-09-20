function acto_menu
% menu callback for HARP Plot/Autocorrelation

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

global MIN_PER_BIN

global ACTO_REPS
global ACTO_BASELINE
global ACTO_LO
global ACTO_HI
global ACTO_DOUBLE_RADIO
global ACTO_SINGLE_RADIO
global ACTO_BIN_EDIT
global ACTO_BASELINE_EDIT
global ACTO_BASELINE_TEXT
global ACTO_LO_EDIT
global ACTO_HI_EDIT

fig = openfig('acto.fig','reuse');

kids = get(fig, 'Children');

ACTO_DOUBLE_RADIO = kids(16);
ACTO_SINGLE_RADIO = kids(15);
ACTO_LO_EDIT = kids(9);
ACTO_HI_EDIT = kids(6);
ACTO_BASELINE_EDIT = kids(11);
ACTO_BASELINE_TEXT = kids(1);
ACTO_BIN_EDIT = kids(13);

setnum(ACTO_HI_EDIT, ACTO_HI)
setnum(ACTO_LO_EDIT, ACTO_LO)

setnum(ACTO_BIN_EDIT, MIN_PER_BIN)

setnum(ACTO_BASELINE_EDIT, ACTO_BASELINE)
show_baseline_hours(ACTO_BASELINE, ACTO_BASELINE_TEXT)

switch ACTO_REPS
  
 case 1
  
  turnoff(ACTO_DOUBLE_RADIO)
  turnon(ACTO_SINGLE_RADIO)
  
 otherwise
  
  turnon(ACTO_DOUBLE_RADIO)
  turnoff(ACTO_SINGLE_RADIO)
    
end

show_incu_radio(fig, INCU_RADIO_Y, 'incu_radio_callback')