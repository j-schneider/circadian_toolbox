function song_play(x,start,width)
% SONG_PLAY(X, START, WIDTH) plays the (2000 hz) song samples X
% beginning at START seconds from the beginning and lasting for WIDTH
% seconds.  Default start is first sample, default width is whole song.

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
% default to whole song


my_matlab_supports_2k=0;

a = 1;
b = length(x);

 
if nargin == 3

  a = 2000*start;
  b = a + 2000*width;

end

data=x(round(a:b));
data=data/max(abs(data))/2;

if (my_matlab_supports_2k)
  % this ought to be right if matlab would actually
  % play the song at 2000 hz as help sound says.
  
  sound(data, 2000);

else
  
  % quick-and-dirty resample to 4096
  % just because matlab-sgi refuses to play lower
  % frequencies than that, or so it appears after
  % some trial-and error
  
  data_2k=data;
  len=length(data_2k);
  data_4k=interp1(1:len,data_2k,1:.5:len);
  sound(data_4k,4000);
end
  
