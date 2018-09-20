function song_recenter(name)
%SONG_RECENTER Re-centers a song file around zero
% 
% song_recenter(filename) 
% Subtract the mean value of the signal and re-save
% the song file. This is used to fix a problem with 
% LifeSong/Mac digitizations which sometimes are off 
% zero, specially with low recording volume.
%
% If filename is not supplied, a window to the directory is
% launched. 

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

if nargin<1
  if isunix
    pat='*';
  else
    pat='*.*';
  end
  name=uigetfile('pat','Select a songfile');
end
[x,h,d,e]=song_load(name);
oldmean=round(mean(x));
fprintf('\n%s: Mean was %2.0f\n',name,oldmean);
x=x-oldmean;
d(:,3)=d(:,3)-oldmean;
song_save(name,x,d);
