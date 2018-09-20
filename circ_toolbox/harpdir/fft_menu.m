function fft_menu
% menu callback for HARP Plot/FFT

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
global FFT_FROM
global FFT_TO
global FFT_ORDER_EDIT
global FFT_FROM_EDIT
global FFT_TO_EDIT

fig = openfig('fft.fig','reuse');

set(fig, 'Name', ['HARP/FFT'])

kids = get(fig, 'Children');

FFT_FROM_EDIT = kids(2);
FFT_TO_EDIT = kids(1);
  
setnum(FFT_FROM_EDIT, FFT_FROM)
setnum(FFT_TO_EDIT, FFT_TO)
