function ls_record_callback
% called when "Record" button is pushed: starts recording, loads data
% stored during recording phase, plots data

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
  
global SECONDS

unix(['/usr/local/matlab/lifesong/lscollect ' num2str(SECONDS)]);

global SAMRAT
global EVENTS
global SONG
global SECONDS
global RECORD_SCALE

LOGFILENAME = 'lifesong.log';
WAVFILENAME = 'lifesong.wav';
USTFILENAME = 'lifesong.wav.ts';

% clear out old junk
cla
EVENTS = [];

% read waveform from file
x = wavread(WAVFILENAME);

% convert to 2000Hz format
SONG = wav2song(x) * RECORD_SCALE;

% plot
plot_song

% make axes look right
reset_axis

% parse up log, UST files
evt = load(LOGFILENAME);
ust = load(USTFILENAME);

% stop here if no events
if isempty(evt), return, end

% starting ust of 1st wav block
recording_started = ust(1,2);
nanoseconds=evt(:,4) - recording_started;

% array stores key-down times for drawing lines to key-up times
downtimes = zeros(1,9);

evidx = 1;

% need to remember down-events if they overrun EOF
downflags = zeros(1,9);

% store events  
for i = 1:size(evt,1)
  key = evt(i,1);
  updn = evt(i,2);
  sec = nanoseconds(i) / 1e9;  
  ypos = -2 + key/9;
  if updn
    downtimes(key) = sec;
    downflags(key) = 1;
  else
    downflags(key) = 0;
    record_event(key, downtimes, ypos, evidx, sec);
    evidx = evidx + 1;
  end
end

%move this to below
% plot events  
%plot_events(EVENTS);

% add pseudo key-release events for keys that are still down at end 
% of recording
stilldown = find(downflags);
for i = 1:length(stilldown)
  record_event(stilldown(i), downtimes, ypos, evidx, SECONDS);
  evidx = evidx + 1;
end

%now that we've fixed the stilldowns, we can plot
% plot events  
plot_events(EVENTS);

% record an event
function record_event(key, downtimes, ypos, evidx, sec)
  global EVENTS
  begsec = downtimes(key);
  EVENTS(evidx,1) = key;
  EVENTS(evidx,2) = begsec;
  EVENTS(evidx,3) = sec;


