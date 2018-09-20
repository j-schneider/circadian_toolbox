function a=amplitude(xx,int,lopass,do_normalize)
%AMPLITUDE peaks-based measure of amplitude of a signal
%Returns the average height of the positive peaks of a signal
%a=amplitude(x,int,lopass,do_normalize)
%
%x: fly data
%int: sampling interval (default: 60)
%lopass: hours of lopass filter to use (default: 8)
%do_normalize: normalize(1) or not normalize(0) before 
%proceeding (default:0).
%
%if x has multiple columns, then a list of amplitudes
%is returned.

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
    do_normalize=0;
end
if nargin<3
    lopass=8;
end
global normalization_method
if isempty(normalization_method)
    normalization_method=4;
end

if do_normalize
    xx=normalize(xx,normalization_method);
end

if lopass>0
    xx=butt_filter(xx,lopass*60/int);
end
for i=1:size(xx,2)
    x=xx(:,i);
    m=mean(x);  
    p=findpeaks(x-m);
    q=findpeaks(-(x-m));
    a(i)=mean([p;q]);
end

