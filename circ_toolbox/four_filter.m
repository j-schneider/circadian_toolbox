function y=four_filter(x,low,high,use_detren)
%FOUR_FILTER Fourier filtering
% y=four_filt(x,low,high,use_detren)
%
% Period-cutoff based on the Fourier coefficients.
%
% This function keeps only periods btw low & high
% use 0 to get lo/hi pass.
%
% see also: butt_filter
%
% Algorithm:
% 1. remove linear trend
% 2. compute DFT
% 3. zero-out coefficients outside the low-high range
% 4. compute inverse-DFT
% 5. add the linear trend back (in lopass only)
% 
% set use_detren=0 to skip steps 1 and 5 above (plain fourier
% filter).

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
    high=0;
end
if nargin<4
  use_detren=1;
end

n=length(x);
half=ceil(n/2);
%freq=(1/n)*(0:half-1);
per=[Inf,n./(1:half-1)];
valid=ones(1,half);
if size(x,1)>1
  transpose=1;
  x=x';
end
if use_detren
  [m,b]=slope(1:n,x);
  x=x-(m*(1:n)+b);
end
f=fft(x);
if low>0
    valid=valid & (per >= low);
end
if high>0
    valid=valid & (per <= high);
end
if rem(n,2)==0
    valid=[valid,valid(half:-1:1)];
else
    valid=[valid,valid(half-1:-1:1)];
end
g=f.*valid;
y=real(ifft(g));
if (low > 0) & (high == 0)
  if use_detren
    y=y+m*(1:n)+b;
  end
end

if transpose
  y=y';
end
