function mesa_menu(name)
% generic menu callback for HARP Plot/Mesa submenus

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
global MESA_ORDER
global MESA_FROM
global MESA_TO
global MESA_ORDER_EDIT
global MESA_FROM_EDIT
global MESA_TO_EDIT
global MESA_FUN

MESA_FUN = name;

fig = openfig('mesa.fig','reuse');

set(fig, 'Name', ['HARP/Mesa: ' name])

kids = get(fig, 'Children');

MESA_ORDER_EDIT = kids(6);
MESA_FROM_EDIT = kids(2);
MESA_TO_EDIT = kids(1);
  
setnum(MESA_ORDER_EDIT, MESA_ORDER)
setnum(MESA_FROM_EDIT, MESA_FROM)
setnum(MESA_TO_EDIT, MESA_TO)
