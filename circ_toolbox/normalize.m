function [y,err]=normalize(x,method,int,trend_hours)
%  y=normalize(x,method,int,[trend_hours])
% four methods of normalization for fly data
%
% x= vector of fly activity data
% int=sampling interval (minutes)
% trend_hours=number of hours used to identify a trend (default=72)
% method=
% 1: y=x/mean(x) 
%    Normalize to mean=1, so data is expressed in terms 
%    of percent of average
%
% 2: y=(x-mean(x))/std(x)
%    Normalize to mean 0, std 1
% 
% 3: y=2*(x-min(x))/(max(x)-min(x))-1 
%    Rescale to min=-1 max=+1
%
% 4: y=x./trend(x)
%    Divide by trend, so new data in terms
%    of percent below and percent above moving average=trend.
%
% 5: y=x-mean(x) 
%    Normalize to mean=0
%
% 6: y=four_filter(x,0,trend_hours*int/60,1)
%    (not truly a normalization) Use a Fourier filter/linear
%    detrending combination to detrend
%    the data by eliminating frequencies above 72 h. 
%
% 7: y=butt_filter(x,0,72*int/60,2)
%    Same as 6 but using an order 2 Butterworth filter. 
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
if nargin < 2
  global normalization_method
  if isempty(normalization_method)
    error('normalize: Normalization method not specified');
  else
    method=normalization_method;
  end
end
err=0;
if nargin <3
    int=60;
end
if nargin<4
    trend_hours=72;
end
if (size(x,2)>1 & size(x,1)>1)
  errs=zeros(size(x,2),1);
  for i=1:size(x,2)
    [y(:,i),errs(i)]=normalize(x(:,i),method,int);
  end
  if sum(errs)>0
    fprintf('Normalize: Errors on columns: ');
    fprintf('%d ',find(errs));
    fprintf('\n');
  end
else
  switch (method)
   case 1
    y=x/mean(x);
   case 2
    y=(x-mean(x))/(std(x));
   case 3
    y=2*(x-min(x))/(max(x)-min(x))-1;
   case 4
    trnd=trend(x,int,trend_hours);
    Ma=max(trnd);
    Mi=min(trnd);
    if ((Ma>0)&(Mi<=0)) | ((Ma>=0) & (Mi<0))
      fprintf('Normalize: Warning: Trend zero or negative\n');
      err=1;
    end
    y=x./trnd;
   case 5
    y=x-mean(x);
   case 6
    y=four_filter(x,0,trend_hours*int/60,1);
   case 7
    y=butt_filter(x,0,trend_hours*int/60,2);
    
  end
end


function y=trend(x,int,trend_hours)
%y=four_filter(x,trend_hours*int/60,0);
y=butt_filter(x,trend_hours*int/60,0,2);
return;
 