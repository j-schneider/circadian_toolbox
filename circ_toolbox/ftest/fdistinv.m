function F = fdistinv(v1,v2,alpha)
%F = fdistinv(v1,v2,alpha);
%   gives the value of F for which fdist(F,v1,v2) = alpha.
%
%   This is normally tabulated as "Percentage Points of the
%   F-distribution - Values of F in terms of A, v1, v2"
%   e.g., in Abramowitz & Stegun's Table 26.9, the value
%   F for which Q(F|v1,v2)=0.01 when v1=3, v2=20 is 4.94,
%   the same answer found through F=FDISTINV(3,20,0.01)
%
%   See FDIST, FTEST_MODELS
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
% Reference: Abramowitz & Stegun, Handbook of Mathematical
% Functions, Dover, 1972.

% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu
% March, 1990

% ^ Calls FDISTINVAUX, FDIST, BETAI, BETACF and GAMMLN  ^

F=fsolve('fdistinvaux',2.5,zeros(16,1),[v1,v2,alpha]);
