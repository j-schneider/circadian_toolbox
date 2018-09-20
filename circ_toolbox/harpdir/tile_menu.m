function tile_menu
% menu callback for HARP Plot/Layout/Tile

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
global TILE_ROWS
global TILE_COLS

global TILE_ROWS_EDIT
global TILE_COLS_EDIT

fig = openfig('tile.fig','reuse');

kids = get(fig, 'Children');

TILE_ROWS_EDIT = kids(4);
TILE_COLS_EDIT = kids(2);

setnum(TILE_ROWS_EDIT, TILE_ROWS)
setnum(TILE_COLS_EDIT, TILE_COLS)
