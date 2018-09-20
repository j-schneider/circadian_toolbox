function err=wingsongid(x,e,n,button)
% WINGSONGID
% wingsongid(x,e,n[,button])
% where x is song data and e the events
% we look for wing extension segments (event 3, or choose button)
% and grab the n-th segment
% and plot that segment of song
% and play the sound
% and plot the fft of the segment
% and slightly smooth it with a butterworth filter
% and find primary and secondary peak
% and test that
% primary peak is [210 250]
% secondary peak is about 60% as high as primary peak
% secondary peak is about 20% higher frequency as primary
% if all three above are true
% then we call this a 'song'
%
% use n=0 to run through all bouts in the song.
% use n=[start stop] to evaluate just a segment

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


min_duration=0.4; % half a second is min duration

if nargin<4
  button=3;
end


if (nargin<3 | (length(n)==1 & n==0))
  ev=e(find(e(:,1)==button),:);
  for i=1:size(ev,1)
    duration=ev(i,4)-ev(i,3);
    figure(i);
    if duration > min_duration
      err{i}=wingsongid(x,e,i,button); 
    else
      err{i}='segment too short';
    end
    subplot(2,1,1)
    title(sprintf('Bout %d: duration=%3.3f s (%s)',i,duration,err{i}));
  end
  return;
end

if length(n) > 1
  start=n(1);
  stop=n(2);
else
  ev=e(find(e(:,1)==button),:);
  ev=ev(n,:);
  start=ev(3);
  stop=ev(4);
end
clf
subplot(2,1,1);
song_plot(x,[],e);

set(gca,'xlim',[start stop]);
drawnow;
s=x(round(start*2000):round(stop*2000));
subplot(2,1,2);

[power,freq]=simplefft(s,2000);
power=butt_filter(power,length(freq)*5/(freq(end)-freq(1)));
plot(freq,power);
[pp,px]=findpeaks(power);
pfreq=freq(px);
speaks=[pp,pfreq'];
speaks=sortrows(speaks);
speaks=speaks(size(speaks,1):-1:1,:);
maxpow=speaks(1,1);
maxfre=speaks(1,2);
hold on
plot(maxfre,maxpow,'*');
text(maxfre,maxpow,sprintf(' %.0f',maxfre));
for i=2:min(size(speaks,1),2);
  hold on
  plot(speaks(i,2),speaks(i,1),'*');
  text(speaks(i,2),speaks(i,1),sprintf(' %.1f@%.1f',...
				       speaks(i,1)/ maxpow,...
				       speaks(i,2)/maxfre));
end
%range=[210 250];
range=[185 220];
rangep2=[0.5 0.7];
rangef2=[1.1 1.3];
song=0;
err='';
if (maxfre<range(1) | maxfre > range(2))
  err='Main peak out of range';
else
  secpow=speaks(2,1);
  secfre=speaks(2,2);
  y=secfre/maxfre;
  if (y<rangef2(1))|(y>rangef2(2))
    err='Sec peak out of range';
  else
    y=secpow/maxpow;
    if (y<rangep2(1))|(y>rangep2(2))
      err='Sec peak is the wrong height';
    else
      song=1;
    end
  end
end
yl=get(gca,'ylim');
xl=get(gca,'xlim');
tx=xl(1) * 0.1 + xl(2)*0.9;
ty=yl(1) * 0.9 + yl(2)*0.9;
if (song)
  text(tx,ty,'IS SONG','HorizontalAlignment','Right');
else
  err;
  text(tx,ty,err,'HorizontalAlignment','Right');
end
drawnow;
song_play(x,start,stop-start);
