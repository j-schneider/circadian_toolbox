function [hour,corr,hpol,norm]=avghour(list,symbol,h,fontsize,mk1,mk2,color);
%AVGHOUR  Compute mean hour using polar coordinates
% [hour,corr]=avghour(list,symbol,h,fontsize)
%
% compute and plot average hour
% from a list of hours
% outputs the average hour
% and correlation coefficient 
%
% See also: hourtest, rayleigh.
%
% NOTE: The global variable DAILY_HOURS defines the duration
% of the day. By default it's DAILY_HOURS=24. 
% Source: Batschelet 81, p. 34

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
global DAILY_HOURS
if isempty(DAILY_HOURS)
  DAILY_HOURS=24;
end
if ~(DAILY_HOURS==24)
  DAILY_HOURS
end
global avghour_init
if isempty(avghour_init)
  avghour_init=1.9;
end

if nargin<3
  h=1.0;
end
if nargin<2
  symbol='o';
end
if nargin<4
  fontsize=[];
end
if nargin<5 | mk1==0
  mk1=[];
end
if nargin<6 | mk2==0
  mk2=[];
end
if nargin<7 | color==0
  color=[];
end
list=list./DAILY_HOURS*2*pi;
if size(list,2)>1
  list=list';
end

n=length(list);
co=cos(list);
si=sin(list);
x=sum(cos(list));
y=sum(sin(list));
corr=(x^2+y^2)/n;
if x==0
  if y>0
    angle=pi;
  else
    angle=3*pi;
  end
else
  angle=atan(y/x);
  if (x<0)
    angle=angle+pi;
  end
end
    
hour=angle/(2*pi)*DAILY_HOURS;
hour=mod(hour,DAILY_HOURS);
if hour>(DAILY_HOURS/2)
  hour=hour-DAILY_HOURS;
end


%plot(co,si,'o');

list=sort(list);
heights=ones(n,1)*h;
%n
i=1;
u=find(list(1+i:end)==list(1:end-i));
while ~isempty(u)
  heights(u)=heights(u)+0.05;
  i=i+1;
  u=find(list(1+i:end)==list(1:end-i));
end
  
if avghour_init>0
  hpol{1}=hpolar(0,avghour_init,'w.',0,1,fontsize);
end
hold on;
%set(hpol{1},'fontsize',fontsize);
%size(list)
%size(heights)
hpol{2}=hpolar(list,heights,symbol);
if ~isempty(mk1)
  set(hpol{2},'MarkerSize',mk1);
end
if ~isempty(color)
    set(hpol{2},'color',color);
end

%plot([0 x/n],[0 y/n]);
hpol{3}=hpolar([angle angle],[0 sqrt(x^2+y^2)/n],'-');
set(hpol{3},'LineWidth',1.5)
if ~isempty(color)
    set(hpol{3},'color',color);
end
norm=sqrt(x^2+y^2)/n;
%plot(x/n,y/n,'*');
o=hpolar(angle,sqrt(x^2+y^2)/n,symbol);
set(o,'LineWidth',1.0);
if ~isempty(mk2)
  set(o,'MarkerSize',mk2);
end
if ~isempty(color)
    set(o,'color',color);
end
h=[-12:12];
rad=h/DAILY_HOURS*2*pi;
%plot(cos(rad),sin(rad),'.')
%axis square


