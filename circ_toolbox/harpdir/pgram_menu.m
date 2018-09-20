function pgram_menu
% menu callback for HARP Plot/Periodogram

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
global PGRAM_FROM_HOURS
global PGRAM_TO_HOURS
global PGRAM_CONF
global PGRAM_FROM_HOURS_EDIT
global PGRAM_TO_HOURS_EDIT
global PGRAM_CONF_EDIT

fig = openfig('pgram.fig','reuse');

kids = get(fig, 'Children');

PGRAM_FROM_HOURS_EDIT = kids(3);
PGRAM_TO_HOURS_EDIT = kids(2);
PGRAM_CONF_EDIT = kids(1);

setnum(PGRAM_FROM_HOURS_EDIT, PGRAM_FROM_HOURS);
setnum(PGRAM_TO_HOURS_EDIT, PGRAM_TO_HOURS);
setnum(PGRAM_CONF_EDIT, PGRAM_CONF)

