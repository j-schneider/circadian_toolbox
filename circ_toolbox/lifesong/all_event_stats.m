function all_event_stats(doprint,prefix)
%ALL_EVENT_STATS (LifeSong)
% 
% all_event_stats scans the current directory for lifesong event
% files and prints out names and basic stats: number of events of
% each type and time (absolute & relative) spent on each state. 
%
% all_event_stats(doprint,prefix)
% 
% doprint 
%    0=send to screen 1=send to printer (default: 0)
%
% prefix
%    Only process files whose names begin with this prefix 
%    (default: process all files)

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
tmpfilename='/tmp/all_event_stats';
a2pscmd='a2ps --columns=1 -L 66 -l 132 -R';
%a2pscmd='a2gs --portrait';
lprcmd='lp';

if nargin<1
  doprint=0;
end

if nargin<2
  prefix='';
end

if doprint
  printerfd=safeopen(tmpfilename,'w');
else
  printerfd=1;
end

% 1. find all .event files
eventfiles=dir([prefix,'*.event']);

if length(eventfiles) <= 0
    fprintf('Error: there are no event files here to look at.\n');
    fprintf('Goodbye!\n');
    return
end
% 2. sort alphabetically
[filenames{1:length(eventfiles),1}] = deal(eventfiles.name);
[y,index]=sort(filenames);
eventfiles=eventfiles(index);
% process
for i=1:length(eventfiles)
  finfo=eventfiles(i);
  if finfo.isdir 
    continue;
  end
  fname=finfo.name;
  fid=safeopen(fname,'r');
  first_line=fgets(fid);
  event=fscanf(fid,'%d %d %f %f %f',[5,Inf]);
  events=event';
  fclose(fid);
  x=findstr(fname,'.event');
  x=x(end);
  binname=fname(1:x-1);
  binfileinfo=dir(binname);
  if isempty(binfileinfo) | isdir(binname)
    fprintf('%s: Error: no binary file found\n');
    continue;
  end
  song=song_load(binname);
  %binfilesize=binfileinfo.bytes;
  sampledatapoints = max(find(song ~= 0));
  %sampledatapoints = (binfilesize-6) / 2;
  showinfo(sampledatapoints/2000,events,binname,printerfd);
end
if doprint
  fclose(printerfd);
  cmd=[a2pscmd,' ',tmpfilename,' | ',lprcmd];
  fprintf('executing %s\n',cmd);
  unix(cmd);
end

function showinfo(seconds,event,name,fd)
fprintf(fd,'--------------------\n');
fprintf(fd,'%s: %g s, %g events\n',name,seconds,size(event,1));
if size(event,1) > 0
  fprintf(fd,'\n%10s %10s %10s %10s\n\n','button','clicks','tot time', ...
	  ' % time');
  count=sparse(event(:,1),1,1);
  times=sparse(event(:,1),1,event(:,4)-event(:,3));
  [buttons,j]=find(count);
  for i=1:length(buttons)
    b=buttons(i);
    fprintf(fd,'%10d %10d %10.1f %10.1f ',b,count(b,1),times(b,1),times(b,1)/seconds* ...
	    100);
    fprintf(fd,'\n');
  end
end

