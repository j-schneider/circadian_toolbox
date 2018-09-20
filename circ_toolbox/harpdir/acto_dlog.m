function varargout = acto_dlog(varargin)
% Dialog event handler for HARP Actogram specification

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
if ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end

% --------------------------------------------------------------------
function varargout = okay_Callback(h, eventdata, handles, varargin)
global ACTO_REPS
global ACTO_BIN
global ACTO_BASELINE
global ACTO_LO
global ACTO_HI
global ACTO_BIN_EDIT
global ACTO_BASELINE_EDIT
global ACTO_LO_EDIT
global ACTO_HI_EDIT
global INCUBATOR

global ACTO_DOUBLE_RADIO
if uival(ACTO_DOUBLE_RADIO)
  ACTO_REPS = 2;
else
  ACTO_REPS = 1;
end

INCUBATOR = choose_incubator;

ACTO_LO = uinum(ACTO_LO_EDIT);
ACTO_HI   = uinum(ACTO_HI_EDIT);
ACTO_BASELINE = uinum(ACTO_BASELINE_EDIT);
ACTO_BIN = uinum(ACTO_BIN_EDIT);

close(get(h, 'Parent'))

do_acto

% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))

% --------------------------------------------------------------------
function varargout = single_radio_Callback(h, eventdata, handles, varargin)
global ACTO_SINGLE_RADIO
global ACTO_DOUBLE_RADIO
turnon(ACTO_SINGLE_RADIO)
turnoff(ACTO_DOUBLE_RADIO)


% --------------------------------------------------------------------
function varargout = double_radio_Callback(h, eventdata, handles, varargin)
global ACTO_SINGLE_RADIO
global ACTO_DOUBLE_RADIO
turnoff(ACTO_SINGLE_RADIO)
turnon(ACTO_DOUBLE_RADIO)


% --------------------------------------------------------------------
function varargout = from_edit_Callback(h, eventdata, handles, varargin)
global ACTO_LO
forcenum(h, ACTO_LO);

% --------------------------------------------------------------------
function varargout = to_edit_Callback(h, eventdata, handles, varargin)
global ACTO_HI
forcenum(h, ACTO_HI)


% --------------------------------------------------------------------
function varargout = bin_edit_Callback(h, eventdata, handles, varargin)
global ACTO_BIN
forcenum(h, ACTO_BIN)


% --------------------------------------------------------------------
function varargout = baseline_edit_Callback(h, eventdata, handles, varargin)
global ACTO_BASELINE
global ACTO_BASELINE_TEXT
forcenum(h, ACTO_BASELINE)
show_baseline_hours(uinum(h), ACTO_BASELINE_TEXT)


