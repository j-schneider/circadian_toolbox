function meangraph(b,start,int)

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
if nargin<2
  start=0;
end
if nargin<3
  int=60;
end

k=size(b,2);
m=mean(b,2);
s=std(b,0,2)/sqrt(k);
n=length(s);
hold off
fill((-1+[1:n,n:-1:1]).*int/60,[m'+s',reverse(m'-s')],.8*[ 1 1 1], ...
     'linestyle',':');
hold on
plot((0:n-1).*int/60,m,'k')
set(gca,'xlim',[0 n].*int/60);
xlabel('Time (hr.)')
xlim=get(gca,'xlim');
set(gca,'xtick',0:12:xlim(2))
grid on
