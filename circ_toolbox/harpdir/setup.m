function setup
% setup for plotting in HARP

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
global LAYOUT
global PLOTNO
global TILE_ROWS
global TILE_COLS
global MAIN_WINDOW

switch LAYOUT

 case 2    % Replace

  openfig('display', 'reuse');

 case 3    % Tile

  openfig('display', 'reuse');
  subplot(TILE_ROWS, TILE_COLS, PLOTNO)
  PLOTNO = PLOTNO + 1;
  if PLOTNO > (TILE_ROWS*TILE_COLS)
    PLOTNO = 1;
  end

 otherwise % Cascade
  
  openfig('display', 'new');
    
end

