function trunc_menu
% menu callback for HARP Modify/Truncate

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
% layout
WIDTH = 600;
HEIGHT = 500;
BUTTON_W = 100;
BUTTON_H = 25;
OKAY_X = 80;
CANCEL_X = 450;
BUTTON_Y = 10;
RADIO_Y = 80;
RADIO_W = 100;
RADIO_H = 18;
BINS_RADIO_X = 150;
DAYS_RADIO_X = 370;
INCU_RADIO_Y = 50;
MIN_SLIDER_X = 110;
MAX_SLIDER_X = 305;
SLIDER_Y = 130;
SLIDER_W = 200;
SLIDER_H = 20;
SNAP_CHKBOX_X = 260;
SNAP_CHKBOX_Y = 80;
MIN_TEXT_X = 30;
MIN_EDIT_X = 60;
MAX_EDIT_X = 510;
MAX_TEXT_X = 545;
EDIT_W = 45;
EDIT_H = 20;
TEXT_W = 40;
TEXT_H = 20;

global TRUNC_BINS
global TRUNC_BINS_RADIO
global TRUNC_DAYS_RADIO
global TRUNC_MIN_SLIDER
global TRUNC_MAX_SLIDER
global TRUNC_SNAP_CHKBOX
global TRUNC_SNAP
global TRUNC_MIN_EDIT
global TRUNC_MAX_EDIT

global CURRENT_RECORD_NAME
global DAYLIGHTS

figure
set(gcf, 'MenuBar', 'none')
set(gcf, 'Name', ['HARP/Truncate ' CURRENT_RECORD_NAME])
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) WIDTH HEIGHT])
set(gca, 'Position', [.1, .35, .825, .55], ...
	 'YTickLabel', [])

uicontrol(gcf, 'Style', 'pushbutton', 'String','Okay',...
  'Callback', 'trunc_dlog(''okay_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [OKAY_X BUTTON_Y BUTTON_W, BUTTON_H]);
uicontrol(gcf, 'Style', 'pushbutton', 'String','Cancel', ...
  'Callback', 'trunc_dlog(''cancel_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [CANCEL_X BUTTON_Y BUTTON_W, BUTTON_H]);
TRUNC_BINS_RADIO = uicontrol(gcf, 'Style', 'radiobutton', ...
  'String','Bins', ...
  'Callback', 'trunc_dlog(''bins_radio_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [BINS_RADIO_X RADIO_Y RADIO_W, RADIO_H]);
TRUNC_DAYS_RADIO = uicontrol(gcf, 'Style', 'radiobutton', ...
  'String','Days', ...
  'Callback', 'trunc_dlog(''days_radio_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [DAYS_RADIO_X RADIO_Y RADIO_W, RADIO_H]);

TRUNC_MIN_SLIDER = uicontrol(gcf, 'Style', 'slider', ...
  'Position', [MIN_SLIDER_X SLIDER_Y SLIDER_W, SLIDER_H], ...
  'Callback', 'trunc_dlog(''slider_Callback'',gcbo,[],guidata(gcbo))');
TRUNC_MAX_SLIDER = uicontrol(gcf, 'Style', 'slider', ...
  'Position', [MAX_SLIDER_X SLIDER_Y SLIDER_W, SLIDER_H], ...
  'Callback', 'trunc_dlog(''slider_Callback'',gcbo,[],guidata(gcbo))');

TRUNC_SNAP_CHKBOX = uicontrol(gcf, 'Style', 'checkbox', ...
  'String','Snap to light', ...
  'Callback', 'trunc_dlog(''snap_chkbox_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [SNAP_CHKBOX_X SNAP_CHKBOX_Y RADIO_W, RADIO_H]);

uicontrol(gcf, 'Style', 'text', 'String', 'Min', ...
  'BackgroundColor', get(gcf, 'Color'), ...
  'Position', [MIN_TEXT_X SLIDER_Y TEXT_W, TEXT_H]);
uicontrol(gcf, 'Style', 'text', 'String', 'Max', ...
  'BackgroundColor', get(gcf, 'Color'), ...
  'Position', [MAX_TEXT_X SLIDER_Y TEXT_W, TEXT_H]);

TRUNC_MIN_EDIT = uicontrol(gcf, 'Style', 'edit', ...
  'Callback', 'trunc_dlog(''min_edit_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [MIN_EDIT_X SLIDER_Y EDIT_W, EDIT_H]);
TRUNC_MAX_EDIT = uicontrol(gcf, 'Style', 'edit', ...
  'Callback', 'trunc_dlog(''max_edit_Callback'',gcbo,[],guidata(gcbo))', ...
  'Position', [MAX_EDIT_X SLIDER_Y EDIT_W, EDIT_H]);

if TRUNC_BINS
  turnon(TRUNC_BINS_RADIO)
  turnoff(TRUNC_DAYS_RADIO)
else
  turnoff(TRUNC_BINS_RADIO)
  turnon(TRUNC_DAYS_RADIO)
end

if TRUNC_SNAP
  turnon(TRUNC_SNAP_CHKBOX)
else
  turnoff(TRUNC_SNAP_CHKBOX)
end

if ~isempty(DAYLIGHTS)
  show(TRUNC_SNAP_CHKBOX)
  disable(TRUNC_SNAP_CHKBOX)
else
  hide(TRUNC_SNAP_CHKBOX)
end

TRUNC_SNAP = 0;

show_incu_radio(gcf, INCU_RADIO_Y, 'trunc_incu_radio_callback')

trunc_axis(TRUNC_BINS)

