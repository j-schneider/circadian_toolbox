function do_hist
% call hist() using current global data and settings from HARP

global HISTO_BASELINE
global HISTO_FORMAT
global MIN_PER_BIN

[y,beg] = cleanup;

lights = getlights(beg);

bin_per_min = 60 / MIN_PER_BIN;

x = [beg/bin_per_min : MIN_PER_BIN/60 : (length(y)+beg-1)/bin_per_min]';

setup

hours = bin2hrs(HISTO_BASELINE);
minPerBar = MIN_PER_BIN;

% defaults
skipDays = 0;
spanDays = Inf;
lightsOn = -1;
lightsOff = 2500;
firstHour = 0;
plotSEM = 1;

if ~isempty(lights)
  format = HISTO_FORMAT;
else
  format = 0;
end

hist(x, y, lights, format, ...
     hours, skipDays, spanDays, lightsOn, ...
     lightsOff, firstHour, minPerBar, plotSEM);

maketitle('Histogram')


