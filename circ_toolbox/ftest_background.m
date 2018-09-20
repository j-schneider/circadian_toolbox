% Background on the F-test, and the use of the m-functions:
%   FDIST
%   FDISTINV
%   FTEST_MODELS
%
% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu
% March, 1990
%
% References:
% Abramowitz, M. & I.A. Stegun, Handbook of Mathematical
%    Functions, Dover, 1972.
% Bevington, P.R., Data Reduction and Error Analysis
%    for the Physical Sciences, McGraw-Hill, NY 1969;
% Stein, S. & R.G. Gordon, Earth and Planet. Sci Lett.
%    69:401-412, 1984.
%
% -----------------------------------------------------------
% The F-test is concerned with the ratio of variances,
% of chi-squared, which is the sum of squares of misfit
% between the observed data
%  obs                           pred
% d    and the model prediction d    , normalized
% by the expected variance (sigma) of each datum:
%
%                  obs     pred  2         2
%   chisq = SUM ( d    -  d     )   / sigma     (1)
%            i     i       i                i
%
%
% N data are to be fit by two alternative models,
% one with p parameters, and one with r parameters.
% (Here, we assume p>r; the variance of residuals from
% model p should be smaller than that from model r.)
% The F-statistic is defined as the ratio
%
%      [chisq(r)-chisq(p)] / (p-r)
%  F = --------------------------              (2)
%          chisq(p) / (N-p)
%
% This statistic is F-distributed with
% v1=(p-r) and v2=(N-p) degrees of freedom.
%
% The F-test considers the probability P(F|v1,v2)
% that the reduction in chi-squared in the second
% model is significantly better than the reduction
% that would have been obtained if meaningless
% extra parameters had been used.
% Often this is expressed as Q(F|v1,v2)=1-P(F|v1,v2),
% e.g., if Q(F|v1,v2)=.02, there is only a 2% risk
% the improvement is due to chance.
%
% m-files available:
%
% FDIST( F, v1, v2) returns Q(F|v1,v2)
%
% FTEST_MODELS ( N, chisq_p, chisq_r, p, r)
%   for p>r and chisq_p<chisq_r,
%   returns the probability risk that the decrease in
%     variance associated with model p is actually
%     due to chance alone.
%
% F = FDISTINV( v1, v2, alpha )
%   returns the value F for which FDIST( F, v1, v2) = alpha.
%
% Also see FTEST_EXAMPLE
