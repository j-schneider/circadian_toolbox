clf

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
cyc_bouts_simon('cacts2low/t/cacts2low3d.cyc', 8, .1, ...
		8, '', '', [0 20 40 60])
cyc_bouts_simon('cacts2low/t/cacts2low5d.cyc', 8, .1, ...
		9, '', '', [])

cyc_bouts_simon('cacts2high/t/cacts2h2d.cyc', 8, .1, ...
		11, '', '', [0 20 40 60])
cyc_bouts_simon('cacts2high/t/cacts2h11d.cyc', 8, .1, ...
		12, '', '', [])

cyc_bouts_simon('cacs20/t/ap9505v00500d.cyc', 8, .1, ...
		14, '', 'PERCENT', [0 20 40 60])
cyc_bouts_simon('cacs20/t/ap9505v03500d.cyc', 8, .1, ...
		15, '', '', [])

cyc_bouts_simon('cacs30 degrees/t/ap9629v05500d.cyc', 8, .1, ...
		17, '', '', [0 20 40 60])
cyc_bouts_simon('cacs30 degrees/t/ap9631v02500d.cyc', 8, .1, ...
                18, '', '', [])

cyc_bouts_simon('cs20deg/t/csmfL1d.cyc', 8, .1, ...
		20, '', '', [0 20 40 60])
cyc_bouts_simon('cs20deg/t/csmfL3d.cyc', 8, .1, ...
		21, 'CPP CATEGORIES', '', [])

cyc_bouts_simon('cs30deg/t/csmfh3d.cyc', 8, .1, ...
		23, '', '', [0 20 40 60])
cyc_bouts_simon('cs30deg/t/csmfh15d.cyc', 8, .1, ...
		24, '', '', [])


subplot(4,6,7), text(-.25, .5, 'CACTS2'), axis off
subplot(4,6,13), text(-.25, .5, 'CACS'), axis off
subplot(4,6,19), text(-.25, .5, 'WT'), axis off

subplot(4,5,2), text(.3, 0, '20 deg C'), axis off
subplot(4,5,4), text(.9, 0, '30 deg C'), axis off

title('Fig. 5', 'FontSize',24, 'Position',[-1 .6 9])