function lag=findlags(g,int,usemesa)
%FINDLAGS: Find phase using crosscorrelation with square wave
% lag=findlags(g,int,usemesa)
% g: fly data vector
% int: sampling interval
% usemesa: use period of 24 hr (0) or find period with mesa (1).
% or use another period (>1)
%
% see also: peakphase

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
n=size(g,1);
for i=1:size(g,2)
  % 1. crosscorrelate
  if usemesa==1
    per=mesaplot(g(:,i),int,[15 33])
  else 
    if usemesa==0
      per=24;
    else
      per=usemesa;
    end
  end
  per=per*60/int;
  s=square(floor(per/2),round(per)-floor(per/2),n);
  [r,x]=xcorr(notrend(g(:,i)),s,12*60/int,'coeff');
  [peakh,peakx]=findmaxpeak(r);
  %i
  %clf
  %plot(x,r);hol d on; plot(peakx,peakh,'*');hold off
  
  %pause
  lag(i)=x(peakx)*int/60;
end
