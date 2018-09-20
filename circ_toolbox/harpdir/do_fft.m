function do_fft
% Use PER_PLOT to display FFT with current global data and settings
% from HARP

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
SKIP = 5; % how many initial values to ignore

global FFT_FROM
global FFT_TO

x = cleanup;

setup

[per,y] = per_plot(x);

maketitle('FFT')

set(gca, 'XLim', [FFT_FROM FFT_TO])

pkreport(per, y, FFT_FROM, FFT_TO)

