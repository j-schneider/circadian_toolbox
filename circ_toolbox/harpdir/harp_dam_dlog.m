function varargout = harp_dam_dlog(varargin)
% event handler for DAM Load dialog in HARP

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
if ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end

% --------------------------------------------------------------------
function varargout = okay_Callback(h, eventdata, handles, varargin)

global INCUBATOR

global DAM_PREFIX
global DAM_DIR
global DAM_USELIGHT
global DAM_LIGHTNAME
global DAM_DATA_A
global DAM_DATA_B
global DAM_ORIGINAL_DATA_A
global DAM_ORIGINAL_DATA_B
global DAM_MODE
global DAM_WHICH

global DAM_PREFIX_EDIT
global DAM_DIR_EDIT
global DAM_LIGHTNAME_EDIT
global DAM_LOAD_B_MENU
global DAM_SELECT_MENUS
global DAM_DAYLIGHT_BROWSE
global DAM_SELECT_MENUS
global DAM_TRUNC_MENU
global DAM_TRUNC_B_MENU
global DAM_PIN_MENU
global DAM_PIN_B_MENU
global DAM_PHASE_MENU
global PHASE_B_MENU
global PHASE_MULTI_MENU
global PHASE_BIVAR_MENU
global DAM_RALPH_MENU
global RALPH_B_MENU
global DAM_REVERT_MENU
global DAM_REVERT_B_MENU
global DAM_REVERT_BOTH_MENU

if DAM_MODE
  filenames = {};
  [monitors,positions] = find(DAM_SELECT_MENUS);
  for i = 1:length(monitors)
    mon = monitors(i);
    pos = positions(i);
    item = DAM_SELECT_MENUS(mon, pos);
    if menuchecked(item)
      filenames{end+1} = get(item, 'UserData');
    end
  end
  
  [a,start,int,len,headers,names] = dam_read_names(filenames, DAM_DIR);

  o = dam_assemble(a,monitors,positions,start,int,len,headers,names,...
		   DAM_DIR,INCUBATOR,DAM_LIGHTNAME);
  
  if DAM_WHICH == 1
    DAM_DATA_A = o;
    DAM_ORIGINAL_DATA_A = DAM_DATA_A;
    enable(DAM_LOAD_B_MENU)
    enable(DAM_TRUNC_MENU)
    enable(DAM_PIN_MENU)
    enable(DAM_REVERT_MENU)
    enable(DAM_PHASE_MENU)
    enable(DAM_RALPH_MENU)
  else
    DAM_DATA_B = o;
    DAM_ORIGINAL_DATA_B = DAM_DATA_B;
    enable(DAM_TRUNC_B_MENU)
    enable(DAM_PIN_B_MENU)
    enable(PHASE_B_MENU)
    enable(PHASE_BIVAR_MENU)
    enable(PHASE_MULTI_MENU)
    enable(RALPH_B_MENU)
    enable(DAM_REVERT_B_MENU)
    enable(DAM_REVERT_BOTH_MENU)
  end
  
  
  close(get(h, 'Parent'))
else
  
  disable(DAM_DAYLIGHT_BROWSE)
  disable(DAM_PREFIX_EDIT)
  disable(DAM_DIR_EDIT)
  disable(DAM_LIGHTNAME_EDIT)
  
  DAM_PREFIX = gettxt(DAM_PREFIX_EDIT);
  DAM_DIR = gettxt(DAM_DIR_EDIT);
  DAM_LIGHTNAME = gettxt(DAM_LIGHTNAME_EDIT);

  if isempty(DAM_DIR)
    DAM_DIR = cd;
  end
  DAM_MODE = 1;

  prefix = DAM_PREFIX;
  direc = dir(DAM_DIR); 

  [filenames{1:length(direc),1}] = deal(direc.name);
  [filenames,monitors,positions] = dam_names(filenames, prefix);
  mon = 0;
  fig = get(h, 'Parent');
  DAM_SELECT_MENUS = [];
  for i = 1:length(monitors)
    pos = positions(i);
    filename = filenames{i};
    if mon ~= monitors(i)
      mon = monitors(i);
      monmenu = uimenu(fig, 'Label', sprintf('M%d', mon));
      uimenu(monmenu, 'Label','All', ...
	 'Callback', sprintf('harp_dam_allpos(%d, 1)', mon))
      uimenu(monmenu, 'Label','None', 'Separator','on', ...
	 'Callback', sprintf('harp_dam_allpos(%d, 0)', mon))
      DAM_SELECT_MENUS(mon,1) = ...
        uimenu(monmenu, 'Label', sprintf('P1', pos), 'Separator','on', ...
          'Callback', sprintf('toggle_dam_menu(%d,1)', mon), ...
	  'UserData', filename);
    else
      DAM_SELECT_MENUS(mon,pos) = ...
	  uimenu(monmenu, 'Label', sprintf('P%d', pos), ...
           'Callback', sprintf('toggle_dam_menu(%d,%d)', mon, pos), ...
	 'UserData', filename);
		 
    end
    drawnow
  end

end


% --------------------------------------------------------------------
function varargout = cancel_Callback(h, eventdata, handles, varargin)
close(get(h, 'Parent'))

% --------------------------------------------------------------------
function varargout = use_daylight_Callback(h, eventdata, handles, varargin)

harp_dam_toggle_daylight(uival(h))

% --------------------------------------------------------------------
function varargout = browse_daylight_Callback(h, eventdata, handles, varargin)

global DAM_PREFIX_EDIT
global DAM_LIGHTNAME_EDIT

prefix = [gettxt(DAM_PREFIX_EDIT) '*'];

[daylights,filename] = load_daylight(prefix);

if filename
  settxt(DAM_LIGHTNAME_EDIT, filename)
end
