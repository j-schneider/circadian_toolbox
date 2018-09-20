function [per,y] = per_plot(x)

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
f=fft(x);
n=length(x);
half=ceil(n/2);
%freq=(1/n)*(0:half-1);
per=[n./(1:half-1)];
y = abs(f(1:half-1)).^2;
plot(per,y);
xl=get(gca,'xlim');
x1=floor(xl(1)/24)*24;
x2=ceil(xl(2)/24)*24;
set(gca,'xtick',x1:24:x2);
xlabel('period (h)');
ylabel('fourier coeff (norm)')

