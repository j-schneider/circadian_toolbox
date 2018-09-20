function [off,per,all,norms]=peakphase(xx, int, lopass, do_normalize,...
				       period, first_hour)
%PEAKPHASE Peak-based measurement of phase
% [off,sem,all]=peakphase(xx,int,lopass,do_normalize,period,first_hour)
%
% xx: fly data
% int: sampling interval (default: 60)
% lopass: lopass filter to use (default: 8)
% do_normalize: do (1) or don't do (0) a normalization (default: 0)
% period: length of the fly's period. Use 0 to compute period
% first_hour: Time (hour) of first observation (default: 0). 
% using mesa (default: 24)
%
% The method used is as follows:
% 1. Data is smoothed with lopass filter
% 2. If period=0 was specified, period is found using mesa
% 3. Data is divided in chunks of period length
% 4. Highest peak defines offset in each chunk
% 5. Mean offset hr divided by period mutliplied by 24 is the result. 
% (offset=distance from beginning of segment to highest peak)
%
% if there's more than one fly (colum) in xx, phase
% of each column is returned
% the optional output per returns periods (mesa or 24) per fly. 
% the optional output all returns each fly's peaks. 
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

global DAILY_HOURS
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
  end
  all={};
peaklim=[15 33];
if nargin<6
  first_hour=0;
end
if nargin<5
    period=DAILY_HOURS
end

if nargin<4
    do_normalize=0;
end
if nargin<3
    lopass=8;
end
global normalization_method
if isempty(normalization_method)
    normalization_method=4;
end

if do_normalize
    xx=normalize(xx,normalization_method);
end

if lopass>0
    xl=butt_filter(xx,lopass*60/int);
else
    xl=xx;
end

off=[];
norms=[];
per=[];
%figure(99)
for i=1:size(xl,2)
    x=xl(:,i);
    if period==0
        [f,tau]=per_mesa(notrend(xx(:,i)),int);
        [peaks,peakx]=findpeaks(f);
        peaktau=tau(peakx);
        fitpeaks=find((peaktau<=peaklim(2)) & (peaktau>=peaklim(1)));
        %peakx(fitpeaks)
        if isempty(fitpeaks)
            fprintf('fly %d is arhythmic!\n',i)
            rhythm=0;
        else   
            thapeak=find(peaks(fitpeaks) == max(peaks(fitpeaks)));
            thapeak=fitpeaks(thapeak);
            rhythm=peaktau(thapeak)
        end
    else
        rhythm=period;
    end
    if rhythm>0
        [p,px]=findpeaks(x);
        flyph=[];
        ph=px*int/60;
        j=1;
        while (((j-1)*rhythm) < max(ph))
            good=find((ph>=((j-1)*rhythm)) & (ph<(j*rhythm)));
            if isempty(good)
                fprintf('Warning: fly %d skips beat %d\n',i,j);
            else
                pph=ph(good);
                ppp=p(good);
                k=find(ppp==max(ppp));
                pph=pph(k);
                flyph(end+1)=pph-(j-1)*rhythm;
            end
            j=j+1;
        end
        if isempty(flyph)
            fprintf('No peaks on fly %d\n',i);
        else
	  flyph=flyph/rhythm*DAILY_HOURS;
	  % flyph=mean(flyph);
	  all{end+1}=mod(flyph+first_hour,DAILY_HOURS);
	  [flyph,norm]=rayleigh(flyph,'NOPLOT');
	  off(end+1)=mod(flyph+first_hour,DAILY_HOURS);
	  norms(end+1)=norm;
	  per(end+1)=rhythm;
        end
    end
end
%close
            
            
  
