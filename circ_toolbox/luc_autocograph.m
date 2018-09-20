function [a,b]=luc_autocograph(a1,list,peak,int)

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
b=a1(:,list);
if nargin<3
  peak=1;
end
if nargin<4
    int=60;
end

if isstruct(peak)
    par=peak;
    peak=par.peak;
    int=par.int;
    normalization_method=par.normalization_method;
    filter_hours=par.filterHours;
else
    par=dam_panels_par;
    filter_hours = 4;
    global normalization_method
    if isempty(normalization_method)
      normalization_method=4;
    end
end

if par.normalize==1
    for i=1:length(list)
      b(:,i)=normalize(b(:,i),normalization_method);
    end
end

k=length(list);
m=mean(b,2);
s=std(b,0,2)/sqrt(k);;
n=length(s);
if filter_hours==0
    fm=m;
else
    fm=butt_filter(m,60/int*filter_hours);
end
[ac,x,ci]=autoco(fm,60/int,1);
if peak
    [a,b]=acplot(ac,x,ci,par.peakRange+24);
else
    [a,b]=acplot(ac,x,ci);
end
return
