function [y,m,d,h,lights]=dam_daylight(fname) 
%DAM_DAYLIGHT  Read daylight file
%
% This function is not usually called directly. 
% use dam_load in most cases.
%
% [y,m,d,h,lights]=dam_daylight(fname)
% reads daylight file
% outputs year,month,day,hour (mil), lights arrays

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


%version6compatible:
% set to 1 for slow, strread method
% set to 0 for fast, textscan method (Matlab version 7+)
% set to 2 for old deprecated 5 monitors daylight format 

global version6compatible
if isempty(version6compatible)
  version6compatible=1;
end
[fid,err]=fopen(fname,'r');
if (fid <= 0)
  fprintf('%s\n',err);
  error(sprintf('Cant read daylight file %s\n',fname));
end
header=fgets(fid);
rows=fscanf(fid,'%d',1);
interval=fscanf(fid,'%d',1);
startinghour=fscanf(fid,'%d',1);
if version6compatible==2
  % old code, had fixed number of 5 incubators
  M=fscanf(fid,'%4d%2d%2d %4d  %1d%1d%1d%1d%1d',[9,Inf]);
  fclose(fid);
  M=M';
  y=M(:,1);
  m=M(:,2);
  d=M(:,3);
  h=M(:,4);
  lights=M(:,5:9);
else
  if version6compatible
    cont=1;
    y=[];
    m=[];
    d=[];
    h=[];
    fgetl(fid); % skip till end of line
    lstring={};
    while cont
      tline=fgetl(fid);
      if ischar(tline)
        [yt,mt,dt,ht,lt]=strread(tline,'%4d%2d%2d %4d %s');
        y(end+1)=double(yt);
        m(end+1)=double(mt);
        d(end+1)=double(dt);
        h(end+1)=double(ht);
        lstring{end+1}=lt{1};
        
      else
        cont=0;
      end
    end
  else
    % textscan does not work for older versions of matlab
    data=textscan(fid,'%4d%2d%2d %4d  %s',[5,Inf]);
    y=double(data{1}); % year
    m=double(data{2}); % month
    d=double(data{3}); % day
    h=double(data{4}); % hour (military time, e.g. 1430)
    lstring=data{5};
  end
  lights=double(char(lstring))-'0'; % ligts: 0=off, 1=on
end
return
