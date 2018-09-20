%KRUPP_LOAD Read Krupp output files
% out=krupp_load(nplates,filename)
%
% Reads in a Krupp file. The file is assumed to contain readings
% for nplates consecutive plates. If nplates=3 for example, then
% first segment belongs to plate 1, second segment to plate 2,
% third segment to plate 3, fourth segment to plate 1 again, and so
% on until the end of the file. 
%
% You can omit filename - a window will pop up asking for the file
% to be read. 
%
% outputs: 
%
% out.f - Data counts for each plate. Each column represents a
% plate, and each row a time reading. 
% 
% out.plates - Names of plates corresponding to each column in
% out.f
%
% out.times - Time readings for the headers only of each segment
% corresponding to out.f (military time hhmm)
%
% out.dates - Same as out.times, but date strings
%
% out.plate_seq - Pate sequence numbers correspoinding to rows and
% columns of out.f
% 
function out=krupp_load(nplates,filename)
if (nargin<1)
  error 'Usage: parse(num_plates)';
end
if (nargin<2)
  filename=uigetfile('*.*');
end
[fid,err]=fopen(filename,'r');
if (fid<0)
  fprintf('Failed to open %s\n',filename);
  error(err);
end
global version6compatible
if isempty(version6compatible)
  version6compatible=1;
end
if version6compatible
  fprintf('Reading file without using textscan ... ');
  lines={};
  go_on = 1;
  while (go_on)
    tline=fgetl(fid);
    if (ischar(tline))
      lines{end+1}=tline;
    else
      go_on=0;
    end
  end
  fprintf('read %d lines.\n',length(lines));
else
  % textscan should be much faster, only available after version 6
  lines=textscan(fid,'%s','Delimiter','\n');
  lines=lines{1};
end
first=strtok(lines);
sep=find(strcmp(first,'Plate'));
% whos lines sep
info={};
for i=1:length(sep)
  info{i}.head=lines{sep(i)};
  if i==length(sep)
    last=length(lines);
  else
    last=sep(i+1)-1;
  end
  % length(lines),i,sep,sep(i)+2,last
  info{i}.data=lines(sep(i)+2:last);
end

fprintf('found %d segments\n',length(info));
plate=0;
row=0;
time=[];
date={};
plate_seq=[];
plates={};
n=length(info);
for i=1:n
  stuff=proc(info{i});
  if i==1
    ncol=length(stuff.data);
    mat = zeros(ceil(n/nplates),ncol);
  end
  if plate==0
    row=row+1;
  end
  if (row==1)
    plates=[plates,stuff.plates'];
  end
  cols=(1+ncol*plate):(ncol*(plate+1));
  mat(row,cols) = stuff.data;
  time(row,1+plate)=stuff.time;
  date{row,1+plate}=stuff.date;
  plate_seq(row,1+plate)=stuff.plate_seq;
  plate = mod(plate + 1,nplates);
end
fprintf('\n');
out.f = mat;
out.date = date;
out.time = time;
out.plate_seq = plate_seq;
out.plates=plates;

function c=tokenize(s)
c={};
while length(s)>0
  [tok,s]=strtok(s);
  c{end+1}=tok;
end


function stuff=proc(info)
% parse header
% Plate Sequence Number: 203     Acquired: 8/2/2005  10:40:37 PM   Plate Temperature:23.1C (73.5F) 
%fprintf('%s\n',info.head);
[dummy,rest] = strtok(info.head); % plate
[dummy,rest] = strtok(rest); % sequence
[dummy,rest] = strtok(rest); % number
[plate,rest] = strtok(rest); % plate no
[dummy,rest] = strtok(rest); % acquired
[date,rest] = strtok(rest); % date
[time,rest] = strtok(rest); % time
[ampm,rest] = strtok(rest); % AM/PM

stuff.plate_seq = str2num(plate);
fprintf('%d ',stuff.plate_seq);
stuff.date = sscanf(date,'%d/%d/%d');
stuff.time = parsetime(time,ampm);

% parse contents
%      F-1 	11:06:10 AM 	 8378 
%      H-1 	11:06:42 AM 	13461 
[names,rest]=strtok(info.data);
% the individual sample times are being discarded, but they could
% be retrieved if necessary. 
[times,rest]=strtok(rest);
[ampm,counts]=strtok(rest);
[letter,rest]=strtok(names,'-');
[number,rest]=strtok(rest,'-');
n=length(names);
order=zeros(n,2);
for i=1:n
  if length(names{i})>0
    %fprintf('name (%s) time %s ampm %s counts %s letter %s number %s\n' ...
    %, names{i},times{i},ampm{i},counts{i},letter{i},number{i});
    order(i,1)=str2num(number{i});
    order(i,2)=upper(letter{i})-'A';
    time(i)=parsetime(times{i},ampm{i});
    ncounts(i)=str2num(counts{i});
    last=i;
  end
end
if (last<n)
  order=order(1:last,:);
end
[x,index]=sortrows(order,[1 2]);
stuff.plates=names(index);
stuff.data=ncounts(index);
return


  


function t=parsetime(hms,ampm)
pm=0;
if (lower(ampm(1)) == 'p')
  pm=1;
end
[hm]=sscanf(hms,'%d:%d');
%hm
h=hm(1);
m=hm(2);
if (pm & (h<12))
  h=h+12;
end
if (~pm & (h==12))
  h=0;
end
t=h*100+m;
%fprintf('%s %s = %d\n',hms,ampm,t);
