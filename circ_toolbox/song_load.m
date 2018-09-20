function [x,hdr,dat,event]=song_load(fname)
% [X,HDR,DAT,EVENT] = SONG_LOAD(FNAME) loads song file FNAME, returning
% samples X, header HDR, .DAT file contents DAT, and .EVENT file
% contents EVENT.
%
% Example: 
%
%   >> [x,h,d,e] = song_load('mysong');

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

%
% SOUND SAMPLES ----------------------------
%
if nargin<1
  % no filename, call gui
  if isunix
    pattern='*';
  else
    pattern='*.*';
  end
  fname=uigetfile(pattern,'Select a file');
end
fid = safeopen(fname,'r','b');

fprintf('Reading %s...\n',fname);
x=fread(fid,Inf,'int16');
fclose(fid);
hdr=x(1:3);

x=x(4:end);

%uncomment the following line for an attempt to bring down to db
%units (-1-1)
%x=x ./ 500;

%
% DATA --------------------------------------
%
if nargout > 2
  datname=[fname,'.dat'];
  [fid,error] = fopen(datname, 'r');
  if (fid<0) 
    fprintf('no .dat file: %s.\n',datname);
    dat=[];
  else
    fprintf('Reading %s...\n',datname);
    dat=load(datname);
  end
end

%
% EVENTS -------------------------------------
%
if nargout > 3
  evname=[fname,'.event'];
  fid = fopen(evname, 'r');
  if fid<0
    fprintf('no event file: %s\n',evname);
    event=[];
  else
    fprintf('Reading %s...\n',evname);
    first_line=fgets(fid);
    event=fscanf(fid,'%d %d %f %f %f',[5,Inf]);
    event=event';
  end
end
  
  
