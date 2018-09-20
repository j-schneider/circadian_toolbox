function gl=gammln(xx)
%GAMMLN   Natural log of the complete Gamma function.
%   GAMMLN(X) returns the log of the gamma function
%   for every element of X.

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
%   Useful in formulas involving, e.g., gamma(x)/gamma(y)
%     for large x and y.

% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu

% Converted from the Fortran subroutine "GAMMLN" in:
% Numerical Recipes, Press et al., Cambridge, 1986.

% ^ Calls no other routines ^

cof=[76.18009173, -86.50532033, 24.01409822, ...
-1.231739516, 0.120858003e-2, -0.536382e-5];
stp=2.50662827465;
[mxx,nxx]=size(xx);
one=ones(mxx,nxx);
half=0.5*one; fpf=5.5*one;
x=xx-one;
tmp=x+fpf;
tmp=(x+half).*log(tmp)-tmp;
ser=one;
for j=1:6,
  x=x+one;
  ser=ser+cof(j)./x;
end
gl=tmp+log(stp*ser);
