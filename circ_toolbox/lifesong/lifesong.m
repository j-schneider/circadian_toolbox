%
% LIFESONG Matlab Lifesong data collection and analysis program
% 

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
% Simon D. Levy        Hall Lab       Brandeis University      2001
% John Rieffel         Hall Lab       Brandeis University      2002
 
function lifesong

% song data
global SONG

%scale and scale "memory" to zoom to previous
global SCALE
global PREV_SCALE_STACK

PREV_SCALE_STACK = [-1 -1];

%in PLAY_MODE, button up plays selection
%in ZOOM_MODE, buttup up zooms selection
global PLAY_MODE
global ZOOM_MODE

ZOOM_MODE = 0;
PLAY_MODE = 0;

% default recording duration
global SECONDS;
SECONDS = 300;

% sampling rate
global SAMRAT
SAMRAT = 2000;

% format conversion
global FILE_SCALE RECORD_SCALE PADSEC
RECORD_SCALE = 30;
FILE_SCALE = 25;  % temporary, for Mac loading
%%%PADSEC = 300;     % temporary, for Mac loading

% Lifesong Rescaling
global LIFESONG_MAX_AMPLITUDE
LIFESONG_MAX_AMPLITUDE=300;

% slider for scrolling
global SLIDER
SLIDER_X = 80;
SLIDER_Y = 50;
SLIDER_W = 645;
SLIDER_H = 20;

% appearance
GUI_W = 800;
GUI_H = 600;
BUTTON_X = 120;
BUTTON_Y = 50;

% reset zooming flags
global LAST_LINE
LAST_LINE = 0;

%pzwin = playzoom;
figure;

set (gcf, 'Name', 'LifesongML')

% Me gusta mi logo
uicontrol(gcf, ...
	  'Style','text', 'String','LifesongML', ...
	  'Position', [GUI_W/2-250 GUI_H-80 500 60], ...
	  'FontSize', 36, ...
	  'FontAngle', 'oblique', ...
	  'ForegroundColor', 'red', ...
	  'BackgroundColor', get(gcf, 'Color'))

% this puts a button 5 pixels up, 5 pixels over (from bottom
% right), 100 pixels wide and 30 pixels high.  And it calls
% ls_play_button_cb when pushed.
b1 = uicontrol('style','toggle',...
              'string','Play',...
               'HandleVisibility','callback', ...
              'units','pixels',...
              'position',[5 5 100 30],...
              'callback',{@ls_play_button_cb});

%likewise
b2 = uicontrol('style','togglebutton',...
	       'string','Zoom',...
	       'HandleVisibility','callback',...
	       'units','pixels',...
	       'position',[110 5 100 30], ...
	       'callback',{@ls_zoom_button_cb});

b3 = uicontrol('style','pushbutton',...
	       'string','UnZoom',...
	       'HandleVisibility','callback',...
	       'units','pixels',...
	       'position',[220 5 100 30], ...
	       'callback',{@ls_unzoom_button_cb});

%b4 reserved for findpeaks
%b5 reserved for clearpeaks

% hide crop button for now
% so that it is done right.

%b6 = uicontrol('style','pushbutton',...
%	       'string','Crop',...
%	       'HandleVisibility','callback',...
%	       'units','pixels',...
%	       'position',[550 5 100 30], ...
%	       'callback',{@ls_crop_button_cb});

% add menus
fmenu = uimenu('Label','File');
uimenu(fmenu,'Label','Load...','Callback','ls_load_callback',...
       'Accelerator','L');
uimenu(fmenu,'Label','Record...','Callback','ls_record_callback',...
       'Accelerator','R');
uimenu(fmenu,'Label','Save...','Callback','ls_save_callback', ...
       'Accelerator','S');
uimenu(fmenu,'Label','Quit','Callback','ls_close_callback',...
         'Separator','on','Accelerator','Q');

emenu = uimenu('Label','Edit');
uimenu(emenu,'Label','Params...','Callback','ls_params_callback');

% add slider for scrolling
SLIDER = uicontrol(gcf, 'Style', 'slider', ...
		   'Callback','ls_slider_callback',...
	           'Position', [SLIDER_X SLIDER_Y SLIDER_W SLIDER_H]);
reset_slider

% set figure size
set_size(GUI_W, GUI_H)

% show initial empty plot
SONG = [];
%set(gca, 'Position', [.2, .2, .6, .4])
set(gca, 'Position', [.1, .2, .8, .6])
set(gca,'YLimMode','auto');
reset_axis

% set up for mouse clicks
set(gcf, 'WindowButtonDownFcn', 'ls_buttdn_callback');
set(gcf, 'WindowButtonUpFcn', 'ls_buttup_callback');
set(gcf, 'WindowButtonMotionFcn', 'ls_buttmv_callback');

% get rid of distracting, unused menu bar
set(gcf, 'MenuBar', 'none')
