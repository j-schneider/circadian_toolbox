function xx=graygram(x,freq)
% graygram(y,freq)
% plots a grayscale actogram
% see also: actogram
% y: activity vector
% freq: sampling frequency (i.e., 2 for dam, 1 for luc)

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
cla;hold off
if size(x,2) > 1
  x=x';
end
if size(x,2)>1
  error('X must be a vector');
end
n=length(x);
maxx=max(x);
minx=min(x);
shift=1.1*(maxx-minx);
w=24*freq;
if mod(n,w) ~= 0
  nn=ceil(n/w)*w;
  x=[x;zeros(nn-n,1)];
else
  nn=n;
end
l=nn/w;
xx=reshape(x,w,l)';
xx=(xx - minx) ./ (maxx - minx);
y=[xx(2:l,:);zeros(1,w)];
xx=[xx,y];
xx=1-xx;
image(xx*63+1);
%pcolor(xx);
shading flat;
colormap(gray);

set(gca,'xlim',0.5+[0 2*w]);
set(gca,'xtick',0.5+(0:8)/8*2*w);
set(gca,'xticklabel',mod(0:6:48,24));
ylabel('day');
xlabel('time (h)');
set(gca,'xgrid','on')
