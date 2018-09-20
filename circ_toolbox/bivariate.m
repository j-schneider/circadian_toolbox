function [rho,sigma]=bivariate(means1,rs1,means2,rs2,smmarkersize, ...
			       lrgmarkersize,color1,color2)
%BIVARIATE Circular test for bivariate  circular samples
%
% [rho,sigma]=bivariate(theta1,rho1,thetha2,rho2)
%
% Hotelling's two sample test,
% "tests whether the centers of the two samples
% deviate significantly from each other"
% Source: Batschelet 81, p. 150

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

lineWidth=1.0;
symbol1='*'
symbol2='o'
if nargin<7
    color1=[];
end
if nargin<8
    color2=[];
end
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
  if ~isempty(color2)
      set([u2,o{2},o{4}],'color',color2);
  end  
end

if nargin>4 & smmarkersize>0
  set(u1,'MarkerSize',smmarkersize);
  set(u2,'MarkerSize',smmarkersize);
end
o{1}=plot([0 meanx1],[0 meany1],'-');
o{3}=plot(meanx1,meany1,symbol1);
set(o{1},'LineWidth',lineWidth);
set(o{3},'LineWidth',lineWidth);
if ~isempty(color1)
    set([u1,o{1},o{3}],'color',color1);
end
if nargin>5 & lrgmarkersize>0
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
set(gca,'xlim',[-1.1 1.1],'ylim',[-1.1 1.1]);
th=0:.1:2*pi+.1;
plot(cos(th),sin(th),'--');
axis square
set(gca,'xticklabel',[],'yticklabel',[]);

return
