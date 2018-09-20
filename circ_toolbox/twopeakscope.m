function [primary,secondary]=twopeakscope(f,wells,start,int, ...
				      filter_hours,lights)

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
noprimary=0;
nosec=0;
primary=[];
secondary=[];
primfly=[];
secfly=[];

if nargin<6
  lights=[];
end

% compute on, off
global DAILY_HOURS
if isempty(DAILY_HOURS)
  h=24;
else
  h=DAILY_HOURS;
end
x=start+(0:size(f,1)-1)*int/60;
if ~isempty(lights)
  l=lights;
  d=diff(l);
  on=x(find(d==1));
  off=x(find(d==-1));
  on=mod(on,h);
  off=mod(off,h);
  lightson=on;
  lightsoff=off;
  start=mod(start-on(1),h);
  off=mod(off-on(1),h);
  on=mod(on-on(1),h);
end

secondary=[];
for i=1:length(wells)
  g=f(:,i);
  [pp,px]=peakscope(g,1,start,int,filter_hours,[],0);
  if (length(pp)<1)
    noprimary=noprimary+1;
    nosec=nosec+1;
  elseif length(pp)<2
    nosec=nosec+1;
    primary(end+1,:)=[pp(1),px(1),i];
  else
    primary(end+1,:)=[pp(1),px(1),i];
    secondary(end+1,:)=[pp(2),px(2),i];
  end
end
fprintf('twopeakscope: n=%d (%d primary, %d secondary peaks missing)\n '...
	 ,length(wells),noprimary,nosec);

clf
%subplot(1,2,1)
hpol=hpolar(0,2.0,'w.',0,l);
hold on

delta=.01;
in_r=1.51;
out_r=1.99;
patchColor=[.6 .9 .6];
for th=off(1)/DAILY_HOURS*2*pi:delta:2*pi-delta
  th2=th+delta;
  
  v=patch([in_r*cos(th),out_r*cos(th),out_r*cos(th2),in_r*cos(th2)],...
	  [in_r*sin(th),out_r*sin(th),out_r*sin(th2),in_r*sin(th2)],...
	  patchColor);
  set(v,'linestyle','none');
end
hpol=hpolar(0,2.0,'w.',0,l);
[ph,pr,pz,pn]=rayleigh(primary(:,2),'*');
hold on
[sh,sr,sz,sn]=rayleigh(secondary(:,2),'o');
% 
ph=mod(ph,DAILY_HOURS);
sh=mod(sh,DAILY_HOURS);
s=sprintf('OFF=%.1f P=%.1f/%.1f(n=%d c=%1.f) S=%.1f/%.1f (n=%d c=%.1f)',...
	  off(1),...
	  ph,ph-off(1),size(primary,1),pr,...
	  sh,sh-off(1),size(secondary,1),sr);

xlabel(s);

%subplot(1,2,2);
%mydoubleplot(primary(:,2),primary(:,1),secondary(:,2),secondary(:,1));
%xlabel('');

%subplot(2,2,3)
%peakscope(f,wells,start,int,filter_hours);

function [rho,sigma]=mydoubleplot(means1,rs1,means2,rs2,smmarkersize, ...
			       lrgmarkersize)
%This function adapted from bivariate.m
mx=max(max(rs1),max(rs2));
lineWidth=1.0;
symbol1='*'
symbol2='o'
if nargin<4
  means2=[];
  rs2=[];
end
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

n1=length(rs1);
n2=length(rs2);
x1=rs1 .* cos(means1/DAILY_HOURS*2*pi);
y1=rs1 .* sin(means1/DAILY_HOURS*2*pi);
meanx1=mean(x1);
meany1=mean(y1);
mean1=[meanx1,meany1];

SSx1=sum((x1-meanx1).^2)
SSy1=sum((y1-meany1).^2)
C1 = sum((x1-meanx1).*(y1-meany1));

if ~isempty(means2)  
  x2=rs2 .* cos(means2/DAILY_HOURS*2*pi);
  y2=rs2 .* sin(means2/DAILY_HOURS*2*pi);
  meanx2=mean(x2);
  meany2=mean(y2);
  mean2=[meanx2,meany2];

  SSx2=sum((x2-meanx2).^2)
  SSy2=sum((y2-meany2).^2)
  C2 = sum((x2-meanx2).*(y2-meany2));
  
  SSx=SSx1+SSx2;
  SSy=SSy1+SSy2;
  r=(C1+C2)*(SSx * SSy)^(-1/2);
  t1=(meanx1-meanx2)*((1/n1+1/n2)*(SSx / (n1+n2-2)))^(-1/2);
  t2=(meany1-meany2)*((1/n1+1/n2)*(SSy / (n1+n2-2)))^(-1/2);
  
  T2=(1-r^2)^(-1)*(t1^2-2*r*t1*t2+t2^2);
  Fn=2
  Fm=(n1+n2-3);
  Fvalue=T2 / ((2*(n1+n2-2))/(n1+n2-3));
  confidence=100-fdist(Fvalue,Fn,Fm)*100;
end

cla
hold on
u1=plot(x1,y1,symbol1);
if ~isempty(means2)
  u2=plot(x2,y2,symbol2);
  o{2}=plot([0 meanx2],[0 meany2],'-');
  o{4}=plot(meanx2,meany2,symbol2);
  set(o{2},'LineWidth',lineWidth);
  set(o{4},'LineWidth',lineWidth);
end

if nargin>4
  set(u1,'MarkerSize',smmarkersize);
  set(u2,'MarkerSize',smmarkersize);
end
o{1}=plot([0 meanx1],[0 meany1],'-');
o{3}=plot(meanx1,meany1,symbol1);
set(o{1},'LineWidth',lineWidth);
set(o{3},'LineWidth',lineWidth);


if nargin>5
  set(o{3},'MarkerSize',lrgmarkersize);
  set(o{4},'MarkerSize',lrgmarkersize);
end
  
if ~isempty(means2)
  [rho1,phi1]=rect2pol(meanx1,meany1)
  [rho2,phi2]=rect2pol(meanx2,meany2)
  phi1=phi1/2/pi*DAILY_HOURS
  phi2=phi2/2/pi*DAILY_HOURS
  xlabel(sprintf('*:r=%.1f phi=%.1f o:r=%.1f phi=%.1f conf.=%4.1f%%',...
		  rho1,phi1,rho2,phi2,confidence));
end

set(gca,'xlim',[-1 1]*mx,'ylim',[-1 1]*mx);
th=0:.1:2*pi+.1;
plot(mx*cos(th),mx*sin(th),'--');
axis square

return

function [r,th]=rect2pol(x,y)
r=sqrt(x^2+y^2);
if x==0
  if y>0
    th=pi/2;
  elseif y<0
    th=-pi/2;
  else
    th=0;
  end
else
  th=atan(y/x);
end
