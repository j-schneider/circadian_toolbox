function cyc_all2(minpulses,ipimax)

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
direc = dir; filenames = {};
[filenames{1:length(direc),1}] = deal(direc.name);
for i=1:length(filenames)
  file=filenames{i};
  where=findstr(file,'.cyc');
  if ~isempty(where) & where(1)==length(file)-3
    cyc_bouts2(file,minpulses,ipimax)
    drawnow;
  end
end
