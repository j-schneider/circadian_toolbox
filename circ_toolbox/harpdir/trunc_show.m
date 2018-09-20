function trunc_show
% show various types of information in HARP truncation dialog

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
global TRUNC_SNAP_CHKBOX
global CURRENT_DATA

cla
hold on

incu = incu_radio_value;

xlim = get(gca, 'XLim');

% handle DAM data
if isstruct(CURRENT_DATA)
  y = CURRENT_DATA.f;
  beg = CURRENT_DATA.first;
  cdlen = CURRENT_DATA.len;
  ymin = min(min(y));
  ymax = max(max(y));
  yminvec(1:beg-1) = ymin;
  for i = 1:size(y, 2)
    z(i,:) = [yminvec y(:,i)'];
  end
else
  [y,beg]= cleanup;
  ymin = min(y);
  ymax = max(y);
  z(1:beg-1) = ymin;
  z = [z y'];
  cdlen = length(CURRENT_DATA);
end

set(gca, 'YLim', [ymin ymax])

xinc = xlim(2) / cdlen;

disable(TRUNC_SNAP_CHKBOX)  

if incu > 0
  [diff,lights] = trunc_diff(incu);
  if ~isempty(find(lights))
    enable(TRUNC_SNAP_CHKBOX)  
    on = find(diff > 0) + 1;
    off = find(diff < 0) + 1;
    if lights(1)
      on = [0 on];
    else
      off = [0 off];
    end
    if length(on) > length(off)
      off(end+1) = 2*on(end); % simulates +Infinity
    end
    on = on * xinc;
    off = off * xinc;
    lo = 1;
    where = find(off > on(lo));
    hi = where(1);
    while lo<=length(on) & hi<=length(off)
      rpatch(on(lo), 0, off(hi)-xinc, ymax, .85)
      lo = lo + 1;
      hi = hi + 1;
    end
  end
end

x = [xinc:xinc:cdlen*xinc];

nsig = size(z,1);
inc = 1 / nsig;
yrange = ymax - ymin;
for i = 1:nsig
  plot(x,  (i-1)*inc*yrange + inc*z(i,:))  
end

set(gca, 'XLim', [0 xlim(2)])
plot_trunc_limits

trunc_edit_update