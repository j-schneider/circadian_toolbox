function [pk,px]=song_peaks(x,threshold)

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
noise=mean(abs(x-mean(x))) % approx noise level as average
[pk,px]=findpeaks(abs(x));
trupeaks=find(pk>(threshold*noise));
px=px(trupeaks);
pk=x(px);
