function incubator = choose_incubator
% return index of selected incubator choice based on radio button in HARP

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
global DAYLIGHTS
global INCU_RADIO

if ~isempty(DAYLIGHTS)
  for i=1:length(INCU_RADIO)
    if uival(INCU_RADIO(i))
      break
    end
  end
  incubator = i - 1;
end


