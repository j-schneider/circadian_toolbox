function grouprayleigh(o1,start,stop,filter_hours)
%PEAKCIRCPLOT plots rayleigh test using:
%
% solopeakcircplot(o1,start,stop,filter_hours)
% uses peakphase to find the peaks of an averaged groups o1 and
% then uses circular statistics to plot the average phases
%
% o1: group of flies
% start: number of first valid bin (or 0 to start from the beginning)(default:0)
% stop: number of last valid bin (or 0 to use all) (default:0)
% filter_hours: number of hours on the butterworth filter (default:8)
%
% Figure 1: uses the averaged signal
% Figure 2: uses the circular peak for each fly
%
% ex: solopeakcircplot(o1)

if nargin<3
    start=0;
end
if nargin<4
    stop=0;
end
if nargin<5
    filter_hours=8;
end
if ~exist('o1.first')
    o1.first=1;
end
if ~exist('o1.daylight')
    o1.daylight=[];
end
o1=dam_truncate(o1,start,stop,'bins');
[phi1]=peakphase(o1.f,o1.int,filter_hours);
rayleigh2(phi1);
