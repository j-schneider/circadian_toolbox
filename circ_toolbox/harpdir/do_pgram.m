function do_pgram
% call pgram() using current global data and settings from HARP

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
global PGRAM_FROM_HOURS
global PGRAM_TO_HOURS
global PGRAM_CONF

y = cleanup;

int = MIN_PER_BIN;
beghrs = PGRAM_FROM_HOURS;
endhrs = PGRAM_TO_HOURS;
conf = PGRAM_CONF;

setup

pgram(y, beghrs, endhrs, conf, int)

maketitle('Periodogram')


