function ff=fcutoff(f,min,max,interval)

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
if nargin < 4
  interval=1;
end
fou=fft(f);
n=length(f);
highcutoff=ceil(n/min);
fou(highcutoff:n)=0;
lowcutoff=floor(n/max);
fou(1:lowcutoff)=0;
fprintf('interval=%d %d\n',lowcutoff,highcutoff);
ff=real(ifft(fou));

