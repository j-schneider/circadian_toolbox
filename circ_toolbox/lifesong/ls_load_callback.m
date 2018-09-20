function ls_load_callback

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
global SONG
global FILE_SCALE
global EVENTS
global SAMRAT
global SECONDS
global PULSES

FILT_ORDER = 2;
FILT_FREQ  = 100;

% get file name from dialog
[filename, pathname] = uigetfile('*', 'Load Song');
fname = [pathname filename];

% if use canceled save dialog, filename will be empty
if ~filename, return, end

%
% SOUND SAMPLES ----------------------------
%
fid = safeopen(fname,'r','b');

SONG = fread(fid,Inf,'int16');
fclose(fid);
hdr = SONG(1:3);

SONG = SONG(4:end);

SONG = SONG / FILE_SCALE;

% set time scale to length of this song
SECONDS = length(SONG) / SAMRAT;
reset_axis

% reset slider to middle of range
reset_slider

%[b,a] = butter(11, FILT_FREQ/(SAMRAT/2));
%SONG = filter(b, a, SONG);

plot_song
reset_axis

% show name in figure
set(gcf, 'Name', ['LifesongML: ' filename])

%
% EVENTS -------------------------------------
%
evname=[fname,'.event'];

if exist(evname, 'file')
  fid = safeopen(evname, 'r');
  if fid >= 0
    first_line=fgets(fid);
    event=fscanf(fid,'%d %d %f %f %f',[5,Inf]);
    if ~isempty(event)
      EVENTS=event';
      EVENTS = EVENTS(:,[1 3 4]);
      plot_events(EVENTS)
    end
  end  
end

%
% PULSES -------------------------------------
%
datname=[fname,'.dat'];

if exist(datname, 'file')
  fid = safeopen(datname, 'r');
  if fid >= 0
    PULSES=fscanf(fid,'%f %f %f', [3, Inf])';
    plot_pulses(PULSES)
    report
  end
end




  
  

