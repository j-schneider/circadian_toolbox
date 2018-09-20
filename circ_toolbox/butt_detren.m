function y=butt_detren(x)
%BUTT_DETREN no longer in use
%
%  y=butt_detren(x)
% utilizes a butterworth filter (high pass)
% of order four to eliminate long term trends
% the filter was obtained with:
% [A,B]=butter(4,2/72,'high')
% which means: Assuming your sampling rate is 1Hz
% (one-per-hour), all periods longer than 72 hours
% are eliminated. 
% then filtfilt is called to perform the filtering
% SEE ALSO: notrend and nologtrend
%

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
B=[ 0.89220304164446  -3.56881216657785 5.35321824986678  ...
    -3.56881216657785 ...
    0.89220304164446 ];
A=[  1.00000000000000  -3.77199674872359  5.34162400300699 ...
     -3.36560164705068 0.79602626753014 ];
y=filtfilt(B,A,x);
