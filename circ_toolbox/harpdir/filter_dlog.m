function varargout = filter_dlog(varargin)
% event handler for filter dialog in HARP

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
global FILTER_ORDER
global FILTER_TWICE
global FILTER_LO_HOURS
global FILTER_HI_HOURS

global FILTER_ORDER_EDIT
global FILTER_TWICE_CBOX
global FILTER_LO_HOURS_EDIT
global FILTER_HI_HOURS_EDIT

if uival(FILTER_TWICE_CBOX) ,FILTER_TWICE = 1; end
FILTER_ORDER = uinum(FILTER_ORDER_EDIT);
FILTER_LO_HOURS = uinum(FILTER_LO_HOURS_EDIT);
FILTER_HI_HOURS = uinum(FILTER_HI_HOURS_EDIT);
do_filter
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = order_edit_Callback(h, eventdata, handles, varargin)
global FILTER_ORDER
forcenum(h, FILTER_ORDER);

% --------------------------------------------------------------------
function varargout = lo_edit_Callback(h, eventdata, handles, varargin)
global FILTER_LO_HOURS
forcenum(h, FILTER_LO_HOURS);


% --------------------------------------------------------------------
function varargout = hi_edit_Callback(h, eventdata, handles, varargin)
global FILTER_HI_HOURS
forcenum(h, FILTER_HI_HOURS)
