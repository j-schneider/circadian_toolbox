function wavfile2lsfile(fname)
%cheaply convert a wav file to a lifesong file
RECORD_SCALE = 30;
mysng = wavread(fname);
SONG = wav2song(mysng)*RECORD_SCALE;
hdr1=2;
bytes=length(SONG)*2;
bytes1=floor(bytes/(16^4));
bytes2=mod(bytes,16^4);
hdr=[hdr1,bytes1,bytes2];

fnameout = [fname '.lsng'];
fid = safeopen(fnameout,'w','b');
FILE_SCALE = 25;
SONG = SONG*FILE_SCALE;

SONG = reshape(SONG,length(SONG),1);
hdr = reshape(hdr,length(hdr),1);
x=[hdr;SONG];
fwrite(fid,x,'int16');
fclose(fid);

