function harp_dam_menu(ab)
% HARP menu callback for DAM Load

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
global INCUBATOR

global DAM_PREFIX
global DAM_DIR
global DAM_USELIGHT
global DAM_LIGHTNAME
global DAM_WHICH
global DAM_MONITOR_COUNT
global DAM_POSITION_COUNT

global DAM_PREFIX_EDIT
global DAM_DIR_EDIT
global DAM_LIGHTNAME_EDIT
global DAM_DAYLIGHT_BROWSE
global DAM_SELECT_MENUS
global DAM_MODE

DAM_WHICH = ab;

DAM_MODE = 0;

fig = openfig('dam.fig','reuse');

if DAM_WHICH == 1
  which = 'A';
else
  which = 'B';
end
set(fig, 'Name', ['HARP: DAM Load ' which])

kids = get(fig, 'Children');

DAM_PREFIX_EDIT = kids(7);
DAM_DIR_EDIT = kids(4);
DAM_LIGHTNAME_EDIT = kids(3);
DAM_DAYLIGHT_BROWSE = kids(2);

settxt(DAM_PREFIX_EDIT, DAM_PREFIX)
settxt(DAM_DIR_EDIT, DAM_DIR)
settxt(DAM_LIGHTNAME_EDIT, DAM_LIGHTNAME)

if isempty(DAM_DIR)
  settxt(DAM_DIR_EDIT, cd)
end
