function peakphaseplot(o1,o2,trunc,filter_hours,delpeaks1,delpeaks2);
%PEAKPHASEPLOT Compare two groups' peaks and plot peaks and delays
% 
% peakphaseplot(o1,o2,trunc,filter_hours,delpeaks1,delpeaks2)
% Uses a butterworth filter to smooth out two averaged activity datas
% loaded with dam_load and generates three plots: fly1, fly2
% and peaks differences. See Levine, et. al., Signal Analysis
% of behavioral and molecular cycles, BMC % Neuroscience 2002;3(1):1 
% Fig. 9 http://www.biomedcentral.com/1471-2202/3/1 

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
clf;
if nargin<3
  trunc=0;
end
if nargin<4
  filter_hours=12; % filter hours
end

if nargin<5
  delpeaks1=[];
end
if nargin<6
  delpeaks2=[];
end

if trunc>0
  o1.data=o1.data(1:trunc,:);
  o2.data=o2.data(1:trunc,:);
end
dir1=sprintf('%s:%s',o1.names{1},o1.names{length(o1.names)});
dir2=sprintf('%s:%s',o2.names{1},o2.names{length(o2.names)});

subplot(4,1,1);
set(gca,'ylim',[0 150]);
hold on
[rd1,x1]=dam_filter(o1.data,o1.start,o1.int,1);
d1=mean(rd1,2);
dam_flyplot(o1);

%plot(x1,d1);
title(sprintf('%s (n=%d)',dir1,size(o1.data,2)));
%xlabel('time (hrs.)')
ylabel('mean activity');
set(gca,'ylim',[0 150]);
xlim1=get(gca,'xlim');


subplot(4,1,2)
set(gca,'ylim',[0 150]);
hold on
[rd2,x2]=dam_filter(o2.data,o2.start,o2.int,1);
d2=mean(rd2,2);
%plot(x2,d2);
dam_flyplot(o2);
%xlabel('time (hrs.)');
ylabel('mean activity');
title(sprintf('%s (n=%d)',dir2,size(o2.data,2)));
set(gca,'ylim',[0 150]);
xlim=get(gca,'xlim');

if (xlim1(2)>xlim(2))
  subplot(4,1,1);
  set(gca,'xlim',xlim)
end
if (xlim1(2)<xlim(2))
  xlim(2)=xlim1(2);
  set(gca,'xlim',xlim)
end
%

subplot(4,1,3);
sp1=butt_filter(d1,60/o1.int*filter_hours);
[pp1,xx1]=findpeaks(sp1)



sp2=butt_filter(d2,2*filter_hours);
[pp2,xx2]=findpeaks(sp2);

if ischar(delpeaks1) | ischar(delpeaks2)
  [delpeaks1,delpeaks2]=manualpeaks(x1,sp1,pp1,xx1,x2,sp2,pp2,xx2)
end
if length(delpeaks1)>0
  l=ones(length(pp1),1);
  l(delpeaks1)=0;
  l=find(l>0);
  pp1=pp1(l);
  xx1=xx1(l);
end
if length(delpeaks2)>0
  l=ones(size(pp2));
  l(delpeaks2)=0;
  l=find(l>0);
  pp2=pp2(l);
  xx2=xx2(l);
end
hold on;
plot(x1(xx1),pp1,'*','MarkerSize',6);
plot(x1,sp1);
plot(x2,sp2,'--');
plot(x2(xx2),pp2,'+','MarkerSize',6);

%xlabel('time (hrs.)');
ylabel(sprintf('mean activity (lowpass/%dhrs.)',filter_hours));
legend(dir1,'',dir2,'',4)
title('peaks')
set(gca,'xlim',xlim);
set(gca,'xgrid','on','ygrid','on');

subplot(4,1,4)
plot(x2(xx2),(xx2-xx1)/2,'*-','MarkerSize',6);
set(gca,'xlim',xlim);
xlabel('time (hrs.)');
ylabel('delay (hrs.)');
title(sprintf('%s-%s peaks',dir2,dir1));
figfonts('FontSize',6);

x=get(gcf,'Position');
%et(gcf,'Position',[x(1)/1.5 x(2) x(3)-x(1)/1.5 x(4)]);
set(gcf,'PaperPosition',[1 1 6.5 9]);
%set(gcf,'PaperPositionMode','Manual');
set(gca,'xgrid','on','ygrid','on');
set(gca,'xlim',xlim);
% print tmp


function [delpeaks1,delpeaks2]=manualpeaks(x1,sp1,pp1,xx1,... ...
x2,sp2,pp2,xx2);



handle_id=155;
handle_id=figure ;
hold on
delpeaks1=[];
delpeaks2=[];
plot(x1,sp1);
plot(x2,sp2);
plot(x1(xx1),pp1,'*','markersize',9)
plot(x2(xx2),pp2,'+','markersize',9)
finish=0;
xlim=get(gca,'xlim');
ylim=get(gca,'ylim');

while(finish==0 )
  if (length(xx1)-length(delpeaks1)) ~= (length(xx2)-length(delpeaks2))
    title('WRONG');
  else
    title('MAYBE RIGHT');
  end
  uu=[];
  if ~isempty(delpeaks1)
    uu=[uu,'DEL1=',sprintf('%d ',delpeaks1)];
  end
   if ~isempty(delpeaks2)
    uu=[uu,'DEL1=',sprintf('%d ',delpeaks2)];
  end
  [x,y]=ginput(1);
  if (x<xlim(1) | x > xlim(2) | y<ylim(1) | y>ylim(2))
    finish=1;
  else
    di1=(x1(xx1)-x).^2+(pp1-y).^2;
    n1=find(di1==min(di1));
    di1=di1(n1(1));
    di2=(x2(xx2)-x).^2+(pp2-y).^2;
    n2=find(di2==min(di2));
    di2=di2(n2(1));
    if di1<di2
      delpeaks1=[delpeaks1,n1];
      for i=1:4:13
	plot(x1(xx1(n1)),pp1(n1),'o','markersize',i);
      end
    else
      delpeaks2=[delpeaks2,n2];
      for i=1:4:13
	plot(x2(xx2(n2)),pp2(n2),'o','markersize',i);
      end
    end
  end
end
delpeaks1
delpeaks2
close(handle_id)
