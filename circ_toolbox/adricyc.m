function adricyc(name)

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
first=1;
last=6;
step=1;
bins=first:step:last;
xlim=[first-step/2, last+step/2];
[fid,err]=fopen(name,'r');
for i=1:6
  s=fgets(fid);
  if (i==1)
    fprintf('%s\n',s)
  end
end
a=fscanf(fid,'%f',[12 Inf]);
fclose(fid);
a=a';
hist(a(:,5),bins)
set(gca,'xlim',xlim)
title(sprintf('%s (total cpp)',name))
