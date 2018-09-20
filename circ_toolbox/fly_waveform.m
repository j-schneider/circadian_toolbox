function w=fly_waveform(y,nbins,int) 
% FLY_WAVEFORM(y,nbins,int)
% Adds up together all of a fly's days (of nbins length)
% and plots and returns just one average wave of length nbins
% 
% int: (optional, for plotting only): bin-size in minutes
% (e.g. 30). defaults to 60.;
%
% Works on sets of flies (column-wise)

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<3, int=60; end

if (size(y,1)==1)
  y=y';
end
if (size(y,1)<nbins)
  fprintf('Error: there are only %d bins of data\n',size(y,1));
  return;
end
m=size(y,1);
days=m/nbins;
if (days<2)
  fprintf('Error: there are just %f cycles here\n',days);
  return
end
if (days ~= floor(days))
  newsize=floor(days)*nbins;
  fprintf('WARNING: dropping %d bins at the end of the data\n',(m- ...
						  newsize));
  y=y(1:newsize,:);
  days=floor(days);
end
for i=1:size(y,2)
  fly=y(:,i);
  histo=reshape(fly,nbins,days);
  histo=mean(histo,2);
  if (i==1)
    w=histo;
  else
    w(:,end+1)=histo;
  end
end
bar((0:nbins-1)/60*int,mean(w,2));
set(gca,'xlim',[0 (nbins-1)/60*int]);
