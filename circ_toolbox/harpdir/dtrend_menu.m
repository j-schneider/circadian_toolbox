function dtrend_menu
% menu callback for HARP Modify/Detrend

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
global DTREND_MODE
global DTREND_LIN_RADIO
global DTREND_LOG_RADIO

fig = openfig('dtrend.fig','reuse');

kids = get(fig, 'Children');

DTREND_LIN_RADIO = kids(3);
DTREND_LOG_RADIO = kids(2);

% disable logarithmic if zeros in data
if zero_data
  set(DTREND_LOG_RADIO, 'Enable', 'off')
else
  set(DTREND_LOG_RADIO, 'Enable', 'on')
end

switch DTREND_MODE
  
 case 2 % logarithmic
  
  turnoff(DTREND_LIN_RADIO)
  turnon(DTREND_LOG_RADIO)
  
 otherwise % linear
  
  turnon(DTREND_LIN_RADIO)
  turnoff(DTREND_LOG_RADIO)
    
end

