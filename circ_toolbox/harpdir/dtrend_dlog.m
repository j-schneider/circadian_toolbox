function varargout = dtrend_dlog(varargin)
% event handler for HARP detrend dialog

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
global DTREND_MODE

global DTREND_LOG_RADIO
if uival(DTREND_LOG_RADIO)
  DTREND_MODE = 2;
else
  DTREND_MODE = 1;
end

close(get(h, 'Parent'))

do_dtrend

% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))

% --------------------------------------------------------------------
function varargout = lin_radio_Callback(h, eventdata, handles, varargin)
global DTREND_LIN_RADIO
global DTREND_LOG_RADIO
turnon(DTREND_LIN_RADIO)
turnoff(DTREND_LOG_RADIO)


% --------------------------------------------------------------------
function varargout = log_radio_Callback(h, eventdata, handles, varargin)
global DTREND_LIN_RADIO
global DTREND_LOG_RADIO
turnoff(DTREND_LIN_RADIO)
turnon(DTREND_LOG_RADIO)
