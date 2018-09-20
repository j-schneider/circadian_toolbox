function s=vsmooth(x,v)
% s=vsmooth(x,v)
% sliding window weighted average:
% smooth x by convolution with v
% by default v is [1 2 3 2 1] but use anything you like

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
if nargin<2
  v=[1 2 3 2 1];
end
k=length(v);
lo=floor(k/2);
ro=lo;
n=length(x);
if (size(x,1)>1)
  x=x';
  transp=1;
else
  transp=0;
end
mat=zeros(k,n);
w=[ones(1,lo),1:n,n*ones(1,ro)];
for i=1:k
  mat(i,:)=x(w(i:i+n-1))*v(i);
end
s=sum(mat,1)/sum(v);
if size(x,1)>1
  s=s';
end

