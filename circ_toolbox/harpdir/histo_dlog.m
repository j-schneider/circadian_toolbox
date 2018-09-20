function varargout = histo_dlog(varargin)
% event handler for histogram dialog in HARP

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
global HISTO_BASELINE
global HISTO_FORMAT
global HISTO_HOURS_MIN
global HISTO_HOURS_MAX
global INCUBATOR
global DAYLIGHTS

global HISTO_BASELINE_EDIT
global HISTO_RADIO_NORMAL
global HISTO_RADIO_CENTER_LIGHT
global HISTO_RADIO_CENTER_DARK
global HISTO_RADIO_ON_TO_OFF
global HISTO_RADIO_OFF_TO_ON

HISTO_BASELINE = uinum(HISTO_BASELINE_EDIT);

if ~isempty(DAYLIGHTS)
  INCUBATOR = choose_incubator;
end

hours = bin2hrs(HISTO_BASELINE);

if hours < HISTO_HOURS_MIN | hours > HISTO_HOURS_MAX
  HISTO_FORMAT = 0;
elseif uival(HISTO_RADIO_NORMAL)
  HISTO_FORMAT = 0;
elseif uival(HISTO_RADIO_CENTER_LIGHT)
  HISTO_FORMAT = 1;
elseif uival(HISTO_RADIO_CENTER_DARK)
  HISTO_FORMAT = 2;
elseif uival(HISTO_RADIO_ON_TO_OFF)
  HISTO_FORMAT = 3;
else
  HISTO_FORMAT = 4;
end

close(get(h, 'Parent'))

do_hist

% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))

% --------------------------------------------------------------------
function varargout = hours_edit_Callback(h, eventdata, handles, varargin)
global HISTO_BASELINE_EDIT
global HISTO_BASELINE_TEXT
global DAYLIGHTS
forcenum(h, HISTO_BASELINE_EDIT);
baseline = uinum(h);
show_baseline_hours(baseline, HISTO_BASELINE_TEXT)
if ~isempty(DAYLIGHTS)
  incubator = choose_incubator;
  toggle_histo_radio(incubator, baseline)
end