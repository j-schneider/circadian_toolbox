function [r1,r2,sqn]=d_autoco(x,maxlag,bptu,detren)
%D_AUTOCO Dusty's Autocorrelation Function
%[r1,r2,sqn]=d_autoco(x,maxlag,bptu,detren
%
%     Adapted from JoelAut.for (pf'00). See autoco for matlab implementation.
% 
%     INPUT VECTOR IS X
%     TWO AUTOCORRELATION VECTORS ARE CALCULATED
%     R1 IS THE AUTOCORELATION OF X FOR + LAGS ONLY
%     R2 IS THE       "         FOR + AND -
%     sqn: confidence interval
%
%     MAXLAG IS THE LENGTH OF R1, 2*MAXLAG FOR R2
%     THE LAG OF R1 IS DETERMINED BY; R1(LAG+1)
%     THE VALUE OF R1 CORRESPONDING TO ZERO LAG IS R1(0)
%     R2 IS AN EVEN FUNCTION AROUND R2(MAXLAG)
%
%     maxlag defaults to n/2
%     bptu: bins per time unit defaults to 1 .
%     detren: remove (1) or not (0) a linear trend. Defaults to 1!!

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
nsamps=length(x);
if nargin<2 | isempty(maxlag)
  maxlag=floor(nsamps/2);
end 
if nargin < 3 | isempty(bptu)
  bptu=1;
end
if nargin<4
  detren=1;
end
index=1:nsamps;
if (size(x,1)>1)
  index=index';
end

% first do detren
if (detren)
  x=d_detren(index,x);
end

% first we do the kappa thing that computes sqn
xsum=sum(x);
xbar=xsum/nsamps;
ss=dot((x - xbar),(x - xbar));
s2 = ss / (nsamps-1);
sqn=1.965/sqrt(nsamps);

for k=1:maxlag
  asum=0;
  iend=nsamps-k;
  asum = dot(x(1:iend)-xbar,x(k+1:k+iend))/nsamps;
  %for itime=1:iend
  %  asum = asum + ((x(itime)-xbar)*(x(itime+k)-xbar))/nsamps;
  %end
  r1(k)=asum/s2;
end
tval=0;
r2(maxlag+1)=1;
tau(maxlag+1)=0;
for k=1:maxlag
  tval=tval+1;
  r2(maxlag+1+k)=r1(k);
  tau(maxlag+1+k)=tval;
  tau(maxlag+1-k)=-tval;
  r2(maxlag+1-k)=r1(k);
end

% what's the f for? --pf
%istop=2*maxlag+1;
%for k=1:istop
%  f(k)=r2(k)
%end
