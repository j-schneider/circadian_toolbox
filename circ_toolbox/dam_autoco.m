function dam_autoco(o,wells,filter_hours,acPeak,peakRange)
%DAM_AUTOCO Auto-correlation of DAM data
% dam_autoco(o,wells,filter_hours,acPeak,peakRange)
% o: object loaded with dam_load
% wells: fly (column no) (flies to be averaged)
% filter_hours: hours for butterworth filter (default: 0=no filter)
% acPeak: n-th peak to look for (default: 2)
% peakRange: where to search for peak (default: [16 32])

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<3
    filter_hours=0;
end
if nargin<4
    acPeak=2;
end
if nargin<5
    peakRange=[16 32];
end
f=mean(o.f(:,wells),2);
if filter_hours>0
    filterf=butt_filter(f,filter_hours/o.int*60);
else
    filterf=f;
end
[ac,xx,ci]=autoco(filterf,60/o.int);
rindex=acplot(ac,xx,ci,(acPeak-1)*24+peakRange);
