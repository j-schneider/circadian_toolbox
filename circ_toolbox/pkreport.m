function pkreport(x, y, xbeg, xend)
% report peak within specified range of X/Y plot 

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

% clobber out-of-bounds values
oob = find(x<xbeg | x>xend);
y(oob) = -Inf;

peakval = max(y);
peakloc = x(find(y == peakval));

if length(peakloc) > 1
  errordlg('More than one peak')
end

blurb(sprintf('Peak at: %5.2f    Value = %5.2f\n', peakloc, peakval))
