function luc_meangraph(a1,list,do_normalize,int)
%LUC_MEANGRAPH (averaged) activity plot for Luciferase data
% luc_meangraph(a1,list,do_normalize,int)
% parameters:
% a1: matrix of (column) activity data
% list: list of flies (columns) to be averaged (default: all)
% do_normalize: pass (1) or don't pass (0) data through a
% normalization filter before averaging (default: 0)
% int: sampling interval in minutes (default: 60)
%
% note: normalization is done via the "normalize" function. 
% the default normalization method is 4 but can be changed by
% declaring a global variable "normalization_method" and setting
% its value to the desired method (see help normalize)
%

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
  int=60;
end

if nargin<3
  do_normalize=0;
end

if isstruct(do_normalize)
    par=do_normalize;
    do_normalize=par.normalize;
    int=par.int;
else
    par=luc_panels_par;
    par.int=int;
    par.normalize=do_normalize;
end

if nargin<2 | isempty(list)
  list=1:size(a1,2);
end

b=a1(:,list);
global nobox
if isempty(nobox)
  nobox=0;
end

normalization_method=par.normalization_method;

if do_normalize
  for i=1:length(list)
    b(:,i)=normalize(b(:,i),normalization_method);
  end
end

k=length(list);
m=mean(b,2);
avg_act=mean(m);
s=std(b,0,2)/sqrt(k);
[u,v]=size(b);
avg_stdm=std(reshape(b,1,u*v))/sqrt(u*v);
n=length(s);
fill((-1+[1:n,n:-1:1]).*int/60,[m'+s',reverse(m'-s')],.8*[ 1 1 1], ...
     'linestyle',':');
hold on;
plot((0:n-1).*int/60,m,'k')
set(gca,'xlim',[0 n].*int/60);
if do_normalize & normalization_method==4
  set(gca,'ylim',[0 2]);
end
xlabel('Time (hr.)')
if do_normalize
  ylabel('Bioluminiscence (variation)')
else
  ylabel('Bioluminiscence (cps.)')
end
xlim=get(gca,'xlim');
ticks=0:12:xlim(2);
set(gca,'xtick',ticks)
if length(ticks)>8
  skip=floor(length(ticks)/8);
  if (mod(skip,2)==1) 
    skip=skip+1;
  end
else
  skip=1;
end
for i=1:length(ticks)
  if mod((i-1),skip)==0
    ticklabel{i}=num2str(ticks(i));
  else
    ticklabel{i}=[];
  end
end
set(gca,'xticklabel',ticklabel);
if nobox==0
  mybox(sprintf('mean=%.2f stdm=%.2f',avg_act,avg_stdm),1);
end
grid on
