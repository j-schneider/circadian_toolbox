function do_acto
% call actogram() using current global data and settings from HARP

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
global CURRENT_RECORD_NAME
global MIN_PER_BIN
global ACTO_LO
global ACTO_HI
global ACTO_REPS
global ACTO_BASELINE

[y,beg] = cleanup;

start = beg / (60/MIN_PER_BIN);
int = MIN_PER_BIN;

mode = 2; % bar graph
lights = getlights(beg);
cutoff = [ACTO_LO ACTO_HI];

hours = bin2hrs(ACTO_BASELINE);

setup

actogram(y, start, int, mode, lights, cutoff, hours, ACTO_REPS)

maketitle('Actogram')


