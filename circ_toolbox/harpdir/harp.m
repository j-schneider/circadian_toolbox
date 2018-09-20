function harp
% HARP: Hall Lab Analysis of Rhythms Package
%
% by Simon Levy, Joel Levine, and Pablo Funes
%
% Jeff Hall Lab   Brandeis University   2002
%
% HARP is a Graphical User Interface (GUI) that calls various
% routines for analyzing and plotting information in the XXX
% format.  

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
global MAIN_WINDOW

global DAM_PREFIX
global DAM_DIR
global DAM_USELIGHT
global DAM_LIGHTNAME
global DAM_DATA_A
global DAM_DATA_B

global LAYOUT
global TILE_ROWS
global TILE_COLS

global DTREND_MODE

global FILTER_ORDER
global FILTER_TWICE
global FILTER_LO_HOURS
global FILTER_HI_HOURS

global MIN_PER_BIN

global DAYLIGHTS

global INCUBATOR
    
global TRUNC_BINS
global TRUNC_SNAP

global AUTO_PEAK_FROM_HOURS
global AUTO_PEAK_TO_HOURS

global PGRAM_FROM_HOURS
global PGRAM_TO_HOURS
global PGRAM_CONF

global HISTO_BASELINE
global HISTO_FORMAT
global HISTO_HOURS_MIN
global HISTO_HOURS_MAX

global ACTO_REPS
global ACTO_BASELINE
global ACTO_LO
global ACTO_HI

global MESA_ORDER
global MESA_FROM
global MESA_TO

global FFT_FROM
global FFT_TO

global PHASE_LOPASS_HOURS
global PHASE_NORMALIZE
global PHASE_FIRST_HOUR
global PHASE_PERIOD

global MOD_MENU
global PLOT_MENU
global DAM_LOAD_B_MENU
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
global DAM_REVERT_A_MENU
global DAM_REVERT_B_MENU
global DAM_REVERT_BOTH_MENU

global DAILY_HOURS  % for phase

% defaults

TILE_ROWS            = 2;
TILE_COLS            = 2;
LAYOUT               = 1; % cascade plots

FILTER_ORDER         = 2;
FILTER_TWICE         = 1; % two passes through data?
FILTER_LO_HOURS      = 4;
FILTER_HI_HOURS      = 0;

DTREND_MODE          = 1; % linear

DAYLIGHTS            = []; % no daylight info
INCUBATOR            = 0;  % don't use incubator info

TRUNC_BINS           = 1;  % use bins instead of days
TRUNC_SNAP           = 0;  % don't automatically truncate to daylight

AUTO_PEAK_FROM_HOURS = 40;
AUTO_PEAK_TO_HOURS   = 56;

PGRAM_FROM_HOURS     = 15;
PGRAM_TO_HOURS       = 40;
PGRAM_CONF           = .05;

HISTO_BASELINE       = 48;
HISTO_FORMAT         = 2;  % center dark
HISTO_HOURS_MIN      = 15; % minimum number of hours to support formatting
HISTO_HOURS_MAX      = 35; % minimum number of hours to support formatting
			    
ACTO_REPS            = 2;  % default to double actogram
ACTO_BASELINE        = 48; % bins

MESA_ORDER           = 36; % Dusty's MFL value
MESA_FROM            = 1; % need to skip some initial noise
MESA_TO              = 30;

FFT_FROM	     = 1;
FFT_TO               = 100;

DAM_PREFIX	     = '';
DAM_DIR              = '';
DAM_USELIGHT         = 1;
DAM_LIGHTNAME        = '';
DAM_DATA_A           = [];
DAM_DATA_B           = [];
DAM_MONITOR_COUNT    = 16;
DAM_POSITION_COUNT   = 32;
PHASE_LOPASS_HOURS   = 8;
PHASE_NORMALIZE      = 0;
PHASE_FIRST_HOUR     = 0;
PHASE_PERIOD         = 24;

