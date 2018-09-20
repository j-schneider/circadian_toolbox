function h=song_multiplot(song,varargin)
% SONG_MULTIPLOT Plot a song in a multi-row format
%  h=song_multiplot(x,dat,event,rows,start,width)

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

% defaults
rows=5;
width=0;
start=0;

if isstruct(song)
  % song_multiplot(song,rows,start,width)
  if length(varargin)>=1
    rows=varargin{1};
  end
  if length(varargin)>=2
    start=varargin{2};
  end
  if length(varargin)>=3
    width=varargin{3};
  end
  dat=song.d;
  event=song.e;
  x=song.x;
else
  x=song;
  if length(varargin)<2 | length(varargin{2})<2
    dat=[];
  else
    dat=varargin{2};
  end
  if length(varargin)<3 | length(varargin{3})<2
    event=[];
  else
    event=varargin{3};
  end
  
  if length(varargin)>=4
    rows=varargin{4};
  end
  if length(varargin)>=5
    start=varargin{5};
  end
  if length(varargin)>=6
    width=varargin{6};
  end
end
if width==0
  width=length(x)/2000;
end
downscale=1;
rw=width/rows;
mix=min(x);
topmax=-inf;
botmin=+inf;
for i=1:rows
  subplot(rows,1,i);
  if ~downscale
    song_plot(x,dat,event,start+(i-1)*rw,rw);
  else
    song_plot(x,dat,event,start+(i-1)*rw,rw,mix);
  end
  if (i<rows)
    xlabel('');
  end
  yl=get(gca,'ylim');
  topmax=max(topmax,yl(2));
  botmin=min(botmin,yl(1));
end
if downscale
  for i=1:rows
    subplot(rows,1,i);
    set(gca,'ylim',[botmin topmax]);
  end
end
