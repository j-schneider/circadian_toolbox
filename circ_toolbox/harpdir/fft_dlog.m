function varargout = fft_dlog(varargin)
% event handler for FFT dialog in HARP

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
global FFT_FROM
global FFT_TO
global FFT_FROM_EDIT
global FFT_TO_EDIT

FFT_FROM = uinum(FFT_FROM_EDIT);
FFT_TO   = uinum(FFT_TO_EDIT);

do_fft

close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = from_edit_Callback(h, eventdata, handles, varargin)
global FFT_FROM
forcenum(h, FFT_FROM);


% --------------------------------------------------------------------
function varargout = to_edit_Callback(h, eventdata, handles, varargin)
global FFT_TO
forcenum(h, FFT_TO)


