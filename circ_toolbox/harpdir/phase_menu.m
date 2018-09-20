function phase_menu(phasetype)
% menu callback for HARP DAM / Phase

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
global PHASE_LOPASS_HOURS
global PHASE_NORMALIZE
global PHASE_FIRST_HOUR
global PHASE_PERIOD_EDIT

global DAM_DATA_A

global PHASE_LOPASS_EDIT
global PHASE_NORMALIZE_CHKBOX
global PHASE_FHOUR_EDIT
global PHASE_PERIOD
global PHASE_TYPE

fig = openfig('phase', 'reuse');

PHASE_TYPE = phasetype;

set(fig, 'Name', sprintf('HARP: %s', phase_typename))

kids = get(fig, 'Children');

PHASE_LOPASS_EDIT = kids(7);
PHASE_NORMALIZE_CHKBOX = kids(5);
PHASE_PERIOD_EDIT = kids(4);
PHASE_FHOUR_EDIT = kids(2);
phase_fhour_label = kids(1);

setnum(PHASE_LOPASS_EDIT, PHASE_LOPASS_HOURS)
setnum(PHASE_PERIOD_EDIT, PHASE_PERIOD)

if PHASE_NORMALIZE
  turnon(PHASE_NORMALIZE_CHKBOX)
else
  turnoff(PHASE_NORMALIZE_CHKBOX)
end

if ~isempty(DAM_DATA_A.daylight)
  enable(PHASE_FHOUR_EDIT)
  setnum(PHASE_FHOUR_EDIT, PHASE_FIRST_HOUR)
  enable(phase_fhour_label)
else
  disable(PHASE_FHOUR_EDIT)
  disable(phase_fhour_label)
end



