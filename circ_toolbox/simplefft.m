function [power,freq,period]=simplefft(x,sampling_rate,noplot)

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<2
  sampling_rate=1;
end
if nargin<3
  noplot=0;
end
%clf
Y=fft(x);
Y(1)=0;
n=length(Y);
halfn=round(n/2);
power = abs(Y(1:halfn)).^2;
nyquist = 1/2;
freq = (1:halfn)/(halfn)*nyquist;
freq=freq*sampling_rate;
period=1./freq;
if ~noplot
  figure
  subplot(2,1,1)
  plot(freq,power,'.-')
  xlabel('frequency');
  ylabel('power');
  title('Spectrum')
  % figure
  subplot(2,1,2)
  plot(period,power,'.-');
  ylabel('Power');
  xlabel('Period');
  title('Periodogram')
end
