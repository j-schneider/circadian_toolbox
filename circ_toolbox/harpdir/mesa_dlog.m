function varargout = mesa_dlog(varargin)
% event handler for MESA dialog in HARP

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
global MESA_ORDER
global MESA_FROM
global MESA_TO
global MESA_ORDER_EDIT
global MESA_FROM_EDIT
global MESA_TO_EDIT

MESA_ORDER = uinum(MESA_ORDER_EDIT);
MESA_FROM = uinum(MESA_FROM_EDIT);
MESA_TO   = uinum(MESA_TO_EDIT);

do_mesa

close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = order_edit_Callback(h, eventdata, handles, varargin)
global MESA_ORDER
forcenum(h, MESA_ORDER);

% --------------------------------------------------------------------
function varargout = from_edit_Callback(h, eventdata, handles, varargin)
global MESA_FROM
forcenum(h, MESA_FROM);


% --------------------------------------------------------------------
function varargout = to_edit_Callback(h, eventdata, handles, varargin)
global MESA_TO
forcenum(h, MESA_TO)


