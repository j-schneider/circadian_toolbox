function varargout = trunc_dlog(varargin)
% event handler for truncation dialog in HARP

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
global TRUNC_BINS
global TRUNC_BINS_RADIO
global TRUNC_SNAP_CHKBOX
global TRUNC_MIN
global TRUNC_MAX
global TRUNC_SNAP

TRUNC_BINS = uival(TRUNC_BINS_RADIO);
TRUNC_SNAP = uival(TRUNC_SNAP_CHKBOX);

close(get(h, 'Parent'))

do_trunc


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = bins_radio_Callback(h, eventdata, handles, varargin)
% callback for 'Bins' radio: impelements mutual exclusion of
% truncation by bins or days
global TRUNC_BINS_RADIO
global TRUNC_DAYS_RADIO
turnon(TRUNC_BINS_RADIO)
turnoff(TRUNC_DAYS_RADIO)
trunc_axis(1)

% --------------------------------------------------------------------
function varargout = days_radio_Callback(h, eventdata, handles, varargin)
% callback for 'Days' radio: impelements mutual exclusion of
% truncation by bins or days
global TRUNC_BINS_RADIO
global TRUNC_DAYS_RADIO
turnoff(TRUNC_BINS_RADIO)
turnon(TRUNC_DAYS_RADIO)
trunc_axis(0)

% --------------------------------------------------------------------
function varargout = slider_Callback(h, eventdata, handles, varargin)
% callback for sliders

global TRUNC_SNAP_CHKBOX

if enabled(TRUNC_SNAP_CHKBOX) & uival(TRUNC_SNAP_CHKBOX)
  trunc_snap
end

ylim = get(gca, 'YLim');
newx = get(gcbo, 'Value');

trunc_update_limits(h, newx)

% --------------------------------------------------------------------
function varargout = snap_chkbox_Callback(h, eventdata, handles, varargin)

if uival(h)
  trunc_snap
end


% --------------------------------------------------------------------
function varargout = min_edit_Callback(h, eventdata, handles, varargin)

global TRUNC_MIN_SLIDER
global TRUNC_SNAP_CHKBOX

orig = get(TRUNC_MIN_SLIDER, 'Value');

forcenum(h, orig)

val = uinum(h);

if val > get(TRUNC_MIN_SLIDER, 'Max')
  val = orig;
  set(h, 'String', num2str(val))
end

set(TRUNC_MIN_SLIDER, 'Value', val)

if enabled(TRUNC_SNAP_CHKBOX) & uival(TRUNC_SNAP_CHKBOX)
  trunc_snap
else
  plot_trunc_limit(orig)
  plot_trunc_limit(val)
end

% --------------------------------------------------------------------
function varargout = max_edit_Callback(h, eventdata, handles, varargin)

global TRUNC_MAX_SLIDER
global TRUNC_SNAP_CHKBOX

orig = get(TRUNC_MAX_SLIDER, 'Value');

forcenum(h, orig)

val = uinum(h);

if val > get(TRUNC_MAX_SLIDER, 'Max')
  val = orig;
  set(h, 'String', num2str(val))
end

set(TRUNC_MAX_SLIDER, 'Value', val)

if enabled(TRUNC_SNAP_CHKBOX) & uival(TRUNC_SNAP_CHKBOX)
  trunc_snap
else
  plot_trunc_limit(orig)
  plot_trunc_limit(val)
end


