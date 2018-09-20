function song_save(fname, song,dat);
% SONG_SAVE(FNAME, SONG) saves samples SONG to song file FNAME.
%
% Example: 
%
%   >> x = song_load('mysong');
%   >> x = do_something_to_samples(x);
%   >> song_save('mysong2', x);

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
% this seems to be the standard header
%hdr=[2;18;20352];
% news! 7/31/02
% i figured out the 2nd and 3rd elements of header:
% lenght of the file in bytes, i.e. number of samples * 4
% because each sample is a 4-byte integer. 
% still don't know what 2 (first byte of header) means,
% probably kHz sampling rate, 2=2000 hz, the usual sampling rate
if nargin<3
  dat=[];
end
hdr1=2;
bytes=length(song)*2;
bytes1=floor(bytes/(16^4));
bytes2=mod(bytes,16^4);
hdr=[hdr1, bytes1, bytes2];
fprintf('%d %X %X %X\n',bytes,bytes,bytes1,bytes2); 
fid = safeopen(fname, 'w', 'b');

%song = song * 500;
song = reshape(song, length(song), 1);
hdr = reshape(hdr, length(hdr), 1);
fprintf('Writing %s...\n',fname);
x=[hdr;song];
fwrite(fid,x,'int16');
fclose(fid);
if ~isempty(dat)
  dname=[fname,'.dat'];
  [dfile,error]=fopen(dname,'w');
  if (dfile<0)
    error(sprintf('song_save: could not open %s for saving', ...
		  dname));
  end
  fprintf('Saving %s...\n',dname);
  fprintf(dfile,'%10.4f%8.4f%10.0f.\r',dat');
  fclose(dfile);
end
