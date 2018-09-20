function [peaks,peakx]=findpeaks(g)
% [p,x]=findpeaks(g)
% finds peaks on vector g
% where peak is: numbers go up, then down
% and returns values (p) and positions (x)

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
n=length(g);
gp=g(1:n-1)-g(2:n);
ud=gp>0;
udp=ud(1:n-2)-ud(2:n-1);
peakx=1+find(udp==-1);
peaks=g(peakx);
