function Y=butt2p(x)
%BUTT2P 2-Pole Butterworth filter from literature
%
% Use butt_filter instead for generic butterworth filtering
% 
% 2 pole butterworth filter
% Y=butt2p(x)
% As per Hamblen-Coyle, et. al., J. of Ins. Beh. 5:417 (1992)
%
% See also: butter2p, Wheeler version (slower).
% Note: a,b correspond to butterworth 2,6.8, or something like that

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
A = 16.94427;                                                      
B = -6.119634;                                                     
C = 14.82464;                                                     
a=[C,-A,-B];
b=[1,2,1];
z=[(a(1)-b(1))*x(1)/a(1), ...
   ((a(1)-b(1))*x(2)+(a(2)-b(2))*x(1))/ a(1)];
Y=filter(b,a,x,z);

