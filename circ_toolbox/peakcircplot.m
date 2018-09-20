function peakcircplot(o1,o2,start,stop,filter_hours,which);
%PEAKCIRCPLOT Compare two groups' peaks and plot peaks and delay
%
% Compare to PEAKPHASEPLOT
% 
% peakcircplot(o1,o2,start,stop,filter_hours,which)
% uses peakphase to find the peaks of averaged groups o1 and o2
% then uses circular statistics to plot the average phases and
% difference, and test. 
%
% o1: first (control) group of flies
% o2: second(experiment) group of flies
% start: number of first valid bin (or 0 to start from the beginning)(default:0)
% stop: number of last valid bin (or 0 to use all) (default:0)
% filter_hours: number of hours on the butterworth filter (default:8)
% 
% there's three figures in this plot:
% figure 1: uses the averaged signal (as in peakphaseplot)
% figure 2: uses the circular peak for each fly (as in peakphase(o1,...)) 
%           (multiple_test)
% figure 3: same as 2 (bivariate).
%
% The optional which parameter controls which figures will be shown:
% [1,1,1] shows all three figures; [0,1,0] shows figure two only, 
% and so on. 
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
clf;
if nargin<3
  start=0;
end
if nargin<4
  stop=0;
end
if nargin<5 
  filter_hours=8; % filter hours
end
if nargin<6
   which=[1 1 1];
end
nfigs=sum(which)
figno=0;
o1=dam_truncate(o1,start,stop,'bins');
o2=dam_truncate(o2,start,stop,'bins');

dir1=sprintf('%s:%s',o1.names{1},o1.names{length(o1.names)});
dir2=sprintf('%s:%s',o2.names{1},o2.names{length(o2.names)});

d1=mean(o1.f,2);
d2=mean(o2.f,2);

clf
if (which(1))
    figno=figno+1;
    mksubplot(nfigs,figno);
    [off,sem,all,r]=peakphase(d1,o1.int,filter_hours);
    peaks1=all{1};
    [off,sem,all,r]=peakphase(d2,o2.int,filter_hours);
    peaks2=all{1};
    hourtest(peaks1,peaks2,0,'b*','ro');
    %title(sprintf('%s(*) %s(o)',dir1,dir2));
end
[phi1,c1,c2,rho1]=peakphase(o1.f,o1.int,filter_hours);
[phi2,c1,c2,rho2]=peakphase(o2.f,o2.int,filter_hours);
if which(2)
    figno=figno+1; mksubplot(nfigs,figno);
    multiple_test(phi1,phi2,0,0,0,'b','r');
    %title(sprintf('%s(*) %s(o)',dir1,dir2));
end
if which(3)
    figno=figno+1; mksubplot(nfigs,figno)
    bivariate(phi1,rho1,phi2,rho2,0,0,'b','r');
end

function mksubplot(nfigs,figno)
if nfigs==3 & figno==3
    subplot(2,1,2);
elseif nfigs==3
    subplot(2,2,figno);
elseif nfigs==2
    subplot(1,2,figno);
end