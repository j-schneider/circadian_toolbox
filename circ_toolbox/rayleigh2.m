function [hour,r,z,n]=rayleigh2(list,symbol,h,fontsize)
%RAYLEIGH  Compute mean hour and Rayleigh's test statistics
% [hour,r,z,n]=rayleigh(list,symbol,h,fontsize)
%
% compute and plot average hour
% from a list of hours
% outputs the average hour
% and coefficients for rayleigh's test
%
% Rayleigh's test tells you wether or not a sample shows
% statistically significant directionality other than zero
% (Batschelet, p. 54). For n<18 you look for r's value on table
% H. For larger n's you use z and table 4.2.1. 
%
% Note: use symbol='NOPLOT' to get the output values without making
% any plots. 
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
  avghour_init=2.0;
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
if strcmp(lower(symbol),'noplot')==1
    noplot=1;
else
    noplot=0;
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

if noplot==0
  if avghour_init>0
    hpol{1}=hpolar(0,2.0,'w.',0,1,fontsize);
  end
    hold on;
  %set(hpol{1},'fontsize',fontsize);
  %size(list)
  %size(heights)
  hpol{2}=hpolar(list,heights,symbol);
  %plot([0 x/n],[0 y/n]);
  hpol{3}=hpolar([angle angle],[0 sqrt(x^2+y^2)/n],'-');
end
norm=sqrt(x^2+y^2)/n;
if noplot==0
  %plot(x/n,y/n,'*');
  o=hpolar(angle,sqrt(x^2+y^2)/n,symbol);
end
h=[-12:12];
rad=h/DAILY_HOURS*2*pi;
%plot(cos(rad),sin(rad),'.')
%axis square
r=norm;
z=n*r*r;
if noplot==0
    stattext=sprintf('mean = %.3g h n=%d r=%.2g z=%.4g',hour,n,r,z);
  text(-0,-2.5,stattext,'HorizontalAlignment','center');
end