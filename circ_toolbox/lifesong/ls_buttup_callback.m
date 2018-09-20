function ls_buttup_callback

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
% called when mouse button is released; will zoom in on current
% highlighted region if mouse was dragged long enough

global LAST_POINT
global LAST_LINE
global CURR_POINT
global BUTTDOWN
global BUTTONID
global PLAY_MODE
global ZOOM_MODE
global SONG
global SCALE
global PREV_SCALE_STACK


% zoom only if left button released
if ~strcmp(BUTTONID, 'normal'), return, end

BUTTDOWN = 0;

point = get(gca, 'CurrentPoint');

x = point(1,1);
CURR_POINT = x;
last_x = LAST_POINT(1,1);

% LAST_LINE is giant highlighting line
if LAST_LINE, delete(LAST_LINE), end
LAST_LINE = 0;
  
% always go zoom between earlier time and later
if x > last_x
  xbeg = last_x;
  xend = x;
else
  xbeg = x;
  xend = last_x;
end

% only handle in-place clicks
if xend > xbeg

  % zoom by resetting axes
%if ( ~(btnstate(gcf,'PlayZoomButtons','Zoom')))
if (ZOOM_MODE) 
  PREV_SCALE_STACK = stack_push(PREV_SCALE_STACK,SCALE(1),SCALE(2))
  SCALE = [xbeg xend]
  moveto(xbeg, xend);
  set(gca,'YLimMode','auto')
  %axis tight;
end
if (PLAY_MODE)
  song_play(SONG,xbeg,(xend-xbeg))
end
%    sprintf('playing: %d thru %d, (%d)\n',xbeg,xend,(xend - xbeg));
%end

%if ( ~(btnstate(gcf,'PlayZoomButtons','Play')))
%    song_play(SONG,xbeg,(xend-xbeg))
%    disp('Hi! I am playing the selection!') 
%end
end

  

