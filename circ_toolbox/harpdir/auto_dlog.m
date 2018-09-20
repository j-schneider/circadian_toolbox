function varargout = auto_dlog(varargin)

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
global AUTO_PEAK_FROM_HOURS
global AUTO_PEAK_TO_HOURS
global AUTO_PEAK_FROM_HOURS_EDIT
global AUTO_PEAK_TO_HOURS_EDIT
AUTO_PEAK_FROM_HOURS = uinum(AUTO_PEAK_FROM_HOURS_EDIT);
AUTO_PEAK_TO_HOURS = uinum(AUTO_PEAK_TO_HOURS_EDIT);

close(get(h, 'Parent'))

do_auto


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))


% --------------------------------------------------------------------
function varargout = peak_from_edit_Callback(h, eventdata, handles, varargin)
global AUTO_PEAK_FROM_HOURS
forcenum(h, AUTO_PEAK_FROM_HOURS)


% --------------------------------------------------------------------
function varargout = peak_to_edit_Callback(h, eventdata, handles, varargin)
global AUTO_PEAK_TO_HOURS
forcenum(h, AUTO_PEAK_TO_HOURS)
