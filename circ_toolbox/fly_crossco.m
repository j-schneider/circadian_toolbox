function [c,lags,peakx]=fly_crossco(d1,d2,int,maxlag)

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
  int=60;
end
if nargin<4
  maxlag=48;
end
if strcmp(version('-release'),'12')==1
  % matlab release 12 inverts xcorr !!!
  % this could need a fix when going to release 13
  t=d1; 
  d1=d2;
  d2=t;
end
[c,lags]=xcorr(notrend(d1),notrend(d2),60/int*maxlag,'coeff');
lags=lags/2;
clf
plot(lags,c);
peak=max(c);
where=find(c==peak);
plag=lags(where);
hold on
if ~isempty(plag)
  plot(plag,peak,'*')
  text(plag,peak*1.1,sprintf('%f',plag));
  peakx=plag;
end
grid on

