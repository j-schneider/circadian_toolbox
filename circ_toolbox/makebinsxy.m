function [means,xs,sums,counts]=makebinsxy(x,y,int)
% MAKEBINSXY Group y-data into bins by interval
% [means,xs,sums,counts]=makebinsxy(x,y,int)
% This function lets you fix a sample of data whose data-collection
% points are irregular. 
% X is a series of timestamps (in hours) and Y the correspoinding
% measurements. Int is the desired interval. 
% The new xs are separated by int, and means are the averaged
% measure of all y's that fell inside the bin. Sums and counts are
% also output (where each bins' mean is sum/count). 
% Empty bins are left at zero. 

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
hint=int/60;
binno=1+floor(x/hint);
sums=full(sparse(binno,1,y));
counts=full(sparse(binno,1,1));
nonempty=find(counts>0);
means=zeros(size(sums));
means(nonempty)=sums(nonempty) ./ counts(nonempty);
xs=((0:length(sums)-1)*hint)';
