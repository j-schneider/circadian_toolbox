function [ri,rs,px]=rindex(a,int,peakrange)
%RINDEX Compute rhytmicity indexes (RI & RS)
% [ri,rs,px]=rindex(a,int,peakrange)
%
% Computes autocorrelation of data vector and
% computes rhytmicity index and strength. 
%
% inputs: 
% a: fly data matrix (one column)
% int: sampling interval (default: 60)
% peakrange lower and upper bound to find peak (default: 24+[15 33])
%
% NOTE: We usually define the rhytmicity index as the height
% of the SECOND peak, thus we look for it in the range 24+[15 33]. 
%
% ri=peak height ("Rhytmicity index")
% rs=peak height/confidence interval ("Rhytmicity strength")
% peakx=location of peak/24
%
% see also: autocoplot (which does a graphic rendition)

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
if nargin<2
  int=60;
end
if nargin<3
  peakrange=24+[15 33];
end

[ac,x,ci]=autoco(a,60/int);
[ri,rs,px]=rindex_raw(ac,x,ci,peakrange);