DAILY_HOURS          = 24; % for DAM Phase computations

MAIN_WINDOW = openfig('harp', 'new');
im = imread('harp', 'gif');
image(im)
set(gca, 'Position', [0 0 1 1], 'XTick',[], 'YTick',[])
set(MAIN_WINDOW, 'MenuBar', 'none')
set(MAIN_WINDOW, 'Name', 'Hall-lab Analysis of Rhythms Package')

fmenu = uimenu('Label','File');
uimenu(fmenu,'Label','Load Record...','Callback','load_record_menu',...
       'Accelerator','R');
uimenu(fmenu,'Label','Load Daylight...','Callback','load_daylight_menu',...
       'Accelerator','D');
uimenu(fmenu,'Label','Quit','Callback','quit_menu',...
         'Separator','on','Accelerator','Q');

dmenu = uimenu('Label','DAM');
dlmenu = uimenu(dmenu, 'Label', 'Load');
uimenu(dlmenu,'Label','A...','Callback','harp_dam_menu(1)')
DAM_LOAD_B_MENU = uimenu(dlmenu,'Label','B ...', ...
			 'Callback','harp_dam_menu(2)');
DAM_TRUNC_MENU = uimenu(dmenu,'Label','Truncate');
DAM_TRUNC_A_MENU = uimenu(DAM_TRUNC_MENU,'Label','A...', ...
			'Callback','harp_dam_truncate(1)');
DAM_TRUNC_B_MENU = uimenu(DAM_TRUNC_MENU,'Label','B...', ...
			'Callback','harp_dam_truncate(2)');
DAM_PIN_MENU = uimenu(dmenu,'Label','Pinpoint');
DAM_PIN_A_MENU = uimenu(DAM_PIN_MENU,'Label','A...', ...
			'Callback','harp_dam_pinpoint(1)');
DAM_PIN_B_MENU = uimenu(DAM_PIN_MENU,'Label','B...', ...
			'Callback','harp_dam_pinpoint(2)');
DAM_PHASE_MENU = uimenu(dmenu,'Label','Phase ');
PHASE_A_MENU = uimenu(DAM_PHASE_MENU, 'Label','A...', ...
			'Callback', 'phase_menu(1)');
PHASE_B_MENU = uimenu(DAM_PHASE_MENU, 'Label','B...', ...
			'Callback', 'phase_menu(2)');
PHASE_MULTI_MENU = uimenu(DAM_PHASE_MENU, 'Label', 'Multiple...', ...
			'Callback', 'phase_menu(3)');
PHASE_BIVAR_MENU = uimenu(DAM_PHASE_MENU, 'Label', 'Bivariate...', ...
			'Callback', 'phase_menu(4)');
DAM_RALPH_MENU = uimenu(dmenu,'Label','Ralph ');
RALPH_A_MENU = uimenu(DAM_RALPH_MENU, 'Label','A...', ...
			'Callback', 'ralph_menu(1)');
RALPH_B_MENU = uimenu(DAM_RALPH_MENU, 'Label','B...', ...
			'Callback', 'ralph_menu(2)');
DAM_REVERT_MENU = uimenu(dmenu, 'Label','Revert', 'Separator','on');
DAM_REVERT_A_MENU = uimenu(DAM_REVERT_MENU, 'Label','A', ...
			'Callback', 'harp_dam_revert_menu(1)');
DAM_REVERT_B_MENU = uimenu(DAM_REVERT_MENU, 'Label','B', ...
			'Callback', 'harp_dam_revert_menu(2)');
DAM_REVERT_BOTH_MENU = uimenu(DAM_REVERT_MENU, 'Label','Both', ...
			'Callback', 'harp_dam_revert_menu(3)');


MOD_MENU = uimenu('Label','Modify');
uimenu(MOD_MENU,'Label','Detrend...','Callback','dtrend_menu', ...
       'Accelerator','D');
