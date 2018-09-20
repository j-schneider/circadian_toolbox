function varargout = phase_dlog(varargin)
% event handler for DAM PHASE dialog in HARP

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
global PHASE_LOPASS_HOURS
global PHASE_NORMALIZE
global PHASE_FIRST_HOUR
global PHASE_PERIOD_EDIT

global PHASE_LOPASS_EDIT
global PHASE_NORMALIZE_CHKBOX
global PHASE_FHOUR_EDIT
global PHASE_PERIOD

PHASE_LOPASS_HOURS = uinum(PHASE_LOPASS_EDIT);
PHASE_PERIOD = uinum(PHASE_PERIOD_EDIT);
PHASE_NORMALIZE = uival(PHASE_NORMALIZE_CHKBOX);

if enabled(PHASE_FHOUR_EDIT)
  PHASE_FIRST_HOUR = uinum(PHASE_FHOUR_EDIT);
end

close(get(h, 'Parent'))

do_phase


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = lo_edit_Callback(h, eventdata, handles, varargin)
global PHASE_LOPASS_HOURS
forcenum(h, PHASE_LOPASS_HOURS);

% --------------------------------------------------------------------
function varargout = fhour_edit_Callback(h, eventdata, handles, varargin)
global PHASE_FIRST_HOUR
forcenum(h, PHASE_FIRST_HOUR);

% --------------------------------------------------------------------
function varargout = period_edit_Callback(h, eventdata, handles, varargin)
global PHASE_PERIOD
forcenum(h, PHASE_PERIOD);
