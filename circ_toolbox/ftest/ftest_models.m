function prob=ftest_models(N, chisq_p, chisq_r, p, r)
%FTEST_MODELS ( N, chisq_p, chisq_r, p, r) with p>r,
%  and chisq_p < chisq_r, returns the probability that 
%  the reduction in chi-squared (squared error) from 
%  model "p" over model "r" is actually due to chance.  
%  This probability is the risk that the extra parameters 
%  in p are meaningless.  N=number of data.
%
%  see FDIST, FDISTINV; 
%  also see FTEST_BACKGROUND and FTEST_EXAMPLE

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
% March, 1990

% ^ Calls FDIST, BETAI, BETACF and GAMMLN  ^

if p<r,
 disp('^p should be > r');
 elseif chisq_p>chisq_r,
  disp('^chisq should DECREASE with increasing params')
 end
end
F = (chisq_r-chisq_p) * (N-p) / ( (p-r) * chisq_p);
v1=p-r;
v2=N-p;
prob = fdist( F, v1, v2 );
