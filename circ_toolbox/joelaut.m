function [ac,x,ci]=joelaut(a,bptu,detren)
%JOELAUT Old autocorrelation function
% [ac,x,ci]=joelaut(a,bptu,detren)
%
% NOT RECOMMENDED: USE AUTOCO INSTEAD
%
% joelaut adapted from dusty's
% input:
% a is a flydata matrix such as obtained from readfly or dust_read
% outputs:
% ac is autocorrelation matrix
% x are the x axis
% ci is confidence interval
% bptu: bins per time unit defaults to 1
% detren: 0=no detrend; 1=linear (default);
% 2=loglog; 3=butter high
%
% SEE ALSO: d_autoco, autoco

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
dusty_code=1;

if nargin < 2
  bptu=1;
end

if nargin< 3
  detren=1;
end

ci=zeros(1,size(a,2));
n=size(a,1);
sqn=1.965/sqrt(size(a,1));
for i=1:size(a,2)
  switch (detren)
   case 0
    f=a(:,i);
   case 1
    f=notrend(a(:,i));
   case 2
    f=nologtrend(a(:,i));
   case 3
    f=butt_detren(a(:,i));
  end
  if (dusty_code)
    [r1,r2,sqn]=d_autoco(f,floor(n/2),bptu,0);
  else
    [r2,x]=xcorr(f,'coeff');
    if (size(r2,1)>1)
      r2=r2';
    end
  end
    ac(:,i)= r2';
    ci(i)=sqn;
end
if (dusty_code)
  if mod(n,2)==0
    x=-floor(1+n-(n/2)):floor(n-((n+1)/2));
  else
    x=-floor(n-(n/2)):floor(n-((n+1)/2));
  end
  x=x' ./ bptu;
end
%n
%size(ac)
%size(x)


