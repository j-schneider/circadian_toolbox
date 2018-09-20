function [y,b,a]=butt_filter(x,pmin,pmax,order,twopass)
% y=butt_filter(x,pmin,pmax,order,twopass)
%
% This function designs a new butterworth filter
% that cuts off periods longer than pmax and periods shorter
% than pmin, and filters data vector x with it. 
% parameters: 
% x: data to be filtered
% min: minimum period length 
% max: maximum period length
% use max=0 (no maximum) to obtain a low-pass filter, 
% or min=0 (no minimum) to obtain a high-pass filter
% order: order of the butterworth filter (default: 2)
% twopass: do (1) or don't do (0) a reverse-pass to compensate
% phase (default:1)
%
% Optionally you can call this function as
% [y,b,a]=butt_filter( ... )
% to obtain the coefficients of the filter
%
if ~exist('pmin') | isempty(pmin)
  pmin=0;
end
if ~exist('pmax') | isempty(pmax)
  pmax=0;
end
if ~exist('order') | isempty(order)
  order=2;
end
if ~exist('twopass') | isempty(twopass)
  twopass=1;
end
if pmax == 0
  if pmin == 0
    y=x;
    return;
  end
  [b,a]=mybutter(order,2/pmin,'low');
elseif pmin == 0
  [b,a]=mybutter(order,2/pmax,'high');
else
  [b,a]=mybutter(order,[2/pmax,2/pmin]);
end 
if twopass
  y=myfiltfilt(b,a,x);
else
  y=filter(b,a,x);
end
