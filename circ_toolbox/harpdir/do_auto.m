function do_auto
% do single autocorrelation, call acplot() using current global data
% and settings from HARP

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
global CURRENT_DATA
global CURRENT_RECORD_NAME
global MIN_PER_BIN

global AUTO_PEAK_FROM_HOURS
global AUTO_PEAK_TO_HOURS

y = cleanup;

bptu = 60/MIN_PER_BIN;
n=size(y,1);
sqn=1.965/sqrt(n);
[r2,x]=xcorr(y,[ceil(72*bptu)],'coeff');
if (size(r2,1)>1), r2=r2'; end
ac= r2';
ci=sqn;
x=x' ./ bptu;

setup

acplot(ac, x, ci, [AUTO_PEAK_FROM_HOURS AUTO_PEAK_TO_HOURS]);

maketitle('Autocorrelation')

