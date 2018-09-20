function bi=betai(a,b,X)
%BETAI  Incomplete Beta function.
%  BETAI(a,b,x) returns the Incomplete Beta function Ix(a,b)
%  for every element of x.  Parameters a and b must be scalars.

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
% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu

% Converted from the Fortran subroutine "BETAI" in:
% Numerical Recipes, Press et al., Cambridge, 1986.

% ^ Calls functions BETACF and GAMMLN  ^

[m,n]=size(X);
bi=zeros(m,n);
%sorry for this non-vectorized loop, folks:
for i=1:m,
  for j=1:n,
    x=X(i,j);
    if x<0 | x>1,
      error('bad argument x in BETAI')
    end
    if x==0.0 | x==1.0,
      bt=0.0;  % Factor in front of continued fraction
    else
      bt=exp(gammln(a+b)-gammln(a)-gammln(b) ...
           +a*log(x)+b*log(1.0-x));
    end
    if x<(a+1)/(a+b+2), %use continued fraction directly.
      bi(i,j) = bt*betacf(a,b,x)/a;
    else
%     Use continued fraction after making
%     symmetry transformation:
      bi(i,j) = 1.0-bt*betacf(b,a,1.0-x)/b;
    end
  end
end
