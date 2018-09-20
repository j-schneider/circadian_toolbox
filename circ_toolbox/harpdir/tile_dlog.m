function varargout = tile_dlog(varargin)
% event handler for plot-tiling dialog in HARP

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
if nargin == 0  % LAUNCH GUI

  fig = openfig(mfilename,'reuse');

  % Use system color scheme for figure:
  set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

  % Generate a structure of handles to pass to callbacks, and store it. 
  handles = guihandles(fig);
  guidata(fig, handles);

  if nargout > 0
    varargout{1} = fig;
  end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end



% --------------------------------------------------------------------
function varargout = okay_Callback(h, eventdata, handles, varargin)
global TILE_ROWS
global TILE_COLS
global TILE_ROWS_EDIT
global TILE_COLS_EDIT
TILE_ROWS = uinum(TILE_ROWS_EDIT);
TILE_COLS = uinum(TILE_COLS_EDIT);

close(get(h, 'Parent'))

set_layout(3) % tile mode


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = rows_edit_Callback(h, eventdata, handles, varargin)
global TILE_ROWS
forcenum(h, TILE_ROWS)


% --------------------------------------------------------------------
function varargout = cols_edit_Callback(h, eventdata, handles, varargin)
global TILE_COLS
forcenum(h, TILE_COLS)