uimenu(MOD_MENU,'Label','Filter...','Callback','filter_menu', ...
       'Accelerator','F');
nmenu = uimenu(MOD_MENU,'Label','Normalize', 'Accelerator','N');
uimenu(MOD_MENU,'Label','Truncate...','Callback','trunc_menu', ...
       'Accelerator','T');
uimenu(MOD_MENU,'Label','Undo All','Callback','undo_menu',...
         'Separator','on','Accelerator','U');

uimenu(nmenu, 'Label', 'Y = X / MEAN(X)', ...
	'Callback', 'do_norm(1)');
uimenu(nmenu, 'Label', 'Y = (X - MEAN(X)) / STD(X)', ...
	'Callback', 'do_norm(2)');
uimenu(nmenu, 'Label', 'Y = 2 * (X-MIN(X)) / (MAX(X)-MIN(X)) - 1', ...
	'Callback', 'do_norm(3)');
uimenu(nmenu, 'Label', 'Y = X / TREND(X)', ...
	'Callback', 'do_norm(4)');
uimenu(nmenu, 'Label', 'Y = X - MEAN(X)', ...
	'Callback', 'do_norm(5)');
uimenu(nmenu, 'Label', 'Y = FOUR_FILTER(X,72)', ...
	'Callback', 'do_norm(6)');
uimenu(nmenu, 'Label', 'Y = BUTT_FILTER(X, 72)', ...
	'Callback', 'do_norm(7)');


PLOT_MENU = uimenu('Label','Plot');
uimenu(PLOT_MENU,'Label','Activity','Callback','activity_menu', ...
       'Accelerator','A');
uimenu(PLOT_MENU,'Label','Actogram...','Callback','acto_menu', ...
       'Accelerator','C');
uimenu(PLOT_MENU,'Label','Autocorrelation...','Callback','auto_menu', ...
       'Accelerator','R');
uimenu(PLOT_MENU,'Label','Histogram...','Callback','histo_menu', ...
       'Accelerator','H');
uimenu(PLOT_MENU,'Label','Periodogram...','Callback','pgram_menu', ...
       'Accelerator','P');
mmenu = uimenu(PLOT_MENU,'Label','MESA');
uimenu(PLOT_MENU,'Label','FFT...','Callback','fft_menu', ...
       'Accelerator','F');
lmenu = uimenu(PLOT_MENU,'Label','Layout', 'Separator','on');

uimenu(mmenu, 'Label', 'Burg...', 'Callback','mesa_menu(''pburg'')')
uimenu(mmenu, 'Label', 'Dusty...', 'Callback','mesa_menu(''dusty'')')
uimenu(mmenu, 'Label', 'Music...', 'Callback','mesa_menu(''pmusic'')')
uimenu(mmenu, 'Label', 'PYULEAR...', 'Callback','mesa_menu(''pyulear'')')

uimenu(lmenu, 'Label', 'Cascade', 'Callback', 'set_layout(1)');
uimenu(lmenu, 'Label', 'Replace', 'Callback', 'set_layout(2)');
uimenu(lmenu, 'Label', 'Tile...', 'Callback', 'tile_menu'); 

% can't display or modify a record till we've got one
disable(MOD_MENU)
disable(PLOT_MENU)

% can't do various things till we've got some DAM data
disable(DAM_LOAD_B_MENU)
disable(DAM_TRUNC_MENU)
disable(DAM_TRUNC_B_MENU)
disable(DAM_PIN_MENU)
disable(DAM_PIN_B_MENU)
disable(DAM_PHASE_MENU)
disable(PHASE_B_MENU)
disable(PHASE_BIVAR_MENU)
disable(PHASE_MULTI_MENU)
disable(DAM_RALPH_MENU)
disable(RALPH_B_MENU)
disable(DAM_REVERT_MENU)
disable(DAM_REVERT_B_MENU)
disable(DAM_REVERT_BOTH_MENU)