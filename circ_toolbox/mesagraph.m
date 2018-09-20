function rhythm=mesagraph(f,tau,peaklim,noplot)
%MESAGRAPH  Plot mesa data and find principal peak
% rhythm=mesagraph(f,tau,peaklim[,noplot])
%
% f,tau are MESA data (see per_mesa, d_mesa, etc.)
% peaklim=[min,max] is the range to check for peaks.
% If peaklim is specified, the highest peak between 
% min and max is marked in the graph and its x value retruned.
%
% noplot: if set to one, no plot is made (only rhythm returned)
% 
% see also: mesaplot

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
if nargin<3
  peaklim=[];
end
if nargin<4
  noplot=0;
end

if ~noplot
  plot(tau,f);
  hold on
  xlabel('period (h)')
  ylabel('power');
  set(gca,'xlim',[0 48]);
  set(gca,'xtick',(0:12:48));
  grid on
end

if nargin>2 & ~ isempty(peaklim)
  [peaks,peakx]=findpeaks(f);
  peaktau=tau(peakx);
  fitpeaks=find((peaktau<=peaklim(2)) & (peaktau>=peaklim(1)));
  %peakx(fitpeaks)
  if isempty(fitpeaks)
    rhythm=[];
  else
    thapeak=find(peaks(fitpeaks) == max(peaks(fitpeaks)));
    thapeak=fitpeaks(thapeak);
    rhythm=peaktau(thapeak);
    if ~noplot
      plot(rhythm,peaks(thapeak),'*');
      mybox(sprintf('* peak = %2.1fh',rhythm),4);
    end
%    text(rhythm,peaks(thapeak),num2str(rhythm,' %2.1f'));
  end
else
   rhythm=[];
end
