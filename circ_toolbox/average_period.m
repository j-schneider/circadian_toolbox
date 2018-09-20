function [per,sem,nr]=average_period(a,wells,int,range)
%AVERAGE_PERIOD calculate average mesa period
%[per,sem,nr]=average_period(a,wells,int,range)

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
if nargin<4
  range=[15 33];
end
if nargin<2
    wells=1:size(a,2);
end
if nargin<3
    int=60;
end
r=[];
for i=1:size(a,2)
  ri=mesaplot(a(:,i),int,range)
  if isempty(ri)
    fprintf('warning: %d is arhytmic',i);
  else   
    r(end+1)=ri;
  end
end
nr=length(r);
if nr==0
  fprintf('No rhytmic flies found');
  per=[];
  sem=[];
else
  per=mean(r);
  sem=std(r)/sqrt(nr);
  label=sprintf('N=%d NR=%d Per=%.2f sem=%.2f',size(a,2),nr,per,sem);
  title(label);
  fprintf(label);
end
