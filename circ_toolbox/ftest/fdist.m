function pf = fdist(f,v1,v2)
%FDIST( F, v1, v2) returns Q(F|v1,v2), the probability
%   of observing a value of F or greater in an
%   F-distribution with v1 and v2 degrees of freedom.
%
%   e.g., in Abramowitz & Stegun's Table 26.9, the value
%   F for which Q(F|v1,v2)=0.01 when v1=3, v2=20 is 4.94;
%   this can be verified by confirming that
%   FDIST( 4.94, 3, 20 ) returns a probability of 0.01, or 1%.
%
%   To find the value 4.94, use FDISTINV.
%   To apply the F-test, use FTEST_MODELS
%   also see FTEST_BACKGROUND and FTEST_EXAMPLE

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
% References: Press et al., Numerical Recipes,
%   Cambridge, 1986;
% Abramowitz & Stegun, Handbook of Mathematical
%   Functions, Dover, 1972.

% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu
% March, 1990

% ^ Calls functions BETAI, BETACF and GAMMLN  ^

a = v2 ./ 2;
b = v1 ./ 2;
x = v2 ./ ( v2 + v1 .* f) ;
if(a<0),
 pf = 1.0;
else
 pf = betai(a,b,x);
end

