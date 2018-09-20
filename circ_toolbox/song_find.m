function [ev,py,px]=song_find(y)

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
signal_to_noise=4;
min_interval=200; % milliseconds btw bouts
min_duration=150; % min length of a bout
freq=2000; % samples-per-second
if (size(y,1)>1) 
  y=y';
end
[py,px]=song_peaks(y,signal_to_noise);
py=[y(1),py,y(end)];
px=[1,px,length(y)];
holes=px(2:end)-px(1:end-1);  % distance-btw-peaks
sampinterval=(min_interval/1000)*freq;
bigholes=find(holes>sampinterval);

nobegins=px(bigholes);
noends=px(bigholes+1);

boutbegins=noends(1:end-1);
boutends=nobegins(2:end);
boutsizes=boutends-boutbegins;
bigenough=find(boutsizes>(min_duration/1000*freq));
boutends=boutends(bigenough);
boutbegins=boutbegins(bigenough);
boutsizes=boutends-boutbegins;
ev=[boutbegins'/freq,boutends'/freq];

