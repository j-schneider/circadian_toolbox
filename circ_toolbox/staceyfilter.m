function [data,interval,x]=staceyfilter(m)
%STACEYFILTER add missing points, extract x vector, and return pure data
%for Stacey's files (first column is x, others are data).
%
% returns data = data columns
% interval=min x increment
% x=time sequence
%
% If not all intervals are identical, then the minimum is taken,
% a warning prints out and data is refitted to even steps of interval
% size, using linear interpolation.

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

x=m(:,1);
m=m(:,2:end);
steps=x(2:end)-x(1:end-1);
interval=min(steps)
maxinterval=max(steps);
if (interval==maxinterval)
    data=m;
else
    fprintf('Intervals are uneven, attempting repair\n')
    newx=x(1):interval:x(end);
    fprintf('Adding: ');
    fprintf('%.1f ',setdiff(newx,x));
    fprintf('\n');
    data=zeros(length(newx),size(m,2));
    for i=1:size(m,2)
        data(:,i)=interp1(x,m(:,i),newx)';
    end
    x=newx;
end
interval=interval*60
