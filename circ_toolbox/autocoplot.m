function [ri,rs,px]=autocoplot(a,int,peakrange)
%AUTOCOPLOT Autocorrelation calc & graph
% [ri,rs,px]=autocoplot(a,int,peakrange)
%
% Computes autocorrelation of data vector a
% and makes a nice graph of it. 
% calls autoco to compute autocorrelation,
% followed by acplot to make the graph. 
%
% int: sampling interval (minutes) (default:60)
%
% peakrange: if provided, will find highest
% peak in (double) that range and mark its position 
% in the graph. The hour of the max autocorrelation
% peak and rhytmicity index are computed. (default: no peak analysis)

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
% see also: mesaplot,acplot,autoco,rindex

if nargin<2
  int=60;
end
if nargin<3
  peakrange=[];
end

[ac,x,ci]=autoco(a,60/int);
[ri,rs,px]=acplot(ac,x,ci,peakrange);
