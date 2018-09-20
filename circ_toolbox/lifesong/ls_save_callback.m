function ls_save_callback

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
% called when "Save" button is pushed: saves song and events

global EVENTS
global SONG
global SAMRAT
global FILE_SCALE
%global PADSEC

% get file name from dialog
[filename, pathname] = uiputfile('*', 'Save Song');
fname = [pathname filename];

% if use canceled save dialog, filename will be empty
if ~filename, return, end

% open event file
fid = safe_open([fname '.event']);

% seems necessary for some reason
fprintf(fid, '1000\n');

% save events
for i = 1:size(EVENTS,1)

  event = EVENTS(i,:);
  evtkey = event(1);
  evtbeg = event(2);
  evtend = event(3);
  fprintf(fid, ' %d 0   %8.4f   %8.4f     %3d.\n', ...
	    evtkey, evtbeg, evtend, 0);
end

% BIG TROUBLE IF NO FINAL <CR>
fprintf(fid, '\n');

% close events file
fclose(fid);

% pad song to PADSEC seconds
% removing now that headers are created properly
% (?) - jr 
%if length(SONG) < PADSEC*SAMRAT
%  SONG(end+1:PADSEC*SAMRAT) = 0;
%end
  
% this seems to be the standard header
%hdr=[2;18;20352];
% see comment on song_save.m
hdr1=2;
bytes=length(SONG)*2;
bytes1=floor(bytes/(16^4));
bytes2=mod(bytes,16^4);
%fprintf('%d %X %X %X\n',bytes,bytes,bytes1,bytes2);
hdr=[hdr1, bytes1, bytes2];

fid = safeopen(fname, 'w', 'b');
SONG = SONG * FILE_SCALE;

global LIFESONG_MAX_AMPLITUDE
if max(abs(SONG)) > LIFESONG_MAX_AMPLITUDE
  SONG=SONG * LIFESONG_MAX_AMPLITUDE / max(abs(SONG));
end
SONG = reshape(SONG, length(SONG), 1);
hdr = reshape(hdr, length(hdr), 1);

x=[hdr;SONG];
fwrite(fid,x,'int16');
fclose(fid);
  

% open file with error on failure
function fid = safe_open(fname)
  fid = fopen(fname, 'w');
  if fid == -1
    error(['Failed to open file ' fname ' for writing'])
  end
  

