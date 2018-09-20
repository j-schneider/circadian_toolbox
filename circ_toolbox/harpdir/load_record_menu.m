function load_record_menu
% menu callback for HARP File/Load Record.  Loads new data and resets 
% low, high actogram cutoffs.

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
global MIN_PER_BIN
global START_TIME
global CURRENT_DATA
global ORIGINAL_DATA
global CURRENT_RECORD_NAME
global ACTO_LO
global ACTO_HI
global DTREND_MODE
global PLOT_MENU
global MOD_MENU

% get file name from dialog
[filename, pathname] = uigetfile('*', 'Load Record');
fullname = [pathname filename];

% if use canceled load dialog, filename will be empty
if fullname
  fid = fopen(fullname, 'r');
  comment = fgets(fid);
  nentries = str2num(fgets(fid));
  min_per_bin = str2num(fgets(fid));
  start_time = str2num(fgets(fid));
  data = fscanf(fid, '%d');
  if length(data) ~= nentries
    errordlg('Bad format for record file')
    return
  end
  fclose(fid);
  MIN_PER_BIN = min_per_bin;
  START_TIME = start_time;
  CURRENT_DATA = data;
  noneg = CURRENT_DATA(find(CURRENT_DATA>=0));
  ACTO_LO = min(noneg);
  ACTO_HI = max(noneg);
  CURRENT_RECORD_NAME = filename;
  ORIGINAL_DATA = CURRENT_DATA;
  
  % disallow logarithmic detrend for data containing zeros
  if zero_data, DTREND_MODE = 1; end

  % enable menus
  enable(PLOT_MENU)
  enable(MOD_MENU)
  
end

