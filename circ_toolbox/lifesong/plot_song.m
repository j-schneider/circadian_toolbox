function plot_song

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
global SONG
global SAMRAT
global SCALE

cla

xrange = (0:length(SONG)-1)/SAMRAT;

%set current scale
SCALE(1) = 0;
SCALE(2) = (length(SONG)-1)/SAMRAT;

h = plot(xrange,SONG);
moveto(SCALE(1),SCALE(2));
% reset axes appropriately
set(gca,'YLimMode','auto')
%axis tight;
hold on

