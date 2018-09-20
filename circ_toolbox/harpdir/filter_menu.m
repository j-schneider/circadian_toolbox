function filter_menu
% menu callback for HARP Modify/Filter

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
global FILTER_LO_HOURS
global FILTER_HI_HOURS
global FILTER_ORDER
global FILTER_TWICE

global FILTER_LO_HOURS_EDIT
global FILTER_HI_HOURS_EDIT
global FILTER_ORDER_EDIT
global FILTER_TWICE_CBOX

fig = openfig('filter.fig','reuse');

kids = get(fig, 'Children');

FILTER_TWICE_CBOX = kids(1);
FILTER_ORDER_EDIT = kids(2);
FILTER_LO_HOURS_EDIT = kids(9);
FILTER_HI_HOURS_EDIT = kids(6);

setnum(FILTER_HI_HOURS_EDIT, FILTER_HI_HOURS)
setnum(FILTER_LO_HOURS_EDIT, FILTER_LO_HOURS)
setnum(FILTER_ORDER_EDIT, FILTER_ORDER)

if FILTER_TWICE
  turnon(FILTER_TWICE_CBOX)
else
  turnoff(FILTER_TWICE_CBOX)
end



  
  