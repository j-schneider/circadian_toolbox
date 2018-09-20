% Examples on the use of the m-functions:
%   FDIST
%   FDISTINV
%   FTEST_MODELS
%
% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu
% March, 1990
%
% -----------------------------------------------------
% N data are to be fit by two alternative models,
% model "p" with p parameters, and model "r", with r
% parameters. When p>r chi-squared for "p" should
% be smaller than for "r": chisq_p < chisq_r.
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
% ----------------------------------------------------
% Example 1:
%
% You are attempting to model 1000 measurements stored
% in the 1000 by 1 vector DATA.  You have two alternate
% models, "p" and "r", which produce the predicted data
% PRED_P and PRED_R; these are also 1000 by 1 vectors.
% Model "r" has only 25 parameters, while model "p" has
% 29 parameters and fits the data better.
%
% All of the measurements have the same uncertainties,
% so that instead of formally computing chi-squared,
% the residual variance can be used when computing the
% F-ratio. The residual variance is given by, e.g.:
% RESIDVAR_P = SUM( (DATA-PRED_P).^2 );
% RESIDVAR_R = SUM( (DATA-PRED_R).^2 );
% If the data are given in units of km, say, these
% variances have units squared-km.
%
% Here is the summary of how the two models stack up:
%
% Model    Parameters     Data   Residual variance
%   "r"        r=25       N=1000   RESIDVAR_R = 880
%   "p"        p=29       N=1000   RESIDVAR_P = 870
%
% The probability of risk that this reduction is
% coincidental can be computed using the function
% FTEST_MODELS( N, chisq_p, chisq_r, p, r) as follows:
%
% PROB = FTEST_MODELS( 1000, 870, 880, 29, 25 );
%
% yielding PROB = .0254,
%                          (880-870) / (29-25)
% or through computing F = ------------------   = 2.79
%                            870 / (1000-29)
%
% and using the function FDIST directly:
%
% PROB = FDIST( 2.79, (29-25), (1000-29) );
%
% which yields the same answer, PROB = .0254
% The probability is thus about 3% that this reduction
% is purely a matter of chance.  Equivalently stated, the
% reduction is "significant at the 97% confidence level".
% This may or may not be enough to convince your colleagues.
%
% ------------------------------------------------------
% Example 2:
%
% In Example 1, suppose you want to search for another
% model with 29 free parameters, but now one that is
% better than model "r" at the 99% significance level.
% Both v1=(29-25) and v2=(1000-29) are fixed; the F-ratio
% that this new model would have to produce must now
% satisfy FDIST( F99, v1, v2)=0.01  where F99 is the
% threshold F-ratio.
% This is found through "FDISTINV":
%
% F99 = FDISTINV( (29-25), (1000-29), 0.01 );
%
% yielding F99=3.34
% *Check: FDIST( 3.34, 4, 971 ) = 0.010
%
% Also see FTEST_BACKGROUND
