function do_phase
% run HARP DAM phase using current params

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
global PHASE_LOPASS_HOURS
global PHASE_NORMALIZE
global PHASE_FIRST_HOUR
global PHASE_PERIOD
global PHASE_TYPE

global DAM_DATA_A
global DAM_DATA_B

global DAILY_HOURS

% use A
if PHASE_TYPE ~= 2

  if ~isempty(DAM_DATA_A.daylight)
    first_hour_a = PHASE_FIRST_HOUR;
  else
    first_hour_a = 0;
  end

  [p1,c1,c2,r1] = peakphase(DAM_DATA_A.f, DAM_DATA_A.int, ...
	  		    PHASE_LOPASS_HOURS, PHASE_NORMALIZE, ...
			    PHASE_PERIOD, first_hour_a);
end

% use B
if PHASE_TYPE ~= 1
  
  if ~isempty(DAM_DATA_B.daylight)
    first_hour_b = PHASE_FIRST_HOUR;
  else
    first_hour_b = 0;
  end

  [p2,c1,c2,r2] = peakphase(DAM_DATA_B.f, DAM_DATA_B.int, ...
			    PHASE_LOPASS_HOURS, PHASE_NORMALIZE, ...
			    PHASE_PERIOD, first_hour_b);
end

setup

switch PHASE_TYPE
  
 case 2 % single B
  
  avghour(p2);
  
 case 3
  
  multiple_test(p1,p2)  
    
 case 4
  
  bivariate(p1,r1,p2,r2);

 otherwise % single A

  avghour(p1);
  
end

set(gcf, 'Name', phase_typename)