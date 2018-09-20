function h=song_plot(song,dat,event,start,width,miny)
% SONG_PLOT
%  h=song_plot(x,dat,event,start,width)
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
if isstruct(song)
  % combined song, new format uses different parameter sequence
  % rename and assign. s
  if nargin>=2
    start=dat;
  else
    start=0;
  end
  if nargin>=3
    width=event;
  else
    width=length(song.x)/2000;
  end
  x=song.x;
  dat=song.d;
  event=song.e;
else
  % split song
  x=song;
  if nargin<2 | length(dat)<2
    dat=[];
  end
  if nargin<3 | length(event)<2
    event=[];
  end
  if nargin<4
    start=0;
  end
  if nargin<5
    width=length(x)/2000;
  end
end

a=2000*start+1;
width=2000*width-1;
stop=start+width;
b=a+width;
i=round(a:b);
ilim=[round(a),round(b)];
data=x(i);
if nargin<6
  miny=min(data);
end
h=plot(i/2000,data);

set(gca,'xlim',ilim/2000);
m=max(abs(data));
%set(gca,'ylim',[-m m]);
xlabel('time (s)');
ylabel('db');
if ~isempty(dat)
  hold on
  %datx=dat(1:sh ,1);
  plot(dat(:,1),dat(:,3),'o')
end
if ~isempty(event)
  sym='x+*sdv^<>';
  button=event(:,1);
  in=event(:,3);
  out=event(:,4);
  ypos=miny*(0.9:.07:1.9);
  hold on
  for i=1:length(button)
    b=button(i);
    if (b>=1 & b<=8)
      yp=ypos(b);
      plot([in(i) out(i)],[yp yp],'-');
      plot([in(i) out(i)],[yp yp],sym(b));
    end
  end
end
