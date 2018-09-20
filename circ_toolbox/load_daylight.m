function [daylights,filename] = load_daylight(prefix)
% load daylight info using specified file name prefix

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
% set up for error
daylights = [];
filename = '';

% get file name from dialog
[filename, pathname] = uigetfile(prefix, 'Load Daylight File');
fullname = [pathname filename];

% if user canceled save dialog, filename will be empty
if fullname
  fid = fopen(fullname, 'r');  
  comment = fgets(fid);
  nentries = str2num(fgets(fid));
  min = str2num(fgets(fid));
  start = str2num(fgets(fid));
  data = fscanf(fid, '%d %d %s');
  fclose(fid);
  if length(data) <= nentries
    errordlg('Bad format for daylight file')
    return
  end
  nbins = length(data)/nentries - 2;
  skip = nbins + 2;
  day_date = data(1:skip:end);
  day_time = data(2:skip:end);
  for i = 1:nbins
    daylights(:,i) = data(i+2:skip:end) - 48;
  end
end

