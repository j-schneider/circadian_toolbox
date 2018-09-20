function inds = ls_crop_button_cb(obj,eventdata)

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
% NOTE-TO SELF: 
%   - must crop not just song, but all other related
%     vectors if they exist

%global ZOOM_MODE
global SONG
global SCALE
global LAST_POINT
global CURR_POINT
global SAMRAT

x = CURR_POINT;
last_x = LAST_POINT(1,1); %last point as in "last point visited
                          %before current point"
			  
if x > last_x
  xbeg = round(last_x*SAMRAT);
  xend = round(x*SAMRAT);
else
  xbeg = round(x*SAMRAT);
  xend = round(last_x*SAMRAT);
end

if (xend > length(SONG))
  xend = length(SONG)
end

if ((xbeg >= 0) && (xend <= length(SONG)))
  if (length(SONG) > 0)
  %inds = find ((SONG(:,1) >= start) & (SONG(:,1) <= stop));
  
  %beg = inds(1)-1;
  %fin = inds(length(inds))+1;
  
  % remove those indices
  
  if ((xbeg >= 1) & (xend <= length(SONG)))
    SONG = [SONG(1:xbeg,:);SONG(xend:length(SONG),:)];
  elseif ((xbeg < 1) && (xend > length(SONG)))
    SONG = [];
  elseif (xbeg < 1)
    SONG = SONG(xend:length(SONG),:);
  elseif (xend > length(SONG))
    SONG = SONG(1:xbeg,:);
  end
  
  plot_song;
  %moveto(start, stop);

  end
end
